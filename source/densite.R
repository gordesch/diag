departement_IRIS <- import_departement_IRIS() %>%
  full_join(import_epci_COM(), by = "INSEE_COM") %>%
  full_join(import_unite_urbaine_IRIS(), by = "CODE_IRIS") %>%
  inner_join(import_demographie_departement_IRIS(), by = c("CODE_IRIS", "INSEE_COM")) %>%
  mutate(
    IRIS_NUMBER = substr(CODE_IRIS, 6, 9)
  )

# Calcul de la densité, par IRIS
departement_IRIS <- departement_IRIS %>%
  mutate(POPDENS = 1e6 * P17_POP / st_area(geometry))

# Filtre EPCI
epci_IRIS <- departement_IRIS %>%
  filter(EPCI %in% !!codes_epci)

# Filtre unité urbaine
unite_urbaine_IRIS <- departement_IRIS %>%
  filter(UU2010 %in% !!codes_unite_urbaine)

# Filtre IRIS de la commune
commune_IRIS <- departement_IRIS %>%
  filter(INSEE_COM %in% !!codes_insee_com)

# Filtre IRIS de la zone d'étude
zone_IRIS <- departement_IRIS %>%
  filter(CODE_IRIS %in% !!codes_IRIS_zone)

# Densité des communes du département
departement_COM <- import_departement_IRIS() %>%
  inner_join(import_demographie_departement_IRIS(), by = c("INSEE_COM", "CODE_IRIS")) %>%
  full_join(import_epci_COM(), by = "INSEE_COM") %>%
  full_join(import_unite_urbaine_IRIS(), by = "CODE_IRIS") %>%
  group_by(INSEE_COM, EPCI, UU2010) %>%
  summarise(P17_POP = sum(P17_POP), .groups = "keep") %>%
  mutate(POPDENS = 1e6 * P17_POP / st_area(geometry))

# Communes de l'EPCI
epci_COM <- departement_COM %>%
  filter(EPCI %in% !!codes_epci)

# Communes de l'unité urbaine
unite_urbaine_COM <- departement_COM %>%
  filter(UU2010 %in% !!codes_unite_urbaine)

# Périmètre de la zone d'étude
zone <- zone_IRIS
zone <- st_boundary(st_union(st_as_sf(zone)))

teo <- read_sf("data/spatial/teo/teo.shp")
