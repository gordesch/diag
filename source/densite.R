source("source/functions/imports_density_map.R")

# IRIS du département
departement_IRIS <- import_departement_IRIS()

# Ajout des données démographiques, par IRIS
departement_IRIS <- departement_IRIS %>%
  left_join(
    import_demographie_departement_IRIS(),
    by = "CODE_IRIS"
  )

# Calcul de la densité, par IRIS
departement_IRIS <- departement_IRIS %>%
  mutate(POPDENS = 1e6 * P17_POP / st_area(geometry))

# Ajout de l'unité urbaine
departement_IRIS <- departement_IRIS %>%
  left_join(
    import_unite_urbaine_IRIS(),
    by = "CODE_IRIS"
  )

# Filtre unité urbaine
unite_urbaine_IRIS <- departement_IRIS %>%
  filter(UU2010 %in% codes_unite_urbaine)

# IRIS de la commune
commune_IRIS <- departement_IRIS %>%
  filter(INSEE_COM %in% !!codes_insee_com)

# IRIS de la zone d'étude
zone_IRIS <- departement_IRIS %>%
  filter(CODE_IRIS %in% !!codes_IRIS_zone)

# Périmètre de la zone d'étude
zone <- zone_IRIS
zone <- st_boundary(st_union(zone))

# Communes du département
departement_COM <- departement_IRIS %>%
  group_by(INSEE_COM) %>%
  summarise(
    P17_POP = sum(P17_POP),
  ) %>%
  mutate(POPDENS = 1e6 * P17_POP / st_area(geometry))

# Communes de l'unité urbaine
unite_urbaine_COM <- departement_IRIS %>%
  filter(UU2010 %in% codes_unite_urbaine) %>%
  group_by(INSEE_COM) %>%
  summarise(
    P17_POP = sum(P17_POP),
  ) %>%
  mutate(POPDENS = 1e6 * P17_POP / st_area(geometry))

teo <- read_sf("data/spatial/teo/teo.shp")
