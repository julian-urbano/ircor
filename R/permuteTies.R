#' Permutations of Rankings With Ties
#'
#' Generates all the permutations of a vector of ranks, by permuting the ranks of all tied items.
#'
#' @param x a numeric vector.
#' @param decreasing logical. Should the sort order be increasing or decreasing (default)?
#'
#' @return A list with all the permuted rankings.
#' @noRd
permuteTies <- function(x, decreasing = TRUE) {
  if(decreasing)
    x <- -x

  ranks <- rank(x, ties.method = "first") # each group contains all integral ranks to permute
  groups <- rank(x, ties.method = "min") # each group contains only the 1st rank within the group
  doPermuteTies(ranks, groups)
}

#' Recursive Generation of Permuted Rankings
#'
#' This function computes recursively the list of all permutations of a given ranking.
#'
#' @param ranks integral ranks of pending items.
#' @param groups tied-ranks (non-integral) of the pending items.
#' @param prev ranks given to the previous items.
#' @param l list to collect all permutations.
#'
#' @return A list with all the permuted rankings.
#' @noRd
doPermuteTies <- function(ranks, groups,  prev = numeric(0), l = list()){
  if(length(ranks) == 1) {
    # only one item remaining. Concatenate and add
    l <- append(l, list( c(prev, ranks) ))
  } else {
    # work out the next item. Obtain tied items and their ranks
    sameGroup <- which(groups == groups[1])
    groupRanks <- ranks[sameGroup]
    # recursively process the rest, rotating items within the same group
    for(i in seq_along(sameGroup)) {
      ranks2 <- ranks[-1]
      ranks2[sameGroup[-1]-1] <- groupRanks[-i]
      groups2 <- groups[-1]
      prev2 <- c(prev, groupRanks[i])
      l <- doPermuteTies(ranks2, groups2, prev2, l)
    }
  }
  l
}
