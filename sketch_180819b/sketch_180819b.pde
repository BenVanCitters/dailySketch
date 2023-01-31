void setup()
{
  size(600,600);
}

void draw()
{
  //fill(200,200,200,50);
  //rect(0,0,width,height);
  background(200);
  float[][] vs = new float[6][2];
  float dLen = TWO_PI/6;
  float edgeLen = 10;
  for(int i = 0; i < vs.length; i++)
  {
    vs[i][0] = edgeLen*cos(dLen*i);
    vs[i][1] = edgeLen*sin(dLen*i);
  }
  strokeWeight(2);
  drawLine(new float[]{width/2,height/2},800,vs);
}

void drawLine(float[] pos, int counts, float[][] vs)
{
  if(counts < 1)
    return;
  //get dir
  int rndIndex = (int)(noise((millis()/2000.f+counts)/7.f+millis()/200.f)*vs.length);
  float[] dir = {vs[rndIndex][0],vs[rndIndex][1]};
  //if(random(1)>.5)
  //{dir[0]*=-1; dir[1]*=-1;}
  float[] tmp = { pos[0]+dir[0],  pos[1]+dir[1]};
  line(pos[0],pos[1],tmp[0],tmp[1]);
  //ellipse(pos[0],pos[1],2,2);//tmp[0],tmp[1]);
  drawLine(tmp, counts-1, vs);
  
}
