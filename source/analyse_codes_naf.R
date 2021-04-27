sirene_naf_1 <- sirene_naf %>%
  group_by(
    libelleSectionActivitePrincipaleUniteLegale,
  ) %>%
  count(name = "n_naf_1", sort = TRUE)

sirene_naf_2 <- sirene_naf %>%
group_by(
  naf.niv2.libelle,
) %>%
  count(name = "n_naf_2", sort = TRUE)

sirene_naf_3 <- sirene_naf %>%
group_by(
  naf.niv3.libelle,
) %>%
  count(name = "n_naf_3", sort = TRUE)

sirene_naf_4 <- sirene_naf %>%
group_by(
  naf.niv4.libelle,
) %>%
  count(name = "n_naf_4", sort = TRUE)

sirene_naf_5 <- sirene_naf %>%
group_by(
  libelleActivitePrincipaleUniteLegale,
) %>%
  count(name = "n_naf_5", sort = TRUE)

sirene_naf_subtotals <- sirene_naf %>%
  select(-siren, -denominationUniteLegale) %>%
  distinct() %>%
  left_join(sirene_naf_5, by = "libelleActivitePrincipaleUniteLegale") %>%
  left_join(sirene_naf_4, by = "naf.niv4.libelle") %>%
  left_join(sirene_naf_3, by = "naf.niv3.libelle") %>%
  left_join(sirene_naf_2, by = "naf.niv2.libelle") %>%
  left_join(sirene_naf_1, by = "libelleSectionActivitePrincipaleUniteLegale") %>%
  select(
    n_naf_5,
    libelleActivitePrincipaleUniteLegale,
    n_naf_4,
    naf.niv4.libelle,
    n_naf_3,
    naf.niv3.libelle,
    n_naf_2,
    naf.niv2.libelle,
    n_naf_1,
    libelleSectionActivitePrincipaleUniteLegale
  )

write.xlsx(sirene_naf_subtotals, "data/tables/etablissements_naf_grouped.xlsx")

sirene_naf_subtotals <- sirene_naf %>%
  left_join(sirene_naf_5, by = "libelleActivitePrincipaleUniteLegale") %>%
  left_join(sirene_naf_4, by = "naf.niv4.libelle") %>%
  left_join(sirene_naf_3, by = "naf.niv3.libelle") %>%
  left_join(sirene_naf_2, by = "naf.niv2.libelle") %>%
  left_join(sirene_naf_1, by = "libelleSectionActivitePrincipaleUniteLegale")

write.xlsx(sirene_naf_subtotals, "data/tables/etablissements_naf.xlsx")
