elevator rug box plot thing…
================

Here’s an example of what it does…

``` r
#load packages
library(palmerpenguins)
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggdist)
#load functions
source('barcodeBoxPlot.R')
# make the plot
barcodeBoxPlot(penguins, species, bill_length_mm,
                    .gapnudge=.38, .alpharange=c(0.1,.6)) +
  theme_light()+
  labs(x='Species', y='Bill Length (mm)') +
  guides(fill="none", alpha='none')+
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))+
  scale_fill_brewer(palette = 'Dark2')+
  ggdist::stat_halfeye(adjust = .5, width = .3, .width = 0, justification = -.4,
    point_colour = 'NA', slab_fill=NA, slab_colour='black', slab_alpha = .3,
    slab_size=0.4) +
  geom_boxplot(width = .15, outlier.shape = NA, fill=NA) +
  geom_point(size = 1.3, alpha=0.3, position = position_jitter(
    seed = 1, width = .07)) +
  coord_cartesian(xlim = c(0.6, NA), clip = "off")
```

![](man/figures/penguins-1.png)<!-- -->
