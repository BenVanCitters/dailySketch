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

  ArrayList<Spot> points = getPoints();
  stroke(255);
  beginShape();
  for(Spot s : points)
  {
    vertForSpot(s);
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

void vertForSpot(Spot s)
{
  stroke(s.c);
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

ArrayList<Spot> getPoints()
{
  float secs = 10;
  float curTime = millis()/(secs*1000);
  float moddedTime = curTime % secs;
  float normedStartT = moddedTime/secs;
  float normedEndT = (moddedTime+.1)/secs; 
 
  int maxIndex = spots.size();
  
  int resultSize = 200;
  float tDiff = (normedEndT-normedStartT)/resultSize;
//  println("tDiff: " + tDiff);
  ArrayList<Spot> result = new ArrayList<Spot>();
  for(int i = 0; i < resultSize; i++)
  {
     result.add(getSpotForT(normedStartT + tDiff*i));
  }
//  println("sz: " + result.length);
  return result;
}

Spot getSpotForT(float t)
{
  t = t % 1.f;
  int startIndex = (int)(t*spots.size());
  int endIndex = (startIndex + 1) % spots.size();
 
  float startPct = startIndex*1.f/ spots.size();
  float endPct = endIndex*1.f/ spots.size();
  float pctDiff = 1.f/ spots.size();
  float interT = (t - startPct)/pctDiff;

  float[] startPos = spots.get(startIndex).pos;

  float[] endPos = spots.get(endIndex).pos;

  float[] diff = new float[]{endPos[0]-startPos[0],
                             endPos[1]-startPos[1],
                             endPos[2]-startPos[2]};
  Spot result = new Spot();
  result.pos = new float[] {diff[0]*interT+startPos[0],
                                diff[1]*interT+startPos[1],
                                diff[2]*interT+startPos[2]};
  result.c = lerpColor(spots.get(startIndex).c,
                       spots.get(endIndex).c,
                       interT);
  return result;  
}

void printPos(float[] pos)
{
  println("pos: [" +pos[0]+ "," + pos[1]+ "," + pos[2] + "]");
}
