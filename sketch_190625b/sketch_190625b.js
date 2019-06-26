
class PlayerCharacter
{
  constructor(posX, posY, plats) 
  {
    this.spinDuration = 1;
    
    //sound stuff
    this.osc = new p5.Oscillator();
    this.osc.setType('square');
    this.osc.start();
    
    this.curAmp = 0;
    this.curFreq = 240;
    
    this.platforms = plats; //PlatformGroup
    this.posX = posX;
    this.posY = posY;
    this.vel = [0,0];
    this.acc = [0,10];
    this.dead = false;
    this.canJump = false;
  }
  
  update(dt)
  {
    this.vel[0] += this.acc[0]*dt;
    this.vel[1] += this.acc[1]*dt;
    this.posX += this.vel[0];
    this.posY += this.vel[1];
    //sound update
    this.curAmp = this.curAmp/2;
    this.curFreq = min(this.curFreq*2,10000);
    this.osc.amp(this.curAmp);
    this.osc.freq(this.curFreq);
    var underplat = this.getUnderPlat()
    
    if(underplat > 0)
    {
      this.posY = underplat;
      if(this.vel[1] > 0)
        this.vel[1] = 0;
      this.canJump = true;
    }
    else
    {
       this.canJump = false;
    }
    if(this.posY > height)
    {
      this.dead = true;
    }
    
  }
  
  draw() 
  {
      stroke(255,0,0); fill(255,0,0);
    //print(this.posX);
    rect(this.posX,this.posY-10,10,10);
  }
  
  getUnderPlat()
  {
    var result = -1;
    var i;
    for(i = 0; i< this.platforms.platArray.length; i++)
    {
      var platX = this.platforms.platArray[i].posX;
      var platY = this.platforms.platArray[i].posY;
      var platW = this.platforms.platArray[i].width;
      var platH = this.platforms.platArray[i].height;
      
      if(this.posX - platW < platX && this.posX > platX)
      {
        if(this.posY - platH/2 < platY)
        {
          if(this.posY >= platY)
          {
            result = platY;
            //fill(0,255,0);
            //rect(platX-5,platY-5,platW+13,platH+13);
          }
        }
      }
    }
    return result;
  }

  jump()
  {
    if(this.canJump)
    {
      this.curFreq = 240;
      this.curAmp = .2;
      this.vel[1] += -5.4;
    }
  }
}

class Platform 
{
  constructor(posX, posY,width,height) 
  {
    this.height = height;
    this.width = width;
    this.posX = posX;
    this.posY = posY;
  }
  
  update(dt)
  {
    
    //this.posY += 1;
  }
  
  draw() 
  {
    stroke(0,100,0);
    fill(0,100,0);
    rect(this.posX,this.posY,this.width,this.height);
  }  
}

class PlatformGroup
{
  constructor()
  {
    this.dist = 0;
    this.nextDiff = [];
    this.platArray = [];
    var j = 0;
    for(j = 0; j < 5; j++)
    {
      var i = 0;
      while(i < width)
      {
        var platWidth = 30 * int(1+random(5));
        if(j==4 && i ==0)
          platWidth = 400;
        this.platArray.push(new Platform(i, 
                                         height - 60*int(1+j),
                                         platWidth, 
                                         20));        
        i += this.getNextPlatSpacing(platWidth,j);
      }
      this.nextDiff.push(i-width);
    }
  }
  
  getNextPlatSpacing(lastWidth, level)
  {
    return lastWidth + 5+random(100*((5-level)+1));
  }
  

  
  update(dt)
  {
    var movement = 140.2;
    this.dist += movement*dt;
    var j;
    for(j = 0; j < this.nextDiff.length; j++)
    {
      
      this.nextDiff[j] -= movement*dt;
      if(this.nextDiff[j] < 0)
      {
        var platWidth = 30 * int(1+random(5));
        this.platArray.push(new Platform(width+this.nextDiff[j], 
                                         height - 60*int(1+j),
                                         platWidth, 
                                         20));        
        var spacing = this.getNextPlatSpacing(platWidth,j)
        this.nextDiff[j] += spacing;
        //print(j + ' ' + spacing + ' ' + this.nexDiff[j]);
        //pri nt(j + " diff " + this.nextDiff[j]);
      }
    }
    
    var i;
    for (i = 0; i < this.platArray.length; i++) 
    { 
      //this.platArray[i].update(dt);
      this.platArray[i].posX -= movement*dt;
    }
    
    var aliveArray = [];
    //aliveArray = [];
    for (i = 0; i < this.platArray.length; i++) 
    { 
      if(this.platArray[i].posX +this.platArray[i].width> 0)
      {
        aliveArray.push(this.platArray[i]);
      }
      else
      {
        //this.platArray.push(new Platform(width, height - 30*int(1+random(5)),60, 20));  
      }
    }
    this.platArray = aliveArray;
    
  }
  
  draw() 
  {
    var i;
    for (i = 0; i < this.platArray.length; i++) 
    { 
      this.platArray[i].draw();
    }
  }

}

class BackTrees
{
  constructor() 
  {
    this.width = 2*width;
     this.backmonts =[];
    var i;
    for (i = 0; i < 8; i++) 
    { 
      this.backmonts.push(random(this.width));
    }
    this.midmonts =[];
    
    for (i = 0; i < 12; i++) 
    { 
      this.midmonts.push(random(this.width));
    }
     this.frontmonts =[];
    
    for (i = 0; i < 18; i++) 
    { 
      this.frontmonts.push(random(this.width));
    }
    
  }
  
  update(dt)
  {
    var i;
    for (i = 0; i < this.backmonts.length; i++) 
    { 
      this.backmonts[i] = (this.backmonts[i] - 20*dt + this.width)%this.width;
    }
    
    for (i = 0; i < this.midmonts.length; i++) 
    { 
      this.midmonts[i] = (this.midmonts[i] - 40*dt + this.width)%this.width;
    }
    
    for (i = 0; i < this.frontmonts.length; i++) 
    { 
      this.frontmonts[i] = (this.frontmonts[i] - 70*dt + this.width)%this.width ;
    }
  }
  
  draw()
  {
    var horizontalOffset = this.width/4;
    var i;
    for (i = 0; i < this.backmonts.length; i++) 
    { 
      var w  = 900;
      fill(220);
      stroke(220);
      triangle(this.backmonts[i]-w-horizontalOffset, height, 
               this.backmonts[i]-horizontalOffset, 20, 
               this.backmonts[i]-horizontalOffset + w, height);
    }
    

    for (i = 0; i < this.midmonts.length; i++) 
    { 
      var w  = 300;
      fill(100);
      stroke(100);
      triangle(this.midmonts[i]-w-horizontalOffset, height, 
               this.midmonts[i]-horizontalOffset, 200, 
               this.midmonts[i] + w-horizontalOffset, height);
    }

    
    for (i = 0; i < this.frontmonts.length; i++) 
    { 
      var w  = 100;
      fill(50);
      stroke(50);
      triangle(this.frontmonts[i]-w-horizontalOffset, height, 
               this.frontmonts[i]-horizontalOffset, 350, 
               this.frontmonts[i] + w-horizontalOffset, height);
    }
  }
}

var lastMillis = 0;

function setup() 
{
  createCanvas(1000, 500);
  startGame();
}

function startGame()
{
  platGroup = new PlatformGroup();
  player = new PlayerCharacter(70,150,platGroup);
  backTrees = new BackTrees();
}

function draw() 
{
  var curMillis = millis();
  var dt = (curMillis -lastMillis) /1000.0;
  
  background(200);

  //rect(sre.posX,sre.posY,sre.width, sre.height);
  if(player.dead == false)
  {
    player.update(dt);  
    platGroup.update(dt);
    backTrees.update(dt);
  }
  
  backTrees.draw();
  platGroup.draw();
  player.draw();

  stroke(255,0,0); fill(255,0,0);
  textSize(32);
  text('Score: ' + int(platGroup.dist), 10, 70);

  
  //print(sqfuare.width);
  lastMillis = curMillis;
}

function touchStarted() {
if(player.dead)
    {
      startGame();
    }else{
      player.jump();
    }
}
function mousePressed() {
if(player.dead)
    {
      startGame();
    }else{
      player.jump();
    }
}
function keyPressed() 
{
  //print(keyCode);
  if(keyCode == 32)
  {
    if(player.dead)
    {
      startGame();
    }else{
      player.jump();
    }
  }
}
