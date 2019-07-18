lmm.opt <- lmm.opt.rt

tmp.summary <- summary(lmm.opt)

write.csv(as.data.frame(tmp.summary$coefficients), "fixed_table.csv")



#########################################

tmp.df <- data.frame(emm.avg) %>% 
  select(Type, Hemisphere, Category, everything())

write_csv(tmp.df, "emm_table.csv")

