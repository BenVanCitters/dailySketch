
import java.lang.reflect.Method; 
import java.lang.reflect.Field; 
import java.lang.reflect.Constructor; 

void setup()
{
  MyClass mc = new MyClass();
  PVector p = new PVector();
  printClassStuff(mc);
  //printClassStuff(p);
  
}

void printClassStuff(Object o)
{
  Class c = o.getClass();  
  println("================");
  println(c.toString());
  print("Class: " + c.getName() + " : ");
  for(Class cls : c.getClasses())
  {
    print(cls + ", " );
  }
  println();
  println("Constructors:");
  Constructor[] constructors = c.getConstructors();
  for(Constructor constructor : constructors)
  {
    println("#" + constructor.toString());
  }
  
  println("Methods:");
  Method[] methods = c.getMethods(); 
  for (Method method : methods) 
  {
    println("*" + method.toString());
  }
  println("Fields:");
  Field[] fields = c.getDeclaredFields();
  for(Field field : fields)
  {
    println("-" + field.toString());
  }
}
