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
   
   PVector sub2(PVector v1, PVector v2) {
     PVector v3;
     v3 = new PVector(v1.x - v2.x, v1.y - v2.y);
     return v3;
   }
}

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G;
  
  Mover(float m, float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0.000);
    acceleration = new PVector(0, 0);
    mass = m;
    G = 1.4;
  }
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }
 
  void checkEdges() {
    if(location.x > width) {
      location.x = width;
      velocity.x *= -1;
      
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }
    if(location.y > height) {
      location.y = height;
      velocity.y = - velocity.y;
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
    
  }
  
  void update() {
    velocity.add(acceleration);
    //velocity.limitspeed(10);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    stroke(0);
    fill(255);
    ellipse(location.x, location.y, mass, mass);
  }
  
  boolean isInside(Liquid l) {
    if (location.x > l.x && location.x <l.x + l.w && location.y >l.y && location.y < l.y + l.h) {
      return true;
    } else {
      return false;
    }
  }
  
  void drag(Liquid l) {
    float speed = velocity.mag();
    float dragMagnitude = l.c * speed * speed;
    
    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMagnitude);
    applyForce(drag);
  }
  
  PVector attract(Mover m){
    PVector force = new PVector(0, 0);
    force = force.sub2(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, mass, width);
    float strength = (G* m.mass * mass) / (distance * distance);
    force.normalize();
    force.mult(strength);
    force.mult(1);
    //println("force.y=", force.y);
    //println("force.x=", force.x);
    return force;   
  }
}

class Liquid {
  float x, y, w, h;
  float c;
  
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  void display() {
    noStroke();
    fill(175);
    rect(x, y, w, h);
  }
}

class Attractor{
  float mass;
  PVector location;
  float G;
  Attractor(float mass_) {
    location = new PVector(width/2, height/2);
    mass = mass_;
    G = 1.4;
  }
  
  void display() {
    stroke(0);
    fill(175, 200);
    ellipse(location.x, location.y, mass, mass);
  }
  
  PVector attract(Mover m){
    PVector force = new PVector(0, 0);
    force = force.sub2(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 0.5 * mass, width);
    float strength = (G* m.mass * mass) / (distance * distance);
    force.normalize();
    force.mult(strength);
    line(m.location.x, force.y, m.location.x, m.location.y);
    println("force.y=", force.y);
    force.mult(1);
    return force;   
  }
}

PVector wind(float time) {//generate a random vector from Perl noies.
  float w_x = noise(time) * random(-2, 2);
  float w_y = noise(time + 10) * random(-2, 2);
  PVector wind = new PVector(w_x, w_y);
  wind.normalize();
  return wind;
}
Mover[] movers = new Mover[2];
Attractor a;
//Liquid liquid;
//float time = 0;
void setup() {
  size(1000, 1000);
  smooth();
  a = new Attractor(45);
  //liquid = new Liquid(0, height/2, width, height/2, 0.5);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(5, 50), random(width), random(height));
  }
  
}

void draw() {
    //background(0);
    //a.display();
   //liquid.display();
    //time += 1;
    //wind = wind(time);
    //wind.mult(0.5);
    //PVector wind = new PVector(0.01, 0);
    
    //for (int i = 0; i < movers.length; i++) {
    //if (movers[i].isInside(liquid)) {
      //movers[i].drag(liquid);
    //}
    //PVector gravity = new PVector(0, 0.1 * movers[i].mass);
    //float c = 0.05;
    //PVector friction = movers[i].velocity.get();
    //friction.mult(-1);
    //friction.normalize();
    //friction.mult(c);
      
    //movers[i].applyForce(friction);
    //movers[i].applyForce(wind);
    //movers[i].applyForce(gravity);
    for (int i = 0; i <movers.length; i++){
      for (int j = 0; j < movers.length; j++){
      if(i != j){
      PVector force = movers[i].attract(movers[j]);
      movers[j].applyForce(force);
      }
      }
      movers[i].update();
      movers[i].display();
      movers[i].checkEdges();
    }
    //println("friction=", friction.x);
    
    //println("a.x = ", mover.acceleration.x);
    //println("a.y = ", mover.acceleration.y);
    //println("l.x = ", mover.location.x);
    //println(",", movers[1].location.y);
 }

  