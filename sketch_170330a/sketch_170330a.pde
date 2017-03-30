ArrayList<Spot> spots = new ArrayList<Spot>(); 
float depth = 300;
float shapeSZ[] = {300,300,300};
void setup()
{
  size(600,600,P3D);
  
  for(int i = 0; i < 550; i++)
  {
    Spot s = new Spot();
    s.pos = new float[]{random(shapeSZ[0]),random(shapeSZ[1]),random(shapeSZ[2])};
    s.c = color(random(256),random(256),random(256));
    spots.add(s);
  }
}

void draw()
{
  background(0);
  translate(width/2,height/2,depth/2);
  rotateX(millis()/1000.f);
  translate(-shapeSZ[0]/2,-shapeSZ[1]/2,-shapeSZ[2]/2);
  noFill();
  strokeWeight(15);
  int[] indecies = getStartEndIndex();
  beginShape();
  if(indecies[0] < indecies[1])
  {
    for(int i = indecies[0]; i < indecies[1]; i++)
    {
      vertForIndex(i);
    } 
  }
  else
  {
    for(int i = indecies[0]; i < spots.size(); i++)
    {
      vertForIndex(i);
    }
    for(int i = 0; i < indecies[1]; i++)
    {
      vertForIndex(i);
    }
  }
  endShape();
}

void vertForIndex(int index)
{
  Spot s = spots.get(index);
      stroke(s.c);
//    fill(s.c);
    vertex(s.pos[0],s.pos[1],s.pos[2]);
}

int[] getStartEndIndex()
{
  float secs = 10;
  float curTime = millis()/(secs*1000);
  float moddedTime = curTime % secs;
  float normedTime = moddedTime/secs; 
  int maxIndex = spots.size();
  
  return new int[]{(int)(maxIndex*normedTime), 
                   (int)(maxIndex*((normedTime + .01)%1.0))};
}


float[][] getPoints()
{
  float secs = 10;
  float curTime = millis()/(secs*1000);
  float moddedTime = curTime % secs;
  float normedTime = moddedTime/secs; 
  int maxIndex = spots.size();
   return new float[][]{};
}
