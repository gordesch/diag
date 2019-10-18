library(tidyverse) # Utilities
library(openxlsx) # Excel exports

# Import data
dipl90 <- read.csv("data/diplomes-1990.csv") %>% as_tibble()
dipl99 <- read.csv("data/diplomes-1999.csv") %>% as_tibble()
dipl10 <- read.csv("data/diplomes-2010.csv") %>% as_tibble()
dipl15 <- read.csv("data/diplomes-2015.csv") %>% as_tibble()

# Simplify and merge
dipl90<- dipl90 %>%
  select(-DEP,
         -REG,
         -TYP_IRIS,
         -INDIC,
         -INFRA,
         -COMP9099,
         -NOM_COM,
         -DCIRISLI,
         -IRIS,
         -NOM_IRIS) %>%
  rename(IRIS = DCOMIRIS,
         COM = DEPCOM)
dipl99 <- dipl99 %>%
  select(-DEP,
         -REG,
         -TYP_IRIS,
         -INDIC,
         -INFRA,
         -COMP9099,
         -NOM_COM,
         -DCIRISLI,
         -IRIS,
         -NOM_IRIS) %>%
  rename(IRIS = DCOMIRIS,
         COM = DEPCOM)
dipl10 <- dipl10 %>%
  select(-DEP,
         -REG,
         -UU2010,
         -LIBCOM,
         -TRIRIS,
         -GRD_QUART,
         -LIBIRIS,
         -TYP_IRIS,
         -MODIF_IRIS,
         -LAB_IRIS)
dipl15 <- dipl15 %>%
  select(-DEP,
         -REG,
         -UU2010,
         -LIBCOM,
         -TRIRIS,
         -GRD_QUART,
         -LIBIRIS,
         -TYP_IRIS,
         -MODIF_IRIS,
         -LAB_IRIS)
dipl <- dipl90 %>%
  full_join(dipl99) %>%
  full_join(dipl10) %>%
  full_join(dipl15)

# Prepare data
dipl <- dipl %>%
  mutate(P90_NSCOL15P = AF90T15P - AF90TETU) %>% # 15+ 1990
  mutate(P99_NSCOL15P = AF99T15P - AF99TETU) %>% # 15+ 1999
  mutate(P90_NSCOL15P_S = AF90TSUP + AF90TBA2) %>% # 15+ dipl du sup 1990
  mutate(P99_NSCOL15P_S = AF99TSUP + AF99TBA2) %>% # 15+ dipl du sup 1999
  mutate(P10_NSCOL15P_S = P10_NSCOL15P_SUP + P10_NSCOL15P_BACP2) %>% # 15+ dipl du sup 2010
  mutate(P15_NSCOL15P_S = P15_NSCOL15P_SUP) # 15+ dipl du sup 2015

sup <- dipl %>%
  select(COM, IRIS, 
         P90_NSCOL15P,
         P99_NSCOL15P,
         P10_NSCOL15P,
         P15_NSCOL15P,
         P90_NSCOL15P_S,
         P99_NSCOL15P_S,
         P10_NSCOL15P_S,
         P15_NSCOL15P_S)

# Paris
sup75 <- sup %>%
  summarise(P90_NSCOL15P_S = sum(P90_NSCOL15P_S, na.rm = TRUE) / sum(P90_NSCOL15P, na.rm = TRUE) * 100,
            P99_NSCOL15P_S = sum(P99_NSCOL15P_S, na.rm = TRUE) / sum(P99_NSCOL15P, na.rm = TRUE) * 100,
            P10_NSCOL15P_S = sum(P10_NSCOL15P_S, na.rm = TRUE) / sum(P10_NSCOL15P, na.rm = TRUE) * 100,
            P15_NSCOL15P_S = sum(P15_NSCOL15P_S, na.rm = TRUE) / sum(P15_NSCOL15P, na.rm = TRUE) * 100) %>%
  mutate(id = 75)

# 5e arr
sup75105 <- sup %>%
  filter(COM == '75105') %>%
  group_by(COM) %>%
  summarise(P90_NSCOL15P_S = sum(P90_NSCOL15P_S, na.rm = TRUE) / sum(P90_NSCOL15P, na.rm = TRUE) * 100,
            P99_NSCOL15P_S = sum(P99_NSCOL15P_S, na.rm = TRUE) / sum(P99_NSCOL15P, na.rm = TRUE) * 100,
            P10_NSCOL15P_S = sum(P10_NSCOL15P_S, na.rm = TRUE) / sum(P10_NSCOL15P, na.rm = TRUE) * 100,
            P15_NSCOL15P_S = sum(P15_NSCOL15P_S, na.rm = TRUE) / sum(P15_NSCOL15P, na.rm = TRUE) * 100) %>%
  rename(id = COM)

# Our Neighborhood
sup751050000 <- sup %>%
  filter(IRIS %in% c('751052003', '751051905', '751051906')) %>%
  summarise(P90_NSCOL15P_S = sum(P90_NSCOL15P_S, na.rm = TRUE) / sum(P90_NSCOL15P, na.rm = TRUE) * 100,
            P99_NSCOL15P_S = sum(P99_NSCOL15P_S, na.rm = TRUE) / sum(P99_NSCOL15P, na.rm = TRUE) * 100,
            P10_NSCOL15P_S = sum(P10_NSCOL15P_S, na.rm = TRUE) / sum(P10_NSCOL15P, na.rm = TRUE) * 100,
            P15_NSCOL15P_S = sum(P15_NSCOL15P_S, na.rm = TRUE) / sum(P15_NSCOL15P, na.rm = TRUE) * 100) %>%
  mutate(id = 751050000)

# Our IRIS
supIRIS <- sup %>%
  filter(IRIS %in% c('751052003', '751051905', '751051906')) %>%
  group_by(IRIS) %>%
  summarise(P90_NSCOL15P_S = sum(P90_NSCOL15P_S, na.rm = TRUE) / sum(P90_NSCOL15P, na.rm = TRUE) * 100,
            P99_NSCOL15P_S = sum(P99_NSCOL15P_S, na.rm = TRUE) / sum(P99_NSCOL15P, na.rm = TRUE) * 100,
            P10_NSCOL15P_S = sum(P10_NSCOL15P_S, na.rm = TRUE) / sum(P10_NSCOL15P, na.rm = TRUE) * 100,
            P15_NSCOL15P_S = sum(P15_NSCOL15P_S, na.rm = TRUE) / sum(P15_NSCOL15P, na.rm = TRUE) * 100) %>%
  rename(id = IRIS)

sup <- sup75 %>%
  full_join(sup75105) %>%
  full_join(sup751050000) %>%
  full_join(supIRIS) %>%
  select(id, everything())

