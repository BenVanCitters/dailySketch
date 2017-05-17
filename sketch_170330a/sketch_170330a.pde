SpotCollection s;
SpotCollection s1;
SpotCollection s2;
SpotCollection s3;
SpotCollection s4;
void setup()
{
  size(1200,1200,P3D);
  
  s = new SpotCollection(550, new float[]{600,600,600});
  s.strokeW = 50;
  float[] sz = new float[]{200,200,200};
  s1 = new SpotCollection(100,sz );
  s1.strokeW = 10;
  s2 = new SpotCollection(100, sz);
  s2.strokeW = 10;  
  s3 = new SpotCollection(100, sz);
  s3.strokeW = 10;
  s4 = new SpotCollection(100, sz);
  s4.strokeW = 10;
}

void draw()
{
  background(0);
  float tm = millis()/1000.f;
  pushMatrix();
  translate(width/2,height/2,200);
  s.draw(tm, 8,.09);
  popMatrix();
  
//  tm/=3;
  pushMatrix();
  translate(width/4,height/4,200);
  s1.draw(tm/3, 2,.3);
  popMatrix();
  
  pushMatrix();
  translate(3*width/4,height/4,200);
  s2.draw(tm/4, 2,.3);
  popMatrix();

  pushMatrix();
  translate(3*width/4,3*height/4,200);
  s3.draw(tm/2.1, 2,.3);
  popMatrix();
  
  pushMatrix();
  translate(width/4,3*height/4,200);
  s4.draw(tm/1.9, 2,.3);
  popMatrix();
  
}

void printPos(float[] pos)
{
  println("pos: [" +pos[0]+ "," + pos[1]+ "," + pos[2] + "]");
}
