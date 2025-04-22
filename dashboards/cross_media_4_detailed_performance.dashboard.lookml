#########################################################{
# Cross Media Detailed Performance dashboard provides
# performance at the campaign and country level
#
# Extends template_cross_media and modifies:
#   dashboard_navigation to set parameter_navigation_focus_page: '4'
#
# Visualization Elements:
#   detailed_performance - table
#########################################################}

- dashboard: cross_media_4_detailed_performance
  title:  Cross Media Detailed Performance
  description: "All performance metrics and spend by campaign in tabular format"
  extends: template_cross_media
  crossfilter_enabled: false

  elements:
  - name: dashboard_navigation
    filters:
      cross_media_dashboard_navigation_xvw.parameter_navigation_focus_page: 4
###############################################################################################
  - name: detailed_performance
    title: Detailed Performance
    explore: cross_media_campaign_daily_agg
    type: looker_grid
    fields: [
             cross_media_campaign_daily_agg.campaign_id,
             cross_media_campaign_daily_agg.source_system_in_color,
             cross_media_campaign_daily_agg.campaign_name_in_source_color,
             cross_media_campaign_dates_ndt.report_date_range,
             cross_media_campaign_daily_agg.product_hierarchy_path,
             cross_media_campaign_daily_agg.country_name,
             cross_media_campaign_daily_agg.total_impressions,
             cross_media_campaign_daily_agg.cpm,
             cross_media_campaign_daily_agg.total_clicks,
             cross_media_campaign_daily_agg.cpc,
             cross_media_campaign_daily_agg.ctr,
             cross_media_campaign_daily_agg.total_cost_in_target_currency]
    sorts: [cross_media_campaign_daily_agg.campaign_name_in_source_color,
            cross_media_campaign_daily_agg.source_system_in_color]
    limit: 100
    show_row_numbers: true
    truncate_text: false
    truncate_header: false
    size_to_fit: false
    table_theme: white
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    minimum_column_width: 75
    series_labels:
      cross_media_campaign_daily_agg.source_system_in_color: Media Platform
      cross_media_campaign_daily_agg.campaign_name_in_source_color: Campaign Name
      cross_media_campaign_daily_agg.total_impressions: Impressions
      cross_media_campaign_daily_agg.total_clicks: Clicks
    series_column_widths:
      cross_media_campaign_daily_agg.campaign_name_in_source_color: 215
      cross_media_campaign_daily_agg.report_date_range: 200
      cross_media_campaign_daily_agg.product_hierarchy_path: 150
      cross_media_campaign_daily_agg.total_impressions: 85
      cross_media_campaign_daily_agg.total_cost_in_target_currency: 85
      cross_media_campaign_daily_agg.cpm: 75
      cross_media_campaign_daily_agg.cpc: 75
      cross_media_campaign_daily_agg.ctr: 75
    series_text_format:
      cross_media_campaign_daily_agg.total_impressions:
        align: right
      cross_media_campaign_daily_agg.cpm:
        align: right
      cross_media_campaign_daily_agg.total_clicks:
        align: right
      cross_media_campaign_daily_agg.cpc:
        align: right
      cross_media_campaign_daily_agg.ctr:
        align: right
      cross_media_campaign_daily_agg.total_cost_in_target_currency:
        align: right
    series_cell_visualizations:
      cross_media_campaign_daily_agg.total_impressions:
        is_active: false
    note_state: collapsed
    note_display: below
    note_text: |-
      <div style=text-align:left;font-size:11px;color:#808080;">
        Limited to 100 campaigns/countries. To change, click the three-dot menu at the top right of tile
      and select 'Explore from here'. Edit row limit in the Data pane.
      </div>
    listen:
      date: cross_media_campaign_daily_agg.report_date
      source: cross_media_campaign_daily_agg.source_system
      country: cross_media_campaign_daily_agg.country_name
      campaign: cross_media_campaign_daily_agg.campaign_name
      product: cross_media_campaign_daily_agg.filter_product_name
      target_currency: cross_media_campaign_daily_agg.parameter_target_currency
      funnel_level: cross_media_campaign_daily_agg.funnel_level
    row: 2
    col: 0
    width: 24
    height: 10
