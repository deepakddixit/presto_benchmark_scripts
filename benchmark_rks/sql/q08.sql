SELECT "t3"."one" AS "one"
FROM (
  SELECT "t0"."one" AS "one",
    "t2"."x_measure__0" AS "x__alias__0"
  FROM (
    SELECT "customer_address"."ca_state" AS "one"
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
  ) "t2" ON ((COALESCE("t0"."one", '0') = COALESCE("t2"."ca_state", '0')) AND (COALESCE("t0"."one", '1') = COALESCE("t2"."ca_state", '1')))
  ORDER BY "x__alias__0" DESC,
    "one" ASC
  LIMIT 5
) "t3"
WHERE ("t3"."one" IS NULL)
LIMIT 1;
