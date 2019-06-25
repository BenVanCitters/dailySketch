class MyTinyClass{
  public int tiny = 1;
  private String s = "1";
}

class superCLASS{
 public void f(){}; 
}

class MyClass extends superCLASS{
  public float b = 9;
  private MyTinyClass mtc;
  public MyClass()
  {
    mtc = new MyTinyClass();
  }
  
  public int getCount()
  {
    return mtc.tiny;
  }
  
  public void setMTC(MyTinyClass m)
  {
    mtc = m;
  }
  
}
