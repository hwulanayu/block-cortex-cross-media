#########################################################{
# The Cross Media template defines the following elements
# shared across cross media-related dashboards:
#
#  - Filters including default values:
#       date
#       funnel_level
#       source
#       country
#       campaign
#       product
#       target_currency
#
#  - Visualization Elements:
#       dashboard_navigation - appears at top with URL links to other dashboards
#
# This template must be EXTENDED into other dashboards and
# filters/elements can be modified further as necessary
#########################################################}

- dashboard: template_cross_media
  title: Cross Media Dashboard Template
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  filters_location_top: true
  description: "Template which defines core filters and elements used in Cross Media dashboards."
###############################################################################################
  filters:
  - name: date
    title: Date
    type: date_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: day_range_picker
      display: inline

  - name: funnel_level
    title: Funnel Level
    type: field_filter
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    explore: cross_media_campaign_daily_agg
    field: cross_media_campaign_daily_agg.funnel_level

  - name: source
    title: Media Platform
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: inline
    explore: cross_media_campaign_daily_agg
    field: cross_media_campaign_daily_agg.source_system
    listens_to_filters: [funnel_level]

  - name: country
    title: Country Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    explore: cross_media_campaign_daily_agg
    field: cross_media_campaign_daily_agg.country_name
    listens_to_filters: [funnel_level, source, campaign]

  - name: campaign
    title: Campaign Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    explore: cross_media_campaign_daily_agg
    field: cross_media_campaign_daily_agg.campaign_name
    listens_to_filters: [funnel_level, source, country]

  - name: product
    title: Product Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    explore: cross_media_campaign_daily_agg
    field: cross_media_campaign_daily_agg.filter_product_name
    listens_to_filters: [funnel_level, source, campaign, country]

  - name: target_currency
    title: Target Currency
    type: field_filter
    # default_value: "{{ _user_attributes['cortex_cross_media_default_currency'] }}"
    default_value: USD
    allow_multiple_values: false
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
    # explore: currency_conversion
    # field: currency_conversion.to_currency
    explore: cross_media_target_currency_list_sdt
    field: cross_media_target_currency_list_sdt.target_currency
###############################################################################################
  elements:
  - name: dashboard_navigation
    type: single_value
    explore: cross_media_campaign_daily_agg
    fields: [cross_media_dashboard_navigation_xvw.navigation_links]
    filters:
      cross_media_dashboard_navigation_xvw.parameter_navigation_focus_page: '1'
      cross_media_dashboard_navigation_xvw.parameter_navigation_style: 'buttons'
    show_single_value_title: false
    listen:
      date: cross_media_dashboard_navigation_xvw.filter1
      source: cross_media_dashboard_navigation_xvw.filter2
      country: cross_media_dashboard_navigation_xvw.filter3
      campaign: cross_media_dashboard_navigation_xvw.filter4
      product: cross_media_dashboard_navigation_xvw.filter5
      target_currency: cross_media_dashboard_navigation_xvw.filter6
      funnel_level: cross_media_dashboard_navigation_xvw.filter7
    row: 0
    col: 0
    width: 24
    height: 1
