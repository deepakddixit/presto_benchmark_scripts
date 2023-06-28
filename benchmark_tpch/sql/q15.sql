-- tpch query 15
WITH revenue0 AS (
  SELECT 
    l.l_suppkey as supplier_no,
    round(sum(round(l.l_extendedprice*(1-l.l_discount),3)),3) as total_revenue
  FROM 
    "lineitem" l
  WHERE 
    l.l_shipdate >= DATE '1996-01-01'
    AND l.l_shipdate < DATE '1996-01-01' + INTERVAL '3' MONTH
  GROUP BY 
    l.l_suppkey
)
 
/* TPC_H Query 15 - Top Supplier */
SELECT 
  s.s_suppkey, 
  s.s_name, 
  s.s_address, 
  s.s_phone, 
  total_revenue
FROM 
  "supplier" s,
  revenue0
WHERE 
  s.s_suppkey = supplier_no 
  AND total_revenue = (SELECT max(total_revenue) FROM revenue0)
ORDER BY 
  s.s_suppkey
;
