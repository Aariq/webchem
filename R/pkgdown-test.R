#' Testing testing \code{\link{testing}}
#'
#' This should break the pkgdown build (https://github.com/r-lib/pkgdown/issues/1351)
#'
#' @return an error
#' @export
#'
#' @examples
#' N()
N <- function() {
  stop("This should break the pkgdown build!")
}