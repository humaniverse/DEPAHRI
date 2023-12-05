library(tidyverse)
library(statswalesr)

devtools::load_all()

# ---- Digital exclusion ----
# Using the Digital Exclusion Risk Index from https://www.goodthingsfoundation.org/what-we-do/news/a-new-tool-in-your-toolbox-the-digital-exclusion-risk-index/
# Source: https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index

# DERI Scores are calculated using minimum and maximum values at different
# geographical levels (starting at version 1.4). We use scores based upon
# the maximum and minimum values within each nation.
wales_lsoa_deri <- read_csv("https://raw.githubusercontent.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/main/Version%201.6/LSOA%20calculations%20and%20scores%20(nation%20level)_v1.6.csv") |>
  select(
    lsoa11_code = `LSOA code`,
    broadband_comp_national = `Broadband component (national)`,
    demography_comp_national = `Demography component (national)`,
    deprivation_comp_national = `Deprivation component (national, Wales IMD)`,
    deri_score_national = `DERI score (national, Wales IMD)`,
  ) |>
  filter(str_detect(lsoa11_code, "^W"))

# ---- Physical Access to Healthcare ----
# - Average return travel time to a GP surgery by public transport
# - Average road distance to nearest three hospitals

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
wales_gp_access_raw <- statswales_get_dataset("wimd1909")

wales_gp_access <-
  wales_gp_access_raw |>
  as_tibble() |>
  filter(Indicator_ItemName_ENG == "Average public return travel time to a GP surgery (minutes)") |>
  filter(LSOA_Code != "Wales") |>
  select(lsoa11_code = LSOA_Code, gp_travel_time_minutes = Data)

wales_hospital_access <- read_csv("https://raw.githubusercontent.com/britishredcrosssociety/covid-19-vulnerability/master/data/hospital-data/nearest-hospitals-LSOA.csv")

wales_hospital_access <-
  wales_hospital_access |>
  mutate(mean_distance_nearest_three_hospitals_km = mean_distance_nearest_three_hospitals / 1000) |>
  distinct(
    lsoa11_code = lsoa11cd,
    mean_distance_nearest_three_hospitals_km
  ) |>
  filter(str_detect(lsoa11_code, "^W"))

wales_lsoa_health_access <-
  wales_gp_access |>
  left_join(wales_hospital_access) |>
  # scale both indicators from 0-10 using same min-max technique as DERI
  mutate(
    gp_travel_time_minutes_score = calculate_score(gp_travel_time_minutes),
    mean_distance_nearest_three_hospitals_km_score = calculate_score(mean_distance_nearest_three_hospitals_km)
  )

wales_lsoa_health_access_component <-
  wales_lsoa_health_access |>
  # weighted both indicators equally for the component
  mutate(health_access_comp_national = 
           gp_travel_time_minutes_score * 0.5 + 
           mean_distance_nearest_three_hospitals_km_score * 0.5) |>
  select(lsoa11_code, health_access_comp_national)

# ---- DEPAHRI ----
# Weighting of the components justification in README
wales_lsoa_depahri <-
  wales_lsoa_deri |> 
  left_join(wales_lsoa_health_access_component) |> 
  mutate(depahri_score_national = 
           broadband_comp_national * 0.25 +
           demography_comp_national * 0.25 +
           deprivation_comp_national * 0.25 +
           health_access_comp_national * 0.25)

usethis::use_data(wales_lsoa_depahri, overwrite = TRUE)
