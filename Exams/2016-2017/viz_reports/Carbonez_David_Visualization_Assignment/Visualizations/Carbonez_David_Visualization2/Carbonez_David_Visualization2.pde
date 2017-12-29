//CARBONEZ DAVID//
//Visualization assignment
//Management of Large-Scale Omics Data
//9/07/2017
//---------------------------------------------

//declare variables
String file = "trees.csv";
String[] lines;
String[] states;
String[] nexusdata;
StringList distances;
ArrayList <StringList> listofdistances;
StringList data;
String siamang = "siamang";
String gorilla = "gorilla";
String bonobo = "bonobo";
String human = "human";
String chimp = "chimp";
String orangutan = "orangutan";
float distance;
float minimumfloat;
float maximumfloat;
float currentfloat;
String currentstring;
int occurrences;
StringList temporary;
FloatList step0;
FloatList step1;
FloatList step2;
FloatList step3;
FloatList step4;
FloatList step5;
StringList step0string;
StringList step1string;
StringList step2string;
StringList step3string;
StringList step4string;
StringList step5string;
boolean isCovered;
boolean isCovered0;
boolean isCovered1;
boolean isCovered2;
boolean isCovered3;
boolean isCovered4;
boolean isCovered5;
int x;
int y;
int xBox;
int yBox;
int h; 
int w;
int countsiamang;
int countgorilla;
int countbonobo;
int counthuman;
int countchimp;
int countorangutan;

//define window
void setup() {
  size(1500, 1000);
  background(255);

  //load the file
  String[] lines = loadStrings(file);


  //store tree names
  String[] states = new String[lines.length-1];
  for (int i = 0; i<lines.length-1; i++) {
    String[] splitted = split(lines[i], ";");
    states[i] = splitted[0];
  }

  //store nexusdata
  String[] nexusdata = new String[lines.length-1];
  for (int i = 0; i<lines.length-1; i++) {
    String[] splitted = split(lines[i], ";");
    nexusdata[i] = splitted[1];
  }

  //extract distances from nexusdata
  listofdistances = new ArrayList <StringList>();
  for (int i = 0; i<nexusdata.length; i++) {
    String[] splitted = split(nexusdata[i], ",");
    for (int k =0; k<splitted.length; k++) {
      splitted[k] = splitted[k].replaceAll("[\\[\\](){}]", "");
    }
    distances = new StringList();
    for (int j = 0; j<6; j++) {
      if (j==5) {
        int p = splitted[5].indexOf(":", splitted[5].indexOf(":")+1);
        splitted[5] = splitted[5].substring(0, p);
      }

      distances.append(splitted[j]);
    }
    listofdistances.add(distances);
    distances = new StringList();
  }
  //find max distance;
  float maxdistance = 0;
  float currentdistance;
  temporary = new StringList();
  for (int j = 0; j<listofdistances.size(); j++) {
    temporary = listofdistances.get(j);
    for (int k = 0; k<temporary.size(); k++) {
      String [] splitted = split(temporary.get(k), ":");
      currentdistance = Float.parseFloat(splitted[1]);
      if (currentdistance > maxdistance) {
        maxdistance = currentdistance;
      }
    }
  }
}

//draw loop
void draw() {
  background(0, 0, 0);
  colorMode(RGB);
  fill(255, 0, 0);
  textSize(25);

  //legenda
  fill(255, 255, 255);
  text("LEGEND", 1300, 75);
  fill(255, 0, 0);
  stroke(255, 0, 0);
  ellipse(1300, 100, 10, 10);
  text("siamang", 1310, 105);
  fill(0, 255, 0);
  stroke(0, 255, 0);
  ellipse(1300, 125, 10, 10);
  text("orangutan", 1310, 130);
  fill(0, 0, 255);
  stroke(0, 0, 255);
  ellipse(1300, 150, 10, 10);
  text("gorilla", 1310, 155);
  fill(255, 255, 0);
  stroke(255, 255, 0);
  ellipse(1300, 175, 10, 10);
  text("human", 1310, 180);
  fill(255, 0, 255);
  stroke(255, 0, 255);
  ellipse(1300, 200, 10, 10);
  text("chimp", 1310, 205);
  fill(0, 255, 255);
  stroke(0, 255, 255);
  ellipse(1300, 225, 10, 10);
  text("bonobo", 1310, 230);


  //draw axes
  stroke(255, 255, 255);
  //y-axis
  arrow(130, 860, 130, 40);
  //x-axis
  arrow(130, 860, 1360, 860);

  //draw ticks on axes
  //horizontal
  line(200, 850, 200, 870); 
  line(400, 850, 400, 870); 
  line(600, 850, 600, 870); 
  line(800, 850, 800, 870); 
  line(1000, 850, 1000, 870); 
  line(1200, 850, 1200, 870); 
  //vertical
  line(110, 663, 130, 663);
  line(110, 466, 130, 466);
  line(110, 269, 130, 269);
  line(110, 72, 130, 72);



  //Label axes
  //vertical
  pushMatrix();
  fill(250, 250, 250);
  translate(30, 630);
  rotate(-HALF_PI);
  text("distance to closest node", 0, 0);
  popMatrix();
  textSize(20);
  text("0.02", 60, 668);
  text("0.04", 60, 471);
  text("0.06", 60, 274);
  text("0.08", 60, 77);

  //horizontal
  textSize(25);
  text("decreasing order of nodes", 600, 940);
  textSize(20);
  text("most diverged", 140, 900);
  text("most converged", 1140, 900);
  step0 = new FloatList();
  step1 = new FloatList();
  step2 = new FloatList();
  step3 = new FloatList();
  step4 = new FloatList();
  step5 = new FloatList();
  step0string = new StringList();
  step1string = new StringList();
  step2string = new StringList();
  step3string = new StringList();
  step4string = new StringList();
  step5string = new StringList();
  //Loop to draw points & lines
  //Loop over every tree
  for (int i=0; i<listofdistances.size(); i++) {
    float previousheight= 0;
    StringList data=listofdistances.get(i);
    //loop over every organism in tree
    for (int number = 0; number <data.size(); number++) {
      String [] splitted = split(data.get(number), ":");
      String organism = splitted[0];
      organism = organism.replaceAll("[^a-zA-Z]", "");
      float distance = Float.parseFloat(splitted[1]);
      //set color based on animal
      if (number ==0) {
        step0.append(distance);
        step0string.append(organism);
      } else {
        if (number==1) {
          step1.append(distance);
          step1string.append(organism);
        } else {
          if (number==2) {
            step2.append(distance);
            step2string.append(organism);
          } else {
            if (number==3) {
              step3.append(distance);
              step3string.append(organism);
            } else {
              if (number==4) {
                step4.append(distance);
                step4string.append(organism);
              } else {
                if (number==5) {
                  step5.append(distance);
                  step5string.append(organism);
                }
              }
            }
          }
        }
      }
      if (organism.contains(siamang)) {
        fill(255, 0, 0);
        stroke(255, 0, 0);
      } else {
        if (organism.contains(orangutan)) {
          fill(0, 255, 0);
          stroke(0, 255, 0);
        } else {
          if (organism.contains(gorilla)) {
            fill(0, 0, 255);
            stroke(0, 0, 255);
          } else {
            if (organism.contains(human)) {
              fill(255, 255, 0);
              stroke(255, 255, 0);
            } else {
              if (organism.contains(chimp)) {
                fill(255, 0, 255);
                stroke(255, 0, 255);
              } else {
                if (organism.contains(bonobo)) {
                  fill(0, 255, 255);
                  stroke(0, 255, 255);
                }
              }
            }
          }
        }
      }
      //draw filled circle per organism
      ellipse((200*number)+200, 900-((distance)*10000), 10, 10);
      //draw connection lines
      if (number !=0) {
        strokeWeight(1);
        line((200*(number-1)+200), previousheight, (200*number)+200, 900-((distance)*10000));
      }
      previousheight = 900-((distance)*10000);
    }
  }

  //display quantities upon mouseover
  x=mouseX;
  y=mouseY;
  //box1: Step1: x = 150 - 250, y = 900-((step1.minimum)*10000) -50 - 900-((step1.maximum)*10000) +5°
  isCovered0 = boxOver(x, y, 0, step0);
  isCovered1 = boxOver(x, y, 1, step1);
  isCovered2 = boxOver(x, y, 2, step2);
  isCovered3 = boxOver(x, y, 3, step3);
  isCovered4 = boxOver(x, y, 4, step4);
  isCovered5 = boxOver(x, y, 5, step5);
  if (isCovered0 == true) {
    countsiamang = countoccurrences(step0string, siamang);
    countgorilla = countoccurrences(step0string, gorilla);
    countbonobo = countoccurrences(step0string, bonobo);
    counthuman = countoccurrences(step0string, human);
    countchimp = countoccurrences(step0string, chimp);
    countorangutan = countoccurrences(step0string, orangutan);
    if (countsiamang != 0) {
      fill(255, 0, 0);
      text(countsiamang, 1265, 105);
    }
    if (countgorilla !=0) {
      fill(0, 0, 255);
      text(countgorilla, 1255, 155);
    }
    if (countbonobo !=0) {
      fill(0, 255, 255);
      text(countbonobo, 1255, 230);
    }
    if (counthuman !=0) {
      fill(255, 255, 0);
      text(counthuman, 1255, 180);
    }
    if (countchimp !=0) {
      fill(255, 0, 255);
      text(countchimp, 1255, 205);
    }
    if (countorangutan !=0) {
      fill(0, 255, 0);
      text(countorangutan, 1265, 130);
    }
    fill(255, 255, 255);
    text("maxdistance:", 1210, 270);
    text(step0.max(), 1340, 270);
    text("mindistance:", 1210, 295);
    text(step0.min(), 1340, 295);
  }
  if (isCovered1 == true) {
    countsiamang = countoccurrences(step1string, siamang);
    countgorilla = countoccurrences(step1string, gorilla);
    countbonobo = countoccurrences(step1string, bonobo);
    counthuman = countoccurrences(step1string, human);
    countchimp = countoccurrences(step1string, chimp);
    countorangutan = countoccurrences(step1string, orangutan);
    if (countsiamang != 0) {
      fill(255, 0, 0);
      text(countsiamang, 1265, 105);
    }
    if (countgorilla !=0) {
      fill(0, 0, 255);
      text(countgorilla, 1255, 155);
    }
    if (countbonobo !=0) {
      fill(0, 255, 255);
      text(countbonobo, 1255, 230);
    }
    if (counthuman !=0) {
      fill(255, 255, 0);
      text(counthuman, 1255, 180);
    }
    if (countchimp !=0) {
      fill(255, 0, 255);
      text(countchimp, 1255, 205);
    }
    if (countorangutan !=0) {
      fill(0, 255, 0);
      text(countorangutan, 1265, 130);
    }
    fill(255, 255, 255);
    text("maxdistance:", 1210, 270);
    text(step1.max(), 1340, 270);
    text("mindistance:", 1210, 295);
    text(step1.min(), 1340, 295);
  }
  if (isCovered2 == true) {
    countsiamang = countoccurrences(step2string, siamang);
    countgorilla = countoccurrences(step2string, gorilla);
    countbonobo = countoccurrences(step2string, bonobo);
    counthuman = countoccurrences(step2string, human);
    countchimp = countoccurrences(step2string, chimp);
    countorangutan = countoccurrences(step2string, orangutan);
    if (countsiamang != 0) {
      fill(255, 0, 0);
      text(countsiamang, 1265, 105);
    }
    if (countgorilla !=0) {
      fill(0, 0, 255);
      text(countgorilla, 1255, 155);
    }
    if (countbonobo !=0) {
      fill(0, 255, 255);
      text(countbonobo, 1255, 230);
    }
    if (counthuman !=0) {
      fill(255, 255, 0);
      text(counthuman, 1255, 180);
    }
    if (countchimp !=0) {
      fill(255, 0, 255);
      text(countchimp, 1255, 205);
    }
    if (countorangutan !=0) {
      fill(0, 255, 0);
      text(countorangutan, 1265, 130);
    }
    fill(255, 255, 255);
    text("maxdistance:", 1210, 270);
    text(step2.max(), 1340, 270);
    text("mindistance:", 1210, 295);
    text(step2.min(), 1340, 295);
  }
  if (isCovered3 == true) {
    countsiamang = countoccurrences(step3string, siamang);
    countgorilla = countoccurrences(step3string, gorilla);
    countbonobo = countoccurrences(step3string, bonobo);
    counthuman = countoccurrences(step3string, human);
    countchimp = countoccurrences(step3string, chimp);
    countorangutan = countoccurrences(step3string, orangutan);
    if (countsiamang != 0) {
      fill(255, 0, 0);
      text(countsiamang, 1265, 105);
    }
    if (countgorilla !=0) {
      fill(0, 0, 255);
      text(countgorilla, 1255, 155);
    }
    if (countbonobo !=0) {
      fill(0, 255, 255);
      text(countbonobo, 1255, 230);
    }
    if (counthuman !=0) {
      fill(255, 255, 0);
      text(counthuman, 1255, 180);
    }
    if (countchimp !=0) {
      fill(255, 0, 255);
      text(countchimp, 1255, 205);
    }
    if (countorangutan !=0) {
      fill(0, 255, 0);
      text(countorangutan, 1265, 130);
    }
    fill(255, 255, 255);
    text("maxdistance:", 1210, 270);
    text(step3.max(), 1340, 270);
    text("mindistance:", 1210, 295);
    text(step3.min(), 1340, 295);
  }
  if (isCovered4 == true) {
    countsiamang = countoccurrences(step4string, siamang);
    countgorilla = countoccurrences(step4string, gorilla);
    countbonobo = countoccurrences(step4string, bonobo);
    counthuman = countoccurrences(step4string, human);
    countchimp = countoccurrences(step4string, chimp);
    countorangutan = countoccurrences(step4string, orangutan);
    if (countsiamang != 0) {
      fill(255, 0, 0);
      text(countsiamang, 1265, 105);
    }
    if (countgorilla !=0) {
      fill(0, 0, 255);
      text(countgorilla, 1255, 155);
    }
    if (countbonobo !=0) {
      fill(0, 255, 255);
      text(countbonobo, 1255, 230);
    }
    if (counthuman !=0) {
      fill(255, 255, 0);
      text(counthuman, 1255, 180);
    }
    if (countchimp !=0) {
      fill(255, 0, 255);
      text(countchimp, 1255, 205);
    }
    if (countorangutan !=0) {
      fill(0, 255, 0);
      text(countorangutan, 1265, 130);
    }
    fill(255, 255, 255);
    text("maxdistance:", 1210, 270);
    text(step4.max(), 1340, 270);
    text("mindistance:", 1210, 295);
    text(step4.min(), 1340, 295);
  }
  if (isCovered5 == true) {
    countsiamang = countoccurrences(step5string, siamang);
    countgorilla = countoccurrences(step5string, gorilla);
    countbonobo = countoccurrences(step5string, bonobo);
    counthuman = countoccurrences(step5string, human);
    countchimp = countoccurrences(step5string, chimp);
    countorangutan = countoccurrences(step5string, orangutan);
    if (countsiamang != 0) {
      fill(255, 0, 0);
      text(countsiamang, 1265, 105);
    }
    if (countgorilla !=0) {
      fill(0, 0, 255);
      text(countgorilla, 1255, 155);
    }
    if (countbonobo !=0) {
      fill(0, 255, 255);
      text(countbonobo, 1255, 230);
    }
    if (counthuman !=0) {
      fill(255, 255, 0);
      text(counthuman, 1255, 180);
    }
    if (countchimp !=0) {
      fill(255, 0, 255);
      text(countchimp, 1255, 205);
    }
    if (countorangutan !=0) {
      fill(0, 255, 0);
      text(countorangutan, 1265, 130);
    }
    fill(255, 255, 255);
    text("maxdistance:", 1210, 270);
    text(step5.max(), 1340, 270);
    text("mindistance:", 1210, 295);
    text(step5.min(), 1340, 295);
  }
}

//boxOver(int xPos, int yPos, int number, FloatList stepx )
//function to draw arrow
void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
} 

//function to find minimum of a FloatList
float minimumfloat (FloatList x1) {
  minimumfloat = 99999;
  for (int k = 0; k<x1.size(); k++) {
    currentfloat = x1.get(k);
    if (currentfloat < minimumfloat) {
      minimumfloat = currentfloat;
    }
  }
  return minimumfloat;
}

float maximumfloat (FloatList x1) {
  maximumfloat = 0;
  for (int k = 0; k<x1.size(); k++) {
    currentfloat = x1.get(k);
    if (currentfloat > maximumfloat) {
      maximumfloat = currentfloat;
    }
  }
  return maximumfloat;
}

int countoccurrences (StringList x1, String x2) {
  currentstring="";
  occurrences =0;
  for (int k = 0; k<x1.size(); k++) {
    currentstring = x1.get(k);
    if (currentstring.contains(x2)) {
      occurrences = occurrences +1;
    }
  }
  return occurrences;
}

boolean boxOver(int xPos, int yPos, int number, FloatList stepx ) {//int xBox, int yBox, int h, int w) {
  if  (xPos > ((number*200)+200)-50 && xPos < ((number*200)+200)+ 50 && yPos > (900-((stepx.max())*10000))-50 && yPos < (900-((stepx.min())*10000))+50) {
    isCovered = true;
  } else {
    isCovered = false;
  }
  return isCovered;
}