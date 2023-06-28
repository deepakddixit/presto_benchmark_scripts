SELECT "cs_item_sk" FROM "catalog_sales" JOIN "customer"
        ON "cs_bill_customer_sk" = "c_customer_sk" WHERE "c_customer_id" = 'AAAAAAAAABAAAAAA';
