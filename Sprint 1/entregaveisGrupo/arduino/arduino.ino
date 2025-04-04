// Declaração e atribuição de variaveis
const int PINO_SENSOR_TEMPERATURA = A0;
float sensor1;
float sensor2;
float sensor3;
float sens2CalcMulti;
float sens2CalcSubt;
float sens3CalcMulti;
void setup() {
  Serial.begin(9600);
}

void loop() {
  int valorLeitura = analogRead(PINO_SENSOR_TEMPERATURA); //A0
  sens2CalcMulti = random(230, 300)/100;
  sens2CalcSubt = random(20,22);
  sens3CalcMulti = random(150, 300)/100;
  sensor1 = ((valorLeitura * 5.0 / 1023.0) / 0.01)-21;
  sensor2 = (((valorLeitura * 5.0 / 1023.0) / 0.01)- sens2CalcSubt) * sens2CalcMulti;
  sensor3 = (((valorLeitura * 5.0 / 1023.0) / 0.01)-23.98) * sens3CalcMulti;
  
  Serial.print("Sensor1:");
  Serial.print(sensor1);  
  Serial.print(" ");  
  Serial.print("Sensor2:");
  Serial.print(sensor2);
  Serial.print(" ");  
  Serial.print("Sensor3:");
  Serial.print(sensor3);
  Serial.print(" ");  
  Serial.print("TempMáxima:");  
  Serial.print(7);
  Serial.print(" ");  
  Serial.print("TempMínima:");  
  Serial.println(-2);

  delay(100);
}