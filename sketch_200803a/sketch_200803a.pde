void setup()
{
  size(700,700);
  //float[][] pts = {{200,0,0}
  //                 ,{width,0,0}
  //                 ,{width-10,height-10,0}
  //                 ,{100,600,0}
  //               };
  //for(int i = 0; i < pts.length; i++)
  //{
  //  ellipse(pts[i][0],pts[i][1],10,10);
  //}
  //bezy(pts,7);
}

void draw()
{
  background(200);
  float t = millis()/1000.f;
  float r = 300;
  float[] p1 = {width/2+ cos(t)*r,height/2+ sin(t)*r,0};
  float[] p2 = {width/2+ cos(t+PI)*r,height/2+ sin(t+PI)*r,0};
  
  float r2 = 100;
  float[] p3 = {width/2+ cos(t+HALF_PI)*r2,
                height/2+ sin(t+HALF_PI)*r2,0};
  float[] p4 = {width/2+ cos(t+PI+HALF_PI)*r2*5,
                height/2+ sin(t+PI+HALF_PI)*r2,0};
                
                
  int lCount = 150;
  for(int i = 0; i < lCount; i ++)
 {
   float pct = i*1.f/(lCount-1);
   float[][] pts = {{width*(10*pct-5),0,0}                                          
                     
                     ,p4,p1
                     
                     ,p2,p3  
                     ,{width*(10*pct-5),height,0}
                   };
    //for(int j = 0; j < pts.length; j++)
    //{
    //  ellipse(pts[j][0],pts[j][1],10,10);
    //}
    bezy(pts,200);
  }
}

void bezy(float[][] points, int evals)
{
  noFill();
  beginShape();
  
  for(int j = 0; j < evals; j++)
  {
    float t = j*1.f/(evals-1);
    float[] sum = {0,0,0};
    //println(" t: " + t);
    for(int i = 0; i < points.length; i++)
    {
      int n= points.length-1;
      float tp = pow(1-t,n-i);
      float tt = pow(t,i);
      float bi = binom(n,i);    
      float val = tp*tt*bi;
      //println("val: " + val + " tp: " + tp + " tt: " + tt + " bi: " + bi + " n: " + n + " i: " + i);
      //println("p: [" + points[i][0] + "," + points[i][1] + "," + points[i][2] + "]");
      sum[0] += val*points[i][0];
      sum[1] += val*points[i][1];
      sum[2] += val*points[i][2];
    }
    //println("SUM: [" + sum[0] + "," + sum[1] + "," + sum[2] + "]");
    vertex(sum[0],sum[1]);
    //println();
  }
  endShape();
}

float binom(int n, int k)
{
  return factorial(n)*1.0/(factorial(k)*factorial(n-k));
}

long factorial(int f)
{
  long result = 1;
  for(int i = 2; i <= f; i++)
  {
    result *= i;
  }
  return result;
}
  
