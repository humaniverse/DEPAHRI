#' England DEPAHRI (Digital Exclusion and Physical Access to Healthcare Risk 
#' Index) Dataset
#'
#' A dataset mapping the difficulty of access to healthcare services, both 
#' physically and due to the risk of digital exclusion, across LSOAs in England.
#' 
#' The DEPAHRI Index is building on the ![DERI Index](https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/tree/main),
#' an index of risk of digital exclusion across England, Wales and Scotland.
#' Different DERI scores are calculated using the minimum and maximum values of 
#' indicators at different geographical levels. The DEPAHRI Index is calculated
#' using national minimum and maximum values, so it uses DERI scores at the 
#' national level.
#'
#' @format A tibble (data frame) with 32,844 rows and 7 variables:
#' \describe{
#'   \item{lsoa11_code}{LSOA code}
#'   \item{broadband_comp_national}{DERI Broadband component (national level)}
#'   \item{demography_comp_national}{DERI Demography component (national level)}
#'   \item{deprivation_comp_national}{DERI Deprivation component (national level)}
#'   \item{deri_score_england}{DERI score (national level)}
#'   \item{health_access_comp_national}{Health access component (national level)}
#'   \item{depahri_score_england}{DEPAHRI score (national level)}
#' }
#'
"england_lsoa_depahri"

#' Wales DEPAHRI (Digital Exclusion and Physical Access to Healthcare Risk 
#' Index) Dataset
#'
#' A dataset mapping the difficulty of access to healthcare services, both 
#' physically and due to the risk of digital exclusion, across LSOAs in Wales
#' 
#' The DEPAHRI Index is building on the ![DERI Index](https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/tree/main),
#' an index of risk of digital exclusion across England, Wales and Scotland.
#' Different DERI scores are calculated using the minimum and maximum values of 
#' indicators at different geographical levels. The DEPAHRI Index is calculated
#' using national minimum and maximum values, so it uses DERI scores at the 
#' national level.
#'
#' @format A tibble (data frame) with 1,909 rows and 7 variables:
#' \describe{
#'   \item{lsoa11_code}{LSOA code}
#'   \item{broadband_comp_national}{DERI Broadband component (national level)}
#'   \item{demography_comp_national}{DERI Demography component (national level)}
#'   \item{deprivation_comp_national}{DERI Deprivation component (national level)}
#'   \item{deri_score_england}{DERI score (national level)}
#'   \item{health_access_comp_national}{Health access component (national level)}
#'   \item{depahri_score_wales}{DEPAHRI score (national level)}
#' }
#' 
"wales_lsoa_depahri"

#' Scotland DEPAHRI (Digital Exclusion and Physical Access to Healthcare Risk 
#' Index) Dataset
#'
#' A dataset mapping the difficulty of access to healthcare services, both 
#' physically and due to the risk of digital exclusion, across Data Zones in 
#' Scotland - labelled LSOA's in this package for consistency with other nations
#' 
#' The DEPAHRI Index is building on the ![DERI Index](https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/tree/main),
#' an index of risk of digital exclusion across England, Wales and Scotland.
#' Different DERI scores are calculated using the minimum and maximum values of 
#' indicators at different geographical levels. The DEPAHRI Index is calculated
#' using national minimum and maximum values, so it uses DERI scores at the 
#' national level.
#'
#' @format A tibble (data frame) with 6,976 rows and 7 variables:
#' \describe{
#'   \item{lsoa11_code}{LSOA / DZ code}
#'   \item{broadband_comp_national}{DERI Broadband component (national level)}
#'   \item{demography_comp_national}{DERI Demography component (national level)}
#'   \item{deprivation_comp_national}{DERI Deprivation component (national level)}
#'   \item{deri_score_england}{DERI score (national level)}
#'   \item{health_access_comp_national}{Health access component (national level)}
#'   \item{depahri_score_scotland}{DEPAHRI score (national level)}
#' }
#' 
"scotland_lsoa_depahri"