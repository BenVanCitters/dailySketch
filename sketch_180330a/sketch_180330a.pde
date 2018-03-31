PGraphics buffer;
PGraphics buffer2;
void setup()
{
  size(2000,2000,OPENGL);
  int w = 400;
  int h = 400;
  buffer = createGraphics(w,h);
  buffer2 = createGraphics(w,h);
  
  buffer.beginDraw();
  buffer.clear();
  buffer.endDraw();
  buffer2.beginDraw();
  buffer2.clear();
  buffer2.endDraw();
  
  background(0);
}

int tickdown = 300;
void draw()
{

  ArrayList<Integer> colors = new ArrayList<Integer>();
  ArrayList<float[]> lines = new ArrayList<float[]>();
  background(255);
  buffer.beginDraw();
  buffer.image(buffer2,0,0);
  buffer.loadPixels();
  buffer.endDraw();
  
  buffer2.beginDraw();
  int accum = 0;
  for(int i = 0; i < buffer.pixels.length; i++)
  {
    int x = i%buffer.width;
    int y = i/buffer.width;
    float brt = brightness(buffer.pixels[i]);
    if(brt > 20 && random(1)>.99)
    {
      accum++;
      buffer2.stroke(buffer.pixels[i]);
      colors.add(buffer.pixels[i]);

      //drawRndLine(x,y);
      
      float radian = random(TWO_PI);
      float len = brt/256.f*random(.9)*(35);
      lines.add(new float[]{x,y,x+len*cos(radian),
                            y+len*sin(radian)});
      buffer2.line(x,y,x+len*cos(radian),
                       y+len*sin(radian));
    }
  }
  //buffer2.beginShape(LINES);
  //for(int i = 0; i < lines.size(); i++)
  //{
  //  float[] stuff = lines.get(i);
  //  int c = colors.get(i);
  //  buffer2.stroke(c);
  //  buffer2.vertex(stuff[0],stuff[1],stuff[2],stuff[3]);
  //}
  //buffer2.endShape();
  
    if(tickdown - millis() < 0)
  {
    tickdown = int(millis() + 200 + random(200));
     int c = color(random(256),random(256),random(256));
    buffer2.fill(c);
    buffer2.stroke(c);
    float radius = random(50)+50;
    buffer2.ellipse(random(buffer2.width),random(buffer.height),radius,radius);

  }
  buffer2.endDraw();
  
  image(buffer,0,0,width,height);
  println("accum: " +  accum + " frameRate: " + frameRate + " linesz: " + lines.size());
}

void mouseClicked()
{
  buffer2.beginDraw();
  int c = color(random(256),random(256),random(256));
  buffer2.fill(c);
  buffer2.stroke(c);
  buffer2.ellipse((mouseX*buffer2.width)/width,(mouseY*buffer.height)/height,50,50);
  buffer2.endDraw();
}

void drawRndLine(int x, int y)
{
  float radian = random(TWO_PI);
  float len = random(10);
  buffer2.line(x,y,x+len*cos(radian),
                   y+len*sin(radian));
}