#test_that("use", {
 # expect_output(hello(), "Hello, world!")
#})

testthat::expect_output(hello(), "Hello, world!")

#testthat::expect_equal(mean_calc(c(1, 2, 3, 4, 5)))
#testthat::quasi_label(quo = (expect), expected.label, arg = "expected")

test_that(expect_equal(mean_calc(c(1,2,3,4,5))))

testthat::expect_equal(mean_calc(c(1,2,3,4,5)))
testthat::quasi_label(quo = 3, labels, arg = "expected")

testthat::quasi_label(quo = expect, labels, arg = expected)
rlang::quo_is_missing(quo)
rlang::abort(message = message)

#testthat::expect_equal(median_calc(c(1, 2, 3, 4, 5)))
#testthat::quasi_label(quo = (expect), expected.label, arg = "expected")




