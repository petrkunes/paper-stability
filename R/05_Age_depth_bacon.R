#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                               Age-depth model
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

require(rbacon)

Bacon("CERNE_EXP", rotate.axes = TRUE, acc.mean = 50, acc.shape = 2, mem.strength = 24, mem.mean = 0.4, d.max = 1988, thick = 3, d.by = 0.25, run = F)



# pdf(file = "data_out/FIG_AGE_accrate.pdf", height = 6, width = 8, encoding = "CP1250.enc")

layout(matrix(c(1,2), 1, 2, byrow = T), widths = c(3,1))
agedepth(
  title = "",
  title.location = "topright",BCAD = FALSE,
  # mn.col = "black",
  # range.col = "grey40",
  d.lab = "Depth (cm)",
  # d.by = 25,
  # d.min = 1700,
  # d.max = 2000,
  # age.max = 14000,
  model.only = T,
  rotate.axes = TRUE,
  plot.range = T,
  # C14.col = "lightblue",
  # C14.border = "navyblue",
  # cal.col = "white",
  # cal.border = "tomato",
  # mar.main = c(3,3,1,1),
  range.lty = "23",
  plot.pdf = FALSE,
  xaxt = "n",
  yaxs = "i",
  xaxs = "i",
  # bty = "n",
  yaxt = "n"
)
add.dates(9000, 50, 1790, rotate.axes = TRUE, height = 10, col = rgb(0, 0.5, 0.5, 0.35), border = rgb(0, 0.5, 0.5, 0.5), cc = 0, pch = '')
add.dates(9000, 50, 1820, rotate.axes = TRUE, height = 10, col = rgb(0, 0, 1, 0.35), border = rgb(0, 0, 1, 0.5), cc = 0, pch = '')
text(9200, 1790, "210Pb dates", adj = c(0,0.5))
text(9200, 1820, "14C dates", adj = c(0,0.5))
# par(xaxt="s", yaxt = "s", cex = 1.2)
# axis(1, 1000*(0:17)-50, 2000-1000*(0:17))
rect(-50,1946.5,11700,1706, border = "red", lty = "dashed")
axis(1, 1000*(0:15))
rug(x = 1000*(0:14) + 500, ticksize = -0.01, side = 1)
axis(2, 10*(0:30)+1700)

accrate.depth.ghost(rotate.axes = T, rev.d = T, plot.median = F)

# dev.off()

# Calculation of acc rate

CER_accrate <- c()
for (d in 1705:1946) {
  CER_accrate <- c(CER_accrate, mean(accrate.depth(d)))
}
mean(CER_accrate)
sd(CER_accrate)

pdf(file = "data_out/Fig_agedepth.pdf", height = 6, width = 6, encoding = "CP1250.enc")

agedepth(
  title = "",
  title.location = "topright",BCAD = FALSE,
  # mn.col = "black",
  # range.col = "grey40",
  d.lab = "Depth (cm)",
  # d.by = 25,
  # d.min = 1700,
  # d.max = 2000,
  # age.max = 14000,
  model.only = F,
  rotate.axes = TRUE,
  plot.range = T,
  # C14.col = "lightblue",
  # C14.border = "navyblue",
  # cal.col = "white",
  # cal.border = "tomato",
  # mar.main = c(3,3,1,1),
  range.lty = "23",
  plot.pdf = FALSE,
  xaxt = "n",
  yaxs = "i",
  xaxs = "i",
  # bty = "n",
  yaxt = "n"
)
add.dates(9000, 50, 1790, rotate.axes = TRUE, height = 10, col = rgb(0, 0.5, 0.5, 0.35), border = rgb(0, 0.5, 0.5, 0.5), cc = 0, pch = '')
add.dates(9000, 50, 1820, rotate.axes = TRUE, height = 10, col = rgb(0, 0, 1, 0.35), border = rgb(0, 0, 1, 0.5), cc = 0, pch = '')
text(9200, 1790, "210Pb dates", adj = c(0,0.5))
text(9200, 1820, "14C dates", adj = c(0,0.5))
# par(xaxt="s", yaxt = "s", cex = 1.2)
# axis(1, 1000*(0:17)-50, 2000-1000*(0:17))
rect(-50,1946.5,11700,1706, border = "red", lty = "dashed")
axis(1, 1000*(0:15))
rug(x = 1000*(0:14) + 500, ticksize = -0.01, side = 1)
axis(2, 10*(0:30)+1700)

dev.off()

