class CA2D {
  int columns, rows;
  int [][] board;
  int w = 8;
  CA2D(int c, int r) {
    columns = c;
    rows = r;
    board = new int[columns][rows];
    for(int x = 0; x < columns; x++){
      for(int y = 0; y < rows; y++) {
        board[x][y] = int(random(2));
      }
    }
  }
  
  void generat() {
    int[][] next = new int[columns][rows];
    
    for (int x = 1; x < columns-1; x++) {
      for (int y = 1; y < rows-1; y++) {
        int neighbors = 0;
        
        for (int i = -1; i <= 1; i++) {
          for(int j = -1; j <= 1; j++) {
            neighbors += board[x+i][y+j];
          }
        }
        
        neighbors -= board[x][y];
        
        if ((board[x][y] == 1) && (neighbors < 2)) next[x][y] = 0;
        else if ((board[x][y] == 1) && (neighbors > 3)) next[x][y] = 0;
        else if ((board[x][y] == 0) && (neighbors == 3)) next[x][y] = 1;
        else next[x][y] = board[x][y];
      }
    }
    board = next;
  }
  
  void juewang() {
    float r = random(1);
    if (r < 1) {
     int j_x = int(random(10,columns - 10));
     int j_y = int(random(10, rows - 10));
     for(int i = -6; i <= 6; i++) {
       for(int j = -6; j<= 6; j++) {
         board[j_x+i][j_y+j] = 0;
       }
     }
    }
  }
  
  void xiwang() {
    float r = random(1);
    if(r > 0) {
      int x_x = int(random(10, columns - 10));
      int x_y = int(random(10, rows - 10));
      for(int i = -1; i <= 10; i++) {
        for(int j = -1; j <= 10; j++) {
          board[x_x+i][x_y+j] = 1;
        }
      }
    }
  }
  
  void display() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        if (board[i][j] == 0) fill(0);
        else fill(255);
        stroke(40);
        rect(i*w, j*w, w, w);
      }
    }
  }
}

CA2D cell;

void setup() {
  frameRate(15);
  size(600, 600);
  cell = new CA2D(70, 70);
}