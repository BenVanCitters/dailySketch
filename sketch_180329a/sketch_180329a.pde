void setup()
{
  size(1400,1400,P3D);  
}

void draw()
{
  float tm = millis()/1000.f;
  lights();
  translate(width/2, height/2);
  float radianSpread = .3*(1+cos(tm*.1))/2.f;
  for(int i = 0; i< 20; i++)
  {
    arm(tm);
    rotateX(radianSpread);
    rotateY(radianSpread);
  }
}

void arm(float tm)
{
  pushMatrix();
  fill(0,255,0);
  armBox(500, 50,  tm, -.2,  .1,  1);//, float d)

  fill(0,0,255);
  armBox(200, 30,  tm, .8,  -.1,  -1.9);
  
  fill(255,0,0);
  armBox(100, 20,  tm, 1.1,  .5,  2.1);
  popMatrix();
}

void armBox(float w, float h, float tm, float rx, float ry, float rz)//, float d)
{
  rotateX(tm*rx);
  rotateY(tm*ry);
  rotateZ(tm*rz);
  translate(w/2,0);
 
  box(w,h,h);
  translate(w/2,0);
}