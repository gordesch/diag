correct_geoloc_airport <- function(data, long, lat) {
  aeroport <- data %>%
    filter(
      codePostalEtablissement == "67960", # Entzheim
      (
        grepl("EUROPE", libelleVoieEtablissement)
        | grepl("221", libelleVoieEtablissement)
        | grepl("AEROPORT", libelleVoieEtablissement)
        | grepl("AEROGARE", complementAdresseEtablissement)
      )
    ) %>%
    mutate(
      latitude = lat,
      longitude = long
    )
  
  data <- data %>% rows_update(aeroport, by = "siret")
  
  remove(aeroport)
  
  data
}