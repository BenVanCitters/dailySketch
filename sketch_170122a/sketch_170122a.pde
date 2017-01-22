String lines[][];

int sloganIndex = 0;
int wordIndex = 0;
boolean waitFrame = false;

PFont font;
float fontSz = 70;

float updateDelay = .3;
float nextUpdateSc = 0;
float lastUpdateMillis = 0;

int backColor = 0;

PGraphics buffer;

void setup()
{
  size(500,500,P2D);
  buffer = createGraphics(100,100,P2D);
  font = createFont("CooperBlackStd", fontSz);
  textFont(font, fontSz);
  

  String tmpLines[] = loadStrings("slogans.txt");
  lines = new String[tmpLines.length][];
  for(int i = 0; i < tmpLines.length; i++)
  {
    lines[i] = tmpLines[i].split(" ");
  
  }
  sloganIndex = 0;//(int)random(lines.length);
  background(0);
  nextUpdateSc = updateDelay;
  lastUpdateMillis = millis();
}


void draw()
{
  buffer.beginDraw();
  buffer.image(g,-2,-3,buffer.width+4,buffer.height+6);
  buffer.noStroke();
  buffer.fill(red(backColor),green(backColor),blue(backColor),30);
  buffer.rect(0,0,buffer.width,buffer.height);
  buffer.endDraw();
  image(buffer,-2,-3,width+4,height+6);
  textAlign(CENTER);
  
  
  nextUpdateSc -= (millis()-lastUpdateMillis)/1000.f;
  if(nextUpdateSc < 0)
  {
    wordIndex++;
    nextUpdateSc = updateDelay;
    if(waitFrame == true)
    {
      sloganIndex = (sloganIndex+1)%lines.length ;//(int)random(lines.length);
      wordIndex = 0;
      backColor = color(random(255),random(255),random(255));
      waitFrame = false;
    }
    
    if(wordIndex >= lines[sloganIndex].length)
    {
      nextUpdateSc = updateDelay*2;
      waitFrame = true;
    }
  }
  if(waitFrame == false)
  {
    translate(width/2,height/2+fontSz/4);
    rotate(-.2);
    text(lines[sloganIndex][wordIndex],0,0);
  }
  lastUpdateMillis = millis();
}
