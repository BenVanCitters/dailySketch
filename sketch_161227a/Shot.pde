class Shot
{
  float[] vel ={0,0};
  float[] pos ={0,0};
  
  void update(float dt)
  {
    pos[0] += dt * vel[0];
    pos[1] += dt * vel[1];
    
  }
  
  void draw()
  {
    pushMatrix();
      pushStyle();
        noStroke();
        translate(pos[0],pos[1]);
        ellipse(0,0,10,10);
      popStyle();
    popMatrix();
  }
}
