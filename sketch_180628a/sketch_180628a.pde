
float[][] startPoss; //= new float[1][1];
float[][] startDirs;// = new float[500][3];
void setup()
{
  size(500,500);
  setupStartVecs();
}

void setupStartVecs()
{
  int w = 500;
  int h = 500;
  int vecCount = w*h;
  startPoss = new float[vecCount][3];
  startDirs = new float[vecCount][3];
  float[] eyePos = new float[]{0,0,-15};
  for(int i = 0; i < vecCount; i++)
  {
    int u = i%w;
    int v = i/w;
    startPoss[i] = new float[]{5*(u*1.f/w - .51),
                               5*(v*1.f/h - .51),
                               -1};
    startDirs[i] = new float[]{startPoss[i][0]-eyePos[0],
                               startPoss[i][1]-eyePos[1],
                               startPoss[i][2]-eyePos[2]};  
    //startDirs[i] = getNormalized(startDirs[i]);
    //startDirs[i] = new float[]{0,0,1};  
    
  }
}

float[][] getTriPoints(float ra, float sz)
{
  float[][] triangle = new float[3][3];
  float ofs =0;//millis()/1000.f;


  for(int i = 0; i < 3; i++)
  {
    float angle = ofs-i*TWO_PI/3.f;
    triangle[i] = new float[]{sz*cos(angle),
                              sz*sin(angle),
                              3};
  }
  
  float d = .5;
  float[] p = {d*cos(ra),d*sin(ra),0};
  for(int i = 0; i < 3; i++)
  {
    triangle[i][0] += p[0];
    triangle[i][1] += p[1];
    triangle[i][2] += p[2];
  }
  return triangle;
}

void draw()
{
  int tricount = 5;
    float ofs = 1;//millis()/1000.f;
  float[][][] tris = new float[tricount][3][3];
  float r = 10*mouseX*1.f/width;
  println(r);
  for(int i = 0; i <tricount; i++)
  {
    tris[i] = getTriPoints(i*TWO_PI/tricount+ofs,r);
  }
  int onColor = color(255,255,255);
  int offColor = color(0,0,0);
  loadPixels();
  for(int i = 0; i < pixels.length; i++)
  {
    int x = i % width;
    int y = i/width;
    boolean anyHits = false;
    for(int j = 0; j < tricount; j++)
    {
      float[] bgt = getTriRayIntersection(tris[j],startPoss[i],startDirs[i]);
      //if(x==mouseX && y == mouseY)
      //{
      //  printVec(bgt);
      //}
      boolean tLoc = (bgt[2] > -1000) && (bgt[2] < 5000);
      boolean gamLoc = (bgt[1] >= 0) && (bgt[1] <=1);
      boolean betLoc = (bgt[0] >= 0) && (bgt[0] <=1-bgt[1]);
      boolean all = tLoc && gamLoc && betLoc;
      anyHits = (gamLoc && betLoc) || anyHits;
    }
    pixels[i] = anyHits ? onColor : offColor;
  }
  updatePixels();
  stroke(255,0,0);
  noFill();
  ellipse(width/2,height/2,5,5);
}

float[] getTriRayIntersection(float[][] tri, float[] start, float[] dir)
{
  float a,b,c,d,e,f,g,h,i,j,k,l,M;
  float beta, gamma, tau;
  a = tri[0][0]-tri[1][0];
  b = tri[0][1]-tri[1][1];
  c = tri[0][2]-tri[1][2];
  d = tri[0][0]-tri[2][0];
  e = tri[0][1]-tri[2][1];
  f = tri[0][2]-tri[2][2];
  g = dir[0];
  h = dir[1];
  i = dir[2];
  j = tri[0][0] - start[0];
  k = tri[0][1] - start[1];
  l = tri[0][2] - start[2];
  M = a*(e*i-h*f)+b*(g*f-d*i)+c*(d*h-e*g);
  beta  = j*(e*i-h*f) + k*(g*f-d*i) + l*(d*h-e*g)/M;
  gamma = i*(a*k-j*b) + h*(j*c-a*l) + g*(b*l-k*c)/M;
  tau   = f*(a*k-j*b) + e*(j*c-a*l) + d*(b*l-k*c)/M;
  return new float[]{beta,gamma,tau};
}
