void setup()
{
  size(800,800,OPENGL);
}

void draw()
{
  background(100);
  int count = 1000;
  strokeWeight(.5);
  float offs = 0;// mouseX*100.f/width;
  float w = width-offs;
  float h = height-offs;
  float diagDist = sqrt(w*w+h*h);
  float maxRad = diagDist/2.f;
//  translate(width/2,height/2);
  
  float innerRadius = 200;
  beginShape(LINES);
  for(int i =0; i < count; i++)
  {
    float curRadian = i*TWO_PI/count + millis()/10000.f;
    
    float radianOffs = PI/16.f*i+TWO_PI*sin(millis()/13000.f);
    float[] start = {width/2+maxRad*cos(curRadian),
                     height/2+maxRad*sin(curRadian)};
    start[0] = min(max(start[0],offs),width-offs);
    start[1] = min(max(start[1],offs),height-offs);
    float[] end = {width/2+innerRadius*cos(curRadian+radianOffs),
                   height/2+innerRadius*sin(curRadian+radianOffs)};
    vertex(start[0],start[1]);
    vertex(end[0],end[1]);
  }
  
  endShape();
  println(frameRate);
}
