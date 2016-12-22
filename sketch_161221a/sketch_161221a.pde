void setup()
{
  size(700, 700, OPENGL);
}

float curRot = 0;
float currentAngle = 0;
long lastMillis = 0;
void draw()
{
  background(0);
//  lights();
  noStroke();
  fill(255,128);
  //translate to 'origin' - the middle of the window
  translate(width/2, height/2);
  //square width
  float sqW = 160;
  currentAngle += (millis() - lastMillis) /400.f;
  if ( currentAngle > PI)
  {
    currentAngle -= PI;
    curRot += HALF_PI;
  }

  //rotate to current 'starting' edge
  rotate(curRot);

  for (int i = 0; i < 3; i++)
  {
    pushMatrix();
    //rotate to side of box
    rotate(HALF_PI*i);
    //displace to edge
    translate(-sqW/2, sqW/2);
    //swing around
    rotate(currentAngle);
//    rotateY(currentAngle*2);
    //draw
    
    rect(0, 0, sqW, sqW);//box(sqW);//
    popMatrix();
  }

  lastMillis = millis();
}

