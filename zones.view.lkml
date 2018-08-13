view: zones {
  sql_table_name: wow.zones ;;

  dimension: area {
    type: string
    sql: ${TABLE}.Area ;;
  }

  dimension: continent {
    type: string
    sql: ${TABLE}.Continent ;;
  }

  dimension: controlled {
    type: string
    sql: ${TABLE}.Controlled ;;
  }

  dimension: max_bot_level {
    type: string
    sql: ${TABLE}.Max_bot_level ;;
  }

  dimension: max_rec_level {
    type: string
    sql: ${TABLE}.Max_rec_level ;;
  }

  dimension: min_bot_level {
    type: string
    sql: ${TABLE}.Min_bot_level ;;
  }

  dimension: min_rec_level {
    type: string
    sql: ${TABLE}.Min_rec_level ;;
  }

  dimension: min_req_level {
    type: number
    sql: ${TABLE}.Min_req_level ;;
  }

  dimension: size {
    type: string
    sql: ${TABLE}.Size ;;
  }

  dimension: subzone {
    type: string
    sql: ${TABLE}.Subzone ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.Type ;;
    drill_fields: [zone, subzone]
  }

  dimension: zone {
    type: string
    sql: ${TABLE}.Zone ;;
  }

  dimension: zone_name {
    type: string
    sql: ${TABLE}.Zone_Name ;;
    primary_key: yes
  }

  measure: count {
    type: count
    drill_fields: [zone_name]
  }
}
