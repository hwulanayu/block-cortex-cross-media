#########################################################{
# PURPOSE
# UNNESTED view of array product_hierarchy_texts found in cross_media_campaign_daily_agg view.
# Provides all product names along a hierarchy with which a campaign is associated.
#
# PRODUCT MATCH
# Each campaign has gone through semantic matching with a Vertex AI text
# generation model to match textual representations of Media Campaigns
# with a single Product Hierarchy node stored in array product_hierarchy_texts.
#
# For example, a campaign named "Plain & Simple - Classic Carbonated Drinks" matches to
# the product hierarchy array ['Beverages', 'Carbonated Drink', 'Soda'].
#
# This view unnests the array product_hierarchy_texts into the dimensions
# product_name and product_level (starting with 0):
#     product_level     product_name
#     0                 Beverages
#     1                 Carbonated Drink
#     2                 Soda
#
# SOURCES
#   Refines View cross_media_campaign_daily_agg__product_hierarchy_texts
#
# REFERENCED BY
#   View cross_media_campaign_daily_agg_rfn
#   Explore cross_media_campaign_daily_agg
#
# NOTES
# - Fields hidden by default. Update field's 'hidden' property to show/hide.
# - Full suggestions set to yes so that filter suggestions populate properly for nested fields.
#
#########################################################}

include: "/views/base/cross_media_campaign_daily_agg__product_hierarchy_texts.view"

view: +cross_media_campaign_daily_agg__product_hierarchy_texts {
  fields_hidden_by_default: yes

  dimension: key {
    primary_key: yes
    sql: CONCAT(${cross_media_campaign_daily_agg.key},${cross_media_campaign_daily_agg__product_hierarchy_texts} ;;
  }

  dimension: product_name {
    hidden: no
    type: string
    group_label: "All Product Hierarchy Levels"
    description: "This field allows you to analyze campaign performance following a hierarchial structure. For instance, a search for a broad term like 'Cosmetics' returns all campaigns associated with that product category and its subcategories. More specific searches, like 'Gel,' narrow down the results to campaigns with that precise branch of the hierarchy ('Cosmetics --> Nail Polish --> Gel'). Searching for 'Nail Polish' returns all nail polishes, including subcategories like 'Gel'."
    sql: ${cross_media_campaign_daily_agg__product_hierarchy_texts} ;;
    full_suggestions: yes
  }

  dimension: product_level {
    hidden: no
    type: number
    group_label: "All Product Hierarchy Levels"
    description: "Returns all product hierarchy levels associated with a campaign."
    sql: product_hierarchy_texts_offset ;;
    full_suggestions: yes
  }

 }
