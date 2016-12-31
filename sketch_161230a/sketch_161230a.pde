void setup()
{
  size(500,500);
}

void draw()
{
  background(255);
  translate(width/2,height/2);
  int c = 4+(int)(120*( cos(millis()/1321.f) + 1 )/2);
  for(int i = 0; i < c; i++)
  {
    float pct = 1-i*1.f/c;
    float sz = width * pct;
    pushMatrix();
    float rotateAmt = cos( millis()/3333.f ) * TWO_PI; 
      rotate(rotateAmt * pct/(4*sin(millis()/1000.f)));
      translate(-sz/2,-sz/2);
      noFill();
      rect(0,0,sz,sz);
    popMatrix();  
  }
}

