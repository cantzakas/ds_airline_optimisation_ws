ANALYZE pricing.to_be_priced_flights;
ANALYZE pricing.model_results;

DROP TABLE IF EXISTS pricing.scoring CASCADE;
CREATE TABLE pricing.scoring AS
(
SELECT
t.RouteID, t.Route_Origin, t.Route_Destination, t.Class, t.Flight_Date, t.Days_To_Flight,
LEAST(coef[2], -0.0001) as price_coef,
madlib.array_dot (
ARRAY[
1,
0, -- Own price is zeroed out
t.Price_Comp1,
t.Price_Comp2,
t.Price_Comp3,
t.Price_Comp4,
t.Flight_Month,
CASE WHEN t.Flight_Weekday = 2 THEN 1 ELSE 0 END,
CASE WHEN t.Flight_Weekday = 3 THEN 1 ELSE 0 END,
CASE WHEN t.Flight_Weekday = 4 THEN 1 ELSE 0 END,
CASE WHEN t.Flight_Weekday = 5 THEN 1 ELSE 0 END,
CASE WHEN t.Flight_Weekday = 6 THEN 1 ELSE 0 END,
CASE WHEN t.Flight_Weekday = 7 THEN 1 ELSE 0 END,
Holiday_Indicator,
CURRENT_DATE - flight_date
]::FLOAT8[], model.coef) as predicted_sales
FROM
pricing.to_be_priced_flights t, pricing.model_results model
WHERE
  t.RouteID = model.RouteID
  AND t.Class = model.Class
  AND t.Days_To_Flight = model.Days_To_Flight AND model.coef is NOT NULL
  )
DISTRIBUTED BY(RouteID);

-- Query returned successfully: 60434892 rows affected, 9916 ms execution time

