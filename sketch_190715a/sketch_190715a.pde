BShape bshape;

import controlP5.*;

ControlP5 cp5;
int sliderValue = 100;

    float firstRadius = 400;
  float secondRadius = 80;
  float thirdRadius = 0;
  float fourthRadius = 20; //radius of solid

  float firstRotCount = 3;
  float secondRotCount = 13;
  float thirdRotCount = 13;
  int ringVerts = 5;
void setup()
{
  size(1800,1000, P3D);
  
  int sliderWidth = 600;
  cp5 = new ControlP5(this);
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("firstRadius")
     .setPosition(10,50)
    .setWidth(sliderWidth)
     .setRange(0,800);
  cp5.addSlider("secondRadius")
     .setPosition(10,70)
    .setWidth(sliderWidth)
     .setRange(0,800);
   cp5.addSlider("thirdRadius")
     .setPosition(10,90)
    .setWidth(sliderWidth)
     .setRange(0,800);  
   cp5.addSlider("fourthRadius")
     .setPosition(10,110)
    .setWidth(sliderWidth)
     .setRange(0,600); 
     
   int tickCount = 81;
   int range = 20;
   cp5.addSlider("firstRotCount")
     .setPosition(10,150)
    .setNumberOfTickMarks(tickCount)
    .setWidth(sliderWidth)
     .setRange(-range,range);
   cp5.addSlider("secondRotCount")
     .setPosition(10,170)
    .setNumberOfTickMarks(tickCount)
    .setWidth(sliderWidth)
     .setRange(-range,range);
   cp5.addSlider("thirdRotCount")
     .setPosition(10,190)
    .setNumberOfTickMarks(161)
    .setWidth(sliderWidth)
     .setRange(-40,40);
     
   cp5.addSlider("ringVerts")
     .setPosition(10,220)
    .setNumberOfTickMarks(101)
    .setWidth(sliderWidth)
     .setRange(3,100);
}

void draw()
{
  
  bshape = new BShape(firstRadius, secondRadius,  thirdRadius,  fourthRadius,
   firstRotCount, secondRotCount, thirdRotCount, ringVerts, 1000);
  lights();
  background(200);
  text("franerate: " + frameRate, 0,20);
  float tm = millis()/6000.f;
  pushMatrix();
  
  translate(width/2,height/2);
  rotateX(tm);
  rotateY(tm/2);
  rotateZ(tm/3);  
  bshape.draw();
  //pushMatrix();
  //translate(200,0,0);
  //rotateX(HALF_PI);
  //bshape.draw();
  //popMatrix();
  //pushMatrix();
  //translate(-200,0,0);
  //rotateX(HALF_PI);
  //rotateY(PI);
  //bshape.draw();
  //popMatrix();
  
  //pushMatrix();
  //translate(0,200,0);
  //rotateY(HALF_PI);
  //bshape.draw();
  //popMatrix();
  //pushMatrix();
  //translate(0,-200,0);
  //rotateY(HALF_PI);
  //rotateZ(PI);
  //bshape.draw();
  //popMatrix();
  popMatrix();
  
  //translate(0,0,200);
}

void keyPressed() 
{
   bshape = new BShape(firstRadius, secondRadius,  thirdRadius,  fourthRadius,
   firstRotCount, secondRotCount, thirdRotCount, ringVerts, 2000);
  bshape.saveAsOBJ(); 
}
