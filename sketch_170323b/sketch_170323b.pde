PartSys partSys = new PartSys();
void setup()
{
  size(800,800);
}

void draw()
{
  for(int i = 0; i < 10; i++)
  {
    float[] noises = new float[]{random(1),
                                 random(TWO_PI)};
    partSys.createNewParticle(new float[]{mouseX,mouseY},
                              new float[]{noises[0]*cos(noises[1]),
                                          noises[0]*sin(noises[1])});
  }
  partSys.update();
  partSys.draw();
}

void mouseClicked()
{
  
}
