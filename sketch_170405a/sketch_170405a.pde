partSys p = new partSys();
partSys p2 = new partSys();
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
  directionalLight(255, 255, 100,
                    -1, -.5, -.8);
  //background color                    
  background(255,0,0);
  
  //update the particle system
  p.update(timeDelta);
  p2.update(timeDelta);
  //draw the particle system
  noStroke();
  pushMatrix();
  translate(0,0,100);
  rotateX(.2);
  p.draw();
  popMatrix();
  
  
  pushMatrix();
  translate(0,0,-300);
  p2.draw();
  popMatrix();
  //save off update time
  lastUpdateMillis = millis();
}

