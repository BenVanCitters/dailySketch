SpotCollection s;
SpotCollection s1;
SpotCollection s2;
SpotCollection s3;
SpotCollection s4;
void setup()
{
  size(600,600,P3D);
  
  s = new SpotCollection(550, new float[]{300,300,300});
  
  float[] sz = new float[]{100,100,100};
  s1 = new SpotCollection(100,sz );
  s1.strokeW = 5;
  s2 = new SpotCollection(100, sz);
  s2.strokeW = 5;  
  s3 = new SpotCollection(100, sz);
  s3.strokeW = 5;
  s4 = new SpotCollection(100, sz);
  s4.strokeW = 5;
}

void draw()
{
  background(0);
  float tm = millis()/1000.f;
  pushMatrix();
  translate(width/2,height/2,200);
  s.draw(tm, 8,.09);
  popMatrix();
  
  tm*=3;
  pushMatrix();
  translate(width/3,height/3,200);
  s1.draw(tm, 2,.3);
  popMatrix();
  
  pushMatrix();
  translate(2*width/3,height/3,200);
  s2.draw(tm, 2,.3);
  popMatrix();

  pushMatrix();
  translate(2*width/3,2*height/3,200);
  s3.draw(tm, 2,.3);
  popMatrix();
  
  pushMatrix();
  translate(width/3,2*height/3,200);
  s4.draw(tm, 2,.3);
  popMatrix();
}

void printPos(float[] pos)
{
  println("pos: [" +pos[0]+ "," + pos[1]+ "," + pos[2] + "]");
}
