tmpfn <- "interaction"


res_value = 350
res_rela = 90
w = 650/res_rela*res_value
h = 804/res_rela*res_value

png(file= paste0(tmpfn, ".png") ,width=w,height=h, res = res_value)

#plot
inter.LinePlot

dev.off()

  