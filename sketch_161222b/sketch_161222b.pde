card c = new card();
long lastMillis = 0;
void setup()
{
  size(500,500, OPENGL);
  c.dims= new float[]{300,100};
  c.pos= new float[]{-150,0};
}

void draw()
{
  float dt = (millis()-lastMillis)/1000.f;
  c.update(dt);
  
  background(210);
  translate(width/2,height/2);
  c.draw();
  lastMillis = millis();
}
