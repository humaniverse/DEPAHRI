# DEPAHRI utilities

library(tidyverse)
library(DEPAHRI)

# Returns LSOA/DZ scores with deciles/quintiles for a nation.
# nation: "england", "wales", "scotland"
load_depahri_scores <- function(nation = c("england", "wales", "scotland")) {
  nation <- match.arg(nation)
  df <- switch(nation,
    england = DEPAHRI::england_lsoa_depahri,
    wales   = DEPAHRI::wales_lsoa_depahri,
    scotland = DEPAHRI::scotland_lsoa_depahri
  )

  code_col <- if (nation == "scotland") "lsoa11_code" else "lsoa11_code"

  df |> 
    select(area_code = {{ code_col }}, score = depahri_score_national) |> 
    mutate(
      decile = ntile(score, 10),
      quintile = ntile(score, 5),
      worst_decile = decile == 10,
      worst_quintile = quintile == 5
    )
}
