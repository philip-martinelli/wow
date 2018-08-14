view: daily_activity_dist {
view_label: "Daily Activity"
  derived_table: {
    sql: select char, AVG(minutes) as minutes
          FROM wow.daily_activity_clean
          group by 1
 ;;
  }

  dimension: char {
    label: "Character"
    type: string
    sql: ${TABLE}.char ;;
  }

  dimension: minutes {
    type: number
    sql: ${TABLE}.minutes ;;
    value_format: "000.##"
  }

  dimension: tiered_minutes {
    type: string
    sql: CASE WHEN ${minutes} < 30 THEN '< 30 minutes'
        WHEN ${minutes}  < 60 THEN '< 60 minutes'
        WHEN ${minutes}  < 90 THEN '< 90 minutes'
        WHEN ${minutes} < 120 THEN '< 120 minutes'
        WHEN ${minutes} < 180 THEN '< 180 minutes'
        else "180+" END
        ;;
  }

  dimension: tiered_minutes_sort {
    type: number
    sql: CASE WHEN ${tiered_minutes} = '< 30 minutes' THEN 1
        WHEN ${tiered_minutes} = '< 60 minutes' THEN 2
        WHEN ${tiered_minutes} = '< 90 minutes' THEN 3
        WHEN ${tiered_minutes} = '< 120 minutes' THEN 4
        WHEN ${tiered_minutes} = '< 180 minutes' THEN 5
        else 6 END;;
  }

  measure: count {
    type: count
  }

}
