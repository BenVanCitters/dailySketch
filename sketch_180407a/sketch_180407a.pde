
void setup()
{
  size(700,700);
}

void draw()
{
  newD();
}

void newD()
{
  background(255);
  noFill();
  strokeWeight(2);
  beginShape();
  
  float tm = millis()/1000.f;
  
  float[] pos = {width/2.f,height/2.f};
  float[] center = {width/2.f,height/2.f};
  float curRadian = tm/7;
  float radianArcLen = 3;
  float radius = 50;
  //pos = circ( radius, pos, center, curRadian, radianArcLen);
  float arcLenMult = 1;
  
  int count = 50;
  for(int i = 0; i < count; i++)
  {
    float pct = i*1.f/count;
    radius = 60*(1+sin(pct*4+tm/1))/2;;//20*(50-i)/50;//5+(25)*noise(tm/4,i);//(1+sin(i+tm/5))/2;
    curRadian += radianArcLen;

    arcLenMult *= -1;
    radianArcLen = arcLenMult*(6)*noise(pct*100+tm/5);//(1+sin(pct*TWO_PI+tm/3))/2;
    center = new float[]{pos[0] + radius*cos(curRadian),
                         pos[1] + radius*sin(curRadian),};
    curRadian += PI;
    
    pos = circ( radius, pos, center, curRadian, radianArcLen);
  }
  
  endShape();
}
float[] circ( float radius, float[] startpos, float[] center, float curRadian, float radianArcLen)
{
  int cPoints = 100;
  float startingRadian = 0;
  float radianDiv = radianArcLen/cPoints;
  for(int i = 0; i < cPoints; i++)
  {
    float[] pt = {center[0]+radius*cos(startingRadian+curRadian),
                  center[1]+radius*sin(startingRadian+curRadian)};
    curRadian+=radianDiv;
    vertex(pt[0],pt[1]);
    startpos = pt;
  } 
  return startpos;
}
