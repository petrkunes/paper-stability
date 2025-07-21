#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                                 Setup project
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

# Run only once #

#--------------------------------------------------------------------------#
# Create a list of packages -----------------------------------------------
#--------------------------------------------------------------------------#

package_list <- c(
  "corrplot",
  "Hmisc",
  "ggplot2",
  "ggrepel",
  "openxlsx",
  "RColorBrewer",
  "readxl",
  "rioja",
  "tidypaleo",
  "tidyverse",
  "vegan"
)

#--------------------------------------------------------------------------#
# Install packages --------------------------------------------------------
#--------------------------------------------------------------------------#


install_packages <-
  function(pkgs_list) {
    # install all packages in the list from CRAN
    sapply(pkgs_list, utils::install.packages, character.only = TRUE)
    
    # install Github packages
    remotes::install_github("petrkunes/PolEco")
    remotes::install_github("nsj3/riojaPlot")
    remotes::install_github("gavinsimpson/ggvegan")
    remotes::install_github("HOPE-UIB-BIO/R-Ratepol-package")
  }

install_packages(package_list)
