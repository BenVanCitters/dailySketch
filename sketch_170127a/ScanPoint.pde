class ScanPoint
{
  float acc[] = {0,0,0};
  float vel[] = {0,0,0};
  float pos[] = {0,0,0};
  float targPos[] = {0,0,0};
  int videoPixelIndex = 0;
  public ScanPoint(float nPos[])
  {
    targPos[0] = nPos[0]*width;
    targPos[1] = nPos[1]*height;
    pos[0] = targPos[0];
    pos[1] = targPos[1];
    int[] xy = {(int)(nPos[0]*1280),(int)(nPos[1]*=720)};
    videoPixelIndex = xy[1]*1280+xy[0];
  }
  
  void update(float dt)
  {
    float[] springForce = {-pos[0]+targPos[0],
                           -pos[1]+targPos[1],
                           -pos[2]+targPos[2]};
//    float sprl = dist(0,0,0,springForce[0],springForce[1],springForce[2]);
//    springForce[0]*=.5;springForce[1]*=.5;springForce[2]*=.5;
//    springForce[0]/=sprl; springForce[1]/=sprl; springForce[2]/=sprl;
    acc[0]+=springForce[0]; acc[1]+=springForce[1]; acc[2]+=springForce[2];
    vel[0]+=acc[0];
    vel[1]+=acc[1];
    vel[2]+=acc[2];
    
    pos[0] += vel[0];
    pos[1] += vel[1];
    pos[2] += vel[2];
    vel[0]*=.68;vel[1]*=.68;vel[2]*=.68;
    acc[0]*=.0;acc[1]*=.0;acc[2]*=.0;
  }
  
  
  
}
