class Liner
{
  ArrayList<float[]> points = new ArrayList<float[]>();
  float[] vel = {0,0,0};
  double[] sumvel = {0,0,0};
  float[] pos = {0,0,0};
  int maxSz = 1000;
  Liner()
  {
    
  }
  
  float[] myNoise(float[] pos, float tm)
  {
    return new float[]{noise(tm*1.5+pos[1],  tm*1.2+pos[2],  tm*1.1+pos[0]) - .46,
                       noise(tm*0.8+pos[0],  tm*0.1+pos[2],  tm*1.5+pos[1]) - .46,
                       noise(tm*1.7+pos[2], tm*0.87+pos[1], tm*1.02+pos[0]) - .46};
  }
  
  String isneg(float f)
  {
    return f < 0 ? "-" : "+"; 
  }
  
  void update()
  {
    float tm = millis()/100000.f;
    int steps = 10;
    for(int i = 0; i < steps; i++)
    {
      float scaleFact = 0.8;
      float[] acc = myNoise(pos,tm);
//      println("acc: " + isneg(acc[0]) + "," + isneg(acc[1]) + "," + isneg(acc[2]));
      vel[0] += acc[0]*scaleFact;
      vel[1] += acc[1]*scaleFact;
      vel[2] += acc[2]*scaleFact;
      sumvel[0] += vel[0]; sumvel[1] += vel[1]; sumvel[2] += vel[2]; 
      float amt = .9;
      vel[0] *= amt; vel[1] *= amt; vel[2] *= amt;
      float[] tmp = {pos[0]+vel[0],pos[1]+vel[1],pos[2]+vel[2]};
      if(tmp[0] > width || tmp[0] < 0)
      {
        vel[0]*=-1;
      }
      if(tmp[1] > height || tmp[1] < 0)
      {
        vel[1]*=-1;
      }
      
      pos[0] += vel[0]; pos[1] += vel[1]; pos[2] += vel[2]; 
      points.add(new float[]{pos[0],pos[1],pos[2]});
    } 
    int c = frameCount*10;
    println("sumvel: " + sumvel[0]/c + "," + sumvel[1]/c + "," + sumvel[2]/c);
    //add point(s)
    
    //cull points
    while(points.size()> maxSz)
    {
      points.remove(0);
    }
  }
  
  void draw()
  {
    noFill();
    beginShape();
    for(float[] pt : points)
    {
      vertex(pt[0],pt[1],pt[2]);
    }
    endShape();
  }
}
