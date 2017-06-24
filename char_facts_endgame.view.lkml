view: char_facts_endgame {
  view_label: "Character Facts"
derived_table: {
  sql:
      SELECT
        a.*
        ,'Existing' AS New_or_Existing
      FROM ${zz_char_facts_minus_levelers_end_game.SQL_TABLE_NAME} a
        UNION ALL
      SELECT
        b.*
        ,'New' AS New_or_Existing
      FROM ${o_char_facts_levelers_only_end_game.SQL_TABLE_NAME} b
  ;;
}

  dimension: char {
    label: "Character"
    type: string
    sql: ${TABLE}.char ;;
    primary_key: yes
  }

  dimension: New_or_Existing {
    label: "New or Existing?"
    type: string
    sql: ${TABLE}.New_or_Existing;;
  }

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
    sql: ${TABLE}.end_game_weeks_active ;;
  }

  dimension: avg_days_active_per_week {
    type: number
    sql: ${TABLE}.end_game_avg_days_active_per_week ;;
  }

  dimension: avg_days_active_per_week_tiered {
    type: tier
    sql: ${avg_days_active_per_week} ;;
    tiers: [0,1,2,3,4,5,6,7]
    style: interval
  }

  dimension: avg_minutes_per_active_day {
    type: number
    sql: ${total_minutes}/${total_days_active} ;;
  }

  dimension: avg_minutes_per_active_day_tiered {
    type: tier
    sql: ${total_minutes}/${total_days_active} ;;
    tiers: [0,45,90,135,180,225,270,315]
  }

  dimension: avg_minutes_per_week  {
    type: number
    sql: ${TABLE}.end_game_avg_minutes_per_week ;;
  }

  measure: avg_minutes {
    type: average
    sql:  ${total_minutes};;
  }

  measure: avg_sessions {
    type: average
    sql: ${total_sessions} ;;
  }

  measure: avg_days_active {
    type: average
    sql: ${total_days_active} ;;
  }

  measure: total_avg_days_active_per_week {
    label: "Avg of avg days active per week"
    type: average
    sql: ${avg_days_active_per_week} ;;

  }

  measure: count {
    type: count
  }

  dimension: total_minutes_tiered {
    type: tier
    sql: ${total_minutes} ;;
    tiers: [0,2500,5000,7500,10000,12500,15000]
    style: integer
  }

  dimension: total_days_active_tiered {
    type: tier
    sql: ${total_days_active} ;;
    tiers: [10,20,30,40,50,60]
    style: integer
  }





}
