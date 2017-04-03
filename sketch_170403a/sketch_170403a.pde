ArrayList<arcc> arcs = new ArrayList<arcc>();
ArrayList<arcc> arcs2 = new ArrayList<arcc>();
void setup()
{
  size(500,500,P3D);
  int num = 17;
  for(int i = 0; i < num; i++)
  {
    float iPct = i*1.f/num;
    arcc a = new arcc();
    float radius = 50+(10+16)*i;
    a.curWidth = HALF_PI * sin(iPct*PI);
    a.curRadius = radius;
    a.velFactor = .2+random(.1);
    a.curDamping = .8+random(.05);
    arcs.add(a);
  }
  
  for(int i = 0; i < num; i++)
  {
    float iPct = i*1.f/num;
    arcc a = new arcc();
    float radius = 37+(10+16)*i;
    a.curWidth = HALF_PI * sin(iPct*PI);
    a.curRadius = radius;
    a.velFactor = .2+random(.1);
    a.curDamping = .8+random(.05);
    arcs2.add(a);
  }
}

void draw()
{
  float targetRadian = (int)((millis()/1000.f))*HALF_PI/2 ;
  
  background(80,100,240);
  noFill();
  stroke(255);
  strokeWeight(5);
  pushMatrix();
  translate(width/2, height/2);
  int num = 20;
  float tm = millis()/1000.f;
  int i = 0;
  for(arcc a: arcs)
  {
    float diff = (targetRadian-a.curWidth/2) - a.curRadian;
    a.curVel += diff*a.velFactor;
    a.curRadian += a.curVel;
    a.curVel *= a.curDamping;
    arc(0, 0, 
        a.curRadius, a.curRadius, 
        a.curRadian,a.curRadian+a.curWidth);
        i++;
  }
  
  stroke(255,160,0);
  for(arcc a: arcs2)
  {
    float diff = (-targetRadian-a.curWidth/2) - a.curRadian;
    a.curVel += diff*a.velFactor;
    a.curRadian += a.curVel;
    a.curVel *= a.curDamping;
    arc(0, 0, 
        a.curRadius, a.curRadius, 
        a.curRadian,a.curRadian+a.curWidth);
        i++;
  }
  popMatrix();
}
