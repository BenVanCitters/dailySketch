class CommandObj<T>
{
  public ArrayList<CommandObj> children = new ArrayList<CommandObj>();
  public ArrayList<CommandObj> getChildren(){return children;} 
  void doTheBiz() { }
  T compute()
  { return null; }
}

class MathCommand<T> extends CommandObj
{
  T val;
  T compute()
  { return null; }
}

class SinCommand extends MathCommand<Float>
{
  MathCommand mc;
  public SinCommand(MathCommand c)
  { mc = c; }
  
  Float compute()
  { 
    float f = (Float)mc.compute();
    return sin(f); }
}

class FloatCommand extends MathCommand<Float>
{
  public FloatCommand(float min, float max)
  { val = random(min,max); }
  
  Float compute()
  { return val; }
}

class TimeFloatCommand extends MathCommand<Float>
{
  Float compute()
  { return millis()/1000.f; }
}

class IntCommand extends MathCommand<Integer>
{
  public IntCommand(int min, int max)
  { val = (int)random(min,max); }
  
  Integer compute()
  { return val; }
}
