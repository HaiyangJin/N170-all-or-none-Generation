lmm.opt <- lmm.opt.N170.high.E205

tmp.summary <- summary(lmm.opt)

write.csv(as.data.frame(tmp.summary$coefficients), "fixed_table.csv")



#########################################

# tmp.df <- data.frame(emm.avg) %>% 
#   select(Type, Hemisphere, Category, everything())
# 
# write_csv(tmp.df, "emm_table.csv")

