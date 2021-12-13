void setup() {
  // put your setup code here, to run once:
  SerialUSB.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  SerialUSB.println("Hello, world!");
  delay(100);
}
