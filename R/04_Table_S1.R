knitr::kable(CER_PAZ %>% select(name, old, young, duration),
             col.names = c("PAZ", "Old boundary [cal. years BP]", "Young boundary [cal. years BP]",
                           "Duration [years]"))