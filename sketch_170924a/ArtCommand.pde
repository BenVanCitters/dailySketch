class ArtCommand extends CommandObj
{
  void doTheBiz()
  {}
}

class EllipseCommad extends ArtCommand
{
  FloatCommand x,y,w,h;

  public EllipseCommad()
  {
    x = new FloatCommand(0,width);
    y = new FloatCommand(0,height);
    w = new FloatCommand(0,50);
    h = new FloatCommand(0,50);
    children.add(x);
    children.add(y);
    children.add(w);
    children.add(h);
  }  
  void doTheBiz()
  { 
    ellipse(x.compute(),
            y.compute(),
            w.compute(),
            h.compute());
  }
}

class RectangleCommad extends ArtCommand
{
  FloatCommand x,y,w,h;

  public RectangleCommad()
  {
    x = new FloatCommand(0,width);
    y = new FloatCommand(0,height);
    w = new FloatCommand(0,50);
    h = new FloatCommand(0,50);
    children.add(x);
    children.add(y);
    children.add(w);
    children.add(h);
  }  
  void doTheBiz()
  { 
    rect(x.compute(),
         y.compute(),
         w.compute(),
         h.compute());
  }
}

class Translate2DCommand extends ArtCommand
{
  FloatCommand x,y;

  public Translate2DCommand()
  {
    x = new FloatCommand(0,width);
    y = new FloatCommand(0,height);
    children.add(x);
    children.add(y);
  }  
  void doTheBiz()
  { 
    translate(x.compute(),y.compute());
  }
}

class Rotate2DCommad extends ArtCommand
{
  FloatCommand angle;

  public Rotate2DCommad()
  {
    angle = new FloatCommand(0,TWO_PI);

    children.add(angle);
  }  
  void doTheBiz()
  { 
    rotate(angle.compute());
  }
}
