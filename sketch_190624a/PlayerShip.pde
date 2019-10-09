class PlayerShip
{
  MissileGroup missileGroup;
  float curRadian = 0;
  float radianDelta = .1;  
  float vel[]={0,0};
  float pos[]={0,0};
  int points = 0;
  float size = 30;
  boolean alive = true;
  private ArrayList<Block> debris = new ArrayList<Block>();
  
  public PlayerShip(MissileGroup missileGroup)
  {
    this.missileGroup = missileGroup;
  }
  
  void update()
  {
    pos[0] = (width + pos[0] + vel[0])%width;
    pos[1] = (height + pos[1] + vel[1])%width;
    for(Block b : debris)
    {
      b.update();
    }
  }
  
  void draw()
  {   
    pushStyle();
    stroke(100,0,100);
    strokeWeight(2);
    if(alive)
    {
      pushMatrix();
      translate(pos[0],pos[1]);
      rotate(curRadian);
      //translate(-5,-5);
      triangle(-15,15,
                20,0,
              -15,-15);
      //rect(0,0,30,10);
      
      popMatrix();
    }
    for(Block b : debris)
    {
      pushMatrix();
      translate(b.pos[0],b.pos[1]);
      rotate(b.curRadian);
      line(-8,0,8,0);   
      popMatrix();
    }
    popStyle();
  }
  
  public void fireMissile()
  {
    if(alive)
    {
      Missile m = new Missile();
      m.pos = new float[]{pos[0],pos[1]};
      float speed = 3.5;
      m.vel = new float[]{vel[0]+speed*cos(curRadian),
                          vel[1] + speed*sin(curRadian)};   
      missileGroup.addMissile(m);
    }
  }
  
  void rotateShip(boolean clockwise)
  {
    if(alive)
    {
      if(clockwise)
        curRadian += radianDelta;
      else
        curRadian -= radianDelta; 
    }
  }
  
  void accelerate()
  {
    if(alive)
    {
      float spd = .05;
      vel[0]+= spd*cos(curRadian);
      vel[1]+= spd*sin(curRadian);
    }
  }
  
  void die()
  {
    if(alive)
    {
    pushStyle();
    fill(255,248,200);
    noStroke();
    ellipse(pos[0],pos[1],200,200);
    popStyle();
    for(int i = 0; i < 5; i++)
    {
      Block b = new Block(3,50);
      float speed = random(8);
      float radian = random(TWO_PI);
      b.vel = new float[]{speed*cos(radian),
                          speed*sin(radian)};
      b.pos = new float[]{pos[0],pos[1]};
      b.curRadian = random(TWO_PI);
      b.radianDelta = .5-random(1);                            
      debris.add(b);
    }
    }
    alive = false;
  }
}
