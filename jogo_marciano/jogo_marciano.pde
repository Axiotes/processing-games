import java.util.Arrays;
float btnStartX, btnStartY, btnBackX, btnBackY, btnWidth = 120, btnHeight = 50, recordsY;
float numberTextY = 300, recNumberX, recNumberY, recNumberWidth = 50, recNumberHeight = 50;
int screen = 1, attempts, attemptsUsed, numMarciano;
int[] records = new int[3];
String numInput, message;

void setup() {
  size(800, 800);
  frameRate(24);
  textAlign(CENTER, TOP);

  btnStartX = (width/2)-(btnWidth/2);
  btnStartY = height/2.5;
  recNumberX = (width/2)-(recNumberWidth/2);
  recNumberY = numberTextY+30;
  btnBackX = (width/2)-(btnWidth/2);
  btnBackY = height - (btnHeight*3);
  recordsY = (height/2.5)+100;
}

void draw() {
  switch(screen) {
    case 1: firstScreen(); break;
    case 2: secondScreen(); break;
    default: firstScreen(); break;
  }
}

void mousePressed() {
  // Iniciar partida
  if (screen == 1 &&
     (mouseX > btnStartX && mouseX < btnStartX + btnWidth &&
      mouseY > btnStartY && mouseY < btnStartY + btnHeight)) {
    numMarciano = int(random(0, 101));
    attempts = 7;    
    attemptsUsed = 0;
    message = "";
    numInput = "";
    screen = 2;
    System.out.println(numMarciano);
  }
  
  // Voltar para tela inicial
  if (screen == 2 &&
     (mouseX > btnBackX && mouseX < btnBackX + btnWidth &&
      mouseY > btnBackY && mouseY < btnBackY + btnHeight)) {    
    screen = 1;
  }
}

void keyPressed() {
  if (screen == 2) {
    if (key == BACKSPACE && numInput.length() > 0) {
      numInput = numInput.substring(0, numInput.length() - 1);
    }

    if (Character.isDigit(key) && numInput.length() < 3) {
      numInput = numInput + key;
    }

    if (key == ENTER) {
      checkMarcianoNumber();
    }
  }
}

boolean checkNumberValue(int num) {
  if (num >= 1 && num <= 100) {
    return true;
  }

  message = "Número Inválido! Digite um número de 1 a 100";
  return false;
}

boolean checkAttempts() {
  if (attempts > 1) {
    attempts--;
    attemptsUsed++;
    return true;
  }

  attempts = 0;
  message = "Você perdeu! O marciano estava escondido na árvore " + numMarciano;
  return false;
}

void checkMarcianoNumber() {
  int number = int(numInput);
  numInput = "";

  if (!checkNumberValue(number) || !checkAttempts()) {
    return;
  }

  if (number == numMarciano) {
    sortRecord();
    message = "Parabéns, Você acertou!!!";
  }

  if (number > numMarciano) {
    message = "O Marciano está em uma árvore menor que " + number;
  }

  if (number < numMarciano) {
    message = "O Marciano está em uma árvore maior que " + number;
  }
}

void sortRecord() {
  for (int i = 0; i < records.length; i++) {
      int record = records[i];
      
      if (attemptsUsed < record || record == 0) {
        for (int j = records.length - 1; j > i; j--) {
            records[j] = records[j-1];
        }
        
        records[i] = attemptsUsed;
        break;
      }
    }
 }
 
void firstScreen() {
  background(29, 28, 24);

  textSize(32);
  fill(62, 207, 134);
  text("Jogo do Marciano", width/2, 100);

  textSize(20);
  fill(62, 207, 134);
  text("Existem 100 árvores e o Marciano está escondido em uma delas", width/2, 200);

  textSize(20);
  fill(62, 207, 134);
  text("Você terá 7 tenativas para encontra-lo", width/2, 230);

  rect(btnStartX, btnStartY, btnWidth, btnHeight);

  textSize(14);
  fill(29,28,24);
  text("Iniciar partida", btnStartX+(btnWidth/2), btnStartY+20);

  textSize(20);
  fill(62, 207, 134);
  text("Recordes de Tentativas:", width/2, recordsY);
  
   for (int i = 0; i < records.length; i++) {
     int record = records[i];
     int recordY = (i + 1)*30;
     String position = i + 1 + "º:   ";
    
     if (record != 0) {
       textSize(18);
       fill(62, 207, 134);
       text(position + record, width/2, recordY+recordsY);
     }
   }
}

void secondScreen() {
  background(29, 28, 24);

  textSize(32);
  fill(62, 207, 134);
  text("Jogo do Marciano", width/2, 100);

  textSize(22);
  fill(62, 207, 134);
  text("Tentativas: " + attempts, width/2, 200);

  textSize(18);
  fill(62, 207, 134);
  text("Digite um número:", width/2, numberTextY);

  fill(255, 255, 255);
  rect(recNumberX, recNumberY, recNumberWidth, recNumberHeight);

  textSize(18);
  fill(62, 207, 134);
  text(numInput, recNumberX+(recNumberWidth/2), recNumberY+18);

  textSize(22);
  fill(62, 207, 134);
  text(message, recNumberX+recNumberWidth, recNumberY+(recNumberHeight*2));
  
  rect(btnBackX, btnBackY, btnWidth, btnHeight);
  
  textSize(14);
  fill(29,28,24);
  text("Voltar", btnBackX+(btnWidth/2), btnBackY+20);
}
