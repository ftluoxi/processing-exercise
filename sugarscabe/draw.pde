void draw() {
  if (a.rounds % 2 == 0) {
    sugartest.updateSugarscape();
    //print("**************************************new sugar coming************************************** ");
    
  }
  a.writeLog();
  sugartest.displaySugarscape();
  print(sugartest.sugartable_iter[25][25]);
  a.updateSystem(sugartest);
  a.displaySystem();
}

void mouseClicked() {
  a.stopWriting();
  fill(0, 102, 153);
  textSize(25);
  text("stop Writing log", width/2-50, height/2);
}