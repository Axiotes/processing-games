int firstLineY1, firstLineY2, secondLineY1, secondLineY2, player1Score, player2Score;
float x, y, speedX, speedY, startSpeed;
boolean hitFirstLine, hitSecondLine, playing, waitStart = false;
String message = "";
int time, pointTime, startTimeGame = 0;

void setup() {
  size(700, 500);
  frameRate(30);
  textAlign(CENTER, TOP);
}

void draw() {
  background(0);
  
  if (!playing) {
    textSize(28);
    fill(255, 255, 255);
    text("Digite um número de 1 a 3 para", width/2, height/2-80);
    text("selecionar dificuldade e inicar partida", width/2, height/2-30);
    
    textSize(16);
    fill(255, 255, 255);
    text("1- Fácil", width/2-100, height/2+30);
    text("2- Médio", width/2, height/2+30);
    text("3- Difícil", width/2+100, height/2+30);
    return;
  }
  
  textSize(28);
  fill(255, 255, 255);
  text(message, width/2, height/2-80);
  
  if (waitStart && millis() - startTimeGame >= 3000) {
    playing = false;
    message = "";
    waitStart = false;
    startTimeGame = 0;
  }
  
  if (millis() - pointTime >= time){
    pointTime = millis();
    speedX = speedX * 1.2;
    speedY = speedY * 1.2;
    time = time + 10000;
  }
  
  textSize(26);
  fill(255, 255, 255);
  text(player1Score + "  :  " + player2Score, width/2, 30);
  
  strokeWeight(10);
  stroke(255, 255, 255);
  line(15, firstLineY1, 15, firstLineY2);
  
  strokeWeight(10);
  stroke(255, 255, 255);
  line(width-15, secondLineY1, width-15, secondLineY2);
  
  x += speedX;
  y += speedY;
  
  hitFirstLine = (x >= 25-10 && x <= 25+10) && (y >= firstLineY1 && y <= firstLineY2);
  hitSecondLine = (x >= width-25-10 && x <= width-25+10) && (y >= secondLineY1 && y <= secondLineY2);
  
  if ((x <= 5 || x >= width-5) || hitFirstLine || hitSecondLine) {
    makePoint();
    speedX *= -1;
  }
  
  if (y <= 10 || y >= height-10) {
    speedY *= -1;
  }
  
  fill(255);
  ellipse(x, y, 10, 10);
}

void keyPressed() {
  if (playing && (key == 'w' || key == 'W') && firstLineY1 > 10) {
    firstLineY1 -= 10;
    firstLineY2 -= 10;
  }
  
  if (playing && (key == 's' || key == 'S') && firstLineY2 < height-10) {
    firstLineY1 += 10;
    firstLineY2 += 10;   
  }
  
  if (playing && keyCode == UP && secondLineY1 > 10) {
    secondLineY1 -= 10;
    secondLineY2 -= 10;
  }
  
  if (playing && keyCode == DOWN && secondLineY2 < height-10) {
    secondLineY1 += 10;
    secondLineY2 += 10;   
  }
  
  if (!playing && key == '1') {
    inicializeMatch(200, 4);
  }
  
  if (!playing && key == '2') {
    inicializeMatch(150, 6);
  }
  
  if (!playing && key == '3') {
    inicializeMatch(100, 8);
  }
}

void makePoint() {
  if (hitFirstLine || hitSecondLine) {
    return;
  }
  
  player1Score = x >= width-5 ?  player1Score+1 : player1Score;
  player2Score = x <= 5 ?  player2Score+1 : player2Score;  
  x = width/2;
  y = height/2;
  time = 10000;
  speedX = startSpeed;
  speedY = startSpeed;
  checkWinner();
}

void inicializeMatch(int lineSize, int ballSpeed) {
  int halfLineSize = lineSize/2;
  
  player1Score = 0;
  player2Score = 0;
  x = width/2;
  y = height/2;
  firstLineY1 = height/2-halfLineSize;
  firstLineY2 = height/2+halfLineSize;
  secondLineY1 = height/2-halfLineSize;
  secondLineY2 = height/2+halfLineSize;
  speedX = ballSpeed;
  speedY = ballSpeed;
  startSpeed = ballSpeed;
  playing = true;
}

void checkWinner() {
  if (player1Score == 5 || player2Score == 5) {
    message = player1Score == 5 ? "Jogador 1 Ganhou!!!" : "Jogador 2 Ganhou!!!";
    waitStart = true;
    startTimeGame = millis();
    x = width/2;
    y = height/2;
    speedX = 0;
    speedY = 0;
  } 
}
