
#########################################################{
# PURPOSE
# Ranks campaigns for a source system by min report date and campaign.
# Used to filter the number of campaigns displayed per media platform
# in the cross_media_2_campaigns dashboard
#
# SOURCES
#   Explore cross_media_campaign_daily_agg
#
# REFERENCED BY
#   Explore cross_media_campaign_daily_agg
#
# NOTES
# - Uses Bind All Filters to match the filters selected
# - Only the fields defined in the set report_date_fields are shown in the Explore
#   cross_media_campaign_daily_agg.

#########################################################}

  include: "/explores/cross_media_campaign_daily_agg.explore.lkml"

  view: cross_media_campaign_ranks_ndt {
    derived_table: {
      explore_source: cross_media_campaign_daily_agg {
        column: campaign_id {}
        column: source_system {}
        column: min_report_date {}
        column: max_report_date {}
        derived_column: rank_by_date {
          sql: RANK() over (PARTITION BY source_system ORDER BY min_report_date, campaign_id) ;;
        }
      bind_all_filters: yes
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

    dimension: rank_by_date {
      type: number
      label: "Campaign Rank by Date"
      description: "Rank of campaign for a media platform sorted by minimum report date and campaign id"
      sql: ${TABLE}.rank_by_date ;;
    }

    dimension: is_within_campaign_limit {
      type: yesno
      description: "Yes if campaign ranking by minimum report date is less than or equal to the parameter Campaign Limit per Media Platform"
      sql: ${rank_by_date} <= ${cross_media_campaign_daily_agg.selected_campaign_limit} ;;
    }

    set: report_date_fields {
      fields: [rank_by_date, is_within_campaign_limit]
    }
  }
