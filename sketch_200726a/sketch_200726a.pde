
pt[] pts = new pt[500];
void setup()
{
  size(700,700,P3D);
  for(int i=0; i < pts.length; i++)
  {
    pts[i] = new pt();
    pts[i].pos[0] = random(700); 
    pts[i].pos[1] = random(700); 
    pts[i].pos[2] = random(50);
    
    pts[i].vel[0] = random(-2,2); 
    pts[i].vel[1] = random(-2,2); 
    pts[i].vel[2] = random(-2,2);    
  }
}

void draw()
{
  background(200);
  update();
  //draw
  translate(width/2,height/2);
  rotateX(millis()/10000.f);
  rotateY(millis()/9070.f);
  rotateZ(millis()/13000.f);
  for(int i =0; i < pts.length; i++)
  {
    pushMatrix();
      translate(pts[i].pos[0],
                pts[i].pos[1],
                pts[i].pos[2]);
      ellipse(0,0,10,10);
    popMatrix();
  }
}

void update()
{
  float[] centerPos = {0,0,0};
  for(int i =0; i < pts.length; i++)
  {
    //find acc
    float[] acc = {0,0,0};
    for(int j =0; j < pts.length; j++)
    {
      float d = 0.0000000000001+dist(pts[i].pos[0], pts[i].pos[1], pts[i].pos[2],
                     pts[j].pos[0], pts[j].pos[1], pts[j].pos[2]);
      float[] diff = {pts[i].pos[0] - pts[j].pos[0],
                      pts[i].pos[1] - pts[j].pos[1],
                      pts[i].pos[2] - pts[j].pos[2]};
      float[] nDiff = {diff[0]/d,diff[1]/d,diff[2]/d};
      float amt = 1.f/( (d/20)*(d/20));
      
      acc[0] += amt*nDiff[0];
      acc[1] += amt*nDiff[1];
      acc[2] += amt*nDiff[2];
      //acc[0] = 0;//acc[0]+amt*nDiff[0];
      //acc[1] = 0;//acc[1]+amt*nDiff[1];
      //acc[2] = 0;//acc[2]+amt*nDiff[2];
    }
    pts[i].vel[0] += acc[0]; 
    pts[i].vel[1] += acc[1]; 
    pts[i].vel[2] += acc[2];
    
    pts[i].pos[0] += pts[i].vel[0]; 
    pts[i].pos[1] += pts[i].vel[1]; 
    pts[i].pos[2] += pts[i].vel[2];
    //map to sphere
    float d = dist(centerPos[0],centerPos[1],centerPos[2],
                   pts[i].pos[0],pts[i].pos[1],pts[i].pos[2]);
    pts[i].pos[0] -= centerPos[0]; 
    pts[i].pos[1] -= centerPos[1]; 
    pts[i].pos[2] -= centerPos[2];
    
    float sphereSz = 300.f;
    pts[i].pos[0] *= sphereSz/d;
    pts[i].pos[1] *= sphereSz/d;
    pts[i].pos[2] *= sphereSz/d;

    pts[i].pos[0] += centerPos[0]; 
    pts[i].pos[1] += centerPos[1]; 
    pts[i].pos[2] += centerPos[2];                  
  }
}

class pt
{
  float[] pos = new float[3];
  float[] vel = new float[3];
  
}
