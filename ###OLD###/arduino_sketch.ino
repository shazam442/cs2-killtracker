int LED = 4;
const String END_MARKER = "###SERIAL_END###";


void setup() {
  Serial.begin(9600);

  pinMode(LED, OUTPUT);
  bootupLedFlash();
}

void bootupLedFlash() {
  for (int i=0; i <= 3; i++) {
    digitalWrite(LED, HIGH);
    delay(100);
    digitalWrite(LED, LOW);
    delay(100);
  }
  
  digitalWrite(LED, HIGH);
}

void loop() {

  while (Serial.available()) {
    String incoming_message = Serial.readStringUntil('\n');
    
    Serial.println(incoming_message); // send the data back to where it came from
    blinkLedWhileOn(LED);
  }
}



void blinkLedWhileOn(int ledPin) {
  digitalWrite(ledPin, LOW);
  delay(100);
  digitalWrite(ledPin, HIGH);
}