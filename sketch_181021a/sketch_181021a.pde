void setup()
{
  size(500,500);
  
}

void draw()
{
  background(255);
  translate(width/2,height/2);
  drawSpiral();
}

void drawSpiral()
{
  int pCount = 10000;
  float rotations = 50;
  float finalRadius = width/2;
  noFill();
  beginShape();
  for(int i = 0; i < pCount; i++)
  {
    float pct = i*1.f/pCount;
    float curRadian = rotations *TWO_PI* pct;
    float curRadius = finalRadius * pct;
    float[] pos = { curRadius * cos(curRadian),
                    curRadius * sin(curRadian)};
    pos[0] += 2*sin(pos[1]/3); 
    pos[1] += 2*sin(pos[1]/3); 
    vertex(pos[0],pos[1]);
  }
  endShape();
}
