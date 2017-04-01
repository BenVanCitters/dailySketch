class SpotCollection
{
  ArrayList<Spot> spots = new ArrayList<Spot>(); 
  float shapeSZ[] = {300,300,300};
float strokeW = 25;
  SpotCollection(int count, float[] sz)
  {
    shapeSZ[0] = sz[0]; shapeSZ[1] = sz[1];shapeSZ[2] = sz[2];
    addPoints(count);
  }
  
  void addPoints(int count)
  {
    for(int i = 0; i < count; i++)
    {
      Spot s = new Spot();
      s.pos = new float[]{random(shapeSZ[0]),random(shapeSZ[1]),random(shapeSZ[2])};
      s.c = color(random(256),random(256),random(256));
      spots.add(s);
    } 
  }
  
  void draw(float tm, int divs, float pct)
  {
    pushMatrix();
     
    rotateX(tm);
    translate(-shapeSZ[0]/2,-shapeSZ[1]/2,-shapeSZ[2]/2);
    noFill();
    strokeWeight(strokeW);
  
    float strokeLen = pct/divs;
    float strokeBlank = .001;
    for(int i = 0; i < divs; i++)
    {
      float start = i*strokeLen;
      float end = (i+1)*strokeLen - strokeBlank;
      ArrayList<Spot> points = getPoints(60, 
                                         new float[]{start,end},
                                         tm/4);
      drawPoints(points);
    }
    popMatrix();
  }
  
  void drawPoints(ArrayList<Spot> points)
  {
    beginShape();
    for(Spot s : points)
    {
      vertForSpot(s);
    }
    endShape();
  }
  
  void vertForSpot(Spot s)
  {
    stroke(s.c);
    vertex(s.pos[0],s.pos[1],s.pos[2]);
  }

  ArrayList<Spot> getPoints(int count, float[] offsets, float tm)
  {
    float secs = 10;
    float curTime = tm/secs;
    float moddedTime = curTime % secs;
    float normedStartT = (moddedTime+ offsets[0])/secs;
    float normedEndT = (moddedTime+ offsets[1])/secs; 
   
    int maxIndex = spots.size();
    
    float tDiff = (normedEndT-normedStartT)/count;
  //  println("tDiff: " + tDiff);
    ArrayList<Spot> result = new ArrayList<Spot>();
    for(int i = 0; i < count; i++)
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
}
