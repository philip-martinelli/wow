view: master_activity_minus_levelers_endgame {
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
                      FROM wow.master_clean a
                      JOIN (
                            SELECT
                              char
                              ,(SELECT MIN(b._timestamp) FROM wow.master_clean b WHERE b.char=a.char AND b._level = 70) AS first_lvl_70
                              ,(SELECT MAX(b._timestamp) FROM wow.master_clean b WHERE b.char=a.char AND b._level = 70) AS last_lvl_70
                            FROM wow.master_clean a
                            GROUP BY 1
                            ORDER BY 1) b
                      ON a.char = b.char
                      Order by 1,5
                      )s
                WHERE (_timestamp >= first_lvl_70 and _timestamp <= last_lvl_70)
                      and (char not in (SELECT
                                          char
                                        FROM wow.new_chars_lvl_70))
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



}
