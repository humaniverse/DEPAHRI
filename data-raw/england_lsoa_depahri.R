library(tidyverse)

# ---- Digital exclusion ----
# Using the Digital Exclusion Risk Index from https://www.goodthingsfoundation.org/what-we-do/news/a-new-tool-in-your-toolbox-the-digital-exclusion-risk-index/
# Source: https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index

# DERI Scores are calculated using minimum and maximum values at different
# geographical levels (starting at version 1.4). We use scores based upon 
# the maximum and minimum values within each nation.
england_deri <- read_csv("https://raw.githubusercontent.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/main/Version%201.6/LSOA%20calculations%20and%20scores%20(nation%20level)_v1.6.csv") |>
  select(
    lsoa11_code = `LSOA code`,
    broadband_comp_national = `Broadband component (national)`,
    demography_comp_national = `Demography component (national)`,
    deprivation_comp_naitonal = `Deprivation component (national, England IMD)`,
    deri_score_england = `DERI score (national, England IMD)`,
  ) |> 
  filter(str_detect(lsoa11_code, "^E"))


usethis::use_data(england_lsoa_depahri, overwrite = TRUE)
