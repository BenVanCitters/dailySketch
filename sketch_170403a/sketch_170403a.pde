ArrayList<arcc> arcs = new ArraList<arcc>();
void setup()
{
   size(500,500,P3D);
   int num = 20;
  float tm = millis()/1000.f;
  for(int i = 0; i < num; i++)
  {
    arcs.add
  }
}

void draw()
{
  background(80,100,240);
  noFill();
  stroke(255);
  strokeWeight(10);
  pushMatrix();
  translate(width/2, height/2);
  int num = 20;
  float tm = millis()/1000.f;
  for(int i = 0; i < num; i++)
  {
    float iPct = i*1.f/num;
    float radius = 50+(10+16)*i;
    arc(0, 0, 
        radius, radius, 
        tm+iPct*.3, tm+HALF_PI+iPct*.3);
  }
  popMatrix();
}
