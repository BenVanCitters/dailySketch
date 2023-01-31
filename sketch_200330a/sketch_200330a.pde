TileMgr mgr;
PImage p;
void setup()
{
  size(600,600,P3D);
  mgr = new TileMgr();
}

void draw()
{
  mgr.draw();
}
