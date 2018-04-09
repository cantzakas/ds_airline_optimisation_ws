

DROP TABLE IF EXISTS pricing.input_for_QP CASCADE;

/*
Create a table pricing.input_for_QP from pricing.scoring, to be used
for optimization.
It must include, and be grouped by
       routeID, Route_Origin, Route_Destination, class, flight_Date.
Also, 
an array of 'price_coef' values ordered by days_to_flight. call it price_coef_array.
an array of 'predicted_sales' values ordered by days_to_flight. call it predicted_sales_array.
Finally, the table should be distributed by routeID.
*/
