class Player
{
  float angle;
  float[] pos ={0,0};
  ArrayList<Shot> shots = new ArrayList<Shot>();
  void draw()
  {
    pushMatrix();
      pushStyle();
        translate(pos[0],pos[1]);
        rotate(angle);
        noStroke();
        fill(255,0,0);
        ellipse(0,0,30,10);
      popStyle();
    popMatrix();
    drawShots();
  }
  
  void fire()
  {
    float speed = 150;
    Shot s = new Shot();
    s.pos[0] = this.pos[0];
    s.pos[1] = this.pos[1];
    s.vel[0] = speed*cos(angle);
    s.vel[1] = speed*sin(angle);
    shots.add(s);
  }
  
  void update(float dt)
  {
    updateShots(dt);
  }
  
  void updateShots(float dt)
  {
    ArrayList<Shot> removals = new ArrayList<Shot>();
    for(Shot s : shots)
    {
      s.update(dt);
      
      //collisions+bounds check.
      if((s.pos[0] < 0 || s.pos[0] > width) ||
         (s.pos[1] < 0 || s.pos[1] > height))
      {
        removals.add(s);
      }
    }
    for(Shot s : removals)
    {
      shots.remove(s);
    }
  }
  
  void drawShots()
  {
    for(Shot s : shots)
    {
      s.draw();
    }
  }
}
