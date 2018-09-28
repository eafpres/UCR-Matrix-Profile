#
# demo matrix profile
#
  library(tsmp)
  library(dplyr)
  library(ggplot2)
  library(ggthemes)
  library(gridExtra)
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
  P1 <- taxi_series %>%
    ggplot(aes(x = timestamp, y = mp, group = 1)) +
    geom_line() +
    scale_x_discrete("", 
                     breaks = c('2014-10-01 23:30:00',
                                '2014-11-01 00:00:00',
                                '2014-12-01 00:00:00'),
                     labels = c('10/1/14', '11/1/14', '12/1/14')) +
    ylab("Matrix Profile\n") +
    labs(title = "Matrix Profile and Raw Taxi Data") +
    labs(subtitle = "data: https://github.com/numenta/NAB/tree/master/data") +
    theme_economist() +
    theme(axis.title = element_text(size = 14)) +
    theme(axis.text = element_text(size = 12)) +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(plot.subtitle = element_text(hjust = 0.5)) + 
    annotate(geom = "text", x = '2014-10-13 12:00:00', y = 2.6, 
             label = "Columbus Day", 
             size = 3, color = "red", hjust = 0.5) +
    annotate(geom = "text", x = '2014-11-01 12:00:00', y = 4.9, 
             label = paste0("double count due to\n",
                            "end of Daylight Time"), 
             size = 3, color = "red", hjust = 0.5) +
    annotate(geom = "text", x = '2014-11-27 12:00:00', y = 5.7, 
             label = "Thanksgiving   ", 
             size = 3, color = "red", hjust = 1)
  P2 <- taxi_series %>%
    ggplot(aes(x = timestamp, y = value / 10000, group = 1)) +
    geom_line() +
    scale_x_discrete("", 
                     breaks = c('2014-10-01 23:30:00',
                                '2014-11-01 00:00:00',
                                '2014-12-01 00:00:00'),
                     labels = c('10/1/14', '11/1/14', '12/1/14')) +
    ylab("Taxi Activity\n") +
    theme_economist() +
    theme(axis.title = element_text(size = 14)) +
    theme(axis.text = element_text(size = 12))
  grid.arrange(P1, P2, ncol = 1)
