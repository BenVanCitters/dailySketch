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

class FloatCommand extends MathCommand<Float>
{
  public FloatCommand(float min, float max)
  { val = random(min,max); }
  
  Float compute()
  { return val; }
}
class IntCommand extends MathCommand<Integer>
{
  public IntCommand(int min, int max)
  { val = (int)random(min,max); }
  
  Integer compute()
  { return val; }
}
