#
# demo matrix profile
#
  library(tsmp)
  library(dplyr)
  library(ggplot2)
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
# taxi data from Numenta benchmark
#
  taxi_data <- 
    read.csv("nyc_taxi.csv", header = TRUE, stringsAsFactors = FALSE)
  taxi_series <- 
    taxi_data %>%
    filter(as.Date(timestamp) >= '2014-10-01') %>%
    filter(as.Date(timestamp) <= '2014-12-10')
  window_size <- 96
  taxi_matrix_profile <-
    tsmp(taxi_series[, 2], window_size = window_size, n_workers = 4)
  taxi_series <- 
    cbind(taxi_series[(window_size / 2):(nrow(taxi_series) - 
                                           window_size / 2), ],
          mp = taxi_matrix_profile$mp[, 1])
  taxi_series %>%
    mutate(timestamp = as.Date(timestamp)) %>%
    ggplot(aes(x = timestamp, y = mp, group = 1)) +
    geom_line()
    
  
  