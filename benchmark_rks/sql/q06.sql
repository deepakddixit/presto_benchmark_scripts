SELECT "t0"."ca_state" AS "ca_state",
  "t0"."cc_name" AS "cc_name",
  SUM("catalog_sales"."cs_net_paid") AS "sum_cs_net_paid_ok"
FROM "catalog_sales" "catalog_sales"
  INNER JOIN (
  SELECT "catalog_sales"."cs_call_center_sk" AS "cs_call_center_sk",
    "catalog_sales"."cs_bill_customer_sk" AS "cs_bill_customer_s",
    "customer_address"."ca_state" AS "ca_state",
    "call_center"."cc_name" AS "cc_name"
  FROM "catalog_sales" "catalog_sales"
    INNER JOIN "call_center" "call_center" ON ("catalog_sales"."cs_call_center_sk" = "call_center"."cc_call_center_sk")
    LEFT JOIN "customer" "customer" ON ("catalog_sales"."cs_bill_customer_sk" = "customer"."c_customer_sk")
    LEFT JOIN "customer_address" "customer_address" ON ("customer"."c_current_addr_sk" = "customer_address"."ca_address_sk")
  WHERE (("call_center"."cc_name" >= 'California') AND ("call_center"."cc_name" <= 'Pacific Northwest') AND (CASE WHEN (("customer_address"."ca_state" IN ('AK', 'DC', 'DE', 'HI', 'MD', 'RI')) OR ("customer_address"."ca_state" IS NULL)) THEN false ELSE true END))
  GROUP BY 3,
    4,
    2,
    1
) "t0" ON (("catalog_sales"."cs_call_center_sk" = "t0"."cs_call_center_sk") AND ((COALESCE("catalog_sales"."cs_bill_customer_sk", 0) = COALESCE("t0"."cs_bill_customer_s", 0)) AND (COALESCE("catalog_sales"."cs_bill_customer_sk", 1) = COALESCE("t0"."cs_bill_customer_s", 1))))
GROUP BY 1,
  2;
