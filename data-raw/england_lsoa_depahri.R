library(tidyverse)
library(compositr)
library(readxl)

# ---- Digital exclusion ----
# Using the Digital Exclusion Risk Index from https://www.goodthingsfoundation.org/what-we-do/news/a-new-tool-in-your-toolbox-the-digital-exclusion-risk-index/
# Source: https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index

# DERI Scores are calculated using minimum and maximum values at different
# geographical levels (starting at version 1.4). We use scores based upon 
# the maximum and minimum values within each nation.
england_lsoa_deri <- read_csv("https://raw.githubusercontent.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/main/Version%201.6/LSOA%20calculations%20and%20scores%20(nation%20level)_v1.6.csv") |>
  select(
    lsoa11_code = `LSOA code`,
    broadband_comp_national = `Broadband component (national)`,
    demography_comp_national = `Demography component (national)`,
    deprivation_comp_national = `Deprivation component (national, England IMD)`,
    deri_score_england = `DERI score (national, England IMD)`,
  ) |> 
  filter(str_detect(lsoa11_code, "^E"))

# ---- Physical Access to Healthcare ----
# - Road distance to GP surgery
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

# Data source: https://www.gov.uk/government/statistics/english-indices-of-deprivation-2019
# File 8 on this landing page
tf <- download_file(
  "https://assets.publishing.service.gov.uk/government/uploads/system/uploads/attachment_data/file/833992/File_8_-_IoD2019_Underlying_Indicators.xlsx",
  "xlxs"
)

england_imd_indicators <- read_excel(tf, sheet = "IoD2019 Barriers Domain")

england_gp_access <- england_imd_indicators |>
  select(
    lsoa11_code = "LSOA code (2011)",
    gp_dist_km = "Road distance to a GP surgery indicator (km)"
  )

england_hospital_access <- read_csv("https://raw.githubusercontent.com/britishredcrosssociety/covid-19-vulnerability/master/data/hospital-data/nearest-hospitals-LSOA.csv")

england_hospital_access <-
  england_hospital_access |>
  mutate(mean_distance_nearest_three_hospitals_km = mean_distance_nearest_three_hospitals / 1000) |>
  distinct(
    lsoa11_code = lsoa11cd,
    mean_distance_nearest_three_hospitals_km
  ) |>
  filter(str_detect(lsoa11_code, "^E"))

england_lsoa_health_access <-
  england_gp_access |>
  left_join(england_hospital_access) |> 
  # scale both indicators from 0-10 using same min-max technique as DERI
  mutate()
  
  
# **then use these scaled indicators to create a new component: health_access_comp**

# ---- DEPAHRI ----

# **create england_lsoa_depahri by joining england_lsoa_deri & england_lsoa_health_access**
# **create DEPAHRI by using weighted average of all 4 components**

usethis::use_data(england_lsoa_depahri, overwrite = TRUE)
