class FMeter extends ThermWidget
{
  int dotCount = 25;
  public void draw()
  {
    pushMatrix();
    pushStyle();
    translate(pos[0],pos[1]);
    fill(40);
    rect(0,0,wxh[0],wxh[1]);
    float dotHt = min(wxh[1]/dotCount,wxh[0]);
    float dotVertSpace = wxh[1]/dotCount;
    float tempRange = temperatureRange[1]-temperatureRange[0];
   float rangePerDot = tempRange/dotCount; 
    for(int i = 0; i< dotCount; i++)
    {
      float dotAmt= temperatureRange[1] -rangePerDot*i;
      float pctThoughDots = 1-i*1.f/dotCount;
      if(temperature < dotAmt)
      {
        fill(0,0,0);
      }
      else
      {
        if(pctThoughDots > .8)
          fill(255,0,0);
        else if(pctThoughDots > .6)
          fill(255,255,0);
        else 
          fill(0,255,0);
      }
      noStroke();
     ellipse(wxh[0]/2, (i+.5)*(dotVertSpace),dotHt,dotHt); 
    }
    
    popStyle();
    popMatrix();
  }
}
