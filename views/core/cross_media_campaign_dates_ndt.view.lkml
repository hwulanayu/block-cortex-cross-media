#########################################################{
# PURPOSE
# Finds the minimum and maximum report dates for a source_system and campaign
# and returns as dimensions. These dimensions are used in the calendar chart (i.e., timeline)
# found in LookML dashboard cross_media_2_campaigns.
#
# SOURCES
#   Explore cross_media_campaign_daily_agg
#
# REFERENCED BY
#   Explore cross_media_campaign_daily_agg
#
# NOTES
# - Does not use any Bind Filters in order to ensure the complete reporting range
#   for a campaign is found.
# - Only the fields defined in the set report_date_fields are shown in the Explore
#   cross_media_campaign_daily_agg.
# - The timeline chart currently displays the full range between the
#   first and last reporting date of a given campaign, regardless of
#   whether the campaign runs on consecutive days or the campaign is complete.
#   For example, a Saturday campaign in March will show the entire range
#   from the first to the last Saturday of that month.
#########################################################}

include: "/explores/cross_media_campaign_daily_agg.explore.lkml"

view: cross_media_campaign_dates_ndt {
  derived_table: {
    explore_source: cross_media_campaign_daily_agg {
      column: campaign_id {}
      column: source_system {}
      column: min_report_date {}
      column: max_report_date {}
      }
    }

    dimension: key {
      hidden: yes
      primary_key: yes
      sql: CONCAT(${source_system},${campaign_id}) ;;
    }

    dimension: source_system {
      type: string
      label: "Media Platform"
      description: "Source system. Either GoogleAds, Meta, TikTok or YouTube (DV360)"
    }

    dimension: campaign_id {
      type: string
      description: "ID of campaign from media platform"
    }

    dimension: min_report_date {
      type: date
      description: "Earliest report date of campaign"
    }

    dimension: max_report_date {
      type: date
      description: "Latest report date of campaign"
    }

    dimension: report_date_range {
      type: string
      description: "Display a campaign's reporting date range as \"[min report date] to [max report date]\""
      sql: CONCAT(${min_report_date},' to ',${max_report_date}) ;;
    }

    set: report_date_fields {
      fields: [min_report_date, max_report_date, report_date_range]
    }
  }
