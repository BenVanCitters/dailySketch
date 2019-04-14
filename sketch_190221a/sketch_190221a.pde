void setup()
{
  size(500,500,P3D);
  sphereDetail(15);
  frameRate(2);
}

void draw()
{
  clear();
  noStroke();
  lights();
  translate(width/2,height/2);
  int maxDepth = 10;
  stickballRender(false,maxDepth);
}

void stickballRender(boolean isStick,int maxDepth)
{
  if(maxDepth < 0)
    return;
  maxDepth--;
    float w = 5;
    float l = 100;
  pushMatrix();
  if(isStick)
  {
    rotateX(random(TWO_PI));
    rotateY(random(TWO_PI));
    rotateZ(random(TWO_PI));
    translate(l/2,0,0);
    fill(220,100,0);
    box(l,w,w);
    translate(l/2,0,0);
    stickballRender(!isStick,maxDepth);
  }
  else
  {
    fill(190,220,255);
    sphere(20);
    int rCount = (int)(random(3));
    for(int i = 0; i < rCount; i++)
    {
      stickballRender(!isStick,maxDepth);
    }
  }

  popMatrix();
}
