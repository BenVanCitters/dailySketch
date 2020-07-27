float[] aTimesV(float a, float[]V)
{
  float[] result = new float[V.length];
  for(int i = 0; i<V.length;i++)
  {
    result[i] = a*V[i]; 
  }
  return result;
}

//add two potentially differeing length vectors together 
float[] p1PlusP2(float[] p1,float[] p2)
{
  int maxL = max(p1.length,p2.length);
  float[] result = new float[maxL];
  for(int i = 0; i < maxL; i++)
  {
    if(i > p1.length)
    {
      result[i] = p2[i];
    }
    else if (i > p2.length)
    {
      result[i] = p1[i];
    }
    else
    {
      result[i] = p1[i]+p2[i];
    }
  }
  return result;
}

float[] bezier(float t, float[] p1,  float[] p2,  float[] p3,  float[] p4)
{
  float oneMinusT = 1-t;
  float a = oneMinusT*oneMinusT*oneMinusT;
  float b = 3*oneMinusT*oneMinusT*t;
  float c = 3*oneMinusT*t*t;
  float d = t*t*t;
  float[] result = p1PlusP2(p1PlusP2(aTimesV(a,p1),aTimesV(b,p2)) , p1PlusP2(aTimesV(c,p3), aTimesV(d,p4)));
  return result;
}
