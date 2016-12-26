long lastMillis = 0;
BenLight[] lights = new BenLight[8];
BenSurf[] bSurfs  = new BenSurf[5];
void setup()
{
  size(500,500,P3D);
  initLights();
  initSurfs();
}

void initLights()
{
  for(int i = 0; i < lights.length;i++)
  {
    lights[i] = new BenLight();
    lights[i].c = new float[]{random(255), 
                              random(255), 
                              random(255) };
    lights[i].rVec= new float[]{random(TWO_PI),
                                random(TWO_PI), 
                                random(TWO_PI)};
    lights[i].rVel= new float[]{random(2)-1,
                                random(2)-1, 
                                random(2)-1};
  }
}

void initSurfs()
{
  for(int i = 0; i < bSurfs.length;i++)
  {
    bSurfs[i] = new BenSurf();
    bSurfs[i].lights = lights;
    bSurfs[i].camRotVel= new float[]{random(2)-1,
                                random(2)-1, 
                                random(2)-1};
    bSurfs[i].camRotVec= new float[]{random(TWO_PI),
                                random(TWO_PI), 
                                random(TWO_PI)};
  }
}

void draw() 
{
  float dt = (millis()-lastMillis)/1000.f;
  clear();
  for(int i = 0; i < lights.length;i++)
  {
    lights[i].update(dt); 
  }

  for(int i = 0; i < bSurfs.length;i++)
  {
    bSurfs[i].draw(dt);
    tint(255,bSurfs[i].opacity);
    image(pg,0,0);
  }
  
  lastMillis = millis();
}
