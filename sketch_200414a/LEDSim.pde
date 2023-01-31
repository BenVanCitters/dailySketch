class LEDSim
{
  int[] lastColors;
  int lightCount = 10;
  
  LEDSim(int count)
  {
    lightCount=count;
    lastColors = new int[lightCount];
  }
  
  private void renderColors(int[] colors)
  {
    float h_spacing = height*1./colors.length;
    for(int i = 0; i < colors.length; i++)
    {
      pushStyle();
      fill(colors[i]);
      //stroke(colors[i]);
      noStroke();
      ellipse(width/2,
              h_spacing*(i+.5),
      h_spacing*.5,h_spacing*.5);
      popStyle();
    }
  }
  
  public void draw(long millis)
  {
    int[] colors = getColors(millis);
    lastColors = colors;
    renderColors(colors);  
  }
  public void drawC(long millis, CCM c)
  {
    int[] colors = getColors2(millis,c);
    lastColors = colors;
    renderColors(colors);  
  }
  
  private int[] getColors2(long millis, CCM c)
  {
    int[] nextColors = new int[lightCount];
    for(int i = 0; i < nextColors.length; i++)
    {
      nextColors[i] = c.getColor(i,lightCount, lastColors[i], millis);
    }
    return nextColors;
  }
  private int[] getColors(long millis)
  {
    int[] nextColors = new int[lightCount];
    float seconds = millis/1000.f;
    for(int i = 0; i < nextColors.length; i++)
    {
      float r = 255*(1+sin(5*seconds+i))/2;
      nextColors[i] = color(r,0,0);
    }
    return nextColors;
  }
}

interface CCM{
  int getColor(int index,int total, int previous,long millis);
}
