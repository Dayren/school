/*
 *  author : namigyj  (2017)
 *  contact : < namigyj -at- protonmail.com >
 *
 */

#include <Process.h>
#include <Keyboard.h>


Process p;
char inData[100];   // output of cmd
char inChar = -1;   // char buffer
byte index = 0;

void setup() {
  pinMode(13, INPUT);
  pinMode(2, OUTPUT);
  digitalWrite(2, HIGH);

  SerialUSB.begin(9600);
  //  // debug: wait until a sMonitor is connected
  //  while (!SerialUSB) {
  //    digitalWrite(2, HIGH);
  //    delay(500);
  //    digitalWrite(2, LOW);
  //    delay(500);
  //  }

  SerialUSB.print("Starting Bridge... ");
  Bridge.begin();
  SerialUSB.println("OK!");
  SerialUSB.print("Starting Keyboard... ");
  Keyboard.begin();
  SerialUSB.println("OK!");

  digitalWrite(2, LOW);
}

void loop() {
  SerialUSB.print("starting command... ");
  listencmd();  // listen to port
  SerialUSB.println("OK!\nwaiting for datagram... ");
  wait();       // wait for it to finish
                // is this useless in sync ?
  SerialUSB.println("OK!\nreading output... ");
  ctos();       // command output to string
  SerialUSB.println("OK!\nforward it to keyboard");
  stok();       // output string to keyboard inputs
}

void listencmd() {
  // setup the command
  p.begin("python");
  p.addParameter("/usr/bin/udpreadprint.py");
  // run in synchronous
  p.runAsynchronously();
}

void wait() {
  // wait for it to finnish
  while (p.running()) {
    SerialUSB.println("waiting... ");
    delay(500);
    if(digitalRead(13)==LOW){
      changeWifi();
    }
  }
}

void ctos() {
  index = 0;
  while (p.available()) {
    if (index < 99) {
      inChar = p.read();
      if (inChar == '\n') {
        inData[index] = '\0'; // Null terminates the string
      }
      inData[index] = inChar;
      index++;
    }
  }
  char str[50];
  int num1;
  SerialUSB.println(inData);
  sscanf(inData, "%d:%[^.].", &num1, str);
  SerialUSB.println(num1);
  SerialUSB.println(str);
}

void stok() {
  char keys[50];
  int key1, key2, key3;
  int num = -1;
  int d;
  // get the data code
  sscanf(inData, "%d:%[^.].", &num, keys);


  if (num == 0) {       // print out a string
    Keyboard.print(keys);
  }
  else if (num == 1) {  // press a key
    sscanf(keys, "%d.", &key1);
    if (key1 < 256) {
      Keyboard.press(key1);
      delay(100);
      Keyboard.releaseAll();
    }
  }
  else if ( num == 2) { // press 2 keys
    sscanf(keys, "%d,%d.", &key1, &key2);
    if (key1 < 256 && key2 < 256) {
      Keyboard.press(key1);
      delay(50);
      Keyboard.press(key2);
      delay(100);
      Keyboard.releaseAll();
    }
  }
  else if ( num == 3) { // press 3 keys
    sscanf(keys, "%d,%d,%d.", &key1, &key2, &key3);
    if (key1 < 256 && key2 < 256 && key3 < 256) {
      Keyboard.press(key1);
      delay(50);
      Keyboard.press(key2);
      delay(50);
      Keyboard.press(key3);
      delay(100);
      Keyboard.releaseAll();
    }
  }
  else if ( num == 4) { // make a delay
    sscanf(keys, "%d.", &d);
    if (d < 10000) {
      delay(d);
    }
  }
  delay(500);
}

void changeWifi() {
  p.begin("cp");
  p.addParameter("/etc/config/wireless.b");
  p.addParameter("/etc/config/wireless");
  p.run();
  p.begin("/etc/init.d/network");
  p.addParameter("restart");
  p.run();
  delay(10000);
}






