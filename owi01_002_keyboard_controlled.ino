int led = 13;

int m_delay = 500;

int m1_1  = 2;
int m1_2  = 3;

int m2_1  = 4;
int m2_2  = 5;

int m3_1  = 6;
int m3_2  = 7;

int m4_1  = 8;
int m4_2  = 9;

int m5_1  = 10;
int m5_2  = 11;

int incomingByte;


void setup() {                
  pinMode(led, OUTPUT);     
  
  pinMode(m1_1, OUTPUT);
  pinMode(m1_2, OUTPUT);
  pinMode(m2_1, OUTPUT);
  pinMode(m2_2, OUTPUT);
  pinMode(m3_1, OUTPUT);
  pinMode(m3_2, OUTPUT);
  pinMode(m4_1, OUTPUT);
  pinMode(m4_2, OUTPUT);
  pinMode(m5_1, OUTPUT);
  pinMode(m5_2, OUTPUT);
  
  // start sending data at 9600 baud rate
  Serial.begin(9600);
  
}

// the loop routine runs over and over again forever:
void loop() {
 
 if (Serial.available() > 0) {
    incomingByte = Serial.read();
    if (incomingByte == 'Q') {    
      digitalWrite(m5_2, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m5_1, HIGH);   // turn the LED on (HIGH is the voltage level)
    }
    if (incomingByte == 'W') {
      digitalWrite(m5_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m5_2, HIGH);   // turn the LED on (HIGH is the voltage level)
    }
    if (incomingByte == 'I') {
      digitalWrite(m4_2, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m4_1, HIGH);   // turn the LED on (HIGH is the voltage level)    
    }
    if (incomingByte == 'J') {
      digitalWrite(m4_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m4_2, HIGH);   // turn the LED on (HIGH is the voltage level)    
    }
    if (incomingByte == 'O') {
      digitalWrite(m3_2, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m3_1, HIGH);   // turn the LED on (HIGH is the voltage level)    
    }
    if (incomingByte == 'K') {
      digitalWrite(m3_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m3_2, HIGH);   // turn the LED on (HIGH is the voltage level)    
    }
    if (incomingByte == 'P') {
      digitalWrite(m2_2, LOW);    // turn the LED off by making the voltage LOWX`
      digitalWrite(m2_1, HIGH);   // turn the LED on (HIGH is the voltage level)        
    }
    if (incomingByte == 'L') {
      digitalWrite(m2_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m2_2, HIGH);   // turn the LED on (HIGH is the voltage level)    
    }
    if (incomingByte == 'A') {
      digitalWrite(m1_2, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m1_1, HIGH);   // turn the LED on (HIGH is the voltage level)    
    }
    if (incomingByte == 'S') {  
      digitalWrite(m1_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m1_2, HIGH);   // turn the LED on (HIGH is the voltage level)    
    }
    
    if (incomingByte == 'R') {  
      digitalWrite(m1_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m1_2, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m2_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m2_2, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m3_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m3_2, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m4_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m4_2, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m5_1, LOW);    // turn the LED off by making the voltage LOW
      digitalWrite(m5_2, LOW);    // turn the LED off by making the voltage LOW
    }
  }  
}
