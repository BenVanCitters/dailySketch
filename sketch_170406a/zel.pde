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
    noStroke();
    if(isWounding) //red for just wounded
    {
      fill(255,0,0); 
      translate(random(-5,5),random(-5,5));
    } 
    else if (isDead) //dead
    {
      fill(0); 
    }
    else if(hp < 2) //flashing if low life
    {
      if((millis()/333)%2==0)
      {
        fill(255,255,255);
      }
     else  
      {
        fill(255,0,0);
      }
    }
    else
    {
      fill(255,255,255); 
    }
    translate(pos[0], pos[1]);
    ellipse(0,0,20,20); //circle for the player
    if(isAttacking)
    {  
      float radFromDir = (moveDir/4.f)*TWO_PI;
      rotate(radFromDir);
      fill(90);      
      ellipse(10,0, attackDist, 2);//sword
      ellipse(5,0,2, 5);//hilt
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
      //we should have a way, way better technique to distribute
      // damage to targets
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
//    println("attack!");
    if(isAttacking) return;
    isAttacking = true;
    curAttackTime = attackDuration;    
  }
}
