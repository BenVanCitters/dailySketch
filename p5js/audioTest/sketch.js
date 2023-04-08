class particle
{
  constructor()
  {
    this.pos = createVector(width/2,height/2);
    this.pos.add(p5.Vector.random2D().mult(width/4 +  random(width/8) )) ;
    this.vel = p5.Vector.random2D().mult(.2);
    this.myFreq = 0;
    
    this.osc = new p5.Oscillator('sine');
    this.osc.phase(random(1));
  }
  
  update()
  {
    let m = createVector(mouseX,mouseY);
    let dir = p5.Vector.sub(m, this.pos);
    let distSq = dir.magSq();
    if(dir.mag() <= 4)
    {
      this.vel.mult(-1);
      let perp =  createVector(dir.y,dir.x).normalize().mult(random(-.1,.1));
          this.vel.add(perp);                                                  
    }
    else
    {
      dir.normalize();
      dir.div(distSq);
      dir.mult(40);
      this.vel.add(dir);
    }
    
    
    this.pos.add(this.vel); 
  
    this.myFreq = constrain(
      map(this.vel.mag(), 0, 4, 0,2000), 5, 2000);
    if(distSq > 70000)
      this.myFreq = 0;
    try{
    this.osc.freq(this.myFreq, 0.1);  
    }
    catch(error)
      {
        
      }
  }
  draw()
  {
    noStroke();
    push();
    fill(150,220,180);
    translate(this.pos.x, this.pos.y);
    ellipse(0,0, 15, 15);
    
    fill(0,0,0);
    ellipse(-3,-3, 3, 3);
    ellipse(3,-3, 3, 3);
    
    let pctOpen = min(1,map(this.vel.mag()*3, 0, 4, 0,1));
    let closedM = createVector(8,1);
    let whistleM = createVector(5,5)
    let curMouth = p5.Vector.lerp(closedM,whistleM, pctOpen);
    ellipse(0,3, curMouth.x, curMouth.y);
    pop();
  }
}

let osc, playing, freq, amp;
let parts = [];
function setup() {
  let cnv = createCanvas(500, 500);
  cnv.mousePressed(playOscillator);
  // osc = new p5.Oscillator('square');
  
  for(let i = 0; i < 30; i++)
  { parts.push (new particle() ); }
}

function draw() {
  for(let part of parts)
  {
    part.update();
  }
  
  background(255);
  for(let part of parts)
  {
    part.draw();
  }
  let maxDist = createVector(width/2,height/2).magSq();
  //freq = constrain(map(part.vel.mag(), 0, 5, 0,2000), 5, 2000);
  amp = constrain(map(mouseY, height, 0, 0, 1), 0, 1);

  text('tap to play', 20, 20);
  //text('freq: ' + freq, 20, 40);
  text('amp: ' + amp, 20, 60);

  //text(`vel ${part.vel.mag()}`, 20, 80);
  if (playing) {
    // smooth the transitions by 0.1 seconds
    //osc.freq(freq, 0.1);
    for(let part of parts)
    {
      part.osc.amp(amp, 0.1);
    }
  }
}

function playOscillator() {
  // starting an oscillator on a user gesture will enable audio
  // in browsers that have a strict autoplay policy.
  // See also: userStartAudio();
  for(let part of parts)
  {
    part.osc.start();
  }
  playing = !playing;
  if(!playing)
    {
      for(let part of parts)
  {
  part.osc.amp(0, 0.5);
  }
    }
}

function mouseReleased() {
  // ramp amplitude to 0 over 0.5 seconds
  
  //playing = false;
}