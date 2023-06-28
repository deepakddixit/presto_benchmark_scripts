SELECT SUM("catalog_sales"."cs_net_paid") AS "sum_cs_net_paid_ok",
  "t0"."tmn_d_date_ok" AS "tmn_d_date_ok"
FROM "catalog_sales" "catalog_sales"
  INNER JOIN (
  SELECT "catalog_sales"."cs_call_center_sk" AS "cs_call_center_sk",
    "catalog_sales"."cs_sold_date_sk" AS "cs_sold_date_sk",
    DATE_TRUNC('month', "date_dim"."d_date") AS "tmn_d_date_ok"
  FROM "catalog_sales" "catalog_sales"
    INNER JOIN "call_center" "call_center" ON ("catalog_sales"."cs_call_center_sk" = "call_center"."cc_call_center_sk")
    INNER JOIN "date_dim" "date_dim" ON ("catalog_sales"."cs_sold_date_sk" = "date_dim"."d_date_sk")
  WHERE (("call_center"."cc_name" >= 'California') AND ("call_center"."cc_name" <= 'Pacific Northwest') AND (NOT (YEAR("date_dim"."d_date") IS NULL)))
  GROUP BY 1,
    2,
    3
) "t0" ON (("catalog_sales"."cs_call_center_sk" = "t0"."cs_call_center_sk") AND ("catalog_sales"."cs_sold_date_sk" = "t0"."cs_sold_date_sk"))
GROUP BY 2
HAVING (NOT (SUM("catalog_sales"."cs_net_paid") IS NULL));
