ShapeHole triShp;
ShapeHole circShp;
ShapeHole sqrShp;

void setup()
{
  size(500,500,OPENGL);
  
  triShp = new ShapeHole(createCircShape(50*3,4),createCircShape(25*3,3),1000);
  triShp.setColor(color(0,255,0));
  
  sqrShp = new ShapeHole(createCircShape(60*3.5,4),createCircShape(40*3.5,4),1000);
  sqrShp.setColor(color(255,0,0));
  
  circShp = new ShapeHole(createCircShape(50*5,4),createCircShape(30*5,1000),1000);
  circShp.setColor(color(0,0,255));
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
  //oscillating background color 
  float tm = millis()/800.f;
  background(255*(1+sin(tm*.9 +1))/2,
             255*(1+sin(tm*.5 +3))/2,
             255*(1+sin(tm*.1 +7))/2);

    drawRepeatTris(triShp,70*3,new float[]{-20,20});
    drawRepeatTris(sqrShp,70*3.5,new float[]{37,41});
    drawRepeatTris(circShp,70*5,new float[]{17,-13});
    println("frameRate: " + frameRate);
}

void drawRepeatTris(ShapeHole s, float w, float[] offs)
{
  float tm = millis()/1000.f;
  int eCount = (int)(width/w) + 1;
  float shapeSpacing = w;
  float[] offset = {tm*offs[0]%shapeSpacing,tm*offs[1]%shapeSpacing};
  for(int i = -1; i < eCount+1; i++)
  {
    for(int j =-1; j < eCount+1; j++)
    {
      pushMatrix();
        translate(i*shapeSpacing+offset[0], j*shapeSpacing+offset[1]);
        s.draw();
      popMatrix();
    }
  }
}
