--Scoring
DROP TABLE IF EXISTS pricing.to_be_priced_flights CASCADE;

CREATE TABLE pricing.to_be_priced_flights AS
SELECT
routeID,
route_origin,
route_destination,
first_flight_number,
second_flight_number,
class,
Days_To_Flight,
flight_date,
flight_month,
flight_weekday,
holiday_indicator,
-- changing to double precision (previously was integer) to match with other tables
300.0::double precision AS Price_Comp1,
400.0::double precision AS Price_Comp2,
200.0::double precision AS Price_Comp3,
250.0::double precision AS Price_Comp4
FROM
pricing.route_flight_assignment route, 
(--SELECT generate_series(1,20:: bigint) as Days_To_Flight) days, -- type changed from bigint to integer to match other tables
SELECT generate_series(1,20:: integer) as Days_To_Flight) days,
(SELECT * FROM pricing.time_dim WHERE flight_date>'2011-10-31') tt,
(SELECT UNNEST(ARRAY['Economy', 'Business', 'First-Class']) as class) cl
DISTRIBUTED BY (routeID);

