class DifRec
{
  PGraphics renderTarget;
  float[][] chemsCur;
  float[][] chemsLast;
  float[][] convKernal = {{0.2,  0.05, 0.2},
                          {0.05 , -1.0, 0.05 },
                          {0.2,  0.05, 0.2}};
                          
int width; int height;                          
  int count = 0;
  float k = .059;
  float dA = 1.0f;
  float dB = .5f;
  float f = .034f;
  float dT = 1.0f;
  public DifRec(int w, int h)
  {
    this.width = w;
    this.height = h;
    renderTarget = createGraphics(w,h,P2D);
    count = w*h;
    chemsLast = new float[count][2];
    chemsCur = new float[count][2];
    seed();
  }
  
  void seed()
  {
    for(int i = 0; i < count; i++)
    {
      int[] xy = getXYForIndex(i);
      int x = xy[0];
      int y = xy[1];
      boolean inMid = abs(renderTarget.width/2-x) < 5 && abs(renderTarget.width/2-y) < 5;
      chemsLast[i][0] = random(1);
      chemsLast[i][1] = random(1);
      chemsCur[i][0] = chemsLast[i][0];
      chemsCur[i][1] = chemsLast[i][1];
    }
  }
  
  void update()
  {
    for(int i = 0; i < count; i++)
    {
      float a = chemsLast[i][0];
      float b = chemsLast[i][1];
      chemsCur[i][0] = a + (dA*lap(i,0) - a*b*b + f*(1-a))*dT;
      chemsCur[i][1] = b + (dB*lap(i,1) + a*b*b - (k+f)*b)*dT;
    }
    swap();
  }
  
  void swap()
  {
      float[][] tmp= chemsCur;
      chemsCur = chemsLast;
      chemsLast = tmp;
  }
  
  float lap(int index, int abIndex)
  {
    int[] xy = getXYForIndex(index);
    int x = xy[0];
    int y = xy[1];
//    if(x < 0 || y < 0 || x >= width || y >= height)
//    { return 0; }
    float result = 0;
    for(int i = 0; i < 3; i++)
    {
      for(int j = 0; j < 3; j++)
      {
        int xOffs = i-1;
        int yOffs = j-1;
        int newX = x+xOffs;
        int newY = y+yOffs;
        if(newX < 0 || newY < 0 || newX >= renderTarget.width || newY >= renderTarget.height)
        { continue; }
        int ndx = getIndexForXY(newX, newY);
        
        result += convKernal[i][j] * chemsLast[ndx][abIndex];
      }
    }
    
    return result;
  }
  
  void render()
  {
    
    float thresh = (threshholdSpd*millis()/2000.f) % .5; //mouseX*1.f/width;
    renderTarget.beginDraw();
    renderTarget.loadPixels();
    for(int i = 0; i < count; i++) 
    {
      float a = chemsCur[i][0];
      float b = chemsCur[i][1];
      //b = abs(b -thresh) < .05 ? 255 : 0;
      renderTarget.pixels[i] = color(b,b,b,b);
//      renderTarget.pixels[i] = color(255*a, 255*b,0);
    }
    renderTarget.updatePixels();
    renderTarget.endDraw();
  }
  
 
  int getIndexForXY(int x, int y)
  {
    return x+y*renderTarget.width;
  }
  int[] getXYForIndex(int index)
  {
    return new int[]{index%renderTarget.width,index/renderTarget.width};
  }
}
