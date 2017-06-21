view: jan_thru_dec_activity_for_lvl_70 {
  sql_table_name: wow.jan_thru_dec_activity_for_lvl_70 ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${TABLE}.char as string),'  ',CAST(${TABLE}._timestamp as string)) ;;
  }

  dimension: _guild {
    type: number
    sql: ${TABLE}._guild ;;
  }

  dimension: _level {
    type: number
    sql: ${TABLE}._level ;;
  }

  dimension_group: _timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._timestamp ;;
  }

  dimension: _zone {
    type: string
    sql: ${TABLE}._zone ;;
  }

  dimension: char {
    type: number
    sql: ${TABLE}.char ;;
  }

  dimension: day_active {
    type: number
    sql: ${TABLE}.day_active ;;
  }

  dimension: diff {
    type: number
    sql: ${TABLE}.diff ;;
  }

  dimension: session {
    type: number
    sql: ${TABLE}.session ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
