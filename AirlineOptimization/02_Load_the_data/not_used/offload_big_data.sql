

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


-- The following EXTERNAL table creates a path to a file that is currently
-- stored in HDFS. The CREATE TABLE statement does not load any data
-- so there is NO materialization into HAWQ.
DROP EXTERNAL TABLE IF EXISTS pricing.flight_history_load;
CREATE WRITABLE EXTERNAL TABLE pricing.flight_history_load
( LIKE pricing.flight_history )
LOCATION ('pxf://10.0.29.200:50070/user/gpadmin/flight_history/?profile=HdfsTextSimple&COMPRESSION_CODEC=org.apache.hadoop.io.compress.BZip2Codec')
FORMAT 'TEXT' (DELIMITER = ',')
LOG ERRORS INTO pricing.flight_history_load_errs SEGMENT REJECT LIMIT 1 PERCENT;

-- This INSERT INTO statement is the statement that materializes data into HAWQ
-- and we get the advantage of being able to collect the statistics for the
-- table and to perform an analyze.
-- the following code loads 504875340 rows and should take about 762687.119 ms
INSERT INTO pricing.flight_history SELECT * FROM pricing.flight_history_load;

DROP EXTERNAL TABLE IF EXISTS pricing.to_be_priced_flights_load;
CREATE WRITABLE EXTERNAL TABLE pricing.to_be_priced_flights_load
( LIKE pricing.to_be_priced_flights )
LOCATION ('pxf://10.0.29.200:50070/user/gpadmin/to_be_priced_flights/?profile=HdfsTextSimple&COMPRESSION_CODEC=org.apache.hadoop.io.compress.BZip2Codec')
FORMAT 'TEXT' (DELIMITER = ',')
LOG ERRORS INTO pricing.to_be_priced_flights_errs SEGMENT REJECT LIMIT 1 PERCENT;

-- the following code loads 86335560 rows and should take about 87701.510 ms
INSERT INTO pricing.to_be_priced_flights_load SELECT * FROM pricing.to_be_priced_flights;

