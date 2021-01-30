float[][] getBezierPoints(float[][] controlPts, int count)
{
  float[][] result = new float[count][3];
  for(int j = 0; j < count; j++)
  {
    float t = j*1.f/(count-1);
    result[j] = getBezierPtForT(controlPts,t);
    //println("SUM: [" + sum[0] + "," + sum[1] + "," + sum[2] + "]");
  }
  return result;
}

//returns a single 3 vector for a a set of bezier control points and a value of 't'
float[] getBezierPtForT(float[][] controlPts, float t)
{
  float[] sum = {0,0,0};
  //println(" t: " + t);
  for(int i = 0; i < controlPts.length; i++)
  {
    int n= controlPts.length-1;
    float tp = pow(1-t,n-i); //maybe cache these pow vals next???
    float tt = pow(t,i);
    float bi = cachedBinom(n,i);    
    float val = tp*tt*bi;
    //println("val: " + val + " tp: " + tp + " tt: " + tt + " bi: " + bi + " n: " + n + " i: " + i);
    //println("p: [" + points[i][0] + "," + points[i][1] + "," + points[i][2] + "]");
    sum[0] += val*controlPts[i][0];
    sum[1] += val*controlPts[i][1];
    sum[2] += val*controlPts[i][2];
  }
  return sum;
}

//returns the 'binomial' of n and k
float binom(int n, int k)
{
  return (float)(getCachedFact(n)*1.0/(getCachedFact(k)*getCachedFact(n-k)));
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
  
void printLongArr(long[] arr)
{
  for(int i = 0; i < arr.length; i++)
  {
    print(arr[i] + ", ");
  }
}
  
long[] cachedFact = new long[]{0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
void setupCachedFact()
{
  println("setupt");
  cachedFact[1] = 1;
  cachedFact[0] = 1;
  for(int i = 1; i < cachedFact.length; i++)
  {
    cachedFact[i] = cachedFact[i-1] * i;
    //println(i + " --- " + cachedFact[i]);
  }    
}


int maxCF = -1;
long getCachedFact(int i)
{
  maxCF = max(maxCF, i);
  if(i>=0  && i < cachedFact.length)
  {
    if(cachedFact[i] < 1)
    {
      println("cachedFact["+i+"]: " +  cachedFact[i]);
      setupCachedFact();
    }else
     return cachedFact[i];
  }
  return -1;
}

//cached binomial
boolean isBinomCached = false;
float[][] cachedBinom = new float[6][6];
void setupCachedBinom()
{
  for(int i = 0; i < cachedBinom.length; i++)
  {
    for(int j = 0; j < cachedBinom[i].length; j++)
    {
      cachedBinom[i][j] = (float)(getCachedFact(i)*1.0/(getCachedFact(j)*getCachedFact(i-j)));
    } 
  }
  isBinomCached = true;
}

//returns the 'binomial' of n and k
float cachedBinom(int n, int k)
{
  //println("n,k: " + n +"," + k );
  if(!isBinomCached)
  {
    setupCachedBinom();
  }
  return cachedBinom[n][k];
  
  //return getCachedFact(n)*1.0/(getCachedFact(k)*getCachedFact(n-k));
}
