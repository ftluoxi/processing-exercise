import java.util.*;
class PVector {
  float x;
  float y;
  
  PVector(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  void add(PVector v) {
    x = x + v.x;
    y = y + v.y;
  }
  
  void sub(PVector v) {
    x = x - v.x;
    y = y -v.x;
  }
  
  void mult(float m) {
    x = m * x;
    y = m * y;
  }
  
  void div(float m) {
    x = x / m;
    y = y / m;
  }
  
  float mag(){
    return sqrt(x * x + y * y);
  }
  
  void normalize() {
    float m = mag();
    div(m);
  }
  
  PVector random2d() {
    PVector v = new PVector(random(-width, width), random(-height, height));
    v.normalize();
    return v;
  }
  
  PVector get() {
    PVector vcopy = new PVector(x, y);
    return vcopy;
  }
  
  void limitspeed(float topspeed) {//when set the topspeed, the ellipse will not return to window area.
    if (abs(x) > topspeed) {
      x = topspeed;
    }
  
    if (abs(y) > topspeed) {
      y = topspeed;
    }
   }
}
PVector sub2(PVector v1, PVector v2) {
  PVector v3;
  v3 = new PVector(v1.x - v2.x, v1.y - v2.y);
  return v3;
}

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float mass = 1;
  PImage img;
  
  Particle(PVector l, PImage img_) {
    acceleration = new PVector(0, 0.0);
    float vx = randomGaussian() * 0.3;
    float vy = randomGaussian() * 0.3 - 1;
    velocity = new PVector(vx, vy);
    location = l.get();
    lifespan = 100;
    img = img_;
  }
  
  void run() {
    update();
    render();
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 2.5;
  }
  
  void render() {
    imageMode(CENTER);
    tint(255, lifespan);
    image(img, location.x, location.y);
  }
  
  void display() {
    fill(0, lifespan);
    stroke(0, lifespan);
    ellipse(location.x, location.y, 8, 8);
  }
  
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }
  
  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}

class Confetti extends Particle {
  Confetti(PVector l, PImage img) {
    super(l, img);
  }
  
  void display() {
    float theta = map(location.x, 0, width, 0, TWO_PI*2);
    
    rectMode(CENTER);
    fill(0, lifespan);
    stroke(0, lifespan);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    rect(0, 0, 8, 8);
    popMatrix();
  }
}

class Repeller {
  float strength = 500;
  PVector location;
  float r = 10;
  
  Repeller(float x, float y) {
    location = new PVector(x, y);
  }
  
  void display() {
    stroke(255);
    fill(25);
    ellipse(location.x, location.y, r*2, r*2);
  }
  
  PVector repel(Particle p) {
    PVector dir = sub2(location, p.location);
    println(location.x, location.y);
    float d = dir.mag();
    dir.normalize();
    d = constrain(d, 5, 100);
    float force = -1 * strength/(d * d);
    dir.mult(force);
    dir.mult(-1);
    return dir;
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  PImage img;
  
  ParticleSystem(int num, PVector v, PImage img_) {
    particles = new ArrayList<Particle>();
    origin = v.get();
    img = img_;
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, img));
    }
  }
  
  void addParticle() {
    particles.add(new Particle(origin, img));
  }
  
  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
  
  void applyForce(PVector force) {
    for (Particle p : particles) {
      p.applyForce(force);
    }
  }
  
  void applyRepeller(Repeller r) {
    for (Particle p : particles) {
      PVector force = r.repel(p);
      p.applyForce(force);
    }
  }
}
ParticleSystem ps;
//Repeller repeller;

//Particle p;
//Confetti con;
void setup() {
  size(800, 800);
  PImage img = loadImage("texture.png");
  PVector startpoint = new PVector(width/2, height/2);
  ps = new ParticleSystem(0, startpoint, img);

  //p = new Particle(new PVector(width/2, height/2));
  //con = new Confetti(new PVector(width/2, height/2));
}