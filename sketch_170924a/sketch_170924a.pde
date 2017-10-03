EllipseCommad e;// = new EllipseCommad();

void setup()
{
  size(500,500);
   e = new EllipseCommad(new MathCommand(),
   new MathCommand(),
   new MathCommand(),
   new MathCommand());
}

void draw()
{
  e.doTheBiz();
}
