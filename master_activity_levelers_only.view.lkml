view: master_clean_lvl_70 {
  sql_table_name: wow.master_clean_lvl_70 ;;

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${TABLE}.char as string),'  ',CAST(${TABLE}._timestamp as string)) ;;
  }

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

  dimension: day_of_the_week {
    type: date_day_of_week
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
    drill_fields: []
  }
}
