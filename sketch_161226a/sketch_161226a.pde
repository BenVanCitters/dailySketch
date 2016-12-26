void setup()
{
  size(500,500);
}

void draw()
{
  
  background(0);
  int r = 5 + (int)(mouseX*50.f/width);
  int horizontalCount = width/r;
  int verticalCount = height/r;
  int count = (1+horizontalCount)*(1+verticalCount);
  for(int i = 0; i < count; i++)
  {
    
    int x = r/2 +(i*r)%width;
    int y = r/2 + r*((i*r)/width);
    fill( (( millis() +x * y ) % 1024)/4 );
    ellipse(x,y,r,r);
  }
}
