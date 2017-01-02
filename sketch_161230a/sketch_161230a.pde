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
      rotate(rotateAmt * pct/(4*sin(millis()/7997.f)));
      translate(-sz/2*sin(millis()/3000.f),
                -sz/2*sin(13+millis()/2777.f));
      noFill();
//      ellipse(0,0,sz*sin(millis()/5555.f+97),
//      sz*sin(millis()/1212.f+51));
rect(0,0,sz*sin(millis()/5555.f+97),
      sz*sin(millis()/1212.f+51));
    popMatrix();  
  }
}

