adapt90 <- function(tibble) {
  tibble %>%
    select(-IRIS, -COMP9099) %>%
    rename(IRIS = DCOMIRIS, COM = DEPCOM)
}

adapt99 <- function (tibble) {
  tibble %>%
    select(-IRIS, -COMP9099) %>%
    rename(IRIS = DCOMIRIS, COM = DEPCOM)
}
simplify <- function(tibble) {
  tibble %>%
    select(-DEP,
           -REG,
           -UU2010,
           -LIBCOM,
           -TRIRIS,
           -GRD_QUART,
           -LIBIRIS,
           -TYP_IRIS,
           -MODIF_IRIS,
           -LAB_IRIS)
}