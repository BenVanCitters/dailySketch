Triangle t1,t2,t3,t4;
void setup()
{
  size(700,600);
  setupTris();
}


  ArrayList<Triangle> tris = new ArrayList<Triangle>();
void setupTris()
{
  float[][] spacings= getGridSpacings(100,-HALF_PI);
  
  int wt = 10;
  int ht = 10;
  float[][] pts = new float[wt*ht][2];
  //create points
  for(int j = 0; j < ht; j++)
  {
    for(int i = 0; i < wt; i++)
    {
      pts[i+j*ht] = vec2PlusVec2(vec2TimesFloat(spacings[0],i),
                                 vec2TimesFloat(spacings[1],j));
                                 printV2(pts[i+j*wt]);
    } 
  }
  
  Segment[] topSegs = new Segment[wt];
  Segment lastSeg = null;
  for(int j = 0; j < ht-1; j++)
  {
    for(int i = 0; i < wt-1; i++)
    {
      int index1 = i+j*wt;
      int index2 = i+1+j*wt;
      int index3 = i+(j+1)*wt;
      int index4 = i+1+(j+1)*wt;
      
      Segment a = new Segment(pts[index1],pts[index4]);
      Segment b = new Segment(pts[index3],pts[index4]);
      Segment c;
      if(i < 1)
        c = new Segment(pts[index1],pts[index3]);
      else 
        c = lastSeg; 
      Segment d;
      if(j < 1)
        d = new Segment(pts[index1],pts[index2]);
      else
        d = topSegs[i];
      
      Segment e = new Segment(pts[index2],pts[index4]);
      
      /// tri stuff
      tris.add(new Triangle(c,a,b));
      tris.add(new Triangle(a,d,e));
      /// end tri stuff
      lastSeg = e;
      topSegs[i] = b;
    } 
  }
  Triangle firstT = tris.get(0);
  firstT.pairSegmentWithSide(firstT.a,0);
  
  float[] p1 = {450,100};
  float[] p2 = {350,300};
  float[] p3 = {550,300};
  float[] p4 = {250,500};
  float[] p5 = {450,500};
  float[] p6 = {650,500};
  Segment a = new Segment(p2,p1);
  Segment b = new Segment(p1,p3);
  Segment c = new Segment(p3,p2);
  Segment d = new Segment(p3,p5);
  Segment e = new Segment(p5,p2);
  Segment f = new Segment(p5,p4);
  Segment g = new Segment(p4,p2);
  Segment h = new Segment(p3,p6);
  Segment i = new Segment(p5,p6);
  
  t1 = new Triangle(a,b,c);
  t2 = new Triangle(e,f,g);
  t3 = new Triangle(c,d,e);
  t4 = new Triangle(d,h,i);
  t1.pairSegmentWithSide(c,0);
  //t2.pairSegmentWithSide(e,2);
  //t4.pairSegmentWithSide(d,1);
}

void draw()
{
  for(Triangle t : tris)
  {
    setColorForTri(t);
  t.draw();
  }
  
  //setColorForTri(t1);
  //t1.draw();
  //setColorForTri(t2);
  //t2.draw();
  //setColorForTri(t3);
  //t3.draw();
  //setColorForTri(t4);
  //t4.draw();
  
  float[] curBary = getCurTriBary();
  if(curBary != null)
  {
    for(Triangle t : tris)
    {
      float[] pos = t.baryToCart(curBary);
      brush(pos);
    }
    //float[] pos = t1.baryToCart(curBary);
    //brush(pos);
    //pos = t2.baryToCart(curBary);
    //brush(pos);
    //pos = t3.baryToCart(curBary);
    //brush(pos);
    //pos = t4.baryToCart(curBary);
    //brush(pos);
  }
}

void brush(float[] pos)
{
  fill(0);
  stroke(0);
  ellipse(pos[0],pos[1],2,2);
}

void setColorForTri(Triangle t)
{
    float[] mxy = {mouseX,mouseY};
  float[] bpt;
  //float sum = bpt[0]+ bpt[1]+ bpt[2];
  //String s = "b<"+bpt[0]+",\n"+bpt[1]+",\n" +bpt[2]+"> sum: " + sum; 
  //if(bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
  //{ 
  //  stroke(0,200,0);
  //}
  //else
  //{
  //  stroke(200);
  //}
  //ellipse(mxy[0],mxy[1],5,5);
  //noFill();
  bpt = t.barycentricFromCartesian(mxy);
  if(bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
  { 
    stroke(0,200,0);
    fill(0,200,0);
  }
  else
  {
    stroke(170);
    fill(170);
  }
}

float[] getCurTriBary()
{
  float[] mxy = {mouseX,mouseY};
  float[] bpt;
  for(Triangle t : tris)
  {
     bpt = t.barycentricFromCartesian(mxy);
    if(bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
    {
      return bpt;
    }
  }
  return null;
  //bpt = t1.barycentricFromCartesian(mxy);
  //if(bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
  //{
  //  return bpt;
  //}
  //  bpt = t2.barycentricFromCartesian(mxy);
  //if(bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
  //{
  //  return bpt;
  //}
  //  bpt = t3.barycentricFromCartesian(mxy);
  //if(bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
  //{
  //  return bpt;
  //}
  //  bpt = t4.barycentricFromCartesian(mxy);
  //if(bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
  //{
  //  return bpt;
  //}
  //return null;
}

float[][] getGridSpacings(float radius, float radianOffset)
{
  float r = 0;
  float[] p0 = {radius*cos(radianOffset+r),radius*sin(radianOffset+r)};
  r+=TWO_PI/3.f;
  float[] p1 = {radius*cos(radianOffset+r),radius*sin(radianOffset+r)};
  r+=TWO_PI/3.f;
  float[] p2 = {radius*cos(radianOffset+r),radius*sin(radianOffset+r)};
  //1-0
  
  //2-0
  return new float[][]{vec2MinusVec2(p1,p0),vec2MinusVec2(p2,p0)};
}