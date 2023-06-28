SELECT "t0"."cc_name" AS "cc_name",
  SUM("catalog_sales"."cs_net_paid") AS "sum_cs_net_paid_ok"
FROM "catalog_sales" "catalog_sales"
  INNER JOIN (
  SELECT "catalog_sales"."cs_call_center_sk" AS "cs_call_center_sk",
    "call_center"."cc_name" AS "cc_name"
  FROM "catalog_sales" "catalog_sales"
    INNER JOIN "call_center" "call_center" ON ("catalog_sales"."cs_call_center_sk" = "call_center"."cc_call_center_sk")
  WHERE (("call_center"."cc_name" >= 'California') AND ("call_center"."cc_name" <= 'Pacific Northwest'))
  GROUP BY 2,
    1
) "t0" ON ("catalog_sales"."cs_call_center_sk" = "t0"."cs_call_center_sk")
GROUP BY 1;
