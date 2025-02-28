#########################################################{
# PURPOSE
# Finds the distinct list of target currencies in
# CrossMediaCampaignDailyAgg. Used as suggest_dimension
# for parameter_target_currency.
#
# SOURCES
#   Table CrossMediaCampaignDailyAgg
#
# REFERENCED BY
#   Explore cross_media_target_currency_list_sdt
#
#########################################################}

view: cross_media_target_currency_list_sdt {
  derived_table: {
    sql:
      SELECT
        TargetCurrency as target_currency
      FROM
        `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CrossMediaCampaignDailyAgg`
      GROUP BY
        1 ;;
  }

  dimension: target_currency {
    type: string
    primary_key: yes
    label: "Currency (Target)"
    description: "Code indicating the converted currency type used for reporting"
    sql: ${TABLE}.target_currency ;;
  }


 }
