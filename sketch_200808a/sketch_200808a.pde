//https://medium.com/@zachlieberman/daily-sketches-2016-28586d8f008e
Ring r;

void setup()
{
  size(600,600);
  r = new Ring(200);
}
long lastMillis = 0;
void draw()
{
  float dt = (millis()-lastMillis)/1000.f;
  lastMillis = millis();
  background(0);
  r.update(dt);
  r.draw();
}
