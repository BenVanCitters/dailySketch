class Missile
{
  float vel[]={0,0};
  float pos[]={0,0};
  float size = 10;
  public Missile()
  {
  }
  
  void update()
  {
    pos[0]+=vel[0];
    pos[1]+=vel[1];
  }
  
  void draw()
  {
    pushMatrix();
    pushStyle();
    translate(pos[0],pos[1]);
    stroke(255,0,0);
    noFill();
    float sz = 7 + 3 * (sin(millis()/100.f)+1)/2.f;
    ellipse(0,0,sz,sz);
    popStyle();
    popMatrix();
  }
  
  void die()
  {
  } 
}
