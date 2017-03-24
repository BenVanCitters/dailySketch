void setup()
{
  size(1000,800,P3D);
}

void draw()
{
  float t = millis()/4000.f;
  
    float r = (1+sin(6+t*.87))/2;
    float g = (1+sin(5+t/1.221))/2;
    float b = (1+sin(4+t/2.0))/2;
    int c1 = color(r*255,g*255,b*255);
  
    r = (1+sin(1+t*0.4))/2;
    g = (1+sin(2+t/2.1))/2;
    b = (1+sin(3+t/2.3))/2;
    int c2 = color(r*255,g*255,b*255);
  
 

  
if(frameCount%2 ==0)
  {
    background(c1);
drawBox(c2,t);
}
  else
  {
    background(c2);
  drawBox(c1,t);
}
  

  
    
}

void drawBox(int c, float t)
{
   translate(width/2,height/2);
   noStroke();
   rotateX(t/2);
   rotateY(t/2.4);
   rotateZ(t/1.7);
   fill(c);
    box(250);
}


