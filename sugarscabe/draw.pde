void draw() {
  if (a.rounds % 5 == 0) {
    sugartest.updateSugarscape();
    //print("**************************************new sugar coming************************************** ");
    
  }
  a.writeLog();
  sugartest.displaySugarscape();
  a.updateSystem(sugartest);
  a.displaySystem();
}

void mouseClicked() {
  a.stopWriting();
  fill(0, 102, 153);
  textSize(25);
  text("stop Writing log", width/2-50, height/2);
}