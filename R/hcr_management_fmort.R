#' @title F-based Harvest Control Rule
#'
#' @description The F-based rule is the conventional ICES decision rule. Here it
#' is implemented such that the TAC next year is calculated from the true
#' stock in numbers based on a fishing mortality that includes observation error.
#'
#' If the Btrigger is set in the rule (Btrigger > 0) then linear reductions of
#' fishing mortality is done relative to observed spawning stock biomass (i.e.
#' that includes observation errrors).
#'
#' @export
#'
#' @param y XXX
#' @param h XXX
#' @param hrate Harvest rate - with error
#' @param ssb Spawning stock biomass - with error
#' @param ctr Control file
#' @note Need to check is ssb-hat is calculated according to the correct delay
#' specification.
#'
#' To do: Modify function so that buffer is not active below Btrigger and
#' also include a TAC-constraint, either the
#' Icelandic type or the convention percentage contraint used in EU stocks.

hcr_management_fmort <- function(y,h,hrate,ssb,ctr)
{



  selF     <- X$selF[,y + ctr$delay,h,]
  selD     <- X$selD[,y + ctr$delay,h,]
  Na       <- X$N[,y + ctr$delay,h,]
  cWa      <- X$cW[,y + ctr$delay,h,]
  selF     <- X$selF[,y + ctr$delay,h,]
  selD     <- X$selD[,y + ctr$delay,h,]
  Ma       <- X$M[,y + ctr$delay,h,]

  # adjust harvest rate
  i <- ssb < ctr$b_trigger
  hrate[i] <- hrate[i] * ssb[i]/ctr$b_trigger

  Fa <- t(hrate * t(selF))
  Da <- t(hrate * t(selD))

  tac <- colSums(Na * Fa/(Fa + Da + Ma + 1e-05) *
                   (1 - exp(-(Fa + Da + Ma))) * cWa)

  X$TAC[y+1,h,] <<- tac

}
