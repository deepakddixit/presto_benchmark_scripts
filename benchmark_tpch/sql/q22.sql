-- tpch query 22
SELECT 
  cntrycode, 
  count(*) AS numcust, 
  sum(c_acctbal) AS totacctbal
FROM 
  (
    SELECT 
      substr(c.c_phone,1,2) AS cntrycode,
      c.c_acctbal
    FROM 
      "customer" c
    WHERE 
      substr(c.c_phone,1,2) IN ('13', '31', '23', '29', '30', '18', '17')
      AND c.c_acctbal > (
        SELECT 
          avg(c.c_acctbal) 
        FROM 
          "customer" c
        WHERE 
          c.c_acctbal > 0.00 
          AND substr(c.c_phone,1,2) IN ('13', '31', '23', '29', '30', '18', '17')
      ) 
      AND NOT EXISTS (
        SELECT 
          * 
        FROM 
          "orders" o
        WHERE 
          o.o_custkey = c.c_custkey
      )
  ) AS custsale
GROUP BY 
  cntrycode
ORDER BY 
  cntrycode
;
