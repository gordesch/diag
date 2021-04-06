plot_stbrieuc <- function(sf_in_viewport) {
  bbox <- st_bbox(sf_in_viewport)
  list(
    coord_sf(
      xlim = c(bbox$xmin, bbox$xmax),
      ylim = c(bbox$ymin, bbox$ymax),
      crs = 2154
    ),
    theme(
      panel.background = element_rect(
        fill = "gray99",
        size = 0
      ),
      axis.line=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks=element_blank(),
      axis.title.x=element_blank(),
      axis.title.y=element_blank(),
    )
  )
}