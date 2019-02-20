# The current function  is to substring the Event to different levels

substr_EventLR <- function(df.in) {
  df.out <- {
    df.in %>% 
      mutate(
        Hemisphere = ifelse(substr(EventLR, 1, 1) == "L", "left", ifelse(substr(EventLR, 1, 1) == "R", "right", NA)), 
        Hemisphere = as.factor(Hemisphere),
        Event = substring(EventLR, 2)
        ) %>% 
          substr_Event()
  }
  return(df.out)
}


substr_Event <- function(df.in) {
  df.out <- {
    df.in %>% 
      mutate(
        NS = ifelse(substr(Event, 1, 1) == "N", "normal", ifelse(substr(Event, 1, 1) == "S", "scrambled", NA)),
        FH = ifelse(substr(Event, 2, 2) == "F", "face", ifelse(substr(Event, 2, 2) == "H", "house", NA)),
        Duration = ifelse(substr(Event, 3, 3) == "7", 17, 
                          ifelse(substr(Event, 3, 3) == "5", 50, 
                                 ifelse(substr(Event, 3, 3) == "1", 100, 
                                        ifelse(substr(Event, 3, 3) == "2", 200, NaN)))),
        NS = as.factor(NS), 
        FH = as.factor(FH),
        Duration = as.factor(Duration)
      )
  }
  return(df.out)
}