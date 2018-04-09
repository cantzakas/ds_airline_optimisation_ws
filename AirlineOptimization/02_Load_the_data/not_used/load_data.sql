DROP TABLE IF EXISTS pricing.airports;
CREATE TABLE pricing.airports (
    city TEXT,
    faa VARCHAR(3),
    iata VARCHAR(3),
    ica VARCHAR(4),
    airport TEXT,
    airport_role VARCHAR(3),
    enplanements BIGINT,
    hub_assignment VARCHAR(3),
    is_hub INTEGER
)
DISTRIBUTED BY (faa);


DROP TABLE IF EXISTS pricing.flight_capacities;
CREATE TABLE pricing.flight_capacities (
  flight_number TEXT,
  class TEXT,
  capacity INTEGER
)
DISTRIBUTED BY (flight_number);


DROP TABLE IF EXISTS pricing.flight_history;
CREATE TABLE pricing.flight_history (
    routeid BIGINT,
  origin VARCHAR(3),
  destination VARCHAR(3),
  flight_1 VARCHAR(10),
  flight_2 VARCHAR(10),
  class TEXT,
  days_to_flight INTEGER,
  flight_date DATE,
  flight_month INTEGER,
  flight_weekday INTEGER,
  holiday_indicator INTEGER,
  price DOUBLE PRECISION,
  price_comp1 DOUBLE PRECISION,
  price_comp2 DOUBLE PRECISION,
  price_comp3 DOUBLE PRECISION,
  price_comp4 DOUBLE PRECISION,
  sales INTEGER
)
WITH (APPENDONLY=TRUE, COMPRESSTYPE=QUICKLZ)
DISTRIBUTED BY (routeid);


DROP TABLE IF EXISTS pricing.flight_times;
CREATE TABLE pricing.flight_times (
    flight_number TEXT,
    route_type INTEGER,
    origin VARCHAR(3),
    destination VARCHAR(3),
    daypart TEXT
)
DISTRIBUTED BY (flight_number);


DROP TABLE IF EXISTS pricing.route_flight_assignment;
CREATE TABLE pricing.route_flight_assignment (
  routeid BIGINT,
  route_origin VARCHAR(3),
  route_destination VARCHAR(3),
  first_flight_number TEXT,
  first_origin VARCHAR(3),
  first_destination VARCHAR(3),
  first_daypart TEXT,
  second_flight_number TEXT,
  second_origin VARCHAR(3),
  second_destination VARCHAR(3),
  second_daypart TEXT
)
DISTRIBUTED BY (route_origin, route_destination);


DROP TABLE IF EXISTS pricing.routes;
CREATE TABLE pricing.routes (
  id SERIAL,
  route_type INTEGER,
  origin VARCHAR(3),
  destination VARCHAR(3),
  hub VARCHAR(3)
)
DISTRIBUTED BY (origin, destination);


DROP TABLE IF EXISTS pricing.time_dim;
CREATE TABLE pricing.time_dim (
  flight_date DATE,
  flight_month INTEGER,
  flight_weekday INTEGER,
  holiday_indicator INTEGER
)
DISTRIBUTED BY (flight_date);


DROP TABLE IF EXISTS pricing.to_be_priced_flights;
CREATE TABLE pricing.to_be_priced_flights (
  routeid BIGINT,
  route_origin VARCHAR(3),
  route_destination VARCHAR(3),
  first_flight_number TEXT,
  second_flight_number TEXT,
  class TEXT,
  days_to_flight INTEGER,
  flight_date DATE,
  flight_month INTEGER,
  flight_weekday INTEGER,
  holiday_indicator INTEGER,
  price_comp1 DOUBLE PRECISION,
  price_comp2 DOUBLE PRECISION,
  price_comp3 DOUBLE PRECISION,
  price_comp4 DOUBLE PRECISION
)
WITH (APPENDONLY=TRUE, COMPRESSTYPE=QUICKLZ)
DISTRIBUTED BY (routeid);


-- this takes about 5 seconds, if the system is busy
\copy pricing.airports from '/data/labs/15_AirlineOptimization/data/airports.csv' csv header

-- this takes about 3 seconds, if the system is busy
\copy pricing.flight_capacities from '/data/labs/15_AirlineOptimization/data/flight_capacities.csv' csv header

-- this takes about 7 seconds, if the system is busy
\copy pricing.flight_times from '/data/labs/15_AirlineOptimization/data/flight_times.csv' csv header

-- this takes about 17 seconds, if the system is busy
\copy pricing.route_flight_assignment from '/data/labs/15_AirlineOptimization/data/route_flight_assignment.csv' csv header

-- this takes about 5 seconds, if the system is busy
\copy pricing.routes from '/data/labs/15_AirlineOptimization/data/routes.csv' csv header

-- this takes about 6 seconds, if the system is busy
\copy pricing.time_dim from '/data/labs/15_AirlineOptimization/data/time_dim.csv' csv header


-- The following EXTERNAL table creates a path to a file that is currently
-- stored in HDFS. The CREATE TABLE statement does not load any data
-- so there is NO materialization into HAWQ.
DROP EXTERNAL TABLE IF EXISTS pricing.flight_history_load;
CREATE EXTERNAL TABLE pricing.flight_history_load
( LIKE pricing.flight_history )
LOCATION ('pxf://10.0.29.200:50070/user/gpadmin/flight_history/*.bz2?profile=HdfsTextSimple&COMPRESSION_CODEC=org.apache.hadoop.io.compress.BZip2Codec')
FORMAT 'TEXT' (DELIMITER = ',')
LOG ERRORS INTO pricing.flight_history_load_errs SEGMENT REJECT LIMIT 1 PERCENT;

DROP EXTERNAL TABLE IF EXISTS pricing.flight_history_load;
CREATE EXTERNAL TABLE pricing.flight_history_load
( LIKE pricing.flight_history )
LOCATION ('gpfdist://etl1:18080/pricing/flight_history.csv.gz')
FORMAT 'TEXT' (DELIMITER = ',')
LOG ERRORS INTO pricing.flight_history_load_errs SEGMENT REJECT LIMIT 1 PERCENT;

-- This INSERT INTO statement is the statement that materializes data into HAWQ
-- and we get the advantage of being able to collect the statistics for the
-- table and to perform an analyze.
-- the following code loads 504875340 rows and should take about 762687.119 ms
INSERT INTO pricing.flight_history SELECT * FROM pricing.flight_history_load;


DROP EXTERNAL TABLE IF EXISTS pricing.to_be_priced_flights_load;
CREATE EXTERNAL TABLE pricing.to_be_priced_flights_load
( LIKE pricing.to_be_priced_flights )
LOCATION ('pxf://10.0.29.200:50070/user/gpadmin/to_be_priced_flights/*.bz2?profile=HdfsTextSimple&COMPRESSION_CODEC=org.apache.hadoop.io.compress.BZip2Codec')
FORMAT 'TEXT' (DELIMITER = ',')
LOG ERRORS INTO pricing.to_be_priced_flights_errs SEGMENT REJECT LIMIT 1 PERCENT;


DROP EXTERNAL TABLE IF EXISTS pricing.to_be_priced_flights_load;
CREATE EXTERNAL TABLE pricing.to_be_priced_flights_load
( LIKE pricing.to_be_priced_flights )
LOCATION ('gpfdist://etl1:18080/pricing/to_be_priced_flights.csv.gz')
FORMAT 'TEXT' (DELIMITER = ',')
LOG ERRORS INTO pricing.to_be_priced_flights_errs SEGMENT REJECT LIMIT 1 PERCENT;

-- the following code loads 86335560 rows and should take about 87701.510 ms
INSERT INTO pricing.to_be_priced_flights SELECT * FROM pricing.to_be_priced_flights_load;

