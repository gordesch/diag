add_ca <- function(data) {
  endpoint = "https://opendata.datainfogreffe.fr/api/records/1.0/search/"
  siren_chunks <- split(sirene_all$siren, ceiling(seq_along(sirene_all$siren)/1000))
  
  chiffres_cles_results <- tibble()
  for(i in 1:length(siren_chunks)) {
    siren_list = paste0(siren_chunks[[i]], collapse = " OR ")
    params = list(
      dataset = "chiffres-cles-2019",
      token = "5ePm83u88KivX94feM4oG0XeEtU0QAxzWZPgFmYtnDLL3xinMIhj2yrKuwwelzS",
      q = paste0("siren:(", siren_list, ")"),
      rows = 1000
    )
    cat(paste("\n# Download chunk: ", i ,"on", length(siren_chunks), "\n"))
    chiffres_cles <- POST(endpoint, body = params, progress("down"))
    chiffres_cles_json <- fromJSON(content(chiffres_cles, "text"))
    chiffres_cles_results <- bind_rows(
      chiffres_cles_results,
      as_tibble(chiffres_cles_json$records$fields)
    )
  }

  data %>%
    left_join(
      chiffres_cles_results %>% select(siren, starts_with("tranche_ca")),
      by = "siren"
    ) %>%
    mutate_at(
      .vars = vars(starts_with("tranche_ca")),
      ~replace(., is.na(.), "Inconnu")
    ) %>%
    mutate_at(
      .vars = vars(starts_with("tranche_ca")),
      .fun= factor,
      levels = c(
        "Inconnu",
        "A - de 32K",
        "B entre 32K et 82K",
        "C entre 82K et 250K",
        "D entre 250K et 1M",
        "E + d 1M"
      ),
      ordered = TRUE
    ) %>%
    rowwise() %>%
    mutate(CA = pmax(
      tranche_ca_millesime_1,
      tranche_ca_millesime_2,
      tranche_ca_millesime_3
    )) %>%
    ungroup() %>%
    select(-starts_with("tranche_ca"))
}