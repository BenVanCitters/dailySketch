class particles
{
  ArrayList<PrimParts> balls = new ArrayList<PrimParts>(); 
  ArrayList<SecParts> shraps = new ArrayList<SecParts>();
 
 PGraphics bloodBuffer;
 particles()
 {
   bloodBuffer = createGraphics(width/8,height/8,P2D);
 }
 void draw()
 {
   bloodBuffer.beginDraw();
   bloodBuffer.noStroke();
   bloodBuffer.fill(255,0,0);
   bloodBuffer.noSmooth();
   float xscale = bloodBuffer.width*1.f/width;
   for(SecParts p : shraps)
   {
     bloodBuffer.pushMatrix();
     bloodBuffer.scale(xscale);
     bloodBuffer.translate(p.pos[0],p.pos[1]);
     bloodBuffer.ellipse(0,0,5,5);
     bloodBuffer.popMatrix();
     pushMatrix();
     translate(p.pos[0],p.pos[1]);
     fill(128,128,0);
     rect(0,0,10,10);
     popMatrix();
   }
   bloodBuffer.fill(255,255,255,5);
   bloodBuffer.rect(0,0,bloodBuffer.width,bloodBuffer.height);
//   bloodBuffer.filter(BLUR);
   bloodBuffer.endDraw();
   image(bloodBuffer,0,0,width,height);
   
   for(PrimParts p : balls)
   { 
     pushMatrix();
     translate(p.pos[0],p.pos[1]);
     noStroke();
     fill(0,0,0);
     ellipse(0,0,20,20);
     popMatrix();
   }
 }
 
 void update(float dt)
 {
   float grav = 610;
   ArrayList<PrimParts> deadPrims = new ArrayList<PrimParts>();
   for(PrimParts p : balls)
   {     
     p.vel[1]+=grav*dt;
     float[] newPos = {p.pos[0] + p.vel[0]*dt, 
                       p.pos[1] + p.vel[1]*dt};
     boolean collided = false;
     if(newPos[0] > width)
     { newPos[0] = newPos[0]-(newPos[0]-width); p.vel[0]*=-1; collided = true;}
     
     if(newPos[0] < 0)
     { newPos[0] *= -1; p.vel[0]*=-1; collided = true;}
     
     if(newPos[1] > height)
     { newPos[1] = newPos[1]-(newPos[1]-width); p.vel[1]*=-1; collided = true;}
     
     if(newPos[1] < 0)
     { newPos[1] *= -1; p.vel[1]*=-1; collided = true;}
     if(collided)
        p.time*=.01;
     p.pos[0] = newPos[0]; p.pos[1] = newPos[1];
     p.update(dt);
     if(p.time < 0)
     { addExplo(p);
       deadPrims.add(p);
     }
   }
   balls.removeAll(deadPrims);
   
   
   ArrayList<SecParts> deadExplo = new ArrayList<SecParts>();
   for(SecParts p : shraps)
   {
     p.vel[1]+=grav*dt;
     float[] newPos = {p.pos[0] + p.vel[0]*dt,
                       p.pos[1] + p.vel[1]*dt};
     if(newPos[0] > width || newPos[0] < 0 || newPos[1] > height || newPos[1] < 0)
     {deadExplo.add(p); }

     p.pos[0] = newPos[0]; p.pos[1] = newPos[1];
   }
   shraps.removeAll(deadExplo);
   
   //add some new balls!
   if(balls.size() < 5)
   {
     PrimParts p = new PrimParts();
     p.time = 2+random(4);
     p.pos = new float[]{random(width),height-1};
     float randomPow = 700+random(200);
     float randRadian = (PI + HALF_PI) + (random(1.5)-.25); 
     p.vel = new float[]{randomPow*cos(randRadian),
                         randomPow*sin(randRadian)};
     balls.add(p);
   }
 }
 
 void addExplo(PrimParts p)
 {
   int count = 15 + (int)random(20);
   for(int i = 0; i < count; i++)
   {
     float power = random(270);
     SecParts par = new SecParts();

     float randRadian = random(TWO_PI);
     par.vel = new float[]{p.vel[0]+power*cos(randRadian),
                           p.vel[1]+power*sin(randRadian)};
     par.pos[0] = p.pos[0]+cos(randRadian)*random(10); 
     par.pos[1] = p.pos[1]+sin(randRadian)*random(10);
     shraps.add(par);
   }
 }
 }
class part
{
  float[] pos = {0,0};
  float[] vel = {0,0};  
  void update(float dt){};
  void draw(){}
  }

class PrimParts extends part
{
  int state = 0; //0 flying 1 waiting to explode
 float time;
 void draw(){}
 void update(float dt)
 { time -= dt;}
 
}

class SecParts extends part
{
  void draw(){}
}
