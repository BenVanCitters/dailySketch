CircSeg[] segs = new CircSeg[500];
void setup()
{
  size(500,500);
  for(int i = 0; i < segs.length; i++)
  {
    float pctComplete = i*1.f/segs.length;
    segs[i] = new CircSeg();
    segs[i].targetVal = 100;
    segs[i].speedConst = .1+.05* sin(4*pctComplete*TWO_PI);
  }
}

void draw()
{
  background(0);
  
  int curIndex = mouseX*segs.length/width;//(int)((millis()/17001.f) * segs.length) % segs.length;
  segs[curIndex].curVel += 30;//+30*sin(millis()/2000.f);
  
  //nearby segment reaction
  float sprAmnt = mouseY*1.f/height;
  for(int i = 0; i < segs.length; i++)
  {
    //spring with next
    int nextIndex = (i+1)%segs.length;
    float nDiff = segs[nextIndex].curVal - segs[i].curVal;
    nDiff*=sprAmnt;
    segs[i].curVel += nDiff;
    
    //spring with prev
    int prevIndex = (segs.length+i-1)%segs.length;
    float pDiff = segs[prevIndex].curVal - segs[i].curVal;
    pDiff*=sprAmnt;
    segs[i].curVel += pDiff;
  }
  //initial spring reaction
  for(int i = 0; i < segs.length; i++)
  {
    segs[i].update();
  }
  

  
  noFill();
  stroke(255);
  pushMatrix();
  translate(width/2,height/2);
  beginShape();
  float radDiv = TWO_PI/ segs.length;
  for(int i = 0; i < segs.length; i++)
  {
    vertex(segs[i].curVal*cos(radDiv*i), 
           segs[i].curVal*sin(radDiv*i));
  }
  endShape();
  popMatrix();
}

void mouseClicked()
{
  //  
  for(int i = 0; i < segs.length; i++)
  {
    segs[i].curVel += 50;
  }
}
