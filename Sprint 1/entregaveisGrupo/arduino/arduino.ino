// Declaração e atribuição de variaveis
const int PINO_SENSOR_TEMPERATURA = A0;
float temperatura;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int valorLeitura = analogRead(PINO_SENSOR_TEMPERATURA);
  temperatura = ((valorLeitura * 5.0 / 1023.0) / 0.01)-40;
  int temperatura2 = random(-24, -12);
  int temperatura3 = random(-24, -12);
  
  Serial.print(temperatura);
  Serial.print(";");
  Serial.print(temperatura2);
  Serial.print(";");
  Serial.println(temperatura3);

  delay(1000);
}