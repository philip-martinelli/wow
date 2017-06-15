view: zz_new_chars_by_month {
  derived_table: {
    sql:
          --for lack of pivoting in BQ, here is my makeshift pivot:
          SELECT
            month
            ,yesno
          FROM (
            SELECT
            a.*
            ,CASE WHEN month = '2008-01-01' AND first_month = month AND char IN (SELECT
                                                                                char
                                                                              FROM
                                                                                  (
                                                                                  SELECT
                                                                                    char,
                                                                                    _level,
                                                                                    FORMAT_DATE('%Y-%m',DATE(MIN(_timestamp))) AS month
                                                                                  FROM
                                                                                    wow.master_clean
                                                                                  GROUP BY
                                                                                    1,
                                                                                    2
                                                                                  )a
                                                                              WHERE month = '2008-01' AND _level > 1
                                                                              group by 1) then 'no'
                  WHEN month = '2008-01-01' AND first_month = month AND char not IN (SELECT
                                                                                    char
                                                                                  FROM
                                                                                      (
                                                                                      SELECT
                                                                                        char,
                                                                                        _level,
                                                                                        FORMAT_DATE('%Y-%m',DATE(MIN(_timestamp))) AS month
                                                                                      FROM
                                                                                        wow.master_clean
                                                                                      GROUP BY
                                                                                        1,
                                                                                        2
                                                                                      )a
                                                                                  WHERE month = '2008-01' AND _level > 1
                                                                                  group by 1) then 'yes'
                  WHEN month <> '2008-01-01' AND first_month  = month then 'yes'
                  ELSE 'no' END as yesno
            FROM (
            Select
             char
             ,DATE_TRUNC(date,MONTH) as month
             ,(SELECT DATE_TRUNC(DATE(MIN(b._timestamp)),MONTH) as first_month FROM wow.master_clean b where a.char=b.char) as first_month
             FROM wow.daily_activity_clean a
            GROUP BY 1,2,3
            )a
            )b
          order by 1
 ;;
  }

  dimension: month {
    type: date_month_num
    sql: ${TABLE}.month ;;
  }

  dimension: new_chars {
    type: string
    sql: ${TABLE}.yesno ;;
  }

  measure: count {
    type: count
  }

}
