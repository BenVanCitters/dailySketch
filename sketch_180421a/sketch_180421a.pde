import processing.pdf.*;
String s = "";
  
PGraphics tile;
PGraphics printer;


float currentAngle = 0;
String currentFontName = "";
String currentCopy = "";
void setup()
{
  size(1000,1000);
  printer = createGraphics(933,2000, PDF, "output.pdf");
  tile = createGraphics(933,2000);
  
  String[] lines = loadStrings("config.txt");
  float fontSz = float(lines[2]);
  String fontName = lines[1];
  s = lines[0];
  
  currentFontName = fontName;
  currentCopy = s;

  PFont mono = createFont(fontName,fontSz);
  tile.beginDraw();
  tile.textFont(mono);
  tile.endDraw();

    printer.beginDraw();
  printer.textFont(mono);
  printer.endDraw();
  
 // draw();
}

void draw()
{
  background(255,0,255);
  
  //image(tile,0,0);
  //println("askdhlaskjd");
  
  renderTile(tile);
  drawTiles();
  drawInfo();
  if(save)
  {
    savePDF(); 
  }
  //println("mouseButton: " + mouseButton);
  if(mouseButton <= 0)
  {
    save = false;
  }
  if(!save && mouseButton > 0)
  {
    save = true;
  }
  
}
boolean save = false;


void drawInfo()
{
  if(mouseButton> 0)
  {
    textSize(50);
    fill(255,255,0);
    String eg = "SAVING output.pdf";
    text(eg,width/3,height/2); 
  }
  else
  {
    textSize(20);
    fill(0,255,0);
    String g = "Change the text angle by moving\nthe mouse up and down, current angle: " + currentAngle + "\nClick anywhere on the image to start saving output to a pdf";
    text(g,10,40);
    g = "To edit other variables change data\\config.txt and relaunch\n1st line: copy (" + currentCopy + ")\n2nd line: font name("+currentFontName+")\n3rd line: font size";
    text(g,10,180);
  }
}


void renderTile(PGraphics tile)
{
  tile.beginDraw();
  // float fontSz = 1+mouseX*99.f/width;
  //PFont mono = createFont("Times New Roman Italic",fontSz);
  
  //tile.textFont(mono);
  
  tile.background(0);
  double mVar = -15.0 + mouseY*-20.0/height;
  currentAngle = (float)mVar;
  long count = 20000000;
  float stepLen = .01;//mouseY*10.f/height;
  //println("mvar: " + mVar + " len = " + stepLen*count);// (36675-40000)
  float pos[] = {0,72};
  double radian =mVar*TWO_PI/360;
  double direction[] = { java.lang.Math.cos(radian), java.lang.Math.sin(radian)};
  boolean printNow = true;
  for(int i = 0; i < count; i++)
  {
    pos[0]+= direction[0]*stepLen;
    pos[1]+= direction[1]*stepLen;
    if(pos[0] > tile.width){ printNow = true; pos[0] -= tile.width;}
    if(pos[0] < 0){ printNow = true; pos[0] += tile.width;}
      
    if(pos[1] > tile.height){ printNow = true; pos[1] -= tile.height;}
    if(pos[1] < 0){ printNow = true; pos[1] += tile.height;}
    
    if(printNow)
    {
      tile.fill(255,0,0);
      tile.pushMatrix();
        tile.translate(pos[0],pos[1]);
        tile.rotate((float)(radian));
        tile.translate(-i*stepLen,0);
        tile.text(s,0,0);
      tile.popMatrix();
      printNow = false;
    }
  }
  tile.endDraw();
}  


void drawTiles()
{
  float w = tile.width;
  float h = tile.height;
  float borderW = 10;
  for(int i = -1; i < 4; i++)
  {
    for(int j = -1; j < 4; j++)
    {
      pushMatrix();
      scale(.3);
      translate((w+borderW)*(.5+i),(h+borderW)*(.5+j));
      //image(gr,(w)*i,(-i*74/3)+(h)*j);
      image(tile,0,0);
      popMatrix();
    }
  } 
}

long lastSaveTime = 0;
void savePDF()
{
  //println("millis: " + millis() + " delta = " + (millis()-lastSaveTime));
  if(millis()-lastSaveTime > 2000)
  {
    
    renderTile(printer);
    printer.dispose();
    lastSaveTime = millis();
    println("it's cool, we finished up..");
  }
}