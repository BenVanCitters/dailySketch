SpotCollection s;
void setup()
{
  size(600,600,P3D);
  s = new SpotCollection(550);
}

void draw()
{
  background(0);
  translate(width/2,height/2,200);
  s.draw();
}

void printPos(float[] pos)
{
  println("pos: [" +pos[0]+ "," + pos[1]+ "," + pos[2] + "]");
}
