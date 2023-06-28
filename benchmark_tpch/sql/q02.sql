-- tpch query 2
SELECT
  s.s_acctbal,
  s.s_name,
  n.n_name,
  p.p_partkey,
  p.p_mfgr,
  s.s_address,
  s.s_phone,
  s.s_comment
FROM
  "part" p,
  "supplier" s,
  "partsupp" ps,
  "nation" n,
  "region" r
WHERE
  p.p_partkey = ps.ps_partkey
  AND s.s_suppkey = ps.ps_suppkey
  AND p.p_size = 15
  AND p.p_type like '%BRASS'
  AND s.s_nationkey = n.n_nationkey
  AND n.n_regionkey = r.r_regionkey
  AND r.r_name = 'EUROPE'
  AND ps.ps_supplycost = (
    SELECT
      min(ps.ps_supplycost)
    FROM
      "partsupp" ps,
      "supplier" s,
      "nation" n,
      "region" r
    WHERE
      p.p_partkey = ps.ps_partkey
      AND s.s_suppkey = ps.ps_suppkey
      AND s.s_nationkey = n.n_nationkey
      AND n.n_regionkey = r.r_regionkey
      AND r.r_name = 'EUROPE'
  )
ORDER BY
  s.s_acctbal desc,
  n.n_name,
  s.s_name,
  p.p_partkey
;
