-- tpch query 17
SELECT 
  sum(l.l_extendedprice)/7.0 as avg_yearly 
FROM 
  "lineitem" l,
  "part" p
WHERE 
  p.p_partkey = l.l_partkey 
  AND p.p_brand = 'Brand#23' 
  AND p.p_container = 'MED BOX'
  AND l.l_quantity < (
    SELECT 
      0.2*avg(l.l_quantity) 
    FROM 
      "lineitem" l
    WHERE 
    l.l_partkey = p.p_partkey
  )
;
