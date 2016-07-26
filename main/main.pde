/*Cute little shit main program
----------------------------------------
Generally, this program
----------------------------------------
i'd want to send data all the time to the 
arduino for running like constantly changing
the analog stivk value when it also always 
has an x and y position or at the neutral position

can i do this better by adding a second argument?
would it benefit or make things complicated for low
reward?
original format:
	*int|int|int#
	*cmd|pin|val#
if i simply add two more arguments for pin num and 
val for a second motor. would i compromise stability?
what if i encode two value into one and the algorithm 
is only enaged in the motor driving block?
my goal is to transmit as little data as possible

what if the transmission is #motorDrive|powLev|diff#
where motordrive is the motor driving command. powLev 
is the general power level. so 255 would be full 
forward and -255 is full reverse. then diff would be a
differential to apply. so spinning right would be 
255|255#. spinning left would be 255|-255# assuming 
that the  parseInt function can handle the negative 
sign. if not, we can just do 0 - 255 and see how that 
resolution works. 

this is nice because its the same amount of data 
transmitted, but assumes the motor pins stay the same, 
or at least dont need to be addressed directly. Instead,
the system just takes a value and a difference to apply,
which makes the data transmitted cover two aanalog drive 
values.
*/

#define START_CMD_CHAR '*'
#define END_CMD_CHAR '#'
#define DIV_CMD_CHAR '|'

#define CMD_MOTOR 9
#define CMD_DIGITALWRITE 10
#define CMD_ANALOGWRITE 11
#define CMD_WAGTAIL 12
#define CMD_HONK 12
#define CMD_HONKTONE 13

#define MAX_ANALOGWRITE 255

#define PIN_HIGH 3
#define PIN_LOW 2


void setup() {
  Serial.being(9600);
  Serial.println("Starting up program...");
  Serial.flush();
}

void loop() {
  //read until the serial port is empty
  Serial.flush();
  int ard_command = 0;
  int pin_num = 0;
  int pin_value = 0;
  char get_char = ' ';

  //if no chars available, restart loop
  if(Serial.available() < 1) return;

  get_char = Serial.read();
  //if the start char isn't seen, restart loop
  if(get_char != START_CMD_CHAR) return;

  //parse arguments from serial line
  ard_command = Serial.parseInt();
  pin_num = Serial.parseInt();
  pin_value= Serial.parseInt();
  Serial.println("command received! what was seen...");
  Serial.println(START_CMD_CHAR + ard_command + DIV_CMD_CHAR + pin_num + DIV_CMD_CHAR + pin_value + END_CMD_CHAR + \n);

  //-------command seen and parsed, handle command routines below-------


  // GET digitalWrite DATA FROM bluetooth
  if (ard_command == CMD_DIGITALWRITE){
    if (pin_value == PIN_LOW) pin_value = LOW;
    else if (pin_value == PIN_HIGH) pin_value = HIGH;
    else return; // error in pin value. return.
    // pinMode(pin_num, OUTPUT);
    // digitalWrite(pin_num, pin_value);
    set_digitalwrite( pin_num,  pin_value);  // Uncomment this function if you wish to use
    return;  // return from start of loop()
  }

  // SET analogWrite DATA FROM bluetooth
  //if (ard_command == CMD_ANALOGWRITE) {
  //  analogWrite(  pin_num, pin_value );
  //  // add your code here
  //  return;  // Done. return to loop();
  //}
  
  // handle bluetooth motor drive command.
  //motor drive range 0 - 255
  //motor diff range -255 - 255
  if (ard_command == CMD_MOTOR) {
    driveMotor(RIGHT,val);
    driveMotor(LEFT,val - diff);//correct 
    	//this. this will end up outside of the 
    	//pwm resolution range
    
    return;  // Done. return to loop();
  }

  if(ard_command == CMD_HONK){}
  if(ard_command == CMD_HONKTONE){}
  if(ard_command == CMD_WAGTAIL){}
}



// 2a) select the requested pin# for DigitalWrite action
void set_digitalwrite(int pin_num, int pin_value){
  switch (pin_num) {
  case 13:
    pinMode(13, OUTPUT);
    digitalWrite(13, pin_value);
    // add your code here
    break;
  case 12:
    pinMode(12, OUTPUT);
    digitalWrite(12, pin_value);
    // add your code here
    break;
  case 11:
    pinMode(11, OUTPUT);
    digitalWrite(11, pin_value);
    // add your code here
    break;
  case 10:
    pinMode(10, OUTPUT);
    digitalWrite(10, pin_value);
    // add your code here
    break;
  case 9:
    pinMode(9, OUTPUT);
    digitalWrite(9, pin_value);
    // add your code here
    break;
  case 8:
    pinMode(8, OUTPUT);
    digitalWrite(8, pin_value);
    // add your code here
    break;
  case 7:
    pinMode(7, OUTPUT);
    digitalWrite(7, pin_value);
    // add your code here
    break;
  case 6:
    pinMode(6, OUTPUT);
    digitalWrite(6, pin_value);
    // add your code here
    break;
  case 5:
    pinMode(5, OUTPUT);
    digitalWrite(5, pin_value);
    // add your code here
    break;
  case 4:
    pinMode(4, OUTPUT);
    digitalWrite(4, pin_value);
    // add your code here
    break;
  case 3:
    pinMode(3, OUTPUT);
    digitalWrite(3, pin_value);
    // add your code here
    break;
  case 2:
    pinMode(2, OUTPUT);
    digitalWrite(2, pin_value);
    // add your code here
    break;
    // default:
    // if nothing else matches, do the default
    // default is optional
  }
}


void honk(){
  //do honking stuff
}
