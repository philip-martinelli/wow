view: zz_chars_leveling_funnel {
  derived_table: {
    sql:
    WITH funnel as (SELECT
                total,ten,twenty,thirty,fourty,fifty,sixty,seventy
                FROM
                (
                SELECT
                SUM(total) as total
                ,SUM(ten) as ten
                ,SUM(twenty) as twenty
                ,SUM(thirty) thirty
                ,SUM(fourty)as fourty
                ,SUM(fifty) as fifty
                ,SUM(sixty) as sixty
                ,SUM(seventy) as seventy
                FROM(
                SELECT
                a.char
                ,CASE WHEN 1 = 1 THEN 1 ELSE 0 END as total
                ,CASE WHEN max(_level) >= 10 THEN 1 ELSE 0 END as ten
                ,CASE WHEN max(_level) >= 20 THEN 1 ELSE 0 END as twenty
                ,CASE WHEN max(_level) >= 30 THEN 1 ELSE 0 END as thirty
                ,CASE WHEN max(_level) >= 40 THEN 1 ELSE 0 END as fourty
                ,CASE WHEN max(_level) >= 50 THEN 1 ELSE 0 END as fifty
                ,CASE WHEN max(_level) >= 60 THEN 1 ELSE 0 END as sixty
                ,CASE WHEN max(_level) >= 70 and a.char in (select char from wow.new_chars_lvl_70) and a.char not in (SELECT
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
                                                                                                                                ))THEN 1 ELSE 0 END as seventy
                FROM wow.new_chars a
                LEFT JOIN wow.master_clean b
                on a.char = b.char
                group by 1
                )s
                )ss)

SELECT level,cnt
FROM(
SELECT
  'total' as level
  ,total as cnt
FROM funnel
  UNION ALL
SELECT
  'ten' as level
  ,ten as cnt
FROM funnel
  UNION ALL
SELECT
  'twenty' as level
  ,twenty as cnt
FROM funnel
  UNION ALL
SELECT
  'thirty' as level
  ,thirty as cnt
FROM funnel
  UNION ALL
SELECT
  'fourty' as level
  ,fourty as cnt
FROM funnel
  UNION ALL
SELECT
  'fifty' as level
  ,fifty as cnt
FROM funnel
  UNION ALL
SELECT
  'sixty' as level
  ,sixty as cnt
FROM funnel
  UNION ALL
SELECT
  'seventy' as level
  ,seventy as cnt
FROM funnel
order by cnt desc
)
;;
  }

  dimension: level {
    type:string
    sql:${TABLE}.level ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}.cnt ;;
  }

  measure: countt {
    type: count
  }


}
