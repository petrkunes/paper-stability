#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                        Figure 5: Correlation matrix
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

# pdf(file = "data_out/Fig_5.pdf", width = 6, height = 6)
ggcorrplot(CER_cor_lm_resid$r, hc.order = T, type = "lower", 
           p.mat = CER_cor_lm_resid$P, lab = T, insig = "blank",
           outline.color = "white", ggtheme = ggplot2::theme_void,
           legend.title = "Pearson's r",
           colors = c("#D55E00", "white", "#117733"))

# dev.off()