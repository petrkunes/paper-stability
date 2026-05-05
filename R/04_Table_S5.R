#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#                            Supplementary Material
#                Table S5: RDA explained variance individual vars
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

knitr::kable(
data.frame(
  Term       = rownames(CER.RDA.anova.var),
  Variance   = round(CER.RDA.anova.var$Variance, 3),
  Proportion = round(CER.RDA.anova.var$Variance / CER.rda$tot.chi, 3),
  F_stat     = round(CER.RDA.anova.var$F, 3),
  p_value    = CER.RDA.anova.var$`Pr(>F)`
)
)