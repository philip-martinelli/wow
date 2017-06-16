view: daily_activity_for_lvl_70 {
  sql_table_name: wow.daily_activity_for_lvl_70 ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${TABLE}.char as string),'  ',CAST(${TABLE}.date as string)) ;;
  }

  dimension: char {
    type: number
    sql: ${TABLE}.char ;;
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}.date;;
    datatype: date
    timeframes: [date,week,month,month_name]
  }

  dimension: day_of_week {
    type: string
    sql: ${TABLE}.day_of_week ;;
  }

  dimension: days_active {
    type: number
    sql: ${TABLE}.days_active ;;
  }

  dimension: minutes {
    type: number
    sql: ${TABLE}.minutes ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.session ;;
  }

  measure: count {
    type: count
  }

  measure: avg_minutes {
    type: average
    sql: ${minutes} ;;
  }

  measure: avg_sessions {
    type: average
    sql: ${sessions} ;;
  }

  measure: sum {
    type: sum
    sql: ${minutes} ;;
  }

}
