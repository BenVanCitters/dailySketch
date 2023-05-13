PGraphics imgs[] = new PGraphics[500];

void setup()
{
  size(500,500);
  int pWidth = width/imgs.length;
  for(int i = 0; i < imgs.length;i++)
  {
    imgs[i] = createGraphics(pWidth, height);
    drawCommand(imgs[i],pWidth*i);
  }

}

void drawCommand(PGraphics p, int offset)
{
  p.beginDraw();
  p.background(0);
  p.noStroke();
  p.fill(255);
  p.ellipse(width/2-offset,height/2,300,300);
  p.endDraw();
}
void draw()
{
  //noiseDetail(256,0.99);
    for(int i = 0; i < imgs.length;i++)
  {
     //= createGraphics(pWidth, height);
   
  image(imgs[i], i*imgs[i].width,-50+100*noise(2*i+millis()/2000.f,i/3.f,i-millis()/3100.f));
  }
  println(frameRate);
}
