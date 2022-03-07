library(nflreadr)
library(tidyverse)

set.seed(2022)

histo_combines <- load_combine() %>% filter(season != 2022 & !is.na(forty))

n <- 300

boot_means = rep(NA, 10000)

for(i in 1:10000){
  boot_sample <-  sample_n(histo_combines, n, replace = TRUE)
  boot_means[i] <-  mean(boot_sample$forty)
}

summary(boot_means)

hist(boot_means)

bm_mean <- boot_means %>% mean()
bm_sd <- boot_means %>% sd()

comb_22_z <- (4.71 - bm_mean)/bm_sd

pnorm(comb_22_z, bm_mean, bm_sd)
