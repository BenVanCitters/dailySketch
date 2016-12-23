float[][] points = new float[150][3];
float[] jitterOffSets = new float[points.length];
int breakIndex = points.length-1;
float zSpacing = 120;
float circumference = 1000;

void setup()
{
  size(500,500,OPENGL);
  
  for(int i = 0; i < points.length; i++)
  {
    points[i][2] = -i*zSpacing;
    jitterOffSets[i] = random(60);
  }
}

void draw()
{
  //update
  float tm = millis()/90000.f;
  for(int i = 0; i < points.length; i++)
  {
    float pctThru = i * 1.f / (points.length-1);
    points[i][2] += 59;
    boolean b = false;
    if(points[i][2] > 0) 
    {
      points[i][2] -= points.length*zSpacing;
//      if(!b)
      {
        breakIndex = i;
        b = true;
        println(breakIndex);
      }
      
    }
    float scl = points[i][2]/(zSpacing*points.length);
    scl*=(1+sin(tm))/2;
    points[i][0] = scl*(circumference)*cos(tm+pctThru*TWO_PI);
    points[i][1] = scl*(circumference)*sin(tm+pctThru*TWO_PI);
  }
  
  //draw
  //set far plane way out.
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, width/height, 0.01, 1000000);
  
  background(0);
  lights();
  noStroke();
//  stroke(255);
  noFill();
  translate(width/2,height/2,0);
  for(int i = 0; i < points.length; i++)
  {
    float tPercent = i*1.f/points.length;
    float c = -points[i][2]/(zSpacing*points.length);
    fill(255*c);
    beginShape(TRIANGLE_STRIP);
    int edgeCount = 40;
    float tunnelRadius = 800.f;
    
    if(breakIndex != i)//|| !(breakIndex == (points.length-1)) && i==0)
    {
      for(int j = 0; j < edgeCount+1; j++)
      {
        //current radian
        float curRad = j*TWO_PI/(edgeCount);
        //depth scaling
        float scl = 1+points[i][2]/(zSpacing*points.length);   
        //radius of the tunnel
        float curRadius = scl*(jitterOffSets[i]+tunnelRadius); 
        vertex( points[i][0]+curRadius*cos(curRad), 
                points[i][1]+curRadius*sin(curRad), 
                points[i][2] );
                
        //index to connect the last to
        int nextIndex = (i+1)%(points.length);
        scl = 1+points[nextIndex][2]/(zSpacing*points.length);
        float nextRadius = scl*(jitterOffSets[nextIndex]+tunnelRadius);
        vertex( points[nextIndex][0]+nextRadius*cos(curRad), 
                points[nextIndex][1]+nextRadius*sin(curRad), 
                points[nextIndex][2] );
      }
      
    }
//    else
//      {
//        println("not drawing: " + i);
//      }
    endShape();
  }
}
