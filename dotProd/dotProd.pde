void setup()
{
  size(500,500);
}

void draw()
{
  background(255);
  translate(width/2,height/2);
  
  float[] v1 = {cos(0),sin(0)};
  float[] v2 = {mouseX-width/2,mouseY-height/2};
  float d = dist(0,0,v2[0],v2[1]);
  v2[0]/=d;v2[1]/=d;
  
  float m = .5*width*.75;
  line(0,0,m*v1[0],m*v1[1]);
  line(0,0,m*v2[0],m*v2[1]);
  float dot = v1[0]*v2[0]+v1[1]*v2[1];
  println(dot);
}
