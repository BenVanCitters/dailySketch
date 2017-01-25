void setup()
{
  size(500,500);
  
}

void draw()
{
  background(255);
  fill(0);
  float cW = 20;
  int circlesPerRow = (int)(width/cW);
  int circlesPerCol = (int)(height/cW);
  int x = cW*(millis()/50)%circlesPerRow;
  int y = (millis()/50)/
  ellipse(x,cW,cW,cW);
}
