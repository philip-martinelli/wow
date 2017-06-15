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

explore: daily_activity_clean {}

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

explore: daily_activity_for_lvl_70 {}

explore: zz_new_chars_by_month {}

explore: zz_chars_leveling_funnel {}
