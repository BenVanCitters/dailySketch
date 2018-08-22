class Triangle
{
  Segment a,b,c;
  boolean aligned = false; //whether the alignment has been run yet
  float[]p1,p2,p3;
  public Triangle(float[] pt1, float[]pt2, float[]pt3)
  {
    a = new Segment(pt1,pt2);
    b = new Segment(pt2,pt3);
    c = new Segment(pt3,pt1);
    a.addTriangle(this);
    b.addTriangle(this);
    c.addTriangle(this);
    p1=pt1; p2=pt2; p3=pt3;
  }
  
  public Triangle(Segment s1, Segment s2, Segment s3)
  {
    a = s1; a.addTriangle(this);
    b = s2; b.addTriangle(this);
    c = s3; c.addTriangle(this);
    p1=a.getCommon(b); p2=b.getCommon(c); p3=c.getCommon(a);
  }
  
  void pairNeighbors()
  {
    aligned = true;
    Triangle t1 = a.getOtherTriangle(this);
    t1.pairSegmentWithSide(a, 0);
    Triangle t2 = b.getOtherTriangle(this);
    t2.pairSegmentWithSide(b,1);
    Triangle t3 = c.getOtherTriangle(this);
    t3.pairSegmentWithSide(c,2);
  }
  
  //recursive method to align all trianlgess with a rule
  void pairSegmentWithSide(Segment s, int side)
  {
    if(aligned)
      return;
      
    aligned = true;
    Segment[] tmp = {a,b,c};
    if(side == 0)
    {
      if(s == a)
      {
        a = tmp[2];
        b = tmp[0];
        c = tmp[1];

      }
      if(s == c)
      {
        a = tmp[1];
        b = tmp[2];
        c = tmp[0];       
      }
    }
    if(side == 1)
    {
      if(s == b)
      {
        a = tmp[1];
        b = tmp[2];
        c = tmp[0];
      }
      if(s == c)
      {
        a = tmp[2];
        b = tmp[0];
        c = tmp[1];
      }
    }
    if(side == 2)
    {
      if(s == b)
      {
        a = tmp[2];
        b = tmp[0];
        c = tmp[1];
      }
      if(s == a)
      {
        a = tmp[1];
        b = tmp[2];
        c = tmp[0];
      }
    }
    p1=a.getCommon(b); p2=b.getCommon(c); p3=c.getCommon(a);
    
    Triangle t1 = a.getOtherTriangle(this);
    if(t1!=null)
      t1.pairSegmentWithSide(a,0);
    
    Triangle t2 = b.getOtherTriangle(this);
    if(t2!=null)
      t2.pairSegmentWithSide(b,1);
    
    Triangle t3 = c.getOtherTriangle(this);
    if(t3!=null)
      t3.pairSegmentWithSide(c,2);
  }
  
  void draw()
  {
    triangle(p1[0],p1[1],p2[0],p2[1],p3[0],p3[1]);
    drawSegments();
  }
  
  void drawSegments()
  {
    float[] cen = getCenter();
    pushStyle();
    strokeWeight(2);
    stroke(255,0,0);
    drawSeg(a,cen);//    a.draw();
    stroke(0,255,0);
    drawSeg(b,cen);//b.draw();
    stroke(0,0,255);
    drawSeg(c,cen);//c.draw();
    popStyle();
  }
  //do some goofy math to offset from edge
  void drawSeg(Segment s,float[] center)
  {
    float[] sCen = s.getCenter();
    float[] c = vec2TimesFloat(center,-1);
    sCen = vec2PlusVec2(c,sCen);
    sCen = vec2Norm(sCen);
    sCen = vec2TimesFloat(sCen,-5);
    pushMatrix();
    //scale(.9);
    translate(sCen[0],sCen[1]);
    
    s.draw();
    popMatrix();
  }
  //add vectors and average
  float[] getCenter()
  {
    float[] result = {p1[0]+p2[0]+p3[0],
                      p1[1]+p2[1]+p3[1]};
    result[0]/=3.f;
    result[1]/=3.f;
    return result;
  }
  
  float[] barycentricFromCartesian(float[] cartXY)
  {
    //lambda1 = ((y2-y3)(x-x3)+(x3-x2)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
    //lambda2 = ((y3-y1)(x-x3)+(x1-x3)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
    //lambda3 = ((y1-y2)(x-x3)+(x2-x1)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
    //lam3 = 1-lambda1-lambda2
    float[] result = {0,0,0};
    float x1 = p1[0];
    float x2 = p2[0];
    float x3 = p3[0];
    float y1 = p1[1];
    float y2 = p2[1];
    float y3 = p3[1];
    float x = cartXY[0];
    float y = cartXY[1];
    float xMx3 = (x-x3);
    float x1Mx3 = (x1-x3);
    float yMy3 = (y-y3);
    float x3Mx2 = (x3-x2);
    float y2My3 = (y2-y3);
    float denom = (y2My3*x1Mx3+x3Mx2*(y1-y3));
    result[0] = (y2My3*xMx3+x3Mx2*yMy3) / denom;
    result[1] = ((y3-y1)*xMx3+x1Mx3*yMy3) / denom;
    //result[2] = ((y1-y2)*(x-x3)+(x2-x1)*(y-y3)) / ((y2-y3)*(x1-x3)+(x3-x2)*(y1-y3));//
    result[2] = 1- result[0]-result[1];
    return  result;
  }
  
  float[] baryToCart(float[] bary)
  {
    float[] result={0,0};
    result[0] = bary[0]*p1[0]+bary[1]*p2[0]+bary[2]*p3[0];
    result[1] = bary[0]*p1[1]+bary[1]*p2[1]+bary[2]*p3[1];
    
    return result;
  }

  boolean equals(Triangle t)
  {
    return (p1[0] == t.p1[0] &&
           p1[1] == t.p1[1]) &&
           (p2[0] == t.p2[0] &&
           p2[1] == t.p2[1]) &&
           (p3[0] == t.p3[0] &&
           p3[1] == t.p3[1]);
  }
}
