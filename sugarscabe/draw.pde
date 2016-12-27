void draw() {
  for (int x = 0; x < 50; x++) {
    for (int y = 0; y < 50; y++) {
      fill(sugartest.getSugarValue(x, y));
      
      ellipse(10*x, 10*y, 10, 10);
    }
  }
}