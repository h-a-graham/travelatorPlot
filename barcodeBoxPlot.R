source('density_function.R')
#' Make a barcode/rug/travelator plot
#' @param .df A dataframe or tibble
#' @param .xcol The column name for the x axis
#' @param .ycol The column name for the y axis
#' @param .maxbins maximum number of bins that are allowed. the default (50) is usually more than enough.
#' @param .gapnudge change the travelator width
#' @param .alpharange vector length 2 between 0 and 1. The range of alpha t be used. Default is `c(0.1, 0.9)`
#' @return A ggplot object with the rug.
#' @example
#'
#' library(ggplot2)
#' library(palmerpenguins)
#' library(dplyr)
#` library(tidyr)

#` barcodeBoxPlot(penguins, species, bill_length_mm,
#`                .gapnudge=.38, .alpharange=c(0.1,.6)) +
#`   geom_boxplot(width = .15, outlier.shape = NA, fill=NA) +
#`   geom_point(size = 1.3, alpha=0.3, position = position_jitter(
#`     seed = 1, width = .07))

barcodeBoxPlot <- function(.df, .xcol, .ycol, .maxbins=50,
                           .gapnudge=.38, .alpharange=c(0.1,.9)){
  .xcol_en <- quo_name(enquo(.xcol))
  .ycol_en <- quo_name(enquo(.ycol))

  t <- density_function(.df, .xcol_en, .ycol_en,  .maxbins)

  p <- .df %>%
    ggplot(aes(x=as.numeric(as.factor(!!sym(.xcol_en))),
               y=!!sym(.ycol_en),
               group=as.numeric(as.factor(!!sym(.xcol_en))))) +
    geom_rect(data=t, aes(ymin = bin_val,
                  ymax = bin_max,
                  xmin = as.numeric(group_fct) - .gapnudge,
                  xmax = as.numeric(group_fct) + .gapnudge,
                  alpha=density,fill = group_fct), col = NA, inherit.aes = FALSE)+
    scale_alpha(range=.alpharange)+
    scale_x_continuous(labels = levels(t$group_fct),
                       breaks = 1:nlevels(t$group_fct)) +
    guides(alpha='none')
  p
}
