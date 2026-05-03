#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#                            Supplementary Material
#                      Table S2: Pollen assemblage zones
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

knitr::kable(CER_PAZ %>% select(name, old, young, duration),
             col.names = c("PAZ", "Old boundary [cal. years BP]", "Young boundary [cal. years BP]",
                           "Duration [years]"))