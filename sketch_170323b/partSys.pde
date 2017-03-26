class PartSys
{
  ArrayList<Part> parts= new ArrayList<Part>();
  PartSys()
  {
    
  }
  
  void update()
  {
    float tm = millis()/1000.f;
    ArrayList<Part> deadParts= new ArrayList<Part>();
    for(Part p : parts)
    {
      float[] vel = getNoiseVel(p.pos,tm);
      p.vel[0]+=vel[0];
      p.vel[1]+=vel[1];
      p.pos[0]+=p.vel[0];
      p.pos[1]+=p.vel[1];
      
     if((p.pos[0] > width || p.pos[0] < 0) || 
     (p.pos[1] > height || p.pos[1] < 0))
     {
       deadParts.add(p);
     } 
    }
    parts.removeAll(deadParts);
  }
  
  
  void draw()
  {
    float tm=millis()/1000.f;
    for(Part p : parts)
    {
      pushMatrix();
      translate(p.pos[0],p.pos[1]);
      fill(p.c);
      noStroke();
      float sz = 3+20*(1+sin(tm*3+(p.pos[0]+p.pos[1])*.005125))/2;
//    float sz = 3+15*noise(p.pos[0]*.06,p.pos[1]*.06, tm*.1);
      ellipse(0,0,sz,sz);
      popMatrix();
    }
    println("sz: " + parts.size());
  }
  
  float[] getNoiseVel(float[] pos, float tm)
  {
    float[] scaledPos = new float[]{pos[0]*.2,pos[1]*.2};
    float[] noises = new float[]{noise(scaledPos[0],scaledPos[1],tm),
                       50*TWO_PI*noise(scaledPos[0],tm+3,scaledPos[1])};
    float maxSz = .5;
    return new float[]{maxSz*noises[0]*cos(noises[1]),
                       maxSz*noises[0]*sin(noises[1])};
  }
  
  void createNewParticle(float[] pos, float[] vel)
  {
    float t = millis()/1000.f;
    int c = color(rnd(t),
                  rnd(t/5+15),
                  rnd(t/2+50));
    Part p = new Part(pos,vel,c);
    parts.add(p);
  }
  
  float rnd(float t)
  {
    return random(20)+(256-20)*noise(t);
  }
}
class Part
{
  float pos[];
  float vel[];  
  int c;
  Part(float[] p, float[] v, int c)
  {
    pos = p; 
    vel = v;
    this.c = c;
  }
}
