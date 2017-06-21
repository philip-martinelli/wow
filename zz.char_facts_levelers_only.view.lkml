view: one_thru_70_summary {
  derived_table: {
    sql:

    --This derived table captures different levels of aggregation (daily & weekly) for key behavior metrics per character.
    --NOTE 1: This particular table evaluates data for the subset of new characters that leveled from 1-70.
    --NOTE 2: The extra subqueries I have in the Joined view 'C' are used to clean a small number of users that had wacky data from the results.
    --NOTE 3: I only wanted to look at time spent leveling, so I removed all timestamps after the first lvl 70 timestamp.

        SELECT
          a.char
          ,b.minutes,b.sessions
          ,b.days_active
          ,c.weeks_active
          ,c.avg_days_active_per_week
          ,c.avg_minutes_per_week
          ,(SELECT min(b._timestamp) FROM wow.master_clean b WHERE a.char = b.char) as first_active
        FROM wow.chars_clean a
        JOIN (
              SELECT
                char
                ,SUM(minutes) as minutes
                ,SUM(session) as sessions
                ,SUM(days_active) as days_active
              FROM wow.daily_activity_for_lvl_70
              GROUP BY 1
              ) b
              ON a.char = b.char
        JOIN (SELECT char
                ,COUNT(week) as weeks_active
                ,ROUND(AVG(days_active),1) as avg_days_active_per_week
                ,ROUND(AVG(minutes),1) as avg_minutes_per_week
              FROM (
                    SELECT char
                      ,DATE_TRUNC(DATE(_timestamp),WEEK) as week
                      ,SUM(diff)as minutes
                      ,SUM(session) as session
                      ,SUM(day_active) as days_active
                      FROM wow.jan_thru_dec_activity_for_lvl_70
                      WHERE char not in (SELECT
                                          char
                                        FROM (
                                              SELECT
                                                char
                                                ,SUM(minutes) as minutes
                                                ,SUM(session) as sessions
                                                ,SUM(days_active) as days_active
                                              FROM wow.daily_activity_for_lvl_70
                                              GROUP BY 1
                                              HAVING minutes <= 180
                                                  )s)
                      GROUP BY 1,2
                          )s
                GROUP BY 1
              ) c
              ON b.char = c.char
        ORDER BY 1
            ;;
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
    sql: ${TABLE}.weeks_active ;;
  }

  dimension: avg_days_active_per_week {
    type: number
    sql: ${TABLE}.avg_days_active_per_week ;;
  }

  dimension: avg_minutes_per_week  {
    type: number
    sql: ${TABLE}.avg_minutes_per_week ;;
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
}
