
void setup()
{
  size(1400,850,P3D);
}

void draw()
{
  float diagRad = dist(0,0,width,height)/2.f;
  float tm = 500+millis()/5000.f;
  int count = 1500;
//  lights();

  background(255);
  noStroke();
  tint(256-7*cos(tm*.1+2)-3,
       256-7*cos(tm*.09+3)-3,
       256-7*cos(-tm*.07+5)-3);
  translate(width/2,height/2,-250);
  beginShape(TRIANGLE_STRIP);
  texture(g);
  textureMode(NORMAL);
  
  
  for(int i = 0; i < count; i++)
  {
    float pct = i*1.f/count;
    float[] norm = normalizeF(new float[] {sin(-tm*3+ pct*2.2)*cos(-3*pct+5*tm)/2,
                                           sin(tm*1.1 + 6 - pct*11)+cos(pct*5.2 + .2 * -tm),
                                           sin(1-tm+pct*9)/sin(-7.5*pct+tm+2)});
   
    float[] pos = {diagRad*(sin(3+.2*tm+.22*pct*15) + .15 * sin(1+.5*tm-pct*41)),
                    diagRad*(sin(2+1.5*tm-pct*19) - .15 *sin(9-.99*tm-pct*30.1)),
                    diagRad*(sin(1-tm*.9+pct*21) + .15 *sin(2+.01*tm-pct*35.1))};
    float ribbonWidth = diagRad*sin(tm*.7 + 1 + pct*.88)*cos(pct*1.2 + .2 * tm);
    vertex(pos[0]+norm[0]*ribbonWidth,
           pos[1]+norm[1]*ribbonWidth,
           pos[2]+norm[2]*ribbonWidth
           ,pct,0
           );
   vertex(pos[0]-norm[0]*ribbonWidth,
           pos[1]-norm[1]*ribbonWidth,
           pos[2]-norm[2]*ribbonWidth
           ,pct,1
           );
  }
  endShape();
  
}

float[] normalizeF(float[] v)
{
  float d = dist(0,0,0,v[0],v[1],v[2]);
  return new float[]{v[0]/d,v[1]/d,v[2]/d};
}
