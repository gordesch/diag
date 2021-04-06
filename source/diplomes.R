# Import des données
dipl_IRIS <- read_delim(
  "data/tables/base-ic-diplomes-formation-2017_csv/base-ic-diplomes-formation-2017.CSV",
  delim = ";",
  locale = locale("fr", decimal_mark = "."),
  col_types = cols_only(
    IRIS = col_character(),
    COM = col_character(),
    P17_NSCOL15P = col_number(),
    P17_NSCOL15P_DIPLMIN = col_number(),
    P17_NSCOL15P_BEPC = col_number(),
    P17_NSCOL15P_CAPBEP = col_number(),
    P17_NSCOL15P_BAC = col_number(),
    P17_NSCOL15P_SUP2 = col_number(),
    P17_NSCOL15P_SUP34 = col_number(),
    P17_NSCOL15P_SUP5 = col_number()
  )
)

# Simplification
dipl_IRIS <- dipl_IRIS %>%
  rename(DEPCOM = COM) %>%
  extract(
    DEPCOM,
    c('DEP', 'COM'),
    "([0-9]{2})([0-9]{3})",
    remove = FALSE
  )

# Prepare data
dipl_IRIS <- dipl_IRIS %>%
  mutate(
    # Regroupage des sans diplôme et BEPC
    P17_NSCOL15P_DIPLMINBEPC = P17_NSCOL15P_DIPLMIN + P17_NSCOL15P_BEPC,
    # Regroupage de l'enseignement supérieur
    P17_NSCOL15P_SUP = P17_NSCOL15P_SUP2 + P17_NSCOL15P_SUP34 + P17_NSCOL15P_SUP5
  ) %>%
  select(DEP, COM, IRIS, 
         P17_NSCOL15P,
         P17_NSCOL15P_DIPLMINBEPC,
         P17_NSCOL15P_CAPBEP,
         P17_NSCOL15P_BAC,
         P17_NSCOL15P_SUP
  )

# Apply computations to geo levels
source("source/functions/apply_computations.R")
dipl_stats <- apply_computations(
  dipl_IRIS,
  compute_stats_dipl,
  geo_levels_dipl
)