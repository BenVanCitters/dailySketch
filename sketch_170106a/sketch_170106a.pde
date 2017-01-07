ShapeHole triShp;// = new ShapeHole();
ShapeHole circShp;
ShapeHole sqrShp;
void setup()
{
  size(500,500,P2D);
  float[][] outsideVerts = createCircShape(200,4);
  
  triShp = new ShapeHole(outsideVerts,createCircShape(100,3),1000);
  sqrShp = new ShapeHole(outsideVerts,createCircShape(100,4),1000);
  circShp = new ShapeHole(outsideVerts,createCircShape(100,1000),1000);
}
//radius-based vertex creator helper function
float[][] createCircShape(float radius, int vertCount)
{
  float[][] insideCircVerts = new float[vertCount][2];
  
  float piPlace = TWO_PI/insideCircVerts.length;
  for(int i = 0; i < insideCircVerts.length; i++)
  {
    float curRadians = HALF_PI/2+i*piPlace;
    insideCircVerts[i][0] = radius*cos(curRadians);
    insideCircVerts[i][1] = radius*sin(curRadians);
  }
  return insideCircVerts;
}
void draw()
{
  background(255);
  translate(width/2,height/2);
  pushMatrix();
  scale(4*mouseY*1.f/height);
  triShp.draw();
  popMatrix();
  
  pushMatrix();
  translate(100,100);
  scale(4*mouseY*1.f/height);
  circShp.draw();
  popMatrix();
}

void drawRepeatCircs()
{
  float tm = millis()/1000.f;
  int eCount = 10;
  float shapeSpacing = width*1.f/eCount;
  for(int i = -1; i < eCount+1; i++)
  {
    for(int j =-1; j < eCount+1; j++)
    {
      float[] offset = {tm*20%shapeSpacing,tm*20%shapeSpacing};
      float shapeW = shapeSpacing*.5;
      ellipse(i*shapeSpacing+offset[0], j*shapeSpacing+offset[1],shapeW,shapeW);
    }
  } 
}
