view: weekly_summary_clean {
  sql_table_name: wow.weekly_summary_clean ;;

  dimension: char {
    type: number
    sql: ${TABLE}.char ;;
  }

  dimension: days_active {
    type: number
    sql: ${TABLE}.days_active ;;
  }

  dimension: minutes {
    type: number
    sql: ${TABLE}.minutes ;;
  }

  dimension: session {
    type: number
    sql: ${TABLE}.session ;;
  }

  dimension: week {
    type: date
    sql: ${TABLE}.week ;;
  }

  measure: count {
    type: count
  }


  measure: avg_days_active {
    type: average
    sql: ${days_active} ;;
  }



}
