ShapeHole shp;// = new ShapeHole();

void setup()
{
  size(500,500);
  
  float[][] outsideVerts = new float[4][2];
  for(int i = 0; i < outsideVerts.length; i++)
  {
    float piPlace = TWO_PI/outsideVerts.length;
    float curRadians = i*piPlace;
    float radius = 200;
    outsideVerts[i][0] = radius*cos(curRadians);
    outsideVerts[i][1] = radius*sin(curRadians);
  }
  
  float[][] insideVerts = new float[3][2];
  for(int i = 0; i < insideVerts.length; i++)
  {
    float piPlace = TWO_PI/insideVerts.length;
    float curRadians = i*piPlace;
    float radius = 100;
    insideVerts[i][0] = radius*cos(curRadians);
    insideVerts[i][1] = radius*sin(curRadians);
  }
  
  shp = new ShapeHole(outsideVerts,insideVerts,50);
}

void draw()
{
  background(255);
  translate(width/2,height/2);
//    for(int i = 0; i < shp.outsideVerts.length; i++)
//  {
//    stroke(255,0,0);
//    ellipse(shp.outsideVerts[i][0], 
//    shp.outsideVerts[i][1],10,10);
//  }
//  
//  float[] lerped = shp.getLerpedVert(mouseX*1.f/width,
//  shp.outsideVerts);
//  stroke(0);
//  ellipse(lerped[0],lerped[1],10,10);
scale(4*mouseY*1.f/height);
//strokeWeight(.1);
noStroke();
fill(0);
shp.draw();
  

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
