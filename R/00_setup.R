
#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                                  Setup file
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#


#--------------------------------------------------------------------------#
# Load packages -----------------------------------------------------------
#--------------------------------------------------------------------------#

package_list <- c(
  "car",
  "corrplot",
  "Hmisc",
  "ggcorrplot",
  "ggplot2",
  "ggrepel",
  "ggvegan",
  "mvgam",
  "nlme",
  "openxlsx",
  "PolEco",
  "RColorBrewer",
  "readxl",
  "rioja",
  "riojaPlot",
  "rbacon",
  "RRatepol",
  "tidypaleo",
  "tidyverse",
  "vegan"
)

sapply(package_list, library, character.only = TRUE)

rm(package_list)
