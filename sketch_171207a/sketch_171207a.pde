PImage img;
void setup()
{
  size(700,700);
  img = loadImage("img.png");
}

void draw()
{
  noStroke();
  image(img,0,0,width,height);
  loadPixels();
  int mouseIndex = mouseX+mouseY*width;
  int[][] result = getNearByPix(mouseIndex, 55);

  float wpr = width*1.f/result[0].length;
  float hpr = height*1.f/result.length;
  for(int j = 0;j < result.length; j++)
  {
    for(int i = 0; i < result[0].length; i++)
    {
      fill(result[j][i]);
      rect(i*wpr,j*hpr,wpr,hpr);
    }
  }
}

int[][] getNearByPix(int index, int half_sz)
{
  int startX = (index % width);
  int startY = (index / width);
  int[][] pix = new int[1+half_sz*2][1+half_sz*2];
  
  for(int i = 0; i < pix.length; i++)
  {
    int x_ofs = i-half_sz;
    for(int j = 0; j < pix[i].length; j++)
    {
      int y_ofs = j-half_sz;
      int x = min(max(startX + x_ofs,0),width-1);
      int y = min(max(startY + y_ofs,0),height-1);
      int newIndex = x+y*width;  
      pix[j][i] = pixels[newIndex];
    } 
  }
  return pix;
}
