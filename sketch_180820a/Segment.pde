

class Segment
{
  float[] a,b;
  private Triangle[] tris = new Triangle[2];
  
  public Segment(float[] pt1, float[] pt2)
  {
    a = pt1;b=pt2;
  }
  
  void draw()
  {
    line(a[0],a[1],b[0],b[1]);
  }
  
  void addTriangle(Triangle t)
  {
    tris[1] = tris[0];
    tris[0] = t;
  }

  Triangle getOtherTriangle(Triangle t)
  {
    if(t.equals(tris[0]))
    {
      return tris[1];
    }
    else if(t.equals(tris[1]))
    {
      return tris[0];
    }
  
    return null;  
  }
  
  //add vectors and average
  float[] getCenter()
  {
    float[] result = {a[0]+b[0],
                      a[1]+b[1]};
    result[0]/=2.f;
    result[1]/=2.f;
    return result;
  }
  
  //gets the common point (float[]) between two segments
  //or returns null if there is no common point
  float[] getCommon(Segment other)
  {
    //println(a[0] +"," + a[1] +" aaa " + other.a[0] + "," + other.a[1]);
    //println(b[0] +"," + b[1] +" bbb " + other.b[0] + "," + other.b[1]);
    if( a[0] == other.a[0] && a[1] == other.a[1] ) {
      return a;
    }
    if( a[0] == other.b[0] && a[1] == other.b[1] ) {
      return a;
    }
    if( b[0] == other.a[0] && b[1] == other.a[1] ) {
      return b;
    }
    if( b[0] == other.b[0] && b[1] == other.b[1] ){
      return b;
    }
    //no match found
    return null;
  }
}