import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import processing.core.PApplet;
import processing.core.PVector;
import java.util.*;
Box2DProcessing box2d;
ArrayList<Box> boxes;
ArrayList<Card> cards;
Pair pair;
//Surface surface;
Boundary boundary;
float count1 = 0;
float count2 = 0;
Vec2 wind; 

void setup() {
  size(640,360);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  pair = new Pair(10);
  wind = new Vec2(-0.001, 0);
  wind = box2d.coordPixelsToWorld(wind);
  boxes = new ArrayList<Box>();
  //surface = new Surface();
  boundary = new Boundary(width/2, height/2+180, 640, 20);
  
}

void draw() {
  background(255);
  box2d.step();
  //surface.display();
  boundary.display();
  pair.display();
  
  if(mousePressed) {
    boxes.add(new Box(mouseX, mouseY, 0));
  }
  for(Box b : boxes) {
    b.display();
    b.applyForce(wind);
  } 
}