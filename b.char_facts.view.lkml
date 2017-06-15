view: char_facts {
  derived_table: {
    sql: SELECT * FROM ${one_thru_70_summary.SQL_TABLE_NAME}
          UNION ALL
         SELECT * FROM ${zz_char_facts_minus_levelers.SQL_TABLE_NAME}
      ;;
  }

  dimension: char {
    type: string
    sql: ${TABLE}.char ;;
    primary_key: yes
  }

#   dimension: race {
#     type: string
#     sql: ${TABLE}._race ;;
#   }
#
#   dimension: class {
#     type: string
#     sql: ${TABLE}._charclass ;;
#   }

  dimension: total_minutes {
    type: number
    sql: ${TABLE}.minutes ;;
  }

  dimension: total_sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: total_days_active {
    type: number
    sql: ${TABLE}.days_active ;;
  }

  dimension: total_weeks_active {
    type: number
    sql: ${TABLE}.weeks_active ;;
  }

  dimension: avg_days_active_per_week {
    type: number
    sql: ${TABLE}.avg_days_active_per_week ;;
  }

  dimension: avg_minutes_per_week {
    type: number
    sql: ${TABLE}.avg_minutes_per_week ;;
  }

  dimension: first_active_day {
    type: date
    sql: DATE(${TABLE}.first_active) ;;
  }

  measure: count {
    type: count
  }



}
