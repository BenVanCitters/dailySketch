PImage teeth;
PGraphics tg; 
void setup()
{
  size(500,500,P2D);
  teeth = loadImage("teeth.jpg");
  tg = createGraphics(teeth.width,teeth.height,P2D);
  noiseDetail(8,0.5);
}

void draw()
{
  float tm = millis()/100.0;
  background(255);
  teeth.loadPixels();
  tg.beginDraw();
  tg.clear();
  tg.loadPixels();
  float sn = 1;//(1+(sin(tm*.016))/2);
  for(int i = 0; i < teeth.pixels.length; i++)
  {
    int x = i%teeth.width;
    int y = i/teeth.width;
    float n = noise((x-tm*.9)/90.f,(y+tm*.2)/70.f, tm*.2);
    int a = (int)(255*sn*n);
//    int c = color(red(teeth.pixels[i]),
//                  green(teeth.pixels[i]),
//                  blue(teeth.pixels[i]),a);
    int c = teeth.pixels[i];      
    a = a << 24;
    //argb
    c = c & 0x00ffffff;
    c = c | a;
    tg.pixels[i] = c;//color(255,0,0 );
  }
  tg.updatePixels();
  tg.endDraw();
  image(tg,0,0,width,height);
  println(frameRate);
}
