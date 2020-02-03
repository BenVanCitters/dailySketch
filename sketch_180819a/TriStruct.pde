//repository for all points and segments - to prevent needles duplication
class SegAndPointManager
{
  float[][]points;
  //insert a point into the repo
  int addPoint(float[] pt)
  {
    return -1;
  }
  
  //find a given point in the mgr and return it's index
  int getIndexForPoint(float[] pt)
  {
  
    return -1;  
  }
  
}

//class to represent one edge of a triangle
class TriSeg
{
  int vIndex1;
  int vIndex2;
  float[][] ptr;
  TriStruct[] tris;
  
  void draw()
  {
    line(ptr[vIndex1][0],ptr[vIndex1][1],
         ptr[vIndex2][0],ptr[vIndex2][1]);
  }
  
  TriStruct[] getAttachedTriangles()
  {
    return tris;
  }
  
  float[] getPointA()
  float[] getCOmmonPointWith(TriSeg seg)
  {
    
  }
}

//class to represent a triangle
class TriStruct
{
  TriSeg segA;
  TriSeg segB;
  TriSeg segC;
  
  public TriStruct(int indexA, int indexB, int indexC)
  {
    
  }
  
  float[] getPoint(int index)
  {
    if(index == 0)
      
  }
  
  float[] baryFromCart(float[] cartXY)
  {
//    float[] barycentricFromCartesian(float[] cartXY, float[][]tripts)
//{
  //lambda1 = ((y2-y3)(x-x3)+(x3-x2)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
  //lambda2 = ((y3-y1)(x-x3)+(x1-x3)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
  //lambda3 = ((y1-y2)(x-x3)+(x2-x1)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
  //lam3 = 1-lambda1-lambda2
  float[] result = {0,0,0};
  float x1 = tripts[0][0];
  float x2 = tripts[1][0];
  float x3 = tripts[2][0];
  float y1 = tripts[0][1];
  float y2 = tripts[1][1];
  float y3 = tripts[2][1];
  float x = cartXY[0];
  float y = cartXY[1];
  float xMx3 = (x-x3);
  float x1Mx3 = (x1-x3);
  float yMy3 = (y-y3);
  float x3Mx2 = (x3-x2);
  float y2My3 = (y2-y3);
  float denom = (y2My3*x1Mx3+x3Mx2*(y1-y3));
  result[0] = (y2My3*xMx3+x3Mx2*yMy3) / denom;
  result[1] = ((y3-y1)*xMx3+x1Mx3*yMy3) / denom;
  //result[2] = ((y1-y2)*(x-x3)+(x2-x1)*(y-y3)) / ((y2-y3)*(x1-x3)+(x3-x2)*(y1-y3));//
  result[2] = 1- result[0]-result[1];
  return  result;
//}
  }
}
