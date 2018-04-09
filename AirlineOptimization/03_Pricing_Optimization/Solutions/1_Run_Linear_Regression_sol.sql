SET client_min_messages TO error;

DROP TABLE IF EXISTS pricing.model_results CASCADE;
DROP TABLE IF EXISTS pricing.model_results_summary CASCADE;

-- You can choose to analyze the pricing.flight_history table if you want.

SELECT madlib.linregr_train( 'pricing.flight_history',
                             'pricing.model_results',
                             'Sales',
                             'ARRAY[
							-- intercept
								1, 	
							--prices
								Price, 	
								Price_Comp1, 
								Price_Comp2, 
								Price_Comp3, 
								Price_Comp4,
							--seasonality
								Flight_Month, 									
								CASE WHEN Flight_Weekday=2 THEN 1 ELSE 0 END, 	
								CASE WHEN Flight_Weekday=3 THEN 1 ELSE 0 END, 
								CASE WHEN Flight_Weekday=4 THEN 1 ELSE 0 END, 
								CASE WHEN Flight_Weekday=5 THEN 1 ELSE 0 END, 
								CASE WHEN Flight_Weekday=6 THEN 1 ELSE 0 END, 
								CASE WHEN Flight_Weekday=7 THEN 1 ELSE 0 END, 
								Holiday_Indicator, 								
							--trend
								CURRENT_DATE-flight_date
							]',
                             'routeid, origin, destination, class, days_to_flight'
                           );
