Circ myCirc = new Circ(150);
void setup()
{
  size(500,500,P3D);
}

void draw()
{
  background(75, 118, 153);  
  myCirc.update();
  
  setLights();
  pushMatrix();
    translate(width/2,height/2,100*sin(millis()/7777.f));
    rotateY(millis()/6000.f);
    rotateZ(millis()/4000.f);
    myCirc.draw();
  popMatrix();
}

void setLights()
{
  ambientLight(75*.5, 118*.5, 153*.5);
  lightSpecular(193,203,186);
  directionalLight(200, 200, 200, 0, 1, -1);
}
