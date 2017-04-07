class character
{
  float[] oldpos = new float[]{0,0};
  float[] pos= new float[]{0,0};
  int hp;
  boolean isDead = false;
  float moveLength = 20;  

  float distTo(float[] p)
  {
    return dist(p[0],p[1],pos[0],pos[1]);
  }

  void draw()
  {
    
  }
  
  void update(float dt)
  {
    
  }
  
  void beginAttack()
  {
    
  }
 
 void doWoundingLogic(float dt)
  {
    if(isWounding)
    {
      if(hp <= 0)
      {
        //die
        println("dies");
        isDead = true;
      }
      else
      {
        curWoundTime -= dt;
        if(curWoundTime <= 0)
        {
          isWounding = false;
        }
      }
    }
  }
  boolean isWounding = false;
  float woundDuration = .5;
  float curWoundTime = 0;
  void beginWound(int dmg)
  {
    if(isWounding) return;
    println("wounding!!");
    hp -= dmg;
    isWounding = true;
    curWoundTime = woundDuration;
  }
 
  boolean isMoving = false;
  int moveDir = 0;
  float moveDuration = .2;
  float curMoveTime = 0;
  float[] moveTarget = new float[]{0,0};
  
  public void beginMove(int dir)
  {
    if(isMoving) return;
    moveDir = dir;
    oldpos[0] = pos[0]; oldpos[1] = pos[1];
    isMoving = true;
    curMoveTime = moveDuration;
    float radFromDir = (dir/4.f)*TWO_PI;
    moveTarget = new float[]{moveLength*cos(radFromDir), 
                             moveLength*sin(radFromDir)};
    moveTarget[0]+=pos[0]; moveTarget[1]+=pos[1];                     
  }
  
  void doMoveLogicUpdate(float dt)
  {
    if(isMoving)
    {
      curMoveTime -= dt;
      float pctMove = 1-curMoveTime/moveDuration;
      float[] diff = new float[]{moveTarget[0]-oldpos[0],
                                 moveTarget[1]-oldpos[1]};
      pos[0] = oldpos[0] + diff[0]*pctMove;
      pos[1] = oldpos[1] + diff[1]*pctMove;
      if( curMoveTime <= 0) //done moving
      {
        pos[0] = moveTarget[0];
        pos[1] = moveTarget[1];
        isMoving = false; 
      } 
    }    
  }
}
