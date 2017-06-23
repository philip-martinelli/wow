view: k_leveling_funnel_test {

  derived_table: {
    sql: SELECT
          *
         FROM wow.leveling_funnel_p1
          UNION ALL
         SELECT
          *
         FROM wow.leveling_funnel_p2 ;;
  }

  dimension: class {
    type: string
    sql: ${TABLE}.class ;;
  }

dimension: class_parameter {
  type: string
  sql:
  CASE WHEN ${class} = {% parameter class_parameter %} THEN ${class} ELSE 'All Classes' END;;
}



  dimension: level {
    type: string
    sql: ${TABLE}.level;;
  }

  dimension: level_format {
    type: string
    sql: CASE WHEN level = 'total' then '>= lvl 1'
    WHEN level = 'ten' then '>= lvl 10'
    WHEN level = 'twenty' then '>= lvl 20'
    WHEN level = 'thirty' then '>= lvl 30'
    WHEN level = 'fourty' then '>= lvl 40'
    WHEN level = 'fifty' then '>= lvl 50'
    WHEN level = 'sixty' then '>= lvl 60'
    WHEN level = 'seventy' then '>= lvl 70' END;;
  }

  dimension: level_sort {
    type: number
    sql: CASE WHEN level = 'total' then 0
          WHEN level = 'ten' then 1
          WHEN level = 'twenty' then 2
          WHEN level = 'thirty' then 3
          WHEN level = 'fourty' then 4
          WHEN level = 'fifty' then 5
          WHEN level = 'sixty' then 6
          WHEN level = 'seventy' then 7 END;;
  }

#   dimension: count {
#     type: number
#     sql: ${TABLE}.cnt;;
#   }


  measure: sum {
    type: sum
    sql: ${TABLE}.cnt ;;
  }

}
