PGraphics p;
void setup()
{
  size(700,700, P3D);
  p = createGraphics(width,height,P3D);
}

void draw()
{
  clear();
  lights();
  float tm = millis()/1000.f;
  drawStripes(tm);
  drawGeo(tm);
}

void drawGeo(float tm)
{
  pushMatrix();
  translate(width/2, height/2);
  rotateX(tm*.1);
  rotateY(tm*.3);
  rotateZ(tm*.5);
  int w = 50;
  int h = 70;
  for(int i = 0; i < h; i++)
  {
    noStroke();
//    noFill();
//    stroke(255);
    beginShape(TRIANGLE_STRIP);
    texture(p);
    textureMode(NORMAL);
    for(int j = 0; j < w; j++)
    {
      float xpct = j*1.f/(w-1);
      float ypct = i*1.f/(h);
      float[] vert = getVertForNormXY(xpct,ypct,tm);
      vertex(vert[0],vert[1],vert[2]
              ,xpct,ypct
              );
              
      ypct = (i+1)*1.f/(h);
      vert = getVertForNormXY(xpct,ypct,tm);
      vertex(vert[0],vert[1],vert[2]
              ,xpct,ypct
              );
    }
    endShape();
  }
  popMatrix();
}

float[] getVertForNormXY(float xpct, float ypct, float tm)
{
  float tubePct = (1+sin(3+tm*.2345))/2.f;
//  float wrapPct = (1+sin(tm/6.7))/2.f;
  float[] tubePos = {0,0,0};
  float[] wrapPos = {0,0,0};
  
  float outerRadius = 200;
  float donutRadius = 100;
  
  float innerRadian = xpct*TWO_PI;
  float outerRadian = ypct*TWO_PI;
  float[] torusNormal = {cos(innerRadian),sin(innerRadian),0};
  float[] up = {0,0,1};
  float cosO = cos(outerRadian);
  float sinO = sin(outerRadian);
  
  float[] torusWrap = new float[]{donutRadius*torusNormal[0]*cosO + donutRadius*up[0]*sinO,
                                  donutRadius*torusNormal[1]*cosO + donutRadius*up[1]*sinO,
                                  donutRadius*torusNormal[2]*cosO + donutRadius*up[2]*sinO};
  torusWrap[0]+= torusNormal[0]*outerRadius;
  torusWrap[1]+= torusNormal[1]*outerRadius;
  torusWrap[2]+= torusNormal[2]*outerRadius;
  
  float[] planePos = {(xpct-.5)*width,
                      (ypct-.5)*height,
                      0};
  float anttubePct = 1-tubePct;
  return new float[] {tubePct*torusWrap[0] + anttubePct*planePos[0],
                      tubePct*torusWrap[1] + anttubePct*planePos[1],
                      tubePct*torusWrap[2] + anttubePct*planePos[2]};
//return new float[] {xpct*width,
//                      ypct*height,
//                      70*(mouseX*1.f/width)*sin(5* tm + 10*(xpct+ypct))};
}

void drawStripes(float tm)
{
  p.beginDraw();
  p.colorMode(HSB, 256);
  p.clear();
  p.translate(p.width/2,p.height/2);
  p.rotate(tm*.6);
  int halfCount = 10;
  float spacing = 1.8*p.width/(halfCount*2.f);
  
  for(int i = -halfCount; i < halfCount; i++)
  {
    p.pushMatrix();
    p.translate(0,0);
//    float pct = (i+halfCount)*1.f/(halfCount*2);
//    p.fill(256*pct,256,256);
    float tOffs = (15*tm)%spacing;
    float xpos = tOffs + i*spacing+5;
    float ht = p.height*3; 
    p.rect(xpos,-ht/2,spacing*.5,ht);
    p.popMatrix();  
  }
  p.endDraw();
}