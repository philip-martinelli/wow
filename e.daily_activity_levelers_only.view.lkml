view: daily_activity_for_lvl_70 {
  view_label: "Daily Activity"
  sql_table_name: wow.daily_activity_for_lvl_70 ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${TABLE}.char as string),'  ',CAST(${TABLE}.date as string)) ;;
  }

  dimension: char {
    label: "Character"
    type: number
    sql: ${TABLE}.char ;;
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}.date;;
    datatype: date
    timeframes: [date,week,month,month_name]
  }

  dimension: days_ordered {
    type: string
    sql: CASE WHEN ${day_of_week} = 'Monday' THEN 1
    WHEN ${day_of_week} = 'Tuesday' THEN 2
    WHEN ${day_of_week} = 'Wednesday' THEN 3
    WHEN ${day_of_week} = 'Thursday' THEN 4
    WHEN ${day_of_week} = 'Friday' THEN 5
    WHEN ${day_of_week} = 'Saturday' THEN 6
    WHEN ${day_of_week} = 'Sunday' THEN 7
    ELSE 8 END ;;
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

  measure: avg_days_active {
    type: average
    sql: ${days_active} ;;
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
