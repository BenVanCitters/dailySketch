void setup()
{
  size(700,700,P3D);
}

void draw()
{
  lights();
  background(120);
  
//  noFill();
  noStroke();
  translate(width/2,height/2,0);
  float tm = millis()/5000.f;
  rotateX(tm);
  rotateY(tm);
  rotateZ(tm);
  
//  float factor = mouseY*20.f/height;
//  println(factor);
  
  int maxLevel = (10*mouseX)/width;
  float position[] = {0,0,0};
  recurseBox(300,position,0,maxLevel);
}

void recurseBox(float sz, float[] pos, int curLevel, int maxLevel)
{
  if(curLevel > maxLevel)
    return;
    
  pushMatrix();
  translate(pos[0],pos[1],pos[2]);
  box(sz);
  
  int newLv = curLevel+1;
  float factor = 1.7142857;//mouseY*20.f/height;
  //top
  pushMatrix();
  rotateY(PI/4.f);
  recurseBox(sz/factor,
             new float[]{0,sz/2,0},
             newLv,
             maxLevel);  
  popMatrix();
  //bottom
  pushMatrix();
  rotateY(-PI/4.f);
  recurseBox(sz/factor,
             new float[]{0,-sz/2,0},
             newLv,
             maxLevel);  
  popMatrix();
  //right
  pushMatrix();
  rotateX(PI/4.f);
  recurseBox(sz/factor,
             new float[]{sz/2,0,0},
             newLv,
             maxLevel);  
  popMatrix();
  //left
  pushMatrix();
  rotateX(-PI/4.f);
  recurseBox(sz/factor,
             new float[]{-sz/2,0,0},
             newLv,
             maxLevel);  
  popMatrix();

             
  //front
  pushMatrix();
  rotateZ(PI/4.f);
  recurseBox(sz/factor,
             new float[]{0,0,sz/2},
             newLv,
             maxLevel);  
             popMatrix();

  //back
  pushMatrix();
  rotateZ(PI/4.f);
  recurseBox(sz/factor,
             new float[]{0,0,-sz/2},
             newLv,
             maxLevel);
  popMatrix();
  popMatrix();
}
