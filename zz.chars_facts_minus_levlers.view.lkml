view: zz_char_facts_minus_levelers {
  derived_table: {
    sql:

    --This derived table captures different levels of aggregation (daily & weekly) for key behavior metrics per character.
    --NOTE: This particular table evaluates data for the total population EXCEPT the subset of new characters that leveled from 1-70.

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
              WHERE char not in (SELECT
                                  char
                                FROM wow.new_chars_lvl_70)
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

}
