class Box {
  float w, h;
  float lifespan;
  Body body;
  int type;
  
  Box(float locx_, float locy_, int type_) {
    w = 16;
    h = 16;
    type = type_;
    
    BodyDef bd = new BodyDef();//create the basic definition of physic body;
    FixtureDef fd = new FixtureDef();
    if(type == 0) {
      bd.type = BodyType.DYNAMIC;
      fd.density = 20;
    } else {
      bd.type = BodyType.STATIC;
      fd.density = 0;
    }
     
    
    //println(locx_, locy_);
    bd.position.set(box2d.coordPixelsToWorld(locx_, locy_));
    body = box2d.createBody(bd);//use the definition "bd" to create physic body "body"
    
    CircleShape ps = new CircleShape(); //create the shape difinition of body;
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    //float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.m_radius = box2dW;//the shape of body is box
    
    
    fd.density = 1;
    fd.shape = ps;
    
    fd.friction = 0.1;
    fd.restitution = 0.8;
    body.createFixture(fd);   
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    
    fill(127);
    stroke(0);
    rectMode(CENTER);
    ellipse(0, 0, w, w);
    line(0, 0, w/2, 0);
    popMatrix();
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
}

class Pair {
  ArrayList<Box> balls;
  ArrayList<DistanceJointDef> djdfs;
  ArrayList<DistanceJoint> djs;
  int N;
  
  Pair(int N_) {
    N = N_;
    balls = new ArrayList<Box>();
    djdfs = new ArrayList<DistanceJointDef>();
    djs = new ArrayList<DistanceJoint>();
    
    for (int i = 0; i < N; i++) {
      if(i == 0 || i == N - 1){
        balls.add(new Box(16*i, height/2, 1));
      } else {
        balls.add(new Box(16*i, height/2, 0));
      }
    }
    
    for (int i = 0; i < N - 1; i++) {     
      DistanceJointDef df = new DistanceJointDef();
      df.bodyA = balls.get(i).body;
      df.bodyB = balls.get(i + 1).body;
      df.length = box2d.scalarPixelsToWorld(16);
      df.frequencyHz = 1.5;
      df.dampingRatio = 0.5;
      djdfs.add(df);
      DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(df);
      djs.add(dj);
    }
  }
  
  void display() {
    for (int i = 0; i < N - 1; i++) {
      Vec2 pos1 = box2d.getBodyPixelCoord(balls.get(i).body);
      Vec2 pos2 = box2d.getBodyPixelCoord(balls.get(i + 1).body);
      stroke(0);
      line(pos1.x, pos1.y, pos2.x, pos2.y);
      balls.get(i).display();
      balls.get(i + 1).display();
    }
  }
}

class Card {
  float w, h;
  Body body;
  
  Card(float position_x, float position_y) {
    w = 4;
    h = 32;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(position_x, position_y));
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 20;
    fd.restitution = 0;
    
    body.createFixture(fd);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    
    fill(200);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
}

class Boundary {
  float x, y;
  float w, h; 
  Body b;
  
  Boundary(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    bd.type = BodyType.STATIC;
    b = box2d.createBody(bd);
    
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    PolygonShape ps = new PolygonShape();
    ps.setAsBox(box2dW, box2dH);
    
    b.createFixture(ps, 1);
  }
  
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}

class Surface {
  ArrayList<Vec2> surface;
  
  Surface() {
    surface = new ArrayList<Vec2>();
    surface.add(new Vec2(0, height/2 + 50));
    surface.add(new Vec2(width/2, height/2 + 50));
    surface.add(new Vec2(width, height/2));
    
    ChainShape chain = new ChainShape();
    Vec2[] verticles = new Vec2[surface.size()];
    for (int i = 0; i < verticles.length; i++) {
      verticles[i] = box2d.coordPixelsToWorld(surface.get(i));
    }
    chain.createChain(verticles, verticles.length);
    
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd); //us default set to create body
    body.createFixture(chain, 1);
    
  }
  
  void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    beginShape();
    for (Vec2 v:surface) {
      vertex(v.x, v.y);
    }
    endShape();
  }
}