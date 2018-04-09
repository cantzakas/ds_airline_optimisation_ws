--Run the Quadratic Programming 

-- STUDENTS - DO NOT TRY TO CREATE THIS FUNCTION.
-- It is here so you can see it, but you do not have
--  permission to create a function 
-- CREATE OR REPLACE FUNCTION r_solve_QP(a float8[], b float8[], c integer)
-- RETURNS float8[] AS 
-- $$
-- 	library(quadprog)
-- 	
--   Dmat<- matrix(0,14,14)
-- 	diag(Dmat) <- -2*a 
-- 	dvec <- b 
--   Amat <- matrix(0,14,15)
-- 	Amat[,1] <- -a
-- 	diag(Amat[,2:15]) <- a
-- 	bvec  <- c(-c+sum(b),-b)
-- 
-- 	qp<-solve.QP(Dmat,dvec,Amat,bvec=bvec)
-- 
-- return(qp$solution)
-- $$ 
-- LANGUAGE 'plr';


DROP TABLE IF EXISTS pricing.optimal_prices CASCADE;

-- you might want to analyze the pricing.input_for_qp table
CREATE TABLE pricing.optimal_prices
AS
SELECT
  routeid, Route_Origin, Route_Destination,
  "class",
  flight_date,
  CASE WHEN class='Economy' THEN pricing.r_solve_QP(price_coef_array, predicted_sales_array, 200)
  	   WHEN class='Business' THEN pricing.r_solve_QP(price_coef_array, predicted_sales_array, 15)
  	   ELSE pricing.r_solve_QP(price_coef_array, predicted_sales_array, 10) END as optimal_prices
FROM pricing.input_for_qp
DISTRIBUTED BY (routeid, "class", flight_date);

-- Query returned successfully: 4316778 rows affected, 28154 ms execution time.
