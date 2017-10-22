view: weekly_summary_clean {
view_label: "Weekly Activity"
  sql_table_name: wow.weekly_summary_clean ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${TABLE}.char as string),'  ',CAST(${TABLE}.week as string)) ;;
  }

  dimension: char {
    label: "Character"
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
    type: date_week
    sql: ${TABLE}.week ;;
    convert_tz: no
  }

  measure: count {
    type: count
  }

  measure: avg_days_active {
    type: average
    sql: ${days_active} ;;
  }



}
