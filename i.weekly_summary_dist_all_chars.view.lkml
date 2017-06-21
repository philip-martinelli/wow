view: weekly_summary_dist {

  derived_table: {
    sql: SELECT
          char
          ,AVG(days_active) as days_active
          ,AVG(minutes) as minutes
          ,AVG(session)as session
          FROM
            wow.weekly_summary_clean
          GROUP BY 1
          order by 1;;
  }

  dimension: char {
    type: string
    sql: ${TABLE}.char ;;
    primary_key: yes
  }

  dimension: days_active {
    type: number
    sql: ${TABLE}.days_active ;;
  }

  dimension: avg_minutes {
    type: number
    sql: ${TABLE}.minutes ;;
  }

  dimension: avg_session {
    type: number
    sql: ${TABLE}.session ;;
  }

  dimension: tiered_days_active {
    type: string
    sql: CASE WHEN ${days_active} < 2 THEN '1-2 days'
          WHEN ${days_active} < 4 THEN '3-4 days'
          WHEN ${days_active} < 6 THEN '5-6 days'
          ELSE '7 days' END
          ;;
  }

  measure: count {
    type: count
  }


}
