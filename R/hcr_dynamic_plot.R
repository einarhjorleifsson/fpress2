#' @title XXX
#'
#' @description XXX
#'
#' @export
#'
#' @param df data.frame, normally generated via function hcr_summarise_data
hcr_dynamic_plot <- function(df) {

  # dummy
  summarise <- value <- year <- q05 <- q10 <- q25 <- q50 <- q75 <- q90 <- q95 <- NA
  dyn <- reshape2::melt(df,id.vars = c("year"))
  dyn <- plyr::ddply(dyn,c("year","variable"),summarise,
                     q05=quantile(value,0.05),
                     q10=quantile(value,0.10),
                     q25=quantile(value,0.25),
                     q50=quantile(value,0.50),
                     q75=quantile(value,0.75),
                     q90=quantile(value,0.90),
                     q95=quantile(value,0.95),
                     m=mean(value))
  dyn_plot <- ggplot2::ggplot(dyn,ggplot2::aes(year)) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin=q05,ymax=q95),fill="red",alpha=0.2) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin=q10,ymax=q90),fill="red",alpha=0.2) +
    ggplot2::geom_ribbon(ggplot2::aes(ymin=q25,ymax=q75),fill="red",alpha=0.2) +
    ggplot2::geom_line(ggplot2::aes(y=q50),col="red") +
    ggplot2::geom_line(ggplot2::aes(y=m),col="blue") +
    ggplot2::facet_wrap(~ variable,scales="free_y") +
    ggplot2::labs(x="",y="")
  return(list(data=dyn,ggplot=dyn_plot))
}
