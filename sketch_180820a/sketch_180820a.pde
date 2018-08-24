import processing.pdf.*;

void setup()
{
  size(1500, 1500);
  //beginRecord(PDF, "everythindg.pdf");
  setupTris();
}


ArrayList<Triangle> tris = new ArrayList<Triangle>();
void setupTris()
{
  float[][] spacings= getGridSpacings(200, -HALF_PI);
  printV2(spacings[0]);
  printV2(spacings[1]);
  int wt = 10;
  int ht = 10;
  float[][] pts = new float[wt*ht][2];
  //create points
  for (int j = 0; j < ht; j++)
  {
    for (int i = 0; i < wt; i++)
    {
      pts[i+j*ht] = vec2PlusVec2(vec2TimesFloat(spacings[0], i), 
        vec2TimesFloat(spacings[1], j));
      //printV2(pts[i+j*wt]);
      pts[i+j*ht][0]+=width/2;
      pts[i+j*ht][1]+=-1500;
    }
  }

  Segment[] topSegs = new Segment[wt];
  Segment lastSeg = null;
  //build triangles and segments
  for (int j = 0; j < ht-1; j++)
  {
    for (int i = 0; i < wt-1; i++)
    {
      int index1 = i+j*wt;
      int index2 = i+1+j*wt;
      int index3 = i+(j+1)*wt;
      int index4 = i+1+(j+1)*wt;

      Segment a = new Segment(pts[index2], pts[index3]);
      Segment b = new Segment(pts[index3], pts[index4]);
      Segment c;
      if (i < 1)
        c = new Segment(pts[index1], pts[index3]);
      else 
      c = lastSeg; 
      Segment d;
      if (j < 1)
        d = new Segment(pts[index1], pts[index2]);
      else
        d = topSegs[i];

      Segment e = new Segment(pts[index2], pts[index4]);

      /// tri stuff
      tris.add(new Triangle(c, d, a));
      tris.add(new Triangle(a, e, b));
      /// end tri stuff
      lastSeg = e;
      topSegs[i] = b;
    }
  }
  Triangle firstT = tris.get(0);
  firstT.pairSegmentWithSide(firstT.a, 0);
}

float[] lastBary = null;
Triangle lastTri = null;

Triangle currentTri = null;
void draw()
{
  if (mouseButton == RIGHT)
  {
    background(200);
  }
  //for (Triangle t : tris)
  //{
  //  setColorForTri(t);
  //  t.draw();
  //}

  //a little line correction for edges
  float[] curBary = getCurTriBary();
  float[] bpt = null;
  float[] zerocrosspt = null;
  float[] zeroCrossCart = null;
  boolean zeroCross = false;

  if (curBary != null)
  {
    if (mouseButton == LEFT)
    {
      if (lastTri != null)
      {
        bpt = lastTri.barycentricFromCartesian(new float[]{mouseX, mouseY});
        float[] baryDiff = null;
        if (lastBary != null)
        {
          baryDiff = vec3MinusVec3(bpt,lastBary);
        }
        float pct = 1;
        for (int i = 0; i < 3; i++)
        {
          if (bpt[i] <0)
          {
            zeroCross = true;
            println("lastBary");
            printV3(lastBary);
            println("bpt"  );
            printV3(bpt);
            //print(bpt);
            float p =  lastBary[i]/abs(baryDiff[i]);
            pct = min(pct, p);
            println("pct " + pct);
            float t = baryDiff[i]*pct+lastBary[i];
            println("t: " + t);
          }
        }
        if (zeroCross)
        {
          println("baryDiff");
          printV3(baryDiff);
          zerocrosspt = vec3TimesFloat(baryDiff, pct);
          zerocrosspt = vec3PlusVec3(zerocrosspt, lastBary);
          
          //printV2(zerocrosspt);
        }
      }


      for (Triangle t : tris)
      {
        float[] pos = t.baryToCart(curBary);

        float[] lpos = pos;
        if (lastBary != null)
          lpos = t.baryToCart(lastBary);
        if (zeroCross)
        {
          //print("sdlkfjsdl");
          zeroCrossCart = t.baryToCart(zerocrosspt);
          
          brush(zeroCrossCart,lpos,curColor);
          //brush(pos,zeroCrossCart,curColor);
        } else
        {
          brush(pos, lpos, curColor);
        }
      }
      lastBary = curBary;
    } else
    {
      curColor = color(255, 0, 0);
      lastBary = null;
    }
  }
  lastTri = currentTri;
}
int curColor = color(random(256), random(256), random(256));
void brush(float[] pos, float[] lpos, int c)
{
  fill(c);
  stroke(c);
  //if(lpos != null)
  //{
  line(pos[0], pos[1], lpos[0], lpos[1]);
  //}
  //else
  //{  
  //  //point(pos[0],pos[1]);
  //  //ellipse(pos[0],pos[1],2,2);
  //}
}

void setColorForTri(Triangle t)
{
  float[] mxy = {mouseX, mouseY};
  float[] bpt;

  bpt = t.barycentricFromCartesian(mxy);
  if (bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
  { 
    stroke(0, 200, 0);
    fill(0, 200, 0);
  } else
  {
    stroke(170);
    fill(170);
  }
}

float[] getCurTriBary()
{
  float[] mxy = {mouseX, mouseY};
  float[] bpt;
  for (Triangle t : tris)
  {
    bpt = t.barycentricFromCartesian(mxy);
    if (bpt[0] > 0 && bpt[1] > 0 && bpt[2] > 0)
    {
      currentTri = t;
      return bpt;
    }
  }
  return null;
}


float[][] getGridSpacings(float radius, float radianOffset)
{
  float r = 0;
  float[] p0 = {radius*cos(radianOffset+r), radius*sin(radianOffset+r)};
  r+=TWO_PI/3.f;
  float[] p1 = {radius*cos(radianOffset+r), radius*sin(radianOffset+r)};
  r+=TWO_PI/3.f;
  float[] p2 = {radius*cos(radianOffset+r), radius*sin(radianOffset+r)};
  //1-0

  //2-0
  return new float[][]{vec2MinusVec2(p1, p0), vec2MinusVec2(p2, p0)};
}

//void keyPressed() {
//  if (key == 'q') {
//    endRecord();
//    exit();
//  }
//}