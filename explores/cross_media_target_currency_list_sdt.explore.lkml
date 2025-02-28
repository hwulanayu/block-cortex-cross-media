#########################################################{
# PURPOSE
# Hidden Explore used as suggest dimension for
# parameter_target_currency and dashboard filter
#
# SOURCE
#   view: cross_media_target_currency_list_sdt
#
# REFERENCED BY
#   View cross_media_common_parameters_xvw
#   LookML Dashboard template_cross_media
#
#########################################################}

include: "/views/core/cross_media_target_currency_list_sdt.view"

explore: cross_media_target_currency_list_sdt {
  hidden: yes
}
