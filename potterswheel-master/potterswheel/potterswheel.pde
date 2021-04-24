//.obj export realised with:
//https://github.com/nervoussystem/OBJExport
import nervoussystem.obj.*;
import processing.serial.*;
//import iadt.creative.Inputs;



Serial myPort;  
boolean record = false;
PShape shapeGroup;
PVector v;
PVector[] vertices;
float z;
int maxvertices;
int steps = 36; //this defines your outer shape
int vertexCount = 0;
boolean offsetTrue = true;
float zDrehung = 0;
float yDrehung = 0;
float scale = 0.1;
String val;  
int counter = 0;
String xVal1;
String xVal2;
String xVal3;
int mainRadius = 200;

void setup() {
  
  //int numSides = Inputs.readInt("How many sides will your default shape have? (Must be greater than or equal to 3)");
  //steps = numSides;
  size(1200, 1200, P3D);
  noStroke();
  frameRate(23);
  maxvertices = (3600*height) + 1;
  vertices = new PVector[maxvertices];
  //shapeGroup = createShape(GROUP);
  //camera();
  createSlice();
  fill(255);
  String portName = Serial.list()[8];
  System.out.println(portName);
  myPort = new Serial(this, portName, 9600);
  

}

boolean isNumeric(String string) {
    int intValue;
    
    
    
    if(string == null || string.equals("")) {
        System.out.println("String cannot be parsed, it is null or empty.");
        return false;
    }
    
    try {
        intValue = Integer.parseInt(string);
        return true;
    } catch (NumberFormatException e) {
        System.out.println("Input String cannot be parsed to Integer.");
    }
    return false;
}



void createSlice() {
  
  String radiusStr = "200";
  
    float radius;
   if (isNumeric(radiusStr)) {
     radius = Float.parseFloat(radiusStr);
   } else {
     radius = 400;
     
     
   }
  
  
  
  //versetze punkte immer abwechselnd 
  float offset = (360/steps)/2;
  offset = offsetTrue ? offset : -offset;
  offsetTrue = !offsetTrue;
  
  //berechne Punkte in Kreis
  for (int i=0; i<=steps; i++) {
      
    //calculate angle
    //if circle not very round steps might be smaller, need to calculate distance
    float angle = radians((i * (360/steps)) + offset);
    PVector v = new PVector(0  + (cos(angle) * (radius)), 
    0 + (sin(angle) * (radius)), 
    z);
    vertices[vertexCount++] = v;
  }
  
  
}

void createSlice(float z, int grow) {
  
  
  
  System.out.println(grow);
  
  
  if (grow == 1) {
    mainRadius += 20;
  } else if (grow == -1) {
    mainRadius -= 20; 
  }
  
  
  
  
  System.out.println(mainRadius);
  
  System.out.println("\n\n\n");
  //versetze punkte immer abwechselnd 
  float offset = (360/steps)/2;
  offset = offsetTrue ? offset : -offset;
  offsetTrue = !offsetTrue;
  
  //berechne Punkte in Kreis
  for (int i=0; i<=steps; i++) {
      
    //calculate angle
    //if circle not very round steps might be smaller, need to calculate distance
    float angle = radians((i * (360/steps)) + offset);
    PVector v = new PVector(0  + (cos(angle) * (mainRadius)), 
    0 + (sin(angle) * (mainRadius)), 
    z);
    vertices[vertexCount++] = v;
  }
  
  
}


void draw() {
  String[] inputs = new String[2];
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');
    if (val == null) {
      
    } else {
      inputs  = split(val,',');
      xVal1 = inputs[0];
      xVal2 = inputs[1];
      xVal3 = inputs[2];
      xVal1 = trim(xVal1);
      xVal2 = trim(xVal2);
      xVal3 = trim(xVal3);
      
    }
    
    
  
  }
  
  
  background(255);
  
  int grow = 0;
  
  
  if (isNumeric(xVal1) && isNumeric(xVal2) && isNumeric(xVal3)) {
    if ((Integer.parseInt(xVal1) > Integer.parseInt(xVal2))   || (Integer.parseInt(xVal3) > Integer.parseInt(xVal2))) {
        grow = 1;
    } else if ((Integer.parseInt(xVal1) < Integer.parseInt(xVal2))  ||    (Integer.parseInt(xVal1) < Integer.parseInt(xVal3))) {
        grow = -1;
      
    } else {
        grow = 0;
      
    }
    
  }
  //print(vertexCount + "\n");
  if (vertexCount < maxvertices-steps-1) {
    z=z+15;
    int tmpRadius = mouseX*4;
    
    //System.out.println("tmp: " + tmpRadius);
    
    //System.out.println("xVal1: " + val);
    
    //createSlice(z, mouseX*4);
    createSlice(z, grow);


    PShape currentShape;
    currentShape = createShape();
    currentShape.beginShape(TRIANGLE_STRIP);

    for (int i=0; i < vertexCount-steps-1; i=i+2) {
        currentShape.vertex( vertices[i].x,  vertices[i].y,  vertices[i].z);
        currentShape.vertex( vertices[i+steps-1].x, vertices[i+steps-1].y,  vertices[i+steps-1].z);
        currentShape.vertex( vertices[i+1].x,  vertices[i+1].y,  vertices[i+1].z);
        currentShape.vertex( vertices[i+steps].x,  vertices[i+steps].y,  vertices[i+steps].z);
    }
    currentShape.endShape(CLOSE);
    
    lights();

    if (record){
      beginRaw("nervoussystem.obj.OBJExport", "~/Desktop/bla.obj"); 
    }
    
    translate(width/2, height/1.2, 0);
    rotateX(radians(95));
    //rotateX(map(mouseY,0,height, 95, 93));
    scale(scale);
    rotateZ(zDrehung=zDrehung+0.02);
   
    shape(currentShape, 0, 0);
    endRaw();
    record = false;

    //shapeGroup.addChild(currentShape);
  }
}

void keyPressed() {
  // Use a key press so that it doesn't make a million files
  if (key == 'r') {
    record = true;
  }
}
  
  void mousePressed(){
   
  }
  
  void mouseDragged(){
    //if (pmouseX < mouseX){
    //  scale = scale + 0.003;
    //} else {
    //  scale = scale - 0.003;
    //}

  }
