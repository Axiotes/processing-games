import java.util.Arrays;

int screen = 1;
int player = 1;
int match = 0;
JSONObject[] board;
JSONObject[] playerWins;
boolean playerMode;
boolean playerTurn = true;
boolean matchOver = false;
String message = "";

boolean waitMatch = false;
int startTimeMatch = 0;
boolean waitGame = false;
int startTimeGame = 0;
boolean waitCpu = false;
int startTimeCpu = 0;

int player1Rgb = 255;
int[] player2Rgb = new int[3];

float btnPlayerX, btnPlayerY, btnCompX, btnCompY, btnWidth = 250, btnHeight = 120; // Botoes
int btnBackPosition = 30, btnBackWidth = 80, btnBackHeight = 40;

float horLineY1 = 150, horLineY2 = 650, firstLineHorX = 400, secondLineHorX = 600; // Linhas HORIZONTAIS
float verLineX1 = 250, verLineX2 = 750, firstLineVerY = 300, secondLineVerY = 500; // Linhas VERTICAIS

void setup() {
  size(1000, 800);
  frameRate(24);
  textAlign(CENTER, TOP);
  
  btnPlayerX = (width/2)-(btnWidth+10);
  btnPlayerY = height/2;
  btnCompX = (width/2)+10;
  btnCompY = height/2;
}

void draw() {
  switch(screen) {
    case 1: firstScreen(); break;
    case 2: secondScreen(); break;
    default: firstScreen(); break;
  }
}

void mousePressed() {
  // Clicks da PRIMEIRA tela
  if (screen == 1) {
    // Iniciar partida contra Jogador
    if (mouseX > btnPlayerX && mouseX < btnPlayerX + btnWidth &&
        mouseY > btnPlayerY && mouseY < btnPlayerY + btnHeight) {
      screen = 2;
      playerMode = true;
      initializeGame();
    }
    
    // Iniciar partida contra Computador
    if (mouseX > btnCompX && mouseX < btnCompX + btnWidth &&
        mouseY > btnCompY && mouseY < btnCompY + btnHeight) {
      screen = 2;
      playerMode = false;
      initializeGame();
    }
    return;
  }
  
  // Clicks da SEGUNDA tela
  if (screen == 2 && !waitMatch) {
    // Voltar para tela inicial
    if (mouseX > btnBackPosition && mouseX < btnBackPosition + btnBackWidth &&
        mouseY > btnBackPosition && mouseY < btnBackPosition + btnBackHeight) {
      screen = 1;
    }
    // A1
    if (mouseX > verLineX1 && mouseX < firstLineHorX &&
        mouseY > horLineY1 && mouseY < firstLineVerY) {
      if (!board[0].getBoolean("status") && playerTurn) {
        board[0].setBoolean("status", true);
        board[0].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        actionMode();
        changeColor();
      }
    }
    
    // A2
    if (mouseX > firstLineHorX && mouseX < secondLineHorX &&
        mouseY > horLineY1 && mouseY < firstLineVerY) {
      if (!board[1].getBoolean("status") && playerTurn) {
        board[1].setBoolean("status", true);
        board[1].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        playerTurn = playerMode == true ? true : false;
        actionMode();
        changeColor();
      }
    }
    
    // A3
    if (mouseX > secondLineHorX && mouseX < verLineX2 &&
        mouseY > horLineY1 && mouseY < firstLineVerY) {
      if (!board[2].getBoolean("status") && playerTurn) {
        board[2].setBoolean("status", true);
        board[2].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        playerTurn = playerMode == true ? true : false;
        actionMode();
        changeColor();
      }
    }
    
    // B1
    if (mouseX > verLineX1 && mouseX < firstLineHorX &&
        mouseY > firstLineVerY && mouseY < secondLineVerY) {
      if (!board[3].getBoolean("status") && playerTurn) {
        board[3].setBoolean("status", true);
        board[3].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        playerTurn = playerMode == true ? true : false;
        actionMode();
        changeColor();
      }
    }
    
    // B2
    if (mouseX > firstLineHorX && mouseX < secondLineHorX &&
        mouseY > firstLineVerY && mouseY < secondLineVerY) {
      if (!board[4].getBoolean("status") && playerTurn) {
        board[4].setBoolean("status", true);
        board[4].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        playerTurn = playerMode == true ? true : false;
        actionMode();
        changeColor();
      }
    }
    
    // B3
    if (mouseX > secondLineHorX && mouseX < verLineX2 &&
        mouseY > firstLineVerY && mouseY < secondLineVerY) {
      if (!board[5].getBoolean("status") && playerTurn) {
        board[5].setBoolean("status", true);
        board[5].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        playerTurn = playerMode == true ? true : false;
        actionMode();
        changeColor();
      }
    }
    
    // C1
    if (mouseX > verLineX1 && mouseX < firstLineHorX &&
        mouseY > secondLineVerY && mouseY < horLineY2) {
      if (!board[6].getBoolean("status") && playerTurn) {
        board[6].setBoolean("status", true);
        board[6].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        playerTurn = playerMode == true ? true : false;
        actionMode();
        changeColor();
      }
    }
    
    // C2
    if (mouseX > firstLineHorX && mouseX < secondLineHorX &&
        mouseY > secondLineVerY && mouseY < horLineY2) {
      if (!board[7].getBoolean("status") && playerTurn) {
        board[7].setBoolean("status", true);
        board[7].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        playerTurn = playerMode == true ? true : false;
        actionMode();
        changeColor();
      }
    }
    
    // C3
    if (mouseX > secondLineHorX && mouseX < verLineX2 &&
        mouseY > secondLineVerY && mouseY < horLineY2) {
      if (!board[8].getBoolean("status") && playerTurn) {
        board[8].setBoolean("status", true);
        board[8].setInt("player", player);
        checkMatchWinner();
        player = player == 1 ? 2 : 1;
        playerTurn = playerMode == true ? true : false;
        actionMode();
        changeColor();
      }
    }
  }
}

void changeColor() {
  if (player == 1) {
    player1Rgb = 255;    
    player2Rgb[0] = 0;
    player2Rgb[1] = 0;
    player2Rgb[2] = 0;
    return;
  }
  
  player1Rgb = 0;
  player2Rgb[0] = 135;
  player2Rgb[1] = 206;
  player2Rgb[2] = 235;
}

void drawMark(String position, int currentPlayer) {
  float positionX = 0;
  float positionY = 0;
  
  switch (position) {
    case "a1":
        positionX = verLineX1+(firstLineHorX-verLineX1)/2; // 250+(400-250)/2 = 325
        positionY = horLineY1+(firstLineVerY-horLineY1)/2; // 150+(300-150)/2 = 225
        break;
    case "a2":
        positionX = firstLineHorX+(secondLineHorX-firstLineHorX)/2;
        positionY = horLineY1+(firstLineVerY-horLineY1)/2;
        break;
    case "a3":
        positionX = secondLineHorX+(verLineX2-secondLineHorX)/2;
        positionY = horLineY1+(firstLineVerY-horLineY1)/2;
        break;
    case "b1":
        positionX = verLineX1+(firstLineHorX-verLineX1)/2;
        positionY = firstLineVerY+(secondLineVerY-firstLineVerY)/2;
        break;
    case "b2":
        positionX = firstLineHorX+(secondLineHorX-firstLineHorX)/2;
        positionY = firstLineVerY+(secondLineVerY-firstLineVerY)/2;
        break;
    case "b3":
        positionX = secondLineHorX+(verLineX2-secondLineHorX)/2;
        positionY = firstLineVerY+(secondLineVerY-firstLineVerY)/2;
        break;
    case "c1":
        positionX = verLineX1+(firstLineHorX-verLineX1)/2;
        positionY = secondLineVerY+(horLineY2-secondLineVerY)/2;
        break;
    case "c2":
        positionX = firstLineHorX+(secondLineHorX-firstLineHorX)/2;
        positionY = secondLineVerY+(horLineY2-secondLineVerY)/2;
        break;
    case "c3":
        positionX = secondLineHorX+(verLineX2-secondLineHorX)/2;
        positionY = secondLineVerY+(horLineY2-secondLineVerY)/2;
        break;
  }
  
  if (currentPlayer == 1) {
    noFill();
    stroke(255, 0, 0);
    ellipse(positionX, positionY, 80, 80);
    return;
  }
  
  strokeWeight(5);
  stroke(135, 206, 235);
  line(positionX-45, positionY-45, positionX+35, positionY+35); // a1 = 280, 180, 360, 260 
  
  strokeWeight(5);
  stroke(135, 206, 235);
  line(positionX+35, positionY-45, positionX-45, positionY+35); // a1 = 360, 180, 280, 260 
}

void initializeBoard() {
  board = new JSONObject[9];
  
  for (int i = 0; i < board.length; i++) {
    board[i] = new JSONObject();
    String localization = "a" + (i+1);
    if (i > 2) localization = "b" + (i-2);
    if (i > 5) localization = "c" + (i-5);
    board[i].setString("localization", localization);
    board[i].setBoolean("status", false);
    board[i].setInt("player", 0);
  }
}

void initializeMatch() {
  match++;
  initializeBoard();
  matchOver = false;
}

void initializeGame() {
  match = 0;
  initializeMatch();
  inicializePlayersWins();
}

void inicializePlayersWins() {
  playerWins = new JSONObject[2];
  
  playerWins[0] = new JSONObject();
  playerWins[0].setInt("player", 1);
  playerWins[0].setInt("wins", 0);
  
  playerWins[1] = new JSONObject();
  playerWins[1].setInt("player", 2);
  playerWins[1].setInt("wins", 0);
}

void checkMatchWinner() {
  // Verificar linhas e colunas
  for (int i = 0; i < 3; i++) {
    int lineEl1 = i * 3;
    int lineEl2 = lineEl1+1;
    int lineEl3 = lineEl1+2;
    
    int columnEl1 = i;
    int columnEl2 = i+3;
    int columnEl3 = i+6;
    
    boolean samePlayer = 
      // Verficar linhas se e o mesmo jogador
      (board[lineEl1].getInt("player") == board[lineEl2].getInt("player") && 
      board[lineEl2].getInt("player") == board[lineEl3].getInt("player")) ||
      // Verificar coluna se e o mesmo jogador
      (board[columnEl1].getInt("player") == board[columnEl2].getInt("player") && 
      board[columnEl2].getInt("player") == board[columnEl3].getInt("player"));
      
    boolean allMarked = 
      // Verificar se toda a linha esta com status true
      (board[lineEl1].getBoolean("status") && 
      board[lineEl2].getBoolean("status") && 
      board[lineEl3].getBoolean("status")) ||
      // Verificar se toda a coluna esta com status true
      (board[columnEl1].getBoolean("status") && 
      board[columnEl2].getBoolean("status") && 
      board[columnEl3].getBoolean("status"));
      
    if (allMarked && samePlayer) {
      message = "Jogador " + player + " ganhou a " + match + "º partida";
      playerWins[player-1].setInt("wins", playerWins[player-1].getInt("wins") + 1);
      checkGameWinner();
      waitMatch = true;
      startTimeMatch = millis();
      matchOver = true;
      return;
    }
  }
  
  // Verficar diagonais
  boolean samePlayerDiagonals = 
    // Verficar primeira diagonal se e o mesmo jogador
      (board[0].getInt("player") == board[4].getInt("player") && 
      board[4].getInt("player") == board[8].getInt("player")) ||
      // Verificar segunda diagonal se e o mesmo jogador
      (board[2].getInt("player") == board[4].getInt("player") && 
      board[4].getInt("player") == board[6].getInt("player"));
      
  boolean allMarkedDiagonals = 
      // Verificar se toda a primeira diagonal esta com status true
      (board[0].getBoolean("status") && 
      board[4].getBoolean("status") && 
      board[8].getBoolean("status")) ||
      // Verificar se toda a segunda diagonal esta com status true
      (board[2].getBoolean("status") && 
      board[4].getBoolean("status") && 
      board[6].getBoolean("status"));
      
  if (allMarkedDiagonals && samePlayerDiagonals) {
      message = "Jogador " + player + " ganhou a " + match + "º partida";
      playerWins[player-1].setInt("wins", playerWins[player-1].getInt("wins") + 1);
      checkGameWinner();
      waitMatch = true;
      startTimeMatch = millis();
      matchOver = true;
      return;
  }
}

void checkGameWinner() {
  if (playerWins[player-1].getInt("wins") == 3) {
    message = "Jogador " + player + " ganhou o jogo!!!";
    waitGame = true;
    startTimeGame = millis();
  }
}

void actionMode() {
  if (playerMode == true) {
    playerTurn = true;
    waitCpu = false;
    startTimeCpu = 0;
    return;
  }
  
  playerTurn = false;
  waitCpu = true;
  startTimeCpu = millis();
}

void cpuChoice() {
  while(true) {
    int position = int(random(0, 8));
    
    if (!board[position].getBoolean("status")) {
      board[position].setBoolean("status", true);
      board[position].setInt("player", player);
      checkMatchWinner();
      player = player == 1 ? 2 : 1;
      playerTurn = true;
      changeColor();
      break;
    }
  }
}

void firstScreen() {
  background(255, 255, 255);
  
  textSize(32);
  fill(0);
  text("Jogo da Velha", width/2, 100);
  
  textSize(26);
  fill(0);
  text("Selecione o modo de jogo", width/2, 200);
  
  fill(135, 206, 235);
  noStroke();
  rect(btnPlayerX, btnPlayerY, btnWidth, btnHeight);
  textSize(24);
  fill(0);
  text("Jogador x Jogador", btnPlayerX+(btnWidth/2), btnPlayerY+(btnHeight/2.5));
  
  fill(135, 206, 235);
  noStroke();
  rect(btnCompX, btnCompY, btnWidth, btnHeight);
  textSize(24);
  fill(0);
  text("Jogador x Computador", btnCompX+(btnWidth/2), btnCompY+(btnHeight/2.5));
}

void secondScreen() {
  background(255, 255, 255);
  
  fill(0);
  noStroke();
  rect(btnBackPosition, btnBackPosition, btnBackWidth, btnBackHeight);
  textSize(16);
  fill(255, 255, 255);
  text("Voltar", btnBackPosition+(btnBackWidth/2), btnBackPosition+(btnBackHeight/2.5));
  
  // Primeira linha horizontal
  strokeWeight(5);
  stroke(0);
  line(firstLineHorX, horLineY1, firstLineHorX, horLineY2);
  
  // Primeira linha vertical
  strokeWeight(5);
  stroke(0);
  line(verLineX1, firstLineVerY, verLineX2, firstLineVerY);
  
  // Segunda linha horizontal
  strokeWeight(5);
  stroke(0);
  line(secondLineHorX, horLineY1, secondLineHorX, horLineY2);
  
  // Segunda linha vertical
  strokeWeight(5);
  stroke(0);
  line(verLineX1, secondLineVerY, verLineX2, secondLineVerY);
  
  for (int i = 0; i < board.length; i++) {
    if (board[i].getBoolean("status")) {
      drawMark(board[i].getString("localization"), board[i].getInt("player"));
    }
  }
  
  textSize(24);
  fill(0);
  text(message, width/2, 80);
  
  textSize(26);
  fill(player1Rgb, 0, 0);
  text("Jogador 1", 100, (height/2)-20);
  
  textSize(26);
  fill(player1Rgb, 0, 0);
  text(playerWins[0].getInt("wins"), 100, (height/2)+15);
  
  textSize(26);
  fill(player2Rgb[0], player2Rgb[1], player2Rgb[2]);
  text("Jogador 2", width-100, (height/2)-20);
  
  textSize(26);
  fill(player2Rgb[0], player2Rgb[1], player2Rgb[2]);
  text(playerWins[1].getInt("wins"), width-100, (height/2) + 15); 
  
  if (waitMatch && millis() - startTimeMatch >= 2000) {
    initializeMatch();
    message = "";
    waitMatch = false;
    startTimeMatch = 0;
  }
  
  if (waitGame && millis() - startTimeGame >= 2000) {
    initializeGame();
    message = "";
    waitGame = false;
    startTimeGame = 0;
  }
  
  if (waitCpu && millis() - startTimeCpu >= 1000 && !matchOver) {
    cpuChoice();
    waitCpu = false;
    startTimeCpu = 0;
  }
}
