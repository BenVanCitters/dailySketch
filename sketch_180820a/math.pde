float[] vec2PlusVec2(float[] a,float[] b)
{
  return new float[]{a[0]+b[0],a[1]+b[1]};
}
float[] vec2MinusVec2(float[] a,float[] b)
{
  return new float[]{a[0]-b[0],a[1]-b[1]};
}

float[] vec2TimesFloat(float[] a,float b)
{
  return new float[]{a[0]*b,a[1]*b};
}

float[] vec2Norm(float[] a)
{
  float l = 1.f/dist(0,0,a[0],a[1]);
  return vec2TimesFloat(a,l);
}
void printV2(float[] v)
{
  println("<" + v[0] + "," + v[1] + "," + ">");
}