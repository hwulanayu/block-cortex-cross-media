named_value_format: positive_m_or_k {
  value_format: "[>=1000000]0.0,,\"M\";[>=1000]0.0,\"K\";0"
  strict_value_format: yes
}

named_value_format: positive_usd_m_or_k {
  value_format: "[>=1000000]$0.0,,\"M\";[>=1000]$0.0,\"K\";$0"
  strict_value_format: yes
}

named_value_format: usd_three_decimal {
  value_format: "$0.000"
  strict_value_format: yes
}
