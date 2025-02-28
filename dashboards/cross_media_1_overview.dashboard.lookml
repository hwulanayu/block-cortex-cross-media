#########################################################{
# Cross Media Performance Overview dashboard provides an overview of
# media performance in total and by platform
#
# Extends template_cross_media and modifies:
#   dashboard_navigation to set parameter_navigation_focus_page: '1'
#
# Visualization Elements:
#   impressions - single-value viz
#   cpm - single-value viz
#   ctr - single-value viz
#   clicks - single-value viz
#   cpc - single-value viz
#   spend - single-value viz
#   monthly_campaign_performance - stacked column
#   monthly_campaign_performance_by_platform - column with cpc as line
#   cpm_by_month_and_platform - column
#   cumulative_spend - steamgraph
#
# To improve performance, KPIs in single-value vizzes are all run
# together in a single query (rather than a query per KPI)
#
#########################################################}


- dashboard: cross_media_1_overview
  title: Cross Media Performance Overview
  description: "Overview of media performance in total and by platform"

  extends: template_cross_media

  elements:

  - name: dashboard_navigation
    filters:
      cross_media_dashboard_navigation_xvw.parameter_navigation_focus_page: '1'
###############################################################################################
  - name: header_overall_performance
    type: text
    body_text: "<div style=\"position: relative; text-align: center;
                      min-height: 20px; padding: 2px;
                      border-bottom: 2px #C0C0C0 inset; width: 100%;\">
                <span style=\"background-color: #FFFFFF; color: #808080;
                      font-size: 120%; font-weight: bold; height: 20px; margin-bottom: 2px;\">
                What is the overall campaign performance?
                </span>
                </div>"
    row: 2
    col: 0
    width: 24
    height: 2
###############################################################################################
  - name: impressions
    title: 'Impressions'
    explore: cross_media_campaign_daily_agg
    type: single_value
    fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
            cross_media_campaign_daily_agg.cpm,
            cross_media_campaign_daily_agg.cpc,
            cross_media_campaign_daily_agg.total_clicks_formatted,
            cross_media_campaign_daily_agg.ctr,
            cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    hidden_fields: [cross_media_campaign_daily_agg.cpm,
                    cross_media_campaign_daily_agg.cpc,
                    cross_media_campaign_daily_agg.total_clicks_formatted,
                    cross_media_campaign_daily_agg.ctr,
                    cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    note_state: collapsed
    note_display: hover
    note_text: The number of times your ad was viewed for a specific duration depending
      on ad format.
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 3
    col: 0
    width: 4
    height: 2
###############################################################################################
  - name: cpm
    title: CPM
    explore: cross_media_campaign_daily_agg
    type: single_value
    fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
            cross_media_campaign_daily_agg.cpm,
            cross_media_campaign_daily_agg.cpc,
            cross_media_campaign_daily_agg.total_clicks_formatted,
            cross_media_campaign_daily_agg.ctr,
            cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    hidden_fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
                    cross_media_campaign_daily_agg.cpc,
                    cross_media_campaign_daily_agg.total_clicks_formatted,
                    cross_media_campaign_daily_agg.ctr,
                    cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    note_state: collapsed
    note_display: hover
    note_text: The average cost for 1,000 impressions.
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 3
    col: 4
    width: 4
    height: 2
###############################################################################################
  - name: ctr
    title: 'CTR'
    explore: cross_media_campaign_daily_agg
    type: single_value
    fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
            cross_media_campaign_daily_agg.cpm,
            cross_media_campaign_daily_agg.cpc,
            cross_media_campaign_daily_agg.total_clicks_formatted,
            cross_media_campaign_daily_agg.ctr,
            cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    hidden_fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
                    cross_media_campaign_daily_agg.cpc,
                    cross_media_campaign_daily_agg.total_clicks_formatted,
                    cross_media_campaign_daily_agg.cpm,
                    cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    note_state: collapsed
    note_display: hover
    note_text: The number of clicks on the ad divided by the number of impressions.
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 3
    col: 8
    width: 4
    height: 2
###############################################################################################
  - name: clicks
    title: 'Clicks'
    explore: cross_media_campaign_daily_agg
    type: single_value
    fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
            cross_media_campaign_daily_agg.cpm,
            cross_media_campaign_daily_agg.cpc,
            cross_media_campaign_daily_agg.total_clicks_formatted,
            cross_media_campaign_daily_agg.ctr,
            cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    hidden_fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
                    cross_media_campaign_daily_agg.cpc,
                    cross_media_campaign_daily_agg.ctr,
                    cross_media_campaign_daily_agg.cpm,
                    cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    note_state: collapsed
    note_display: hover
    note_text: Total number of clicks on the ad.
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 3
    col: 12
    width: 4
    height: 2
###############################################################################################
  - name: cpc
    title: 'CPC'
    explore: cross_media_campaign_daily_agg
    type: single_value
    fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
            cross_media_campaign_daily_agg.cpm,
            cross_media_campaign_daily_agg.cpc,
            cross_media_campaign_daily_agg.total_clicks_formatted,
            cross_media_campaign_daily_agg.ctr,
            cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    hidden_fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
                    cross_media_campaign_daily_agg.total_clicks_formatted,
                    cross_media_campaign_daily_agg.ctr,
                    cross_media_campaign_daily_agg.cpm,
                    cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    note_state: collapsed
    note_display: hover
    note_text: The average cost per click.
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 3
    col: 16
    width: 4
    height: 2
###############################################################################################
  - name: spend
    title: 'Total Spend'
    explore: cross_media_campaign_daily_agg
    type: single_value
    fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
            cross_media_campaign_daily_agg.cpm,
            cross_media_campaign_daily_agg.cpc,
            cross_media_campaign_daily_agg.total_clicks_formatted,
            cross_media_campaign_daily_agg.ctr,
            cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
    hidden_fields: [cross_media_campaign_daily_agg.total_impressions_formatted,
                    cross_media_campaign_daily_agg.total_clicks_formatted,
                    cross_media_campaign_daily_agg.ctr,
                    cross_media_campaign_daily_agg.cpm,
                    cross_media_campaign_daily_agg.cpc]
    note_state: collapsed
    note_display: hover
    note_text: The total cost of media across the campaigns shown.
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 3
    col: 20
    width: 4
    height: 2
###############################################################################################
  - name: header_monthly_campaign_performance
    type: text
    body_text: "<div style=\"position: relative; text-align: center;
                      min-height: 20px; padding: 2px;
                      border-bottom: 2px #C0C0C0 inset; width: 100%;\">
                <span style=\"background-color: #FFFFFF; color: #808080;
                      font-size: 120%; font-weight: bold; height: 20px; margin-bottom: 2px;\">
                How many impressions did I buy?
                </span>
                </div>"
    row: 5
    col: 0
    width: 24
    height: 2
###############################################################################################
  - name: monthly_campaign_performance
    title: Total Impressions by Month
    explore: cross_media_campaign_daily_agg
    type: looker_column
    fields: [cross_media_campaign_daily_agg.source_system,
            cross_media_campaign_daily_agg.report_month,
            cross_media_campaign_daily_agg.total_impressions_formatted]
    pivots: [cross_media_campaign_daily_agg.source_system]
    # fill_fields: [cross_media_campaign_daily_agg.report_month]
    sorts: [cross_media_campaign_daily_agg.source_system desc,
            cross_media_campaign_daily_agg.report_month]
    title_hidden: false
    stacking: normal
    total: true
    show_totals_labels: true
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_datetime_label: "%b %y"
    legend_position: left
    y_axis_combined: true
    show_null_points: false
    discontinuous_nulls: true
    interpolation: step
    point_style: circle
    y_axes: [
          {label: '', orientation: left,
              series: [{axisId: cross_media_campaign_daily_agg.total_impressions_formatted,
                            id: cross_media_campaign_daily_agg.total_impressions_formatted,
                          name: Total Impressions}],},
          ]
    series_types:
      cross_media_campaign_daily_agg.total_impressions_formatted: column
    series_colors:
      GoogleAds - cross_media_campaign_daily_agg.total_impressions_formatted: "rgba(15,157,88,.50)"
      Google Ads - cross_media_campaign_daily_agg.total_impressions_formatted: "rgba(15,157,88,.50)"
      Meta - cross_media_campaign_daily_agg.total_impressions_formatted: "rgba(66,103,178,.50)"
      TikTok - cross_media_campaign_daily_agg.total_impressions_formatted: "rgba(0,0,0,.50)"
      YouTube (DV360) - cross_media_campaign_daily_agg.total_impressions_formatted: 'rgba(255,0,0,.50)'
      YouTube - cross_media_campaign_daily_agg.total_impressions_formatted: 'rgba(255,0,0,.50)'
    advanced_vis_config: |-
      {
        chart: {},
        tooltip: {
          backgroundColor: '#bebeb6',
          shared: true,
          shadow: true,
          formatter: null,
          headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
          pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f} ({point.percentage:.0f}%) </td></tr>',
          footerFormat: '</table>',
        },

      }
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 7
    col: 0
    width: 24
    height: 8
###############################################################################################
  - name: header_impressions_and_ctr
    type: text
    body_text: "<div style=\"position: relative; text-align: center;
                      min-height: 20px; padding: 2px;
                      border-bottom: 2px #C0C0C0 inset; width: 100%;\">
                <span style=\"background-color: #FFFFFF; color: #808080;
                      font-size: 120%; font-weight: bold; height: 20px; margin-bottom: 2px;\">
                How did my campaigns perform?
                </span>
                </div>"
                # <div style=\"position: relative; padding-top: 10px; text-align: center; font-size: 100%; font-weight: bold; color: #808080; height: 40px;\">
                # Impressions <span style='font-size: 20px;'>&#9632;</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CTR <span style='font-size: 20px;'>&#9675;</span>
                # </div>
                # <div style=\"position: relative; padding-top: 10px; text-align: center; font-size: 80%; font-weight: bold; color: #4c947d; height: 40px;\">

                #       <span style='color: rgba(15,157,88,.50);font-size: 18px;'>GoogleAds</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                #       <span style='color: rgba(66,103,178,.50);font-size: 18px;'>Meta</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                #       <span style='color: rgba(0,0,0,.50);font-size: 18px;'>TikTok</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                #       <span style='color: rgba(255,0,0,.50);font-size: 18px;'>YouTube (DV360)</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                # </div>


    row: 15
    col: 0
    width: 24
    height: 3
##############################################################################################
  - name: monthly_campaign_performance_by_platform
    title: Impressions and Click Through Rates by Month & Media Platform
    explore: cross_media_campaign_daily_agg
    type: looker_column
    fields: [cross_media_campaign_daily_agg.source_system,
            cross_media_campaign_daily_agg.report_month,
            cross_media_campaign_daily_agg.total_impressions_formatted,
            cross_media_campaign_daily_agg.ctr_formatted]
    pivots: [cross_media_campaign_daily_agg.source_system]
    sorts: [cross_media_campaign_daily_agg.source_system,
            cross_media_campaign_daily_agg.report_month]
    limit: 100
    column_limit: 10
    title_hidden: false
    y_axis_gridlines: false
    show_y_axis_ticks: true
    show_x_axis_label: false
    x_axis_datetime_label: "%b %y"
    hide_legend: false
    legend_position: left
    point_style: circle_outline
    interpolation: step
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    discontinuous_nulls: true
    y_axes: [
        ##--> left axis shows Impressions
        {label: '', orientation: left,
        series: [
          {axisId: cross_media_campaign_daily_agg.total_impressions_formatted,
            id: GoogleAds - cross_media_campaign_daily_agg.total_impressions_formatted,
            name: GoogleAds - Impressions},
          {axisId: cross_media_campaign_daily_agg.total_impressions_formatted,
            id: Meta - cross_media_campaign_daily_agg.total_impressions_formatted,
            name: Meta - Impressions},
          {axisId: cross_media_campaign_daily_agg.total_impressions_formatted,
            id: TikTok - cross_media_campaign_daily_agg.total_impressions_formatted,
            name: TikTok - Impressions},
          {axisId: cross_media_campaign_daily_agg.total_impressions_formatted,
            id: YouTube (DV360) - cross_media_campaign_daily_agg.total_impressions_formatted,
            name: YouTube (DV360) - Impressions}
            ],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        type: linear},
        ##--> right axis shows CTR
        {label: '', orientation: right,
        series: [
          {axisId: cross_media_campaign_daily_agg.ctr_formatted,
          id: GoogleAds - cross_media_campaign_daily_agg.ctr_formatted,
          name: Google Ads - CTR},
          {axisId: cross_media_campaign_daily_agg.ctr_formatted,
          id: Google Ads - cross_media_campaign_daily_agg.ctr_formatted,
          name: Google Ads - CTR},
          {axisId: cross_media_campaign_daily_agg.ctr_formatted,
          id: Meta - cross_media_campaign_daily_agg.ctr_formatted,
          name: Meta - CTR},
          {axisId: cross_media_campaign_daily_agg.ctr_formatted,
          id: TikTok - cross_media_campaign_daily_agg.ctr_formatted,
          name: TikTok - CTR},
          {axisId: cross_media_campaign_daily_agg.ctr_formatted,
          id: YouTube (DV360) - cross_media_campaign_daily_agg.ctr_formatted,
          name: YouTube (DV360) - CTR},
          {axisId: cross_media_campaign_daily_agg.ctr_formatted,
          id: YouTube - cross_media_campaign_daily_agg.ctr_formatted,
          name: YouTube - CTR}
          ],
        valueFormat: 0"%", showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}
        ]
    series_types:
      # GoogleAds - cross_media_campaign_daily_agg.total_impressions_formatted: column
      # Meta - cross_media_campaign_daily_agg.total_impressions_formatted: column
      # TikTok - cross_media_campaign_daily_agg.total_impressions_formatted: column
      # YouTube (DV360) - cross_media_campaign_daily_agg.total_impressions_formatted: column
      # YouTube - cross_media_campaign_daily_agg.total_impressions_formatted: column
      cross_media_campaign_daily_agg.total_impressions_formatted: column
      # cross_media_campaign_daily_agg.ctr_formatted: scatter
      GoogleAds - cross_media_campaign_daily_agg.ctr_formatted: scatter
      Google Ads - cross_media_campaign_daily_agg.ctr_formatted: scatter
      Meta - cross_media_campaign_daily_agg.ctr_formatted: scatter
      TikTok - cross_media_campaign_daily_agg.ctr_formatted: scatter
      YouTube (DV360) - cross_media_campaign_daily_agg.ctr_formatted: scatter
      YouTube - cross_media_campaign_daily_agg.ctr_formatted: scatter
    series_colors:
    #--> impressions as column with 50% transparancy
      GoogleAds - cross_media_campaign_daily_agg.total_impressions_formatted: rgba(15,157,88,.50)
      Google Ads - cross_media_campaign_daily_agg.total_impressions_formatted: rgba(15,157,88,.50)
      Meta - cross_media_campaign_daily_agg.total_impressions_formatted: rgba(66,103,178,.50)
      TikTok - cross_media_campaign_daily_agg.total_impressions_formatted: rgba(0,0,0,.50)
      YouTube (DV360) - cross_media_campaign_daily_agg.total_impressions_formatted: rgba(255,0,0,.50)
      YouTube - cross_media_campaign_daily_agg.total_impressions_formatted: rgba(255,0,0,.50)
    #--> ctr as point with full color
      GoogleAds - cross_media_campaign_daily_agg.ctr_formatted: rgba(15,157,88,1)
      Google Ads - cross_media_campaign_daily_agg.ctr_formatted: rgba(15,157,88,1)
      Meta - cross_media_campaign_daily_agg.ctr_formatted: rgba(66,103,178,1)
      TikTok - cross_media_campaign_daily_agg.ctr_formatted: rgba(0,0,0,1)
      YouTube (DV360) - cross_media_campaign_daily_agg.ctr_formatted: rgba(255,0,0,1)
      YouTube - cross_media_campaign_daily_agg.ctr_formatted: rgba(255,0,0,1)
    series_labels:
      GoogleAds - cross_media_campaign_daily_agg.total_impressions_formatted: GoogleAds - Impressions
      Google Ads - cross_media_campaign_daily_agg.total_impressions_formatted: Google Ads - Impressions
      Meta - cross_media_campaign_daily_agg.total_impressions_formatted: Meta - Impressions
      TikTok - cross_media_campaign_daily_agg.total_impressions_formatted: TikTok - Impressions
      YouTube (DV360) - cross_media_campaign_daily_agg.total_impressions_formatted: YouTube (DV360) - Impressions
      YouTube - cross_media_campaign_daily_agg.total_impressions_formatted: YouTube - Impressions
      GoogleAds - cross_media_campaign_daily_agg.ctr_formatted: GoogleAds - CTR
      Google Ads - cross_media_campaign_daily_agg.ctr_formatted: Google Ads - CTR
      Meta - cross_media_campaign_daily_agg.ctr_formatted: Meta - CTR
      TikTok - cross_media_campaign_daily_agg.ctr_formatted: TikTok - CTR
      YouTube (DV360) - cross_media_campaign_daily_agg.ctr_formatted: YouTube (DV360) - CTR
      YouTube - cross_media_campaign_daily_agg.ctr_formatted: YouTube - CTR

    advanced_vis_config: |-
      {
        chart: {},
        tooltip: {
          backgroundColor: '#bebeb6',
          shared: true,
          shadow: true,
          formatter: null,
          headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
          pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f} </td></tr>',
          footerFormat: '</table>',
        },
        series: [
         // impressions googleads
         {
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f} </td></tr>',
            footerFormat: '</table>',
            },
          },
          // ctr googleads
          {
            marker: {
              fillColor: '#FFFFFF',
            },
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.2f}% </td></tr>',
            footerFormat: '</table>',
            shared: true,
            },
          },
          // impressions meta
          {
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f} </td></tr>',
            footerFormat: '</table>',
            },
          },
          // ctr meta
          {
          marker: {
            fillColor: '#FFFFFF',
          },
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.2f}% </td></tr>',
            footerFormat: '</table>',
            shared: true,
            },
          },
          // impressions tiktok
          {
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f} </td></tr>',
            footerFormat: '</table>',
            },
          },
          // ctr tiktok
          {
          marker: {
            fillColor: '#FFFFFF',
          },
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.2f}% </td></tr>',
            footerFormat: '</table>',
            shared: true,
            },
          },
           // impressions youtube
          {
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f} </td></tr>',
            footerFormat: '</table>',
            },
          },
          // ctr youtube
          {
          marker: {
            fillColor: '#FFFFFF',
          },
          tooltip: {
            headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
            pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.2f}% </td></tr>',
            footerFormat: '</table>',
            shared: true,
            },
          },
        ]
      }
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 18
    col: 0
    width: 24
    height: 8
###############################################################################################
  # - name: header_monthly_cpm
  #   type: text
  #   body_text: "<div style=\"position: relative; text-align: center;
  #                     min-height: 20px; padding: 2px;
  #                     border-bottom: 2px #C0C0C0 inset; width: 100%;\">
  #               <span style=\"background-color: #FFFFFF; color: #808080;
  #                     font-size: 120%; font-weight: bold; height: 20px; margin-bottom: 2px;\">
  #               Cost per Mille by Month & Media Platform
  #               </span>
  #               </div>"
  #   row: 26
  #   col: 0
  #   width: 24
  #   height: 2
###############################################################################################
  - name: cpm_by_month_and_platform
    title: Cost per Mille by Month & Media Platform
    explore: cross_media_campaign_daily_agg
    type: looker_column
    fields: [cross_media_campaign_daily_agg.source_system,
             cross_media_campaign_daily_agg.report_month,
             cross_media_campaign_daily_agg.cpm]
    pivots: [cross_media_campaign_daily_agg.source_system]
    sorts: [cross_media_campaign_daily_agg.source_system,
            cross_media_campaign_daily_agg.report_month]
    title_hidden: false
    column_limit: 50
    column_group_spacing_ratio: 0.3
    # total: true
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    limit_displayed_rows: false
    legend_position: left
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, valueFormat: 0.,
              series: [
                {axisId: cross_media_campaign_daily_agg.cpm,
                id: cross_media_campaign_daily_agg.cpm, name: CPM,
                }],
      }]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      GoogleAds - cross_media_campaign_daily_agg.cpm: rgba(15,157,88,.50)
      Google Ads - cross_media_campaign_daily_agg.cpm: rgba(15,157,88,.50)
      Meta - cross_media_campaign_daily_agg.cpm: rgba(66,103,178,.50)
      TikTok - cross_media_campaign_daily_agg.cpm: rgba(0,0,0,.50)
      YouTube (DV360) - cross_media_campaign_daily_agg.cpm: rgba(255,0,0,.50)
      YouTube - cross_media_campaign_daily_agg.cpm: rgba(255,0,0,.50)
    x_axis_datetime_label: "%b %y"
    advanced_vis_config: |-
      {
        tooltip: {
          backgroundColor: '#bebeb6',
          shared: true,
          shadow: true,
          formatter: null,
          headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
          pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.2f} </td></tr>',
          footerFormat: '</table>',
        },
      }
    show_null_points: false
    discontinuous_nulls: true
    interpolation: step
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 26
    col: 0
    width: 24
    height: 8
###############################################################################################
  - name: header_cumulative_spend
    type: text
    body_text: "<div style=\"position: relative; text-align: center;
                      min-height: 20px; padding: 2px;
                      border-bottom: 2px #C0C0C0 inset; width: 100%;\">
                <span style=\"background-color: #FFFFFF; color: #808080;
                      font-size: 120%; font-weight: bold; height: 20px; margin-bottom: 2px;\">
                What is the cumulative campaign spend?
                </span>
                </div>"
    row: 36
    col: 0
    width: 24
    height: 2
###############################################################################################
  - name: cumulative_spend
    title: Monthly Campaign Spend
    explore: cross_media_campaign_daily_agg
    type: looker_area
    fields: [cross_media_campaign_daily_agg.report_month,
             cross_media_campaign_daily_agg.source_system,
             cross_media_campaign_daily_agg.cumulative_total_cost_in_target_currency_formatted
            ]
    pivots: [cross_media_campaign_daily_agg.source_system]
    sorts: [cross_media_campaign_daily_agg.source_system desc,
            cross_media_campaign_daily_agg.report_month]
    title_hidden: false
    y_axis_gridlines: false
    show_x_axis_label: false
    hide_legend: false
    legend_position: left
    show_null_points: true
    show_totals_labels: true
    stacking: normal
    series_types:
      cross_media_campaign_daily_agg.cumulative_total_cost_in_target_currency_formatted: area
    series_colors:
      GoogleAds - cross_media_campaign_daily_agg.cumulative_total_cost_in_target_currency_formatted: "rgba(15,157,88,.70)"
      Google Ads - cross_media_campaign_daily_agg.cumulative_total_cost_in_target_currency_formatted: "rgba(15,157,88,.70)"
      Meta - cross_media_campaign_daily_agg.cumulative_total_cost_in_target_currency_formatted: "rgba(66,103,178,.70)"
      TikTok - cross_media_campaign_daily_agg.cumulative_total_cost_in_target_currency_formatted: "rgba(0,0,0,.70)"
      YouTube (DV360) - cross_media_campaign_daily_agg.cumulative_total_cost_in_target_currency_formatted: 'rgba(255,0,0,.70)'
      YouTube - cross_media_campaign_daily_agg.cumulative_total_cost_in_target_currency_formatted: 'rgba(255,0,0,.70)'
    x_axis_datetime_label: "%b %y"
    advanced_vis_config: |-
      {
        chart: {
          type: 'streamgraph',
        },
        tooltip: {
          backgroundColor: '#bebeb6',
          shared: true,
          shadow: true,
          formatter: null,
          headerFormat: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;">{point.key}</th>',
          pointFormat: '<tr><th style="text-align: left;color:{point.color};">{series.name}:&nbsp;&nbsp;</th><td style="text-align: right;color:{point.color};" >{point.y:,.0f} ({point.percentage:.0f}%) </td></tr>',
          footerFormat: '</table>',
        },
      }
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 38
    col: 0
    width: 24
    height: 8
