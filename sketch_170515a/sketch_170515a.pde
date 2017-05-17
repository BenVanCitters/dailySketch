particles p;

void setup()
{
  size(displayWidth,700,P2D);
  p = new particles();
}

long lastMillis = 0;
void draw()
{
  background(255);
  float dt = (millis()-lastMillis)/1000.f;
   p.update(dt);
  p.draw(); 
  lastMillis = millis();
}
