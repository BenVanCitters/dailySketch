void setup()
{
  size(900,900,P3D);
}

void draw()
{
  background(0);
  translate(width/2,height/2);
  float tm = millis()/100.f;
  rotateX(tm/10);
  rotateY(tm/11);
  rotateZ(tm/13);
  noStroke();
  int triCount = 90;
  float madRadius = 1800;
  float rotOffset = .8*sin(tm/40);
  for(int j = 0; j < triCount; j++)
  {
    rotateX(rotOffset*1.f/10);
    rotateY(rotOffset*1.f/11);
    rotateZ(rotOffset*1.f/13);
    float outerRad = j*madRadius/triCount;
    float innerRad = (j+1)*madRadius/triCount;
    beginShape(TRIANGLE_STRIP);
    for(int i = 0; i < 4; i++)
    {
      float curRadian = i * TWO_PI/3;
      float[] pos = {cos(curRadian),sin(curRadian),0};
      vertex(innerRad*pos[0],innerRad*pos[1],innerRad*pos[2]);
      vertex(outerRad*pos[0],outerRad*pos[1],outerRad*pos[2]);
    }
    endShape();
  }
}
