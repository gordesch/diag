apply_computations <- function (table_IRIS, compute_stats, geo_levels) {
  # Tableau complet
  stats <- tibble()
  
  # France (métrop.)
  if ("NAT" %in% geo_levels) {
    statsNAT <- table_IRIS %>%
      compute_stats %>%
      mutate(id = "France (métrop.)")
    stats <- bind_rows(stats, statsNAT)
  }
  
  # Département
  if ("DEP" %in% geo_levels) {
    statsDEP <- table_IRIS %>%
      filter(substr(INSEE_COM, 1, 2) %in% !!codes_dep) %>%
      compute_stats %>%
      mutate(id = !!nom_dep)
    stats <- bind_rows(stats, statsDEP)
  }
  
  # EPCI
  if ("EPCI" %in% geo_levels) {
    statsEPCI <- table_IRIS %>%
      filter(EPCI %in% !!codes_epci) %>%
      compute_stats %>%
      mutate(id = !!nom_epci)
    stats <- bind_rows(stats, statsEPCI)
  }
  
  # Groupe de communes
  if ("GROUP_COM" %in% geo_levels) {
    statsCOM <- table_IRIS %>%
      filter(INSEE_COM %in% !!codes_insee_com) %>%
      compute_stats %>%
      mutate(id = !!nom_group_com)
    stats <- bind_rows(stats, statsCOM)
  }
  
  # Communes
  if ("COM" %in% geo_levels) {
    statsCOM <- table_IRIS %>%
      filter(INSEE_COM %in% !!codes_insee_com) %>%
      group_by(NOM_COM) %>%
      compute_stats %>%
      rename(id = NOM_COM)
    stats <- bind_rows(stats, statsCOM)
  }
  
  # Zone d'étude, groupée
  if ("GROUP_IRIS" %in% geo_levels) {
    statsGROUP <- table_IRIS %>%
      filter(CODE_IRIS %in% !!codes_IRIS_zone) %>%
      compute_stats %>%
      mutate(id = !!nom_zone)
    stats <- bind_rows(stats, statsGROUP)
  }
  
  # Zone d'étude, chaque IRIS
  if ("IRIS"  %in% geo_levels) {
    statsIRIS <- table_IRIS %>%
      filter(IRIS %in% !!codes_IRIS_zone) %>%
      group_by(IRIS) %>%
      compute_stats %>%
      rename(id = IRIS)
    stats <- bind_rows(stats, statsIRIS)
  }
  
  # Id au début du tableau
  stats <- stats %>%
    select(id, everything())
} 