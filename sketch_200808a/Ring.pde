class Ring
{
  RingParticle[] particles;
  springNums[][] springMatrix;
  class springNums
  {
    public float k;
    public float x;
    public springNums(float _k, float _x){k=_k;x=_x;}
    
  }
  
  public Ring(int particleCount)
  {
    //int particleCount = 80;
    setupParticles(particleCount);
    setupSprintMatrix(particleCount);
  }
  
  void setupSprintMatrix(int particleCount)
  {
    //j = 
    springMatrix = new springNums[particleCount][particleCount];
    for(int i = 0; i < particleCount; i++)
    {
      for(int j = i; j < particleCount; j++)
      {
        float ijDiff = abs(i-j)*1.f/11.f;
        float[] diffV = subV( particles[j].pos, particles[i].pos );
        float partDist = .000001+dist(0,0,0,diffV[0],diffV[1],diffV[2]);
        springMatrix[i][j] = new springNums(.0005,//random(.001),
                                            partDist+112*sin(11+ijDiff));
      }
    }
  }
  
  springNums springConst(int i, int j)
  {
    springNums result = springMatrix[i][j];
    if(result == null)
      result = springMatrix[j][i];
    return result;
  }
  
  void setupParticles(int particleCount)
  {
    particles = new RingParticle[particleCount];
    //create particles
    for(int i = 0; i < particles.length; i++)
    {
      particles[i] = new RingParticle();
    }
    
    //postition particles
    float[] midPt = {width/2.f,height/2.f,0};
    for(int i = 0; i < particles.length; i++)
    {
      float curRad = i*TWO_PI/ particles.length;
      float[] unitCirc = {cos(curRad),sin(curRad),0};
      float radius = 200;
      particles[i].pos = addV(midPt, multSV(unitCirc,radius));
    }

  }
  
  void update(float dt)
  {
    //calc all new force
    for(int i = 0; i < particles.length; i++)
    {
      particles[i].acc = zero3();
      for(int j = 0; j < particles.length; j++)
      {
        if(i == j)
          continue;
          
        float[] diffV = subV( particles[j].pos, particles[i].pos );
        float partDist = .000001+dist(0,0,0,diffV[0],diffV[1],diffV[2]);
        //if(partDist > 100) continue;
        //if(abs(i-j) < 3) continue;
        float[] norm = multSV(diffV, 1.f/partDist);
        //F = -kx Hooke's law
        springNums spn = springConst(i,j);
        float x = spn.x - partDist;
        float k = spn.k;//.001;
        float F = -k*x;
        float[] acc = multSV(norm,F);
        particles[i].acc = addV(particles[i].acc, acc);
     //particles[i].vel[0] = particles[p];      
      }
    }
    
    //update vel, pos
    for(int i = 0; i < particles.length; i++)
    {
      //println("particles[" + i + "] " + particles[i].strg());
      particles[i].vel = addV(particles[i].vel, multSV(particles[i].acc,1));
      particles[i].pos = addV(particles[i].pos, multSV(particles[i].vel,1));
    }
  }
  
  void draw()
  {
    for(int i = 0; i < particles.length; i++)
    {
      stroke(0);
      //ellipse(particles[i].pos[0], particles[i].pos[1],10,10);
      //stroke(0,255,0);
      //line(particles[i].pos[0], particles[i].pos[1],
      //     particles[i].pos[0]+particles[i].vel[0], particles[i].pos[1]+particles[i].vel[1]);
           
      stroke(0,255,0);
      //drawLineFrom(particles[i].pos,particles[i].vel);
      
      stroke(255,0,0);
      //drawLineFrom(particles[i].pos, multSV(getNorm(particles[i].acc),10));
      //line(particles[i].pos[0], particles[i].pos[1],
      //     particles[i].pos[0]+particles[i].vel[0], particles[i].pos[1]+particles[i].vel[1]);
    }
    for(int i = 0; i < particles.length; i++)
    {
      int nexti = (i+1)%particles.length;
      drawLine(particles[i].pos,particles[nexti].pos); 
    }
  }
  
}

class RingParticle
{
  public RingParticle a;
  public RingParticle b;
  public float mass = 1;
  public float[] pos = {0,0,0};
  public float[] vel = {0,0,0};
  
  public float[] acc = {0,0,0};
  
  public RingParticle()
  {
    
  }
  public String strg()
  {
    return ".pos: " + VtoS(pos) + " vel: " + VtoS(vel) + " acc: " + VtoS(acc);
  }
}
