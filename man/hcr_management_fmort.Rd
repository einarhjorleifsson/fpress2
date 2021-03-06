% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hcr_management_fmort.R
\name{hcr_management_fmort}
\alias{hcr_management_fmort}
\title{F-based Harvest Control Rule}
\usage{
hcr_management_fmort(y, h, hrate, ssb, ctr)
}
\arguments{
\item{y}{XXX}

\item{h}{XXX}

\item{hrate}{Harvest rate - with error}

\item{ssb}{Spawning stock biomass - with error}

\item{ctr}{Control file}
}
\description{
The F-based rule is the conventional ICES decision rule. Here it
is implemented such that the TAC next year is calculated from the true
stock in numbers based on a fishing mortality that includes observation error.

If the Btrigger is set in the rule (Btrigger > 0) then linear reductions of
fishing mortality is done relative to observed spawning stock biomass (i.e.
that includes observation errrors).
}
\note{
Need to check is ssb-hat is calculated according to the correct delay
specification.

To do: Modify function so that buffer is not active below Btrigger and
also include a TAC-constraint, either the
Icelandic type or the convention percentage contraint used in EU stocks.
}
