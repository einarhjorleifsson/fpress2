#' @title Hockey stick recruitment model
#'
#' @description XXX
#'
#' @export
#'
#' @param ssb XXX
#' @param ctr XXX
#' @param reccv XXX
recruit1 <- function (ssb, ctr, reccv)
{
  rec <- ifelse(ssb >= ctr$ssb_break, 1, ssb/ctr$ssb_break) * ctr$r_mean * reccv
  rec <- rec/exp(ctr$r_cv^2/2)
  return(rec)
}
