#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                        Calculation of rate of change
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

# Calculates separately the pollen-based rate of change
# The result is saved in a data file and loaded back in 00_Main_calculations.R

# Calculate Rate of Change ----

CER_ROC <- estimate_roc(
  data_source_community = CER_pollen_w,
  data_source_age = CER_age,
  smooth_method = "shep",
  smooth_age_range = 500,
  dissimilarity_coefficient = "chisq",
  standardise = TRUE,
  n_individuals = 500,
  rand = 1000,
  use_parallel = TRUE,
  working_units = "levels"
)

saveRDS(CER_ROC, file = "data_out/CER_ROC.rds")
