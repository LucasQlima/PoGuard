// Declaração e atribuição de variaveis
const int PINO_SENSOR_TEMPERATURA = A0;
float temperatura;

void setup() {
  Serial.begin(9600);
}

void loop() {
  int valorLeitura = analogRead(PINO_SENSOR_TEMPERATURA);
  temperatura = ((valorLeitura * 5.0 / 1023.0) / 0.01)-50;
  int temperatura2 = random(-24, -10);
  int temperatura3 = random(-24, -10);

  

// caminhão 1
  
  Serial.print(temperatura);
  Serial.print(";");
  Serial.print(temperatura2);
  Serial.print(";");
  Serial.print(temperatura3); 
  Serial.print(";");
  
// caminhão 2  
  Serial.print(temperatura+10);
  Serial.print(";");
  Serial.print(temperatura2+10);
  Serial.print(";");
  Serial.print(temperatura3+10);
  Serial.print(";");
  
// caminhão 3
  Serial.print(temperatura+10);
  Serial.print(";");
  Serial.print(temperatura2);
  Serial.print(";");
  Serial.println(temperatura3);

  int one_minute = 1000;
  delay(one_minute);
}