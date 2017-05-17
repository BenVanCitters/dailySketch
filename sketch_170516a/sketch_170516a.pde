void setup()
{
  size(300,300,P3D);
  rectMode(CENTER);
}

void draw()
{
  background(255);
  strokeWeight(5);
  float tm = millis()/1000.f;
  translate(width/2,height/2);
  rotateX(tm*1.01);
  rotateY(1+tm*-0.97);
  rotateZ(11+tm*.7);
  rect(0,0,180,180);
}
