view: chars_clean {
  view_label: "Characters"
#   sql_table_name: wow.chars_clean ;;

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
    drill_fields: [master_clean_lvl_70._level, master_clean_lvl_70._guild]
  }

  dimension: _race {
    label: "Race"
    type: string
    sql: ${TABLE}._race ;;
  }

  dimension: _zone {
    label: "Zone"
    type: string
    sql: ${master_clean_lvl_70._zone} ;;
  }

  measure: count {
    label: "Count"
    type: count
  }


}
