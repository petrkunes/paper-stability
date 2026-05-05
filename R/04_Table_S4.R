#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#                            Supplementary Material
#                      Table S4: RDA explained variance
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

knitr::kable(
data.frame(
  Term       = rownames(CER.RDA.anova),
  Variance   = round(CER.RDA.anova$Variance, 3),
  Proportion = round(CER.RDA.anova$Variance / CER.rda$tot.chi, 3),
  F_stat     = round(CER.RDA.anova$F, 3),
  p_value    = CER.RDA.anova$`Pr(>F)`
)
)
