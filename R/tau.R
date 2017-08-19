#' Kendall \eqn{\tau} Rank Correlation Coefficients
#'
#' \code{tau} is the rank correlation coefficient by Kendall, where neither vector can contain tied
#' items. \code{tau_a} and \code{tau_b} are the versions developed to cope with ties under the
#' scenarios of accuracy and agreement, respectively. See the references for details.
#'
#' @param x a numeric vector. In \code{tau_a} this is the vector of true scores.
#' @param y a numeric vector of the same length as \code{x}. In \code{tau_a} this is the vector of
#'   estimated scores.
#'
#' @return The correlation coefficient.
#' @references M.G. Kendall (1948). Rank Correlation Methods. Charles Griffin & Company
#'   Limited.
#' @seealso \code{\link{tauAP}} for AP correlation coefficients.
#' @examples
#' # No ties
#' x <- c(0.67, 0.45, 0.29, 0.12, 0.57, 0.24, 0.94, 0.75, 0.08, 0.54)
#' y <- c(0.48, 0.68, 0.32, 0.09, 0.06, 0.61, 0.87, 0.22, 0.44, 0.84)
#' tau(x, y)
#' tau_a(x,y) # same as tau
#' tau_b(x,y) # same as tau
#'
#' # Ties in y
#' y <- round(y, 1)
#' tau_a(x, y)
#' tau_b(x, y)
#'
#' # Ties in x too
#' x <- round(x, 1)
#' tau_b(x, y)
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
