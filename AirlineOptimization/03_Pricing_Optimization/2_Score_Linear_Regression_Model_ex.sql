
DROP TABLE IF EXISTS pricing.scoring CASCADE;

CREATE TABLE pricing.scoring AS
SELECT 
  t.RouteID, t.Route_Origin, t.Route_Destination, t.Class,t.Flight_Date,t.Days_To_Flight,
  LEAST(coef[2], -0.0001) as price_coef,

/*****************************************************************************
Fill in the blanks
Compute a dot product between an independent variable array generated from
the pricing.to_be_priced_flights table and the linear regression coefficents
generated in pricing.model_results.
This dot product represents your sales prediction.
In the dot product make sure to set 'Price' in the indepedent variable array
to 0, because that is what we want to optimize.
Use the madlib.array_dot function.
*****************************************************************************/

AS predicted_sales
FROM
  pricing.to_be_priced_flights t, pricing.model_results model
WHERE
      t.RouteID = model.RouteID
  AND t.Class = model.Class
  AND t.Days_To_Flight = model.Days_To_Flight
DISTRIBUTED BY(RouteID);

