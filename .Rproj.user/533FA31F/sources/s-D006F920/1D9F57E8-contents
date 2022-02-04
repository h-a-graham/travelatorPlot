source('density_function.R')
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
