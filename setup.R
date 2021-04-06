# Bases de données et fichiers détails du recensement de la population
# URL stable : https://www.data.gouv.fr/fr/datasets/r/76d535cc-4670-4dc0-8627-1bba2a9d3b16
# URL actuelle : https://www.insee.fr/fr/information/4467366

# IRIS... GE
# URL actuelle : https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html#irisge

import_data <- function (file_url, file_name, file_downloaded_type) {
  file_path <- paste0("data/", file_name)
  
  # Dowload
  cat(paste("\n# Download start:", file_name, "\n"))
  parsed_url <- parse_url(file_url)
  if(parsed_url$scheme == "ftp") {
    curl::curl_download(
      file_url,
      path.expand(file_path),
      quiet = FALSE
    )
  } else {
    httr::GET(
      url = file_url,
      write_disk(path.expand(file_path), overwrite=TRUE),
      progress("down")
    )
  }
  
  # Unzip
  cat(paste("\n# Unzip start:", file_name, "\n"))
  if(file_downloaded_type == 'zip') unzip(file_path , exdir = file_path)
}

data_to_download <- tibble(
  "file_url" = character(),
  "file_name" = character(),
  "file_downloaded_type" = character()
) %>%
  add_row(
    "file_url" = "https://www.insee.fr/fr/statistiques/fichier/4799309/base-ic-evol-struct-pop-2017_csv.zip",
    "file_name" = "evol-struct-pop",
    "file_downloaded_type" = "zip"
  ) %>%
  add_row(
    "file_url" = "https://www.insee.fr/fr/statistiques/fichier/4799252/base-ic-diplomes-formation-2017_csv.zip",
    "file_name" = "diplomes-formation",
    "file_downloaded_type" = "zip",
  ) %>%
  add_row(
    "file_url" = "ftp://Iris_GE_ext:eeLoow1gohS1Oot9@ftp3.ign.fr/IRIS-GE_2-0__SHP_LAMB93_D022_2020-01-01.7z.001",
    "file_name" = "departement22",
    "file_downloaded_type" = "zip"
  )
pmap(
  list(
    data_to_download$file_url,
    data_to_download$file_name,
    data_to_download$file_downloaded_type
  ),
  .f = import_data
)