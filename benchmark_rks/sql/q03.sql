SELECT SUM("catalog_sales"."cs_net_paid") AS "sum_cs_net_paid_ok",
  COUNT(1) AS "x__alias__0"
FROM "catalog_sales" "catalog_sales"
  INNER JOIN (
  SELECT "catalog_sales"."cs_call_center_sk" AS "cs_call_center_sk"
  FROM "catalog_sales" "catalog_sales"
    INNER JOIN "call_center" "call_center" ON ("catalog_sales"."cs_call_center_sk" = "call_center"."cc_call_center_sk")
  WHERE (("call_center"."cc_name" >= 'California') AND ("call_center"."cc_name" <= 'Pacific Northwest'))
  GROUP BY 1
) "t0" ON ("catalog_sales"."cs_call_center_sk" = "t0"."cs_call_center_sk")
HAVING (COUNT(1) > 0);
