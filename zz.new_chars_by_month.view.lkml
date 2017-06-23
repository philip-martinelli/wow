view: zz_new_chars_by_month {
  view_label: "New Characters per Month"
  derived_table: {
    sql:
          --This summary table counts the number of new/existing character per month
          --NOTE 1: Characters are only counted as new ONCE.  After their first month, they are counted as existing for subsequent months.
          --NOTE 2: I added special logic for the Death Knight class since only existing characters can play as Death Knights and their first month as that class is not their first month as that character.

           SELECT
            class
            ,month
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
                  WHEN month <> '2008-01-01' AND first_month  = month AND class = 'Death Knight' then 'no'
                  WHEN month <> '2008-01-01' AND first_month  = month then 'yes'
                  ELSE 'no' END as yesno
            FROM (
            Select
             a.char
             ,c._charclass as class
             ,DATE_TRUNC(date,MONTH) as month
             ,(SELECT DATE_TRUNC(DATE(MIN(b._timestamp)),MONTH) as first_month FROM wow.master_clean b where a.char=b.char) as first_month
             FROM wow.daily_activity_clean a
             join wow.chars_clean c
             on a.char = c.char
            GROUP BY 1,2,3
            )a
            )b
          order by 1
 ;;
  }

  dimension: class {
    type: string
    sql: ${TABLE}.class ;;
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
