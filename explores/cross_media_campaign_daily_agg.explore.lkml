#########################################################{
# PURPOSE
# Provides daily campaign totals by Source System, Campaign, and Country.
# Also includes cost amounts in source currency converted to a target currency
# as specified by user.
#
# SOURCES
# see include: statements
#
# REFERENCED BY
#   LookML dashboards:
#     cross_media_1_overview
#     cross_media_2_campaigns
#     cross_media_3_countries
#
# TARGET CURRENCY CODE
#   - This Explore shows only 1 Target Currency at a time based on the value in
#     parameter_target_currency.
#       * Users can change the parameter value on provided LookML dashboards or Explore.
#       * In the provided LookML dashboards, the default value for this parameter is based on the value in
#         the user attribute cortex_cross_media_default_currency.
#   - This filter condition is defined in SQL_ALWAYS_WHERE property
#
# NOTES
#   - Only select fields from cross_media_campaign_dates_ndt are pulled into this Explore
#       using the `fields:` property and the set cross_media_campaign_dates_ndt.report_date_fields
#
#########################################################}

include: "/views/core/cross_media_campaign_daily_agg_rfn.view"
include: "/views/core/cross_media_campaign_daily_agg__product_hierarchy_texts_rfn.view"
include: "/views/core/cross_media_dashboard_navigation_xvw.view"
include: "/views/core/cross_media_campaign_dates_ndt.view"
include: "/views/core/cross_media_campaign_ranks_ndt.view"

explore: cross_media_campaign_daily_agg {
  hidden: no
  description: "Daily campign totals by Source System, Campaign and Country. Also includes cost amounts in source currency converted to target currency as specified by user. "

  sql_always_where: ${target_currency} = {% parameter cross_media_campaign_daily_agg.parameter_target_currency %} ;;

  join: cross_media_campaign_daily_agg__product_hierarchy_texts {
    view_label: "Products"
    sql: LEFT JOIN UNNEST(${cross_media_campaign_daily_agg.product_hierarchy_texts}) as cross_media_campaign_daily_agg__product_hierarchy_texts WITH OFFSET AS product_hierarchy_texts_offset ;;
    relationship: one_to_many
  }

  join: cross_media_campaign_dates_ndt {
    view_label: "Cross Media Campaign Daily Agg"
    relationship: many_to_one
    type: inner
    sql_on: ${cross_media_campaign_daily_agg.source_system} =
    ${cross_media_campaign_dates_ndt.source_system} AND
    ${cross_media_campaign_daily_agg.campaign_id} = ${cross_media_campaign_dates_ndt.campaign_id} ;;
    fields: [cross_media_campaign_dates_ndt.report_date_fields*]
  }

  join: cross_media_campaign_ranks_ndt {
    view_label: "Cross Media Campaign Daily Agg"
    relationship: many_to_one
    type: inner
    sql_on: ${cross_media_campaign_daily_agg.source_system} =
          ${cross_media_campaign_ranks_ndt.source_system} AND
          ${cross_media_campaign_daily_agg.campaign_id} = ${cross_media_campaign_ranks_ndt.campaign_id} ;;
    fields: [cross_media_campaign_ranks_ndt.report_date_fields*]
  }

  join: cross_media_dashboard_navigation_xvw {
    relationship: one_to_one
    sql:  ;;
  }

}
