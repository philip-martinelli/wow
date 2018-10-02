view: master_clean{
  derived_table: {
    sql:
      SELECT
            a.char
           ,a._zone
           ,a._timestamp
           ,a._charclass
           ,b._race
           ,c.first_lvl_70
           ,c.last_lvl_70
          FROM master_clean AS a
          JOIN (SELECT a.char
                      ,a._race
                      FROM chars_clean AS a
                      ORDER BY 1) b
                      ON a.char = b.char
          JOIN (SELECT
                              char
                              ,(SELECT MIN(b._timestamp) FROM wow.master_clean b WHERE b.char=a.char AND b._level = 70) AS first_lvl_70
                              ,(SELECT MAX(b._timestamp) FROM wow.master_clean b WHERE b.char=a.char AND b._level = 70) AS last_lvl_70
                            FROM wow.master_clean a
                            GROUP BY 1
                            ORDER BY 1) c
                            ON c.char = a.char
                            ORDER BY 1
          ;;
  }
  dimension: char {
    primary_key: yes
    sql: ${TABLE}.char ;;
  }
  dimension: _zone {
    type: string
    sql: ${TABLE}._zone ;;
  }
  dimension: _timestamp {
    type: date
    sql: ${TABLE}._timestamp ;;
  }
  dimension: _race {
    type: string
    sql: ${TABLE}._race ;;
  }
  dimension: first_lvl_70 {
    type: date
    sql: ${TABLE}.first_lvl_70 ;;
  }
  dimension: last_lvl_70 {
    type: date
    sql: ${TABLE}.last_lvl_70 ;;
  }
  measure: count {
    type: count
  }
}
persist_for: "24 hour"
