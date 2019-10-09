BlockGroup blockGroup;
MissileGroup missileGroup;
PlayerShip ship;
BenInput benInput = new BenInput(); 
PGraphics bbuffer;
void setup()
{
  size(1080,1080,P2D);
  startGame();
}

void startGame()
{
  background(200);
  bbuffer = createGraphics(width,height,P2D);
  bbuffer.beginDraw();
  bbuffer.image(g,0,0);
  //bbuffer.filter(BLUR);
  bbuffer.endDraw();
  missileGroup = new MissileGroup();
  ship = new PlayerShip(missileGroup);  
  ship.pos = new float[]{width/2,height/2};
  blockGroup = new BlockGroup(8, ship, missileGroup);
}

void draw()
{
  pushMatrix();
  translate(width/2,height/2);
  rotate(.0001);
  translate(-width/2,-height/2);
  //image(bbuffer,0,0);
  popMatrix();
  //update
  inputUpdate();
  missileGroup.update();
  ship.update();
  blockGroup.update();
  
  //draw
  missileGroup.draw();
  ship.draw();
  blockGroup.draw();
  
  bbuffer.beginDraw();
  float offset = 0;
  bbuffer.image(g,-offset,-offset,width+offset*2,height+offset*2);
  //bbuffer.filter(BLUR);
  bbuffer.endDraw();
}

void inputUpdate()
{
  if(benInput.forwardDown)
  { ship.accelerate(); }
  if(benInput.clockwiseDown)
  { ship.rotateShip(true); }
  if(benInput.cclockwiseDown)
  { ship.rotateShip(false); }
  if(benInput.fireOffToOn)
  { 
    ship.fireMissile();
    if(!ship.alive)
    {
      startGame();
    }
  }
  benInput.update();
}

void keyPressed() 
{ benInput.keyPressed(); }

void keyReleased() 
{ benInput.keyReleased(); }
