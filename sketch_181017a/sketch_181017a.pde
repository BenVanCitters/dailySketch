void setup()
{
  size(1000,700);
}

void draw()
{
  background(255);
  int vCount = 500;
  float mPct = mouseX*1.f/width;
  int lCount = (int)(200);
  
  for(int j = 0; j < lCount; j++)
  {
    noFill();
    beginShape();
    float jPct = j*1.f/lCount;
    float tpct = 1-pow(jPct,.005);
    for(int i = 0; i < vCount; i++)
    {
      float pct = i*1.f/vCount;
      float y = pow(pct,(tpct)*200*mPct)*height;
      vertex(pct*width,y);
    }
    endShape();
  }
}
