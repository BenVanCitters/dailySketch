class TempGuage extends ThermWidget
{
//  float[] pos={0,0};
//  float[] wxh={300,100};
//  float temperatureRange[] = {0,60};
//  float temperature = 56;

  public TempGuage()
  {
    
  }
  public void draw()
  {
    pushMatrix();
    pushStyle();
    translate(pos[0],pos[1]);
    fill(255);
    noStroke();
    rect(0,0,wxh[0],wxh[1]);
    translate(wxh[0]/2,wxh[1]);
    stroke(0,255,100);
    strokeWeight(10);
    float outerRingRadius = wxh[1]*2;
    float innerRingRadius = wxh[1]*1.8f;
    arc(0, 0, outerRingRadius, outerRingRadius, PI, TWO_PI);
    
    stroke(0,0,255);
    arc(0, 0, innerRingRadius,innerRingRadius, PI, 5*TWO_PI/8);
    
    stroke(255,0,0);
    arc(0, 0,innerRingRadius,innerRingRadius, TWO_PI*7.f/8, TWO_PI);
    
    float pctThroughRange = (temperature-temperatureRange[0])/(temperatureRange[1]-temperatureRange[0]);
    float tempInRads = PI/2.f;
    tempInRads += PI*pctThroughRange;
//    println("pctThroughRange: "+ pctThroughRange*PI);
    rotate(tempInRads);
    fill(255,0,0);
    
    strokeWeight(1);
    stroke(0);
    rect(0,0,5,wxh[1]*.9f);
    popStyle();
    popMatrix();
  }
}
