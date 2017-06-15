view: chars_clean {
  sql_table_name: wow.chars_clean ;;

  dimension: char {
    type: number
    sql: ${TABLE}.char ;;
    primary_key: yes
  }

  dimension: new_player {
    type: string
    sql: CASE WHEN EXISTS (SELECT * FROM wow.new_chars b WHERE b.char = ${char}) THEN 'New' else 'Existing' END;;
  }

  dimension: _charclass {
    type: string
    sql: ${TABLE}._charclass ;;
  }

  dimension: _race {
    type: string
    sql: ${TABLE}._race ;;
  }


  measure: count {
    label: "Count"
    type: count
  }


}
