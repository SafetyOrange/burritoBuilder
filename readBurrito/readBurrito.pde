import spacebrew.*;

String server= "sandbox.spacebrew.cc";
String name="burritoReader";
String description ="";

Spacebrew sb;
JSONObject burrito = new JSONObject();

color[][] dot = new color[600][600];
float brushSize = 50;
float burrW;
float burrH;
color mark= color(255, 102, 204);

float meat, mS;
float guac, gS;
float chee, cS;
float bean, bS;
float salsa, sS;


void setup() {
  size(600, 600, P3D);

  sb = new Spacebrew( this );
  sb.addSubscribe ("Reader", "Burrito");
  sb.connect(server, name, description);

  burrW = width/1.5;
  burrH = height/1.5;

  for (int i = 0; i < width; i++) {
    for (int j=0; j < height; j++) {
      dot[i][j] = color(255);
    }
  }
}

void draw() {
  background(255);
  fill(0);
  textSize(32);
  text("Burrito Reader v0.1", 150, 30);

  mS=map(meat, 0, 100, 0, 8);
  gS=map(guac, 0, 100, 0, 8);
  cS=map(chee, 0, 100, 0, 8);
  bS=map(bean, 0, 100, 0, 8);
  sS=map(salsa, 0, 100, 0, 8);


  text("Meat: " + meat + " (" + mS + " large serving spoons)" +
    "\nGuac: " + guac + " (" + gS + " large serving spoons)" +
    "\nChee: " + chee + " (" + cS + " large serving spoons)" +
    "\nBean: " + bean + " (" + bS + " large serving spoons)" +
    "\nSalsa: " + salsa + " (" + sS + " large serving spoons)", 30, 170);
}

void onCustomMessage( String name, String type, String value ) {

  if ( type.equals("burrito") ) {
    // parse JSON!
    JSONObject m = JSONObject.parse( value );
    meat = m.getInt("meat");
    guac = m.getInt("guac");
    chee = m.getInt("chee");
    bean = m.getInt("bean");
    salsa = m.getInt("salsa");
  }
}

