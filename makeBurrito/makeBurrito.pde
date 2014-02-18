int area = int(PI*600*600);
color[][] dot = new color[600][600];
float brushSize = 50;
float burrW;
float burrH;
color mark= color(255, 102, 204);


void setup() {
  size(600, 600);
  burrW = width/1.5;
  burrH = height/1.5;
  noCursor();
  println(area);

  for (int i = 0; i < width; i++) {
    for (int j=0; j < height; j++) {
      dot[i][j] = color(255);
    }
  }
}

void draw() {
  textSize(32);
  text("Burrito Builder v0.1", 50, 20);

  for (int i=0; i < width; i++) {
    for (int j=0; j < height; j++) {
      set(i,j , dot[i][j]);
    }
  }
  
  fill(0);
  textSize(32);
  text("Burrito Builder v0.1", 150,30);

  stroke(0);
  strokeWeight(5);
  noFill();
  ellipse(width/2, height/2, burrW, burrH);

  paint();

  button("Meats", color(#863D01), 20, 100);
  button("Guac", color(#9ECB77), 20, 200);
  button("Chee", color(#E8D634), 20, 300);
  button("Bean", color(#A58A5D), 20, 400);
  button("Salsa", color(#C43400), 20, 500);

  stroke(150);
  noFill();
  ellipse(mouseX, mouseY, brushSize, brushSize);
}

void paint() {
  if (mousePressed && 
    mouseX>0 &&
    mouseX<width &&
    mouseY>0 &&
    mouseY<height) {


    for (int i = 0; i < width; i++) {
      for (int j=0; j < height; j++) {
        if (dist(i,j, mouseX, mouseY)<=brushSize/2 &&
            dist(i, j, width/2, height/2) <= burrW/2) {
          dot[i][j]=mark;
        }
      }
    }
  }
}

void button(String name, color c, float x, float y){
 fill(0);
 textSize(20);
 text(name, x,y-10);
 fill(c);
 rect(x,y,50,50);
  
}

