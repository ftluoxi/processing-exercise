sugar.map <- function(file = "map.txt", type = 1){
  env <- search()
  if(length(intersect(env, "package:rgl"))==0){
    cat("load package:rgl\n")
    library(rgl)
  }
  cat("rendering sugar map...\n")
  map <- read.csv("map.txt", header = F, sep = ",")
  map <- as.matrix(map[, -ncol(map)])
  if(type == 1){
    persp3d(1:nrow(map), 1:ncol(map), map, col = "steelblue", xlab = "locx", ylab = "locy", zlab = "sugar")
  }
  else{
    contour(1:nrow(map), 1:ncol(map), map, col = "steelblue", xlab = "locx", ylab = "locy")
  }
  
}