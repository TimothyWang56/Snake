ArrayList<Float> xPos = new ArrayList<Float>();
ArrayList<Float> yPos = new ArrayList<Float>();
int screenState = 0;
int direction = 0;
int xHead = 400;
int yHead = 300;
int xFood = int(random(15, 785));
int yFood = int(random(15, 585));
int score = 0;
PImage photo;
void setup(){
  size(800,600);
  background(255);
  fill(0);
  for(int i = 0; i < 35; i++){
    xPos.add(float(-100));
  }
  for(int i = 0; i < 35; i++){
    yPos.add(float(-100));
  }
  photo = loadImage("SnakeFace.jpg");
  photo.resize(70, 70);
}

void draw(){
  if(screenState == 0){
    background(255);
    textSize(32);
    text("Click To Play!", 280, 300);
    checkClick();
  }
  if(screenState == 1){
    if(direction != 0) background(255);
    textSize(20);
    text(score, 50, 50);
    translate(xHead, yHead);
    if(direction == 2){
      rotate(PI);
    } else if(direction == 3){
      rotate(3*PI/2);
    } else if(direction == 4){
      rotate(PI/2);
    }
    imageMode(CENTER);
    image(photo, 0, 0);
    resetMatrix();
    ellipse(xFood, yFood, 30, 30);
    checkWall();
    checkTail();
    tail();
    if(direction == 3){
      xHead= xHead + 5;
    }
    else if(direction == 4){
      xHead= xHead - 5;
    }
    else if(direction == 1){
      yHead= yHead + 5;
    }
    else if(direction == 2){
      yHead= yHead - 5;
    }
    if((xHead - xFood)*(xHead - xFood) + (yHead - yFood)*(yHead - yFood) < 1600){
      score = score + 1;
      xFood = int(random(15, 785));
      yFood = int(random(15, 585));
      ellipse(xFood, yFood, 50, 50);
      for(int i = 0; i < 7; i++){
        xPos.add(-100.0);
        yPos.add(-100.0);
      }
    }
  }
  if(screenState == 2){
    background(255);
    textSize(32);
    text("GAME OVER! YOUR SCORE WAS " + score + "!", 130, 270);
    text("Click To Play Again!", 245, 330);
    checkClick();
  }
}
//directions
void keyPressed(){
  if(key == 'w'){
    if(direction != 1){
      direction = 2;
    }
  }
  if(key == 's'){
    if(direction != 2){
      direction = 1;
    }
  }
  if(key == 'a'){
    if(direction != 3){
      direction = 4;
    }
  }
  if(key == 'd'){
    if(direction != 4){
      direction = 3;
    }
  }
}

void checkWall(){
  if(xHead > 775 || xHead < 25 || yHead < 25 || yHead > 575){
    screenState = 2;
  }
}

void tail(){
  if(direction != 0){
    for(int i = xPos.size()-1; i > 0; i--){
      xPos.set(i, xPos.get(i-1));
    }
    for(int i = yPos.size()-1; i > 0; i--){
      yPos.set(i, yPos.get(i-1));
    }
    if(xPos.size() > 0){
      xPos.set(0, float(xHead));
      yPos.set(0, float(yHead));
    }
    fill(#A6E33E);
    for(int i = 0; i < xPos.size() - 7; i++){
      if(i%7 == 0 && i > 6){
        ellipse(xPos.get(i), yPos.get(i), 40, 40);
      }
    }
    fill(0);
  }
}
void checkTail(){
  //if(xPos.size() > 30){
  for(int i = 30; i < xPos.size() - 14; i++){
    if(dist(xHead, yHead, xPos.get(i), yPos.get(i)) < 40){
      screenState = 2;
    }
  }
}
void checkClick(){
  if(screenState == 0){
    if(mousePressed && (mouseButton == LEFT)){
    background(255);
    screenState = 1;
    }
  }
  else if(screenState == 2){
    if(mousePressed && (mouseButton == LEFT)){
      background(255);
      screenState = 1;
      score = 0;
      direction = 0;
      xPos.clear();
      yPos.clear();
      xHead = 400;
      yHead = 300;
      for(int i = 0; i < 35; i++){
        xPos.add(float(-100));
      }
      for(int i = 0; i < 35; i++){
        yPos.add(float(-100));
      }
    }
  }
}
