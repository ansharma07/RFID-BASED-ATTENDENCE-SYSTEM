# Arduino Code
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
28
return;
}
// Select one of the cards
if ( ! mfrc522.PICC_ReadCardSerial())
{
return;
}
//Show UID on serial monitor
 
String content= "";
byte letter;
for (byte i = 0; i < mfrc522.uid.size; i++)
{
content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
content.concat(String(mfrc522.uid.uidByte[i], HEX));
}
Serial.println();
Serial.print("Message : ");
content.toUpperCase();
if (content.substring(1) == "60 4E 07 1E" ) //change here the UID of the card/cards that you 
want to give access
{
Serial.println("1");
ser.write(1);
Serial.println();
 
delay(3000);
}
if (content.substring(1) == "69 A9 81 5A" ) //change here the UID of the card/cards that 
you want to give access
{
Serial.println("2");
ser.write(2);
29
Serial.println();
 
delay(3000);
}
}