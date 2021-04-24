/* Simple example code for Force Sensitive Resistor (FSR) with Arduino. More info: https://www.makerguides.com */

// Define FSR pin:
#define fsrpin1 13
#define fsrpin2 35
#define fsrpin3 15
int outPorts[] = {14, 27, 26, 25};



//Define variable to store sensor readings:
int fsrreading1; //Variable to store FSR value
int fsrreading2; //Variable to store FSR value
int fsrreading3;


void setup() {
  // Begin serial communication at a baud rate of 9600:
  Serial.begin(9600);
  for (int i = 0; i < 4; i++) {
  pinMode(outPorts[i], OUTPUT);
  }
}

void loop() {

  // Reads the FSR pin and store the output as fsrreading:
  fsrreading1 = analogRead(fsrpin1);
  fsrreading2 = analogRead(fsrpin2);
  fsrreading3 = analogRead(fsrpin3);
  

  // Print the fsrreading in the serial monitor:
  // Print the string "Analog reading = ".
//  Serial.print("Analog reading = ");
//  // Print the fsrreading:
//  Serial.print(fsrreading);
    int mappedValue1 = map(fsrreading1, 0, 4095, 0, 400);
    int mappedValue2 = map(fsrreading2, 0, 4095, 0, 400);
    int mappedValue3 = map(fsrreading3, 0, 4095, 0, 400);
    String values = String(mappedValue1) + "," + String(mappedValue2) + "," + String(mappedValue3) + "\n";
    Serial.print(values);
    moveAngle(true,20,3);
    moveAngle(false,20,3);

//    moveAround(true,100,3);
    
     

    delay(500); //Delay 500 ms.
}


//Suggestion: the motor turns precisely when the ms range is between 3 and 20
void moveSteps(bool dir, int steps, byte ms) {
for (unsigned long i = 0; i < steps; i++) {
moveOneStep(dir); // Rotate a step
delay(constrain(ms,3,20)); // Control the speed
}
}

void moveAround(bool dir, int turns, byte ms){
  for(int i=0;i<turns;i++)
    moveSteps(dir,32*64,ms);
}


void moveOneStep(bool dir) {
// Define a variable, use four low bit to indicate the state of port
static byte out = 0x01;
// Decide the shift direction according to the rotation direction
if (dir) { // ring shift left
  out != 0x08 ? out = out << 1 : out = 0x01;
} else { // ring shift right
  out != 0x01 ? out = out >> 1 : out = 0x08;
}
// Output singal to each port
  for (int i = 0; i < 4; i++) {
    digitalWrite(outPorts[i], (out & (0x01 << i)) ? HIGH : LOW);
  }
}

void moveAngle(bool dir, int angle, byte ms){
  moveSteps(dir,(angle*32*64/360),ms);
}
