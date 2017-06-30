#' @title HCR: Setup of recruitment error structure
#'
#' @description Each iter has own cv and rho
#'
#' @export
#'
#' @param d XXX
#' @param ctr XXX
#'
hcr_set_recErrors2 <- function(d,ctr)
{

  n_years  <- dim(d)[1]
  n_hrates <- dim(d)[2]
  n_iters  <- dim(d)[3]

  # Recruitment: cv & autocorrelation
  x <- array(rnorm(n_years * n_iters),
             dim=c(n_years , n_iters))

  for (y in 2:n_years) x[y,] <- ctr$ssb_pars$r_rho * x[y-1,] + sqrt(1 - ctr$ssb_pars$r_rho^2) * x[y,]

  x <- exp(x*ctr$ssb_pars$r_cv)
  for (h in 1:n_hrates) d[,h,] <- x

  return(d)
}
