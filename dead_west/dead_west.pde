PImage backgroundImage;

PImage playerLifesImage, player; 
int playerLifes = 3, playerX, playerY;
boolean playing, playerUp, playerDown, playerLeft, playerRight, playerShooting;

boolean bulletVisible;
JSONObject[] bullets;
String currentDirection = "right";

JSONObject[] allZombies;

void setup() {
  size(800, 600);
  frameRate(30);
  textAlign(CENTER, TOP);
  
  playing = false;
  backgroundImage = loadImage("initial.png");
  allZombies = new JSONObject[3];
}

void draw() {
  image(backgroundImage, 0, 0);
  
  if (playing) {
    playerLive();
    movePlayer();
    playerSprite();
    activeBullets();
    image(player, playerX, playerY);
    
    for (int i = 0; i < allZombies.length; i++) {
      JSONObject zombie = allZombies[i];
      
      zombieCollider(zombie);
      zombieMovement(zombie);
      
      if (zombie.getInt("life") == 0) {
        zombie.setString("sprite", "");
        zombie.setInt("score", 0);
        zombie.setInt("life", 0);
        zombie.setInt("x", 0);
        zombie.setInt("y", 0);
        continue;
      }
      
      PImage zombieSprite = loadImage(zombie.getString("sprite"));
      image(zombieSprite, zombie.getInt("x"), zombie.getInt("y"));
    }
  }
}

void keyPressed() {
  if (!playing) {
    playing = true;
    backgroundImage = loadImage("scenario_level1.png");
    initializeGame();
  }

  if (playing) {
    if (key == 'w' || key == 'W') {
      playerUp = true;
      currentDirection = "up";
    }
    if (key == 's' || key == 'S') { 
      playerDown = true;
      currentDirection = "down";
    }
    if (key == 'a' || key == 'A') { 
      playerLeft = true;
      currentDirection = "left";
    }
    if (key == 'd' || key == 'D') { 
      playerRight = true;
      currentDirection = "right";
    }
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
      shoot(currentDirection);
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

//void playerCollider() {
//  for (int i = 0; i < allZombies.length; i++) {
//    int zombieX = allZombies[i].getInt("x");
//    int zombieY = allZombies[i].getInt("y");
      
//    boolean collidedX = (playerX >= zombieX-15 && playerX <= zombieX+20);
//    boolean collidedY = (playerY >= zombieY-20 && playerY <= zombieY+40);
      
//    if (collidedX && collidedY) {
//      println("encostou!!");
//      playerLifes -= 1;
//    }
//  }
//}

void shoot(String direction) {
  for (int i = 0; i < bullets.length; i++) {
    if (!bullets[i].getBoolean("active")) {
      setBullet(i, true, playerX, playerY, direction);
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
      
      if (bullets[i].getString("direction").equals("left")) bullets[i].setInt("x", bulletX - 10); 
      if (bullets[i].getString("direction").equals("right")) bullets[i].setInt("x", bulletX + 10);
      if (bullets[i].getString("direction").equals("up")) bullets[i].setInt("y", bulletY - 10);
      if (bullets[i].getString("direction").equals("down")) bullets[i].setInt("y", bulletY + 10); 
      
      boolean outOfScreen = (bulletX > width || bulletX < 0 || bulletY > height || bulletY < 0);
      
      if (outOfScreen) setBullet(i, false, 0, 0, "");
    }
  }
}

void setBullet(int index, boolean active, int x, int y, String direction) {
  bullets[index].setBoolean("active", active);
  bullets[index].setInt("x", x);
  bullets[index].setInt("y", y);
  bullets[index].setString("direction", direction);
}

void zombieLevel(JSONObject zombie, int level, int x, int y) {
  zombie.setInt("level", level);
  zombie.setString("sprite", "zombie-" + level + "-left.png");
  zombie.setInt("score", level*10);
  zombie.setInt("life", level);
  zombie.setInt("x", x);
  zombie.setInt("y", y);
}

void zombieCollider(JSONObject zombie) {
  for (int i = 0; i < bullets.length; i++) {
    if (bullets[i].getBoolean("active")) {
      int bulletX = bullets[i].getInt("x");
      int bulletY = bullets[i].getInt("y");
    
      int zombieX = zombie.getInt("x");
      int zombieY = zombie.getInt("y");
      
      boolean collidedX = (bulletX >= zombieX-15 && bulletX <= zombieX+20);
      boolean collidedY = (bulletY >= zombieY-20 && bulletY <= zombieY+40);
      
      if (collidedX && collidedY) {
        setBullet(i, false, 0, 0, "");
        int zombieLife = zombie.getInt("life");
        
        zombie.setInt("life", zombieLife-1);
      }
    }
  }
}

void zombieMovement(JSONObject zombie) {
  float speed = 0;

  if (zombie.getInt("level") == 1) speed = 3.5;
  if (zombie.getInt("level") == 2) speed = 2;
  if (zombie.getInt("level") == 3) speed = 1;

  int zombieX = zombie.getInt("x");
  int zombieY = zombie.getInt("y");

  float dx = playerX - zombieX;
  float dy = playerY - zombieY;
  
  float distance = dist(zombieX, zombieY, playerX, playerY);
  
  if (distance > 0) {
    dx = (dx / distance) * speed;
    dy = (dy / distance) * speed;

    zombie.setInt("x", zombieX + int(dx));
    zombie.setInt("y", zombieY + int(dy));
  }
}


void zombieSpawn() {
  for (int i = 0; i < allZombies.length; i++) {
    allZombies[i] = new JSONObject();
    
    int x = int(random(0, width));
    int y = int(random(0, height));
    
    zombieLevel(allZombies[i], 1, x, y);
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
    setBullet(i, false, 0, 0, "");
  }
  
  zombieSpawn();
}
