-- tpch query 20
SELECT 
  s.s_name, 
  s.s_address 
FROM 
  "supplier" s,
  "nation" n
WHERE 
  s.s_suppkey IN (
    SELECT 
      ps.ps_suppkey 
    FROM 
      "partsupp" ps
    WHERE 
      ps.ps_partkey IN (
        SELECT 
          p.p_partkey 
        FROM 
          "part" p
        WHERE 
          p.p_name like 'forest%'
      ) 
      AND ps.ps_availqty > (
        SELECT 
          0.5*sum(l.l_quantity) 
        FROM 
          "lineitem" l
        WHERE 
          l.l_partkey = ps.ps_partkey 
          AND l.l_suppkey = ps.ps_suppkey 
          AND l.l_shipdate >= date('1994-01-01')
          AND l.l_shipdate < date('1994-01-01') + interval '1' YEAR
      )
  )
  AND s.s_nationkey = n.n_nationkey 
  AND n.n_name = 'CANADA'
ORDER BY 
  s.s_name
;
