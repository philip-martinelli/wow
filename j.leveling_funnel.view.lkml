view: j_leveling_funnel {
  derived_table: {
    sql: SELECT
        a.char
        ,b._charclass
        ,MAX(b._level) as max_lvl
      FROM wow.new_chars a
      LEFT JOIN wow.master_clean b
      on a.char = b.char
      group by 1,2 ;;
  }

  dimension: char {
    primary_key:yes
    type: string
    sql: ${TABLE}.char;;
  }

  dimension: class {
    type: string
    sql: ${TABLE}._charclass ;;
  }

  dimension: max_level {
    type: number
    sql: ${TABLE}.max_lvl ;;
  }

#   dimension: max_level_tiered {
#     type: tier
#     sql: ${max_level} ;;
#     tiers: [10,20,30,40,50,60,70]
#
# }

  dimension: max_level_t {
    type: string
    case: {
      when: {
        label: "70"
        sql:  ${max_level}  >= 70 and ${char} in (select char from wow.new_chars_lvl_70) and ${char} not in (SELECT
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
                                                                                                                        ));;
      }
      when: {
        label: ">= 60"
        sql: ${max_level}  >= 60 ;;
      }
      when: {
        label: ">= 50"
        sql: ${max_level}  >= 50 ;;
      }
      when: {
        label: ">= 40"
        sql: ${max_level}  >= 40 ;;
      }
      when: {
        label: ">= 30"
        sql: ${max_level}  >= 30 ;;
      }
      when: {
        label: ">= 20"
        sql: ${max_level}  >= 20 ;;
      }
      when: {
        label: ">= 10"
        sql: ${max_level}  >= 10 ;;
      }
      else: ">= 1"
    }
  }


  measure: count {
    type: count
  }


}
