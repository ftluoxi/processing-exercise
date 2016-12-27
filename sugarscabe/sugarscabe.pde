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
  agent(int vision_p, int stomach_p, int step_p){
    vision = vision_p;
    stomach = stomach_p;
    step = step_p;
    locx = (int)mouseX;
    locy = (int)mouseY;
    status = 1;
    sugarbag = (int)random(0, 200);
  }
  
  void updateStatus() {
    if (sugarbag <= 0)
      status = 0;
    else 
      sugarbag = sugarbag - stomach;
  }
  
  void reapSugar(sugarscape s) {
    int[] currentLoc = {locx, locy};
    if (s.getSugarValue(locx, locy) > 0) {
      sugarbag = sugarbag + s.getSugarValue(locx, locy);
    }
    else {
      currentLoc = findSugar(s);
    }
  }
  
  int[] findSugar(sugarscape s) {
     int up = s.getSugarValue(locx, locy-vision);
     int down = s.getSugarValue(locx, locy+vision);
     int left = s.getSugarValue(locx-vision, locy);
     int right = s.getSugarValue(locx+vision, locy);
     
  }
  
  
  
}

class sugarscape {
  int[][] sugartable;
  int[][] sugartable_iter;
  int width_sugar;
  int height_sugar;
  int rounds;
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
          sugartable[x][y] = (int)random(0, 128);
        }
      }
      
      for(int i = -2; i < 3; i++) {
        for(int j = -2; j < 3; j++) {
          if ((pow(abs(i), 2) + pow(abs(j), 2)) >= 4) {
            sugartable[center1_x+i][center1_y+j] = 155;
            sugartable[center2_x+i][center2_y+j] = 155;
          }
          else if ((pow(abs(i), 2) + pow(abs(j), 2)) >= 1) {
            sugartable[center1_x+i][center1_y+j] = 205;
            sugartable[center2_x+i][center2_y+j] = 205;
          }
          else if ((pow(abs(i), 2) + pow(abs(j), 2)) <= 0) {
            sugartable[center1_x+i][center1_y+j] = 255;
            sugartable[center2_x+i][center2_y+j] = 255;
          }
        }
      }
    }
    
    if (type == 2) {//uniform sugarscape
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
          sugartable[x][y] = 128;
        }
      }
    }
    sugartable_iter = sugartable;
    rounds = 0;
  }
  //return the sugar amount at speicified location.
  int getSugarValue(int locx, int locy) {
    locx = constrain(locx, 0, width_sugar-1);
    locy = constrain(locy, 0, height_sugar-1);
    return(sugartable_iter[locx][locy]);
  } 
}

sugarscape sugartest;
int xoff = 20; int yoff = 20;
void setup() {
  sugartest = new sugarscape(50, 50, 1);
  size(500, 500);
  smooth();
}