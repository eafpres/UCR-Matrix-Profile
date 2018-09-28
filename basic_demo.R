#
# demo matrix profile
#
  library(tsmp)
  library(dplyr)
#
  time_series <- 
    read.csv("penguin_sample.csv", header = FALSE)
  time_series <- 
    as.numeric(time_series[1:8000, 1])
  time_matrix_profile <- 
    tsmp(time_series, window_size = 800, n_workers = 4) %>% 
    find_motif(n_motifs = 3) %>% 
    plot()
#