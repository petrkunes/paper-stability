#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#                            Supplementary Material
#                              Table S1: Dating
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

CER_geochron <- info$dets %>% 
  mutate(`14C age [BP]`= case_when(cc==1 ~ paste(age, error, sep = " ± "))) %>%
  mutate(`210Pb age [cal. BP]`= case_when(cc==0 ~ paste(age, error, sep = " ± "))) %>%
  select(labID, depth, `210Pb age [cal. BP]`, `14C age [BP]`) %>%
  replace(is.na(.), '')
colnames(CER_geochron)[1:2] <- c("Laboratory ID", "Depth [cm b.w.l.]")
knitr::kable(CER_geochron)