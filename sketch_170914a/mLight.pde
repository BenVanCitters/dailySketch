class mLight
{
  float [] spds = new float[3];
  float [] offsets = new float[3];
  float [] dir = new float[3];
  float [] rgbColor = new float[3];
  
  public mLight()
  {
    spds[0] = random(-1,1);
    spds[1] = random(-1,1);
    spds[2] = random(-1,1);
    
    offsets[0] = random(TWO_PI);
    offsets[1] = random(TWO_PI);
    offsets[2] = random(TWO_PI);
    
    rgbColor[0] = random(255);
    rgbColor[1] = random(255);
    rgbColor[2] = random(255);
  }
  
  void update(float tm)
  {
    //spds = new float[3];
    dir[0] = sin(spds[0]*tm + offsets[0]);
    dir[1] = sin(spds[1]*tm + offsets[1]);
    dir[2] = sin(spds[2]*tm + offsets[2]);
    dir = normalize(dir);
     
  }
}
