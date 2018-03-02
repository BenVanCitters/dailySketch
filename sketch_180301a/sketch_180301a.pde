
DifRec d;

void setup()
{
  size(900,900);
  d = new DifRec();

}

void draw()
{
  background(0);
  long s = millis();
  d.update();
  d.update();
  d.update();
  long f = millis()-s;
  
  d.draw();
  fill(255);
  stroke(255);
  text("" + frameRate,0,50);
text("updateTime: " + f, 0, 65);
}
