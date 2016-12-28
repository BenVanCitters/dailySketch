class BaddieWrangler
{
  ArrayList<Baddie> baddies = new ArrayList<Baddie>();
  
  BaddieWrangler()
  {
    for(int i = 0; i < 50; i++)
    {
      Baddie b = new Baddie();
      baddies.add(b);
    }
  }
  void update(float dt)
  {
    int i = 0;
    for(Baddie b : baddies)
    {
      float radius = 200;
      float t = i*TWO_PI/baddies.size();
      b.pos[0] = width/2  + radius*cos(t+millis()/4000.f);
      b.pos[1] = height/2 + radius*sin(t+millis()/4000.f);
      
      if(!b.dead)
      {
        for(Shot s : p.shots)
        {
          if(dist(s.pos[0],s.pos[1],b.pos[0],b.pos[1]) < 20)
          {
            b.dead = true;
            b.deathTimer = 15;
//            println("killed");
          }
        }
      }
      b.update(dt);
      i++;
    }
  }
  
  void draw()
  {
    for(Baddie b : baddies)
    {
      b.draw();
    }
  }
}

class Baddie
{
  float[] pos = {0,0};
  boolean dead;
  float deathTimer = 0;
  
  void draw()
  {
    if(!dead)
    {
      pushMatrix();
        pushStyle();
          noStroke();
          fill(0,255,0);
          translate(pos[0],pos[1]);
          ellipse(0,0,10,10);
        popStyle();
      popMatrix();
    }
  }
  
  void update(float dt)
  {
    if(dead)
    {
      deathTimer -= dt;
      
//        println(deathTimer);
      if(deathTimer <= 0)
      {
//        println("relived");
        dead = false;
      }
    }
  }
  
  
}
