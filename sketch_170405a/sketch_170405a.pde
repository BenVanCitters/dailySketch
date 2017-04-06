partSys p = new partSys();
float lastUpdateMillis = 0;
void setup()
{
  size(500,500,P3D);
}

void draw()
{
  //record the delta between 'ticks'
  float timeDelta = (millis()-lastUpdateMillis)/1000.f;
  //setup the world rendering
  //lights
  directionalLight(255, 255, 255,
                    -1, -.5, -.4);
  //background color                    
  background(255,0,0);
  
  //update the particle system
  p.update(timeDelta);
  
  //draw the particle system
  noStroke();
  p.draw();
  
  //save off update time
  lastUpdateMillis = millis();
}

