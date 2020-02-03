BShape bshape;

void setup()
{
  size(700,700, P3D);
  bshape = new BShape();
  bshape.saveAsOBJ();
}

void draw()
{
  
  lights();
  background(200);
  text("franerate: " + frameRate, 0,20);
  translate(width/2,height/2);
  float tm = millis()/6000.f;
  rotateX(tm);
  rotateY(tm/2);
  rotateZ(tm/3);  
  bshape.draw();
  //pushMatrix();
  //translate(200,0,0);
  //rotateX(HALF_PI);
  //bshape.draw();
  //popMatrix();
  //pushMatrix();
  //translate(-200,0,0);
  //rotateX(HALF_PI);
  //rotateY(PI);
  //bshape.draw();
  //popMatrix();
  
  //pushMatrix();
  //translate(0,200,0);
  //rotateY(HALF_PI);
  //bshape.draw();
  //popMatrix();
  //pushMatrix();
  //translate(0,-200,0);
  //rotateY(HALF_PI);
  //rotateZ(PI);
  //bshape.draw();
  //popMatrix();
}
