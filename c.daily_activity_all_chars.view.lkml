view: daily_activity_clean {

  dimension: char {
    type: string
    sql: ${TABLE}.char ;;
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}.date;;
#     datatype: date
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
  }

  measure: avg_sessions {
    type: average
    sql: ${sessions} ;;
  }

  measure: sum_minutes {
    type: sum
    sql: ${minutes} ;;
  }

}
