#' @title HCR recruitment model
#'
#' @description XXX
#'
#' @export
#'

#' @param ssb XXX
#' @param cv XXX
#' @param ctr XXX
#'
hcr_recruitment_model <- function (ssb, cv, ctr)
{
  rec <- switch(ctr$r_model,
                recruit1(ssb, ctr, cv),
                recruit2(ssb, ctr$ssb_break, ctr$r_mean, cv))
  return(rec)
}
