KaruskalMazeMaker kmm;
void setup()
{
  size(700,700);
  kmm = new KaruskalMazeMaker();
  kmm.setup();
}

void draw()
{
  background(40);
  //  kmm.setup();
  //kmm.solve(2 );
  kmm.draw();
}

float nsin(float t)
{
  return (1.f+sin(t))/2.f;
}

void mouseClicked()
{
    kmm.setup();
  kmm.solve(2 );
}
