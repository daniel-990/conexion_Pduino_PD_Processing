import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


int tamano = 60;
int numeroBolas = 50;
int tamano2 = 0;
int posX2 = 0;
int posY2 = 0;

int valor = 0;
int valor2 = 0;

int relleno = 0;
float [] posX = new float [numeroBolas];
float [] posY = new float [numeroBolas];


void setup (){
size(500,500,P3D);
//por aqui va a escuchar PD
oscP5 = new OscP5(this,12001);

for(int i=0; i<numeroBolas; i++){
  posX[i] = width/random(10);
  posY[i] = height/random(5);
}
}

void draw(){
  background(tamano2,199,posY2);
  noStroke();
  fill(random(255),random(255),random(255));
  ellipse(posX2,posY2,tamano,tamano);
  bezier(posX2,10,40,posY2,120,30,tamano2,tamano2);
  triangle(30, posX2, 58, posY2, 86, tamano2);
  
  pushMatrix();
  fill(255);
  translate(tamano2, posY2/2, 0);
  rotateY(posY2);
  rotateX(posX2);
  noStroke();
  box(tamano2);
  popMatrix();
  
  
  for(int i=0; i<numeroBolas; i++){
      strokeWeight(3);
      stroke(random(200));
      noFill();
      rect(valor2, 20, 55, valor, posY2);
      rect(30,posY2, tamano2, tamano2);
  }
}

void mousePressed(){
  for(int i=0; i<numeroBolas; i++){
    posX[i] = width/random(5);
    posY[i] = height/random(5);
  }
}

//comunicacion osc con PUREDATA
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  
  if(theOscMessage.checkAddrPattern("/valor1")==true) {
    int primerValor = theOscMessage.get(0).intValue();
    tamano2 = primerValor;
  } 
  
  if(theOscMessage.checkAddrPattern("/valor2")==true){
      int segundoValor = theOscMessage.get(0).intValue();
      posX2 = segundoValor;
  }
  
    if(theOscMessage.checkAddrPattern("/valor3")==true){
      int tercerValor = theOscMessage.get(0).intValue();
      posY2 = tercerValor;
  }
  
    if(theOscMessage.checkAddrPattern("/valor4")==true){
      int cuartoValor = theOscMessage.get(0).intValue();
      valor = cuartoValor;
  }
  
    if(theOscMessage.checkAddrPattern("/valor5")==true){
      int quintoValor = theOscMessage.get(0).intValue();
      valor2 = quintoValor;
      println(valor2);
  }
  
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
