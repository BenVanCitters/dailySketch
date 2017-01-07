class ShapeHole
{
  float[][] verts;
  PShape shape;// = createShape(TRIANGLE_STRIP);
  ShapeHole(float[][] outArray, float[][] inArray, int vertStops)
  {
    verts = new float[vertStops*2][2];
    
    float spacing = 1.f/vertStops;
    shape = createShape();
    shape.beginShape(TRIANGLE_STRIP);
    shape.noStroke();
    for(int i = 0; i < vertStops; i++)
    {
      verts[i*2] = getLerpedVert(i*spacing,outArray);
      shape.vertex(verts[i*2][0],verts[i*2][1]);
      verts[i*2+1] = getLerpedVert(i*spacing,inArray);
      shape.vertex(verts[i*2+1][0],verts[i*2+1][1]);
    }
    //cap off
    shape.vertex(verts[0][0],verts[0][1]);
    shape.vertex(verts[1][0],verts[1][1]);

    shape.endShape();
    shape.setFill(color(0));
    println("endShape");
 } 
  
  void draw()
  {
    shape(shape,0,0);
//    beginShape(TRIANGLE_STRIP);
//    for(int i = 0; i < verts.length; i++)
//    {
//      vertex(verts[i][0],verts[i][1]);
//    }
//    //cap off
//    vertex(verts[0][0],verts[0][1]);
//    vertex(verts[1][0],verts[1][1]);
//    endShape();
  }
  
  //returns the faked position 'pct' percent through the 
  // verts
  float[] getLerpedVert(double pct, float[][] verts)
  {
    double fIndex = (pct*(verts.length));
    double btwnVerts = fIndex % 1.0;

    int preIndex = (int)fIndex;
    int postIndex = (preIndex+1)%verts.length;
    
    float[] result = {verts[postIndex][0] - verts[preIndex][0],
                      verts[postIndex][1] - verts[preIndex][1]};
    result[0] *= btwnVerts;
    result[1] *= btwnVerts;
    
    result[0] += verts[preIndex][0];
    result[1] += verts[preIndex][1];
//    println("pct: " + pct + " btwnVerts: " + btwnVerts + " fIndex: " + fIndex);
//    println("preINdex: " + preIndex + " postIndex: " + postIndex);
  return result;
  }
}
