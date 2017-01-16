population.map <- function(file = "agentslog.txt"){
  env <- search()
  varlist <- ls()
  if(length(intersect(env, "package:rgl")) == 0){
    cat("load package:rgl\n")
    library(rgl)
  }
 
  cat("reading log file....\n")
  agentslog <- read.csv(file, header = F, sep = " ")
  agentslog <- na.omit(agentslog)
  colnames(agentslog) <- c("ID", "sugarbag", "locx", "locy", "vision", "stomach", "rounds")
  round.no <- agentslog[nrow(agentslog), ]$rounds
  lastround <- agentslog[agentslog$rounds == round.no, ]
  rownames(lastround) <- c(1:nrow(lastround))
  
  cat("rendering population map...\n")
  population.map <- matrix(0, nrow = 50, ncol = 50)
  for (i in 1:nrow(lastround)){
    x = lastround[i, ]$locx
    y = lastround[i, ]$locy
    population.map[x, y] = population.map[x, y] + 1
  }
  persp3d(1:ncol(population.map), 1:nrow(population.map), population.map, col = "steelblue", xlab = "locx", ylab = "locy", zlab = "population")
}