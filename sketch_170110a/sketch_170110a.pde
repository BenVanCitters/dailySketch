void setup()
{
  size(500,500, P3D);
}

void draw()
{
  lights();
  background(200,90,30);
  float tm = millis()/1000.f;
  int count = 10;
  float wheelRad = 200;
  float radianDiv = TWO_PI/count;
  int wheelCount = 13;
  float wheelRot = PI/wheelCount;
  float spotOffeset = 0;
  translate(width/2,height/2);
  for(int j = 0; j < wheelCount; j++)
  { 
    pushMatrix();
    float curWheelRot = wheelRot*j;
    rotateY(curWheelRot +tm/16);
    
    for(int i = 0; i< count; i++)
    {
      pushMatrix();
      rotateX(spotOffeset+radianDiv*i+tm);
      translate(0,0,wheelRad);
      fill(20,50,255);
      noStroke();
      ellipse(0,0,20,20);
      popMatrix();
    }
    tm*=-1;
    spotOffeset += radianDiv/4;
    popMatrix();
  }
}
