#' @title Observation error model
#'
#' @description XXX
#'
#' @export
#'
#' @param y XXX
#' @param h XXX
#' @param Fmult XXX
#' @param ctr XXX


hcr_observation_error <- function(y, h, Fmult,ctr) {

  hrate <- ctr$HRATE[h]
  delay <- ctr$delay

  assError <- X$assError[ y + delay, h,]

  N   <-    X$N[,y + delay, h,]
  bW  <-   X$bW[,y + delay, h,]
  sB  <- X$selB[,y + delay, h,]
  bio <- colSums(N * bW * sB)

  sW  <-   X$sW[,y + delay ,h,]
  xN  <-  X$mat[,y + delay, h,]
  M   <-    X$M[,y + delay, h,]
  pF  <-   X$pF[,y + delay, h,]
  pM  <-   X$pM[,y + delay, h,]
  selF <- X$selF[, y + delay, h,]
  selD <- X$selD[, y + delay, h,]

  totalF <- t(Fmult * t(selF))

  dF <- t(Fmult * t(selD))

  ssb <- colSums(N * exp( -( pM * M + pF * (totalF + dF))) * xN * sW)

  n_iters <- ctr$iter
  hrate    <- rep(hrate, n_iters)

  ## A. The assessment error model
  if (ctr$a_error == 1) {
    bio_hat     <- bio   * ctr$a_bias * exp(assError)
    ssb_hat     <- ssb   * ctr$a_bias * exp(assError)
    hrate_hat   <- hrate * ctr$a_bias * exp(assError)
  }

  if (ctr$a_error == 2) {
    bio_hat     <- bio   * ctr$a_bias * (1 + assError)
    ssb_hat     <- ssb   * ctr$a_bias * (1 + assError)
    hrate_hat   <- hrate * ctr$a_bias * (1 + assError)
  }

  return(list(hrate=hrate_hat,bio=bio_hat,ssb=ssb_hat))
}
