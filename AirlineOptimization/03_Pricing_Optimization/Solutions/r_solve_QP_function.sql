-- NOTE: This function must be created by the gpadmin user since PL/R is currently (as of March 2017)
--       an untrusted language

set search_path to pricing;


CREATE OR REPLACE FUNCTION r_solve_QP(a float8[], b float8[], c integer)
RETURNS float8[] AS 
$$
	library(quadprog)
	
  Dmat<- matrix(0,14,14)
	diag(Dmat) <- -2*a 
	dvec <- b 
  Amat <- matrix(0,14,15)
	Amat[,1] <- -a
	diag(Amat[,2:15]) <- a
	bvec  <- c(-c+sum(b),-b)

	qp<-solve.QP(Dmat,dvec,Amat,bvec=bvec)

return(qp$solution)
$$ 
LANGUAGE 'plr';

GRANT EXECUTE ON FUNCTION r_solve_QP (float8[], float8[], integer) TO pivpair;
