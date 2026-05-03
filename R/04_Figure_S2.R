#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#                            Supplementary Material
#                        Figure S2: Correlation of trees
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

ggcorrplot(CER_cor_spe$r, p.mat = CER_cor_spe$P,  hc.order = T, type = "lower",
           lab = T, insig = "blank",
           outline.color = "white", ggtheme = ggplot2::theme_void,
           legend.title = "Pearson's r",
           colors = c("#D55E00", "white", "#117733"))
