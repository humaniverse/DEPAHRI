#' Calculate indicator scores following DERI methodology
#'
#' As explained in the [DERI Score Methodology](https://github.com/GreaterManchesterODA/Digital-Exclusion-Risk-Index/blob/main/Version%201.0/DERI%20Score%20Methodology_v1.0.md):
#'
#' "For the DERI, the score for each indicator in each LSOA is given as a number
#' between 0 and 10, where 10 indicates a higher level of digital exclusion
#' risk. The score for each indicator aimed to show how far between the minimum
#' and maximum indicator values the individual indicator value was for each LSOA
#' located. This gives a value between 0 (the LSOA has the smallest indicator
#' value, therefore indicating low risk) to 10 (the LSOA has the highest
#' indicator value, therefore indicating high risk)."
#'
#' The calculation used for each indicator (i) and each LSOA (j) in each
#' district (k) is:
#'
#' - For indicators for which higher value indicates higher risk:
#'   10 x ((Value of indicator i for LSOA j in district k) -
#'         (Minimum value of indicator i across all LSOAs in district k)) /
#'        ((Maximum value of i across all LSOAs in district k) -
#'         (Minimum value of i across all LSOAs in district k))
#'
#' - For indicators for which higher value indicates lower risk:
#'   10 x ((Maximum value of indicator i across all LSOAs in district k) -
#'         (Value of indicator i for LSOA j in district k)) /
#'        ((Maximum value of i across all LSOAs in district k) -
#'         (Minimum value of i across all LSOAs in district k))
#'
#' As a result, the direction of the scale of data inputted by the function
#' does not necessarily match that of the data outputted, for which higher
#' values will always mean high risk.
#'
#' @param var Vector containing the indicator to be scored (e.g., gp_dist_km)
#' @param inverse Default is TRUE. Set as FALSE if higher value of the indicator
#'        indicates lower risk
#'
#' @export
calculate_score <-
  function(var,
           inverse = FALSE) {
    max_val <- max(var, na.rm = TRUE)
    min_val <- min(var, na.rm = TRUE)

    if (inverse) {
      score <- 10 * (max_val - var) / (max_val - min_val)
    } else {
      score <- 10 * (var - min_val) / (max_val - min_val)
    }

    return(score)
  }
