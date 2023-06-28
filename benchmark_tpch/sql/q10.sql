-- tpch query 10
SELECT
  c.c_custkey,
  c.c_name,
  sum(l.l_extendedprice * (1 - l.l_discount)) AS revenue,
  c.c_acctbal,
  n.n_name,
  c.c_address,
  c.c_phone,
  c.c_comment
FROM
  "lineitem" AS l,
  "orders" AS o,
  "customer" AS c,
  "nation" AS n
WHERE
  c.c_custkey = o.o_custkey
  AND l.l_orderkey = o.o_orderkey
  AND o.o_orderdate >= DATE '1993-10-01'
  AND o.o_orderdate < DATE '1993-10-01' + INTERVAL '3' MONTH
  AND l.l_returnflag = 'R'
  AND c.c_nationkey = n.n_nationkey
GROUP BY
  c.c_custkey,
  c.c_name,
  c.c_acctbal,
  c.c_phone,
  n.n_name,
  c.c_address,
  c.c_comment
ORDER BY
  revenue DESC
LIMIT 20
;
