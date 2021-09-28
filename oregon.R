library(maps)
png(here::here("oregon.png"))
map("state", region = "Oregon", lwd = 10, bg = NA, mar = c(0.1, 0.1, 0.1, 0.1))
dev.off()

