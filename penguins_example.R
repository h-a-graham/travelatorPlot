library(palmerpenguins)
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggdist)
#load functions
source('barcodeBoxPlot.R')

# exports folder
if (!dir.exists('exports')) dir.create('exports')

# The obvious option...
penguins %>%
  ggplot(aes(x=species, y=bill_length_mm, fill=species)) +
  geom_boxplot() +
  scale_fill_brewer(palette = 'Dark2') +
  geom_jitter() +
  theme_minimal()

# build base plot with the barcode
p <- barcodeBoxPlot(penguins, species, bill_length_mm,
                    .gapnudge=.35, .alpharange=c(0.1,1)) +
  theme_light()+
  labs(x='Species', y='Bill Length (mm)') +
  guides(fill="none", alpha='none')+
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))+
  scale_fill_brewer(palette = 'Dark2')
p
# with violin plot overlay
p  +
  geom_jitter(alpha=0.3) +
  geom_violin(fill=NA,
              scale='count')

ggsave('exports/bill_length_mm.png', width=8.47, height=7.47)

# with raincloud overlay
p +
  ggdist::stat_halfeye(adjust = .3, width = .3, .width = 0, justification = -.3,
    point_colour = 'NA', slab_fill=NA, slab_colour='black',
    slab_size=0.4) +
  # ggdist::stat_gradientinterval(width=5)+
  geom_boxplot(width = .15, outlier.shape = NA, fill=NA) +
  ggdist::stat_dots(
    side = "left",
    dotsize = .8,
    justification = 1.15,
    binwidth = .3,
    colour='black'
  ) +
  # geom_point(size = 1.3, alpha=0.3, position = position_jitter(
  #   seed = 1, width = .07)) +
  coord_cartesian(xlim = c(0.6, NA), clip = "off")

ggsave('exports/bill_length_mm2.png', width=8.47, height=7.47)

# the right way:
penguins %>%
  ggplot(aes(x = species, y = bill_length_mm, fill = species)) +
  stat_gradientinterval(adjust=0.7,position = "dodge", colour=NA, width=0.9) +
  theme_light()+
  labs(x='Species', y='Bill Length (mm)') +
  guides(fill="none", alpha='none')+
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))+
  scale_fill_brewer(palette = 'Dark2') +
  ggdist::stat_halfeye(adjust = .3, width = .3, .width = 0, justification = -.3,
                       point_colour = 'NA', slab_fill=NA, slab_colour='black',
                       slab_size=0.7) +
  geom_boxplot(width = .15, outlier.shape = NA, fill=NA) +
  ggdist::stat_dots(
    side = "left",
    dotsize = .8,
    justification = 1.15,
    binwidth = .3,
    colour='black'
  ) +
  coord_cartesian(xlim = c(1, NA), clip = "off")

ggsave('exports/bill_length_mm3.png', width=8.47, height=7.47)



penguins %>%
  ggplot(aes(x = species, y = bill_length_mm, fill = species)) +
  stat_gradientinterval(aes(fill=stat(pdf)),position = "dodge", colour=NA,
                        width=0.6, slab_type='pdf', fill_type = "gradient") +
  scale_fill_gradientn(colours=viridisLite::mako(255))+
  theme_light()+
  labs(x='Species', y='Bill Length (mm)') +
  guides(fill="none", alpha='none')+
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))+
  ggdist::stat_halfeye(adjust = .5, width = .2, .width = 0, justification = -.1,
                       point_colour = 'NA', slab_fill=NA, slab_colour='black',
                       slab_size=0.7, fill=NA, lwd=0.5) +
  geom_boxplot(width = .15, outlier.shape = NA, fill=NA,
               position = position_nudge(x = -0.1)) +
  coord_cartesian(xlim = c(1, NA), clip = "off")

ggsave('exports/bill_length_mm4.png', width=8.47, height=7.47)


# extras




p2 <- barcodeBoxPlot(iris, Species, Sepal.Width,
                    .gapnudge=.38, .alpharange=c(0.1,.6)) +
  theme_light()+
  labs(x='Species', y='Sepal Width (mm)') +
  guides(fill="none", alpha='none')+
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))+
  scale_fill_brewer(palette = 'Dark2')

p2 +
  ggdist::stat_halfeye(adjust = .5, width = .3, .width = 0, justification = -.4,
                       point_colour = 'NA', slab_fill=NA, slab_colour='black', slab_alpha = .3,
                       slab_size=0.4) +
  geom_boxplot(width = .15, outlier.shape = NA, fill=NA) +
  geom_point(size = 1.3, alpha=0.3, position = position_jitter(
    seed = 1, width = .07)) +
  coord_cartesian(xlim = c(0.6, NA), clip = "off")

barcodeBoxPlot(penguins, species, bill_length_mm,
                     .gapnudge=.38, .alpharange=c(0.1,.6)) +
  geom_boxplot(width = .15, outlier.shape = NA, fill=NA) +
  geom_point(size = 1.3, alpha=0.3, position = position_jitter(
    seed = 1, width = .07))

