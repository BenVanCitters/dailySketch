float[] pos;
PGraphics mySurf;
void setup()
{
  size(1000,1000);
  pos = new float[]{0,35};
  //String[] fontList = PFont.list();
  //printArray(fontList);
  mySurf = createGraphics(100, 40);
}

void draw()
{
  background(0);
  mySurf.beginDraw();
  mySurf.background(100);
  pos[0] = (pos[0]+.9)%300;
  mySurf.textSize(45); 
  mySurf.text("¯\\_(ツ)_/¯",100-pos[0],pos[1]);
  mySurf.endDraw();
  image(mySurf,0,0,width,mySurf.height*(width*1.f/mySurf.width));
  updatePixels();
  
  mySurf.beginDraw();
   mySurf.loadPixels();
  int w_count = (int)(250.f*mouseX/width);
  int h_count = (int)(90.f*mouseY/height);
  float b_width = width*1.f/w_count;
  float b_height = height*.5f/h_count;
  int onColor = color(255);
  int offColor = color(90);      
  noStroke();
  
  for(int i = 0; i < w_count;i++)
  {
    for(int j = 0; j< h_count; j++)
    {
      float[] xy ={i*1.f/w_count,j*1.f/h_count};

      fill(offColor);
     int[] imgXY = {(int)(xy[0]*mySurf.width),
                    (int)(xy[1]*mySurf.height)};
     int p_index = imgXY[1]*mySurf.width + imgXY[0];
      int c = get((int)(width *xy[0]),
                  (int)(.5*height*xy[1]));
      c = mySurf.pixels[p_index];
      float brt = brightness(c);
      if(brt > 100)
      {
        fill(onColor);
      } 
      rect(b_width*i,
      height/2+b_height*j,
      b_width*.8,
      b_height*.8);
    }
  }
  mySurf.endDraw();
  
  
  
}
