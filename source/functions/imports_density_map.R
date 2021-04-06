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
  ) %>% rename(CODE_IRIS = IRIS)
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
    filter(EPCI == code_epci)
}
