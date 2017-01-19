population.map <- function(file = "agentslog.txt", type = 1){
  env <- search()
  varlist <- ls()
  if(length(intersect(env, "package:rgl")) == 0){
    cat("load package:rgl\n")
    library(rgl)
  }
 
  cat("reading log file....\n")
  agentslog <- read.csv(file, header = F, sep = " ")
  agentslog <- na.omit(agentslog)
  colnames(agentslog) <- c("ID", "sugarbag", "locx", "locy", "vision", "stomach","step","rounds")
  round.no <- agentslog[nrow(agentslog), ]$rounds
  lastround <- agentslog[agentslog$rounds == round.no, ]
  firstround <- agentslog[agentslog$rounds == 1, ]
  halfround <- agentslog[agentslog$rounds == floor(round.no * 0.5), ]
  tfround <- agentslog[agentslog$rounds == floor(round.no * 0.75), ]
  rownames(lastround) <- c(1:nrow(lastround))
  
  cat("rendering population map...\n")
  population.map <- matrix(0, nrow = 50, ncol = 50)
  population1.map <- matrix(0, nrow = 50, ncol = 50)
  population75.map <- matrix(0, nrow = 50, ncol = 50)
  population50.map <- matrix(0, nrow = 50, ncol = 50)
  for (i in 1:nrow(lastround)){
    x = lastround[i, ]$locx
    y = lastround[i, ]$locy
    population.map[x, y] <- population.map[x, y] + 1
  }
  for (i in 1:nrow(firstround)){
    x = firstround[i, ]$locx
    y = firstround[i, ]$locy
    population1.map[x, y] <- population1.map[x, y] + 1
  }
  for (i in 1:nrow(halfround)){
    x = halfround[i, ]$locx
    y = halfround[i, ]$locy
    population50.map[x, y] <- population50.map[x, y] + 1
  }
  for (i in 1:nrow(tfround)){
    x = tfround[i, ]$locx
    y = tfround[i, ]$locy
    population75.map[x, y] <- population75.map[x, y] + 1
  }
  if(type == 1){
    open3d()
    persp3d(1:ncol(population.map), 1:nrow(population.map), population.map, col = "steelblue", 
            xlab = "locx", ylab = "locy", zlab = "population", main = "population at lastround")
    open3d()
    persp3d(1:ncol(population1.map), 1:nrow(population1.map), population1.map, col = "steelblue", 
            xlab = "locx", ylab = "locy", zlab = "population", main = "population at first round")
    open3d()
    persp3d(1:ncol(population50.map), 1:nrow(population50.map), population50.map, col = "steelblue", 
            xlab = "locx", ylab = "locy", zlab = "population", main = "population at 50% round")
    open3d()
    persp3d(1:ncol(population75.map), 1:nrow(population75.map), population75.map, col = "steelblue", 
            xlab = "locx", ylab = "locy", zlab = "population", main = "population at 75% round")
  }
  else{
    par(mfrow = c(2, 2))
    contour(1:ncol(population.map), 1:nrow(population.map), population.map, col = "steelblue", 
            xlab = "locx", ylab = "locy", main = "population at lastround")
    contour(1:ncol(population1.map), 1:nrow(population1.map), population1.map, col = "steelblue", 
            xlab = "locx", ylab = "locy", main = "population at first round")
    contour(1:ncol(population50.map), 1:nrow(population50.map), population50.map, col = "steelblue", 
            xlab = "locx", ylab = "locy", main = "population at %50 round")
    contour(1:ncol(population75.map), 1:nrow(population75.map), population75.map, col = "steelblue", 
            xlab = "locx", ylab = "locy", main = "population at %75 lastround")
  }
  par(mfrow = c(1,1))
}