void setup()
{
  size(800,800,P2D);
}

  float[] pos1={500,300};
  float[] pos2={200,200};
  
void draw()
{
  loadPixels();
  for(int i = 0; i < pixels.length; i++)
  {
    int x = i%width;
    int y = i/width;

    float[] diff = {mouseX-x,
                    mouseY-y};
    float d = dist(0,0,diff[0],
            diff[1]);
    float[] normDiff = {diff[0]/d,
                        diff[1]/d};
    float ring = gauss(d,255,150,50);//fromNormDistr(d,50,2);
    pixels[i] = color(128*(1+normDiff[0]),
                      128*(1+normDiff[1]),
                      ring);
//                      if(ring > 0.1)
//                      {
//                       println(ring); 
//                      }

  }
  updatePixels();
  
  int divs = 100;
  float wSpacing = width*1.f/divs;
  float hSpacing = height*1.f/divs;
  for(int y = 0; y < divs; y++)
  {
    for(int x = 0; x < divs; x++)
    {
      float xp = wSpacing*x;
      float yp = hSpacing*y;
      float[] diff = {mouseX-xp,
                      mouseY-yp};
       float d = dist(0,0,
                      diff[0],
                      diff[1]);
      float[] normDiff = {diff[0]/d,
                          diff[1]/d};
      float ringVal = 1-(2*gauss(d,1,150,50));
      stroke(255);
      line(xp,yp,
           xp+normDiff[0]*5*ringVal,
           yp+normDiff[1]*5*ringVal);
    }  
  }  
}

float fromNormDistr(float t, float mu, float sigma)
{
  return exp(-(t-mu)*(t-mu)/(2.f*sigma*sigma))/(sqrt(TWO_PI)*sigma*sigma);
}

//a is peak height, b peak offset from origin, c is bell width
float gauss(float t, float a, float b, float c)
{
  return a*exp(-((t-b)*(t-b))/(2*c*c));
}
