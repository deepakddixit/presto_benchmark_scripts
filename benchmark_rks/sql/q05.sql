SELECT "t1"."cust_age__bin_" AS "cust_age__bin_",
  "t1"."cd_gender" AS "cd_gender",
  "t1"."i_category" AS "i_category",
  SUM("catalog_sales"."cs_net_paid") AS "sum_cs_net_paid_ok"
FROM "catalog_sales" "catalog_sales"
  INNER JOIN (
  SELECT "catalog_sales"."cs_call_center_sk" AS "cs_call_center_sk",
    "catalog_sales"."cs_bill_customer_sk" AS "cs_bill_customer_s",
    "catalog_sales"."cs_sold_date_sk" AS "cs_sold_date_sk",
    "catalog_sales"."cs_item_sk" AS "cs_item_sk",
    FLOOR(CAST(CASE WHEN YEAR("date_dim"."d_date") - YEAR(CAST(CAST(CONCAT(CONCAT(CONCAT(CONCAT(CAST("customer"."c_birth_year" AS VARCHAR),'-'),CAST("customer"."c_birth_month" AS VARCHAR)),'-'),CAST("customer"."c_birth_day" AS VARCHAR)) AS TIMESTAMP) AS DATE)) >=0 THEN FLOOR(YEAR("date_dim"."d_date") - YEAR(CAST(CAST(CONCAT(CONCAT(CONCAT(CONCAT(CAST("customer"."c_birth_year" AS VARCHAR),'-'),CAST("customer"."c_birth_month" AS VARCHAR)),'-'),CAST("customer"."c_birth_day" AS VARCHAR)) AS TIMESTAMP) AS DATE))) ELSE CEIL(YEAR("date_dim"."d_date") - YEAR(CAST(CAST(CONCAT(CONCAT(CONCAT(CONCAT(CAST("customer"."c_birth_year" AS VARCHAR),'-'),CAST("customer"."c_birth_month" AS VARCHAR)),'-'),CAST("customer"."c_birth_day" AS VARCHAR)) AS TIMESTAMP) AS DATE))) END AS BIGINT) / 10) AS "cust_age__bin_",
    "customer_demograph"."cd_gender" AS "cd_gender",
    "t0"."i_category" AS "i_category"
  FROM "catalog_sales" "catalog_sales"
    INNER JOIN "call_center" "call_center" ON ("catalog_sales"."cs_call_center_sk" = "call_center"."cc_call_center_sk")
    INNER JOIN "customer" "customer" ON ("catalog_sales"."cs_bill_customer_sk" = "customer"."c_customer_sk")
    INNER JOIN "customer_demographics" "customer_demograph" ON ("customer"."c_current_cdemo_sk" = "customer_demograph"."cd_demo_sk")
    INNER JOIN "date_dim" "date_dim" ON ("catalog_sales"."cs_sold_date_sk" = "date_dim"."d_date_sk")
    INNER JOIN (
    SELECT "item"."i_category" AS "i_category",
      CAST(CASE WHEN "item"."i_item_sk" >=0 THEN FLOOR("item"."i_item_sk") ELSE CEIL("item"."i_item_sk") END AS BIGINT) AS "xtemp0"
    FROM "item" "item"
  ) "t0" ON ("catalog_sales"."cs_item_sk" = "t0"."xtemp0")
  WHERE ((NOT (FLOOR(CAST(CASE WHEN YEAR("date_dim"."d_date") - YEAR(CAST(CAST(CONCAT(CONCAT(CONCAT(CONCAT(CAST("customer"."c_birth_year" AS VARCHAR),'-'),CAST("customer"."c_birth_month" AS VARCHAR)),'-'),CAST("customer"."c_birth_day" AS VARCHAR)) AS TIMESTAMP) AS DATE)) >=0 THEN FLOOR(YEAR("date_dim"."d_date") - YEAR(CAST(CAST(CONCAT(CONCAT(CONCAT(CONCAT(CAST("customer"."c_birth_year" AS VARCHAR),'-'),CAST("customer"."c_birth_month" AS VARCHAR)),'-'),CAST("customer"."c_birth_day" AS VARCHAR)) AS TIMESTAMP) AS DATE))) ELSE CEIL(YEAR("date_dim"."d_date") - YEAR(CAST(CAST(CONCAT(CONCAT(CONCAT(CONCAT(CAST("customer"."c_birth_year" AS VARCHAR),'-'),CAST("customer"."c_birth_month" AS VARCHAR)),'-'),CAST("customer"."c_birth_day" AS VARCHAR)) AS TIMESTAMP) AS DATE))) END AS BIGINT) / 10) IS NULL)) AND ("t0"."i_category" IN ('Books', 'Books                                             ', 'Electronics', 'Electronics                                       ', 'Jewelry', 'Jewelry                                           ')) AND (NOT ("customer_demograph"."cd_gender" IS NULL)) AND ("call_center"."cc_name" >= 'California') AND ("call_center"."cc_name" <= 'Pacific Northwest'))
  GROUP BY 5,
    6,
    2,
    1,
    4,
    3,
    7
) "t1" ON (("catalog_sales"."cs_call_center_sk" = "t1"."cs_call_center_sk") AND ("catalog_sales"."cs_bill_customer_sk" = "t1"."cs_bill_customer_s") AND ("catalog_sales"."cs_sold_date_sk" = "t1"."cs_sold_date_sk") AND ("catalog_sales"."cs_item_sk" = "t1"."cs_item_sk"))
GROUP BY 1,
  2,
  3;
