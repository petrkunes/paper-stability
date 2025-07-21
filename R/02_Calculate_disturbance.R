#------------------------------------------------------------------------------#
#
#
# Long-term biodiversity–stability relationship in temperate mountain forests  
#
#                    Calculation of pollen-based disturbance
#
#                                  Petr Kuneš
#                                     2025
#
#
#------------------------------------------------------------------------------#

# Calculates separately the pollen-based disturbance frequency estimates
# The result is saved in a data file and loaded back in 00_Main_calculations.R

#------------------------------------------------------------------------------#
# JOIN POLLEN WITH PLANTS ----
#------------------------------------------------------------------------------#

# Load pollen taxa - plant species table
taxa_species <- read_excel("data_in/_taxa_species.xlsx")

## MATCH TYPES ----
taxa_pollen <- data.frame(pollen_taxon = unique(CER_EPD$data$Name))
taxa_plants <- taxa_pollen %>% 
  left_join(taxa_species) %>% select(pollen_taxon, species)
taxa_plants_2 <- taxa_plants %>% filter(is.na(species))
taxa_plants <- taxa_plants %>% filter(!is.na(species))

## MATCH -type -group with  type  group ----
taxa_species_mod <- data.frame(lapply(taxa_species, function(x) {gsub(" type", "-type", x)}))
taxa_species_mod <- data.frame(lapply(taxa_species_mod, function(x) {gsub(" group", "-group", x)}))
colnames(taxa_species_mod)[3] <- "pollen_taxon"
taxa_plants_2 <- merge(x=taxa_plants_2, y=taxa_species_mod, by="pollen_taxon", all.x=TRUE)

taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(species.y)) %>% select(pollen_taxon, species.y) %>% rename(species = species.y))
taxa_plants_2 <- taxa_plants_2 %>% filter(is.na(species.y)) %>% select(pollen_taxon, species.y) %>% rename(species = species.y)

## MATCH -type with -Typ ----
taxa_plants_2 <- data.frame(lapply(taxa_plants_2, function(x) {gsub("-type", "-Typ", x)}))
taxa_plants_2 <- taxa_plants_2 %>% left_join(taxa_species_mod, by = "pollen_taxon")
taxa_plants_2 <- data.frame(lapply(taxa_plants_2, function(x) {gsub("-Typ", "-type", x)}))
taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(species.y)) %>% select(pollen_taxon, species.y) %>% rename(species = species.y))
taxa_plants_2 <- taxa_plants_2 %>% filter(is.na(species.y)) %>% select(pollen_taxon, species.y) %>% rename(species = species.y)

## MATCH species ----
species <- data.frame(unique(taxa_species_mod[,1:2]))
taxa_plants_2 <- taxa_plants_2 %>%
  select(pollen_taxon) %>%
  rename(species = pollen_taxon) %>%
  left_join(species, by = "species", keep = TRUE)
taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(genus)) %>%
                       rename(pollen_taxon = species.x) %>%
                       rename(species = species.y) %>% select(pollen_taxon, species))
taxa_plants_2 <- taxa_plants_2 %>% filter(is.na(genus)) %>%
  rename(pollen_taxon = species.x) %>%  select(pollen_taxon, species.y)

## MATCH hierarchy ----
taxa_hierarchy <- read_excel("data_in/_taxa_hierarchy.xlsx")
taxa_plants_2 <-  taxa_plants_2 %>%
  left_join(taxa_hierarchy %>% rename(pollen_taxon = target)) %>%
  left_join(taxa_species_mod %>% rename(origin = pollen_taxon))
taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(origin)) %>% select(pollen_taxon, species))
taxa_plants_2 <- taxa_plants_2 %>% filter(is.na(origin)) %>% select(pollen_taxon, species)

## MATCH synonyms ----
taxa_synonym <- read_excel("data_in/_taxa_synonym.xlsx") %>% filter(synonym != 'NA')
taxa_plants_2 <- taxa_plants_2 %>% 
  left_join(taxa_synonym %>% rename(pollen_taxon = varname), by = "pollen_taxon") %>%
  left_join(taxa_species %>% rename(synonym = pollen_taxon), by = "synonym")
taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(species.y)) %>% select(pollen_taxon, species.y) %>% rename(species = species.y))
taxa_plants_2 <- taxa_plants_2 %>% filter(is.na(species.y)) %>% select(pollen_taxon, synonym, species.y)

## Match synonym hierarchy ----
taxa_plants_2 <- taxa_plants_2 %>% 
  left_join(taxa_hierarchy %>% rename(synonym = target), by = "synonym") %>%
  left_join(taxa_species %>% rename(origin = pollen_taxon), by = "origin")
taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(species)) %>% select(pollen_taxon, species))
taxa_plants_2 <- taxa_plants_2 %>% 
  filter(is.na(species)) %>% select(pollen_taxon, synonym, origin, species)

## Match synonym genus ----
taxa_plants_2 <- taxa_plants_2 %>%
  left_join(taxa_species %>% rename(synonym = genus), by = "synonym", keep = T)
taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(synonym.y)) %>% select(pollen_taxon.x, species.y) %>%
                       rename(pollen_taxon = pollen_taxon.x) %>%
                       rename(species = species.y))
taxa_plants_2 <- taxa_plants_2 %>% filter(is.na(synonym.y)) %>% select(pollen_taxon.x, synonym.x, species.x) %>% 
  rename(pollen_taxon = pollen_taxon.x) %>%
  rename(species = species.x)

## Match synonym species ----
taxa_plants_2 <- taxa_plants_2 %>%
  left_join(taxa_species %>% rename(synonym.x = species), by = "synonym.x")
taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(genus)) %>% select(pollen_taxon.x, synonym.x) %>%
                       rename(pollen_taxon = pollen_taxon.x) %>%
                       rename(species = synonym.x))
taxa_plants_2 <- taxa_plants_2 %>% filter(is.na(genus)) %>% select(pollen_taxon.x, synonym.x, species) %>%
  rename(pollen_taxon = pollen_taxon.x) %>%
  rename(synonym = synonym.x)

## MATCH genera ----
taxa_plants_2 <- taxa_plants_2 %>% select(-synonym)
taxa_plants_2 <- taxa_plants_2 %>% rename(genus = pollen_taxon) %>%
  left_join(taxa_species, by = "genus")

taxa_plants <- rbind(taxa_plants, taxa_plants_2 %>% filter(!is.na(species.y)) %>% select(genus, species.y) %>% rename(pollen_taxon = genus) %>%
                       rename(species = species.y))
taxa_plants_2 <- taxa_plants_2 %>% filter(is.na(species.y)) %>% select(genus, species.y) %>% rename(pollen_taxon = genus) %>%
  rename(species = species.y) # remaining unmached types

#------------------------------------------------------------------------------#
# CALCULATE DISTURBANCE INDEX ----
#------------------------------------------------------------------------------#

# Load disturbance indexes and merge with plant-pollen table
species_dist <- read_csv("data_in/_species_dist.csv")
taxa_pl_dist <- na.omit(merge(taxa_plants, species_dist, by = "species", all.x = TRUE))

CER_counts <- data.frame(Entity = 3, CER_EPD$data[,c(1,4,5)]) %>%
  rename(Sample = depth, Varname = Name, Count = value)

CER_dist <- Eco.Index(CER_counts, taxa_pl_dist)

saveRDS(CER_dist, file = "data_out/CER_disturbance.rds")

