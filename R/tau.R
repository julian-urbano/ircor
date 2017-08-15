#' Kendall \eqn{\tau} Rank Correlation Coefficients
#'
#' @param x a numeric vector. When applicable, this is the vector of true scores.
#' @param y a numeric vector of the same length as \code{x}. When applicable, this is the vector of
#'   estimated scores.
#'
#' @return The correlation coefficient.
#' @references M.G. Kendall (1948). Rank Correlation Methods (4th ed.). Charles Griffin & Company
#'   Limited.
#' @examples
#' @seealso \code{\link{tauAP}} for AP correlation coefficients.
#' @export
tau <- function(x, y) {
  check(x, y)

  n <- length(x)
  numerator <- 0
  for(i in seq(1, n-1)) {
    for(j in seq(i+1, n)) {
      sx <- sign(x[i] - x[j])
      sy <- sign(y[i] - y[j])

      numerator <- numerator + sx * sy
    }
  }
  nn <- n*(n-1)/2
  numerator / nn
}

#' @rdname tau
#' @export
tau_a <- function(x, y) {
  check_a(x, y)

  n <- length(x)
  numerator <- 0
  for(i in seq(1, n-1)) {
    for(j in seq(i+1, n)) {
      sx <- sign(x[i] - x[j])
      sy <- sign(y[i] - y[j])

      numerator <- numerator + sx * sy
    }
  }
  nn <- n*(n-1)/2
  numerator / nn
}

#' @rdname tau
#' @export
tau_b <- function(x, y) {
  check_b(x, y)

  n <- length(x)
  numerator <- 0
  tx <- ty <- 0
  for(i in seq(1, n-1)) {
    for(j in seq(i+1, n)) {
      sx <- sign(x[i] - x[j])
      sy <- sign(y[i] - y[j])

      numerator <- numerator + sx * sy
      if(sx == 0)
        tx <- tx +1
      if(sy == 0)
        ty <- ty +1
    }
  }
  nn <- n*(n-1)/2
  numerator / sqrt(nn-tx) / sqrt(nn-ty)
}
