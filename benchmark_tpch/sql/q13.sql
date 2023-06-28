-- tpch query 13
SELECT 
  c_count, 
  count(*) as custdist
FROM (
  SELECT 
    c.c_custkey, 
    count(o.o_orderkey)
  FROM 
    "customer" c
    LEFT OUTER JOIN
    "orders" o
  ON 
    c.c_custkey = o.o_custkey
    AND o.o_comment NOT LIKE '%special%requests%'
  GROUP BY c.c_custkey
) AS c_orders (c_custkey, c_count)
GROUP BY 
  c_count
ORDER BY 
  custdist DESC, 
  c_count DESC
;
