connection: "bq_test_db"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     sql_on: ${orders.id} = ${order_items.order_id}
#   }
#
#   join: users {
#     sql_on: ${users.id} = ${orders.user_id}
#   }
# }

explore: daily_activity_clean {
  join: chars_clean {
    sql_on: ${chars_clean.char} = ${daily_activity_clean.char} ;;
    relationship: many_to_one
  }
}

explore: chars_clean {
#   join: one_thru_70_summary {
#     relationship: one_to_one
#     sql_on: ${chars_clean.char}=${one_thru_70_summary.char} ;;
#     sql_where: ${one_thru_70_summary.char} is not null ;;
#   }
#   fields: [ALL_FIELDS*]
}

explore: char_facts {
  join: chars_clean {
    relationship: one_to_one
    sql_on: ${chars_clean.char} = ${char_facts.char} ;;
  }
}

# explore: locations {}
#
# explore: zones {}

explore: hourly_activity_clean {}

explore: weekly_summary_clean {}

explore: weekly_summary_dist {}

explore: daily_activity_dist {}

explore: daily_activity_for_lvl_70 {
  join: chars_clean {
    relationship: one_to_one
    sql_on: ${chars_clean.char} = ${daily_activity_for_lvl_70.char} ;;
  }
}

explore: master {}

explore: zz_new_chars_by_month {}

explore: zz_chars_leveling_funnel {}

explore: k_leveling_funnel_test {}

explore: j_leveling_funnel {}

explore: one_thru_70_summary {
  join: chars_clean {
    relationship: one_to_one
    sql_on: ${chars_clean.char} = ${one_thru_70_summary.char} ;;
  }
  }

explore: zones {
  label: "Zones-Levelers"
  join: jan_thru_dec_activity_for_lvl_70 {
    sql_on: ${jan_thru_dec_activity_for_lvl_70._zone} = ${zones.zone_name} ;;
    relationship: one_to_many
    type: left_outer
  }
  join: chars_clean {
    sql_on: ${chars_clean.char} = ${jan_thru_dec_activity_for_lvl_70.char} ;;
    relationship: many_to_one
    type: left_outer
    fields: [chars_clean.new_player,chars_clean.new_player_lvl_70,chars_clean.count]
  }
}
