void setup()
{
  size(500,500,P3D);
}
void draw()
{
  background(255);
  lights();
  drawStairs();
}

void drawStairs()
{
  float tm = millis()/1000.f;

  int count = 300;
  pushMatrix();
  float stairHt = 5;
  translate(width/2,height/2);
  for(int i = -count/2; i < count/2; i++)
  {
    float pct = i*1.f/count;
    pushMatrix();
    rotateY(tm+pct*(TWO_PI*10));
    translate(100,stairHt*i);
    box(100,stairHt,40);
    popMatrix();
  }
  popMatrix();
  
}

