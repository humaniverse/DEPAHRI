# pkgload::load_all(".")

# Test case 1: Normal case with default settings
var <- c(1, 3, 5, 7, 9)
expected_output <- c(0, 2.5, 5, 7.5, 10)  # Replace with expected output values
output <- calculate_score(var)

expect_equal(output, expected_output)

# Test case 2: Case with inverse set to TRUE
var_inverse <- c(1, 3, 5, 7, 9)
expected_output_inverse <- c(10, 7.5, 5, 2.5, 0)  # Replace with expected output values
output_inverse <- calculate_score(var, inverse = TRUE)

expect_equal(output_inverse, expected_output_inverse)

# Test case 3: Edge case with an empty vector
var_empty <- numeric(0)
expect_error(calculate_score(var_empty), "Input vector is empty")

# Test case 4: Edge case with a vector containing only one element
var_single <- c(5)
expect_error(calculate_score(var_single), "Input vector has only one element")

# Test case 5: Case with a vector containing NAs
var_with_na <- c(1, 3, NA, 7, 9)
expected_output_with_na <- c(0, 2.5, NA, 7.5, 10)  # Replace with expected output values
output_with_na <- calculate_score(var_with_na)

expect_equal(output_with_na, expected_output_with_na)

# Test case 6: Case with a vector where all values are equal
var_all_equal <- c(3, 3, 3, 3, 3)
expect_error(calculate_score(var_all_equal), "All values in the input vector are equal")


