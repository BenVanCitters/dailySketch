float[][] points = new float[40][3];
float zSpacing = 5;
float circumference = 1000;

void setup()
{
  size(500,500,OPENGL);
  float tm = millis()/1000.f;
  for(int i = 0; i < points.length; i++)
  {
    points[i][0] = circumference*cos(tm+i/100.f);
    points[i][1] = circumference*sin(tm+i/100.f);
    points[i][2] = -i*zSpacing;
  }
}

void draw()
{
  //update
  int breakIndex = points.length-1;
  for(int i = 0; i < points.length; i++)
  {
    points[i][2] += 1;
    if(points[i][2] > 0) 
    {
      points[i][2] -= points.length*zSpacing;
      breakIndex = i;
    }
    float scl = points[i][2]/(zSpacing*points.length);
    points[i][0] = scl*circumference*cos(i/100.f);
    points[i][1] = scl*circumference*sin(i/100.f);
  }
  
  //draw
  background(0);
  lights();
  noStroke();
//  stroke(255);
//  noFill();
  translate(width/2,height/2,-500);
//  beginShape();
  for(int i = 0; i < points.length-1; i++)
  {
    beginShape(TRIANGLE_STRIP);
    int edgeCount = 10;
    float tunnelRadius = 500.f;
    for(int j = 0; j < edgeCount; j++)
    {
      float curRad = j*TWO_PI/(edgeCount-1);
      vertex( points[i][0]+tunnelRadius*cos(curRad), 
              points[i][1]+tunnelRadius*sin(curRad), 
              points[i][2] );
      int nextIndex = (i+1)%points.length;
      if(breakIndex == 0)
        nextIndex = i+1;
      vertex( points[nextIndex][0]+tunnelRadius*cos(curRad), 
              points[nextIndex][1]+tunnelRadius*sin(curRad), 
              points[nextIndex][2] );
    }
    endShape();
//    vertex( points[i][0], points[i][1], points[i][2] );
  }
  endShape();
}
