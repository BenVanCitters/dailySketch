PGraphics target;
PImage tapes;
void setup()
{
  size(1400,850,P2D);
  target = createGraphics(200,200,P2D);
  tapes = loadImage("tapes.png");
}

void draw()
{
  target.loadPixels();
  int startIndex = 0;//(int)(random(pixels.length));  
  float amt = 5+700*(1+cos(millis()*TWO_PI/2500.f))/2;
  //for(int j=0; j< 200; j++)
  while(startIndex<target.pixels.length)
  {
    int count = (int)(random(amt));
    startIndex+=count;
    for(int i = 0; i < count; i++)
    {
      int index = (i+startIndex)%target.pixels.length;
      float pct = i*TWO_PI/(count-1);
      target.pixels[index] = color(255*(0+(1+cos(pct))/2)); 
    }
  }
  target.updatePixels();

pushMatrix();
  translate(width/2,height/2);
  rotate(millis()*TWO_PI/5000.f);
  //scale so that one edge of the 'target' surface is the same size as the diagonal
  //of the screen
  float sc = sqrt(width*width+height*height)/min(target.width,target.height);
//  scale(sc);
  translate(-sc*target.width/2,-sc*target.height/2);  
  image(target,0,0,target.width*sc,target.width*sc);
popMatrix();  
println(frameRate);
float tScale = height*1.f/tapes.height;
image(tapes,0,0,tScale*tapes.width,height);
}
