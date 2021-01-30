float[] multSV(float[] a, float b)
{
  float[] result = new float[a.length];
  for(int i = 0; i< result.length; i++)
  {
    result[i] = a[i] * b;
  }
  return result;
}

float[] addV(float[] a, float[] b)
{
  int maxL = max(a.length,b.length);
  float[] result = new float[maxL];
  for(int i = 0; i< result.length; i++)
  {
    float ai = i < a.length ? a[i] : 0;
    float bi = i < b.length ? b[i] : 0;
    result[i] = ai + bi;
  }
  return result;
}

float[] subV(float[] a, float[] b)
{
  return addV( a, multSV(b,-1));
}

float[] getNorm(float[] a)
{
  float dst = dist(0,0,0,a[0],a[1],a[2]);
  return multSV(a,1.f/dst);
}

String VtoS(float[] a)
{
  String result = "[";
  for(int i = 0; i < a.length; i++)
  {
    result = result + a[i] + ","; 
  }
  result = result + "]";
  return result;
}

void drawLineFrom(float[] start, float[]a)
{
  line(start[0],start[1],start[0]+a[0],start[1]+a[1]);
}

void drawLine(float[] a, float[]b)
{
  line(a[0],a[1],b[0],b[1]);
}

float[] zero3(){return new float[] {0,0,0};}
