/*
 * Revised version using SQL as opposed to a function
 * 16 April 2015
 * Alastair Turner, Pivotal
 */

CREATE OR REPLACE FUNCTION pricing.bounded_random (lower_bound float8, upper_bound float8)
RETURNS float8
AS
$functionBody$
  SELECT $1 + ($2 - $1) * RANDOM();
$functionBody$
LANGUAGE SQL;


DROP TABLE IF EXISTS pricing.flight_history;
CREATE TABLE pricing.flight_history (
  RouteID BIGINT, --INTEGER, (type changed to match other tables)
  Origin VARCHAR(3),
  Destination VARCHAR(3),
  Flight_1 VARCHAR(10),
  Flight_2 VARCHAR(10),
  Class TEXT,
  Days_To_Flight INTEGER,
  Flight_Date DATE,
  Flight_Month INTEGER,
  Flight_Weekday INTEGER,
  holiday_indicator INTEGER,
  Price DOUBLE PRECISION,
  Price_Comp1 DOUBLE PRECISION,
  Price_Comp2 DOUBLE PRECISION,
  Price_Comp3 DOUBLE PRECISION,
  Price_Comp4 DOUBLE PRECISION,
  Sales INTEGER
)
DISTRIBUTED BY (RouteID);

INSERT INTO pricing.flight_history
--First pass determines advance booking category and capacity for the route
WITH first_pass AS (
  SELECT *,
      CASE WHEN days_to_flight > 3 THEN TRUNC(days_to_flight/5) + 1 ELSE 3 END AS advance_category,
      CASE WHEN class = 'Economy' THEN 198 WHEN class = 'Business' THEN 30 ELSE 20 END AS capacity
    FROM pricing.flight_history_staging
),
--Now that we have some basic values to work with get the max price and build the price comparison factors,
--  holiday factor and weekday factor
second_pass AS (
  SELECT *,
      --Maximum price (this really isn't pretty :( )
      CASE
        WHEN (class = 'Economy' AND advance_category = 1) THEN 800
        WHEN (class = 'Economy' AND advance_category = 2) THEN 600
        WHEN (class = 'Economy' AND advance_category = 3) THEN 400
        WHEN (class = 'Business' AND advance_category = 1) THEN 1300
        WHEN (class = 'Business' AND advance_category = 2) THEN 1100
        WHEN (class = 'Business' AND advance_category = 3) THEN 900
        WHEN (class NOT IN('Business', 'Economy') AND advance_category = 1) THEN 2500
        WHEN (class NOT IN('Business', 'Economy') AND advance_category = 2) THEN 1600
        WHEN (class NOT IN('Business', 'Economy') AND advance_category = 3) THEN 1300
      END AS max_price,
      --Price comparison factors
      CASE WHEN price_comp1 - price < -20 THEN pricing.bounded_random(.85, .95) ELSE 1 END AS comp1_factor,
      CASE WHEN price_comp2 - price < -20 THEN pricing.bounded_random(.7, 1)  ELSE 1 END AS comp2_factor,
      CASE WHEN price_comp3 - price < 40 THEN pricing.bounded_random(.8, .95) ELSE 1 END AS comp3_factor,
      CASE WHEN price_comp4 - price < -60 THEN pricing.bounded_random(.95 , 1) ELSE 1 END AS comp4_factor,
      --Holiday factor
      CASE
        WHEN (holiday_indicator = 1 AND class = 'Economy') THEN pricing.bounded_random(1.4, 1.6)
        WHEN (holiday_indicator = 1 AND class <> 'Economy') THEN pricing.bounded_random(.7, .9)
        ELSE 1
      END AS holiday_factor,
      --Day of week factor
      CASE
        WHEN (class='Economy' AND flight_weekday IN (1, 6, 7)) THEN pricing.bounded_random(1.2, 1.4)
        WHEN (class='Economy' AND flight_weekday NOT IN (1, 6, 7)) THEN pricing.bounded_random(.8, 1)
        WHEN (class<>'Economy' AND flight_weekday IN (2, 5, 6)) THEN pricing.bounded_random(1.3, 1.5)
        WHEN (class<>'Economy' AND flight_weekday NOT IN (2, 5, 6)) THEN pricing.bounded_random(.8, .9)
        ELSE 1
      END AS weekday_factor
    FROM first_pass
),
--The only item remaining is the price factor
third_pass AS (
  SELECT *,
      8 - (price/max_price) AS price_factor
  FROM second_pass
)
SELECT
    RouteID, Origin, Destination, Flight_1, Flight_2, Class, Days_To_Flight, Flight_Date, Flight_Month, Flight_Weekday,
    holiday_indicator, Price, Price_Comp1, Price_Comp2, Price_Comp3, Price_Comp4,
    TRUNC(capacity / 20 * comp1_factor * comp2_factor * comp3_factor * comp4_factor * holiday_factor * weekday_factor * price_factor) AS sales
  FROM third_pass;

