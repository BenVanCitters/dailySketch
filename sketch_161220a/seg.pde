class CircSeg
{
  public float curVal;
  public float targetVal;
  public float curVel;
  public float curAccel;
  public float speedConst = 1.f/15;
  
  void update()
  {
    curAccel = (targetVal-curVal)*speedConst;
    curVel += curAccel;
    curVel *= .95;
    curVal += curVel;
  }
  
}

