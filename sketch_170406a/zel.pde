class zel extends character
{
  
  float moveDuration = .2;
  zel()
  {
    hp = 5;
    pos = new float[]{0,0};
  }
  

  void draw()
  {
    pushMatrix();
    pushStyle();
    ellipseMode(CENTER);
    
    if(isWounding) 
    {
      fill(255,0,0); 
      translate(random(-5,5),random(-5,5));
    } 
    else if (isDead)
    {
      fill(0); 
    }
    else
    {
      fill(255,255,255); 
    }
    translate(pos[0], pos[1]);
    ellipse(0,0,20,20);
    if(isAttacking)
    {
      
      float radFromDir = (moveDir/4.f)*TWO_PI;
      float[] attackTarget = new float[]{cos(radFromDir), 
                                         sin(radFromDir)};
      ellipse(attackTarget[0]*15,attackTarget[1]*15,
                  attackDist*attackTarget[0], 
                  attackDist*attackTarget[1]);
    }
     popStyle();
    popMatrix();
  }
  
  void doAttackLogic(float dt)
  {
    if(isAttacking)
    {
      curAttackTime -=dt;
      float radFromDir = (moveDir/4.f)*TWO_PI;
      float[] attackTarget = new float[]{cos(radFromDir), 
                                         sin(radFromDir)};
      b.damageToPos(new float[]{pos[0] + attackDist*attackTarget[0], 
                                pos[1] + attackDist*attackTarget[1]},1);
      if(curAttackTime <= 0)
      {
        isAttacking = false;
      }
    }
  }
  
  void update(float dt)
  {
    doWoundingLogic(dt);
    doMoveLogicUpdate(dt);
    doAttackLogic(dt);   
  }
  
  boolean isAttacking = false;
  float attackDuration = .2;
  float curAttackTime = 0;
  float attackDist = 15;
  void beginAttack()
  {
    println("attack!");
    if(isAttacking) return;
    isAttacking = true;
    curAttackTime = attackDuration;    
  }
}
