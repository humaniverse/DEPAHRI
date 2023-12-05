# pkgload::load_all(".")

# ---- England LSOA DEPAHRI ----
england_lsoa11_codes_path <-
  system.file(
    "extdata", "england_lsoa11_codes.csv",
    package = "DEPAHRI", mustWork = TRUE
  )
england_lsoa11_codes <- read.csv(england_lsoa11_codes_path)

# Test class
expect_equal(
  class(england_lsoa_depahri)[1],
  "tbl_df"
)

# Test dimensions: 32844 LSOAs, and 7 columns
expect_equal(
  dim(england_lsoa_depahri),
  c(32844, 7)
)

# Test LSOA codes
expect_equal(
  class(england_lsoa_depahri$lsoa11_code),
  "character"
)

expect_equal(
  sort(england_lsoa_depahri$lsoa11_code),
  sort(england_lsoa11_codes$lsoa11_code)
)

# Test other columns
for (col in colnames(england_lsoa_depahri)[-1]) {
  # col <- "broadband_comp_national"
  # class
  expect_equal(
    class(england_lsoa_depahri[[col]]),
    "numeric"
  )
  # included in [0; 10]
  expect_true(all(
    england_lsoa_depahri[[col]] >= 0 &
      england_lsoa_depahri[[col]] <= 10,
    na.rm = TRUE
  ))
}

# Test for NAs
expect_false(any(is.na(england_lsoa_depahri)))

# ---- Wales LSOA DEPAHRI ----
wales_lsoa11_codes_path <-
  system.file(
    "extdata", "wales_lsoa11_codes.csv",
    package = "DEPAHRI", mustWork = TRUE
  )
wales_lsoa11_codes <- read.csv(wales_lsoa11_codes_path)

# Test class
expect_equal(
  class(wales_lsoa_depahri)[1],
  "tbl_df"
)

# Test dimensions: 1909 LSOAs, and 7 columns
expect_equal(
  dim(wales_lsoa_depahri),
  c(1909, 7)
)

# Test LSOA codes
expect_equal(
  class(wales_lsoa_depahri$lsoa11_code),
  "character"
)

expect_equal(
  sort(wales_lsoa_depahri$lsoa11_code),
  sort(wales_lsoa11_codes$lsoa11_code)
)

# Test other columns
for (col in colnames(wales_lsoa_depahri)[-1]) {
  # col <- "broadband_comp_national"
  # class
  expect_equal(
    class(wales_lsoa_depahri[[col]]),
    "numeric"
  )
  # included in [0; 10]
  expect_true(all(
    wales_lsoa_depahri[[col]] >= 0 &
      wales_lsoa_depahri[[col]] <= 10,
    na.rm = TRUE
  ))
}

# Test for NAs
expect_false(any(is.na(wales_lsoa_depahri)))

# ---- Scotland LSOA DEPAHRI ----
scotland_dz11_codes_path <-
  system.file(
    "extdata", "scotland_dz11_codes.csv",
    package = "DEPAHRI", mustWork = TRUE
  )
scotland_dz11_codes <- read.csv(scotland_dz11_codes_path)

# Test class
expect_equal(
  class(scotland_lsoa_depahri)[1],
  "tbl_df"
)

# Test dimensions: 6976 DZs, and 7 columns
expect_equal(
  dim(scotland_lsoa_depahri),
  c(6976, 7)
)

# Test LSOA codes
expect_equal(
  class(scotland_lsoa_depahri$lsoa11_code),
  "character"
)

expect_equal(
  sort(scotland_lsoa_depahri$lsoa11_code),
  sort(scotland_dz11_codes$dz11_code)
)

# Test other columns
for (col in colnames(scotland_lsoa_depahri)[-1]) {
  # col <- "broadband_comp_national"
  # class
  expect_equal(
    class(scotland_lsoa_depahri[[col]]),
    "numeric"
  )
  # included in [0; 10]
  expect_true(all(
    scotland_lsoa_depahri[[col]] >= 0 &
      scotland_lsoa_depahri[[col]] <= 10,
    na.rm = TRUE
  ))
}

# Test for NAs
expect_false(any(is.na(scotland_lsoa_depahri)))
