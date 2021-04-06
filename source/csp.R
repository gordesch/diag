# Import des données
csp_IRIS <- read_delim(
  "data/tables/base-ic-evol-struct-pop-2017_csv/base-ic-evol-struct-pop-2017.CSV",
  delim = ";",
  locale = locale("fr", decimal_mark = "."),
  col_types = cols_only(
    IRIS = col_character(),
    COM = col_character(),
    C17_POP15P = col_number(),
    C17_POP15P_CS1 = col_number(),
    C17_POP15P_CS2 = col_number(),
    C17_POP15P_CS3 = col_number(),
    C17_POP15P_CS4 = col_number(),
    C17_POP15P_CS5 = col_number(),
    C17_POP15P_CS6 = col_number(),
    C17_POP15P_CS7 = col_number(),
    C17_POP15P_CS8 = col_number()
  )
)

# Simplification
csp_IRIS <- csp_IRIS %>%
  rename(DEPCOM = COM) %>%
  extract(
    DEPCOM,
    c('DEP', 'COM'),
    "([0-9]{2})([0-9]{3})",
    remove = FALSE
  )

# Apply computations to geo levels
source("source/functions/apply_computations.R")
csp_stats <- apply_computations(
  csp_IRIS,
  compute_stats_csp,
  geo_levels_csp
)