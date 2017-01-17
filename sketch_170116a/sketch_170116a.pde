void setup()
{
  size(500, 500);
  background(0);
}

void draw()
{
  fill(0,6);
  rect(0,0,width,height);
  
  //  background(255);
  float tm = millis()/1001.f;
  float cen[] = {  
    width/2.f, height/2.f
  };

float mouseXNum = mouseX*3.f/width;
float mouseYNum = mouseY*1.f/width;
  for (int i = 0; i <18400; i++)
  {
    float initialSz = (1.f/3.f)*(width/2.f);
    float pos[] = {
      0, 0
    };
    for (int j = 1; j < 5; j++)
    {
      float period = j+mouseXNum;
      float npos[] = {
        cos(period*tm), 
        sin(period*tm)
        };
        npos[0] *= initialSz;
      npos[1] *= initialSz;
      pos[0] += npos[0]; 
      pos[1] += npos[1];
      initialSz *=mouseYNum;
    }
    int x = (int)(pos[0]+cen[0]);
    int y = (int)(pos[1]+cen[1]); 

    set(x, y, color(255, 233, 56));
    tm+=1;
  }
}

