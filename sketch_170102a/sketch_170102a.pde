PGraphics p;
PGraphics g2;
void setup()
{
  size(500,500, P3D);
  p = createGraphics(width,height,P3D);
  p.beginDraw();
  p.background(255);
  p.endDraw();
  g2 = createGraphics(width,height,P3D);
}

void draw()
{
  
  p.beginDraw();
  
  float tm = millis()/1000.f;
  
  //draw flaps
  p.strokeWeight(5);
  p.pushMatrix();
    p.translate(width/2,height/2);
    p.rotateY(tm);
    p.rotateZ(tm/16);
    int flapCount = 10;
    float flapW = 220;
    for(int i = 0; i < flapCount; i++)
    {
      float pctThroughLoop = i*1.f/flapCount;
      float curRadian = pctThroughLoop * TWO_PI;
      p.pushMatrix();        
        p.translate(-flapW/2,0);
        p.rotateX(curRadian + tm);
        
        p.textureMode(NORMAL);
        p.beginShape(QUAD);
        p.texture(g2);
          p.vertex(0,0,0,0);
          p.vertex(flapW,0,1,0);
          p.vertex(flapW,flapW,1,1);
          p.vertex(0,flapW,0,1);
        p.endShape();
      p.popMatrix();
    }
  p.popMatrix();
  p.endDraw();
  image(p,0,0);  
  g2.beginDraw();
  g2.image(p,0,0);
  g2.endDraw();
}
