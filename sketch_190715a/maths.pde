float[] crossProd(float[] a, float[] b)
{
  
  return new float[]{ a[1]*b[2]-a[2]*b[1],
                      a[2]*b[0]-a[0]*b[2],
                      a[0]*b[1]-a[1]*b[0]};
}

float[] normalized(float[] a)
{
  float d = dist(0,0,0,a[0],a[1],a[2]);
  return new float[]{a[0]/d,a[1]/d,a[2]/d};
}
