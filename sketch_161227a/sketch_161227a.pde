BaddieWrangler bw = new BaddieWrangler();
Player p = new Player();

long lastMillis = 0;
void setup()
{
  size(500,500,P3D);
  p.pos[0] = width/2;
  p.pos[1] = height/2;
}

void draw()
{
  float dt = (millis()-lastMillis)/1000.f;
  //update
  updateInput(dt);
  p.update(dt);
  bw.update(dt);
  
  //draw
  background(0);
  p.draw();
  bw.draw();
  
  lastMillis = millis();
}

boolean waitingForKeyUp = false;
void updateInput(float dt)
{
  if(keyPressed)
  {
    if(!waitingForKeyUp)
    {
      waitingForKeyUp = true;
      if(keyCode == UP)
      {
        p.fire();
      }
    }
    if(keyCode == LEFT)
      {
        p.angle -= dt * 3;
      }
      else if(keyCode == RIGHT)
      {
        p.angle += dt * 3;
      }
  }
  else
  {
    waitingForKeyUp = false;
  }
}

