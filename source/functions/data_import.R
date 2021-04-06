import_departement_IRIS <- function () {
  read_sf("data/spatial/dep22/dep22.shp") %>%
    select(
      INSEE_COM,
      NOM_COM,
      CODE_IRIS,
      NOM_IRIS,
      geometry
    )
}

import_demographie_departement_IRIS <- function () {
  read_delim(
    "data/tables/base-ic-evol-struct-pop-2017_csv/base-ic-evol-struct-pop-2017.CSV",
    delim = ";",
    locale = locale("fr", decimal_mark = "."),
    col_types = cols_only(
      IRIS = col_character(),
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
  ) %>% rename(CODE_IRIS = IRIS) %>%
    extract(
      CODE_IRIS,
      c('INSEE_COM'),
      "([0-9]{5})",
      remove = FALSE
    )
}

import_csp_departement_IRIS <- function () {
  read_delim(
    "data/tables/base-ic-evol-struct-pop-2017_csv/base-ic-evol-struct-pop-2017.CSV",
    delim = ";",
    locale = locale("fr", decimal_mark = "."),
    col_types = cols_only(
      IRIS = col_character(),
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
  ) %>% rename(CODE_IRIS = IRIS) %>%
    extract(
      CODE_IRIS,
      c('INSEE_COM'),
      "([0-9]{5})",
      remove = FALSE
    )
}

import_dipl_departement_IRIS <- function () {
  read_delim(
    "data/tables/base-ic-diplomes-formation-2017_csv/base-ic-diplomes-formation-2017.CSV",
    delim = ";",
    locale = locale("fr", decimal_mark = "."),
    col_types = cols_only(
      IRIS = col_character(),
      P17_NSCOL15P = col_number(),
      P17_NSCOL15P_DIPLMIN = col_number(),
      P17_NSCOL15P_BEPC = col_number(),
      P17_NSCOL15P_CAPBEP = col_number(),
      P17_NSCOL15P_BAC = col_number(),
      P17_NSCOL15P_SUP2 = col_number(),
      P17_NSCOL15P_SUP34 = col_number(),
      P17_NSCOL15P_SUP5 = col_number()
    )
  ) %>% rename(CODE_IRIS = IRIS) %>%
    extract(
      CODE_IRIS,
      c('INSEE_COM'),
      "([0-9]{5})",
      remove = FALSE
    ) %>%
    mutate(
      # Regroupage des sans diplôme et BEPC
      P17_NSCOL15P_DIPLMINBEPC = P17_NSCOL15P_DIPLMIN + P17_NSCOL15P_BEPC,
      # Regroupage de l'enseignement supérieur
      P17_NSCOL15P_SUP = P17_NSCOL15P_SUP2 + P17_NSCOL15P_SUP34 + P17_NSCOL15P_SUP5
    ) %>%
    select(INSEE_COM, CODE_IRIS, 
           P17_NSCOL15P,
           P17_NSCOL15P_DIPLMINBEPC,
           P17_NSCOL15P_CAPBEP,
           P17_NSCOL15P_BAC,
           P17_NSCOL15P_SUP
    )
}

import_etud_departement_IRIS <- function () {
  read_delim(
    "data/tables/base-ic-diplomes-formation-2017_csv/base-ic-diplomes-formation-2017.CSV",
    delim = ";",
    locale = locale("fr", decimal_mark = "."),
    col_types = cols_only(
      IRIS = col_character(),
      P17_POP1824 = col_number(),
      P17_POP2529 = col_number(),
      P17_SCOL1824 = col_number(),
      P17_SCOL2529 = col_number()
    )
  ) %>% rename(CODE_IRIS = IRIS) %>%
    extract(
      CODE_IRIS,
      c('INSEE_COM'),
      "([0-9]{5})",
      remove = FALSE
    )
}

import_unite_urbaine_IRIS <- function () {
  read_delim(
    "data/tables/iris-uu-saintbrieuc.csv",
    delim = ";",
    locale = locale("fr", decimal_mark = "."),
    col_types = cols_only(
      CODE_IRIS = col_character(),
      UU2010 = col_character()
    )
  )
}

import_epci_COM <- function() {
  read_delim(
    "data/tables/epci.csv",
    delim = ",",
    locale = locale("fr", decimal_mark = "."),
    col_types = cols_only(
      CODGEO = col_character(),
      EPCI = col_character()
    )
  ) %>%
    rename(INSEE_COM = CODGEO) %>%
    filter(EPCI %in% !!codes_epci)
}
