

DROP TABLE IF EXISTS pricing.input_for_QP CASCADE;

-- You may want to analyze the pricing.scoring table
CREATE TABLE pricing.input_for_QP AS
SELECT routeID, Route_Origin, Route_Destination, class, flight_Date, 
array_agg(price_coef order by days_to_flight) price_coef_array, array_agg(predicted_sales order by days_to_flight) predicted_sales_array
FROM pricing.scoring
GROUP BY routeID, Route_Origin, Route_Destination, class, flight_Date
DISTRIBUTED BY (routeID);

-- Query returned successfully: 4316778 rows affected, 10463 ms execution time.
