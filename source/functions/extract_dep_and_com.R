# Extrait le numéro de département d'un IRIS
extract_codes_dep <- function(iris_vector) {
  codes_dep <- c()
  for (code_iris in iris_vector) {
    code_dep <- substr(code_iris, 1, 2)
    if (!code_dep %in% codes_dep) codes_dep <- c(codes_dep, code_dep)
  }
  codes_dep
}

# Extrait le code commune d'un IRIS
extract_codes_com <- function(iris_vector) {
  codes_com <- c()
  for (code_iris in iris_vector) {
    code_com <- substr(code_iris, 3, 5)
    if (!code_com %in% codes_com) codes_com <- c(codes_com, code_com)
  }
  codes_com
}

# Extrait le code commune COMPLET d'un IRIS
extract_codes_insee_com <- function(iris_vector) {
  codes_insee_com <- c()
  for (code_iris in iris_vector) {
    code_insee_com <- substr(code_iris, 1, 5)
    if (!code_insee_com %in% codes_insee_com) codes_insee_com <- c(codes_insee_com, code_insee_com)
  }
  codes_insee_com
}