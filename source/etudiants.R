# Import des données
etud_IRIS <- read_delim(
  "data/tables/base-ic-diplomes-formation-2017_csv/base-ic-diplomes-formation-2017.CSV",
  delim = ";",
  locale = locale("fr", decimal_mark = "."),
  col_types = cols_only(
    IRIS = col_character(),
    COM = col_character(),
    P17_POP1824 = col_number(),
    P17_POP2529 = col_number(),
    P17_SCOL1824 = col_number(),
    P17_SCOL2529 = col_number()
  )
)

# Simplification
etud_IRIS <- etud_IRIS %>%
  rename(DEPCOM = COM) %>%
  extract(
    DEPCOM,
    c('DEP', 'COM'),
    "([0-9]{2})([0-9]{3})",
    remove = FALSE
  )

# Apply computations to geo levels
source("source/functions/apply_computations.R")
etud_stats <- apply_computations(
  etud_IRIS,
  compute_stats_etud,
  geo_levels_etud
)