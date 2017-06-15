
#------------- Code used to define sessions and active days ---------------
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
