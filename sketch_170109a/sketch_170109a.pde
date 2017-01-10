void setup()
{
  size(500,500);
}

void draw()
{
  fill(255,255,255,15);
  rect(0,0,width,height);
  filter(BLUR, 1);
  
  float tm = millis()/1000.f;
  
  stroke(0);
  noFill();
  beginShape();
  int points = 100;
  for(int i = 0; i < points; i++)
  {
    float indexAmt = i*100.f*cos01(tm*TWO_PI/100)/points;
    float t = indexAmt + tm*1;
//    vertex(random(width),random(height));
    vertex(width*sin01(t*.3+17)*sin01(1+t)+333*cos01(t*.8+2) + 60*sin(i/31.f+tm*1.3+1),
           height*cos01(3+t)*sin01(2+t)+200*cos01(t*3+17)+127*cos01(t*.7+19)+100*sin(.5*tm+29)+19*sin(i/17.0+3.1*tm+101));
  }
  endShape();
}

float sin01(float tm)
{
  return (sin(tm)+1)/2;
}

float cos01(float tm)
{
  return (cos(tm)+1)/2;
}
