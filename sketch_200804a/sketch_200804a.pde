void setup()
{
  size(700,700);
  drawx();
}

void drawx()
{
  long m1 = millis();
  background(200);
  float t = 4;//millis()/1000.f;
  float r = 300;
  //println(t);
  float[] p1 = {width/2+ cos(t)*r,height/2+ sin(t)*r,0};
  float[] p2 = {width/2+ cos(t+PI)*r,height/2+ sin(t+PI)*r,0};
  
  float r2 = 100;
  float[] p3 = {width/2+ cos(t+HALF_PI)*r2,
                height/2+ sin(t+HALF_PI)*r2,0};
  float[] p4 = {width/2+ cos(t+PI+HALF_PI)*r2*5,
                height/2+ sin(t+PI+HALF_PI)*r2,0};
                
                
  int lCount = 1500;
  for(int i = 0; i < lCount; i ++)
 {
   float pct = i*1.f/(lCount-1);
   float xval = width*(100*pct-50);
   float[][] pts = {{xval,0,0}                                          
                     
                     ,p4,p1
                     
                     ,p2,p3  
                     ,{xval,height,0}
                   };
    //for(int j = 0; j < pts.length; j++)
    //{
    //  ellipse(pts[j][0],pts[j][1],10,10);
    //}
    renderBezier(pts,900);
  }
  println("CalcTime: " + (millis()-m1));
}

//draws a bezier line for a set of control points and a segment count
void renderBezier(float[][] points, int evals)
{
  noFill();
  beginShape();
  float[][] linepoints = getBezierPoints(points,evals);
  
  for(int i = 0; i < linepoints.length; i++)
  {
    vertex(linepoints[i][0],linepoints[i][1]);
  }
  endShape();
}
