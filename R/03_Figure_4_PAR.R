#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                   Figure 4: Pollen accumulation rate diagram
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

# pdf("data_out/Fig_CER_PAR_stab.pdf", width = 8, height = 6)

color_pol <- "#117733"
color_stab <- "#DDCC77"
color_zone <- "#882255"
color_zone2 <- "#332288"

shift <- 0.17
space <- 0.012

rp2.1 <- riojaPlot(tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T) %>% select(unlist(taxalist[1])), 
                   CER_pollen$metadata %>% rename(`Age cal. BP` = `#Chron1`), 
                   xlabels = "Pinus\nPAR",
                   # labels.italicise = T,
                   yvar.name = "Age cal. BP", scale.percent = F, xRight = shift,
                   ytks1 = seq(0, 12000, by = 500),
                   srt.xlabel = 90,
                   centre.xlabel = T,
                   col.poly = color_pol, col.baseline = NA,
                   plot.bar = F, plot.line = F,
                   scale.minmax = T,
                   plot.top.axis = F, plot.bottom.axis = T,
                   yTop = 0.78,
                   minmax = data.frame(0,15000)
)
rp2.2 <- riojaPlot(CER_CPA$Samples %>% select(unlist(taxalist)[1]), 
                   CER_CPA$Samples %>% select(age), 
                   yvar.name = "age", 
                   minmax = data.frame(0,5),
                   xlabels = "stability",
                   scale.percent = T,
                   x.pc.inc = 5,
                   min.width.pc = 7,
                   scale.minmax = T,
                   plot.poly = T, plot.bar = F, plot.line = F, riojaPlot = rp2.1,
                   col.poly = color_stab,
                   # xSpace = space,
                   xRight = shift + 0.05)

addRPZone(rp2.2, CER_CPA$Zones %>% filter(Taxon == "Pinus" & age>-44) %>% select(age) %>% unlist(), col = color_zone, 
          xLeft = shift*0.5, 
          lty = "dashed",
          xRight = shift + 0.05)

shift <- shift + 0.05
rp3.1 <- riojaPlot(tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T) %>% select(unlist(taxalist)[2]), 
                   CER_pollen$metadata, 
                   yvar.name = "#Chron1", scale.percent = FALSE, 
                   scale.minmax = T,
                   minmax = data.frame(0,10000),
                   xlabels = "Betula\nPAR",
                   col.poly = color_pol,col.baseline = NA,
                   plot.bar = F, plot.line = F,
                   plot.top.axis = F, plot.bottom.axis = T,
                   xRight = shift + 0.05, riojaPlot = rp2.2
)

rp3.2 <- riojaPlot(CER_CPA$Samples %>% select(unlist(taxalist)[2]), 
                   CER_CPA$Samples %>% select(age), 
                   yvar.name = "age", 
                   xlabels = "stability",
                   minmax = data.frame(0,5),
                   scale.minmax = T,
                   scale.percent = T,
                   x.pc.inc = 5,
                   min.width.pc = 7,
                   plot.poly = T, plot.bar = F, plot.line = F, riojaPlot = rp3.1, 
                   col.poly = color_stab,
                   # xSpace = space,
                   xRight = shift + 0.1)

addRPZone(rp3.2, CER_CPA$Zones %>% filter(Taxon == taxalist[[2]] & age>-44) %>% select(age) %>% unlist(), col = color_zone, lty = "dashed", xLeft = shift, xRight = shift+0.1)

shift <- shift + 0.1
rp4.1 <- riojaPlot(tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T) %>% select(taxalist[[3]]),
                   CER_pollen$metadata,
                   yvar.name = "#Chron1",
                   xlabels = "Picea abies\nPAR",
                   col.poly = color_pol,col.baseline = NA,
                   plot.line = F, plot.bar = F,
                   scale.minmax = T,
                   minmax = data.frame(0,15000),
                   plot.top.axis = F, plot.bottom.axis = T,
                   scale.percent = FALSE, xRight = shift + 0.05*1.5, riojaPlot = rp3.2
)
rp4.2 <- riojaPlot(CER_CPA$Samples %>% select(taxalist[[3]]), CER_CPA$Samples %>% select(age), 
                   yvar.name = "age", 
                   scale.percent = T,
                   x.pc.inc = 5,
                   min.width.pc = 7,
                   xlabels = "stability",
                   minmax = data.frame(0,5),
                   scale.minmax = T,
                   plot.poly = T, plot.bar = F, plot.line = F, riojaPlot = rp4.1, 
                   col.poly = color_stab,
                   # xSpace = space,
                   xRight = shift + 0.05*1.5 + 0.05)
addRPZone(rp4.2, CER_CPA$Zones %>% filter(Taxon == taxalist[[3]] & age>--44) %>% select(age) %>% unlist(), lty = "dashed", col = color_zone, 
          xLeft = shift, xRight = shift + 0.05*1.5+0.05)
shift <- shift + 0.05*1.5 + 0.05
rp5.1 <- riojaPlot(tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T) %>% select(taxalist[[4]]), 
                   CER_CPA$Samples %>% select(age), 
                   yvar.name = "age",
                   xlabels = "Corylus avellana\nPAR",
                   scale.minmax = T,
                   col.poly = color_pol,col.baseline = NA,
                   plot.bar = F, plot.line = F,
                   minmax = data.frame(0,10000),
                   plot.top.axis = F, plot.bottom.axis = T,
                   scale.percent = FALSE, xRight = shift + 0.05, riojaPlot = rp4.2
)
rp5.2 <- riojaPlot(CER_CPA$Samples %>% select(taxalist[[4]]), CER_CPA$Samples %>% select(age), yvar.name = "age", 
                   scale.percent = T,
                   x.pc.inc = 5,
                   min.width.pc = 7,
                   xlabels = "stability",
                   minmax = data.frame(0,5),
                   scale.minmax = T,
                   plot.poly = T, plot.bar = F, plot.line = F, riojaPlot = rp5.1, 
                   col.poly = color_stab,
                   # xSpace = space,
                   xRight = shift + 0.1
)

addRPZone(rp5.2, CER_CPA$Zones %>% filter(Taxon == taxalist[[4]] & age>-44) %>% select(age) %>% unlist(), col = color_zone, lty = "dashed", xLeft = shift, xRight = shift + 0.1)
shift <- shift + 0.1
rp6.1 <- riojaPlot(tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T) %>% select(taxalist[[5]]), CER_CPA$Samples %>% select(age), 
                   yvar.name = "age",
                   xlabels = "Alnus\nPAR",
                   scale.minmax = T,
                   col.poly = color_pol,col.baseline = NA,
                   plot.line = F, plot.bar = F,
                   minmax = data.frame(0,10000),
                   plot.top.axis = F, plot.bottom.axis = T,
                   scale.percent = FALSE, xRight = shift + 0.05, riojaPlot = rp5.2
)
rp6.2 <- riojaPlot(CER_CPA$Samples %>% select(taxalist[[5]]), CER_CPA$Samples %>% select(age), yvar.name = "age", 
                   scale.percent = T,
                   x.pc.inc = 5,
                   min.width.pc = 7,
                   xlabels = "stability",
                   minmax = data.frame(0,5),
                   scale.minmax = T,
                   plot.poly = T, plot.bar = F, plot.line = F, riojaPlot = rp6.1, 
                   col.poly = color_stab,
                   # xSpace = space,
                   xRight = shift + 0.1
)
addRPZone(rp6.2, CER_CPA$Zones %>% filter(Taxon == taxalist[[5]] & age>-44) %>% select(age) %>% unlist(), col = color_zone, lty = "dashed", xLeft = shift, xRight = shift + 0.1)
shift <- shift + 0.1
rp7.1 <- riojaPlot(tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T) %>% select(taxalist[[6]]), 
                   CER_CPA$Samples %>% select(age), 
                   yvar.name = "age",
                   xlabels = "Fagus sylvatica\nPAR",
                   scale.minmax = T,
                   col.poly = color_pol,col.baseline = NA,
                   plot.line = F, plot.bar = F,
                   minmax = data.frame(0,10000),
                   plot.top.axis = F, plot.bottom.axis = T,
                   scale.percent = FALSE, xRight = shift + 0.05, riojaPlot = rp6.2
)
rp7.2 <- riojaPlot(CER_CPA$Samples %>% select(taxalist[[6]]), CER_CPA$Samples %>% select(age), yvar.name = "age", 
                   scale.percent = T,
                   x.pc.inc = 5,
                   min.width.pc = 7,
                   xlabels = "stability",
                   minmax = data.frame(0,5),
                   scale.minmax = T,
                   plot.poly = T, plot.bar = F, plot.line = F, riojaPlot = rp7.1, 
                   col.poly = color_stab,
                   # xSpace = space,
                   xRight = shift + 0.1
)
addRPZone(rp6.2, CER_CPA$Zones %>% filter(Taxon == taxalist[[6]] & age>-44) %>% select(age) %>% unlist(), col = color_zone, lty = "dashed", xLeft = shift, xRight = shift + 0.1)
shift <-shift + 0.1
rp8.1 <- riojaPlot(tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T) %>% select(taxalist[[7]]), 
                   CER_CPA$Samples %>% select(age), 
                   yvar.name = "age",
                   xlabels = "Abies alba\nPAR",
                   scale.minmax = T,
                   col.poly = color_pol, col.baseline = NA,
                   plot.line = F, plot.bar = F,
                   minmax = data.frame(0,10000),
                   plot.top.axis = F, plot.bottom.axis = T,
                   scale.percent = FALSE, xRight = shift + 0.05, riojaPlot = rp7.2
)
rp8.2 <- riojaPlot(CER_CPA$Samples %>% select(taxalist[[7]]), CER_CPA$Samples %>% select(age), yvar.name = "age", 
                   scale.percent = T,
                   x.pc.inc = 5,
                   min.width.pc = 7,
                   xlabels = "stability",
                   minmax = data.frame(0,5),
                   scale.minmax = T,
                   plot.poly = T, plot.bar = F, plot.line = F, riojaPlot = rp8.1, 
                   col.poly = color_stab,
                   # xSpace = space,
                   xRight = shift + 0.1
)
addRPZone(rp8.2, CER_CPA$Zones %>% filter(Taxon == taxalist[[7]] & age>-44) %>% select(age) %>% unlist(), col = color_zone, lty = "dashed", xLeft = shift, xRight = shift + 0.1)

plot.stability <- function(x, y, i, nm, style) {
  usr <- par("usr") # extract the x and y data limits of the plot
  text(0.5, usr[4]-300, "Stability [all]", adj=c(0, 0), xpd=NA, srt=90, cex = 0.9, col="black")
}
rp9 <- riojaPlot(CER_data_ord$env %>% select(Stability), CER_data_ord$env %>% select(`#Chron1`),
                 xlabels = "",
                 centre.xlabel = T,
                 riojaPlot=rp8.2,
                 minmax = data.frame(0.2,0.9),
                 plot.bar = F, plot.line = T, col.line = "black",
                 col.baseline = NA,
                 fun.xfront=plot.stability
)
addRPZone(rp2.1, 10000, 8200, col = color_zone2, alpha = 0.1, xRight = 1)
addRPZone(rp2.1, 5000, 3200, col = color_zone2, alpha = 0.1, xRight = 1)
# addRPZone(rp2.1, 2800, 3000, col = color_zone2, alpha = 0.1, xRight = 1)
# addRPZone(rp2.1, 0, 200, col = color_zone2, alpha = 0.1, xRight = 1)


# dev.off()
rm(list = ls(pattern = "^rp"))
