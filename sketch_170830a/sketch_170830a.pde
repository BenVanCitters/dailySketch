import javax.tools.JavaCompiler;
import javax.tools.ToolProvider;
import java.io.*;
//import org.eclipse.jdt.core.compiler.batch.BatchCompiler;

String[] sketchStr;

void setup()
{
  size(500,500);
  textSize(15);

  println(sketchPath(""));
  
  compileJazz();
}


void draw()
{
  for(int i = 0; i < sketchStr.length; i++)
  {
    text(sketchStr[i],0,(1+i)*15);
  }  

}
void newJazz()
{
  final StringBuffer errorBuffer = new StringBuffer();
        Writer internalWriter = new Writer() {
          public void write(char[] buf, int off, int len) {
            errorBuffer.append(buf, off, len);
          }

          public void flush() { }

          public void close() { }
        };
// Wrap as a PrintWriter since that's what compile() wants
      PrintWriter writer = new PrintWriter(internalWriter);

      //result = com.sun.tools.javac.Main.compile(command, writer);
      
      PrintWriter outWriter = new PrintWriter(System.out);
      
      // Version that's not dynamically loaded
      //CompilationProgress progress = null;
      BatchCompiler.compile(command, outWriter, writer, progress);
    }
void compileJazz()
{
 JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
 String myPath = sketchPath("") + "sketch_170830a.pde";
 println(myPath);
 File myFile = new File(myPath);
 println(myFile.getPath());
 println(compiler);
 compiler.run(null, null, null, myFile.getPath()); 
}

void printFile()
{
  sketchStr = loadStrings("sketch_170830a.pde");

  for(int i = 0; i < sketchStr.length; i++)
  {
    println(sketchStr[i]);
  }
}

void printDirectories()
{
    File dir = new File(sketchPath(""));
  File[] filesList = dir.listFiles();
  for (File file : filesList) {
      if (file.isFile()) {
          System.out.println(file.getName());
      }
  }
}
