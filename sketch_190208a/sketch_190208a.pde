void setup()
{
  size(displayWidth, displayHeight,P3D);
}

void draw()
{
  lights();
  background(0);
  noStroke();
  float tm = millis()/1000.f;
  translate(width/2, height/2);
  float sz = 80;
  int countHalf = 20;
  float s = (1+sin(tm*.06))/2.f;
  for(int i = -countHalf; i < countHalf; i++)
  {
    for(int j = -countHalf; j < countHalf; j++)
    {
      pushMatrix();
        
        float i_s = 2*sin(.3*tm+i/23.f);
        float j_s = 1.5*sin(.7*tm+j/29.f);
        float j_i_s = 2.5*sin(.2*tm-i*.5+j/13.f);
        i_s *= s;
        j_s *= s;
        j_i_s *= s;
        rotateX(tm*0.15 + i_s);
        rotateY(tm*0.2+j_i_s);
        rotateZ(tm*0.06+j_s);
        translate(sz*1.3*i,
                  sz*1.3*j,
                  0);
        box(sz);
      popMatrix();
    }
  }
}
