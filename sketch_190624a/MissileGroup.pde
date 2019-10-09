class MissileGroup
{
  private ArrayList<Missile> missiles = new ArrayList<Missile>();
  
  public MissileGroup()
  {
    
  }
  
  void addMissile(Missile m)
  {
    missiles.add(m);
  }
  
  void update()
  {
    ArrayList<Missile> deadMissiles = new ArrayList<Missile>();
    for(Missile m : missiles)
    {
      m.update();
      if(m.pos[0] < 0 || m.pos[0] > width || m.pos[1] < 0 || m.pos[1] > height)
      {
        deadMissiles.add(m);
      }
    }
    missiles.removeAll(deadMissiles);
  }
  
  void draw()
  {
    for(Missile m : missiles)
    {
      m.draw();
    }
  }
}
