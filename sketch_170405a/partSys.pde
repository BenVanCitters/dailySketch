class part
{
  float[] pos = new float[]{0,0};
  float[] vel = new float[]{0,0};
  float timeToDirSwitch;  
}

class partSys
{
  ArrayList<part> parts = new ArrayList<part>(); 
  float spd = 80;
  float[][] vels = new float[][]{{spd,0},{0,spd},{-spd,0},{0,-spd}};
 
 //constructor. create a bunch of particles at the start
 partSys()
 {
   for(int i= 0; i < 100; i++)
   {
     createParticle();
   }
 }
 
 //create and add a particle to the system
 void createParticle()
 {
   part p = new part();
   p.pos = new float[]{random(width),random(height)};
   randomiseVel(p);
   parts.add(p);
 }
 
 //respawn the particle
 void randomiseVel(part p)
 {
   int velIndex = (int)(random(vels.length));
   p.vel[0] = vels[velIndex][0]; 
   p.vel[1] = vels[velIndex][1];
   //direction time vill vary depending on app time
   float sTime = (1+cos(millis()/8000.f))/2;
   p.timeToDirSwitch = random(1*sTime);
 }
 
 //
 void update(float dt)
 {
   //create an array to hold the 'dead' particles
   ArrayList<part> dead = new ArrayList<part>();
   for(part p : parts)
   {
     if((p.pos[0] < 0 || p.pos[0] > width) || 
        (p.pos[1] < 0 || p.pos[1] > height))
     {
       dead.add(p);
       continue;
     }
     
     //decrement directional life
     p.timeToDirSwitch -= dt;
     if(p.timeToDirSwitch <= 0)
     {
       randomiseVel(p);
     }
     //update position w/ velocity
     p.pos[0] += p.vel[0]*dt;
     p.pos[1] += p.vel[1]*dt;
   }
   //respawn
   for(part p : dead)
   {
     createParticle();
   }
   //clear the 'dead'
   parts.removeAll(dead);
 }
 
 void draw()
 {
   for(part p : parts)
   {
     pushMatrix();
     //move into place
     translate(p.pos[0],p.pos[1]);
     box(25);
     popMatrix();
   }
 }
}
