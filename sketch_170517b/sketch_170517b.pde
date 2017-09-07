void setup()
{
  size(500,900,P3D);
}
void draw()
{
  background(40,30,0);
  directionalLight(255,210,200,-1,2.5,-1);
  ambientLight(100,100,80);
  drawStairs();
}

void drawStairs()
{
  float tm = millis()/1000.f;

  int count = 300;//(int)(mouseY*300.f/height);
  pushMatrix();
  float stairHt = 15;//(mouseY*30.f/height);
  float stairDepth = 31;//mouseX*50.f/height;
  float stairWidth = 100;
  translate(width/2,height/2);
  for(int i = -count/2; i < count/2; i++)
  {
    float pct = i*1.f/count;
    pushMatrix();
      rotateY(-tm-pct*(TWO_PI*10));
      pushMatrix();
        translate(100,stairHt*i);
        box(stairWidth,stairHt,stairDepth);
      popMatrix();
      pushMatrix();
        translate(100,stairHt*(i-.5));
        box(stairWidth*1.05,stairHt/10,stairDepth*1.15);
      popMatrix();
    popMatrix();
  }
  popMatrix();
  
}

