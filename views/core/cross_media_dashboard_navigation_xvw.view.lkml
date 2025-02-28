#########################################################{
# PURPOSE
# Dynamically generates html links (including filters) to support navigation between
# related cross media dashboards.
#
# SOURCE
# Extends View template_dashboard_navigation_ext
#
# REFERENCED BY
# Explore cross_media_campaign_daily_agg
#
# CUSTOMIZATIONS {
# While the extended template provided much of the logic needed, the following
# customizations were made in this extending view:
#
#   1. Updated dimension map_filter_numbers_to_dashboard_filter_names with:
#       - filter number-to-dashboard filter values as follows:
#           1   date
#           2   source
#           3   country
#           4   campaign
#           5   product
#           6   target_currency
#           7   funnel_level
#       - example syntax:
#             sql: "1|date||2|source||3|country||4|campaign||5|product||6|target_currency||7|funnel_level" ;;
#
#   2. Updated dash_bindings dimension to
#      list the filters used on the dashboard that should be passed between dashboards in the set:
#
#       dashboard name                    link text               filters used
#       ---------------                   --------------------    ----------
#       cross_media_1_overview              Overview                1,2,3,4,5,6,7
#       cross_media_2_campaigns             Campaigns               1,2,3,4,5,6,7
#       cross_media_3_countries             Countries               1,2,3,4,5,6,7
#       cross_media_4_detailed_performance  Detailed Performance    1,2,3,4,5,6,7
#
#       - example syntax:
#           "cross_media_1_overview|Overview|1,2,3||cross_media_2_campaign_line_items|Campaign Line Items|1,2,3||cross_media_3_audience_type|Audience Type|1,2,3"
#
#      Constants were used to define the dashboard ID, link text, and filter set for each dashboard to simplify the process of making changes.
#      These constants, with names that begin with "link_map_cross_media_dash_bindings_",  can be found in the manifest file.
#
#   3. Updated dimension parameter_navigation_focus_page to allow values 3 and 4
#
#   4. Updated hidden and label properties of filter1 to filter7. Also updated filter1 to use "type: date".
#
#   5. Added the view_label "@{label_view_for_dashboard_navigation}" to control how the fields are grouped and displayed in the Explore.
#
#}
#
# HOW TO USE FOR NAVIGATION {
#   1. Add to an Explore using a bare join
#         explore: cross_media_campaign_daily_agg {
#         join: cross_media_dashboard_navigation_xvw {
#           relationship: one_to_one
#           sql:  ;;
#           }}
#
#   2. Open the Explore and add "Dashboard Links" dimension to a Single Value Visualization.
#
#   3. Add these navigation parameters to visualization and set to desired values:
#         Navigation Style = Buttons (or if using LookML, buttons)
#         Navigation Focus Page = 1 (if adding to first dashboard listed, set to 2 if added viz to second dashboard)
#
#   4. Add navigation filters to the visualization. These filters will "listen" to the dashboard filters.
#
#   5. Add Visualization to dashboard and edit dashboard to pass the dashboard filters
#    to Filters 1 to N accordingly.
#
#    Alternatively, you can edit the dashboard LookML and the "listen" property as shown in
#    the LookML example below:
#       - name: dashboard_navigation
#         explore: cross_media_campaign_daily_agg
#         type: single_value
#         fields: [cross_media_dashboard_navigation_xvw.navigation_links]
#         filters:
#           cross_media_dashboard_navigation_xvw.parameter_navigation_focus_page: '1'
#           cross_media_dashboard_navigation_xvw.parameter_navigation_style: 'buttons'
#         show_single_value_title: false
#         show_comparison: false
#         listen:
#           date: cross_media_dashboard_navigation_xvw.filter1
#           source: cross_media_dashboard_navigation_xvw.filter2
#           country: cross_media_dashboard_navigation_xvw.filter3
#}
#########################################################}

  include: "/views/core/template_dashboard_navigation_ext.view"
  view: cross_media_dashboard_navigation_xvw {
    extends: [template_dashboard_navigation_ext]
    view_label: "@{label_view_for_dashboard_navigation}"

    dimension: map_filter_numbers_to_dashboard_filter_names {
      sql: "1|date||2|source||3|country||4|campaign||5|product||6|target_currency||7|funnel_level" ;;
      # sql: "1|date||2|business_unit||3|customer_type||4|customer_country" ;;
    }

#--> Used constants to define the dashboard id|link text|filter set for each dashboard. See manifest to make changes
    dimension: dash_bindings {
      hidden: yes
      type: string
      sql:    "@{link_map_cross_media_dash_bindings_overview}||@{link_map_cross_media_dash_bindings_campaigns}||@{link_map_cross_media_dash_bindings_countries}||@{link_map_cross_media_dash_bindings_detailed_performance}"
        ;;
    }
    # dimension: dash_bindings {
    #   hidden: yes
    #   type: string
    #   sql:    "cross_media_1_overview|Overview|1,2,3,4,5,6,7||cross_media_2_campaigns|Campaigns|1,2,3,4,5,6,7||cross_media_3_countries|Countries|1,2,3,4,5,6,7||cross_media_4_detailed_performance|Detailed Performance|1,2,3,4,5,6,7"
    #         ;;
    #   }

    parameter: parameter_navigation_focus_page {
      allowed_value: {value:"3"}
      allowed_value: {value:"4"}
    }

    filter: filter1 {
      type: date
      hidden: no
      label: "Date"
    }

    filter: filter2 { hidden: no label: "Media Platform"}
    filter: filter3 { hidden: no label: "Country"}
    filter: filter4 { hidden: no label: "Campaign"}
    filter: filter5 { hidden: no label: "Product"}
    filter: filter6 { hidden: no label: "Target Currency"}
    filter: filter7 { hidden: no label: "Funnel Level"}

  }
