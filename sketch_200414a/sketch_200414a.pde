LEDSim ledSim;

void setup()
{
  size(600,600);
  ledSim = new LEDSim(25);
}


void draw()
{
  background(0);
  long m = millis();
  //ledSim.draw(m);
  ledSim.drawC(m,new CCM(){
    public int getColor(int index,int total, int previous,long millis)
    {
      float s = millis/1000.f;
      float r = (noise(s*.5,index+s*2));    
      //float g = red(previous);
      return colorFromRange(r);
    }});
}

//returns color from a float number between 0-1
int colorFromRange(float pct)
{
  return color(pct*255,0,0);
}
