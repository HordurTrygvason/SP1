class Game { //<>// //<>// //<>//
  // egenskaber
  int w;
  int h;
  int numberOfFood;
  int numberOfEnemies;
  int playerLife;
  int[][]board;
  Dot player;
  Dot player2;
  Dot[] food;
  Dot[] enemies;
  Keys keys;
  
  

  // konstruktør
  Game(int gW, int gH, int nF, int nE) {
    w = gW;
    h = gH;
    numberOfFood = nF;
    food = new Dot[nF];
    numberOfEnemies = nE;
    enemies = new Dot[nE];
    playerLife= 100;
    board  = new int[gW][gH];
    player = new Dot(0, 1, w-1, h-1);
    player2 = new Dot(0, 1, w-2, h-2);
    keys = new Keys();
   
// food
    for (int i = 0; i < nF; ++i) {
      food[i] = new Dot(w-10, h-10, w-10, h-10);
    }
    
    for (int i = 0; i < nE; ++i) {
      enemies[i] = new Dot(w-1, h-1, w-1, h-1);
    }
  }
  // metoder

  int[][] getBoard() { 
    return board;
  }

  public int getWidth()
  {
    return h;
  }

  public int getHeight()
  {
    return w;
  }
  
  int getPlayerLife() {
    
    return playerLife;
  }

  void onKeyPressed(char ch) {
    keys.onKeyPressed(ch);
  }
  void onKeyReleased(char ch) {
    keys.onKeyReleased(ch);
  }


  void update() {
    updatePlayer1();
    updatePlayer2();
    updateFood();
    updateEnemiesPlayer1();
    updateEnemiesPlayer2();
    checkForCollisionsFoodPlayer1();
    checkForCollisionsFoodPlayer2();
    checkForCollisionsEnemiesPlayer2();
    clearBoard();
    populateBoardFood();
    populateBoardEnemies();
    populateBoardEnemiesPlayer2();
  }

  void updatePlayer1() {
    // tjekke om spilleren har trykket på a,s,d eller w
    if (keys.wDown) { 
      player.moveUp();
    }
    if (keys.aDown) {
      player.moveLeft();
    }
    // cond3 relateret til keypressed a
    if (keys.sDown) {
      player.moveDown();
    }
    if (keys.dDown) {
      player.moveRight();
    }
    
  }
  
   void updatePlayer2() {
    // tjekke om spilleren har trykket på a,s,d eller w
    if (keys.wDown2) { 
      player2.moveUp();
    }
    if (keys.aDown2) {
      player2.moveLeft();
    }
    // cond3 relateret til keypressed a
    if (keys.sDown2) {
      player2.moveDown();
    }
    if (keys.dDown2) {
      player2.moveRight();
    }
    
  }

  void updateFood() {
    // loope igennem alle fjender
    for (int i=0; i<food.length; i++) {
      // nogle gange skal fjende i følge efter spiller
      // andre gange flytte sig random

      if (i>=0) {

        int dX = player.xPos - food[i].xPos;
        int dY = player.yPos - food[i].yPos;
    
        if (dX>0) {
          //spilleren er til højre - så flyt mod højr
          food[i].moveRight();
        } else  if (dX>0) {
          food[i].moveLeft();
        } else if (dY<0) {
          //spilleren er til højre - så flyt mod højr
          food[i].moveDown();
        } else if (dY>0) {
          food[i].moveUp();
        }
      }
      int rand = (int) random(4);
      if (rand == 0) {
        food[i].moveUp();
      }
      if (rand == 1) {
        food[i].moveDown();
      }
      if (rand == 2) {
        food[i].moveRight();
      }
      if (rand == 3) {
        food[i].moveLeft();
      }
    }
  }
 
  
   void updateEnemiesPlayer1() {
    // loope igennem alle fjender
    for (int i=0; i<enemies.length; i++) {
      // nogle gange skal fjende i følge efter spiller
      // andre gange flytte sig random

      if (i>=0) {

        int dX = player.xPos - enemies[i].xPos;
        int dY = player.yPos - enemies[i].yPos;
        if (dX>0) {
          //spilleren er til højre - så flyt mod højr
          enemies[i].moveRight();
        } else  if (dX<0) {
          enemies[i].moveLeft();
        } else if (dY>0) {
          //spilleren er til højre - så flyt mod højr
          enemies[i].moveDown();
        } else if (dY<0) {
          enemies[i].moveUp();
        }
      }
      int rand = (int) random(4);
      if (rand == 0) {
        enemies[i].moveUp();
      }
      if (rand == 1) {
        enemies[i].moveDown();
      }
      if (rand == 2) {
        enemies[i].moveRight();
      }
      if (rand == 3) {
        enemies[i].moveLeft();
      }
    }
  }
  
   void updateEnemiesPlayer2() {
    // loope igennem alle fjender
    for (int i=0; i<enemies.length; i++) {
      // nogle gange skal fjende i følge efter spiller
      // andre gange flytte sig random

      if (i>=0) {

        int dX = player2.xPos - enemies[i].xPos;
        int dY = player2.yPos - enemies[i].yPos;
        if (dX>0) {
          //spilleren er til højre - så flyt mod højr
          enemies[i].moveRight();
        } else  if (dX<0) {
          enemies[i].moveLeft();
        } else if (dY>0) {
          //spilleren er til højre - så flyt mod højr
          enemies[i].moveDown();
        } else if (dY<0) {
          enemies[i].moveUp();
        }
      }
      int rand = (int) random(4);
      if (rand == 0) {
        enemies[i].moveUp();
      }
      if (rand == 1) {
        enemies[i].moveDown();
      }
      if (rand == 2) {
        enemies[i].moveRight();
      }
      if (rand == 3) {
        enemies[i].moveLeft();
      }
    }
  }

  void checkForCollisionsFoodPlayer1() {
    // dvs hvis der er 1 i feltet og 2 er samme sted har vi koll
    // spør hver fjende er du samme sted som player?
    for (int i=0; i<food.length; i++) {
      if (food[i].getX() == player.getX() && food[i].getY() == player.getY()) {
        // then coll and player looses one lifepoint
        playerLife++;
      }
    }
  }
  
   void checkForCollisionsFoodPlayer2() {
    // dvs hvis der er 1 i feltet og 2 er samme sted har vi koll
    // spør hver fjende er du samme sted som player?
    for (int i=0; i<food.length; i++) {
      if (food[i].getX() == player2.getX() && food[i].getY() == player2.getY()) {
        // then coll and player looses one lifepoint
        playerLife++;
      }
    }
  }
  
 void checkForCollisionsEnemies() {
    // dvs hvis der er 1 i feltet og 2 er samme sted har vi koll
    // spør hver fjende er du samme sted som player?
    for (int i=0; i<enemies.length; i++) {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY()) {
        // then coll and player looses one lifepoint
        playerLife--;
      }
    }
  }
  
  void checkForCollisionsEnemiesPlayer2() {
    // dvs hvis der er 1 i feltet og 2 er samme sted har vi koll
    // spør hver fjende er du samme sted som player?
    for (int i=0; i<enemies.length; i++) {
      if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY()) {
        // then coll and player looses one lifepoint
        playerLife--;
      }
    }
  }

  void clearBoard() {
    for (int y = 0; y < h; ++y) {
      for (int x = 0; x < w; ++x) {
        board[x][y]=0;
      }
    }
  }

  void populateBoardFood() {
    // insert player
    board[player.getX()][player.getY()] = 1;
    for (int i = 0; i < food.length; ++i) {
      board[food[i].getX()][food[i].getY()]= 2;
    }
     board[player2.getX()][player2.getY()] = 1;
    for (int i = 0; i < food.length; ++i) {
      board[food[i].getX()][food[i].getY()]= 2;
    }
  }


void populateBoardEnemies() {
    // insert player
    board[player.getX()][player.getY()] = 1;
    for (int i = 0; i < enemies.length; ++i) {
      board[enemies[i].getX()][enemies[i].getY()]= 2;
    }
   
  }
  
  void populateBoardEnemiesPlayer2() {
    // insert player
    board[player2.getX()][player2.getY()] = 1;
    for (int i = 0; i < enemies.length; ++i) {
      board[enemies[i].getX()][enemies[i].getY()]= 2;
    }
  }

}
