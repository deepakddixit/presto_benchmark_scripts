SELECT "t4"."c_email_address" AS "c_email_address",
  "t4"."ca_state" AS "ca_state",
  SUM("catalog_sales"."cs_net_paid") AS "sum_cs_net_paid_ok"
FROM "catalog_sales" "catalog_sales"
  INNER JOIN (
  SELECT "catalog_sales"."cs_call_center_sk" AS "cs_call_center_sk",
    "catalog_sales"."cs_bill_customer_sk" AS "cs_bill_customer_s",
    "customer"."c_email_address" AS "c_email_address",
    "customer_address"."ca_state" AS "ca_state"
  FROM "catalog_sales" "catalog_sales"
    INNER JOIN "call_center" "call_center" ON ("catalog_sales"."cs_call_center_sk" = "call_center"."cc_call_center_sk")
    INNER JOIN "customer" "customer" ON ("catalog_sales"."cs_bill_customer_sk" = "customer"."c_customer_sk")
    LEFT JOIN "customer_address" "customer_address" ON ("customer"."c_current_addr_sk" = "customer_address"."ca_address_sk")
    INNER JOIN (
    SELECT "t0"."ca_state" AS "ca_state",
      "t2"."x_measure__0" AS "x__alias__0"
    FROM (
      SELECT "customer_address"."ca_state" AS "ca_state"
      FROM "customer_address" "customer_address"
      GROUP BY 1
    ) "t0"
      LEFT JOIN (
      SELECT "t1"."ca_state" AS "ca_state",
        SUM("catalog_sales"."cs_net_paid") AS "x_measure__0"
      FROM "catalog_sales" "catalog_sales"
        INNER JOIN (
        SELECT "catalog_sales"."cs_bill_customer_sk" AS "cs_bill_customer_s",
          "customer_address"."ca_state" AS "ca_state"
        FROM "catalog_sales" "catalog_sales"
          LEFT JOIN "customer" "customer" ON ("catalog_sales"."cs_bill_customer_sk" = "customer"."c_customer_sk")
          LEFT JOIN "customer_address" "customer_address" ON ("customer"."c_current_addr_sk" = "customer_address"."ca_address_sk")
        GROUP BY 2,
          1
      ) "t1" ON ((COALESCE("catalog_sales"."cs_bill_customer_sk", 0) = COALESCE("t1"."cs_bill_customer_s", 0)) AND (COALESCE("catalog_sales"."cs_bill_customer_sk", 1) = COALESCE("t1"."cs_bill_customer_s", 1)))
      GROUP BY 1
    ) "t2" ON ((COALESCE("t0"."ca_state", '0') = COALESCE("t2"."ca_state", '0')) AND (COALESCE("t0"."ca_state", '1') = COALESCE("t2"."ca_state", '1')))
    ORDER BY "x__alias__0" DESC,
      "ca_state" ASC
    LIMIT 5
  ) "t3" ON ("customer_address"."ca_state" = "t3"."ca_state")
  WHERE ((NOT ("customer"."c_email_address" IS NULL)) AND ("call_center"."cc_name" >= 'California') AND ("call_center"."cc_name" <= 'Pacific Northwest'))
  GROUP BY 3,
    4,
    2,
    1
) "t4" ON (("catalog_sales"."cs_call_center_sk" = "t4"."cs_call_center_sk") AND ("catalog_sales"."cs_bill_customer_sk" = "t4"."cs_bill_customer_s"))
GROUP BY 1,
  2;
