-- tpch query 18
SELECT
  c.c_name,
  c.c_custkey,
  o.o_orderkey,
  o.o_orderdate,
  o.o_totalprice,
  sum(l.l_quantity)
FROM
  "customer" AS c,
  "orders" AS o,
  "lineitem" AS l
WHERE
  o.o_orderkey IN (
    SELECT l.l_orderkey
    FROM
      "lineitem" AS l
    GROUP BY
      l.l_orderkey
    HAVING
      sum(l.l_quantity) > 300
  )
  AND c.c_custkey = o.o_custkey
  AND o.o_orderkey = l.l_orderkey
GROUP BY
  c.c_name,
  c.c_custkey,
  o.o_orderkey,
  o.o_orderdate,
  o.o_totalprice
ORDER BY
  o.o_totalprice DESC,
  o.o_orderdate
LIMIT 100
;
