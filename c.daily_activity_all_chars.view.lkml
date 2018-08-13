view: daily_activity_clean {
view_label: "Daily Activity"
  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${TABLE}.char as string),'  ',CAST(${TABLE}.date as string)) ;;
  }


  dimension: char {
    label: "Character"
    type: string
    sql: ${TABLE}.char ;;
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}.date;;
    datatype: date
    timeframes: [date,week,month,month_name]
  }

  dimension: week_day_ordered {
    type: number
    sql: CASE WHEN daily_activity_clean.day_of_week = 'Monday' THEN 1
          WHEN daily_activity_clean.day_of_week = 'Tuesday' THEN 2
          WHEN daily_activity_clean.day_of_week = 'Wednesday' THEN 3
          WHEN daily_activity_clean.day_of_week = 'Thursday' THEN 4
          WHEN daily_activity_clean.day_of_week = 'Friday' THEN 5
          WHEN daily_activity_clean.day_of_week = 'Saturday' THEN 6
          ELSE 7 END ;;
  }


  dimension: week_day {
    type: string
    sql: ${TABLE}.day_of_week ;;
  }

  dimension: minutes {
    type: number
    sql: ${TABLE}.minutes ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.session ;;
  }

  dimension: days_active {
    type: number
    sql: ${TABLE}.days_active;;
  }

  measure: avg_minutes {
    type: average
    sql: ${minutes} ;;
    value_format: "###.00"
  }

  measure: avg_sessions {
    type: average
    sql: ${sessions} ;;
    value_format: "###.00"
  }

  measure: sum_minutes {
    type: sum
    sql: ${minutes} ;;
  }

  measure: median_minutes {
    type: median
    sql:  ${minutes};;
  }

  measure: median_sessions {
    type: median
    sql: ${sessions} ;;
  }

  measure: max_minutes {
    type: max
    sql: ${minutes} ;;
  }

  measure: max_sessions {
    type: max
    sql: ${sessions} ;;
  }

  measure: sum_sessions {
    type: sum
    sql: ${sessions} ;;
  }

}
