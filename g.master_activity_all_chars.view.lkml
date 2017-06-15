view: master {
  sql_table_name: wow.avatars ;;

  dimension: _charclass {
    type: string
    sql: ${TABLE}._charclass ;;
  }

  dimension: _guild {
    type: number
    sql: ${TABLE}._guild ;;
  }

  dimension: _level {
    type: number
    sql: ${TABLE}._level ;;
  }

  dimension: _race {
    type: string
    sql: ${TABLE}._race ;;
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

  measure: count {
    type: count
    approximate_threshold: 100000
    drill_fields: []
  }
}
