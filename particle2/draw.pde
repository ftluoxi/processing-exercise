PVector gravity = new PVector(0, 0.1);

void draw() {
  background(0);
  float dx = map(mouseX,0, width, -1, 1);
   float dy = map(mouseY,0, height, -0.1, 0.1);
  PVector wind = new PVector(dx, dy);
  ps.applyForce(wind);
  //ps.applyForce(gravity);
  ps.run();
  for (int i = 0; i < 100; i++) {
    ps.addParticle();
  }
  
  
}