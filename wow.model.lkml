connection: "bq_test_db"

include: "*.view.lkml"         # include all views in this project
#include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: default {
  max_cache_age: "72 hours"
}

explore: daily_activity_clean {
  label: "All Characters: Daily Summary"
  join: chars_clean {
    sql_on: ${chars_clean.char} = ${daily_activity_clean.char} ;;
    relationship: many_to_one
    fields: [chars_clean._charclass,chars_clean._race,chars_clean.new_player,chars_clean.new_player_lvl_70]
  }
}

explore: chars_clean {
  label: "All Characters: Characters"
  join: daily_activity_clean {
    sql_on: ${chars_clean.char} = ${daily_activity_clean.char} ;;
    relationship: many_to_one
  }
  join: master_clean_lvl_70 {
    sql_on: ${master_clean_lvl_70.char} = ${chars_clean.char} ;;
    relationship: many_to_one
  }
}

explore: char_facts {
  label: "All Characters: Character Facts"
  join: chars_clean {
    relationship: one_to_one
    sql_on: ${chars_clean.char} = ${char_facts.char} ;;
    fields: [chars_clean._charclass,chars_clean._race,chars_clean.new_player,chars_clean.new_player_lvl_70]
  }
}


explore: hourly_activity_clean {
  label: "All Characters: Hourly Summary"
}

explore: weekly_summary_clean {
  label: "All Characters: Weekly Summary"
}

explore: weekly_summary_dist {
  label: "All Characters: Weekly Summary - Distribution"
}

explore: daily_activity_dist {
  label: "All Characters: Daily Summary - Distribution"
}

explore: daily_activity_for_lvl_70 {
  label: "Levelers Only: Daily Summary"
  join: chars_clean {
    relationship: one_to_one
    sql_on: ${chars_clean.char} = ${daily_activity_for_lvl_70.char} ;;
    fields: [chars_clean._charclass,chars_clean._race,chars_clean.new_player,chars_clean.new_player_lvl_70]
  }
  sql_always_where: ${chars_clean.char} not in (SELECT
                                                  char
                                                FROM (
                                                SELECT
                                                  char
                                                  ,SUM(minutes) as minutes
                                                  ,SUM(session) as sessions
                                                  ,SUM(days_active) as days_active
                                                FROM wow.daily_activity_for_lvl_70
                                                GROUP BY 1
                                                HAVING minutes <= 180
                                                )s) ;;
}

explore: master {
  label: "Master View - All Activity"
}

explore: zz_new_chars_by_month {
  label: "All Characters: New Characters per Month"
}

# explore: zz_chars_leveling_funnel {}

explore: k_leveling_funnel_test {
  label: "Levelers Only: Leveling Funnel"
}

# explore: j_leveling_funnel {}

explore: one_thru_70_summary {
  label: "Levelers Only: Character Facts"
  join: chars_clean {
    relationship: one_to_one
    sql_on: ${chars_clean.char} = ${one_thru_70_summary.char} ;;
    fields: [chars_clean._charclass,chars_clean._race,chars_clean.new_player,chars_clean.new_player_lvl_70]
  }
  }

explore: zones {
  label: "Levelers Only: Zones"
  join: jan_thru_dec_activity_for_lvl_70 {
    sql_on: ${jan_thru_dec_activity_for_lvl_70._zone} = ${zones.zone_name} ;;
    relationship: one_to_many
    type: left_outer
  }
  join: chars_clean {
    sql_on: ${chars_clean.char} = ${jan_thru_dec_activity_for_lvl_70.char} ;;
    relationship: many_to_one
    type: left_outer
    fields: [chars_clean.new_player,chars_clean.new_player_lvl_70,chars_clean.count,chars_clean._charclass]
  }
}


# explore: n_master_activity_levelers_only_endgame {}
# explore: o_char_facts_levelers_only_end_game {}
# explore: zz_char_facts_minus_levelers_end_game{}
explore: char_facts_endgame {
  label: "All Characters: Character Facts - Endgame"
  join: chars_clean {
    relationship: one_to_one
    sql_on: ${chars_clean.char} = ${char_facts_endgame.char} ;;
#     fields: [chars_clean._charclass,chars_clean._race]
  }
  join: master_clean_lvl_70 {
    relationship: many_to_one
    sql_on: ${master_clean_lvl_70.char} = ${char_facts_endgame.char} ;;
  }
}
  # explore: j_leveling_funnel {}
