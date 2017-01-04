class Circ
{
  ArrayList<Circ> children = new ArrayList<Circ>();
  float radius = 0;
  //pos and vel are in spherical coords
  float[] pos = {0,random(PI),random(TWO_PI)}; //r, theta, phi
  float[] vel={0,random(.03),random(.03)};//r, theta, phi
  
  public Circ(float radius)
  {
    this.radius = radius;
    pos[0] = 0;
    spawnChildren(1);
  }
  
  public Circ(float parentRadius, int depth)
  {
    radius = parentRadius*.3 + random(.5*parentRadius);
    pos[0] = parentRadius*.5 + random(.5*parentRadius);;
    spawnChildren(depth);
  }
  
  void spawnChildren(int depth)
  {
    if( depth < 4)
    {
      int count = (int)random(10);
      for(int i = 0; i < count; i++)
      {
        children.add(new Circ(radius,depth+1));
      }
    }
  }
  
  void draw()
  {
    float[] xyz = {pos[0] * sin(pos[1]) * cos(pos[2]),
                   pos[0] * sin(pos[1]) * sin(pos[2]),
                   pos[0] * cos(pos[1])};
    pushMatrix();
    translate(xyz[0],xyz[1],xyz[2]);
    noStroke();
    fill(164,159,55);
    shininess(100.0); 
    sphere(radius);
    for(Circ c : children)
    {
      c.draw();
    }
    popMatrix();
    
  }
  
  void update()
  {
    for(int i= 0; i < 3; i++)
    {pos[i]+=vel[i];}
        for(Circ c : children)
      {
        c.update();
      }
  }
}
