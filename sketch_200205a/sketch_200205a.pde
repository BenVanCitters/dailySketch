BShape2 bshape;
String filepath = "C:/Users/vanci/Downloads/codingchallengeforfastradius/Moon.stl";

void setup()
{
  size(900,900,P3D);
  bshape = new BShape2(filepath);
}

void draw()
{
  background(200);
  lights();
  translate(width/2,height/2);
  scale(50);
  fill(255);
  noStroke();
  rotateY(mouseX/100.f);
  rotateX(mouseY/100.f);
  bshape.draw();
}
