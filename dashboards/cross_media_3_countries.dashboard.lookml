#########################################################{
# Cross Media Countries dashboard provides media performance details
# by country.
#
# Extends template_cross_media and modifies:
#   dashboard_navigation to set parameter_navigation_focus_page: '3'
#
# Visualization Elements:
#   campaign_spend_by_country - stacked column
#   impressions_by_country - stacked column
#   cpc_by_country - column
#   cpm_by_country - column
#
#########################################################}

- dashboard: cross_media_3_countries
  title: Cross Media by Country
  description: "Media performance details by country"

  extends: template_cross_media

  elements:
    - name: dashboard_navigation
      filters:
        cross_media_dashboard_navigation_xvw.parameter_navigation_focus_page: '3'
###############################################################################################
    - name: header_country_spend
      type: text
      body_text: "<div style=\"position: relative; text-align: center;
                        min-height: 20px; padding: 2px;
                        border-bottom: 2px #C0C0C0 inset; width: 100%;\">
                  <span style=\"background-color: #FFFFFF; color: #808080;
                        font-size: 120%; font-weight: bold; height: 20px; margin-bottom: 2px;\">
                  What was the campaign performance by country?
                  </span>
                  </div>"
      row: 5
      col: 0
      width: 24
      height: 2
###############################################################################################
    - name: campaign_spend_by_country
      title: Spend by Country
      explore: cross_media_campaign_daily_agg
      type: looker_column
      fields: [cross_media_campaign_daily_agg.source_system,
               cross_media_campaign_daily_agg.country_name,
               cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted]
      pivots: [cross_media_campaign_daily_agg.source_system]
      # fill_fields: [cross_media_campaign_daily_agg.report_month]
      sorts: [cross_media_campaign_daily_agg.source_system desc,
              cross_media_campaign_daily_agg.country_name]
      title_hidden: false
      stacking: normal
      total: true
      show_totals_labels: true
      column_group_spacing_ratio: 0.2
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
                series: [{axisId: cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted,
                              id: cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted,
                            name: Total Impressions}],},
              ]
      series_types:
        cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted: column
      series_colors:
        GoogleAds - cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted: "rgba(15,157,88,.50)"
        Google Ads - cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted: "rgba(15,157,88,.50)"
        Meta - cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted: "rgba(66,103,178,.50)"
        TikTok - cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted: "rgba(0,0,0,.50)"
        YouTube (DV360) - cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted: 'rgba(255,0,0,.50)'
        YouTube - cross_media_campaign_daily_agg.total_cost_in_target_currency_formatted: 'rgba(255,0,0,.50)'
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
    - name: impressions_by_country
      title: Impressions by Country
      explore: cross_media_campaign_daily_agg
      type: looker_column
      fields: [cross_media_campaign_daily_agg.source_system,
               cross_media_campaign_daily_agg.country_name,
               cross_media_campaign_daily_agg.total_impressions_formatted]
      pivots: [cross_media_campaign_daily_agg.source_system]
      # fill_fields: [cross_media_campaign_daily_agg.report_month]
      sorts: [cross_media_campaign_daily_agg.source_system desc,
              cross_media_campaign_daily_agg.country_name]
      title_hidden: false
      stacking: normal
      total: true
      show_totals_labels: true
      column_group_spacing_ratio: 0.2
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
      row: 15
      col: 0
      width: 24
      height: 8
###############################################################################################
    - name: cpc_by_country
      title: Cost per Click by Country
      explore: cross_media_campaign_daily_agg
      type: looker_column
      fields: [cross_media_campaign_daily_agg.source_system,
               cross_media_campaign_daily_agg.country_name,
               cross_media_campaign_daily_agg.cpc]
      pivots: [cross_media_campaign_daily_agg.source_system]
      sorts: [cross_media_campaign_daily_agg.source_system,
              cross_media_campaign_daily_agg.country_name]
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
      y_axes: [{label: '', orientation: left, series: [{axisId: cross_media_campaign_daily_agg.cpc,
              id: cross_media_campaign_daily_agg.cpc, name: cpc,}],
        }]
      x_axis_zoom: true
      y_axis_zoom: true
      series_colors:
        GoogleAds - cross_media_campaign_daily_agg.cpc: rgba(15,157,88,.50)
        Google Ads - cross_media_campaign_daily_agg.cpc: rgba(15,157,88,.50)
        Meta - cross_media_campaign_daily_agg.cpc: rgba(66,103,178,.50)
        TikTok - cross_media_campaign_daily_agg.cpc: rgba(0,0,0,.50)
        YouTube (DV360) - cross_media_campaign_daily_agg.cpc: rgba(255,0,0,.50)
        YouTube - cross_media_campaign_daily_agg.cpc: rgba(255,0,0,.50)
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
      row: 23
      col: 0
      width: 24
      height: 8
###############################################################################################
    - name: cpm_by_country
      title: Cost per Mille by Country
      explore: cross_media_campaign_daily_agg
      type: looker_column
      fields: [cross_media_campaign_daily_agg.source_system,
               cross_media_campaign_daily_agg.country_name,
               cross_media_campaign_daily_agg.cpm]
      pivots: [cross_media_campaign_daily_agg.source_system]
      sorts: [cross_media_campaign_daily_agg.source_system,
              cross_media_campaign_daily_agg.country_name]
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
      y_axes: [{label: '', orientation: left, series: [{axisId: cross_media_campaign_daily_agg.cpm,
              id: cross_media_campaign_daily_agg.cpm, name: CPM,}],
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
      row: 31
      col: 0
      width: 24
      height: 8
