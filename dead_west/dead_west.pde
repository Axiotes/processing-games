PImage backgroundImage, playerLifesImage, player;
int playerLifes = 3, playerX, playerY;
boolean playing, playerUp, playerDown, playerLeft, playerRight, playerShooting, bulletVisible;
JSONObject[] bullets;

void setup() {
  size(800, 600);
  frameRate(30);
  textAlign(CENTER, TOP);
  
  playing = false;
  backgroundImage = loadImage("initial.png");
}

void draw() {
  image(backgroundImage, 0, 0);
  
  if (playing) {
    playerLive();
    movePlayer();
    playerSprite();
    activeBullets();
    image(player, playerX, playerY);
  }
}

void keyPressed() {
  if (!playing) {
    playing = true;
    backgroundImage = loadImage("scenario_level1.png");
    initializeGame();
  }

  if (playing) {
    if (key == 'w' || key == 'W') playerUp = true;
    if (key == 's' || key == 'S') playerDown = true;
    if (key == 'a' || key == 'A') playerLeft = true;
    if (key == 'd' || key == 'D') playerRight = true;
    if (key == ' ') playerShooting = true;
  }
}

void keyReleased() {
  if (playing) {
    if (key == 'w' || key == 'W') playerUp = false;
    if (key == 's' || key == 'S') playerDown = false;
    if (key == 'a' || key == 'A') playerLeft = false; 
    if (key == 'd' || key == 'D') playerRight = false;
    if (key == ' ') { 
      playerShooting = false; 
      shoot();
    }
  }
}

void movePlayer() {
  int speed = 5;

  if (playerUp && playerY > 0) playerY -= speed;
  if (playerDown  && playerY < height - 100) playerY += speed;
  if (playerLeft && playerX > 0) playerX -= speed;
  if (playerRight && playerX < width - 66) playerX += speed;
}

void playerLive() {
  int x = 10;
  
  for(int i = 0; i < playerLifes; i++) {
    image(playerLifesImage, x, 10);
    
    x += 40;
  }
}

void playerSprite() {
  if (playerShooting) {
    player = loadImage("player-shooting.png");
    return;
  }
  
  if (playerLeft) {
    player = loadImage("player-left.png");
    return;
  }
  
  if (playerRight) {
    player = loadImage("player-right.png");
    return;
  }
  
  player = loadImage("player.png");
}

void shoot() {
  for (int i = 0; i < bullets.length; i++) {
    if (!bullets[i].getBoolean("active")) {
      bullets[i].setInt("x", playerX);
      bullets[i].setInt("y", playerY + 20);
      bullets[i].setBoolean("active", true);
      return;
    }
  }
}

void activeBullets() {
  for (int i = 0; i < bullets.length; i++) {
    if (bullets[i].getBoolean("active")) {
      PImage bullet = loadImage("bullet.png");
      int bulletX = bullets[i].getInt("x");
      int bulletY = bullets[i].getInt("y");
      
      image(bullet, bulletX, bulletY);
      
      bullets[i].setInt("x", bulletX + 10);
      // bullets[i].setInt("y", bulletX + 10);
      
      if (bulletX > width) {
        bullets[i].setBoolean("active", false);
        bullets[i].setInt("x", 0);
        bullets[i].setInt("y", 0);
      }
    }
  }
}

void initializeGame() {
  playerLifesImage = loadImage("life.png");
  player = loadImage("player.png");
  playerX = width/2 - 33;
  playerY = height/2 - 50;
  
  bullets = new JSONObject[6];
  for (int i = 0; i < bullets.length; i++) {
    bullets[i] = new JSONObject();
    bullets[i].setBoolean("active", false);
    bullets[i].setInt("x", 0);
    bullets[i].setInt("y", 0);
  }
}
