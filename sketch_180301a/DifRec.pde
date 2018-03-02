class DifRec
{
  float[][] chemsCur;
  float[][] chemsLast;
  float[][] convKernal = {{0.05,  0.2, 0.05},
                          {0.2 , -1.001, 0.2 },
                          {0.05,  0.2, 0.05}};
  int count = 0;
  float k = .062;
  float dA = 1.0f;
  float dB = .5f;
  float f = .0545;
  float dT = 1.0;
  public DifRec()
  {
    count = width*height;
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
      boolean inMid = x < width/2;//abs(width/2-x) < 10 && abs(width/2-y) < 10;
      chemsLast[i][0] = inMid? 0 : 1;
      chemsLast[i][1] = inMid? 1 : 0;
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
        if(newX < 0 || newY < 0 || newX >= width || newY >= height)
        { continue; }
        int ndx = getIndexForXY(newX, newY);
        
        result += convKernal[i][j] * chemsLast[ndx][abIndex];
      }
    }
    
    return result;
  }
  
  void draw()
  {
    loadPixels();
    for(int i = 0; i < count; i++) 
    {
      float a = chemsCur[i][0];
      float b = chemsCur[i][1];
      
      pixels[i] = color(255*a, 255*b,0);
    }
    updatePixels();
  }
  
  int getIndexForXY(int x, int y)
  {
    return x+y*width;
  }
  int[] getXYForIndex(int index)
  {
    return new int[]{index%width,index/width};
  }
}
