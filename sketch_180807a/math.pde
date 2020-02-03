float[] barycentricFromCartesian(float[] cartXY, float[][]tripts)
{
  //lambda1 = ((y2-y3)(x-x3)+(x3-x2)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
  //lambda2 = ((y3-y1)(x-x3)+(x1-x3)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
  //lambda3 = ((y1-y2)(x-x3)+(x2-x1)(y-y3)) / ((y2-y3)(x1-x3)+(x3-x2)(y1-y3))
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
  //result[2] = ((y1-y2)*(x-x3)+(x2-x1)*(y-y3)) / ((y2-y3)*(x1-x3)+(x3-x2)*(y1-y3));//
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
