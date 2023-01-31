float[][] tripoints= {{10,10},{100,600},{500,20}};
float[] pt = {700/2,700/2};
float[] bvel = {.001,.001,0};
void setup()
{
  size(700,700);
  float radius = 700/2.f;
  float[] center = {width/2,height/2};
  tripoints= new float[][]{{center[0]+radius*cos(0),center[1]+radius*sin(0)},
                           {center[0]+radius*cos(TWO_PI/3),center[1]+radius*sin(TWO_PI/3)},
                           {center[0]+radius*cos(2*TWO_PI/3),center[1]+radius*sin(2*TWO_PI/3)}};
}

void draw()
{
  //background(0,200,255);
  beginShape(TRIANGLES);
  for(int i = 0; i < tripoints.length;i++)
  {
    vertex(tripoints[i][0],tripoints[i][1]);
  }
  endShape();
  for(int i = 0; i < tripoints.length;i++)
  {
    ellipse(tripoints[i][0],tripoints[i][1],5,5);
  }
  float[] mouseXY = {mouseX,mouseY};
  float[] bary = barycentricFromCartesian(mouseXY,tripoints);
  //println("bc: " + bary[0] + ", " + bary[1] + ", " + bary[2] ); 
 movePt();
 //renderbarycentricTriPixels();
}

void renderbarycentricTriPixels()
{
    loadPixels();
  for(int i = 0; i < pixels.length; i++)
  {
    float[] xy = {i%width,i/width};
    float[] b = barycentricFromCartesian(xy,tripoints);
    if (b[0] > 0 && b[1] > 0 && b[2] > 0)
    {
      pixels[i] = color(255*b[0],b[1]*255,b[2]*255);
    }
    else 
    {
      pixels[i] = color(0);
    }
  }
    updatePixels();
}

void movePt()
{
  float[] vel = baryToCart(bvel,tripoints);
  float[] nPos = {pt[0] + vel[0],pt[1] + vel[1]};
  
  float[] b = barycentricFromCartesian(nPos,tripoints);
  if ((b[0] < 0)||(b[1] < 0)||(b[2] < 0)){
         float t = b[0]; b[0] = b[1]; b[1] = b[2]; b[2] = t; 
     pt = baryToCart(b,tripoints);
     t = bvel[0]; bvel[0] = bvel[1]; bvel[1] = bvel[2]; bvel[2] = t;}
  vel = baryToCart(bvel,tripoints);
  println("bvel: " + bvel[0] + "," + bvel[1] + ", " + bvel[2]);
  println("vel: " + vel[0] + "," + vel[1] );
  println("pt: " + pt[0] + "," + pt[1] );
  println("b: " + b[0] + "," + b[1] + ", " + b[2]);
  pt[0] += vel[0];
  pt[1] += vel[1];
  
  ellipse(pt[0],pt[1],5,5);
}

float[] barycentricFromCartesian(float[] cartXY, float[][]tripts)
{
  //lambda1 = ((y2-y3)(x-x3)+(x3-x2)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
  //lambda2 = ((y3-y1)(x-x3)+(x1-x3)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
  //lam3 = 1-lambda1-lambda2
  float[] result = {0,0,0};
  float x1 = tripts[0][0];
  float x2 = tripts[1][0];
  float x3 = tripts[2][0];
  float y1 = tripts[0][1];
  float y2 = tripts[1][1];
  float y3 = tripts[2][1];
  float x = cartXY[0];
  float y = cartXY[1];
  float xMx3 = (x-x3);
  float x1Mx3 = (x1-x3);
  float yMy3 = (y-y3);
  float x3Mx2 = (x3-x2);
  float y2My3 = (y2-y3);
  float denom = (y2My3*x1Mx3+x3Mx2*(y1-y3));
  result[0] = (y2My3*xMx3+x3Mx2*yMy3) / denom;
  result[1] = ((y3-y1)*xMx3+x1Mx3*yMy3) / denom;
  result[2] = 1- result[0]-result[1];
  return  result;
}

float[] baryToCart(float[] bary, float[][] tris)
{
  float[] result={0,0};
  result[0] = bary[0]*tris[0][0]+bary[1]*tris[1][0]+bary[2]*tris[2][0];
  result[1] = bary[0]*tris[0][1]+bary[1]*tris[1][1]+bary[2]*tris[2][1];
  
  return result;
}
