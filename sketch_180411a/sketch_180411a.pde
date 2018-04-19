void setup()
{
  size(700,700);
  daw();
}

void daw()
{
  
  background(255);
  int wCount = 40;
  int hCount = wCount;
  float w = width*1.f/wCount;
  float h=height*1.f/hCount;
  for(int i = 0; i < wCount; i++)
  {
    for(int j = 0; j < hCount; j++)
    {
      pushMatrix();
      translate(i*w,j*h);
      drawSq(w,h);
      popMatrix();
    }
  }
}

void drawSq(float w,float h)
{
  //rect(0,0,5,5);
  noFill();
  translate(w/2,h/2);
  float rCount = (int)(random(4));
  rotate(rCount*HALF_PI);
  translate(-w/2,-h/2);
  arc(0,0,w*2,h*2,0,PI/2);
  int swtch = (int)(random(2));
  switch(swtch){
    case 2:
    break;
  }
}
