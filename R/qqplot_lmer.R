qqplot_lmer <- function(lmm) {
  df <- data.frame(resi = residuals(lmm))
  
  g <- {
    ggplot(df, aes(sample = resi)) +
      stat_qq() +
      stat_qq_line()
  }
  return(g)
}