/* 
   Processing sketch that send a ascii byte character to Arduino which
   then subsquentally controls a motor   

Linux :

Logitech Logitech Attack 3( 2 ) has:
 3 sliders
 11 buttons
   Buttons (11)
    Type     Name               Multiplier
    button    Trigger             -
    button    Thumb               -
    button    Thumb 2             -
    button    Top                 -
    button    Top 2               -
    button    Pinkie              -
    button    Base                -
    button    Base 2              -
    button    Base 3              -
    button    Base 4              -
    button    Base 5              -

   Sliders (3)
    Type     Name               Multiplier     Tolerance
    slider    x                   1.0            0.0            absolute
    slider    y                   1.0            0.0            absolute
    slider    z                   1.0            0.0            absolute
   the ascii key is controlled by joystick.
 
*/
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

import processing.serial.*;
import java.io.*;

ControlIO controll;
ControlSlider sliderX;
ControlSlider sliderY;
ControlButton button;
ControlDevice device;
ControlButton b10, b11, b2, b3, b4, b5, b1;

float xpos; 
float ypos; 
float multiplier = 1;
int hotWire = 0;
// instance of the serial class
Serial port;
// set the font
PFont myFont;
 
void setup()  {
  // screen size of the program
  size(180, 460);  
  // List all the available serial ports in the output pane. 
  // You will need to choose the port that the Arduino board is 
  // connected to from this list. The first port in the list is 
  // port #0 and the third port in the list is port #2. 
  println(Serial.list()); 
  // set the font to use
  myFont = createFont("verdana", 12);
  textFont(myFont);
  // Open the port that the Arduino board is connected to (in this case #0) 
  // Make sure to open the port at the same speed Arduino is using (9600bps)
  port = new Serial(this, Serial.list()[0], 9600);  
 
 controll = ControlIO.getInstance(this);
  for (int i = 0; i < controll.getNumberOfDevices(); i++) {
    ControlDevice device = controll.getDevice(i);    
      println(device.getName()+"( "+i+" ) has:");
      println(" " + device.getNumberOfSliders() + " sliders");
      println(" " + device.getNumberOfButtons() + " buttons");
  }
  device = controll.getDevice("Logitech Logitech Attack 3");
  sliderX = device.getSlider("x");//left to right = -1 +1 => base motor
  sliderY = device.getSlider("y");//front to back = -1 +1 => elbow motor
  b10 = device.getButton("Base 4"); //shoulder motor up
  b11 = device.getButton("Base 5"); //shoulder motor down
  b1 = device.getButton("Trigger");//reset - trigger button
  b2 = device.getButton("Thumb");//wrist motor dpwn
  b3 = device.getButton("Thumb 2");//whrist motor up
  b4 = device.getButton("Top");//grip motor open
  b5 = device.getButton("Top 2");//grip close  
}
 
void draw() 
{ 
  background(0);
  noStroke();
  fill(150);
  // draw each box/ button with a label above each    
  text("Q : Base Motor Left", 5, 5, 200, 75);
  text("W : Base Motor Right", 5, 50, 200, 75); 
  text("J : Shoulder Motor UP", 5, 95, 200, 75);
  text("I : Shoulder Motor DOWN", 5, 140, 200, 75);
  text("O : Elbow Motor UP", 5, 185, 200, 75);
  text("K : Elbow Motor DOWN", 5, 230, 200, 75);
  text("L : Wrist Motor UP", 5, 275, 200, 75);
  text("P : Wrist Motor DOWN", 5, 320, 200, 75);    
  text("A : Hand Motor CLOSE", 5, 365, 200, 75);
  text("S : Hand Motor OPEN", 5, 410, 200, 75);
 
  // start looking to see whats pressed and send a value
  // over the serial portq
  if(keyPressed) {
    if (key == 'q' || key == 'Q') {
      port.write('Q');
    }
    if (key == 'w' || key == 'W') {
      port.write('W');
    }
    if (key == 'a' || key == 'A') {
      port.write('A');
    }
    if (key == 's' || key == 'S') {
      port.write('S');
    }
    if (key == 'i' || key == 'I') {
      port.write('I');
    }
    if (key == 'j' || key == 'J') {
      port.write('J');
    }
    if (key == 'o' || key == 'O') {
      port.write('O');
    }
    if (key == 'k' || key == 'K') {
      port.write('K');
    }
    if (key == 'p' || key == 'P') {
      port.write('P');
    }
    if (key == 'l' || key == 'L') {
      port.write('L');
    }  
    if (key == 'r' || key == 'R') {
      port.write('R');
    }
    
  }
  xpos = sliderX.getValue();
  ypos = sliderY.getValue(); 
  
  println(xpos+":"+ypos);
  
  if (b1.pressed()) {
    println("bo reset");
    port.write('R');
    hotWire = 0;
  }
  
  if(xpos > -0.5 && xpos < 0.5 && ypos > -0.5 && ypos < 0.5 && !b10.pressed() && !b11.pressed() && !b2.pressed() && !b3.pressed() && !b4.pressed() && !b5.pressed() && hotWire == 1){
    //reset    
    println(xpos+"reset"+ypos);
    port.write('R');
    hotWire = 0;
 } 
 else{
   
    // joystic processing
   if(xpos < -0.5){
      //move base left = Q
      println(xpos+"<"+ypos);
      port.write('Q');
      hotWire = 1;
    }  
    if(xpos > 0.5){
      //move base right = W
      println(xpos+">"+ypos);
      port.write('W');
      hotWire = 1;
    }
    if(ypos < -0.5){
      //move elbow down = K
      println(xpos+"V"+ypos);
      port.write('K');
      hotWire = 1;
    }
    if(ypos > 0.5){
      //move elbow up = O
      println(xpos+"^"+ypos);
      port.write('O');
      hotWire = 1;
    }     
    
    if (b10.pressed()) {
      //move sholder up = J
      println("b10");
      port.write('J');
      hotWire = 1;
    }  
    
    if (b11.pressed()) {
      println("b11");
      //move sholder down = I 
      port.write('I');
      hotWire = 1;
    }
    
    if (b2.pressed()) {
      println("b2");
      //move wrist up = L
      port.write('L');
      hotWire = 1;
    }  
    
    if (b3.pressed()) {
      println("b3");
      //move wrist down = P 
      port.write('P');
      hotWire = 1;
    }
    
    if (b4.pressed()) {
      println("b4");
      //grip open = S
      port.write('S');
      hotWire = 1;
    }  
    
    if (b5.pressed()) {
      println("b5");
      //grip close = A
      port.write('A');
      hotWire = 1;
    }
  }
}
void keyReleased() {
  println("keyrelsease");
  port.write('R');
}