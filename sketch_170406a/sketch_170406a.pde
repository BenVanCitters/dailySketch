long lastMillis = 0;
baddies b = new baddies();

zel z = new zel();
void setup()
{
  size(500,500);
}

void draw()
{
  //compute delta time
  float dt = (millis()-lastMillis)/1000.f;
  b.update(dt);
  z.update(dt);
  
  background(0,255,0);
  pushMatrix();
  translate(width/2,height/2);
  b.draw();
  z.draw();
  popMatrix();
  lastMillis = millis();
}
