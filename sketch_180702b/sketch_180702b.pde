
float[][] startPoss; //= new float[1][1];
float[][] startDirs;// = new float[500][3];
void setup()
{
  size(500,500,P3D);

}

//void setupStartVecs()
//{
//  float[] eyePos = new float[]{0,0,-15};

//    //startPoss[i] = new float[]{5*(u*1.f/w - .51),
//    //                           5*(v*1.f/h - .51),
//    //                           -1};
//}

float[][] getTriPoints(float ra)
{
  float[][] triangle = new float[3][3];
    float r = 10*mouseX*1.f/width;
  float ofs =0;//millis()/1000.f;

  for(int i = 0; i < 3; i++)
  {
    float angle = ofs-i*TWO_PI/3.f;
    triangle[i] = new float[]{r*cos(angle),
                              r*sin(angle),
                              3};
  }
  println(r);
  float d = 5;
  float[] p = {d*cos(ra),d*sin(ra),0};
  for(int i = 0; i < 3; i++)
  {
    triangle[i][0] += p[0];
    triangle[i][1] += p[1];
    triangle[i][2] += p[2];
  }
  return triangle;
}

void draw()
{
  background(0);
  int tricount =5;
    float ofs =1;//millis()/1000.f;
  float[][][] tris = new float[tricount][3][3];

  for(int i = 0; i <tricount; i++)
  {
    tris[i] = getTriPoints(i*TWO_PI/tricount+ofs);
  }
  int onColor = color(255,255,255);
  int offColor = color(0,0,0);
  stroke(255,0,0);
  fill(255,0,0);
  translate(width/2,height/2);
  beginShape(TRIANGLES);
  for(int i = 0; i < tris.length; i++)
  {
    for(int j = 0; j < tris[i].length; j++)
    {
      vertex(tris[i][j][0],
             tris[i][j][1],
             tris[i][j][2]);
    }
      
  }
  
  endShape();
  noFill();
  ellipse(width/2,height/2,5,5);
}
