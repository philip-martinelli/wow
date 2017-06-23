view: chars_clean {
  view_label: "Characters"
  sql_table_name: wow.chars_clean ;;

  dimension: char {
    label: "Character"
    type: number
    sql: ${TABLE}.char ;;
    primary_key: yes
  }

  dimension: new_player {
    label: "New or Existing?"
    type: string
    sql: CASE WHEN EXISTS (SELECT * FROM wow.new_chars b WHERE b.char = ${char}) THEN 'New' else 'Existing' END;;
  }

  dimension: new_player_lvl_70{
    label: "Reached level 70?"
    type: string
    sql: CASE WHEN EXISTS (SELECT * FROM wow.new_chars_lvl_70 b WHERE b.char = ${char}) THEN 'Yes' else 'No' END;;
  }

  dimension: _charclass {
    label: "Class"
    type: string
    sql: ${TABLE}._charclass ;;
  }

  dimension: _race {
    label: "Race"
    type: string
    sql: ${TABLE}._race ;;
  }


  measure: count {
    label: "Count"
    type: count
  }


}
