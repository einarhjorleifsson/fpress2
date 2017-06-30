#' @title HCR: Setup of weight error structure
#'
#' @description XXX
#'
#' @export
#'
#' @param d XXX
#' @param ctr XXX
#'
hcr_set_wgtErrors <- function(d,ctr)
{
  # Weight error - note for first year
  #                no cv in this implementation, need to be added
  # NOTE - same error is applied to all ages - should include an option
  #        for white noise accross ages.
  n_ages <- dim(d)[1]
  n_years  <- dim(d)[2]
  n_hrates <- dim(d)[3]
  n_iters  <- dim(d)[4]

  x <- array(rnorm(n_years * n_iters),
             dim=c(n_years,  n_iters))

  for (y in 2:n_years) x[y,] <- ctr$w_rho * x[y-1,] + sqrt(1 - ctr$w_rho^2) * x[y,]

  for (a in 1:n_ages) {
    for (h in 1:n_hrates) d[a,,h,] <- x * ctr$w_cv[a]
  }

  return(d)

}
