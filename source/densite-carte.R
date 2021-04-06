library(mapsf)
source("functions/imports-carte-densite.R")

code_unite_urbaine <- "22501"
code_commune <- "22278"
codes_IRIS_zone <- c(
  "222780101",
  "222780102",
  "222780103",
  "222780104",
  "222780105"
)

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
  filter(UU2010 == !!code_unite_urbaine)

# IRIS de la commune
commune_IRIS <- departement_IRIS %>%
  filter(INSEE_COM == !!code_commune)

# IRIS de la zone d'étude
zone_IRIS <- departement_IRIS %>%
  filter(CODE_IRIS %in% c(
    !!codes_IRIS_zone
  ))

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
  filter(UU2010 == !!code_unite_urbaine) %>%
  group_by(INSEE_COM) %>%
  summarise(
    P17_POP = sum(P17_POP),
  ) %>%
  mutate(POPDENS = 1e6 * P17_POP / st_area(geometry))

teo <- read_sf("data/teo.shp")

# Initiate a base map
# Plot Dep22

mf_init(x = commune_IRIS)
mf_theme(
  x = "default",
  bg = "blue",
  fg = "blue"
)
# plot COMMUNES
mf_map(
  departement_COM,
  type = "base",
  border = "white",
  add = TRUE
)
# plot IRIS 
mf_map(commune_IRIS, 
  var = "POPDENS",
  type = "choro",
  breaks = "geom",
  nbreaks=5,
  col = "Mint",
  pal = "Reds 2",
  border = "gray17", 
  lwd = 0.5,
  leg_pos = "topleft1", 
  leg_title = "Densité de population\n(habitants par km2)",
  add = TRUE
)
# plot TEO
mf_map(
  teo,
  type = "typo",
  var= "type",
  pal = c("cornflowerblue"),
  lwd = 6,
  leg_pos = "bottomleft2", 
  leg_title = "Projet en cours",
  add = TRUE
)
# layout
mf_layout(
  title = "Saint-Brieuc – Densité de population", 
  credits = paste(
    "Données démographiques : Insee, 2017.",
    "Fond de carte : IGN, 2020.",
    "Réalisation : Repérage Urbain, 2021."))