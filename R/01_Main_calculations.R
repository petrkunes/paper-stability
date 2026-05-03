#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                        Main calculations and analyses
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#



#--------------------------------------------------------------------#
# Input data ----
#--------------------------------------------------------------------#

# This will load all necessary data needed for calculations
source("R/01_Load_data.R")


# Analysis ----
## Calculate disturbance index ----

# source("02_Calculate_disturbance.R")
# CER_dist <- read.table("data_out/CER_dist_2.csv", sep = ";") # READS OUTPUT OF THE PREVIOUS FUNCTION
CER_dist <- readRDS("data_out/CER_disturbance.rds") # READS OUTPUT OF THE PREVIOUS FUNCTION

## Calculate percentages ---
CER_ecog <- tilia_ecog(CER_EPD, list("TRSH", "HERB", "VACR", "DWAR", "HELO", "AQUA"), list("pollen"))
CER_perc <- tilia_percent(CER_pollen, list("TRSH", "UPHE"), list("TRSH", "UPHE"), list("pollen"))
CER_perc_NPP <- tilia_percent(CER_pollen, list("TRSH", "UPHE"), list("FUNG"), list("pollen","spore"))
CER_perc_NPP <- CER_perc_NPP %>% mutate(`Dung fungi` = Cercophora + Diporotheca + Chaetomium + Podospora + Sordaria + Sporormiella)
CER_perc_EPD <- tilia_percent(CER_EPD, list("TRSH", "DWAR", "HERB"), list("TRSH", "HERB", "DWAR"), list("pollen"))


## Create PAR ----
CER_PAR <- tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = F)
CER_PAR_EPD <- tilia_EPD(CER_PAR, epd_p_vars)
CER_PAR_w <- tilia_PAR(CER_pollen, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T)
CER_charAR <- tilia_CHAR(CER_char, groups = list("CHAR"), elements = list("<125 µm"), unit = list("particles/ml"), piwot.wider = TRUE)

## Calculate diversity indices ----
CER_divers_EPD <- tilia_divers(CER_EPD, CER_PAR_EPD,
                               index = list("rarefy", "simpson", "invsimpson", "PIE"), 
                               groups = list("TRSH", "HERB", "VACR", "DWAR", "HELO", "AQUA"), 
                               elements = list("pollen"),
                               lowsum = 500)

## Calculate pollen assemblage zones ----
clust <- chclust(vegdist(CER_perc_EPD %>% select(-depth), method = "hellinger"))
# bstick(clust, 10)
CER_EPD$metadata$Zones <-  cutree(clust, 6)
CER_PAZ <- CER_EPD$metadata %>% group_by(Zones) %>% summarise(zm=mean(`#Chron1`), old=max(`#Chron1`), young=min(`#Chron1`), duration=max(`#Chron1`)-min(`#Chron1`)) %>%
  mutate(name=paste("CJ", 6:1)) %>% select(zm, name, old, young, duration)


## Calculate change point analysis ----

CER_pollen_mod <- CER_pollen
CER_pollen_mod$data <- CER_pollen_mod$data %>% 
  mutate(value = if_else(Name == "Abies alba" & depth == 1871.25, value*0, value)) %>%
  mutate(value = if_else(Name == "Fagus" & (depth == 1930.25 | depth == 1911.25 | depth == 1891.25 | depth == 1887.25), value*0, value))


CER_CPA <- tilia_parchp(tilia_PAR(CER_pollen_mod, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T), taxon = taxalist, 
                        method = "PELT", penalty = "BIC", minseglen = 5, all.samples = T)

### Calculate increases ----

CER_stab_pop <- data.frame(Taxon = character(), stab_incr = numeric(), stab_decr = numeric(), stab_pop_incr = numeric())
for(t in taxalist) {
CER_stab_pop <- rbind(CER_stab_pop,
                      CER_CPA$Zones %>% filter(Taxon == t & mean>0) %>% mutate(stab.diff=lead(stability, default=last(stability))-stability) %>% mutate(pop.diff=lead(mean, default=last(mean))-mean) %>%
                        group_by(Taxon) %>% mutate(stab_incr = sum(stab.diff>0)) %>% mutate(stab_decr = sum(stab.diff<0)) %>% mutate(stab_pop_incr = sum(stab.diff>0 & pop.diff>0)) %>% 
                        mutate(pop_stab_ratio=stab_pop_incr/stab_incr) %>%
                        select(Taxon, stab_incr, stab_decr, stab_pop_incr, pop_stab_ratio) %>% unique())
}
colnames(CER_stab_pop) <- c("Taxon", "Stability increase", "Stability decrease", "Stab+Pop increase", "Ratio stab+pop")
CER_stab_pop <- CER_stab_pop %>% arrange(desc(`Ratio stab+pop`))

## Calculate Rate of Change ----

CER_pollen_w <- CER_EPD$data %>% select(-Group, -Element) %>% 
  pivot_wider(names_from = Name, values_from = value) %>% rename(sample_id = depth) %>% mutate(sample_id = as.character(sample_id))
CER_age <- CER_EPD$metadata %>% select(depth, `#Chron1`) %>% mutate(sample_id = as.character(depth)) %>% rename(age = `#Chron1`)

CER_CPA$Samples <- CER_CPA$Samples %>% left_join(CER_age)
CER_CPA$Zones <- CER_CPA$Zones %>% left_join(CER_age)

# source("02_Calculate_ROC.r")

CER_ROC <- readRDS("data_out/CER_ROC.rds")

## Merge data for ordination ----

CER_data_ord <- tilia_merge(tilia_CHAR(CER_char, groups = list("CHAR"), elements = list("<125 µm"), unit = list("particles/ml")), 
                            tilia_percent(CER_EPD, groups = list("TRSH", "HERB", "DWAR", "HELO"), groups_sum = list("TRSH", "HERB", "DWAR", "HELO"), elements = list("pollen", "spore")), 
                            CER_divers_EPD, 
                            tilia_parchp(tilia_PAR(CER_pollen_mod, list("TRSH", "UPHE"), list("pollen"), piwot.wider = T), taxon = taxalist, 
                                         method = "PELT", penalty = "BIC", minseglen = 5, all.samples = T)$SamplesStand,
                            taxa = unlist(taxalist), CHARunits = "particles/ml")

colnames(CER_data_ord$env)[c(2,3,5,7,9)] <- c("Charcoal", "Stability", "Richness", "Richness%", "Diversity")

### Join climatic data
CER_data_ord$env <- CER_data_ord$env %>%
  left_join(CER_CHELSA, join_by(`#Chron1`<= startyear, `#Chron1`>=endyear))
CER_data_ord$env[1,15:18] <- CER_data_ord$env[2,15:18]

### Join ROC and disturbance and geochem

CER_data_ord$env <- CER_data_ord$env %>% 
  left_join(CER_ROC %>% rename(`#Chron1` = Age)) %>%
  left_join(CER_dist %>% rename(depth = Sample)) %>% 
  left_join(CER_XRF_combined_shift, by = "depth")

colnames(CER_data_ord$env)[c(24)] <- "Disturbance"
colnames(CER_data_ord$env)[c(27)] <- "K/Ti"
colnames(CER_data_ord$env)[c(16)] <- "MAT"

### Join NPPs
CER_data_ord$env <- CER_data_ord$env %>% 
  left_join(CER_perc_NPP)

CER_data_ord$env <- CER_data_ord$env[-130,]
CER_data_ord$pollen <- CER_data_ord$pollen[-130,]
CER_data_ord$pollen <- CER_data_ord$pollen[,colSums(CER_data_ord$pollen)>0]

## Ordination ----

# Check gradient length
CER.dca <- decorana(CER_data_ord$pollen[,-1], iweigh = 1)

CER_data_ord$envst <- decostand(CER_data_ord$env %>% select(Charcoal, Stability, Richness, Diversity, ROC, Disturbance, `K/Ti` , MAT, `Dung fungi`, Ustulina), method = "standardize")

# Check for colinearity
CER.rda.test <- rda(decostand(CER_data_ord$pollen[,-1], method = "hellinger") ~ Charcoal + Stability + Richness + Diversity + Disturbance + ROC + `K/Ti` + MAT + `Dung fungi`+ Ustulina, data = CER_data_ord$env %>% select(Charcoal, Stability, Richness, Diversity, Disturbance, ROC, `K/Ti`, MAT, `Dung fungi`, Ustulina))
CER.env.test <- vif.cca(CER.rda.test)

### RDA without detrending ----

# CER.rda <- rda(decostand(CER_data_ord$pollen[,-1], method = "hellinger") ~ Charcoal + Stability + Richness + Diversity + Disturbance + ROC + MAT, data = CER_data_ord$envst)

# RDA without covariable
# CER.rda <- rda(decostand(CER_data_ord$pollen[,-1], method = "hellinger") ~ Charcoal + Stability + Richness + Diversity + Disturbance + ROC + `K/Ti` + MAT, data = CER_data_ord$env %>% select(Charcoal, Stability, Richness, Diversity, Disturbance, ROC, `K/Ti`, MAT))

# RDA with covariable
CER.rda <- rda(decostand(CER_data_ord$pollen[,-1], method = "hellinger") ~ Charcoal + Stability + Richness + Diversity + Disturbance + ROC + `K/Ti` + MAT + Condition(`#Chron1`), data = CER_data_ord$env %>% select(`#Chron1`, Charcoal, Stability, Richness, Diversity, Disturbance, ROC, `K/Ti`, MAT))



CER.RDA.anova <- anova(CER.rda, by = "axis")
CER.RDA.anova.var <- anova(CER.rda, by = "margin") %>% arrange(desc(F))

CER_scores <- fortify(CER.rda)
CER.RDA.species <- CER_data_ord$pollen %>% select(-depth) %>%
  select(order(colSums(.), decreasing = T))
CER_species <- head(colnames(CER.RDA.species), 14)
CER_spec_scores <- subset(CER_scores, score == "species" & label %in% CER_species)
CER_env_scores <- subset(CER_scores, score == "biplot")


## Test correlation of environmental variables ----
CER_corr <- rcorr(as.matrix(CER_data_ord$envst %>% select(Charcoal, Richness, Diversity, Disturbance, ROC, Stability, MAT, `K/Ti`)), type = "pearson")
diag(CER_corr$P) <- 0

# Model each environmental variable as a function of time
# Take residuals (which are approximately “de‑trended” and have reduced autocorrelation)
CER_env_lm_resid <- as.data.frame(matrix(NA, nrow = nrow(CER_data_ord$envst),
                                  ncol = ncol(CER_corr$r)))
colnames(CER_env_lm_resid) <- colnames(CER_corr$r)

CER_PAR_sel <- CER_PAR_w %>% select(unlist(taxalist))

### linear model
for (j in colnames(CER_corr$r)) {
  fit <- lm(CER_data_ord$envst[, j] ~ CER_data_ord$env$`#Chron1`)
  CER_env_lm_resid[, j] <- resid(fit)
}


# Now check correlation among de-trended variables
CER_cor_lm_resid <- rcorr(as.matrix(CER_env_lm_resid), type = "pearson")
# corrplot(CER_cor_lm_resid$r, p.mat = CER_cor_lm_resid$P, method = "color", type = "lower", order = "hclust")


CER_cor_spe <- rcorr(as.matrix(CER_PAR_sel), type = "pearson")
diag(CER_cor_spe$P) <- 0
# corrplot(CER_cor_spe$r, p.mat = CER_cor_spe$P, method = "color", type = "lower")


#--------------------------------------------------------------------#
# Load and save calculations ----  

# save.image("data_out/CER_data.RData")
# load("data_out/CER_data.RData")

#--------------------------------------------------------------------#
