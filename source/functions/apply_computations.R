apply_computations <- function (table_IRIS, compute_stats, geo_levels) {
  # France (métrop.)
  statsNAT <- table_IRIS %>%
    compute_stats %>%
    mutate(id = "France (métrop.)")
  
  # Département
  statsDEP <- table_IRIS %>%
    filter(DEP %in% !!codes_dep) %>%
    compute_stats %>%
    mutate(id = !!nom_dep)
  
  # Commune
  statsCOM <- table_IRIS %>%
    filter(COM %in% !!codes_com) %>%
    compute_stats %>%
    mutate(id = !!nom_comm)
  
  
  # Zone d'étude, groupée
  statsGROUP <- table_IRIS %>%
    filter(IRIS %in% !!codes_IRIS_zone) %>%
    compute_stats %>%
    mutate(id = !!nom_zone)
  
  # Zone d'étude, chaque IRIS
  statsIRIS <- table_IRIS %>%
    filter(IRIS %in% !!codes_IRIS_zone) %>%
    group_by(IRIS) %>%
    compute_stats %>%
    rename(id = IRIS)
  
  # Tableau complet
  stats <- statsNAT[0,]
  if ("NAT"   %in% geo_levels) stats <- bind_rows(stats, statsNAT)
  if ("DEP"   %in% geo_levels) stats <- bind_rows(stats, statsDEP)
  if ("COM"   %in% geo_levels) stats <- bind_rows(stats, statsCOM)
  if ("GROUP" %in% geo_levels) stats <- bind_rows(stats, statsGROUP)
  if ("IRIS"  %in% geo_levels) stats <- bind_rows(stats, statsIRIS)
  stats <- stats %>%
    select(id, everything())
} 