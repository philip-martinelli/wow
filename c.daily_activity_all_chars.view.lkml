view: daily_activity_clean {
view_label: "Daily Activity"
    # derived_table: {
    #   sql:
    #   SELECT
    #     daily_activity_clean.char AS char,
    #     daily_activity_clean.minutes AS minutes,
    #     daily_activity_clean.day_of_week  AS daily_activity_clean_week_day,
    #     CASE WHEN daily_activity_clean.day_of_week = 'Monday' THEN 1
    #             WHEN daily_activity_clean.day_of_week = 'Tuesday' THEN 2
    #             WHEN daily_activity_clean.day_of_week = 'Wednesday' THEN 3
    #             WHEN daily_activity_clean.day_of_week = 'Thursday' THEN 4
    #             WHEN daily_activity_clean.day_of_week = 'Friday' THEN 5
    #             WHEN daily_activity_clean.day_of_week = 'Saturday' THEN 6
    #             ELSE 7 END  AS daily_activity_clean_week_day_ordered,
    #     COUNT(DISTINCT CONCAT(CAST(master_clean_lvl_70.char as string),'  ',CAST(master_clean_lvl_70._timestamp as string)) ) AS master_clean_lvl_70_count,
    #     daily_activity_clean.session AS session
    #   FROM daily_activity_clean
    #   LEFT JOIN wow.master_clean_lvl_70  AS master_clean_lvl_70 ON daily_activity_clean.char = master_clean_lvl_70.char

    #   WHERE (NOT (daily_activity_clean.session  = 0)) AND (master_clean_lvl_70._level  = 70)
    #   GROUP BY 1,2,3,4,5,6
    # ORDER BY 4
    # ;;
    # }

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

  dimension: master_clean_level_70_count {
      type: number
        sql: ${TABLE}.master_clean_level_70_count ;;
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

  measure: money_per_minute {
     type: sum
      sql: ${minutes}*0.00034223744 ;;
        value_format: "000.##"
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
