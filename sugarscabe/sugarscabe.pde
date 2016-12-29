import java.util.*;
class agent{
  int vision;
  int stomach;
  int step;
  int status;
  int sugarbag;
  int locx, locy;
  
  /*initialize the sugarbag\status\vision\stomach\step and location of an agent
    sugarbag:the sugar amount when an agent was born;
    status:dead or live
    vision:the ability to find sugar
    stomach:how much sugar an agent consumed to maintain its life
    step:the step of an agent, it means the movement ability to go through the sugar-
    scape
    location:locx,locy, the location of an agent born in sugarscabe
  */
  agent(){
    vision = (int)random(2, 11);
    stomach = (int)random(2, 11);
    step = (int)random(2, 11);
    locx = (int)random(100, 500)/10;
    locy = (int)random(100, 500)/10;
    status = 1;
    sugarbag = (int)random(11, 20);
  }
  
  void updateStatus() {
    if (sugarbag <= 0) {
      status = 0;
      print("agent is dead!\n");
    }
    else {
      sugarbag = sugarbag - stomach;
      print("alive!, sugarbag: ", sugarbag, "\n");
    }
  }
  
  void reapSugar(sugarscape s) {
    int[] currentLoc = {locx, locy};
    if (s.getSugarValue(currentLoc[0], currentLoc[1]) > 0) {
      sugarbag = sugarbag + s.getSugarValue(currentLoc[0], currentLoc[1]);
      s.removeSugar(currentLoc[0], currentLoc[1]);
      print("got new sugar!, sugarbag: ", sugarbag, "\n");
    }
    else {
      currentLoc = findSugar(s);
      print("not enough sugar, searching...\n"); 
    }
  }
  
  int[] findSugar(sugarscape s) {
     int upmax = 0, uploc = 1, uptemp;
     int downmax = 0, downloc = 1, downtemp;
     int leftmax = 0, leftloc = 1, lefttemp;
     int rightmax = 0, rightloc = 1, righttemp;
     for (int i = 1; i <= vision; i++) {
       uptemp = s.getSugarValue(locx, locy - i);
       downtemp = s.getSugarValue(locx, locy + i);
       lefttemp = s.getSugarValue(locx - i, locy);
       righttemp = s.getSugarValue(locx + i, locy);
       if (uptemp > upmax) {
         upmax = uptemp;
         uploc = i;
       }
       if (downtemp > downmax) {
         downmax = downtemp;
         downloc = i;
       }
       if (lefttemp > leftmax) {
         leftmax = lefttemp;
         leftloc = i;
       }
       if (righttemp > rightmax) {
         rightmax = righttemp;
         rightloc = i;
       }
   
     }
     
     int[] direction = {upmax, downmax, leftmax, rightmax};
     print("max sugar value at up, down, left, right: ", direction[0], direction[1], 
     direction[2], direction[3], "\n");
     if (max(direction) <= 0) {
       locx = locx + ((int)random(-2, 2))*step;
       locy = locy + ((int)random(-2, 2))*step;
       print("can't search any sugar, random steps: ", locx, locy, "\n");
     }
     else {
      int maxdirection = max(direction);
      if (upmax == maxdirection) {
        if (step < uploc) {
          locx = locx + 0;
          locy = locy - step;
        }
        else {
          locx = locx + 0;
          locy = locy - uploc;
        }
        print("find new sugar at up!, move to location: ", locx, locy, "\n");
      }
      else if (downmax == maxdirection) {
        if (step < downloc) {
          locx = locx + 0;
          locy = locy + step;
        }
        else {
          locx = locx + 0;
          locy = locy + downloc;
        }
        print("find new sugar at down!, move to location: ", locx, locy, "\n");
      }
      else if (leftmax == maxdirection) {
        if (step < leftloc) {
          locx = locx - step;
          locy = locy + 0;
        }
        else {
          locx = locx - leftloc;
          locy = locy + 0;
        }
        print("find new sugar at left!, move to location: ", locx, locy, "\n");
      }
      else if (rightmax == maxdirection) {
        if (step < rightloc) {
          locx = locx + step;
          locy = locy + 0;
        }
        else {
          locx = locx + rightloc;
          locy = locy + 0;
        }
        print("find new sugar at right!, move to location: ", locx, locy, "\n");
      }
     }
   locx = constrain(locx, 0, s.width_sugar - 1);
   locy = constrain(locy, 0, s.height_sugar - 1);
   int[] nextLocation = {locx, locy};
   return nextLocation;
  }
  
  void displayAgent() {
    if (status == 1)
      fill(220, 20, 60);
    else
      fill(0, 0, 0);
    ellipse(10*locx, 10*locy, 10, 10);
  }
  
  
  
}

class sugarscape {
  int[][] sugartable;
  int[][] sugartable_iter;
  int width_sugar;
  int height_sugar;
  /*initialize sugarscape with some user-specified params
  int w: the weight of sugarscape
  int h:the heght of sugarscape
  int type: the type of sugarscape,
  type == 0:random sugarscape
  type == 1:unbalance sugarscape, it will generate 2 sugar peaks in the sugarsacpe.
  type == 2: uniform sugarscape, the amount of sugar is a constant everywhere
  */
  sugarscape(int w, int h, int type) {
    width_sugar = w;
    height_sugar = h;
    sugartable = new int[w][h];
    sugartable_iter = new int[w][h];
    if (type == 0) {//random sugarscape
      for (int x = 0; x < w; x++){
        for (int y = 0; y < h; y++) {
          sugartable[x][y] = (int)random(0, 256);
          sugartable_iter[x][y] = sugartable[x][y];
        }
      }
    }
    
    if (type == 1) {//unbalance sugarscape
      int center1_x = (int)random(w/4, w/2);
      int center1_y = (int)random(h/4, h/2);
      int center2_x = (int)random(w/2, 0.75*w);
      int center2_y = (int)random(h/2, 0.75*h);
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
          sugartable[x][y] = (int)random(0, 0);
          sugartable_iter[x][y] = sugartable[x][y];
        }
      }
      
      for(int i = -2; i < 3; i++) {
        for(int j = -2; j < 3; j++) {
          if ((pow(abs(i), 2) + pow(abs(j), 2)) >= 4) {
            sugartable[center1_x+i][center1_y+j] = 155;
            sugartable[center2_x+i][center2_y+j] = 155;
            sugartable_iter[center1_x+i][center1_y+j] = sugartable[center1_x+i][center1_y+j];
            sugartable_iter[center2_x+i][center2_y+j] = sugartable[center2_x+i][center2_y+j];
          }
          else if ((pow(abs(i), 2) + pow(abs(j), 2)) >= 1) {
            sugartable[center1_x+i][center1_y+j] = 205;
            sugartable[center2_x+i][center2_y+j] = 205;
            sugartable_iter[center1_x+i][center1_y+j] = sugartable[center1_x+i][center1_y+j];
            sugartable_iter[center2_x+i][center2_y+j] = sugartable[center2_x+i][center2_y+j];
          }
          else if ((pow(abs(i), 2) + pow(abs(j), 2)) <= 0) {
            sugartable[center1_x+i][center1_y+j] = 255;
            sugartable[center2_x+i][center2_y+j] = 255;
            sugartable_iter[center1_x+i][center1_y+j] = sugartable[center1_x+i][center1_y+j];
            sugartable_iter[center2_x+i][center2_y+j] = sugartable[center2_x+i][center2_y+j];
          }
        }
      }
    }
    
    if (type == 2) {//uniform sugarscape
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
          sugartable[x][y] = 128;
          sugartable_iter[x][y] = sugartable[x][y];
        }
      }
    }
    
  }
  //return the sugar amount at speicified location.
  int getSugarValue(int locx, int locy) {
    locx = constrain(locx, 0, width_sugar-1);
    locy = constrain(locy, 0, height_sugar-1);
    return(sugartable_iter[locx][locy]);
  }
  
  void removeSugar(int locx, int locy) {
    locx = constrain(locx, 0, width_sugar-1);
    locy = constrain(locy, 0, height_sugar-1);
    sugartable_iter[locx][locy] = 0;
  }
  
  void updateSugarscape() {
    for (int x = 0; x < width_sugar; x++ ) {
      for (int y = 0; y < height_sugar; y++) {
        sugartable_iter[x][y] = sugartable[x][y];
      }
    }
  }
  
  void displaySugarscape() {
    for (int x = 0; x < width_sugar; x++) {
      for (int y = 0; y < height_sugar; y++) {
        fill(255-getSugarValue(x, y));
        ellipse(10*x, 10*y, 10, 10);
      }
    }
    
  }
}

class agentSystem {
  ArrayList<agent> agents;
  int N;
  int rounds;
  
  agentSystem(int size) {
    agents = new ArrayList<agent>();
    N = size;
    for (int i=0; i < N; i++) {
      agents.add(new agent());
    }
    rounds = 1;
  }
  
  void updateSystem(sugarscape s) {
    Iterator<agent> it = agents.iterator();
    while (it.hasNext()) {
      agent a = it.next();
      a.updateStatus();
      if (a.status == 0) {
        it.remove();
        N = N - 1;
      }
      else {
        a.reapSugar(s);
      }
    }
   rounds++;
  }
  
  void displaySystem() {
    for (int i = 0; i < agents.size(); i++) {
      agent temp = agents.get(i);
      temp.displayAgent();
    }
  }
  
  
  
}

sugarscape sugartest = new sugarscape(50, 50, 1);
agentSystem a = new agentSystem(1000);

int xoff = 20; int yoff = 20;
void setup() {
  frameRate(30);
  //print(a.locx, a.locy, a.sugarbag, "\n");
  size(500, 500);
  smooth();
}