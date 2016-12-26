void draw() {
  population.natureselection();
  population.generate();
  population.calcfitness();
  display();
  //frameRate(30);
  if (population.finished()) {
    println("runtime: ", millis()/1000.0);
    noLoop();
  }
}