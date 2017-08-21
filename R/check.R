#' Check Arguments to Correlation Functions
#'
#' These are auxiliary functions to check that two variables are of the correct type to compute
#' correlation coefficients. If they are not, the execution is \code{\link{stop}}ped.
#'
#' \itemize{
#'   \item \code{check_types}: both \code{x} and \code{y} are numeric vectors of the same length.
#'   \item \code{check} : \code{check_types} and neither \code{x} nor \code{y} contains ties.
#'   \item \code{check_a}: \code{check_types} and \code{x} does not contain ties.
#'   \item \code{check_b}: same as \code{check_types}.
#' }
#'
#' @param x the first argument.
#' @param y the second argument.
#'
#' @return Nothing, called for its side effect.
#' @noRd
check_types <- function(x, y) {
  if(!is.numeric(x) || !is.atomic(x) || !is.vector(x))
    stop("'x' must be a numeric vector", call. = FALSE)
  if(!is.numeric(y) || !is.atomic(y) || !is.vector(y))
    stop("'y' must be a numeric vector", call. = FALSE)
  if(length(x) != length(y))
    stop("'x' and 'y' must be of the same length", call. = FALSE)
}

has.ties <- function(x) {
  length(x) != length(table(x))
}

#' @rdname check_types
check <- function(x, y) {
  check_types(x,y)

  if(has.ties(x))
    stop("'x' contains ties.", call. = FALSE)
  if(has.ties(y))
    stop("'y' contains ties.", call. = FALSE)
}

#' @rdname check_types
check_a <- function(x, y) {
  check_types(x, y)
  if(has.ties(x))
    stop("'x' contains ties.", call. = FALSE)
}

#' @rdname check_types
check_b <- function(x, y) {
  check_types(x, y)
}

