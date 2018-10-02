view: char_facts {
  view_label: "Character Facts"
  derived_table: {
    sql:

    --This derived table captures different levels of aggregation (daily & weekly) for key behavior metrics per character.
    --NOTE: This particular table evaluates data for the TOTAL (new and existing character) population.

        SELECT
          a.char
          ,b.minutes
          ,b.sessions
          ,b.days_active
          ,c.weeks_active
          ,c.avg_days_active_per_week
          ,c.avg_minutes_per_week
          ,(SELECT min(b._timestamp) FROM wow.master_clean b WHERE a.char = b.char) as first_active
          ,(SELECT MAX(b._timestamp) FROM wow.master_clean b WHERE a.char = b.char) AS last_active
        FROM wow.chars_clean a
        JOIN (
              SELECT
                char
                ,SUM(minutes) as minutes
                ,SUM(session) as sessions
                ,SUM(days_active) as days_active
              FROM wow.daily_activity_clean
              GROUP BY 1
              ) b
          ON a.char = b.char
        JOIN (SELECT
                char
                ,COUNT(week) as weeks_active
                ,ROUND(AVG(days_active),1) as avg_days_active_per_week
                ,ROUND(AVG(minutes),1) as avg_minutes_per_week
              FROM wow.weekly_summary_clean
              GROUP BY 1
              ) c
          ON b.char = c.char
        ORDER BY 1
      ;;
  }

  dimension: char {
    label: "Character"
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

  dimension: total_minutes_tiered {
    type: tier
    sql: ${total_minutes} ;;
    tiers: [0,2500,5000,7500,10000,12500,15000]
    style: integer
  }

  dimension: total_sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: total_days_active {
    type: number
    sql: ${TABLE}.days_active ;;
  }

  dimension: total_days_active_tiered {
    type: tier
    sql: ${total_days_active} ;;
    tiers: [10,20,30,40,50,60]
    style: integer
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
    sql: ${TABLE}.first_active ;;
  }

  dimension: avg_minutes_per_active_day_tiered {
    type: tier
    sql: ${total_minutes}/${total_days_active} ;;
    tiers: [0,45,90,135,180,225,270,315]
  }

  dimension: last_active_day {
    type: date
    sql: ${TABLE}.last_active ;;
  }

  measure: count {
    type: count
  }

  measure: average_days_active_per_week {
    type: average
    sql: ${avg_days_active_per_week} ;;
  }

  measure: average_total_days_active {
    type: average
    sql: ${total_days_active} ;;
  }

  measure: average_total_minutes {
    type: average
    sql: ${total_minutes} ;;
  }

  measure: average_sessions {
    type: average
    sql: ${total_sessions} ;;
  }

measure: average_weeks_active {}

}
