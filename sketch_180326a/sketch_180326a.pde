PShape hexa ;
void setup()
{
  size(500,500,OPENGL);
  buildHex();
}

void buildHex()
{
  hexa = createShape();
  hexa.beginShape(TRIANGLE_FAN);
  hexa.specular(255, 255, 255);
  hexa.shininess(5.0); 
  hexa.fill(0);
  hexa.noStroke();
  
  //middle
  hexa.vertex(0,0);
  for(int i = 0; i < 7; i++)
  {
    float radian = i*TWO_PI/6.f;
    hexa.vertex(cos(radian),
                sin(radian),
                .1*cos(radian*2));
  }
  hexa.endShape();
}

void draw()
{
  background(0,255,0);
  lightSpecular(255, 255, 255);
  directionalLight(255, 255, 255, 0, 0, -1);
  specular(255, 255, 255);
  
  int w = 9;
  int h = 35;
  for(int i = 0; i < w; i++)
  {
    for(int j = 0; j< h; j++)
    {
      
      pushMatrix();
      scale(15);
      float x = (j % 2)*2 + i*4;
      float y = j;
      float d = dist(2*w,.5*h,x,y);
      translate(x,y);
      float tm = millis()/1000.f;
      rotateX(.5*tm + .2*d);
      //rotateY(0.4*tm);
      //rotateZ(0.3*tm);
      shape(hexa);
      popMatrix();
    }
  }

for(int i = 0; i < 4; i++)
  {
    for(int j = 0; j< 15; j++)
    {
      pushMatrix();
      scale(80);
      translate(-3,-3,-5);
      translate((j % 2)*2 + i*4, 
                j);
      float tm = millis()/1000.f;
//      rotateX(0.1*tm + j/10.f);
      //rotateZ(0.1*tm);
      rotateY(0.1*tm + j/3.f);
      
      shape(hexa);
      popMatrix();
    }
  }
  println("fr: " + frameRate);
}
