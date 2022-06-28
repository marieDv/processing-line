/** DRAWING A LINE BY USING THE BRESENHAM ALGORITHM**/
/** VERSION 2.0 **/
/** SERIAL COMMUNICATION WITH ARDUINO COMMENTED OUT**/
import processing.serial.*;



//PLACEHOLDER VALUES 
float [] values0 = {100000, 300000};//2 boxes === 0.01 % 
float [] values1 = {400000, 500000};// 4 boxes
float [] values2 = {700000, 900000}; // 7 boxes
float [] values3 = {1000000, 1300000}; // 11 boxes
float [] values4 = {1400000, 1800000}; // 12 boxes 
float [] values5 = {2800000, 2200000}; // 13 boxes === 0.1 % 


//VARIABLES
int activeValue = 0;
boolean imageShown = false;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
PVector pt_a, pt_b;
float w;
float h;
PImage img;
float cellSize = 10;
int x1 = 0;
int y1 = 0;
float counter = 0;
int activeBoxes = 10;
float newSpeed = 0.1;
int randomFactor = 20;
int countForImage = 0;
int x= 0;
int r = 310;
int y = r;
float d = 20-(2*r);
boolean restart = true;

PVector pos;
PVector vel;

void setup() {
fullScreen();
background(0,0,0);
  img = loadImage("intro.png");
  w = width / cellSize;
  h = height / cellSize;
  pt_a = new PVector(w/2.0, h/2);
  pt_b =  new PVector(90.0, 12);
  pos = new PVector(0, 0);
  vel = new PVector(3, 5);
  frameRate(10);
  //myPort = new Serial(this, "/dev/cu.usbmodem14101", 9600);
}

void draw() {

  init();
}

void init(){
val = "1";
//if ( myPort.available() > 0) {  
//  val = myPort.readStringUntil('\n');
//  val = trim(val);

//if (val != null) {
//    if(val.equals("showImage")  ){
//      imageShown = true;
//      myPort.clear();
          
//  }
//  if(val.equals("1")  ){
//    activeValue = 1;
//    myPort.clear();
//  }
//  if(val.equals("2")){
//    activeValue = 2;
//    myPort.clear();
//  }
//  if(val.equals("3")  ){
//    activeValue = 3;
//    myPort.clear();
//  }
//  if(val.equals("4")){
//    activeValue = 4;
//    myPort.clear();
//  }
//  if(val.equals("5")){
//    activeValue = 5;
//    myPort.clear();
//  }  
//}
//}

drawLines();
}

void drawLines(){
  strokeWeight(5);
  stroke(255, 255, 255);
  noFill();

  push();
  fill(0,0,0);
  noStroke();
  rect(0,0, width, height-60);
  pop();
  
  push();
  pos.add(vel);
  if (pos.x > (width-500) / cellSize - cellSize || pos.x < 1) {
    vel.x *= -1;
  }
  if (pos.y > (height-600) / cellSize || pos.y < 1) {
    vel.y *= -1;
  }
  int aX = 100 + (int(sin(0.1 * counter)* 1));
  int aY = 30 + (int(sin(0.9 * counter)* 30));
    pt_a = new PVector(aX, aY);
    drawPt(pt_a);
    pt_b = new PVector(int(pos.x), int(pos.y));
    drawPt(pt_b);
  
    pop();
  
    drawLine(pt_a.x, pt_a.y, pt_b.x, pt_b.y);  
      if(activeValue >= 4){
        drawLine(pt_a.x+10, pt_a.y+10, pt_b.x+10, pt_b.y+10);  
         if(activeValue >= 5){
           drawLine(pt_a.x+20, pt_a.y+20, pt_b.x+20, pt_b.y+20);   
         }
      }
  x1 += Math.sin(counter)*x1;
  
 if(millis() % 17 == 0){
  drawCPUData();
  counter+=0.2;
  }

}

/** DRAW RANDOM DATA FOR NOW **/
void drawCPUData(){
  int posX = 10;
  int posY = height-10;
  push();
   fill(0,0,0);
   noStroke();
   rect(posX, posY-50, width, 300);
   pop();
   textSize(35);
   fill(200, 200, 200);

int numberLoops  = 0;

if(activeValue == 0){ //5
   text(random(values0[0], values0[1])+"X PER SECOND TO RENDER", posX, posY, -120);
   numberLoops = 5;
}
if(activeValue == 1){//9
   text(random(values1[0], values1[1])+"X PER SECOND TO RENDER", posX, posY, -120);
   numberLoops = 9;
}
if(activeValue == 2){//10
   text(random(values2[0], values2[1])+"X PER SECOND TO RENDER", posX, posY, -120);
   numberLoops = 10;
}
if(activeValue == 3){//11
   text(random(values3[0], values3[1])+"X PER SECOND TO RENDER", posX, posY, -120);
   numberLoops = 11;
}
if(activeValue == 4){ // 12
   text(random(values4[0], values4[1])+"X PER SECOND TO RENDER", posX, posY, -120);
   numberLoops = 12;
}
if(activeValue == 5){//14 ALL
   text(random(values5[0], values5[1])+"X PER SECOND TO RENDER", posX, posY, -120);
   numberLoops = 14;
}

   for(int i=0; i<=13; i++){
     push();
     strokeWeight(1);
     stroke(255,255,255);
     noFill();
     rect((posX + 660)+27*i, posY-40, 20,40);
     pop();
   
   }
   for(int i=0; i<=numberLoops-1; i++){
     push();
     fill(255,255,255);
     rect((posX + 660)+27*i, posY-40, 20,40);
     pop();
   
   }
}


void drawPt(PVector pt) {
  float x = pt.x * cellSize;
  float y = pt.y * cellSize;
  fill(255,255,255);
  noStroke();
  rect(x, y, cellSize, cellSize);
}

void drawDot(float x,float y) {
  fill(255,255,255);
  noStroke();
  rect(x * cellSize, y * cellSize, cellSize, cellSize);
}

void drawLine(float x1, float y1, float x2, float y2) {
  float dx, dy;
  dx = x2 - x1;
  if (dx != 0) {
    if (dx > 0) {
      dy = y2 - y1;
      if (dy != 0) {
        if (dy > 0) {
          if (dx >= dy) {
            float e = dx;
            dx = (e - dx) * 2;
            dy = dy * 2;

            while (true) {
              drawDot(x1, y1);
              x1 = x1 + 1;
              if (x1 == x2) {
                break;
              }
              e = e - dy;
              if (e < 0) {
                y1 = y1 + 1;
                e = e + dx;
              }
            }
          } else {
            float e = dy;
            dy = e * 2;
            dx = dx * 2;
            while (true) { 
              drawDot(x1, y1);
              y1 = y1 + 1;
              if (y1 == y2) {
                break;
              }
              e = e - dx;
              if (e < 0) {
                x1 = x1 + 1;
                e = e + dy;
              }
            }
          }
        } else { // dy < 0 (and dx > 0)

          if (dx >= -dy) {
            float e = dx;
            dx = e * 2;
            dy = dy * 2;
            while (true) { 
              drawDot(x1, y1);
              x1 = x1 + 1;
              if (x1 == x2) {
                break;
              }
              e = e + dy;
              if (e < 0) {
                y1 = y1 - 1;
                e = e + dx;
              }
            }
          } else {
            float e = dy;
            dy = e * 2;
            dx = dx * 2;
            while (true) {
              drawDot(x1, y1);
              y1 = y1 - 1;
              if (y1 == y2) {
                break;
              }
              e = e + dx;
              if (e > 0) {
                x1 = x1 + 1;
                e = e + dy;
              }
            }
          }
        }
      } else { // dy = 0 (and dx > 0)
        do {
          drawDot(x1, y1);
          x1 = x1 + 1;
        } while (x1 != x2);
      }
    } else { // dx < 0
      dy = y2 - y1;
      if (dy != 0) {
        if (dy > 0) {

          if (-dx >= dy) {
            float e = dx;
            dx = e * 2;
            dy = dy * 2;
            while (true) {
              drawDot(x1, y1);
              x1 = x1 - 1;
              if (x1 == x2) {
                break;
              }
              e = e + dy;
              if (e >= 0) {
                y1 = y1 + 1;
                e = e + dx;
              }
            }
          } else {
            float e = dy;
            dy = e * 2;
            dx = dx * 2;
            while (true) {
              drawDot(x1, y1);
              y1 = y1 + 1;
              if (y1 == y2) {
                break;
              }
              e = e + dx;
              if (e <= 0) {
                x1 = x1 - 1;
                e = e + dy;
              }
            }
          }
        } else { // dy < 0 (and dx < 0)

          if (dx <= dy) {
            float e = dx;
            dx = e * 2;
            dy = dy * 2; 
            while (true) {
              drawDot(x1, y1);
              x1 = x1 - 1;
              if (x1 == x2) {
                break;
              }
              e = e - dy;
              if (e >= 0) {
                y1 = y1 - 1;
                e = e + dx;
              }
            }
          } else { 
            float e = dy;
            dy = e * 2;
            dx = dx * 2; 
            while (true) {
              drawDot(x1, y1);
              y1 = y1 - 1;
              if (y1 == y2) {
                break;
              }
              e = e - dx;
              if (e >= 0) {
                x1 = x1 - 1;
                e = e + dy;
              }
            }
          }
        }
      } else { // dy = 0 (and dx < 0)
        do {
          drawDot(x1, y1);
          x1 = x1 - 1;
        } while (x1 != x2);
      }
    }
  } else { // dx = 0
    dy = y2 - y1;
    if (dy != 0) {
      if (dy > 0) {
        do {
          drawDot(x1, y1);
          y1 = y1 + 1;
        } while (y1 != y2);

      } else { // dy < 0 (and dx = 0)
        do {
          drawDot(x1, y1);
          y1 = y1 - 1;
        } while (y1 != y2);
      }
    }
  }
}

void drawGrid() {
  push();
  stroke(255, 255, 255);
  strokeWeight(0.2);
  for (int y = 0; y <= h/2; y++) {
   line(0, y * cellSize, w * cellSize, y * cellSize);
    for (int x = 0; x <= w/2; x++) {
    line(x * cellSize, 0, x * cellSize, h * cellSize);
    }
  }pop();
}
