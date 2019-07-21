# set up the theme for plot and rainclound plot
general_theme = theme_bw() +
  theme(
    text = element_text(size = 10),
    axis.title = element_text(size = 16), 
    axis.text = element_text(size = 15), # the size of the texts in plot
    # axis.text.x = element_text(angle = 45, vjust = 0.5),
    legend.title=element_text(size=16),
    legend.text=element_text(size=16),
    # legend.position = "bottom",
    legend.key.width = unit(1.2, "cm"),
    plot.title = element_text(lineheight=.8, face="bold", size = 17),
    panel.border = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    axis.line.x = element_line(colour = 'black', size=0.5, linetype='solid'),
    axis.line.y = element_line(colour = 'black', size=0.5, linetype='solid', arrow = arrow(length = unit(0.3, "cm"))),
    # remove the facet background color
    strip.text = element_text(face="bold", size=15, lineheight=5.0),
    strip.background = element_rect(fill="white", colour="white", size=1),
    strip.placement = "outside"
)
