

/*
Show one route
You may need to find a route, class, and date to insert into the WHERE
clause below
*/

select * from pricing.optimal_prices order by random() limit 5;

/*
Display optimal prices for the preceding 20 days for one of the flights
from the output of the above command. Pick a valid routeid, 
flight_date='2012-01-03' and economy class.

You will need to substitute valid values for the flight_date, routeid, and class
*/
