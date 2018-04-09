
DROP TABLE IF EXISTS pricing.flight_history_staging CASCADE;

CREATE TABLE pricing.flight_history_staging (
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
Price_Comp4 DOUBLE PRECISION
)
DISTRIBUTED BY (RouteID);


INSERT INTO pricing.flight_history_staging
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
CASE WHEN Class='Economy' THEN
		CASE WHEN (Days_To_Flight<5) THEN 300+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 200+400*RANDOM()
	 		 ELSE  100+300*RANDOM() END
	 WHEN Class='Business' THEN
		CASE WHEN (Days_To_Flight<5) THEN 800+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 700+400*RANDOM()
	 		 ELSE  600+300*RANDOM() END
	  WHEN Class='First-Class' THEN
		CASE WHEN (Days_To_Flight<5) THEN 2000+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 1200+400*RANDOM()
	 		 ELSE  1000+300*RANDOM() END
END	 as Price,
CASE WHEN Class='Economy' THEN
		CASE WHEN (Days_To_Flight<5) THEN 350+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 250+400*RANDOM()
	 		 ELSE  100+300*RANDOM() END
	 WHEN Class='Business' THEN
		CASE WHEN (Days_To_Flight<5) THEN 800+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 700+400*RANDOM()
	 		 ELSE  600+300*RANDOM() END
	  WHEN Class='First-Class' THEN
		CASE WHEN (Days_To_Flight<5) THEN 2100+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 1500+400*RANDOM()
	 		 ELSE  1000+300*RANDOM() END
END	 as Price_Comp1,
CASE WHEN Class='Economy' THEN
		CASE WHEN (Days_To_Flight<5) THEN 300+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 200+400*RANDOM()
	 		 ELSE  100+300*RANDOM() END
	 WHEN Class='Business' THEN
		CASE WHEN (Days_To_Flight<5) THEN 700+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 600+400*RANDOM()
	 		 ELSE  500+300*RANDOM() END
	  WHEN Class='First-Class' THEN
		CASE WHEN (Days_To_Flight<5) THEN 900+500*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 800+400*RANDOM()
	 		 ELSE  700+300*RANDOM() END
END	 as Price_Comp2,
CASE WHEN Class='Economy' THEN
		CASE WHEN (Days_To_Flight<5) THEN 200+300*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 200+200*RANDOM()
	 		 ELSE  200+100*RANDOM() END
	 WHEN Class='Business' THEN
		CASE WHEN (Days_To_Flight<5) THEN 400+200*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 300+200*RANDOM()
	 		 ELSE  300+200*RANDOM() END
	  WHEN Class='First-Class' THEN
		CASE WHEN (Days_To_Flight<5) THEN 500+200*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 400+200*RANDOM()
	 		 ELSE  300+200*RANDOM() END
END	 as Price_Comp3,
CASE WHEN Class='Economy' THEN
		CASE WHEN (Days_To_Flight<5) THEN 250+200*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 200+300*RANDOM()
	 		 ELSE  100+100*RANDOM() END
	 WHEN Class='Business' THEN
		CASE WHEN (Days_To_Flight<5) THEN 350+200*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 250+200*RANDOM()
	 		 ELSE  150+200*RANDOM() END
	  WHEN Class='First-Class' THEN
		CASE WHEN (Days_To_Flight<5) THEN 350+200*RANDOM()
	 		 WHEN (Days_To_Flight<10) THEN 250+200*RANDOM()
	 		 ELSE  150+200*RANDOM() END
END	 as Price_Comp4
FROM
pricing.route_flight_assignment route, 
(SELECT generate_series(1,20:: bigint) as Days_To_Flight) days,
(SELECT * FROM pricing.time_dim WHERE flight_date<current_date) tt,
(SELECT UNNEST(ARRAY['Economy', 'Business', 'First-Class']) as class) cl;
	 