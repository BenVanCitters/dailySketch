//lloads a STL file
class BShape2
{
  ArrayList<float[]> normals = new ArrayList<float[]>();
 
  ArrayList<float[]> verts = new ArrayList<float[]>(); 
  ArrayList<int[]> tris = new ArrayList<int[]>();
  float[] minMaxXYZ = {0,0,0,0,0,0}; 
  float area = -1;
  public BShape2(String filepath)
  {
    openParseFile(filepath);
    println("Contains " + tris.size() + " triangles");
    area = getTotalSurfaceArea();
    setMinMax();
    println("total area is: " + area);
    println("minmax X:" + minMaxXYZ[0] + " - " + minMaxXYZ[1] + 
                 ", Y:" + minMaxXYZ[2] + " - " + minMaxXYZ[3] + 
                 ", Z:" + minMaxXYZ[4] + " - " + minMaxXYZ[5] );
  }
  
  public BShape2()
  {}
  
  //finds an 'axis aligned bounding box'
  void setMinMax()
  {
    minMaxXYZ = new float[] {Float.MAX_VALUE,Float.MIN_VALUE,
                             Float.MAX_VALUE,Float.MIN_VALUE,
                             Float.MAX_VALUE,Float.MIN_VALUE}; 
    for(float[] v : verts)
    {
      setMinMax(v);
    } 
  }
    //finds an aabb
  void setMinMax(float[] v)
  {
    minMaxXYZ[0] = min(v[0],minMaxXYZ[0]);
    minMaxXYZ[1] = max(v[0],minMaxXYZ[1]);
    
    minMaxXYZ[2] = min(v[1],minMaxXYZ[2]);
    minMaxXYZ[3] = max(v[1],minMaxXYZ[3]);
    
    minMaxXYZ[4] = min(v[2],minMaxXYZ[4]);
    minMaxXYZ[5] = max(v[2],minMaxXYZ[5]);
  }
  void openParseFile(String path)
  {
    int currentTriIndex = 0;
    int currentVertIndex = 0;
    current_state = 0;
    String[] lines = loadStrings(path);
    for(int i = 0; i < lines.length; i++)
    {
      //println(lines[i]);
      String line = lines[i];
      fileStateHandle(line);
      //println(current_state);
      float[] vert;
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
            vert = floatArrayFromStr(normstr[1]);
            normals.add(vert);
          }
          break;
        case FACET_OUTER_LOOP:
          break;
        case FACET_V1:
          String v1Str = line.split("vertex ")[1];
          vert = floatArrayFromStr(v1Str);
          verts.add(vert);
          currentVertIndex++;
          break;
        case FACET_V2:
          String v2Str = line.split("vertex ")[1];
          vert = floatArrayFromStr(v2Str);
          verts.add(vert);
          currentVertIndex++;
          break;
        case FACET_V3:
          String v3Str = line.split("vertex ")[1];
          vert = floatArrayFromStr(v3Str);
          verts.add(vert);          
          tris.add(new int[]{currentVertIndex-2,currentVertIndex-1,currentVertIndex});
          currentVertIndex++;
          currentTriIndex++;
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
  
  float getTotalSurfaceArea()
  {
    float totalArea = 0;
    for(int[] indxs : tris)
    {
      float[] a = verts.get(indxs[0]);
      float[] b = verts.get(indxs[1]);
      float[] c = verts.get(indxs[2]);
      totalArea += triArea(a,b,c);
    }
    return totalArea;
  }
  
  //solves triangle area via cross product
  //https://en.wikipedia.org/wiki/Triangle#Using_vectors
  float triArea(float[] v1,float[] v2,float[] v3)
  {
    float[] AB = {v2[0]-v1[0],v2[1]-v1[1],v2[2]-v1[2]};
    float[] AC = {v3[0]-v1[0],v3[1]-v1[1],v3[2]-v1[2]};
    
    float[] crossProd = crossProd(AB,AC);
    float crossLeng = vLength(crossProd);
    return crossLeng/2.f;
  }
  
  float[] crossProd(float[] v1,float[] v2)
  {
    
   return new float[]{v1[1]*v2[2] - v1[2]*v2[1],
                      v1[2]*v2[0] - v1[0]*v2[2],
                      v1[0]*v2[1] - v1[1]*v2[0]}; 
  }
  
  float vLength(float[] v1)
  {
    float l = sqrt( v1[0]*v1[0] + v1[1]*v1[1] + v1[2]*v1[2] );
    return l;
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
