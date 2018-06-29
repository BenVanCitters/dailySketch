float vLen(float[] v)
{
  return sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]);
}

float[] getNormalized(float[] v)
{
  float l = vLen(v);
  
  return new float[]{v[0]/l,v[1]/l,v[2]/l};
}

void printVec(float[] v)
{
  println("[" + v[0] + "," + v[1]+ "," + v[2] + "]");
}
