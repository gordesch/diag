plot_stbrieuc <- function() {
  list(
    coord_sf(
      xlim = c(269844, 279480),
      ylim = c(6836000, 6842000),
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
