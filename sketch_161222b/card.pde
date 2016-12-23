class card
{
  float[] rotVec = {0,0,0};
  float[] rotVelVec = {1,0,0};
  float[] pos = new float[]{0,0,0};
  float[] dims = new float[]{10,10}; 
  
  card rt;
  card lf;
  
  void split()
  {
    rt = new card();
    rt.dims = new float[]{dims[0]/2,dims[1]};
    rt.pos = new float[]{dims[0]/2,-dims[1]};
    rt.rotVec = new float[]{0,0,.3};
    lf = new card();
    lf.dims = new float[]{dims[0]/2,dims[1]};
    lf.pos = new float[]{0,-dims[1]};
    rt.rotVec = new float[]{0,0,-.3};
  }
  
  void draw()
  {
    pushMatrix();
    translate(pos[0],pos[1]);
    rotateX(rotVec[0]);
    rotateY(rotVec[1]);
    rotateZ(rotVec[2]);
    if(rt != null && lf != null )
    {
      rt.draw();
      lf.draw();
    }
    else
    {
      rect(0,0,dims[0],dims[1]);
    }
    popMatrix();
  }
  
  void update(float dt)
  {
    if(rotVec[0] > PI && rt != null && lf != null )
    {
      rt.update(dt);
      lf.update(dt);
    }
    else
    {
      if(rotVec[0] > HALF_PI && rt == null && lf == null)
      {
        split();
      }
      else
      {
        rotVec[0] += dt*rotVelVec[0];
        rotVec[1] += dt*rotVelVec[1];
        rotVec[2] += dt*rotVelVec[2];
      }
    }
  }
}
