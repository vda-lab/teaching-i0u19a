//CARBONEZ DAVID//
//Visualization assignment
//Management of Large-Scale Omics Data
//9/07/2017
//---------------------------------------------

//declare variables
String file = "treestruncated.csv";
String[] lines;
String[] states;
String[] nexusdata;
StringList distances;
StringList distances0;
StringList distances23;
FloatList distancestransformed0;
FloatList distancestransformed23;
FloatList plotdistances0;
FloatList plotdistances23;
ArrayList <StringList> listofdistances;
int centerx = 650;
int centery=500;
int R;
int G;
int B;
int T;


//define window
void setup() {
  size(1700, 1000);
  background(255);


  //load the file
  String[] lines = loadStrings(file); 

  //store tree names
  String[] states = new String[lines.length];
  for (int i = 0; i<lines.length; i++) {
    String[] splitted = split(lines[i], ";");
    states[i] = splitted[0];
  }

  //store nexusdata
  String[] nexusdata = new String[lines.length];
  for (int i = 0; i<lines.length; i++) {
    String[] splitted = split(lines[i], ";");
    nexusdata[i] = splitted[1];
  }
  printArray(nexusdata);

  distances0 = new StringList();
  distances0.append("siamang:0.0657");
  distances0.append("orangutan:0.0485");
  distances0.append("gorilla:0.0319");
  distances0.append("human:0.0209");
  distances0.append("chimp:0.0111");
  distances0.append("bonobo:0.0111");

  distances23 = new StringList();
  distances23.append("siamang:0.051");
  distances23.append("orangutan:0.051");
  distances23.append("gorilla:0.0338");
  distances23.append("human:0.024");
  distances23.append("chimp:0.0131");
  distances23.append("bonobo:0.0131");

  //transform distances
  distancestransformed0 = new FloatList();
  for (int i = 0; i<distances0.size(); i++) {
    String[] splitstring = split(distances0.get(i), ":");
    distancestransformed0.append(Float.parseFloat(splitstring[1]));
  }

  distancestransformed23 = new FloatList();
  for (int i = 0; i<distances23.size(); i++) {
    String[] splitstring = split(distances23.get(i), ":");
    distancestransformed23.append(Float.parseFloat(splitstring[1]));
  }
  printArray(distancestransformed0);
  printArray(distancestransformed23);

  //transform differences according to length
  plotdistances0 = new FloatList();
  for (int i = 0; i<distancestransformed0.size(); i++) {
    plotdistances0.append((distancestransformed0.get(i)/(0.0657))*400);
  }
  println(plotdistances0);

  plotdistances23 = new FloatList();
  for (int i = 0; i<distancestransformed23.size(); i++) {
    plotdistances23.append((distancestransformed23.get(i)/(0.0657))*400);
  }
}

//draw loop
void draw() {
  background(255, 255, 255);
  colorMode(RGB);
  textSize(25);

  //draw the hexagon
  fill(255, 255, 255);
  stroke(0, 0, 0);
  drawHexagon(650, 500, 400);
  fill(0, 0, 0);

  //draw the center
  ellipse(centerx, centery, 10, 10);

  //coordinates of vertices
  //left
  ellipse(250, 500, 10, 10);
  fill(0, 0, 0);
  text("Siamang", 120, 510);
  fill(0, 0, 0);

  //Left upper
  ellipse(450, 154, 10, 10);
  fill(0, 0, 0);
  text("Orangutan", 310, 154);
  fill(0, 0, 0);

  //Right upper
  ellipse(850, 154, 10, 10);
  fill(0, 0, 0);
  text("Gorilla", 870, 154);
  fill(0, 0, 0);

  //right
  ellipse(1050, 500, 10, 10);
  fill(0, 0, 0);
  text("Human", 1070, 510);
  fill(0, 0, 0);
  //right lower
  ellipse(850, 846, 10, 10);
  fill(0, 0, 0);
  text("Chimp", 870, 846);
  fill(0, 0, 0);

  //left lower
  ellipse(450, 846, 10, 10);
  fill(0, 0, 0);
  text("Bonobo", 335, 846);
  fill(0, 0, 0);

  //Instructions
  text("Instructions:",200, 50);;
  line(200, 55, 360, 55);
  text("Click the boxes to visualize the polygons", 200, 80); 

  //Legend
  stroke(0, 0, 0);
  fill(0, 0, 0);
  text("LEGEND", 1270, 170);
  line(1270, 175, 1380, 175);
  fill(255, 255, 255);
  rect(1270, 180, 20, 20);
  rect(1270, 210, 20, 20);
  rect(1270, 240, 20, 20);
  fill(0, 0, 0);
  text("STATE_0: ", 1300, 200);
  text("STATE_23000:", 1300, 230);
  text("View both states", 1300, 260);




  //plot the vertexes
  //First set
  if (mousePressed) {
    if (mouseX> 1270 && mouseX<1290 && mouseY > 180 && mouseY < 200) {
      fill(0, 0, 0);
      rect(1270, 180, 20, 20);
      drawShape(centerx, centery, plotdistances0, 255, 0, 0, 75);
      stroke(0, 0, 0);
      rect(1415, 180, 20, 20);
      fill(0, 0, 0);
    }
  }
  //second set
  if (mousePressed) {
    if (mouseX>1270 && mouseX<1290 && mouseY>210 && mouseY<230) {
      fill(0, 0, 0);
      rect(1270, 210, 20, 20);
      drawShape(centerx, centery, plotdistances23, 0, 0, 255, 75);
      fill(0, 0, 255, 75);
      stroke(0, 0, 0);
      rect(1475, 210, 20, 20);
    }
  }

  //both sets
  if (mousePressed) {
    if (mouseX>1270 && mouseX<1290 && mouseY >240 && mouseY<260) {
      fill(0, 0, 0);
      rect(1270, 240, 20, 20);
      rect(1270, 180, 20, 20);
      drawShape(centerx, centery, plotdistances0, 255, 0, 0, 75);
      stroke(0, 0, 0);
      rect(1415, 180, 20, 20);
      fill(0, 0, 0);
      fill(0, 0, 0);
      rect(1270, 210, 20, 20);
      drawShape(centerx, centery, plotdistances23, 0, 0, 255, 75);
      fill(0, 0, 255, 75);
      stroke(0, 0, 0);
      rect(1475, 210, 20, 20);
    }
  }
}

//function to draw shape
void drawShape(float centerx, float centery, FloatList plotdistances, int R, int G, int B, int T) {
  noStroke();
  fill(R, G, B, T);
  beginShape();
  for (int i=0; i<6; i++) {
    vertex((centerx+((cos((3*(PI/3))-(i*(PI/3))))*plotdistances.get(i))), (centery-((sin((3*(PI/3))-(i*(PI/3))))*plotdistances.get(i))));
  }
  endShape();
}




//function to draw hexagon
void drawHexagon(float x, float y, float radius) {
  pushMatrix();
  translate(x, y);
  beginShape();
  for (int i = 0; i < 6; i++) {
    pushMatrix();
    float angle = PI*i/3;
    vertex(cos(angle) * radius, sin(angle) * radius);
    popMatrix();
  }
  endShape(CLOSE);
  popMatrix();
}