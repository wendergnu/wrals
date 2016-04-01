//Programa : Serial port
//by Wender Fernandes

String inData;
int led = 13;
void setup() {
    pinMode(led, OUTPUT);
    Serial.begin(9600);    
}

void loop() {
    while (Serial.available() > 0){
        char recieved = Serial.read();
        inData += recieved;        
        if (recieved == '\n'){
            if(inData == "1\n"){              
              digitalWrite(led, HIGH);              
            }
            else if(inData == "0\n"){              
              digitalWrite(led, LOW);              
            }
            inData = "";            
            Serial.print(digitalRead(led));              
        }
    }
}
