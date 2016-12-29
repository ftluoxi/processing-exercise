void draw() {
  if (a.rounds % 10 == 0) {
    sugartest.updateSugarscape();
    //print("**************************************new sugar coming************************************** ");
    
  }
  sugartest.displaySugarscape();
  a.updateSystem(sugartest);
  a.displaySystem();
}