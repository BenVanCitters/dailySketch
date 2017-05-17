void setup()
{
  size(720,720,P3D);
}

void draw()
{
  background(0);
  directionalLight(255, 0,255,
  0, 1, -1);
  
  directionalLight(200, 0,255,
  0, -1, 0);
  float radius = 250;
//  int divs = 50;
//  float radiansPerDiv = TWO_PI/divs;
  noFill();
  translate(width/2,height/2.5);
  rotateX(-HALF_PI/3);
//  beginShape();
//  for(int i = 0; i< divs; i++)
//  {
//    float curTheta = radiansPerDiv*i;
//    vertex(radius*cos(curTheta),0,radius*sin(curTheta));
//  }
//  endShape();
  
  fill(255);
  noStroke();
  beginShape(TRIANGLE_STRIP);
  float startTheta = millis()/3000.f;
  
  int helixDivs = 600;
  float helixRadiansPerDiv = .016;//.0075 + .0025*(1+sin(millis()/2000.f))/2;;
  float helixRadWidth = .10;//.03 + .08*(1+sin(millis()/1000.f))/2;
  float helixStartRad = millis()/70.f;
  
  float helixRad = 90;
  float lastHelixPos[] = {0,0,0};
  for(int i = 0; i< helixDivs; i++)
  {
    float pctThrough = i*1.f/helixDivs;
    float curCurveTheta = startTheta+helixRadiansPerDiv*i;
    float hrw = helixRadWidth + .109*(1-(1+cos(pctThrough*PI))/2);
    float curHelixTheta = helixStartRad+hrw*i;
    float outNorm[]={cos(curCurveTheta),0,sin(curCurveTheta)};
    float upNorm[]={0,1,0};
    
    float cosCache = cos(curHelixTheta);
    outNorm = multVec(outNorm,cosCache);
    float sinCache = sin(curHelixTheta);
    upNorm = multVec(upNorm,sinCache);
    
    float[] nhelixPos = addVec(upNorm,outNorm);
    float[] helixPos = addVec(upNorm,outNorm);
    helixPos = multVec(nhelixPos,helixRad*(1-pctThrough));
    float[] curvePos = {radius*cos(curCurveTheta),
                        0,
                        radius*sin(curCurveTheta)};
    helixPos = addVec(curvePos,helixPos);  
    float helixDir[] = {helixPos[0]-lastHelixPos[0], 
                        helixPos[1]-lastHelixPos[1], 
                        helixPos[2]-lastHelixPos[2]};
    helixDir = normalize(helixDir);
    float helNorm[] = cross(helixDir,nhelixPos);
    

//    vertex(helixPos[0],
//           helixPos[1],
//           helixPos[2]);
    float[] helixPos1 = addVec(multVec(helNorm,10),helixPos);  
    vertex(helixPos1[0],
           helixPos1[1],
           helixPos1[2]);
    float[] helixPos2 = addVec(multVec(helNorm,-10),helixPos);  
    vertex(helixPos2[0],
           helixPos2[1],
           helixPos2[2]);
    lastHelixPos = helixPos;
  }
  endShape();
}

float[] normalize(float[] vec)
{
  float len = dist(0,0,0,vec[0],vec[1],vec[2]);
  return new float[]{ vec[0]/len, vec[1]/len, vec[2]/len};  
}

float[] cross(float[] a, float[] b)
{
  return new float[]{a[1]*b[2]-a[2]*b[1],
                     a[0]*b[2]-a[2]*b[0],
                     -a[1]*b[0]+a[0]*b[1] };  
}

float[] addVec(float[] a, float[] b)
{
  return new float[]{a[0]+b[0],a[1]+b[1],a[2]+b[2]};
}


float[] multVec(float[] a, float c)
{
  return new float[]{a[0]*c, a[1]*c, a[2]*c};
}
