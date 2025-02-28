#--> Hid dimensions named `total_` and restated as measures in the refinement view cross_media_campaign_daily_agg_rfn
#--> Moved auto-generated view for the product_hierarchy_texts array to separate file

view: cross_media_campaign_daily_agg {
  sql_table_name: `@{GCP_PROJECT_ID}.@{REPORTING_DATASET}.CrossMediaCampaignDailyAgg` ;;

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.CampaignId ;;
  }
  dimension: campaign_name {
    type: string
    sql: ${TABLE}.CampaignName ;;
  }
  dimension: country_code {
    type: string
    sql: ${TABLE}.CountryCode ;;
  }
  dimension: country_name {
    type: string
    sql: ${TABLE}.CountryName ;;
  }
  dimension_group: last_update_ts {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.LastUpdateTS ;;
  }
  dimension: product_hierarchy_id {
    type: string
    sql: ${TABLE}.ProductHierarchyId ;;
  }
  dimension: product_hierarchy_texts {
    hidden: yes
    sql: ${TABLE}.ProductHierarchyTexts ;;
  }
  dimension: product_hierarchy_type {
    type: string
    sql: ${TABLE}.ProductHierarchyType ;;
  }
  dimension_group: report {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ReportDate ;;
  }
  dimension: source_currency {
    type: string
    sql: ${TABLE}.SourceCurrency ;;
  }
  dimension: source_system {
    type: string
    sql: ${TABLE}.SourceSystem ;;
  }
  dimension: target_currency {
    type: string
    sql: ${TABLE}.TargetCurrency ;;
  }
  # dimension: total_clicks {
  #   type: number
  #   sql: ${TABLE}.TotalClicks ;;
  # }
  # dimension: total_cost_in_source_currency {
  #   type: number
  #   sql: ${TABLE}.TotalCostInSourceCurrency ;;
  # }
  # dimension: total_cost_in_target_currency {
  #   type: number
  #   sql: ${TABLE}.TotalCostInTargetCurrency ;;
  # }
  # dimension: total_impressions {
  #   type: number
  #   sql: ${TABLE}.TotalImpressions ;;
  # }
  measure: count {
    type: count
    drill_fields: [campaign_name]
  }
}

# view: cross_media_campaign_daily_agg__product_hierarchy_texts {

#   dimension: cross_media_campaign_daily_agg__product_hierarchy_texts {
#     type: string
#     sql: cross_media_campaign_daily_agg__product_hierarchy_texts ;;
#   }
# }