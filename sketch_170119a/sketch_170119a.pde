PGraphics p;
void setup()
{
  size(1000,1000,P2D);
  p = createGraphics(200,200,P2D);
}

void draw()
{
  p.beginDraw();
  p.noStroke();
  for(int i = 0; i < 10; i++)
  {
    p.fill(random(255),random(255),random(255),random(50));
    float r = random(60);
    int count = 9;
    float[] pos = {random(p.width),random(p.height)};
    for(int j = 0; j < count; j++)
    {
      float pct = 1-j*1.f/count;
      p.ellipse(pos[0],pos[1], r*pct,r*pct);
    }
  }
  p.filter(DILATE);
//  p.filter(DILATE);
//  p.filter(THRESHOLD,.95);

  p.endDraw();
  image(p,0,0,width,height);
//  filter(DILATE);
  println("frameRate: " + frameRate);
}
