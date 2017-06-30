#' @title hcr_recruitment_model2
#'
#' @description Model to predict the recruitment. Here for mcmc frames
#'
#' NOTE: Only ricker model and vs. one or the other of segreg or bevholt
#' reccv
#' @export
#'
#' @param ssb The true spawning stock biomass
#' @param reccv XXX
#' @param ctr The control file, containing the parameters
hcr_recruitment_model2 <- function(ssb,reccv,ctr)
{
  #nsamp <- ctr$iter
  #fit <- ctr$ssb_pars
  #pR <- t(sapply(seq(nsamp), function(j) exp(match.fun(fit $ model[j]) (fit[j,], ssb)) ))
  #return(pR)
  #hcr_recruitment_model <- function(ssb,ctr)
  #{

  #fit <- ctr$ssb_pars
  #rec <- ifelse(fit$model %in% "segreg",
  #              exp(log(ifelse(ssb >= fit$b,fit$a*fit$b,fit$a*ssb))) * reccv,
  #              exp(log(fit$a) + log(ssb) - fit$b * ssb) * reccv)
  #return(rec)
  ssb <- ssb * 1e6
  rec <- rep(-1,length(ssb))
  fit <- ctr$ssb_pars

  # NOTE: Could use the functions in fishvise
  i <- fit$model == "segreg"
  if(any(i)) rec[i] <- fit$a[i]*(ssb[i]+sqrt(fit$b[i]^2+0.001)-sqrt((ssb[i]-fit$b[i])^2+0.001)) * reccv[i]

  i <- fit$model == "ricker"
  if(any(i)) rec[i] <- fit$a[i] * ssb[i] * exp(-fit$b[i] * ssb[i]) * reccv[i]

  i <- fit$model == "bevholt"
  if(any(i)) rec[i] <- fit$a[i] * ssb[i] /(fit$b[i] + ssb[i]) * reccv[i]

  return(rec/1e6)

}
