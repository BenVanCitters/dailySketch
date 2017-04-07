class baddie extends character
{
  baddie()
  {
    hp = 2;
    refreshMoveWait();
    int x = (int)(random(-10,10));
    int y = (int)(random(-10,10));
    pos = new float[]{moveLength*x,moveLength*y};
    oldpos[0] = pos[0]; oldpos[1] = pos[1]; 
  }
  
  void draw()
  {
    pushMatrix();
    translate(pos[0], pos[1]);
    pushStyle();
    rectMode(CENTER);
    if(isDead)
    {
      fill(0);
    }
    else if(isWounding) 
    {
      fill(255,0,0); 
      translate(random(-5,5),random(-5,5));
    }
    else
    {
      fill(255,255,255);
    }
    rect(0,0,20,20);
    popStyle();
    popMatrix();
  }
  
  void refreshMoveWait()
  { curMoveWait = random(maxMoveWait); }  

  float curMoveWait = .2;
  float maxMoveWait = 2.2;
  
  void update(float dt)
  {
    if(isDead) return;
    doWoundingLogic(dt);
    doMoveLogicUpdate(dt);
    if(!isMoving)
    {
      curMoveWait-= dt;
      if( curMoveWait <= 0 )
      {
        int randDir = (int)(random(4));
        beginMove(randDir);
        refreshMoveWait();
      }
    }
  }
}
