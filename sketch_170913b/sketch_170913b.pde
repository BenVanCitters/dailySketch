float[] pos={350,350};
Planet p = new Planet();
Planet center = new Planet();
void setup()
{
  size(700, 700);
  background(0);
  center.pos = new float[]{350,350};
  center.mass = 50;
  p.mass = 5;
  p.pos = new float[]{100,200,0};
  p.vel = new float[]{-.4,.5,0};
}


void draw()
{
  //update
  
  float[] diff = {center.pos[0]-p.pos[0],
                  center.pos[1]-p.pos[1]};
  float dst = dist(0,0,diff[0],diff[1]);
  diff[0]/=dst;
  diff[1]/=dst;
  float g = (center.mass*p.mass)/(dst*dst);
  float[] acc = {diff[0]*g,diff[1]*g};
  float[] lastVel = {p.vel[0],p.vel[1],0};
  p.vel[0]+=acc[0];
  p.vel[1]+=acc[1];
  p.pos[0]+=p.vel[0];
  p.pos[1]+=p.vel[1];
  
  //draw
//  background(120);
  ellipse(p.pos[0],p.pos[1],10,10);
  drawLine(p.pos,acc,8000,color(255,0,0));
  drawLine(p.pos,p.vel,500,color(0,255,0));
  ellipse(center.pos[0],center.pos[1],10,10);  
  println(frameRate);
  println("radius: " + dst);
  float angle = angleBetween(lastVel,p.vel);
  println("angle: " + angle);
  println("r*w^2 = " + (dst*angle*angle) + "= grav " + g);
  println("g-a = " +abs((dst*angle*angle) - g) );
}

void drawLine(float[] pos, float[] ln, float s,int c)
{
  pushStyle();
    stroke(c);
    line(pos[0],pos[1],
       pos[0]+ln[0]*s,pos[1]+ln[1]*s);
 popStyle();
}


float angleBetween(float[] a, float[] b)
{
  float lenA = dist(0,0,0,a[0],a[1],a[2]);
  float lenB = dist(0,0,0,b[0],b[1],b[2]);
  float dot = dot(a,b);
  return acos(dot/(lenA*lenB));
}

float dot(float[] a, float[] b)
{
  return a[0]*b[0]+a[1]*b[1]+a[2]*b[2];
}
