#
# demo matrix profile
#
  library(tsmp)
  library(dplyr)
#
  time_series <- 
    read.csv("penguin_sample.csv", header = FALSE)
  time_series <- 
    as.numeric(time_series[1:40000, 1])
  time_matrix_profile <- 
    tsmp(time_series, window_size = 800) %>% 
    find_motif(n_motifs = 3) %>% 
    plot()
#
# taxi data from Numenta benchmark
#
  taxi_data <- 
    read.csv("nyc_taxi.csv", header = TRUE, stringsAsFactors = FALSE)
  taxi_series <- 
    taxi_data %>%
    filter(as.Date(timestamp) >= '2014-10-01') %>%
    filter(as.Date(timestamp) <= '2014-12-10')
  taxi_series <-
    as.numeric(taxi_series[, 2])
  taxi_matrix_profile <-
    tsmp(taxi_series, window_size = 96, n_workers = 4)
  
  
  