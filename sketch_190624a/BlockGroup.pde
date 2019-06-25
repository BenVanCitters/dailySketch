class BlockGroup
{
  private ArrayList<Block> blocks;
  PlayerShip ship;
  MissileGroup missileGroup;
  PFont font;
  public BlockGroup(int blockCount, PlayerShip ship, MissileGroup missileGroup)
  {
    font = createFont("Impact",48);
    this.missileGroup = missileGroup;
    this.ship = ship;
    blocks = new ArrayList<Block>();
    for(int i = 0; i < blockCount; i++)
    {
      Block b = new Block(3, 50);
      float speed = .1+ random(2);
      float radian = random(TWO_PI);
      b.vel = new float[]{speed*cos(radian),
                          speed*sin(radian)};
      b.pos = new float[]{random(width),
                          random(height)};
      b.curRadian = random(TWO_PI);
      b.radianDelta = .1-random(.2);                            
      blocks.add(b);
    }
  }
  
  void update()
  {
    //move
    for(Block b : blocks)
    {
      b.update();
    }
    
    //collide
    
    ArrayList<Block> deadBlocks = new ArrayList<Block>();
    for(Block b : blocks)
    {
      float player_dist = dist(b.mpos[0],b.mpos[1],
                               ship.pos[0],ship.pos[1]);
       
       
    float collisionThreshhold = ship.size + b.r/2;
      if(player_dist < collisionThreshhold)
      {
        pushStyle();
        stroke(0,100,0);
        strokeWeight(8);
        line(b.pos[0],b.pos[1],
             ship.pos[0],ship.pos[1]);
        popStyle();
        //damage player
        //println("KILL " + b.pos[0] + " , " + b.pos[1] + "d");
        ship.die();
      }
      ArrayList<Missile> deadMissiles = new ArrayList<Missile>();
      for(Missile m : missileGroup.missiles)
      {
         float missile_dist = dist(b.mpos[0],b.mpos[1],
                               m.pos[0],m.pos[1]);
          float min_dist = m.size/2 + b.r/2;
          if(missile_dist < min_dist)
          {
            deadBlocks.add(b);
            deadMissiles.add(m);
          }
      }
      missileGroup.missiles.removeAll(deadMissiles);
    }
    
    //kill - remove dead
    blocks.removeAll(deadBlocks);
    for(Block bd : deadBlocks)
    {
      ship.points += 1;
      pushStyle();
      pushMatrix();
      fill(255,0,0);
      stroke(255,0,0);
      //noStroke(); 
      translate(bd.mpos[0],bd.mpos[1]);
      textSize(50);
      textFont(font);
      String s = "" + ship.points;
      float w = textWidth(s);
      rotate(random(TWO_PI));
      text(s, -w/2,-25);
      
      //ellipse(bd.pos[0],bd.pos[1],100,100);
      popStyle();
      popMatrix();
      if(bd.mass > 0)
      {
        int newCount = 3;
        for(int i = 0; i < newCount; i++)
        {
          Block b = new Block(bd.mass -1,bd.r/1.5 );
          float speed = .3+ random(2);//1.2* dist(0,0,bd.vel[0],bd.vel[1]);
          float radian = random(TWO_PI);
          b.vel = new float[]{speed*cos(radian),
                              speed*sin(radian)};
          b.pos = new float[]{bd.mpos[0],bd.mpos[1]};
          b.curRadian = random(TWO_PI);
          b.radianDelta = .1-random(.2);                            
          blocks.add(b);
        }
      }
    }
  }
  
  void draw()
  {
    for(Block b : blocks)
    {
      b.draw();
    }
  }
}
