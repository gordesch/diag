library(tidyverse) # Utilities
library(openxlsx) # Excel exports

# Import data
empl90 <- read.csv("data/emploi-1990.csv") %>% as_tibble()
empl99 <- read.csv("data/emploi-1999.csv") %>% as_tibble()
empl10 <- read.csv("data/emploi-2010.csv") %>% as_tibble()
empl15 <- read.csv("data/emploi-2015.csv") %>% as_tibble()

# Simplify and merge
empl90<- empl90 %>%
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
empl99 <- empl99 %>%
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
empl10 <- empl10 %>%
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
empl15 <- empl15 %>%
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
empl <- empl90 %>%
  full_join(empl99) %>%
  full_join(empl10) %>%
  full_join(empl15)

empl75 <- empl %>%
  summarise(C90_ACT1564_CS1 = sum(AT90TAG, na.rm = TRUE) / sum(AT90TA, na.rm = TRUE) * 100,
            C99_ACT1564_CS1 = sum(AT99TAG, na.rm = TRUE) / sum(AT99TA, na.rm = TRUE) * 100,
            C10_ACT1564_CS1 = sum(C10_ACT1564_CS1, na.rm = TRUE) / sum(C10_ACT1564, na.rm = TRUE) * 100,
            C15_ACT1564_CS1 = sum(C15_ACT1564_CS1, na.rm = TRUE) / sum(C15_ACT1564, na.rm = TRUE) * 100,
            C90_ACT1564_CS2 = sum(AT90TAR, na.rm = TRUE) / sum(AT90TA, na.rm = TRUE) * 100,
            C99_ACT1564_CS2 = sum(AT99TAR, na.rm = TRUE) / sum(AT99TA, na.rm = TRUE) * 100,
            C10_ACT1564_CS2 = sum(C10_ACT1564_CS2, na.rm = TRUE) / sum(C10_ACT1564, na.rm = TRUE) * 100,
            C15_ACT1564_CS2 = sum(C15_ACT1564_CS2, na.rm = TRUE) / sum(C15_ACT1564, na.rm = TRUE) * 100,) %>%
  mutate(id = 75)