import processing.pdf.*;
JSONArray values;
//PVector[] dance = {};
ArrayList<PVector> dance = new ArrayList<PVector>();
boolean saveOneFrame = false;
int cx = 70;
int cy = 70;
int r = 200;
int frameNumber;
String myFrame; 
void setup() { 
  size(900, 900);
  //noSmooth();
  //stroke(255, 255, 0); // Pollen 
  noStroke();
  fill(random(0, 255), 0, 0, 50);
  frameRate(1);
  int frameNumber = int(random(0, 1000));
  myFrame = "random"+frameNumber+". png"; 
  beginRecord(PDF, myFrame); 
  doItToIt();
  endRecord();
  save(myFrame);
}
void draw() {
}
void doItToIt() { 
  //background(#00ffce);
  //background(#ff00f3);
  background(0);
  loadMovement();
  for (int i = 0; i < dance.size(); i++) {
    //stroke(255, 255, 0); 
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(i));
    int x = int(map(dance.get(i).x, -1, 1, 0, 30));
    int y = int(map(dance.get(i).y, -1, 1, 0, 30));
    int z = int(map(dance.get(i).z, -1, 1, 0, 30));
    int xP = (int)(cx+r*cos(i));
    int yP = (int)(cy+r*sin(i));
    //ellipse(xP, yP, x, x);
    ellipse(xP, yP, z, z);
    // ellipse(xP, yP, y, y);
    //fill(#ff00f3, random(50, 100));
    //fill(#fff800, random(50, 100));
    if (i%2 == 0) {
      noFill();
      stroke(#00ffce);
    }  
    if (i%5==0) {
      noStroke();
      fill(#fff800);
    }
    if (i%3 == 0) {
      noStroke();
      fill(#ff00f3);
    }

    if ((z > x) && (z > y)) { 
      //fill(0, 0);
      //ellipse(xP, yP, z, z);
    }
    if ((x > z) && (x > y)) { 
      //fill(255, 0, 0,10);
      //ellipse(xP, yP, x, x);
    }
    if ((y > z) && (y > x)) { 
      //fill(255, 0, 255);
      //ellipse(xP, yP, y, y);
    }
    //bezier(0, 0, x, y,z, y, height, height);
    popMatrix();
  }
}

void loadMovement() { 
  values = loadJSONArray("flip.json");
  for (int i = 0; i < values.size(); i++) {
    JSONObject animal = values.getJSONObject(i); 
    String movements = animal.getString("message");
    //println(movements);
    parseString(movements, i);
  }
}

void parseString(String arrayValue, int counter) { 
  String[] list = split(arrayValue, ':');
  dance.add(new PVector(float(list[1]), float(list[2]), float(list[3])));
  //nt total = dance.size();
  //println("The total number of particles is: " + total);
  //print(dance.get(counter));
}