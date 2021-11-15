view: sql_runner_query {
  derived_table: {
    sql: SELECT
          inventory_items."PRODUCT_ID"  AS "inventory_items.product_id",
          order_items."ID"  AS "order_items.id"
      FROM "PUBLIC"."ORDER_ITEMS"
           AS order_items
      LEFT JOIN "PUBLIC"."INVENTORY_ITEMS"
           AS inventory_items ON (order_items."INVENTORY_ITEM_ID") = (inventory_items."ID")
      ORDER BY
          1
      FETCH NEXT 500 ROWS ONLY
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: inventory_items_product_id {
    type: number
    sql: ${TABLE}."inventory_items.product_id" ;;
  }

  dimension: order_items_id {
    type: number
    sql: ${TABLE}."order_items.id" ;;
  }

  set: detail {
    fields: [inventory_items_product_id, order_items_id]
  }
}
