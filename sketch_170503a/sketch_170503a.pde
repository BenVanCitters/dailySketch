void setup()
{
  size(850,850,P3D);
}

void draw()
{
  background(0);
  directionalLight(255,255,255,0,0,-1);
  ambientLight(40,40,40);
  translate(width/2,height/2);
  float tm = millis()/100.f;
//  rotateX(tm/10);
//  rotateY(tm/11);
  rotateZ(tm/133);
  noStroke();
  int maxTriCount= 8; 
  int triCount = maxTriCount;//(int)(1+maxTriCount*(sin(17+tm/100)+1)/2.f);
  float madRadius = 500;
  float rotOffset1 = 4.8*sin(tm/110);
  float rotOffset2 = 6.9*sin(1+tm/210);
  float rotOffset3 = 7.4*sin(7+tm/140);
  for(int j = 0; j < triCount; j++)
  {
    rotateX(rotOffset1*1.f/23);
    rotateY(rotOffset1*1.f/19);
    rotateZ(rotOffset1*1.f/17);
    float outerRad = (1-j*1.f/maxTriCount)*madRadius;
    float innerRad = (1-(j+1)*1.f/maxTriCount)*madRadius;
    beginShape(TRIANGLE_STRIP);
    int vertCount = 3;
    for(int i = 0; i <= vertCount; i++)
    {
      float curRadian = i * TWO_PI/vertCount;
      float[] pos = {cos(curRadian),sin(curRadian),0};
      vertex(innerRad*pos[0],innerRad*pos[1],innerRad*pos[2]);
      vertex(outerRad*pos[0],outerRad*pos[1],outerRad*pos[2]);
    }
    endShape();
  }
}
