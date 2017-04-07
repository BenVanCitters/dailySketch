class baddies
{
  ArrayList<baddie> baddis = new ArrayList<baddie>();
  baddies()
  {
    for (int i = 0; i < 12; i++)
    {
      baddie b = new baddie();
      baddis.add(b);
    }
  }

  void update(float dt)
  {
    for (baddie b: baddis)
    {
      b.update(dt);
      float d = b.distTo(z.pos);
      if(d < 5 && !b.isDead)
      {
         z.beginWound(1);
      }
    }
  }

  void draw()
  {
    for (baddie b: baddis)
    {
      b.draw();
    }
  }
  
  void damageToPos(float[] pos, int dmg)
  {
    for (baddie b: baddis)
    {
      float d = b.distTo(pos);
//      println("dist: " + d);
      if(d < 15)
      {
        b.beginWound(dmg);
      }
    }
  }
}

