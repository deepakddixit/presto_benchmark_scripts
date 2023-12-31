-- tpch query 6
SELECT 
  sum(l.l_extendedprice*l.l_discount) AS revenue
FROM 
  "lineitem" l
WHERE 
  l.l_shipdate >= DATE '1994-01-01'
  AND l.l_shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
  AND l.l_discount BETWEEN .06 - 0.01 AND .06 + 0.01
  AND l.l_quantity < 24
;
