import spacebrew.*;

String server= "sandbox.spacebrew.cc";
String name="burritoBuilder";
String description ="";

Spacebrew sb;
JSONObject Burrito = new JSONObject();

int area;

color[][] dot = new color[600][600];
float brushSize = 50;
float burrW;
float burrH;
color mark= color(255);

int meat=0;
int guac=0;
int chee=0;
int bean=0;
int salsa=0;


void setup() {
  size(600, 600);

  sb = new Spacebrew( this );
  sb.addPublish ("Sender", "burrito", Burrito.toString());
  sb.connect(server, name, description);

  burrW = width/1.5;
  burrH = height/1.5;
  area = int(PI*(burrW/2-5)*(burrW/2-5));

  noCursor();

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
      set(i, j, dot[i][j]);
    }
  }

  fill(0);
  textSize(32);
  text("Burrito Builder v0.1", 150, 30);

  stroke(0);
  strokeWeight(5);
  noFill();
  ellipse(width/2, height/2, burrW, burrH);

  paint();
  analyze();

  button("Meats", color(#863D01), 20, 100);
  button("Guac", color(#9ECB77), 20, 200);
  button("Chee", color(#E8D634), 20, 300);
  button("Bean", color(#A58A5D), 20, 400);
  button("Salsa", color(#C43400), 20, 500);

  stroke(150);
  fill(mark);
  ellipse(mouseX, mouseY, brushSize, brushSize);



  sb.send("Sender", "burrito", Burrito.toString());
}
void paint() {
  if (mousePressed && 
    mouseX>0 &&
    mouseX<width &&
    mouseY>0 &&
    mouseY<height) {


    for (int i = 0; i < width; i++) {
      for (int j=0; j < height; j++) {
        if (dist(i, j, mouseX, mouseY)<=brushSize/2 &&
          dist(i, j, width/2, height/2) <= burrW/2) {
          dot[i][j]=mark;
        }
      }
    }
  }
}

void button(String name, color c, float x, float y) {
  fill(0);
  textSize(20);
  text(name, x, y-10);
  fill(c);
  rect(x, y, 50, 50);

  if (mousePressed &&
    mouseX>x &&
    mouseX<x+50 &&
    mouseY>y &&
    mouseY<y+50) {
    mark = c;
  }
}

void analyze() {
  loadPixels();
  meat=0;
  guac=0;
  chee=0;
  bean=0;
  salsa=0;  

  color m = color(#863D01);
  color g = color(#9ECB77);
  color c = color(#E8D634);
  color b = color(#A58A5D);
  color s = color(#C43400);


  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      if (dist(i, j, width/2, height/2) <= burrW/2) {

        if(pixels[(j*width)+i]==m) meat+=1;
        if (dot[i][j]==g) guac+=1;
        if (dot[i][j]==c) chee+=1;
        if (dot[i][j]==b) bean+=1;
        if (dot[i][j]==s) salsa+=1;
      }
    }
  }

  meat=meat*100/area;
  guac=guac*100/area;
  chee=chee*100/area;
  bean=bean*100/area;
  salsa=salsa*100/area;
//  println(area);

  Burrito.setInt("meat", meat);
  Burrito.setInt("guac", guac);
  Burrito.setInt("chee", chee);
  Burrito.setInt("bean", bean);
  Burrito.setInt("salsa", salsa);

  sb.send("Sender", "burrito", Burrito.toString());
}

