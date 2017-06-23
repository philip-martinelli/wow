view: zz_char_facts_minus_levelers_end_game {
  derived_table: {
    sql:
    SELECT
          a.char
          ,SUM(b.minutes) as minutes
          ,SUM(b.sessions) as sessions
          ,SUM(b.days_active) as days_active
          ,c.end_game_weeks_active
          ,c.end_game_avg_days_active_per_week
          ,c.end_game_avg_minutes_per_week
        FROM wow.chars_clean a
        JOIN (
              SELECT
                char
                ,DATE(_timestamp) as date
                ,SUM(diff )as minutes
                ,SUM(session) as sessions
                ,SUM(day_active) as days_active
              FROM ${master_activity_minus_levelers_endgame.SQL_TABLE_NAME}
              GROUP BY 1,2
              ) b
              ON a.char = b.char
        JOIN (SELECT
                char
                ,COUNT(week) as end_game_weeks_active
                ,ROUND(AVG(days_active),1) as end_game_avg_days_active_per_week
                ,ROUND(AVG(minutes),1) as end_game_avg_minutes_per_week
              FROM (
                    SELECT
                      char
                      ,DATE_TRUNC(DATE(_timestamp),WEEK) as week
                      ,SUM(diff)as minutes
                      ,SUM(session) as session
                      ,SUM(day_active) as days_active
                     FROM ${master_activity_minus_levelers_endgame.SQL_TABLE_NAME}
                     GROUP BY 1,2
                    )s
                GROUP BY 1
              ) c
              ON b.char = c.char
        GROUP BY 1,5,6,7
        ORDER BY 1;;
        persist_for: "24 hours"
  }

  dimension: char {
    type: string
    sql: ${TABLE}.char ;;
    primary_key: yes
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
    type: average
    sql: ${avg_days_active_per_week} ;;

  }

  measure: count {
    type: count
  }

  }
