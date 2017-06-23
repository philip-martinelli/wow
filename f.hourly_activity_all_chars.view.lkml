view: hourly_activity_clean {
  view_label: "Hourly Activity"
  sql_table_name: wow.hourly_activity_clean ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${TABLE}.char as string),'  ',CAST(${TABLE}.hour as string)) ;;
  }

  dimension: char {
    label: "Character"
    type: number
    sql: ${TABLE}.char ;;
  }

  dimension: timestamp_cnt {
    label: "Timestamps"
    type: number
    sql: ${TABLE}.f0_ ;;
  }

  dimension_group: hour {
    type: time
    timeframes: [time_of_day,hour_of_day,day_of_week]
    sql: ${TABLE}.hour ;;
  }

  measure: sum {
    label: "Sum of Timestamps"
    type: sum
    sql: ${timestamp_cnt} ;;
  }
}
