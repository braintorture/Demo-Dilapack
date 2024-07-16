#' Prints 'Hello, world!'
#' @export

hello <- function() {
  print("Hello, world!")
}

#' Calculate Mean
#'
#' This function calculates the mean of a numeric vector.
#' @param x A numeric vector.
#' @return The mean of the vector.
#' @examples
#' mean_calc(c(1, 2, 3, 4, 5))
#' @export
mean_calc <- function(x) {
  return(mean(x))
}

#' Calculate Median
#'
#' This function calculates the median of a numeric vector.
#' @param x A numeric vector.
#' @return The median of the vector.
#' @examples
#' median_calc(c(1, 2, 3, 4, 5))
#' @export
median_calc <- function(x) {
  return(median(x))
}



