//lloads a STL file
class BShape2
{
  ArrayList<float[]> normals = new ArrayList<float[]>();
 
  ArrayList<float[]> verts = new ArrayList<float[]>(); 
  
  public BShape2(String filepath)
  {
    openParseFile(filepath);
  }
  public BShape2()
  {
    
  }
  
  void openParseFile(String path)
  {
    current_state = 0;
    String[] lines = loadStrings(path);
    for(int i = 0; i < lines.length; i++)
    {
      println(lines[i]);
      String line = lines[i];
      fileStateHandle(line);
      println(current_state);
      switch(current_state)
      {
        case NOTHING:
          break;
        case SOLID:
          break;
        case FACET_NORM:
          String[] normstr = line.split("facet normal ");
          if(normstr.length > 1)
          {
            normals.add(floatArrayFromStr(normstr[1]));
          }
          break;
        case FACET_OUTER_LOOP:
          break;
        case FACET_V1:
          String v1Str = line.split("vertex ")[1];
          verts.add(floatArrayFromStr(v1Str));
          break;
        case FACET_V2:
          String v2Str = line.split("vertex ")[1];
          verts.add(floatArrayFromStr(v2Str));
          break;
        case FACET_V3:
          String v3Str = line.split("vertex ")[1];
          verts.add(floatArrayFromStr(v3Str));
          break;
        default:
          println("Error!  current parse state is " + current_state);
          break;
      }
    }
  }

float[] floatArrayFromStr(String floatStr)
{
  //println(floatStr);
    String[] norms = floatStr.split(" ");
    float[] floats = {new Float(norms[0]), new Float(norms[1]),new Float(norms[2])};
    return floats;
}
  //messy non-enum states
  final int NOTHING = 0;
  final int SOLID = 1;
  final int FACET_NORM = 2;
  final int FACET_OUTER_LOOP = 3;
  final int FACET_V1 = 4;
  final int FACET_V2 = 5;
  final int FACET_V3 = 6;
  int current_state = 0;
  void fileStateHandle(String asciiLine)
  {
    switch(current_state)
    {
      case NOTHING:
        if (asciiLine.contains("solid"))
        {
          current_state = SOLID;
        }        
        else
        {
          println("err - nothing state received line " + asciiLine); 
        }
        break;
      case SOLID:
        if (asciiLine.contains("facet normal"))
        {
          current_state = FACET_NORM;
        }
        else if (asciiLine.contains("endsolid"))
        {
          current_state = NOTHING;
        }
        else
        {
          println("err - solid state received line " + asciiLine); 
        }
        break;
      case FACET_NORM:
        if (asciiLine.contains("outer loop"))
        {
          current_state = FACET_OUTER_LOOP;
        }
        else if (asciiLine.contains("endfacet"))
        {
          current_state = SOLID;
        }
        else
        {
          println("err - facet norm state received line " + asciiLine); 
        }
        break;
      case FACET_OUTER_LOOP:
        if (asciiLine.contains("vertex"))
        {
          current_state = FACET_V1;
        }
        else
        {
          println("err - facet outer loop state received line " + asciiLine); 
        }
        break;
      case FACET_V1:
        if (asciiLine.contains("vertex"))
        {
          current_state = FACET_V2;
        }
        else
        {
          println("err - v1 state received line " + asciiLine); 
        }
        break;
      case FACET_V2:
        if (asciiLine.contains("vertex"))
        {
          current_state = FACET_V3;
        }
        else
        {
          println("err - v2 state received line " + asciiLine); 
        }
        break;
      case FACET_V3:
        if (asciiLine.contains("endloop"))
        {
          current_state = FACET_NORM;
        }
        else
        {
          println("err - v2 state received line " + asciiLine); 
        }
        break;
      default:
      println("Error!  current parse state is " + current_state);
        break;
    }
  }
  
  void draw()
  {
    beginShape(TRIANGLES);
    for(float[] v : verts)
    {
      vertex(v[0],v[1],v[2]);
    }
    endShape();
  }
}
