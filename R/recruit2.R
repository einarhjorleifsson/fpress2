#' @title Bootstrap model
#'
#' @description Just a dummy for now
#'
#' @export
#'
#' @param ssb XXX
#' @param ssbcut XXX
#' @param recmean XXX
#' @param rdev XXX
recruit2 <- function (ssb, ssbcut, recmean, rdev) {
  rec <- ifelse(ssb >= ssbcut, 1, ssb/ssbcut) * recmean * rdev
  return(rec)
}
