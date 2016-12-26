class CellAuto {
  int[] cells;
  int[] ruleset = {0 ,0, 0, 0, 0, 0, 0, 0};
  int w = 10;
  int generation = 0;
  
  CellAuto() {
    cells = new int[width/w];
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    
    cells[cells.length/2] = 1;
    ruleset = randomruleset();
  }
  
  int[] randomruleset() {
    int[] set = {0, 0, 0, 0, 0, 0, 0, 0};
    for (int i = 0; i < 8; i++) {
      set[i] = (int) random(0, 2);
    }
    return set;
  }
  
  void generate() {
    int[] nextgen = new int[cells.length];
    for (int i = 1; i < cells.length - 1; i++) {
      int left = cells[i-1];
      int right = cells[i+1];
      int me = cells[i];
      nextgen[i] = rules(left, me, right);      
    }
    cells = nextgen;
    generation++;
    if (generation*w == height) {
      generation = 0;
      for (int i = 0; i < cells.length; i++) {
        cells[i] = 0;
      }   
      cells[cells.length/2] = 1;
      ruleset = randomruleset();
      String s = "";
      for(int i = 0; i < ruleset.length; i++) {
        s = s + ruleset[i];
      }
      println("ruleset:", s, "\n");
    }
  }
  
  
  
  int rules(int left, int me, int right) {
    String s = "" + left + me + right;
    int index = Integer.parseInt(s, 2);
    return ruleset[index];
  }
  void display() {
  for (int i = 0; i < cells.length; i++) {
    if (cells[i] == 1) fill(0);
    else fill(255);
    rect(i*w, generation*w, w, w);
  }
 
}
}

CellAuto c;
void setup() {
  size(1500, 600);
  smooth();
  c = new CellAuto();
  
  println(c.ruleset);
}