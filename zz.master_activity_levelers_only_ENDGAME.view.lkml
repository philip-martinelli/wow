view: n_master_activity_levelers_only_endgame {
 derived_table: {
   sql:
        WITH s as (SELECT char,_level,_zone,_guild,_timestamp
                FROM (
                      SELECT
                        a.char
                        ,a._level
                        ,a._zone
                        ,a._guild
                        ,a._timestamp
                        ,b.first_lvl_70
                        ,b.last_lvl_70
                      FROM wow.master_clean_lvl_70  a
                      JOIN (
                            SELECT
                              char
                              ,(SELECT MIN(b._timestamp) FROM wow.master_clean_lvl_70 b WHERE b.char=a.char AND b._level = 70) AS first_lvl_70
                              ,(SELECT MAX(b._timestamp) FROM wow.master_clean_lvl_70 b WHERE b.char=a.char AND b._level = 70) AS last_lvl_70
                            FROM wow.master_clean_lvl_70 a
                            GROUP BY 1
                            ORDER BY 1) b
                      ON a.char = b.char
                      Order by 1,5
                      )s
                WHERE (_timestamp BETWEEN first_lvl_70 AND last_lvl_70)
                      and not (char = 4629 and _timestamp = "2008-03-03 23:38:06 UTC")
                      and (char not in (SELECT
                                char
                               FROM (
                                    SELECT
                                      char
                                      ,SUM(minutes) as minutes
                                      ,SUM(session) as sessions
                                      ,SUM(days_active) as days_active
                                    FROM wow.daily_activity_for_lvl_70
                                    GROUP BY 1
                                    HAVING minutes <= 180)))
                order by 1,5)

        SELECT
           char
          ,_level
          ,_zone
          ,_guild
          ,_timestamp
          ,diff
          ,CASE WHEN diff = 0 then 1 else 0 end as session
          ,day_active
        FROM(
            SELECT
                char
              ,_level
              ,_zone
              ,_guild
              ,_timestamp
              ,COALESCE(CASE WHEN TIMESTAMP_DIFF(_timestamp,next_timestamp,MINUTE) <= 30 THEN TIMESTAMP_DIFF(_timestamp,next_timestamp,MINUTE) ELSE NULL END,0) as diff
              ,CASE WHEN DATE(_timestamp) = DATE(next_timestamp) THEN 0 ELSE 1 END as day_active
            FROM(
                SELECT
                    char
                  ,_level
                  ,_zone
                  ,_guild
                  ,_timestamp
                  ,LAG(_timestamp) OVER (PARTITION BY char ORDER BY _timestamp) AS next_timestamp
                FROM s
                )ss
            )sss
            ORDER BY char,_timestamp
          ;;
          persist_for: "24 hours"
         }
#
#   dimension: char {
#     type: string
#     sql: ${TABLE}.char ;;
#   }
#
#   dimension: level {
#     type: number
#     sql: ${TABLE}._level ;;
#   }
#
#   dimension: zone {
#     type: string
#     sql: ${TABLE}._zone ;;
#   }
#
#   dimension: guild {
#     type: number
#     sql: ${TABLE}._guild ;;
#   }
#
#   dimension_group: _timestamp {
#     type: time
#     sql: ${TABLE}._timestamp;;
#     timeframes: [month,week,date]
#   }
#
#   measure:  sum_diff {
#     type: sum
#     sql: ${TABLE}.diff ;;
#   }
#
#   measure:  sum_session {
#     type: sum
#     sql: ${TABLE}.session ;;
#   }
#
#   measure:  sum_day_active {
#     type: sum
#     sql: ${TABLE}.day_active ;;
#   }


}
