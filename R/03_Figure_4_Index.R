#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                        Figure 4: Ecological indexes
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#


# pdf(file = "data_out/Fig_4.pdf", width = 10, height = 6)
xnames <- rep("", length(colnames(CER_perc_EPD))-1)
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
clust <- chclust(dist(sqrt(CER_perc_EPD %>% select(-depth))))
zones_fig <- CER_EPD$metadata %>% group_by(Zones) %>% summarise(zm=mean(`#Chron1`)) %>%
  mutate(name=paste("CJ", 6:1)) %>% select(-Zones)

color_zone <- "#882255"
color_zone2 <- "#332288"

rp1 <- riojaPlot(CER_perc_EPD %>% select(-depth) %>% ungroup(), CER_EPD$metadata %>% rename(`Age [cal. years BP]` = `#Chron1`),
                 groups = CER_groups,
                 col.group = c("#117733", "#ddcc77", "#CC6677", "#882255"),
                 plot.sec.axis = T, yvar.name = "Age [cal. years BP]", 
                 sec.yvar.name = "Age [cal. years BP]", 
                 selVars = "Celtis",
                 xlabels = xnames,
                 plot.cumul = TRUE, 
                 ytks1 = seq(0, 12000, by = 500),
                 srt.xlabel = 60,
                 plot.exag = T,
                 plot.top.axis = T,
                 lwd.cumul.line = 0,
                 col.cumul.line = NA,
                 yTop = 0.75,
                 scale.percent = TRUE, xRight = 0.20)

plot.xrf <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  x <- CER_XRF_combined$`K:Ti`
  y <- CER_XRF_combined$mean
  text(2, usr[4]-700, "K/Ti", adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="#AA4499")
  text(6, usr[4]-700, "Rate of change", adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="#332288")
  lines(x, y, col="#AA4499", lwd = 1.2, lty = "solid")
}
plot.roc.error <- function(x, y, i, nm, style) {
  x <- c(CER_ROC$ROC_up, rev(CER_ROC$ROC_dw))
  y <- c(CER_ROC$Age, rev(CER_ROC$Age))
  polygon(x, y, col = adjustcolor("#332288", alpha.f=0.4), border = NA)
}
  
rp2 <- riojaPlot(CER_ROC[,"ROC"], CER_ROC[,"Age", drop = FALSE],
                 xlabels = "",
                 plot.bar = F, plot.line = T, col.line = "#332288", lwd.line = 1.5,
                 # scale.minmax = T,
                 minmax = data.frame(0,7),
                 riojaPlot = rp1,
                 plot.poly = F,
                 scale.percent = F,
                 col.baseline = NA,
                 fun.xfront=plot.xrf,
                 fun.xback=plot.roc.error,
                 xRight = 0.30)

plot.richness <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  x <- CER_divers_EPD$Richness
  y <- CER_divers_EPD$`#Chron1`
  text(19, usr[4]-700, expression("Richness [R"[ACC]*"]"), adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="#117733")
  text(27, usr[4]-700, expression("Richness [R"[PC]*"]"), adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col = "#44AA99")
  lines(x, y, col="#44AA99", lwd = 1.2, lty = "dashed")
  # xval <- seq(round_any(usr[1], 0.5, f = floor), round_any(usr[2], 0.5, f = floor), by=0.5) # create a vector of labels for the axis
  # xlab <- rep("", length(xval))
  # axis(side=1, at=xval, labels=xlab, tcl=-0.2, cex.axis=0.5, mgp=c(3, 0.1, 0))
  # xlab <- as.character(xval); xlab[1] <- ""
  # text(xlab, usr[3]+150, xval, cex=0.5, srt=-90, adj=c(0, 0.5), xpd=NA) # ad the x-axis vales
}

rp3 <- riojaPlot(CER_divers_EPD %>% select(AccRichness), CER_divers_EPD[,"#Chron1", drop = FALSE],
                 xlabels = c(""),
                 riojaPlot=rp2,
                 minmax = data.frame(5,35),
                 plot.bar = F, plot.line = T, col.line = "#117733", lwd.line = 1.5,
                 xRight = 0.40,
                 col.baseline = NA,
                 labels.break.long = T,
                 fun.xfront=plot.richness
)

plot.diversity <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  text(6, usr[4]-700, expression("Diversity [D"[SIM]*"]"), adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="black")
}

rp3.1 <- riojaPlot(CER_divers_EPD %>% select(invSimpson), CER_divers_EPD[,"#Chron1", drop = FALSE],
                   xlabels = c(""),
                   riojaPlot=rp3,
                   minmax = data.frame(1,11),
                   plot.bar = F, plot.line = T, col.line = "#999933", lwd.line = 1.5,
                   xRight = 0.50,
                   col.baseline = NA,
                   labels.break.long = T,
                   fun.xfront=plot.diversity
)

plot.disturbance <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  text(-1.6, usr[4]-700, "Disturbance [DF]", adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="black")
}

rp4 <- riojaPlot(CER_dist %>% select(EcoIndex), CER_EPD$metadata %>% select(`#Chron1`),
                 # selVars = "EcoIndex",
                 xlabels = c(""),
                 riojaPlot=rp3.1,
                 minmax = data.frame(-1.75,-1.5),
                 plot.bar = F, plot.line = T, col.line = "#CC6677", lwd.line = 1.5,
                 xRight = 0.60,
                 col.baseline = NA,
                 fun.xfront=plot.disturbance
                 
)
plot.stability <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  text(0.5, usr[4]-700, expression("Stability [S"[ALL]*"]"), adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="black")
}
rp5 <- riojaPlot(CER_data_ord$env %>% select(Stability), CER_data_ord$env %>% select(`#Chron1`),
                 xlabels = c(""),
                 riojaPlot=rp4,
                 minmax = data.frame(0.2,0.9),
                 # scale.minmax = T,
                 plot.bar = F, plot.line = T, col.line = "#88CCEE",
                 lwd.line = 1.5,
                 xRight = 0.70,
                 col.baseline = NA,
                 fun.xfront=plot.stability
                 
)
plot.charcoal <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  par(lheight = 0.6)
  wrap_text <- function(text, width) {
    paste(strwrap(text, width = width), collapse = "\n")
  }
  text(2, usr[4]-700, wrap_text("Charcoal [part/sqcm/year]",20), adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="black")
}
rp6 <- riojaPlot(CER_charAR %>% select(`particles/ml`), CER_char$metadata %>% select(`#Chron1`),
                 # selVars = "EcoIndex",
                 xlabels = c(""),
                 riojaPlot=rp5,
                 minmax = data.frame(0,3),
                 plot.bar = T, plot.line = F, col.bar = "black",
                 lwd.bar = 1,
                 xRight = 0.78,
                 labels.break.long = T,
                 col.baseline = NA,
                 fun.xfront=plot.charcoal
                 
)
plot.chelsa <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  x1 <- c(CER_CHELSA$`bio01 1016m`+3.1, rev(CER_CHELSA$`bio01 1016m`)-3.1)
  y1 <- c(CER_CHELSA$`k BP`*1000, rev(CER_CHELSA$`k BP`*1000))
  text(6, usr[4]-700, "MAT [°C]", adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="black")
  polygon(x1, y1, col = adjustcolor("#AA4499", alpha.f=0.3), border = NA)
}
rp7 <- riojaPlot(CER_CHELSA %>% select(`bio01 1016m`), CER_CHELSA %>% select(`k BP`)*1000,
                 xlabels = "",
                 riojaPlot = rp6,
                 plot.line = T, plot.bar = F, col.line = "#AA4499",
                 lwd.line = 1.5,
                 minmax = data.frame(0,8),
                 fun.xfront=plot.chelsa,
                 xRight = 0.88
                 )
symb.fun <- function(x, y, i, nm, style) {
  sel <- x > 0
  if (sum(sel) > 0) {
    points(rep(3, sum(sel)), y[sel], cex=0.4, pch=19, xpd=NA)
  }
}
funlist <- lapply(1:2, function(x) symb.fun)
# funlist[!sel] <- list(NULL)
plot.fungi <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  par(lheight = 0.6)
  name <- names(nm)
  wrap_text <- function(text, width) {
    paste(strwrap(text, width = width), collapse = "\n")
  }
  text(5, usr[4]-700, wrap_text(name, 20), adj=c(0, 0), xpd=NA, srt=60, cex = 0.9, col="black")
}
rp8 <- riojaPlot(CER_perc_NPP %>% select(`Dung fungi`, Ustulina) %>% rename(`Kretzschmaria deusta` = Ustulina), CER_pollen$metadata %>% select(`#Chron1`),
                 riojaPlot = rp7,
                 # selVars = c("Dung fungi","Ustulina"),
                 xlabels = c("",""),
                 plot.line = F, plot.poly = F, plot.bar = F, plot.symb = F,
                 col.poly = "#CC6677",
                 labels.break.long = T,
                 labels.break.n = 15,
                 scale.percent = T,
                 fun.xfront=funlist,
                 fun.xback=plot.fungi,
                 xRight = 0.95
                 )


  addRPZoneNames(rp1, zones_fig, cex=0.6, xRight = 1, xLeft = 0.95)
  addRPClustZone(rp1, clust, col = color_zone, xRight = 1, lty = "dotted")
addRPZone(rp1, 11050, 11150, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 10250, 10350, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 9350, 9450, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 8150, 8250, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 9350, 9450, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 5850, 5950, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 4150, 4250, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 2850, 2950, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 1350, 1450, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp1, 350, 450, col = color_zone2, alpha = 0.1, xRight = 1)
# dev.off()
rm(list = ls(pattern = "^rp"))

