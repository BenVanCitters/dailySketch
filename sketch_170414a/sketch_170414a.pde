int arcCount = 90; 
ConcArc concs[] = new ConcArc[arcCount];
float arcWidth = 30;
int maxArcRings = 30;
void setup()
{
  size(displayWidth,displayHeight,P3D);
  for(int i = 0; i < arcCount; i++)
  {
    int szMult = 1+(int)random(maxArcRings);
    concs[i] = new ConcArc();
    concs[i].arcRadius = szMult*arcWidth;
    concs[i].radianSpan = .1+random(4*PI/5);
    concs[i].rotSpeed = random(-.4,.4);
    concs[i].thickness = arcWidth;
    concs[i].rotOffset = random(TWO_PI);
  }
}

void draw()
{
  background(0);
  float tm = millis()/1000.f;
  noFill();
  stroke(255);
  translate(width/2.f,height/2.f);
//  strokeWeight(arcWidth/2 + 1.5);
//  strokeCap(PROJECT);
  for(int i = 0; i < concs.length; i++)
  {
    float radStart = concs[i].rotOffset + concs[i].rotSpeed*tm;
//    arc(0, 0, 
//    concs[i].arcRadius, concs[i].arcRadius, 
//    radStart, 
//    radStart+concs[i].radianSpan );
    
    myDrawArc(concs[i].arcRadius, 
    arcWidth + 1.5, 
    radStart, 
    radStart+concs[i].radianSpan);
  }
}

void myDrawArc(float radius, float strokeWeight, float radStart, float radEnd)
{
//  stroke(255);
noStroke();
  fill(255);
  int pointCount = (mouseX*25)/width;
  float radianDiff = (radEnd-radStart)/pointCount;
  float innerRadius = radius-strokeWeight/2.f;
  float outerRadius = radius+strokeWeight/2.f;
  beginShape(TRIANGLE_STRIP);
  for(int i =0; i < pointCount+1; i++)
  {
    float curRadian = radStart+radianDiff*i;
    float[] pos = new float[]{cos(curRadian),sin(curRadian)};
    vertex(outerRadius*pos[0],outerRadius*pos[1]);
    vertex(innerRadius*pos[0],innerRadius*pos[1]);
  }
  endShape();
}
