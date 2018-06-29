import processing.opengl.*;


DifRec d;

void setup()
{
  size(displayWidth,displayHeight,P2D);
    initLPD8();
  d = new DifRec(100,100);

}

void draw()
{
  background(0);
  long s = millis();
  int count = 11;
  for(int i = 0; i < count; i++)
  {
    d.update();  
  }
  d.render();
  long f = millis()-s;
  
  s = millis();
  drawTex();
  long f2 = millis()-s;
  
  //draw info
  tText("" + frameRate,0,50);
  tText("updateTime: " + f + " drawTime: " + f2, 0, 65);

}
void tText(String s, float x, float y)
{
  pushStyle();
    fill(255);
    stroke(255);
    text(s,x,y);
    fill(0);
    stroke(0);
    text(s,x+1,y+1);  
  popStyle();
}
  

  float wCount = 16.f;
  float hCount = 9.f;
void drawTex()
{
  float texW = width*1.f/wCount;
  float texH = height*1.f/hCount;
  float scaleW= texW/d.renderTarget.width;
  float scaleH= texH/d.renderTarget.height;
  
  int rotCount = 0;
  
  for(int i = 0; i < ceil(wCount); i++)
  {
    for(int j = 0; j < ceil(hCount); j++)
    {

     pushMatrix();
       translate(i*texW,j*texH);
       translate(texW/2,texH/2);
       rotate(HALF_PI*rotCount);
       translate(-texW/2,-texH/2);  
       scale(   scaleW,scaleH);
       image(d.renderTarget,0,0);
     popMatrix();
     rotCount++;
    }
  }
}
