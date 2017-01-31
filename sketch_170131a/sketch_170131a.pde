void setup()
{
  size(500,500,P3D);
}

void draw()
{
  background(255);
  rotateX(.1);
  float radius = 150;
  int divs = 50;
  float radiansPerDiv = TWO_PI/divs;
  noFill();
  translate(width/2,height/2);
  beginShape();
  for(int i = 0; i< divs; i++)
  {
    float curTheta = radiansPerDiv*i;
    vertex(radius*cos(curTheta),0,radius*sin(curTheta));
  }
  endShape();
  
  beginShape();
  float startTheta = millis()/5000.f;
  
  int helixDivs = 150;
  float helixRadiansPerDiv = .01;
  float helixRadWidth = .03;
  float helixStartRad = millis()/100.f;
  
  float helixRad = 50;
  for(int i = 0; i< helixDivs; i++)
  {
    float pctThrough = i*1.f/helixDivs;
    float curCurveTheta = startTheta+helixRadiansPerDiv*i;
    float curHelixTheta = helixStartRad+helixRadWidth*i;
    float outNorm[]={cos(curCurveTheta),0,sin(curCurveTheta)};
    float upNorm[]={0,1,0};
    
    float cosCache = helixRad*cos(curHelixTheta);
    outNorm[0]*=cosCache; outNorm[1]*=cosCache; outNorm[2]*=cosCache;
    
    float sinCache = helixRad*sin(curHelixTheta);
    upNorm[0]*=sinCache; upNorm[1]*=sinCache; upNorm[2]*=sinCache;
    float[] curvePos = {radius*cos(curCurveTheta),0,radius*sin(curCurveTheta)};
    float[] helixPos = {upNorm[0]+outNorm[0],
           upNorm[1]+outNorm[1],
           upNorm[2]+outNorm[2]};
    float hOffsetNorm = dist(0,0,0
    vertex(curvePos[0]+helixPos[0],
           curvePos[1]+helixPos[1],
           curvePos[2]+helixPos[2]);
  }
  endShape();
  
}
