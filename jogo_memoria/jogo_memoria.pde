PImage pImg1, pImg2;
int sizeRect = 80, halfWidth, halfHeight, positionX, positionY;
int pImg1X = 0, pImg1Y = 0, pImg2X = 0, pImg2Y = 0, indexImg1, startTime = 0, startTimeRestart = 0;
int attempts = 8;
String image1 = "", image2 = "", message = "";
boolean showImg1 = false, showImg2 = false, firstClick = true;
boolean wait = false, waitRestart = false;
JSONObject[] board;
String[] images = new String[6];

void setup() {
  size(800, 600);
  frameRate(30);
  textAlign(CENTER, TOP);
  
  halfWidth = width/2;
  halfHeight = height/2;
  positionY = halfHeight-sizeRect/2;
  positionX = halfWidth-sizeRect/2;
  images[0] = "basquete_80x80.png";
  images[1] = "futebol_80x80.png";
  images[2] = "natacao_80x80.png";
  images[3] = "tenis_80x80.png";
  images[4] = "volei_80x80.png";
  images[5] = "baseball_80x80.png";
  
  board = new JSONObject[images.length*2];
  for (int i = 0; i < board.length; i++) {
    board[i] = new JSONObject(); 
  }
  
  initializeGame();
}

void draw() {
  background(255);
  
  textSize(16);
  fill(0);
  text("Tentativas: " + attempts, width/2, 100);
  
  textSize(25);
  fill(0);
  text(message, width/2, 50);
  
  if (waitRestart && millis() - startTimeRestart >= 2000) {
    initializeGame();
    waitRestart = false;
    startTimeRestart = 0;
  }
  
  drawRect();
  drawImage();
  showImages();
  
  if (wait && millis() - startTime >= 1000) {
    showImg1 = false;
    showImg2 = false;
    wait = false;
    startTime = 0;
  }
}

void mousePressed() {
  int x = -150, y = -200;
  
  for (int i = 0; i < 3; i++) {
    x = -150;
    y += 100;
    
    for (int j = 0; j < 4; j++) {
      if (!wait && (mouseX > positionX+x && mouseX < positionX+x+sizeRect &&
          mouseY > positionY+y && mouseY < positionY+y+sizeRect)) {
            click(i*4+j);
            gameStatus();
      }
      x += 100;
    }
  }
}

void click(int currentIndex) {
  if (firstClick) {
    indexImg1 = currentIndex;
    image1 = board[indexImg1].getString("image");
    pImg1X = board[indexImg1].getInt("x");
    pImg1Y = board[indexImg1].getInt("y");
    showImg1 = true;
    firstClick = false;
    return;
  }
        
  if (indexImg1 != currentIndex) {
    image2 = board[currentIndex].getString("image");
    pImg2X = board[currentIndex].getInt("x");
    pImg2Y = board[currentIndex].getInt("y");
    showImg2 = true;
    firstClick = true; 
    
    boolean sameImage = checkSameImage(image1, image2);
    board[currentIndex].setBoolean("showImage", sameImage);
    board[currentIndex].setBoolean("match", sameImage);
    board[indexImg1].setBoolean("showImage", sameImage);
    board[indexImg1].setBoolean("match", sameImage);
    wait = true;
    startTime = millis();
  }
}

void drawRect() {
  int x = -150, y = -200;
  
  for (int i = 0; i < 3; i++) {
    x = -150;
    y += 100;
    
    for (int j = 0; j < 4; j++) {
      fill(168, 230, 163);
      noStroke();
      rect(positionX+x, positionY+y, sizeRect, sizeRect);
      board[i*4+j].setInt("x", positionX+x);
      board[i*4+j].setInt("y", positionY+y);
      x += 100;
    }
  }
}

void drawImage() {
  if (showImg1) {
    pImg1 = loadImage(image1);
    image(pImg1, pImg1X, pImg1Y);
  }
  
  if (showImg2) {
    pImg2 = loadImage(image2);
    image(pImg2, pImg2X, pImg2Y);
  }
}

void showImages() {
  for(int i = 0; i < board.length; i++) {
    if (board[i].getBoolean("showImage")) {
      PImage img = loadImage(board[i].getString("image"));
      image(img, board[i].getInt("x"), board[i].getInt("y"));
    }
  }
}

void imagePosition() {
  for (int i = 0; i < images.length; i++) {
    int randomPosition1 = randomPosition();
    board[randomPosition1].setString("image", images[i]);
    
    int randomPosition2 = randomPosition();
    board[randomPosition2].setString("image", images[i]);
  } 
}

void initializeGame() {
  for(int i = 0; i < board.length; i++) {
    board[i].setBoolean("showImage", false);
    board[i].setBoolean("match", false);
    board[i].setString("image", null);
  }
  
  imagePosition();
  attempts = 8;
  message = "";
}

void gameStatus() {
  if (checkWin()) {
    message = "Você Ganhou!!!";
    waitRestart = true;
    startTimeRestart = millis();
    return;
  };
  
  if (attempts == 0) {
    message = "Você Perdeu!!!";
    for (int i = 0; i < board.length; i++) {
      board[i].setBoolean("showImage", true);
    }
    waitRestart = true;
    startTimeRestart = millis();
  }
}

boolean checkWin() {
  boolean win = true;

  for (int i = 0; i < board.length; i++) {
      if (!board[i].getBoolean("match")) {
          win = false;
          break;
      }
  }
  
  if (win) {
    return true;
  }
  
  return false;
}

boolean checkPosition(int position) {
  if (board[position].getString("image") == null) return true;
  
  return false;
}

boolean checkSameImage(String img1, String img2) {
  if (img1.equals(img2)) return true;
  
  attempts -= 1;
  return false;
}

int randomPosition() {
  while(true) {
    int position = int(random(0, board.length));
    
    if (checkPosition(position)) return position;
  }
}
