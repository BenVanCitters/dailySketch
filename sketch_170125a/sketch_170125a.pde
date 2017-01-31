void setup()
{
  size(500,500);
  
}

void draw()
{
  background(255);
  fill(0);
  int cW = 50;
  int circlesPerRow = (int)(width/cW);
  int circlesPerCol = (int)(height/cW);
  
  int timePerCircle = 90;
  int x = (millis()/timePerCircle) % circlesPerRow;
  int y = ((millis()/(timePerCircle*circlesPerRow))%circlesPerCol);
  ellipse(cW*(.5+x),cW*(.5+y),cW,cW);
}
