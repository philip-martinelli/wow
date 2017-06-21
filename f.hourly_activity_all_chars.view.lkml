view: hourly_activity_clean {
  sql_table_name: wow.hourly_activity_clean ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${TABLE}.char as string),'  ',CAST(${TABLE}.hour as string)) ;;
  }

  dimension: char {
    type: number
    sql: ${TABLE}.char ;;
  }

  dimension: timestamp_cnt {
    type: number
    sql: ${TABLE}.f0_ ;;
  }

  dimension_group: hour {
    type: time
    timeframes: [time_of_day,hour_of_day,day_of_week]
    sql: ${TABLE}.hour ;;
  }

  measure: sum {
    label: "Recorded Timestamps"
    type: sum
    sql: ${timestamp_cnt} ;;
  }
}
