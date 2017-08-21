#' AP Rank Correlation Coefficients
#'
#' \code{tauAP} is the AP rank correlation coefficient by Yilmaz et al., where neither vector can
#' contain tied items. \code{tauAP_a} and \code{tauAP_b} are the versions developed by Urbano and
#' Marrero to cope with ties under the scenarios of accuracy and agreement, respectively. See the
#' references for details.
#'
#' Note that the sorting order is decreasing by default, as should be for instance if the scores
#' represent the effectiveness of systems. When the sorting order is ascending, as is for instance when the vectors represent ranks, the parameter
#' \code{decreasing} must be set to \code{FALSE}.
#'
#' @param x a numeric vector. In \code{tauAP_a} this is the vector of true scores.
#' @param y a numeric vector of the same length as \code{x}. In \code{tauAP_a} this is the vector of
#'   estimated scores.
#' @param decreasing logical. Should the sort order be increasing or decreasing (default)?
#'
#' @return The correlation coefficient.
#' @references E. Yilmaz, J.A. Aslam and S. Robertson (2008). A New Rank Correlation Coefficient for
#'   Information Retrieval. ACM SIGIR.
#'
#'   J. Urbano and M. Marrero (2017). The Treatment of Ties in AP Correlation. ACM ICTIR.
#' @seealso \code{\link{tau}} for Kendall correlation coefficients.
#' @examples
#' # No ties
#' x <- c(0.67, 0.45, 0.29, 0.12, 0.57, 0.24, 0.94, 0.75, 0.08, 0.54)
#' y <- c(0.48, 0.68, 0.32, 0.09, 0.06, 0.61, 0.87, 0.22, 0.44, 0.84)
#' tauAP(x, y)
#' tauAP_a(x,y) # same as tauAP
#'
#' # Ties in y
#' y <- round(y, 1)
#' tauAP_a(x, y)
#' tauAP_b(x, y)
#'
#' # Ties in x too
#' x <- round(x, 1)
#' tauAP_b(x, y)
#'
#' # Set decreasing to FALSE when x and y already represent ranks
#' x <- rank(-x)
#' y <- rank(-y)
#' tauAP_b(x, y, FALSE) # same as above
#' @export
tauAP <- function(x, y, decreasing = TRUE) {
  check(x, y)

  if(decreasing)
    return(tauAP(-x, -y, decreasing = FALSE))

  n <- length(x)
  rx <- rank(x)
  ry <- rank(y)

  numerator <- 0
  for(i in seq(1, n-1)) {
    for(j in seq(i+1, n)) {
      sx <- sign(x[i] - x[j])
      sy <- sign(y[i] - y[j])

      if(sx == sy)
        # since we don't traverse in sorted order, divide by the max rank
        numerator <- numerator + 1 / ( max(ry[i], ry[j]) -1 )
    }
  }
  2* numerator / (n-1) -1
}

#' @rdname tauAP
#' @export
tauAP_a <- function(x, y, decreasing = TRUE) {
  check_a(x, y)

  if(decreasing)
    return(tauAP_a(-x, -y, decreasing = FALSE))

  n <- length(x)
  rx <- rank(x)
  ry <- rank(y, ties.method = "first")

  p <- rank(y, ties.method = "min")
  t <- sapply(p, function(pp) sum(p == pp))

  c_all <- 0
  # term I: concordants above the group
  for(i in which(p != 1)) { # ignore first item('s group)
    c_above <- 0
    for(j in which(p < p[i])) {
      sx <- sign(rx[i] - rx[j])
      sy <- sign(ry[i] - ry[j])

      if(sx == sy)
        c_above <- c_above +1
    }
    s_above <- sum( 1 / (p[i] + seq(t[i]) -2) / t[i] )

    c_all <- c_all + c_above * s_above
  }
  # term II: concordants within the group across permutations
  for(i in seq_along(p)) {
    c_within <- 0
    for(k in seq(length.out = t[i]-1))
      c_within <- c_within + k / (p[i] + k -1)
    c_within <- c_within / 2 / t[i]

    c_all <- c_all + c_within
  }
  2 / (n-1) * c_all -1
}

#' @rdname tauAP
#' @export
tauAP_b <- function(x, y, decreasing = TRUE) {
  check_b(x, y)

  if(decreasing)
    return(tauAP_b(-x, -y, decreasing = FALSE))

  (tauAP_b_ties(x,y) + tauAP_b_ties(y,x)) / 2
}

#' Asymetric tauAP_b
#' @noRd
tauAP_b_ties <- function(x, y) {
  n <- length(x)
  rx <- rank(x)
  ry <- rank(y, ties.method = "first")

  p <- rank(y, ties.method = "min")

  c_all <- 0
  not_top <- which(p != 1)
  for(i in not_top) { # ignore the first item('s group)
    # count concordants above the pivot's tie group
    c_above <- 0
    for(j in which(p < p[i])) {
      sx <- sign(rx[i] - rx[j])
      sy <- sign(ry[i] - ry[j])

      if(sx == sy)
        c_above <- c_above +1
    }
    c_all <- c_all + c_above / (p[i]-1) # divide by p-1 instead of i-1
  }
  2 / length(not_top) * c_all -1
}
