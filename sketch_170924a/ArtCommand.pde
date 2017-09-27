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

class Translate2DCommad extends ArtCommand
{
  FloatCommand x,y;

  public Translate2DCommad()
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
