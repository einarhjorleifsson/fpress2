#' @title XXX
#'
#' @description XXX
#'
#' @export
#'
#' @param X XXX
#' @param ctr Control file
hcr_summarise_data <- function(X, ctr) {
  sY <- reshape2::melt(colSums(X$C * X$cW))
  sS <- reshape2::melt(colSums(X$N * exp(- (X$pM * X$M + X$pF * X$tF)) * X$sW * X$mat))
  sB <- reshape2::melt(colSums(X$N * X$bW * X$selB))
  R <- reshape2::melt(drop(X$N[1,,,]))
  Fbar <- reshape2::melt(colMeans(X$tF[(ctr$f1+1):(ctr$f2+1),,,]))
  d <- data.frame(year=sY$year,iter=sY$iter,target=sY$hrate,
                  r=R$value,
                  bio=sB$value,
                  ssb=sS$value,
                  f=Fbar$value,
                  hr=sY$value/sB$value,
                  yield=sY$value)
  return(d)
}
