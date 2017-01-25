class NumberRead extends ThermWidget
{
  

PFont myFont;
  public NumberRead()
  {
//    String[] fontList = PFont.list();
//    println(fontList);
    myFont = createFont("StencilStd", 32);
  }

  void draw()
  {
      pushMatrix();
      pushStyle();
      
      translate(pos[0],pos[1]);
      textFont(myFont,32);
      textAlign(CENTER, CENTER); 
      fill(40);
      rect(0,0,wxh[0],wxh[1]);

      fill(getColorForTemp());
      String txt = String.format("%.1fº", temperature);
      text(txt, wxh[0]/2, wxh[1]/2);
      popStyle();
      popMatrix();
  }
 
  int getColorForTemp()
  {
    float diff = temperatureRange[1]-temperatureRange[0];
   float place = temperature-temperatureRange[0];
  float pct = place/diff; 
    color hot = color(255, 0, 0);
    color cold = color(0, 0, 255);
    return lerpColor(cold, hot, pct);
    
  } 
}
