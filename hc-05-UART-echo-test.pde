//Quirk about needing to press the button for full functionality is notated here - http://electronics.stackexchange.com/questions/101572/hc-05-bluetooth-module-not-responding-to-certain-commands

// Basic bluetooth test sketch. HC-0x_FC-114_01_9600
//  Uses hardware serial to talk to the host computer and software serial for communication with the bluetooth module
//
//  Pins
//  BT VCC to Arduino 5V out. 
//  BT GND to GND
//  Arduino D3 to BT RX through a voltage divider
//  Arduino D2 BT TX (no need voltage divider)
//
//  When a command is entered in the serial monitor on the computer 
//  the Arduino will relay it to the bluetooth module and display the result.
//
// The HC-0x FC-114 modules require CR and NL

#include <SoftwareSerial.h>
SoftwareSerial BTSerial(2, 3); // RX | TX


char c = ' ';
boolean NL = true;
long btSpeed = 38400;   //for some reason serial print in the setup reports a negative value if this is an int
void setup() 
{
      Serial.begin(9600);
      Serial.println("Sketch HC-0x_FC-114_01_9600");
      Serial.println("Arduino with HC-0x FC-114 is ready");
      Serial.println("Make sure Both NL & CR are set");
      Serial.println("");
      
      // FC-114 default baud rate is 9600
      BTSerial.begin(btSpeed);  
      Serial.println("BTserial started at );
      Serial.println(btSpeed);
      
}

void loop()
{

    // Read from the Bluetooth module and send to the Arduino Serial Monitor
    if (BTSerial.available())
    {
        c = BTSerial.read();
        Serial.write(c);
    }
    
      
  
    // Read from the Serial Monitor and send to the Bluetooth module
    if (Serial.available())
    {
        c = Serial.read();
        BTSerial.write(c);   
        
        // Echo the user input to the main window. The ">" character indicates the user entered text.
        if (NL) { Serial.print(">");  NL = false; }
        Serial.write(c);
        if (c==10) { NL = true; }
    }

}

/*
Another supposed way to just setup a debug operation just echoing 
the UART serial line from the desktop to the bluetooth module, 
and echoing the BT board back to the desktop

SoftwareSerial BluetoothSerial(10, 11);

void setup(void)
{
Serial.begin(38400);

BluetoothSerial.begin(38400); // The AT mode runs at 38400

Serial.println("Ready.");
}

void loop(void)
{
while(BluetoothSerial.available())
Serial.write(BluetoothSerial.read());
while(Serial.available())
BluetoothSerial.write(Serial.read());
}
*/




/*This is just the example output from the bluetooth module when testing
Sketch HC-0x_FC-114_01_9600
Arduino with HC-0x FC-114 is ready
Make sure Both NL & CR are set

BTserial started at 9600

>AT
OK
>AT
OK
>AT+VERSION
+VERSION:hc01.comV2.1
OK
*/
