class BenLight
{
  float[] c={255,255,255};
  float[] rVel={1,1,1};
  float[] rVec={0,0,0};
  float radius = 400;
  
  void update(float dt)
  {
    rVec[0]=(rVec[0]+dt*rVel[0])%TWO_PI;
    rVec[1]=(rVec[1]+dt*rVel[1])%TWO_PI;
    rVec[2]=(rVec[2]+dt*rVel[2])%TWO_PI;
  }
  
  void place(PGraphics p)
  {
    p.pushMatrix();
    p.rotateX(rVec[0]);
    p.rotateY(rVec[1]);
    p.rotateZ(rVec[2]);
    p.translate(radius,0);
    p.spotLight(c[0],c[1],c[2], //color
                0,0,0, //position
                -1,0,0,  //direction
                PI/8, 2);//angle, concentration
//    p.pointLight( c[0],c[1],c[2], 0,0,0);
    p.popMatrix();
  }
}
