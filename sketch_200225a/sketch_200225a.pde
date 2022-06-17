import java.lang.Math; 

void setup()
{
  size(1000, 1000, P3D);
  Math.cosh(2);
}

void draw()
{
  int tcount = 10;
  int ccount = 10;
  int n = 100;
  for (int t = 0; t < tcount; t++)
  {
    float theta = t*1.f/tcount;
    for (int c = 0; c < ccount; c++)
    {
      float xi = c*1.f/ccount;
      Complex z = new Complex(xi);
      z = z.Iz(z);
      z.add(new Complex(theta));
      for (int k1 = 0; k1 < n; k1++)
      {
        for (int k2 = 0; k2 < n; k2++)
        {
          float k1t = k1*2*PI/n;
          float k2t = k2*2*PI/n;
          Complex z1;// = (k1*2*PI)*i/n)*cosh(z).^(2/n);
        }
      }
    }
  }
}
