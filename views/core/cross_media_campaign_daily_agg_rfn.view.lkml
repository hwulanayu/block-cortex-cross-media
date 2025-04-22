#########################################################{
# PURPOSE
# The CrossMediaCampaignDailyAgg table and its corresponding
# Looker view cross_media_campaign_daily_agg is an aggregation
# of impressions, clicks and costs by the following dimensions:
#   Report Date
#   Source System
#   Campaign ID
#   Country Code
#   Target Currency
#
# PRODUCT MATCH
# Each campaign has gone through semantic matching with a Vertex AI text
# generation model to match textual representations of Media Campaigns
# with a single Product Hierarchy node. For example, a campaign
# named "Plain & Simple - Classic Carbonated Drinks" matches to
# the product hierarchy node ['Beverages', 'Carbonated Drink', 'Soda'].
# This array is parsed into a few different dimensions:
#    -  Array product_hierarchy_texts which is unnested as dimensions
#       product_name and product_level (starting with 0) in the view
#       cross_media_campaign_daily_agg__product_hierarchy_texts
#           product_level     product_name
#                0              Beverages
#                1              Carbonated Drink
#                2              Soda
#    - product_hierarchy_path which converts the array to a string
#           Beverages --> Carbonated Drink --> Soda
#    - product_name_featured which is last node in the hierarchy
#           Soda
#    - product_level_featured which the numerical level of the last node
#      in the hierarchy
#           2
#
# SOURCES
#   Refines base view cross_media_campaign_daily_agg
#
# REFERENCED BY
#   Explore cross_media_campaign_daily_agg
#
# NOTES
# - The Explore must be filtered to single currency to avoid double-counting impressions and clicks
#   if multiple target currencies are included in the table.
# - Includes fields which reference cross_media_campaign_daily_agg__product_hierarchy_texts
#   so this view must be included in the same Explore.
#########################################################}

include: "/views/base/cross_media_campaign_daily_agg.view"

view: +cross_media_campaign_daily_agg {

  fields_hidden_by_default: no

  dimension: key {
    hidden: yes
    primary_key: yes
    sql: CONCAT(${report_raw},${source_system},${campaign_id},${country_code},${target_currency}) ;;
  }

#########################################################
# PARAMETERS & FILTERS
#{

  parameter: parameter_target_currency {
    hidden: no
    type: string
    view_label: "@{label_view_for_filters}"
    label: "Target Currency"
    description: "Choose the desired currency for reporting"
    suggest_explore: cross_media_target_currency_list_sdt
    suggest_dimension: cross_media_target_currency_list_sdt.target_currency
    default_value: "USD"
  }

#--> this parameter impacts which product name dimension is used for filtering
#--> if "Match Bottom Level" then product_name_featured is used as it represents lowest level of hierarchy (e.g., Cosmetics returns Cosmetics)
#--> if "Match Top Level" then product_name is used to find campaigns associated with Product or any of its sublevels (e.g., Cosmetics returns Cosmetics --> Nail Polish and Cosmetics --> Skin Care)
  parameter: parameter_product_name_level {
    hidden: no
    type: unquoted
    view_label: "@{label_view_for_filters}"
    label: "Product Name: Match Bottom Level or Match Top Level"
    description: "When filtering on product name, match the bottom level of hierarchy only (e.g., search for 'Cosmetics' returns exact match 'Cosmetics') or match top level of the hierarchy (e.g., search for 'Cosmetics` returns 'Cosmetics --> Nail Polish' and 'Cosmetics --> Skin Care'). Default is 'Match Bottom Level'"
    allowed_value: {value: "levelBottom" label: "Match Bottom Level"}
    allowed_value: {value: "levelTop" label: "Match Top Level"}
    default_value: "levelBottom"
  }

#--> dimension selected_product_name_filter used as suggest_dimension
#--> if used in dashboard, link it to parameter_product_name_level to ensure correct drop-down list is shown
  filter: filter_product_name {
    hidden: no
    type: string
    view_label: "@{label_view_for_filters}"
    label: "Product Name"
    sql: {% condition %}${cross_media_campaign_daily_agg.selected_product_name_filter}{% endcondition %}  ;;
    suggest_explore: cross_media_campaign_daily_agg
    suggest_dimension: cross_media_campaign_daily_agg.selected_product_name_filter
    # suggest_persist_for: "1 seconds"
  }

  parameter: parameter_campaign_limit {
    hidden: no
    type: number
    view_label: "@{label_view_for_filters}"
    label: "Campaign limit per media platform"
    description: "Max number of campaigns per media platform to display to chart. Impacts the \"Cross Media Campaigns\" dashboard"
    default_value: "20"
  }

  parameter: parameter_chart_title {
    hidden: yes
    type: string
    view_label: "@{label_view_for_filters}"
    label: "Chart title"
    description: "Chart title to use in measure source system list with chart title"
    allowed_value: {value: "Campaign Impressions and CPM" }
    allowed_value: {value: "Campaign Clicks and CTR" }
    default_value: "Campaign Impressions and CPM"
  }

#} end parameters and filters

#########################################################
# DIMENSIONS: Campaign Attributes
#{

  dimension: source_system {
    label: "Media Platform"
    description: "Source system. Either GoogleAds, Meta, TikTok or @{label_field_value_for_dv360}"
    sql: CASE ${TABLE}.SourceSystem
            WHEN 'DV360' THEN '@{label_field_value_for_dv360}'
            WHEN 'GoogleAds' THEN '@{label_field_value_for_googleads}'
            ELSE ${TABLE}.SourceSystem
         END ;;
  }

  dimension: source_system_in_color {
    label: "Media Platform in Color"
    description: "Display media platform name with background color based on whether the value is Google Ads, Meta, TikTok, or YouTube (DV360)"
    sql: ${source_system} ;;
    html: @{html_format_background_color} ;;
  }

  dimension: campaign_id {
    description: "ID of campaign from media platform"
  }

  dimension: campaign_name {
    description: "Campaign name as represented in the media platform"
  }

  dimension: campaign_name_short {
    type: string
    label: "Campaign Name (Short)"
    description: "Campaign name truncated to 50 characters"
    sql: CONCAT(LEFT(${campaign_name},50),CASE WHEN CHAR_LENGTH(${campaign_name})>50 THEN '...' ELSE '' END) ;;
  }

  dimension: campaign_name_short_with_source {
    type: string
    label: "Campaign Name (Short Name with Platform)"
    description: "Display name of campaign as [platform]: [name up to 50 characters]"
    sql: CONCAT(${source_system},":  ",${campaign_name_short}) ;;
  }

  dimension: campaign_name_in_source_color {
    type: string
    description: "Display campaign name with background color based on media platform"
    sql: ${campaign_name} ;;
    html: @{html_format_background_color} ;;
  }

  dimension: country_code {
    description: "Country code in the ISO 3166-1 alpha-2 format (e.g., US, GB, DE)"
  }

  dimension: country_name {
    description: "Full country name"
    sql: CASE ${country_code}
          WHEN 'US' THEN 'United States'
          WHEN 'GB' THEN 'United Kingdom'
         ELSE ${TABLE}.CountryName
         END;;
  }

  dimension: funnel_level {
    type: string
    description: "Funnel levels of \"Lower\" for Google Ads and \"Upper\" for all other media types"
    sql: CASE ${source_system} WHEN '@{label_field_value_for_googleads}' THEN 'Lower' ELSE 'Upper' END;;
  }

  dimension: selected_campaign_limit {
    hidden: yes
    type: number
    description: "Captures the value in the parameter campaign limit and uses to limit number of campaigns displayed by source system in a visualization. Default value is 1,000"
    sql: {% parameter parameter_campaign_limit %} ;;
  }


#} end campaign attributes

#########################################################
# DIMENSIONS: Dates
#{

  dimension_group: report {
    description: "Reporting date of campaign metrics like clicks and impressions"
    convert_tz: no
  }

  dimension_group: last_update_ts {
    timeframes: [raw, date, time]
    label: "Last Update"
    description: "Timestamp when the record was last updated"
    convert_tz: no
  }

#} end date dimensions

#########################################################
# DIMENSIONS: Currency
#{
#--> costs that are captured in source currency are also reported in
#--> one or more target currencies as defined in Cortex configuration.

  dimension: source_currency {
    hidden: no
    label: "Currency (Source)"
    description: "Source currency code the cost is in, based on the advertiser account hosting the campaign"
  }

  dimension: target_currency {
    hidden: no
    label: "Currency (Target)"
    description: "Code indicating the converted currency type used for reporting"
  }
#} end currency dimensions

#########################################################
# DIMENSIONS: Products
#{

  dimension: product_hierarchy_type {
    view_label: "Products"
    description: "Matched hierarchy type for the campaign"
  }

  dimension: product_hierarchy_id {
    view_label: "Products"
    description: "Unique ID within the product hierarchy table to which the campaign is matched"
  }

  dimension: product_hierarchy_path {
    type: string
    view_label: "Products"
    description: "Campaign's matched product's full product hierarchy path separated by ' --> '. For example, Cosmetics --> Nail Polish"
    sql: ARRAY_TO_STRING(${product_hierarchy_texts}," --> ") ;;
  }

  dimension: product_level_featured {
    type: number
    view_label: "Products"
    description: "Hierarchy level of the campaign's matched product. Top level of hierarchy begins with 0"
    sql: ARRAY_LENGTH(${product_hierarchy_texts}) ;;
  }

  dimension: product_name_featured {
    type: string
    view_label: "Products"
    description: "Name of the campaign's matched product"
    sql: ARRAY_REVERSE(${product_hierarchy_texts})[0] ;;
  }

#--> cross-view reference
#--> references cross_media_campaign_daily_agg__product_hierarchy_texts so this view must be included in Explore
#--> used as suggest_dimension for filter_product_name. Returns either product_name_featured or product_name depending on value selected for parameter_product_name_level

  dimension: selected_product_name_filter {
    hidden: yes
    type: string
    view_label: "Products"
    description: "If value selected for parameter Product Name Level = 'Match Bottom Level' then product_name_featured is returned. If parameter value is 'Match Top Level' product_name is returned"
    sql: {% assign level = cross_media_campaign_daily_agg.parameter_product_name_level._parameter_value %}
                          {% if level == 'levelBottom' %}
                            ${cross_media_campaign_daily_agg.product_name_featured}
                          {% else %}
                            ${cross_media_campaign_daily_agg__product_hierarchy_texts.product_name}
                          {% endif %} ;;
  }


  #} end product dimensions

#########################################################
# DIMENSIONS: KPIs
#{
#--> rename of Total_ fields found in source table CrossMediaCampaignDailyAgg
#--> hidden as each is restated as a measure for reporting

  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.TotalImpressions ;;
  }

  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.TotalClicks ;;
  }

  dimension: cost_in_source_currency {
    hidden: yes
    type: number
    sql: ${TABLE}.TotalCostInSourceCurrency ;;
  }

  dimension: cost_in_target_currency {
    hidden: yes
    type: number
    sql: ${TABLE}.TotalCostInTargetCurrency ;;
  }

#} end kpi dimensions

#########################################################
# MEASURES: KPIs
#{

  measure: total_impressions {
    hidden: no
    type: sum
    description: "The total number of requests for creative content sent from a user's web browser or mobile device to an ad server within a given timeframe"
    sql: ${impressions} ;;
    value_format_name: decimal_0
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }

  measure: total_clicks {
    hidden: no
    type: sum
    description: "The number of times users clicked on a creative during a given timeframe. A click is recorded even if the user does not actually reach the landing page. For example, if a user clicks on an ad, then closes the browser before the landing page loads, a click is still recorded"
    sql: ${clicks} ;;
    value_format_name: decimal_0
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }

#-->Requires source_currency in the query to avoid summing across multiple source currencies.
#-->Instead of using the `required_fields` property, this measure returns a html message if source_currency is missing.
  measure: total_cost_in_source_currency {
    hidden: no
    type: sum
    label: "Total Spend (Source Currency)"
    description: "The amount of money spent to purchase impressions and deliver ads reflecting the advertiser account hosting the campaign. Currency (Source) is a required field to avoid summing across multiple currencies. If source currency is not included, a warning message is returned"
    sql: ${cost_in_source_currency};;
    value_format_name: decimal_2
    # required_fields: [source_currency]
    html: @{html_message_source_currency} ;;
  }

  measure: total_cost_in_target_currency {
    hidden: no
    type: sum
    label: "@{label_currency_defaults}{%- assign field_name = 'Total Spend' -%}@{label_currency_if_selected}"
    description: "The amount of money spent to purchase impressions and deliver ads converted to target currency"
    sql:  ${cost_in_target_currency};;
    value_format_name: decimal_2
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }

  measure: cumulative_total_cost_in_target_currency {
    hidden: no
    type: running_total
    direction: "column"
    label: "@{label_currency_defaults}{%- assign field_name = 'Cumulative Spend' -%}@{label_currency_if_selected}"
    description: "Running total of amount spent on ad impressions and delivery in the specified target currency"
    sql: ${total_cost_in_target_currency} ;;
    value_format_name: decimal_2
  }

  measure: cpc {
    hidden: no
    type: number
    label: "@{label_currency_defaults}{%- assign field_name = 'CPC' -%}@{label_currency_if_selected}"
    description: "Cost per Click. The cost an advertiser pays for each click converted to target currency"
    sql: SAFE_DIVIDE(${total_cost_in_target_currency}, ${total_clicks}) ;;
    value_format_name: decimal_2
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }

  measure: cpm {
    hidden: no
    type: number
    label: "@{label_currency_defaults}{%- assign field_name = 'CPM' -%}@{label_currency_if_selected}"
    description: "Cost per Mille. Estimated total cost per 1000 impressions. Cost is converted to target currency"
    sql: SAFE_DIVIDE(${total_cost_in_target_currency}, ${total_impressions}) * 1000 ;;
    value_format_name: decimal_2
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }

  measure: ctr {
    hidden: no
    type: number
    label: "CTR"
    description: "Click Through Rate. Ratio of clicks to impressions"
    sql: SAFE_DIVIDE(${total_clicks}, ${total_impressions}) ;;
    value_format_name: percent_2
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }
  #} end KPI measures

#########################################################
# MEASURES: Formatted
#{
# measures formatted for dashboard or tooltip display

  measure: total_impressions_formatted {
    type: number
    group_label: "Formatted as Large Numbers"
    label: "Total Impressions"
    description: "The total number of requests for creative content sent from a user's web browser or mobile device to an ad server within a given timeframe. Formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_impressions} ;;
    value_format_name: positive_m_or_k
    html: @{html_format_big_numbers} ;;
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }

  measure: total_clicks_formatted {
    type: number
    group_label: "Formatted as Large Numbers"
    label: "Total Clicks"
    description: "The number of times that users clicked on a creative during a given timeframe. Formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_clicks} ;;
    value_format_name: positive_m_or_k
    html: @{html_format_big_numbers} ;;
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }

  measure: total_cost_in_target_currency_formatted {
    type: number
    group_label: "Formatted as Large Numbers"
    label: "@{label_currency_defaults}{%- assign field_name = 'Total Spend' -%}@{label_currency_if_selected}"
    description: "The amount of money spent to purchase impressions and deliver ads converted to target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_cost_in_target_currency} ;;
    value_format_name: positive_m_or_k
    html: @{html_format_big_numbers} ;;
    link: {
      label: "Show Campaign Details"
      url: "@{link_build_explore_cross_media_campaign_drill}"
    }
  }

  measure: cumulative_total_cost_in_target_currency_formatted {
    type: running_total
    direction: "column"
    group_label: "Formatted as Large Numbers"
    label: "@{label_currency_defaults}{%- assign field_name = 'Cumulative Spend' -%}@{label_currency_if_selected}"
    description: "Running total of amount spent on ad impressions and delivery in the specified target currency and formatted for large values (e.g., 2.3M or 75.2K)"
    sql: ${total_cost_in_target_currency} ;;
    value_format_name: positive_m_or_k
    html: @{html_format_big_numbers} ;;
  }

  measure: ctr_formatted {
    hidden: yes
    type: number
    description: "Click Through Rate on scale between 0 and 100"
    label: "CTR"
    sql: ${ctr} * 100 ;;
    value_format_name: decimal_2
  }

#} end formatted measures

#########################################################
# MEASURES: Misc
#{

  measure: count {
    label: "Row Count"
    description: "Count of unique rows"
  }

  measure: campaign_count {
    type: count_distinct
    description: "Distinct count of campaigns"
    sql: CONCAT(${source_system},${campaign_id}) ;;
  }

  measure: report_date_count {
    type: count_distinct
    description: "Distinct count of report dates"
    sql: ${report_raw} ;;
  }

#--> converted to dimension in view cross_media_campaign_dates_ndt
  measure: min_report_date {
    hidden: yes
    type: date
    sql: MIN(${report_raw}) ;;
  }

#--> converted to dimension in view cross_media_campaign_dates_ndt
  measure: max_report_date {
    hidden: yes
    type: date
    sql: MAX(${report_raw}) ;;
  }

  measure: country_list {
    type: list
    description: "List of countries associated with a campaign"
    list_field: country_name
  }

#--> returns list of source system values in color and centered on one line
  measure: source_system_list {
    type: string
    sql: STRING_AGG(DISTINCT ${source_system}, '|' ORDER BY ${source_system}) ;;
    html:
            <div style=\"position: relative; padding-top: 10px; text-align: center; font-size: 80%; font-weight: bold; color: #4c947d; height: 40px;\">
            @{html_format_font_color}
            </div>
            ;;
  }

#--> returns two lines:
#--> 1. Title as specified in parameter_chart_title
#--> 2. list of source system values in color
  measure: source_system_list_with_chart_title {
    hidden: yes
    type: string
    sql: STRING_AGG(DISTINCT CAST((${source_system}) AS STRING), '|' ORDER BY CAST((${source_system}) AS STRING)) ;;
    html: {%- assign title_text = parameter_chart_title._parameter_value | remove: "&#39;" | remove: "&#34;" | remove: "'" | remove: '"' -%}
             <div style=\"position: relative; padding-top: 10px; text-align: center; font-size: 80%; font-weight: bold; color: #4c947d; height: 30px;\">
                {{ title_text  }}
                <br>
             </div>

             <div style=\"position: relative; padding-top: 10px; text-align: center; font-size: 40%; font-weight: bold; color: #4c947d; height: 30px;\">
                @{html_format_font_color}
             </div>
                  ;;

  }

#} end misc measures

#########################################################
# MEASURES: Helper
#{
# used to support links and drills; hidden from explore

  measure: link_generator {
    hidden: yes
    type: number
    sql: 1 ;;
    drill_fields: [link_generator]
  }

#--> hidden dimensions used for dashboard slide filter
  dimension: dummy_campaign_limit {
    hidden: yes
    type: number
    sql: 50 ;;
  }

#} end helper measures


}
