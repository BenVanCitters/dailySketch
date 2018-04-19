void setup()
{
  size(500,500,P2D);
  
}

void draw()
{
  background(255);
  float tm = millis()/1000.f;
  int t = millis()/100;
  float radian = tm*0.15;
  float lineHalfLength = 45;
  float[] disp = {lineHalfLength*cos(radian),
                  lineHalfLength*sin(radian)};
  int wSteps = 99;
  int hSteps = 99;
  float wStepSz = width*1.f/wSteps;
  float hStepSz = height*1.f/hSteps;
  
  for(int i = 0; i < hSteps; i++)
  {
    pushMatrix();
    translate(0,hStepSz*(.5+i));
    for(int j = 0; j < wSteps; j++)
    {
      pushMatrix();
      translate(wStepSz*(.5+j),0);
      
      float v[] = {j/10.f, i/10.f, tm/1.5f};
      float noiseSamp = noise(v[0],v[1],v[2]);
      int index = j/3+t+i;
      stroke(255*((index+0)%3),
             255*((index+1)%3),
             255*((index+2)%3),128);
      strokeWeight(3*noiseSamp);
      line(noiseSamp*disp[0],noiseSamp*disp[1],
           noiseSamp*-disp[0],noiseSamp*-disp[1]);
      popMatrix();
    } 
   popMatrix();
  } 
}

void renderNoise()
{
  float tm = millis()/1000.f;
    loadPixels();
  for(int i = 0; i < pixels.length; i++)
  {
    int x = i%width;
    int y = i/width;
    float v[] = {x/30.f,y/30.f,tm/5.f};
    float v2[] = {x/23.f,y/19.f,-tm/7.f};
    
    float n1 = noise(v[0],v[1],v[2]);
    float n2 = noise(v2[0],v2[1],v2[2]);
    
    pixels[i] = color(256.f*n1*n2);
  }
  updatePixels();
}
