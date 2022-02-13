#Programming for the interfacing of RFID with the Arduino
#include <SPI.h>
#include <MFRC522.h>
#include "SoftwareSerial.h"
#define SS_PIN 10
#define RST_PIN 9
MFRC522 mfrc522(SS_PIN, RST_PIN); // Create MFRC522 instance.
SoftwareSerial ser(2,3); // RX, TX 
void setup() 
{
 Serial.begin(9600); // Initiate a serial communication
 ser.begin (115200);
 SPI.begin(); // Initiate SPI bus
 mfrc522.PCD_Init(); // Initiate MFRC522
 Serial.println("Approximate your card to the reader...");
 Serial.println();
}
void loop() 
{
 // Look for new cards
 if ( ! mfrc522.PICC_IsNewCardPresent()) 
 {
 return;
 }
 // Select one of the cards
 if ( ! mfrc522.PICC_ReadCardSerial()) 
 {
 return;
 }
 //Show UID on serial monitor
 String content= "";
24
 byte letter;
 for (byte i = 0; i < mfrc522.uid.size; i++) 
 {
 content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
 content.concat(String(mfrc522.uid.uidByte[i], HEX));
 }
 Serial.println();
 Serial.print("access granted: ");
 content.toUpperCase();
 if (content.substring(1) == "7C DD 0C 49" ) 
 Serial.println("STUDENT 1");
 ser.write(1);
 Serial.println();
 
 delay(3000);
 }
 if (content.substring(1) == "C3 91 1C 15" 
 Serial.println("STUDENT 2");
 ser.write(2);
 Serial.println();
 delay(3000);
 }
}
