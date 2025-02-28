#########################################################{
# Cross Media Campaigns dashboard provides performance details
# by campaign.
#
# Extends template_cross_media and modifies:
#   dashboard_navigation to set parameter_navigation_focus_page: '2'
#
# Visualization Elements:
#   calendar - timeline with continuous color based on total impressions
#   campaign_impressions - column with cpm as line
#   campaign_clicks - column with cpc as line
#
#########################################################}

- dashboard: cross_media_2_campaigns
  title: Cross Media Campaigns
  description: "Media performance details by campaign"

  extends: template_cross_media

  filters:
    - name: campaign_limit
      title: 'Campaign Display Limit per Media Platform'
      type: field_filter
      default_value: '20'
      allow_multiple_values: false
      required: false
      ui_config:
        type: slider
        display: inline
        options:
          min: 1
          max: 100
      explore: cross_media_campaign_daily_agg
      field: cross_media_campaign_daily_agg.dummy_campaign_limit

  elements:
    - name: dashboard_navigation
      filters:
        cross_media_dashboard_navigation_xvw.parameter_navigation_focus_page: '2'

###############################################################################################
    - name: header_campaign_calendar
      type: text
      body_text: "<div style=\"position: relative; text-align: center;
                       min-height: 20px; padding: 2px;
                       border-bottom: 2px #C0C0C0 inset; width: 100%;\">
                  <span style=\"background-color: #FFFFFF; color: #808080;
                              font-size: 120%; font-weight: bold; height: 20px; margin-bottom: 2px;\">
                     What campaigns have run?
                  </span>
                 </div>"
      row: 2
      col: 0
      width: 24
      height: 2
###############################################################################################
    - name: calendar
      title: 'Campaign Calender'
      explore: cross_media_campaign_daily_agg
      type: looker_timeline
      fields: [cross_media_campaign_daily_agg.campaign_id,
               cross_media_campaign_daily_agg.campaign_name_short_with_source,
               cross_media_campaign_daily_agg.source_system,
               cross_media_campaign_dates_ndt.min_report_date,
               cross_media_campaign_dates_ndt.max_report_date,
               cross_media_campaign_daily_agg.total_impressions,
               cross_media_campaign_ranks_ndt.rank_by_date,
               cross_media_campaign_daily_agg.selected_campaign_limit,
               cross_media_campaign_ranks_ndt.is_within_campaign_limit
               ]
      hidden_fields: [cross_media_campaign_daily_agg.campaign_id,
                      cross_media_campaign_daily_agg.selected_campaign_limit,
                      cross_media_campaign_ranks_ndt.rank_by_date,
                      cross_media_campaign_ranks_ndt.is_within_campaign_limit
                      ]
      sorts: [
              cross_media_campaign_dates_ndt.min_report_date,
              cross_media_campaign_daily_agg.source_system,
              cross_media_campaign_daily_agg.campaign_id]
      hidden_points_if_no: [cross_media_campaign_ranks_ndt.is_within_campaign_limit]
      groupBars: false
      labelSize: 9pt
      showLegend: true
      y_axis_gridlines: false
      x_axis_gridlines: false
      series_colors:
        GoogleAds - cross_media_campaign_daily_agg.total_impressions: "rgba(15,157,88,.50)"
        Google Ads - cross_media_campaign_daily_agg.total_impressions: "rgba(15,157,88,.50)"
        Meta - cross_media_campaign_daily_agg.total_impressions: "rgba(66,103,178,.50)"
        TikTok - cross_media_campaign_daily_agg.total_impressions: "rgba(0,0,0,.50)"
        YouTube (DV360) - cross_media_campaign_daily_agg.total_impressions: 'rgba(255,0,0,.50)'
        YouTube - cross_media_campaign_daily_agg.total_impressions: 'rgba(255,0,0,.50)'
      color_application:
        custom:
          id: 97465c2c-5cd5-6862-28bb-7fc6e27c0f2c
          label: Custom
          type: continuous
          stops:
          - color: "#a9d6e5"
            offset: 0
          - color: "#61a5c2"
            offset: 25
          - color: "#2c7da0"
            offset: 50
          - color: "#01497c"
            offset: 75
          - color: "#012a4a"
            offset: 100
        options:
          steps: 5
          reverse: true
      valueFormat: dd-mmm-yy
      advanced_vis_config: |-
        {
          chart: {
            spacingBottom: 20,
          },
          subtitle: {
            text: 'Active campaigns based on date range including start and end dates',
            useHTML: true,
            align: 'center',
            style: {
              fontSize: '14px',
            },
          },
          legend: {
            reversed: true,
          },
          xAxis: {
            width: 20,
            scrollbar: {
              enabled: true,
            },
            labels: {
              align: 'right',
              useHTML: true,
              allowOverlap: true,
              maxStaggerLines: 3,
              overflow: 'allow',
              style: {
                fontSize: '9pt',
              },
            },
          },
          yAxis: {
            type: 'datetime',
            opposite: true,
            title: {},
            endOnTick: false,
            startOnTick: false,
            labels: {},
          },
          tooltip: {
            format: '<table><th style="font-size: 1.8em;text-align: left;color: #FFFFFF;"><br>{key}<br></th></table><table>{#each points}<tr><th style="text-align: left;font-size: 1.2em"><br><br><br>{point.detail}<br><br>{point.formattedStart} — {point.formattedEnd}<br>{point.magnitudeFormatted} Impressions<br><br></th></tr>{/each}',
            footerFormat: '</table>',
            // backgroundColor: '#bebeb6',
            shared: true,
            shadow: true,
            padding: 10,
          },
        }
      note_state: collapsed
      note_display: hover
      note_text: |-
        The table displays individual campaigns, or for YouTube (DV360), campaign line items. Each row represents a unique entry, organized chronologically by the earliest reporting date.
        </br></br>The bars' widths visualize the campaign's duration, spanning from the first to the last reporting date. A color gradient indicates the total impression count over this reporting timeframe.
        </br></br>A limited number of campaigns are presented. To expand the view and see additional campaigns, change the dashboard filter `Campaign Display Limit per Media Platform' to desired value.
      listen:
        date: cross_media_campaign_daily_agg.report_date
        source: cross_media_campaign_daily_agg.source_system
        country: cross_media_campaign_daily_agg.country_name
        campaign: cross_media_campaign_daily_agg.campaign_name
        product: cross_media_campaign_daily_agg.filter_product_name
        target_currency: cross_media_campaign_daily_agg.parameter_target_currency
        funnel_level: cross_media_campaign_daily_agg.funnel_level
        campaign_limit: cross_media_campaign_daily_agg.parameter_campaign_limit
      row: 3
      col: 0
      width: 24
      height: 12
###############################################################################################
    - name: header_campaign_impressions
      type: text
      body_text: "<div style=\"position: relative; text-align: center;
                      min-height: 40px; padding: 2px;
                      border-bottom: 2px #C0C0C0 inset; width: 100%;\">
                  <span style=\"background-color: #FFFFFF; color: #808080;
                      font-size: 120%; font-weight: bold; height: 20px; margin-bottom: 2px;\">
                  How were my campaigns performing?
                  </span>
                  </div>"

                  # <div style=\"position: relative; padding-top: 10px; text-align: center; font-size: 100%; font-weight: bold; color: #808080; height: 30px;\">
                  # Impressions <span style='font-size: 20px;'>&#9632;</span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;CPM <span style='font-size: 20px;'>&#9650;</span>
                  # </div>"

                  # <div style=\"position: relative; padding-top: 10px; text-align: center; font-size: 80%; font-weight: bold; color: #4c947d; height: 40px;\">

                  #     <span style='color: rgba(15,157,88,.50);font-size: 18px;'>GoogleAds</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  #     <span style='color: rgba(66,103,178,.50);font-size: 18px;'>Meta</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  #     <span style='color: rgba(0,0,0,.50);font-size: 18px;'>TikTok</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  #     <span style='color: rgba(255,0,0,.50);font-size: 18px;'>YouTube (DV360)</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  # </div>"
      row: 15
      col: 0
      width: 24
      height: 2
###############################################################################################
    - name: subtitle_sources
      explore: cross_media_campaign_daily_agg
      type: single_value
      fields: [cross_media_campaign_daily_agg.source_system_list]
      filters:
        cross_media_campaign_daily_agg.parameter_chart_title: Campaign Impressions and CPM
      show_single_value_title: false
      listen:
        date: cross_media_campaign_daily_agg.report_date
        source: cross_media_campaign_daily_agg.source_system
        country: cross_media_campaign_daily_agg.country_name
        campaign: cross_media_campaign_daily_agg.campaign_name
        product: cross_media_campaign_daily_agg.filter_product_name
        target_currency: cross_media_campaign_daily_agg.parameter_target_currency
        funnel_level: cross_media_campaign_daily_agg.funnel_level
      row: 17
      col: 0
      width: 24
      height: 1
###############################################################################################
    - name: campaign_impressions
      title: Campaign Impressions and CPM
      title_hidden: false
      explore: cross_media_campaign_daily_agg
      type: looker_line
      fields: [cross_media_campaign_daily_agg.selected_campaign_limit,
               cross_media_campaign_daily_agg.campaign_id,
               cross_media_campaign_daily_agg.campaign_name_short,
               cross_media_campaign_daily_agg.source_system,
               cross_media_campaign_dates_ndt.report_date_range,
               cross_media_campaign_daily_agg.total_impressions_formatted,
               cross_media_campaign_daily_agg.cpm,
               cross_media_campaign_ranks_ndt.rank_by_date,
               cross_media_campaign_ranks_ndt.is_within_campaign_limit]
      hidden_fields: [cross_media_campaign_daily_agg.selected_campaign_limit,
                      cross_media_campaign_daily_agg.campaign_id,
                      cross_media_campaign_ranks_ndt.rank_by_date,
                      cross_media_campaign_ranks_ndt.is_within_campaign_limit]
      sorts: [cross_media_campaign_daily_agg.source_system,
              cross_media_campaign_daily_agg.min_report_date,
              cross_media_campaign_daily_agg.campaign_name_short]
      hidden_points_if_no: [cross_media_campaign_ranks_ndt.is_within_campaign_limit]
      x_axis_gridlines: false
      y_axis_gridlines: false
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: false
      show_x_axis_ticks: true
      x_axis_label_rotation: 0
      hide_legend: false
      legend_position: center
      show_value_labels: false
      y_axis_combined: true
      show_null_points: false
      discontinuous_nulls: true
      interpolation: step
      point_style: circle
      y_axes: [{label: '', orientation: left,
                  series: [{axisId: cross_media_campaign_daily_agg.total_impressions_formatted,
                                id: cross_media_campaign_daily_agg.total_impressions_formatted,
                                name: Total Impressions}],},
               {label: '', orientation: right,
                  series: [{axisId: cross_media_campaign_daily_agg.cpm,
                                id: cross_media_campaign_daily_agg.cpm, name: CPM}],},
               ]
      series_types:
        cross_media_campaign_daily_agg.total_impressions_formatted: column
      series_colors:
      #-->conditional formatting based on source system applied in advanced vis config
        cross_media_campaign_daily_agg.total_impressions_formatted: "#808080"
        cross_media_campaign_daily_agg.cpm: "#808080"
      series_point_styles:
        cross_media_campaign_daily_agg.cpm: triangle
      advanced_vis_config: |-
        {
          chart: {
            spacingBottom: 10,
          },

          tooltip: {
            backgroundColor: '#bebeb6',
            shared: true,
            formatter: null,
            shadow: true,
            crosshairs: true,
            },

          series: [
          //first series Impressions
            {
            dataLabels: true,
            tooltip: {
              headerFormat: '<span style="font-size: 1.8em">{point.key}</span><br/>',
              pointFormat: '<span style="color:{point.color}"> <b>{series.name}:  {point.y:,.0f}</b></span><br/>',
              shared: true,
              },
            formatters: [
              {
              select: 'name = Google',
              style: {
                color: 'rgba(15,157,88,.50)',
                },
              },
              {
              select: 'name = Meta',
              style: {
                color: 'rgba(66,103,178,.50)',
                },
              },
              {
              select: 'name = TikTok',
              style: {
                color: 'rgba(0,0,0,.50)',
                },
              },
              {
              select: 'name = YouTube (DV360)',
              style: {
                color: 'rgba(255,0,0,.50)',
              },
              },
              {
              select: 'name = YouTube',
              style: {
                color: 'rgba(255,0,0,.50)',
              },
              },
            ],
            },
            //second series CPM
              {
              dataLabels: false,
              lineWidth: 0,
              tooltip: {
                headerFormat: '<span style="font-size: 1.8em">{point.key}</span><br/>',
                pointFormat: '<span style="color:{point.color}"> <b>{series.name}:  {point.y:,.2f}</b></span><br/>',
                shared: true,
              },
              formatters: [
              {
                select: 'name = Google',
                style: {
                  color: 'rgba(15,157,88,1)',
                },
              },
              {
                select: 'name = Meta',
                style: {
                  color: 'rgba(66,103,178,1)',
                },
              },
              {
                select: 'name = TikTok',
                style: {
                  color: 'rgba(0,0,0,1)',
                },
              },
              {
                select: 'name = YouTube (DV360)',
                style: {
                  color: 'rgba(255,0,0,1)',
                },
              },
              {
                select: 'name = YouTube',
                style: {
                  color: 'rgba(255,0,0,1)',
                },
              },
              ],
              },
            ],
            xAxis: {
              labels: {
                enabled: false,
              },
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
        campaign_limit: cross_media_campaign_daily_agg.parameter_campaign_limit
      row: 19
      col: 0
      width: 24
      height: 8
###############################################################################################
    # - name: subtitle2_sources
    #   explore: cross_media_campaign_daily_agg
    #   type: single_value
    #   fields: [cross_media_campaign_daily_agg.source_system_list]
    #   filters:
    #     cross_media_campaign_daily_agg.parameter_chart_title: Campaign Clicks and CTR
    #   show_single_value_title: false
    #   listen:
    #     date: cross_media_campaign_daily_agg.report_date
    #     source: cross_media_campaign_daily_agg.source_system
    #     country: cross_media_campaign_daily_agg.country_name
    #     campaign: cross_media_campaign_daily_agg.campaign_name
    #     product: cross_media_campaign_daily_agg.filter_product_name
    #     target_currency: cross_media_campaign_daily_agg.parameter_target_currency
    #     funnel_level: cross_media_campaign_daily_agg.funnel_level
    #   row: 27
    #   col: 0
    #   width: 24
    #   height: 2
###############################################################################################
    - name: campaign_clicks
      title: Campaign Clicks and CTR
      title_hidden: false
      explore: cross_media_campaign_daily_agg
      type: looker_line
      fields: [cross_media_campaign_daily_agg.campaign_id,
               cross_media_campaign_daily_agg.campaign_name_short,
               cross_media_campaign_daily_agg.source_system,
               cross_media_campaign_dates_ndt.report_date_range,
               cross_media_campaign_daily_agg.total_clicks_formatted,
               cross_media_campaign_daily_agg.cpc,
               cross_media_campaign_daily_agg.selected_campaign_limit,
               cross_media_campaign_ranks_ndt.rank_by_date,
               cross_media_campaign_ranks_ndt.is_within_campaign_limit]
      hidden_fields: [cross_media_campaign_daily_agg.campaign_id,
                      cross_media_campaign_daily_agg.selected_campaign_limit,
                      cross_media_campaign_ranks_ndt.rank_by_date,
                      cross_media_campaign_ranks_ndt.is_within_campaign_limit]
      sorts: [cross_media_campaign_daily_agg.source_system,
              cross_media_campaign_daily_agg.campaign_name_short,
              cross_media_campaign_daily_agg.min_report_date]
      hidden_points_if_no: [cross_media_campaign_ranks_ndt.is_within_campaign_limit]
      x_axis_gridlines: false
      y_axis_gridlines: false
      show_view_names: false
      show_y_axis_labels: true
      show_y_axis_ticks: true
      y_axis_tick_density: default
      y_axis_tick_density_custom: 5
      show_x_axis_label: false
      show_x_axis_ticks: true
      x_axis_label_rotation: 0
      hide_legend: false
      legend_position: center
      show_value_labels: false
      y_axis_combined: true
      show_null_points: false
      discontinuous_nulls: true
      interpolation: step
      point_style: circle
      y_axes: [{label: '', orientation: left,
                  series: [{axisId: cross_media_campaign_daily_agg.total_clickd_formatted,
                                id: cross_media_campaign_daily_agg.total_clicks_formatted,
                                name: Total Impressions}],},
               {label: '', orientation: right,
                  series: [{axisId: cross_media_campaign_daily_agg.cpc,
                                id: cross_media_campaign_daily_agg.cpc, name: CPC}],},
               ]
      series_types:
        cross_media_campaign_daily_agg.total_clicks_formatted: column
        cross_media_campaign_daily_agg.cpc: line
      series_colors:
      #-->conditional formatting based on source system applied in advanced vis config
        cross_media_campaign_daily_agg.total_clicks_formatted: "#808080"
        cross_media_campaign_daily_agg.cpc: "#808080"
      series_point_styles:
        cross_media_campaign_daily_agg.cpc: diamond
      advanced_vis_config: |-
        {
          chart: {
            spacingBottom: 10,
          },

          tooltip: {
            backgroundColor: '#bebeb6',
            shared: true,
            formatter: null,
            shadow: true,
            crosshairs: true,
            },
          series: [{
            dataLabels: true,
            formatters: [{
              select: 'name = Google',
              style: {
                color: 'rgba(15,157,88,.50)',
              },
              },
              {
              select: 'name = Meta',
              style: {
                color: 'rgba(66,103,178,.50)',
              },
              },
              {
              select: 'name = TikTok',
              style: {
                color: 'rgba(0,0,0,.50)',
              },
              },
              {
              select: 'name = YouTube (DV360)',
              style: {
                color: 'rgba(255,0,0,.50)',
              },
            },
            {
              select: 'name = YouTube',
              style: {
                color: 'rgba(255,0,0,.50)',
              },
            },
            ],
              tooltip: {
                headerFormat: '<span style="font-size: 1.8em">{point.key}</span><br/>',
                pointFormat: '<span style="color:{point.color}"> <b>{series.name}:  {point.y:,.0f}</b></span><br/>',
                shared: true,
                },

            },
            {
              dataLabels: false,
              formatters: [{
                select: 'name = Google',
                style: {
                  color: 'rgba(15,157,88,1)',
              },
              },
              {
                select: 'name = Meta',
                style: {
                  color: 'rgba(66,103,178,1)',
                },
              },
              {
                select: 'name = TikTok',
                style: {
                  color: 'rgba(0,0,0,1)',
                },
              },
              {
                select: 'name = YouTube (DV360)',
                style: {
                  color: 'rgba(255,0,0,1)',
                },
              },
              {
                select: 'name = YouTube',
                style: {
                  color: 'rgba(255,0,0,1)',
                },
              },
              ],
              lineWidth: 0,
              tooltip: {
                headerFormat: '<span style="font-size: 1.8em">{point.key}</span><br/>',
                pointFormat: '<span style="color:{point.color}"> <b>{series.name}:  {point.y:,.2f}</b></span><br/>',
                shared: true,
                },
            },
            ],
           xAxis: {
                labels: {
                  enabled: false,
                },
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
        campaign_limit: cross_media_campaign_daily_agg.parameter_campaign_limit
      row: 27
      col: 0
      width: 24
      height: 8
