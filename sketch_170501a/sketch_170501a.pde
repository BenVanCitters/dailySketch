Liner lin = new Liner();
void setup()
{
  size(500,500,P3D);
  lin.pos = new float[]{width/2, height/2, 0};
}

void draw()
{
  background(255);
  lin.update();
  lin.draw();
}
