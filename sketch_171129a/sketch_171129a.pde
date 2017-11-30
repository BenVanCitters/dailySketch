void setup()
{
  size(500,500,P2D);
}

void draw()
{
//  fill(255,255,255,10);
//  rect(0,0,width,height);
  background(255);
  float[] startpt = {width/2,height/2};
  float curRad = 0;
  float curDist = .01;
  int sz = 1000;
  float t = millis()/1000.f;
  float lenModulator = (1+sin(2+t*.00002))/2.f;
  float radModulator = (1+sin(11+t*.041))/2.f;
  
  strokeWeight(1);
  for(int i = 0; i < sz; i++)
  {
    float dir[] = {cos(curRad),
                   sin(curRad)};
    float[] e = {startpt[0]+curDist*dir[0],
                 startpt[1]+curDist*dir[1]};
    line(startpt[0],startpt[1],
         e[0],e[1]);    
    
    startpt[0] = e[0];
    startpt[1] = e[1];
    curRad += PI/2.f * (.6+radModulator);
    curDist *= 1+.03*lenModulator;
  }
}
