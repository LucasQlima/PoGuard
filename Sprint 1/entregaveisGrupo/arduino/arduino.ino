// Declaração e atribuição de variaveis
const int PINO_SENSOR_TEMPERATURA = A0;
float temperatura;

void setup() {
  Serial.begin(9600);
}

void loop() {
  //  CAMINHÃO
  int valorLeitura = analogRead(PINO_SENSOR_TEMPERATURA);
  temperatura = ((valorLeitura * 5.0 / 1023.0) / 0.01)-50;
  int temperatura2 = random(-24, -14);
  int temperatura3 = random(-24, -14);
  
  int temperatura4 = random(-24, -14);
  int temperatura5 = random(-24, -14);
  int temperatura6 = random(-24, -14);
  
  int temperatura7 = random(-14, -10);
  int temperatura8 = random(-24, -14);
  int temperatura9 = random(-24, -14);
  
  int temperatura10 = random(-14, -10);
  int temperatura11 = random(-14, -10);
  int temperatura12 = random(-24, -14);
  
  int temperatura13 = random(-14, -12);
  int temperatura14 = random(-14, -12);
  int temperatura15 = random(-14, -12);
  
  int temperatura16 = random(-24, -14);
  int temperatura17 = random(-24, -14);
  int temperatura18 = random(-14, -10);
  
  int temperatura19 = random(-24, -14);
  int temperatura20 = random(-14, -12);
  int temperatura21 = random(-14, -12);
  
  int temperatura22 = random(-24, -14);
  int temperatura23 = random(-24, -14);
  int temperatura24 = random(-24, -14);

// caminhão 1
  Serial.print(temperatura);
  Serial.print(";");
  Serial.print(temperatura2);
  Serial.print(";");
  Serial.print(temperatura3); 
  Serial.print(";");
  
// caminhão 2  
  Serial.print(temperatura4);
  Serial.print(";");
  Serial.print(temperatura5);
  Serial.print(";");
  Serial.print(temperatura6);
  Serial.print(";");
  
// caminhão 3
  Serial.print(temperatura7);
  Serial.print(";");
  Serial.print(temperatura8);
  Serial.print(";");
  Serial.print(temperatura9);
  Serial.print(";");
    
// caminhão 4
  Serial.print(temperatura10);
  Serial.print(";");
  Serial.print(temperatura11);
  Serial.print(";");
  Serial.print(temperatura12);
  Serial.print(";");
    
// caminhão 5
  Serial.print(temperatura13);
  Serial.print(";");
  Serial.print(temperatura14);
  Serial.print(";");
  Serial.print(temperatura15);
  Serial.print(";");
    
// caminhão 6
  Serial.print(temperatura16);
  Serial.print(";");
  Serial.print(temperatura17);
  Serial.print(";");
  Serial.print(temperatura18);
  Serial.print(";");
    
// caminhão 7
  Serial.print(temperatura19);
  Serial.print(";");
  Serial.print(temperatura20);
  Serial.print(";");
  Serial.print(temperatura21);
  Serial.print(";");
    
// caminhão 8
  Serial.print(temperatura22);
  Serial.print(";");
  Serial.print(temperatura23);
  Serial.print(";");
  Serial.println(temperatura24);

  int ten_seconds= 1000 * 1;
  delay(ten_seconds);
}