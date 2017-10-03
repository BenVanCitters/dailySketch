class CommandObj<T>
{
  public ArrayList<CommandObj> children = new ArrayList<CommandObj>();
  public ArrayList<CommandObj> getChildren(){return children;} 
  void doTheBiz() { }

}

class MathCommand<Number> extends CommandObj
{
  public MathCommand()
  {
    int r = (int)random(106);
    MathCommand m;
    switch (r)
    {
      case 0: //add
        m = new AddCommand();
        break;
      case 1: //mult
        m = new MultCommand();
        break;      
      case 2: //sin
        m = new SinCommand();
        break;
      case 3: //cos
        m = new CosCommand();
        break;
      case 4: //time
        m = new TimeFloatCommand();
        break;      
      case 5: 
       
//      case 5: //pow
//      case 6: //log
//      case 7: //val
//      case 8: //sqrt
//      case 1: //sub
      default: //float
        m = new FloatCommand(-99999,99999);
        break;    
    }
    children.add(m);
    printMe();
  }
  
  void printMe()
  {
    MathCommand c = (MathCommand)children.get(0);
    println(c.getStr());
  }
  
  String getStr()
  {
    return "";
  }
//    T compute()
//  { return null; }
  Number compute()
  { 
    MathCommand c = (MathCommand)children.get(0);
    return 
      (Number)
      c.compute(); 
  }
}

class MultCommand extends MathCommand<Float>
{
  MathCommand A;
  MathCommand B;
  
  public MultCommand()
  { println("mult"); A = new MathCommand(); B = new MathCommand();  
     children.add(A);children.add(B); }
  
  public MultCommand(MathCommand a, MathCommand b)
  {  A = a; B = b;  children.add(a);children.add(b); }
  
  Float compute()
  {  return (Float)A.compute() * (Float)B.compute(); }

  String getStr()
  {
    return A.getStr() + " * " + B.getStr();
  }
}

class AddCommand extends MathCommand<Float>
{
  MathCommand addA;
  MathCommand addB;
  public AddCommand()
  { println("add"); addA = new MathCommand(); addB = new MathCommand();  
     children.add(addA);children.add(addB); }
  
  public AddCommand(MathCommand a, MathCommand b)
  {  addA = a; addB = b;  children.add(a);children.add(b); }
  
  Float compute()
  {  return (Float)addA.compute() + (Float)addB.compute(); }
  
  String getStr()
  {
    return addA.getStr() + " + " + addB.getStr();
  }
}

class SinCommand extends MathCommand<Float>
{
  MathCommand mc;
  public SinCommand()
  {  println("sine");mc = new MathCommand(); children.add(mc);}
  public SinCommand(MathCommand c)
  {  mc = c;  children.add(c); }
  
  Float compute()
  {  return sin((Float)mc.compute()); }
  String getStr()
  {
    return " sin( " + mc.getStr() + " ) "; 
  }
}

class CosCommand extends MathCommand<Float>
{
  MathCommand mc;
  public CosCommand()
  {  println("cos");mc = new MathCommand(); children.add(mc);}
  public CosCommand(MathCommand c)
  {  mc = c;  children.add(c); }
  
  Float compute()
  {  return cos((Float)mc.compute()); }
  String getStr()
  {
    return " cos( " + mc.getStr() + " ) "; 
  }
}

class FloatCommand extends MathCommand<Float>
{
  float val;
  public FloatCommand(float min, float max)
  { println("float");val = random(min,max); }
  
  Float compute()
  { return val; }
String getStr()
  {
    return " " + val + " " ; 
  }
}

class TimeFloatCommand extends MathCommand<Float>
{
  public TimeFloatCommand()
{
  println("time");
}
  
  Float compute()
  { return millis()/1000.f; }
String getStr()
  {
    return " t:=" + compute() + " " ; 
  }
}

class IntCommand extends MathCommand<Integer>
{
  int val;
  public IntCommand(int min, int max)
  { println("int");val = (int)random(min,max); }
  
  Integer compute()
  { return val; }
  String getStr()
  {
    return " " + val + " " ; 
  }
}
