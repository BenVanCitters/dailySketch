PGraphics tmp;
void setup()
{
  size(500,500,P2D);
  tmp = createGraphics(500,500,P2D);
}

void draw()
{
  float tm = millis()/1000.f;
  float borderMargin = 1;
  tmp.beginDraw();
  tmp.translate(tmp.width/2,tmp.height/2);
  tmp.rotate(.05*cos(tm/10));
  tmp.translate(-tmp.width/2,-tmp.height/2);
  tmp.image(g,borderMargin,
  borderMargin,
  width-2*borderMargin,
  height-2*borderMargin);
  tmp.endDraw();
  
  background(random(255),random(255),random(255));
  translate(width/2,height/2);
  rotate(.05*cos(tm/10));
  translate(-width/2,-height/2);
  image(tmp,borderMargin,
  borderMargin,
  width-2*borderMargin,
  height-2*borderMargin);
}
