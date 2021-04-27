import_sirene_with_labels <- function() {
  # Import fichier
  sirene_all <- vroom(
    "data/tables/sirene-all.geocoded.csv",
    delim = ",",
    col_types = cols_only(
      siren = col_character(),
      nic = col_character(),
      siret = col_character(),
      trancheEffectifsEtablissement = col_character(),
      etablissementSiege = col_character(),
      categorieJuridiqueUniteLegale = col_character(),
      denominationUniteLegale = col_character(),
      activitePrincipaleUniteLegale = col_character(),
      trancheEffectifsUniteLegale = col_character(),
      categorieEntreprise = col_character(),
      complementAdresseEtablissement = col_character(),
      numeroVoieEtablissement = col_character(),
      typeVoieEtablissement = col_character(),
      libelleVoieEtablissement = col_character(),
      codePostalEtablissement = col_character(),
      libelleCommuneEtablissement = col_character(),
      distributionSpecialeEtablissement = col_character(),
      codeCommuneEtablissement = col_character(),
      codeCedexEtablissement = col_character(),
      libelleCedexEtablissement = col_character(),
      enseigne1Etablissement = col_character(),
      denominationUsuelleEtablissement = col_character(),
      activitePrincipaleEtablissement = col_character(),
      caractereEmployeurEtablissement = col_character(),
      latitude = col_character(),
      longitude = col_character()
    )
  )
  
  # Variables
  sirene_all <- sirene_all %>%
    sjlabelled::var_labels(
      trancheEffectifsEtablissement = "Effectif établissement",
      trancheEffectifsUniteLegale = "Effectif unité légale"
    )
  
  # Valeurs
  sirene_all <- sirene_all %>%
    sjlabelled::val_labels(
      trancheEffectifsEtablissement = c(
        "NN" = "Établissement non employeur",
        "00" = "0 salarié au 31/12 (mais dans l'année)",
        "01" = "1 ou 2 salariés",
        "02" = "3 à 5 salariés",
        "03" = "6 à 9 salariés",
        "11" = "10 à 19 salariés",
        "12" = "20 à 49 salariés",
        "21"= "50 à 99 salariés",
        "22" = "100 à 199 salariés",
        "31" = "200 à 249 salariés",
        "32" = "250 à 499 salariés",
        "41" = "500 à 999 salariés",
        "42" = "1 000 à 1 999 salariés",
        "51" = "2 000 à 4 999 salariés",
        "52" = "5 000 à 9 999 salariés",
        "53" = "10 000 salariés et plus"
      ),
      trancheEffectifsUniteLegale = c(
        "NN" = "Établissement non employeur",
        "00" = "0 salarié au 31/12 (mais dans l'année)",
        "01" = "1 ou 2 salariés",
        "02" = "3 à 5 salariés",
        "03" = "6 à 9 salariés",
        "11" = "10 à 19 salariés",
        "12" = "20 à 49 salariés",
        "21"= "50 à 99 salariés",
        "22" = "100 à 199 salariés",
        "31" = "200 à 249 salariés",
        "32" = "250 à 499 salariés",
        "41" = "500 à 999 salariés",
        "42" = "1 000 à 1 999 salariés",
        "51" = "2 000 à 4 999 salariés",
        "52" = "5 000 à 9 999 salariés",
        "53" = "10 000 salariés et plus"
      ),
      
    )
  
  # Codes NAF : https://www.insee.fr/fr/information/2120875
  # (2 premières lignes supprimées car mise en page)
  
  # Codes Tous niveaux
  codes_naf_tous_niv <- read_excel("data/tables/naf2008_5_niveaux.xls") %>%
    rename(
      activitePrincipaleUniteLegale = NIV5,
      naf.niv4 = NIV4,
      naf.niv3 = NIV3,
      naf.niv2 = NIV2,
      sectionActivitePrincipaleUniteLegale = NIV1
    )
  # Libellés niveau 1
  codes_naf_libelles_niv_1 <- read_excel("data/tables/naf2008_liste_n1.xls") %>%
    rename(
      sectionActivitePrincipaleUniteLegale = Code,
      libelleSectionActivitePrincipaleUniteLegale = Libellé
    )
  
  # Libellés niveau 2
  codes_naf_libelles_niv_2 <- read_excel("data/tables/naf2008_liste_n2.xls") %>%
    rename(
      naf.niv2 = Code,
      naf.niv2.libelle = Libellé
    )
  
  # Libellés niveau 3
  codes_naf_libelles_niv_3 <- read_excel("data/tables/naf2008_liste_n3.xls") %>%
    rename(
      naf.niv3 = Code,
      naf.niv3.libelle = Libellé
    )
  
  # Libellés niveau 4
  codes_naf_libelles_niv_4 <- read_excel("data/tables/naf2008_liste_n4.xls") %>%
    rename(
      naf.niv4 = Code,
      naf.niv4.libelle = Libellé
    )
  
  # Libellés niveau 5
  codes_naf_libelles_niv_5 <- read_excel("data/tables/naf2008_liste_n5.xls") %>%
    rename(
      activitePrincipaleUniteLegale = Code,
      libelleActivitePrincipaleUniteLegale = Libellé
    )
  
  # Ajout des codes NAF et libellés
  sirene_all <- sirene_all %>%
    left_join(codes_naf_tous_niv, by = "activitePrincipaleUniteLegale") %>%
    left_join(codes_naf_libelles_niv_1, by = "sectionActivitePrincipaleUniteLegale") %>%
    left_join(codes_naf_libelles_niv_2, by = "naf.niv2") %>%
    left_join(codes_naf_libelles_niv_3, by = "naf.niv3") %>%
    left_join(codes_naf_libelles_niv_4, by = "naf.niv4") %>%
    left_join(codes_naf_libelles_niv_5, by = "activitePrincipaleUniteLegale")
  
  sirene_all
}