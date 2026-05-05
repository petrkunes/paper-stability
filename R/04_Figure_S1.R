#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#                            Supplementary Material
#                        Figure S1: Ordination diagram
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

# pdf(file = "data_out/Fig_S1.pdf", 8, 8)

ggplot() + 
  geom_point(data = CER_spec_scores, aes(x=rda1, y=rda2), color = "#117733", size = 2) +
  geom_text_repel(data = CER_spec_scores, aes(x = rda1, y = rda2, label = label), color = "#117733", size = 5) +
  geom_segment(data = CER_env_scores, aes(x = 0, y = 0, xend = rda1, yend = rda2),
               arrow = arrow(length = unit(0.2, "cm")), color = "#D55E00") +
  geom_text_repel(data = CER_env_scores, aes(x = rda1, y = rda2, label = label), color = "#D55E00", size = 5) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "darkgray") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "darkgray") +
  theme_classic() +
  theme(
    panel.border = element_rect(color = "black", fill = NA, linewidth = 1), 
    axis.line = element_blank(),
    axis.text = element_text(size = 10)
  ) +
  labs(x = "RDA1", y = "RDA2")

# dev.off()

