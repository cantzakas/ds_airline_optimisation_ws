

DROP TABLE IF EXISTS pricing.routes CASCADE;

CREATE TABLE pricing.routes
(
ID SERIAL,
Route_Type INTEGER,
Origin VARCHAR(3),
Destination VARCHAR(3),
Hub VARCHAR(3)
)
DISTRIBUTED BY (Origin, Destination);

-- all large and medium airport pairs have 1 connection flights

INSERT INTO pricing.routes (Route_Type, Origin, Destination, Hub)
SELECT 1, t1.FAA, t2.FAA,
CASE WHEN RANDOM()<0.5 THEN t1.hub_assignment ELSE t2.hub_assignment END
FROM
pricing.airports t1 JOIN pricing.airports t2 ON (t1.FAA <> t2.FAA)
WHERE
t1.Airport_Role IN ('P-L','P-M') AND t2.Airport_Role IN ('P-L','P-M')
AND (t1.Is_Hub=0 AND t2.Is_Hub=0);

-- from all large sized airports to AA Hubs we have nonstop flights

INSERT INTO pricing.routes (Route_Type, Origin, Destination, Hub)
SELECT 2, t1.FAA, t2.FAA, NULL
FROM
pricing.airports t1 JOIN pricing.airports t2 ON (t1.FAA <> t2.FAA)
WHERE
t1.Airport_Role='P-L' AND t2.Is_Hub=1;


-- from all AA Hubs we have nonstop flights to large airports

INSERT INTO pricing.routes (Route_Type, Origin, Destination, Hub)
SELECT 3, t1.FAA, t2.FAA, NULL
FROM
pricing.airports t1 JOIN pricing.airports t2 ON (t1.FAA <> t2.FAA)
WHERE
t1.Is_Hub=1 AND t2.Airport_Role='P-L';


-- from all medium sized airports to AA Hubs we have nonstop flights

INSERT INTO pricing.routes (Route_Type, Origin, Destination, Hub)
SELECT 4, t1.FAA, t2.FAA, NULL
FROM
pricing.airports t1 JOIN pricing.airports t2 ON (t1.FAA <> t2.FAA)
WHERE
t1.Airport_Role='P-M' AND t2.Is_Hub=1;


-- from all AA Hubs we have nonstop flights to medium airports

INSERT INTO pricing.routes (Route_Type, Origin, Destination, Hub)
SELECT 5, t1.FAA, t2.FAA, NULL
FROM
pricing.airports t1 JOIN pricing.airports t2 ON (t1.FAA <> t2.FAA)
WHERE
t1.Is_Hub=1 AND t2.Airport_Role='P-M';


