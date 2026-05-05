#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                        Figure 2: Pollen percentage diagram
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#


# pdf(file = "data_out/Fig_2.pdf", width = 10, height = 7)
CER_groups <- tilia_ecog(CER_EPD, list("TRSH", "DWAR", "HERB"), list("pollen")) %>%
  mutate(Group = replace(Group, Group == "DWAR", "HERB")) %>%
  mutate(Group = replace(Group, Name == "Secale cereale" | Name == "Triticum-type" | Name == "Hordeum-type" | Name == "Cannabis sativa" | Name == "Juglans", "INDP")) %>%
  mutate(Group = replace(Group, Name == "Ambrosia" | Name == "Centaurea cyanus-type" | Name == "Plantago lanceolata-type" | Name == "Plantago media" |
                           Name == "Ranunculus arvensis-type" | Name == "Rumex acetosa-type" | Name == "Urtica" | Name == "Chenopodiaceae/Amaranthaceae" |
                           Name == "Polygonum aviculare-type" | Name == "Spergula arvensis-type" | Name == "Trifolium repens-type" | Name == "Calluna vulgaris" | Name == "Melampyrum", "INDS")) %>%
  mutate(Group = replace(Group, Group == "TRSH", "Arboreal")) %>%
  mutate(Group = replace(Group, Group == "HERB", "Other NAP")) %>%
  mutate(Group = replace(Group, Group == "INDS", "Secondary I.")) %>%
  mutate(Group = replace(Group, Group == "INDP", "Primary I."))
  
CER_groups$Group <- CER_groups$Group <- factor(CER_groups$Group, 
                                    levels=c("Arboreal", "Other NAP", "Secondary I.", "Primary I."))
rp1 <- riojaPlot(CER_perc_EPD %>% select(-depth) %>% ungroup(), CER_EPD$metadata %>% rename(`Age [cal. years BP]` = `#Chron1`), 
                 groups = CER_groups,
                 plot.bar = F,
                 col.group = c("#117733", "#ddcc77", "#CC6677", "#882255"),
                 yvar.name = "Age [cal. years BP]",
                 selVars = trees$Name,
                 labels.break.long = F,
                 plot.cumul = TRUE,
                 plot.groups = TRUE,
                 cumul.mult = 1,
                 ytks1 = seq(0, 12000, by = 500),
                 srt.xlabel = 60,
                 cex.xlabel = 0.7,
                 plot.exag = T,
                 exag.mult = 10,
                 plot.line = F,
                 plot.poly = T,
                 col.baseline = NA,
                 # col.axis=NA,
                 scale.percent = T,
                 yTop = 0.75,
                 xRight = 0.7)

rp2 <- riojaPlot(CER_perc_EPD %>% select(-depth), CER_EPD$metadata %>% rename(`Age cal. BP` = `#Chron1`), 
                 groups = CER_groups,
                 plot.bar = F,
                 plot.line = F,
                 col.group = c("#117733", "#ddcc77", "#CC6677", "#882255"),
                 yvar.name = "Age cal. BP",
                 selVars = herbs$Name,
                 plot.groups = T,
                 labels.break.long = F,
                 cex.xlabel = 0.7,
                 # srt.xlabel = 60,
                 plot.exag = T,
                 exag.mult = 10,
                 col.baseline = NA,
                 scale.percent = TRUE,
                 riojaPlot = rp1,
                 xRight = 0.95
                 ) |>
addRPZoneNames(CER_PAZ, cex=0.6, xRight = 1) |>
addRPClustZone(clust, col = "#332288") 

mtext("%", side = 1, line = 4, cex = 0.7)

rm(list = ls(pattern = "^rp"))

# dev.off()