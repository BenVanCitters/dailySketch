PImage p;
ColorLine cl;
void setup()
{
  size(600,600);
  cl = new ColorLine();
}

void draw()
{
  background(200);
  cl.draw();
}
