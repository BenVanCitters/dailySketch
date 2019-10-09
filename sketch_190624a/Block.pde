class Block
{
  int mass = 5;
  float curRadian = 0;
  float curRadius = 0;
  float radianDelta = 0;  
  float vel[]={0,0};
  float pos[]={0,0};
  
  float mpos[]={0,0};
  float r = 25;
  public Block(int mass, float radius)
  {
    this.mass = mass;
    this.r = radius;
  }
  
  void update()
  {
    curRadius = 50*(mass)/5.f;
    curRadian += radianDelta;
    pos[0] = (width + pos[0] + vel[0])%width;
    pos[1] = (height + pos[1] + vel[1])%width;
    
    mpos[0] = (width + pos[0] + curRadius*cos(curRadian))%width;
    mpos[1] = (height + pos[1]+curRadius*sin(curRadian))%width;
  }
  
  void olddraw()
  {
    pushMatrix();
    translate(pos[0],pos[1]);
    rotate(curRadian);
    rect(-r,-r,r,r);
    popMatrix();
  }
  
  void draw()
  {
    pushMatrix();
    translate(mpos[0],mpos[1]);
    rotate(curRadian);
    translate(-r/2,-r/2);
    rect(0,0,r,r);
    popMatrix();
  }
  
  void die()
  {
    if(this.mass > 1)
    {
      
    }
  }
}
