sugar.map <- function(file = "map.txt"){
  env <- search()
  if(length(intersect(env, "package:rgl"))){
    cat("load package:rgl\n")
    library(rgl)
  }
  cat("rendering sugar map...\n")
  map <- read.csv("map.txt", header = F, sep = ",")
  map <- as.matrix(map[, -ncol(map)])
  persp3d(1:nrow(map), 1:ncol(map), map, col = "steelblue", xlab = "locx", ylab = "locy", zlab = "sugar")
  
}