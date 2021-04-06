# Import des données
demog_IRIS <- read_delim(
  "data/tables/base-ic-evol-struct-pop-2017_csv/base-ic-evol-struct-pop-2017.CSV",
  delim = ";",
  locale = locale("fr", decimal_mark = "."),
  col_types = cols_only(
    IRIS = col_character(),
    COM = col_character(),
    P17_POP = col_number(),
    P17_POP0014 = col_number(),
    P17_POP1529 = col_number(),
    P17_POP3044 = col_number(),
    P17_POP4559 = col_number(),
    P17_POP6074 = col_number(),
    P17_POP75P = col_number(),
    P17_POPH = col_number(),
    P17_POPF = col_number()
  )
)

# Simplification
demog_IRIS <- demog_IRIS %>%
  rename(DEPCOM = COM) %>%
  extract(
    DEPCOM,
    c('DEP', 'COM'),
    "([0-9]{2})([0-9]{3})",
    remove = FALSE
  )

# Apply computations to geo levels
source("source/functions/apply_computations.R")
demog_stats <- apply_computations(
  demog_IRIS,
  compute_stats_demog,
  geo_levels_demog
)