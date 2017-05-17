void setup()
{
  size(900,900,P3D);
}

void draw()
{
  background(0);
  lights();
 ambientLight(0,0,0);
//  stroke(255);
//  strokeWeight(2);
//  noFill();
  translate(width/2,height/2);
  float tm = millis()/8000.f;
  rotateX(tm);
  rotateY(tm);
  rotateZ(tm);
  drawTorus();
}

void drawTorus()
{
  int diameterSegments = 200;
  float radius = 120*1.5; 
  float secondRad = 100*1.5;
  int secondDiamSegs = 5;
  pushMatrix();
  
  float rOffs = millis()/900.f;
  for(int i = 0; i < secondDiamSegs; i++)
  {
    float curInnerRadianPct = rOffs+i*TWO_PI/(secondDiamSegs);
    float nextInnerRadianPct =rOffs+ (i+1)*TWO_PI/(secondDiamSegs);
    beginShape(TRIANGLE_STRIP);
    for(int j = 0; j < diameterSegments; j++)
    {
//      if(random(1)>.8)
//      { 
//        stroke(255);
//        strokeWeight(2);
//        noFill();
//      }
//      else
      {
        noStroke();
        fill(100);
      }
      
//      rOffs += TWO_PI/(diameterSegments-1)
      float curOuterRadianPct = j*TWO_PI/(diameterSegments-1);
      
      float[] basePt = {radius*cos(curOuterRadianPct), 
                        radius*sin(curOuterRadianPct),0};
      float baseDist = dist(0,0,basePt[0],basePt[1]);
      float[] baseNorm = {basePt[0]/baseDist,
                          basePt[1]/baseDist};
                          
      baseNorm[0] *= secondRad; baseNorm[1] *= secondRad;
      
      float radianShift = 4*curOuterRadianPct/secondDiamSegs;
      
      float c = cos(curInnerRadianPct+radianShift);
      float s = sin(curInnerRadianPct+radianShift);
      vertex(basePt[0]+baseNorm[0]*c, 
             basePt[1]+baseNorm[1]*c, 
             basePt[2]+secondRad*s);
             
     c = cos(nextInnerRadianPct+radianShift);
     s = sin(nextInnerRadianPct+radianShift);
     vertex(basePt[0]+baseNorm[0]*c, 
             basePt[1]+baseNorm[1]*c, 
             basePt[2]+secondRad*s);
    }
  endShape();
  }
  popMatrix();
}
