

DROP TABLE IF EXISTS pricing.flight_times CASCADE;

CREATE TABLE pricing.flight_times AS
SELECT 'AA'||to_char(row_number() OVER (ORDER BY RANDOM(), Origin, Destination, DayPart), '00000') AS flight_number, 
r.Route_Type, Origin, Destination, DayPart
FROM
pricing.routes r,
(SELECT UNNEST(ARRAY[1,1,1,1,0]) as freq_2, 
		UNNEST(ARRAY[0,1,1,1,1]) as freq_3,
		UNNEST(ARRAY[1,1,1,0,0]) as freq_4,
		UNNEST(ARRAY[0,0,1,1,1]) as freq_5,
		UNNEST(ARRAY['Early-Morning', 'Morning', 'Afternoon', 'Evening', 'Late Evening']) AS daypart) dp 
WHERE r.route_type IN (2,3,4,5) 
AND ( (route_type=2 AND freq_2=1) OR (route_type=3 AND freq_3=1)  OR (route_type=4 AND freq_4=1) OR (route_type=5 AND freq_5=1))
DISTRIBUTED BY (flight_number);



DROP TABLE IF EXISTS pricing.flight_capacities CASCADE;

CREATE TABLE pricing.flight_capacities AS
SELECT Flight_Number, Class,
CASE WHEN r.route_type IN (2,3) and class='Economy' THEN 195
WHEN r.route_type IN (2,3) and class='Business' THEN 15
WHEN r.route_type IN (2,3) and class='First-Class' THEN 15
WHEN r.route_type IN (4,5) and class='Economy' THEN 128
WHEN r.route_type IN (4,5) and class='Business' THEN 30
WHEN r.route_type IN (4,5) and class='First-Class' THEN 10 END as Capacity
FROM
pricing.flight_times r,
(SELECT UNNEST(ARRAY['Economy', 'Business', 'First-Class']) as class) cl
DISTRIBUTED BY (flight_number);

CREATE SEQUENCE route_serial START 101;

DROP TABLE IF EXISTS pricing.route_flight_assignment CASCADE;
CREATE TABLE pricing.route_flight_assignment AS
SELECT 
nextval('route_serial') as routeID,
r.origin as Route_Origin, r.destination as Route_Destination, fl.flight_number as First_Flight_Number, fl.origin as First_Origin, fl.destination as First_Destination, fl.daypart as First_DayPart, NULL as Second_Flight_Number, NULL as Second_Origin, NULL as Second_Destination, NULL as Second_DayPart
FROM
pricing.routes r,
pricing.flight_times fl
WHERE
r.origin=fl.origin AND
r.destination=fl.destination AND
r.route_type>1
UNION ALL
SELECT 
nextval('route_serial'),
r.origin, r.destination, fl1.flight_number, fl1.origin, fl1.destination, fl1.daypart, fl2.flight_number, fl2.origin, fl2.destination, fl2.daypart
FROM
pricing.routes r,
pricing.flight_times fl1,
pricing.flight_times fl2
WHERE
r.route_type=1 AND r.origin=fl1.origin AND fl1.destination=r.hub AND
fl2.origin= r. hub AND fl2.destination = r.destination 
AND
((fl2.daypart='Morning' AND fl1.daypart='Early Morning')  OR 
 (fl2.daypart='Afternoon' AND fl1.daypart='Morning') OR
 (fl2.daypart='Evening' AND fl1.daypart='Afternoon') OR
 (fl2.daypart='Late Evening' AND fl1.daypart='Evening') )
DISTRIBUTED BY (Route_Origin, Route_Destination);

