summaryAgent <- function(file = "agentslog.txt"){
  cat("###Summary static feature of result log###\nPress any to continue...\n")
  readline()
  invisible()
  cat("reading files...\n")
  agentslog <- read.csv(file, header = F, sep = " ")
  agentslog <- na.omit(agentslog)
  colnames(agentslog) <- c("ID", "sugarbag", "locx", "locy", "vision", "stomach", "step", "rounds")
  cat("(1).Summary the static distribution of agents at first round\nWhich feature do you want to display:\n")
  exit = FALSE
  rounds1 <- agentslog[agentslog$rounds == 1, ]
  roundslast <- agentslog[agentslog$rounds == max(agentslog$rounds), ]
  while(!exit){
    cat("1.sugarbag\n2.vision\n3.stomach\n4.step\n5.all in one graph\n")
    answer1 <- readline()
    if (substr(answer1, 1, 1) == "1"){
      temp_sugarbag <- rounds1$sugarbag
      hist(temp_sugarbag, col = "steelblue", xlab = "sugarbag", main = "Histogram of sugarbag at 1st round")
      rug(jitter(temp_sugarbag, factor = 1.5), ticksize = 0.01, col = "red", lwd = 0.01, quiet = T)
      exit = TRUE
    }
    else if (substr(answer1, 1, 1) == "2") {
      temp_vision <- rounds1$vision
      hist(temp_vision, col = "steelblue", xlab = "vision", main = "Histogram of vision at 1st round")
      rug(jitter(temp_vision, factor = 1.5), ticksize = 0.01, col = "red", lwd = 0.01, quiet = T)
      exit = TRUE
    }
    else if (substr(answer1, 1, 1) == "3") {
      temp_stomach <- rounds1$stomach
      hist(temp_stomach, col = "steelblue", xlab = "vision", main = "Histogram of stomach at 1st round")
      rug(jitter(temp_stomach, factor = 1.5), ticksize = 0.01, col = "red", lwd = 0.01, quiet = T)
      exit = TRUE
    }
    else if (substr(answer1, 1, 1) == "4") {
      temp_step <- rounds1$step
      hist(temp_step, col = "steelblue", xlab = "vision", main = "Histogram of step at 1st round")
      rug(jitter(temp_step, factor = 1.5), ticksize = 0.01, col = "red", lwd = 0.01, quiet = T)
      exit = TRUE
    }
    else if (substr(answer1, 1, 1) == "5") {
      par(mfrow = c(2, 2))
      temp_sugarbag <- rounds1$sugarbag
      temp_vision <- rounds1$vision
      temp_stomach <- rounds1$stomach
      temp_step <- rounds1$step
      hist(temp_sugarbag, col = "steelblue", xlab = "sugarbag", main = "Sugarbag")
      rug(jitter(temp_sugarbag, factor = 1.5), ticksize = 0.01, col = "red", lwd = 0.01, quiet = T)
      hist(temp_vision, col = "steelblue", xlab = "vision", main = "Vision")
      rug(jitter(temp_vision, factor = 1.5), ticksize = 0.01, col = "red", lwd = 0.01, quiet = T)
      hist(temp_stomach, col = "steelblue", xlab = "vision", main = "Stomach")
      rug(jitter(temp_stomach, factor = 1.5), ticksize = 0.01, col = "red", lwd = 0.01, quiet = T)
      hist(temp_step, col = "steelblue", xlab = "vision", main = "Step")
      rug(jitter(temp_step, factor = 1.5), ticksize = 0.01, col = "red", lwd = 0.01, quiet = T)
      par(mfrow = c(1,1))
      exit = TRUE
    }
    else if (sum(substr(answer1, 1, 1)==c("1", "2", "3", "4", "5")) == 0) {
      cat("enter right numbers!\n")
      exit = FALSE
    }
  }
  readline("Press any to continue...\n")
  invisible()
  cat("(2).Compare the feature of agents between 1st and last rounds\n")
  exit = FALSE
  while(!exit){
    cat("which kind of graph do you want?\n1.all in one graph\n2.seperate in each graph\n")
    answer2 <- readline()
    if (substr(answer2, 1, 1) == 1) {
      par(mfrow = c(3, 1))
      exit = TRUE
    }
    else if (substr(answer2, 1, 1) == 2) {
      par(mfrow = c(1, 1))
      exit = TRUE
    }
    else if (sum(substr(answer2, 1, 1)==c("1", "2")) == 0) {
      cat("enter right numbers!\n")
      exit = FALSE
    }
    if(exit == TRUE){
      plot(density(roundslast$vision), col = "red", lwd = 2.5, main = "Vision", xlab = "Vision ability")
      lines(density(rounds1$vision), col = "blue", lwd = 2.5)
      rug(jitter(roundslast$vision), col = "red", side = 1, ticksize = 0.01, lwd = 0.01, quiet = T)
      rug(jitter(rounds1$vision), col = "blue", side = 3, ticksize = 0.01, lwd = 0.01, quiet = T)
      legend(x = "topright", col = c("red", "blue"), lwd = c(2.5, 2.5), legend = c("last", "1st"), bty = "n")
      
      plot(density(roundslast$stomach), col = "red", lwd = 2.5, main = "Stomach", xlab = "Stomach")
      lines(density(rounds1$stomach), col = "blue", lwd = 2.5)
      rug(jitter(roundslast$stomach), col = "red", side = 1, ticksize = 0.01, lwd = 0.01, quiet = T)
      rug(jitter(rounds1$stomach), col = "blue", side = 3, ticksize = 0.01, lwd = 0.01, quiet = T)
      legend(x = "topright", col = c("red", "blue"), lwd = c(2.5, 2.5), legend = c("last", "1st"), bty = "n")
      
      plot(density(roundslast$step), col = "red", lwd = 2.5, main = "Step", xlab = "Move ability")
      lines(density(rounds1$step), col = "blue", lwd = 2.5)
      rug(jitter(roundslast$step), col = "red", side = 1, ticksize = 0.01, lwd = 0.01, quiet = T)
      rug(jitter(rounds1$step), col = "blue", side = 3, ticksize = 0.01, lwd = 0.01, quiet = T)
      legend(x = "topright", col = c("red", "blue"), lwd = c(2.5, 2.5), legend = c("last", "1st"), bty = "n")
      par(mfrow = c(1,1))
    }
  }
  cat("Press any to continue.\n")
  readline()
  invisible()
  cat("3.Compare the features between a dead agent and an alive agent\n")
  cat("1.all in one graph\n2.seperate in each graph\n")
  deadagent <- agentslog[agentslog$sugarbag <= 0, ]
  dead.ID <- deadagent[nrow(deadagent), ]$ID
  dead <- agentslog[agentslog$ID == dead.ID, ]
  alive.ID <- roundslast[1, ]$ID
  alive <- agentslog[agentslog$ID == alive.ID, ]
  exit = FALSE
  while(!exit) {
    answer3 <- readline()
    if (substr(answer3, 1, 1)=="1") {
      par(mfrow = c(2, 1))
      exit = TRUE
    }
    else if (substr(answer3, 1, 1)=="2") {
      exit = TRUE
    }
    else if (sum(substr(answer3, 1, 1)==c("1", "2"))==0) {
      cat("enter right numbers!\n")
      exit = FALSE
    }
    if (exit) {
      plot(alive$rounds, alive$sugarbag, col = "red", type = "l", lwd = 2, xlab = "rounds", 
           ylab = "sugarbag", main = paste( "Alive agent ID:", alive.ID))
      plot(dead$rounds, dead$sugarbag, col = "blue", type = "l", lwd = 2, xlab = "rounds", 
           ylab = "sugarbag", main = paste("Dead agent ID:", dead.ID))
    }
    par(mfrow = c(1,1))
  }
  cat("All job done, press any to exit!\n")
  readline()
  invisible()
}