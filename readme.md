# Diagnostic socio-démographique

## Installation

Note : ce projet nécessite d'avoir R et Rstudio installé sur votre machine.

Installer `renv`
```r
if (!requireNamespace("remotes"))
  install.packages("remotes")

remotes::install_github("rstudio/renv")
```
Installer les packages du projet
```r
renv::restore()
```

## Données

### Statistiques
INSEE, 2017

### Cartes

#### IRIS

Contour…IRIS® édition 2020, INSEE et IGN, [licence ouverte Etalab 2.0](https://www.etalab.gouv.fr/licence-ouverte-open-licence) :
https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html#contoursiris