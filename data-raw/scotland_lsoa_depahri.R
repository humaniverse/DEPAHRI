library(tidyverse)
library(compositr)

devtools::load_all()

# ---- Digital exclusion ----
# Using the Digital Exclusion Risk Index from https://www.goodthingsfoundation.org/what-we-do/news/a-new-tool-in-your-toolbox-the-digital-exclusion-risk-index/
# Source: https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index

# DERI Scores are calculated using minimum and maximum values at different
# geographical levels (starting at version 1.4). We use scores based upon
# the maximum and minimum values within each nation.
scotland_lsoa_deri <- read_csv("https://raw.githubusercontent.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/main/Version%201.6/LSOA%20calculations%20and%20scores%20(nation%20level)_v1.6.csv") |>
  select(
    lsoa11_code = `LSOA code`,
    broadband_comp_national = `Broadband component (national)`,
    demography_comp_national = `Demography component (national)`,
    deprivation_comp_national = `Deprivation component (national, Scotland IMD)`,
    deri_score_national = `DERI score (national, Scotland IMD)`,
  ) |>
  filter(str_detect(lsoa11_code, "^S"))

# ---- Physical Access to Healthcare ----
# - Travel time to nearest GP surgery by public transport (minutes)
# - (No travel time to hospitals data)

# Technical notes of IMD indicators
# Page 52 https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/833951/IoD2019_Technical_Report.pdf
# A bespoke geographic information system application was used to calculate the road
# distance to the closest service from the population weighted centroid of each Output
# Area. To create an average road distance for the Lower-layer Super Output Area, a
# population-weighted mean of the Output Area road distances was used. Each Output Area
# score was weighted according to the proportion of the Lower-layer Super Output Area
# population that is within the Output Area, and the weighted scores summed. The Output
# Area level population estimates used for population-weighting were taken from mid-2017
# small area population estimates at Output Area level published by the Office for National
# Statistics.

# Access to services from Scottish IMD - we want travel time to GPs
# Source: https://statistics.gov.scot/data/scottish-index-of-multiple-deprivation---geographic-access-to-services-indicators
scotland_gp_access_raw <- read_csv("https://statistics.gov.scot/downloads/cube-table?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2Fscottish-index-of-multiple-deprivation---geographic-access-to-services-indicators")

scotland_gp_access <-
  scotland_gp_access_raw |>
  filter(DateCode == 2018) |>
  filter(Destination == "GP" & `Method of Travel` == "Public Transport") |>
  select(lsoa11_code = FeatureCode, gp_travel_time_minutes = Value)

scotland_lsoa_health_access <-
  scotland_gp_access |>
  # scale indicator from 0-10 using same min-max technique as DERI
  mutate(
    gp_travel_time_minutes_score = calculate_score(gp_travel_time_minutes)
  )

scotland_lsoa_health_access_component <-
  scotland_lsoa_health_access |>
  mutate(
    health_access_comp_national = gp_travel_time_minutes_score
  ) |>
  select(lsoa11_code, health_access_comp_national)

# ---- DEPAHRI ----
# Weighting of the components: DERI score is a measure of digital exclusion risk
# but also includes an important deprivation
scotland_lsoa_depahri <-
  scotland_lsoa_deri |>
  left_join(scotland_lsoa_health_access_component) |>
  mutate(
    depahri_score_national =
      broadband_comp_national * 0.25 +
        demography_comp_national * 0.25 +
        deprivation_comp_national * 0.25 +
        health_access_comp_national * 0.25
  )

usethis::use_data(scotland_lsoa_depahri, overwrite = TRUE)
