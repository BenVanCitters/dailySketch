void setup()
{
  size(500,500);
}

void draw()
{
  float tm = millis()/1000.f;
  float r = .4+.35*sin(tm*.3+1);
  float g = .5-.45*sin(tm*.5+2);
  float b = .3-.21*sin(tm*-.4+3);
  loadPixels();
  for(int i = 0; i < pixels.length; i++)
  {
    int x = i%width;
    int y = i/width;
    float ypct = y*1.f/height;
    
    int c = color(sin(tm*.03+(ypct*r)*PI)*255, 
                  sin(tm*.04+(ypct*g)*PI)*255,
                  sin(tm*.06+(ypct*b)*PI)*255);
    pixels[i] = c;
  }
  updatePixels();
}
