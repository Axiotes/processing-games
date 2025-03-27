String[][] themesWords = new String[3][6];
String theme, word, message = "";
char[] selectedLetters = new char[35];
boolean playing = false, wait = false, showWord = false;
int quantityErrors = 0, time = 0, correctLetters = 0;

void setup() {
  size(800, 600);
  frameRate(30);
  textAlign(CENTER, TOP);
  
  themesWords[0][0] = "Animais";
  themesWords[0][1] = "Cachorro";
  themesWords[0][2] = "Elefante";
  themesWords[0][3] = "Gato";
  themesWords[0][4] = "Tigre";
  themesWords[0][5] = "Papagaio";
  
  themesWords[1][0] = "Frutas";
  themesWords[1][1] = "Banana";
  themesWords[1][2] = "Morango";
  themesWords[1][3] = "Abacaxi";
  themesWords[1][4] = "Uva";
  themesWords[1][5] = "Melancia";
  
  themesWords[2][0] = "Esportes";
  themesWords[2][1] = "Futebol";
  themesWords[2][2] = "Basquete";
  themesWords[2][3] = "Vôlei";
  themesWords[2][4] = "Tênis";
  themesWords[2][5] = "Natação"; 
}

void draw() {
  background(135, 206, 235);
  
  strength();
  stickman();
  
  if (!playing) {
    textSize(24);
    fill(0);
    text("Digite um número", width-250, height/2-100);
    text("para selecionar um tema e iniciar", width-250, height/2-70);
    
    textSize(20);
    fill(0);
    text("1- Animais", width-310, height/2-20);
    text("2- Frutas", width-315, height/2+20);
    text("3- Esportes", width-190, height/2-20);
    text("4- Aleatório", width-190, height/2+20);
    
    return;
  }
  
  drawWord();
  textSize(30);
  fill(0);
  text("Tema: " + theme, width-150, 40);
  drawAlphabet();
  
  textSize(35);
  fill(0);
  text(message, width/2+150, height/2-180);
  
  if (wait && millis() - time >= 3000) {
    finishGame();
    wait = false;
    time = 0;
  }

}

void keyPressed() {
  if (!playing && key == '1') {
    chooseWord(0);
    playing = true;
  }
  
  if (!playing && key == '2') {
    chooseWord(1);
    playing = true;
  }
  
  if (!playing && key == '3') {
    chooseWord(2);
    playing = true;
  }
  
  if (!playing && key == '4') {
    int indexTheme = int(random(0, themesWords.length-1));
    chooseWord(indexTheme);
    playing = true;
  }
  
  if (playing && Character.isLetter(key)) {
    char letter = Character.toLowerCase(key);
    if (checkSelectedLetter(letter)) return;
    
    selectLetter(letter);
    checkWordLetter(letter);
    gameStatus();
  }
  
  if (playing && (key == 'a' || key == 'A')) {
    selectLetter('á');
    selectLetter('â');
    selectLetter('ã');
  }
  
  if (playing && (key == 'e' || key == 'E')) {
    selectLetter('é');
    selectLetter('ê');
  }
  
  if (playing && (key == 'i' || key == 'I')) {
    selectLetter('í');
    selectLetter('î');
  }
  
  if (playing && (key == 'o' || key == 'O')) {
    selectLetter('ó');
    selectLetter('ô');
    selectLetter('õ');
  }
  
  if (playing && (key == 'u' || key == 'U')) {
    selectLetter('ú');
    selectLetter('û');
  }
  
  if (playing && (key == 'c' || key == 'C')) {
    selectLetter('ç');
  }
}

void strength() {
  fill(181, 101, 29);
  noStroke();
  rect(0, height-50, width, height);
  
  strokeWeight(12);
  stroke(0);
  line(130, height-150, 50, height-55);
  
  strokeWeight(12);
  stroke(0);
  line(130, height-150, 210, height-55);
  
  strokeWeight(12);
  stroke(0);
  line(130, 100, 130, height-55);
  
  strokeWeight(12);
  stroke(0);
  line(130, 100, 240, 100);
  
  strokeWeight(10);
  stroke(0);
  line(240, 100, 240, 140);
}

void stickman() {
  if (quantityErrors >= 1) {
    fill(0);
    ellipse(240, 180, 80, 80);
  }
  
  if (quantityErrors >= 2) {
    strokeWeight(18);
    stroke(0);
    line(240, 180, 240, 380);
  }
  
  if (quantityErrors >= 3) {
    strokeWeight(16);
    stroke(0);
    line(240, 250, 280, 300);
  }
  
  if (quantityErrors >= 4) {
    strokeWeight(16);
    stroke(0);
    line(240, 250, 200, 300);
  }
  
  if (quantityErrors >= 5) {
    strokeWeight(16);
    stroke(0);
    line(240, 380, 280, 430);
  }
  
  if (quantityErrors >= 6) {
    strokeWeight(16);
    stroke(0);
    line(240, 380, 200, 430);
  }
}

void chooseWord(int indexTheme) {
  String[] selectedTheme = themesWords[indexTheme];
  
  theme = selectedTheme[0];
  word = selectedTheme[int(random(1, selectedTheme.length-1))];
  
  println(theme, word);
}

void drawWord() {
  int position = 50;
  
  for (int i = 0; i <= word.length()-1; i++) {
    char letter = word.charAt(i);
    
    char text = checkSelectedLetter(letter) || showWord ? letter : '_';
    
    textSize(40);
    fill(0);
    text(text, width/2+position, height/2-100);
    
    position += 30;
  }
}

void selectLetter(char letter) {
  for (int i = 0; i < selectedLetters.length; i++) {
    if (selectedLetters[i] == '\u0000') {
      selectedLetters[i] = letter;
      break;
    }
  }
}

void drawAlphabet() {
  String firstHalfAlphabet = "ABCDEFGHIJKLM";
  String secondHalfAlphabet = "NOPQRSTUVWXYZ";
  int positionWidth = -30;
  
  for (int i = 0; i <= firstHalfAlphabet.length()-1; i++) {
    char letter = firstHalfAlphabet.charAt(i);
    
    char text = !checkSelectedLetter(letter) ? letter : '-';
    
    textSize(25);
    fill(0);
    text(text, width/2+positionWidth, height/2);
    
    positionWidth += 30;
  }
  
  positionWidth = -30;
  
  for (int i = 0; i <= secondHalfAlphabet.length()-1; i++) {
    char letter = secondHalfAlphabet.charAt(i);
    
    char text = !checkSelectedLetter(letter) ? letter : '-';
    
    textSize(25);
    fill(0);
    text(text, width/2+positionWidth, height/2+50);
    
    positionWidth += 30;
  }
}

void checkWordLetter(char letter) {
  for (int i = 0; i < word.length(); i++) {
    char wordLetter = word.charAt(i);
    
    if (Character.toLowerCase(wordLetter) == Character.toLowerCase(letter)) {
      correctLetters += 1;
      return;
    }
  }
  
  quantityErrors += 1;
}

boolean checkSelectedLetter(char letter) {
  for (int i = 0; i < selectedLetters.length; i++) {
    char selectedLetter = selectedLetters[i];
    
    if (selectedLetter == Character.toLowerCase(letter)) {
      return true;
    }
  }
  
  return false;
}

void finishGame() {
  for (int i = 0; i < selectedLetters.length; i++) {
    selectedLetters[i] = '\u0000';
  }
  quantityErrors = 0;
  correctLetters = 0;
  playing = false;
  showWord = false;
  theme = "";
  word = "";
  message = "";
}

void gameStatus() {
  if (quantityErrors == 6) {
    message = "Você Perdeu!!!";
    showWord = true;
    wait = true;
    time = millis();
    
    return;
  }
  
  if (correctLetters == word.length()) {
    message = "Você Ganhou!!!";
    showWord = true;
    wait = true;
    time = millis();
  }
}
