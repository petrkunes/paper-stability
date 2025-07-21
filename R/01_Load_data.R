#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                                 Data loading
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#


# Cerne jezero pollen data
CER_pollen <- tilia_trans(read_excel("data_in/CER_pollen_corr.xlsx"))
CER_pollen <- tilia_select(CER_pollen, agemin = -70, agemax = 11700) # select only studied period

# Cerne jezero charcoal data
CER_char <- tilia_trans(read_excel("data_in/CER_char_corr.xlsx"))
CER_char <- tilia_select(CER_char, agemin = -70, agemax = 11700) # select only studied period

# CHELSA climate model
CER_CHELSA <- read_excel("data_in/CER_CHELSA.xlsx")[,-1]
CER_CHELSA[,2:3] <- CER_CHELSA[,2:3]*-1+1950

## European Pollen Database harmonization table (with some added taxa)
epd_p_vars <- read_excel("data_in/EPD_P_VARS_high3_mod.xlsx") %>% rename(Name = VarName)

## Create Cerne jezero harmonized pollen data (EPD harmonization table)
CER_EPD <- tilia_EPD(CER_pollen, epd_p_vars)
CER_EPD$data <-  CER_EPD$data %>%
  mutate(Name = replace(Name, Name == "Ulmus/Zelkova", "Ulmus"))

## Define list of studied taxa
taxalist <- list("Pinus", "Betula", "Picea abies", "Corylus avellana", "Alnus",  "Fagus", "Abies alba")

# Get sample ages from the age-depth model and load the model
CER_agedepth <- read.table("Bacon_runs/CERNE_EXP/CERNE_EXP_96_ages.txt", header = T)
CER_agedepth$depth <-  round(CER_agedepth$depth, digits = 2)
Bacon("CERNE_EXP", rotate.axes = TRUE, acc.mean = 50, acc.shape = 2, mem.strength = 24, mem.mean = 0.4, d.max = 1988, thick = 3, d.by = 0.25, run = F)


# Cerne jezero XRF data and aligning two drives
CER_XRF_GC <- read_excel("data_in/CER_XRF_GC.xlsx")
CER_XRF_15_2_1 <- read_excel("data_in/CER_XRF_15-2-1.xlsx")
CER_XRF_15_2_2 <- read_excel("data_in/CER_XRF_15-2-2.xlsx")

CER_XRF <- rbind(CER_XRF_15_2_1[,-71:-76], CER_XRF_15_2_2 %>% 
                   mutate(`Depth In Core` = `Depth In Core`-0.11))

CER_XRF_long <- CER_XRF %>% pivot_longer(cols = `Magnetic Susceptibility`:`Ca (Error)`, names_to = "Element", values_to = "Value")
CER_XRF_combined <- rbind(CER_XRF_GC %>% mutate("K:Ti" = `K (mg/g)`/`Ti (mg/g)`) %>%
                            mutate("depth" = `Depth In Core` * 100) %>%
                            select(`depth`, `K:Ti`), CER_XRF %>% filter((`Depth In Core`>=18.585 & Section == "CER15-2-2") | Section == "CER15-2-1") %>%
                            mutate("K:Ti" = `K (ppm)`/`Ti (ppm)`) %>% mutate("depth" = `Depth In Core` * 100) %>%
                            select(`depth`, "K:Ti"))
CER_XRF_combined$depth <- round(CER_XRF_combined$depth, digits = 2)
CER_XRF_combined <- left_join(CER_XRF_combined, CER_agedepth)
CER_XRF_combined_shift <- CER_XRF_combined %>% mutate(depth = if_else(depth>=1713.5, depth+0.25, depth)) %>% 
  mutate(depth = if_else(depth<=1713, depth+0.5, depth))
