float[][] tripoints = new float[3][2];
float[] pt = {100,300};
float[] bpt = {1.f/3,1.f/3,1.f/3};
float[] pvel = {.001,.001,0};
void setup()
{
  
  size(700,700);

  //bpt = barycentricFromCartesian(pt,tripoints);
}

void draw()
{
  background(200,200,200);
  drawTriStuff();
  drawPtStuff();
  drawMouseBary();
}

void drawMouseBary()
{
  float[] xy = {mouseX,mouseY};
  float[] b = barycentricFromCartesian(xy,tripoints);
  String s = "b<"+b[0]+",\n"+b[1]+",\n" +b[2]+">"; 
  text(s,mouseX,mouseY);
}

void drawPtStuff()
{
  bpt[2] = 1-bpt[1]-bpt[0];
  float[] tmp = {bpt[0]+pvel[0],
                 bpt[1]+pvel[1],  
                 bpt[2]+pvel[2]};
  for(int i = 0; i < 3; i++)
  {
    if(tmp[i] > 1 || tmp[i] < 0)
    {
      pvel[i] *= -1;
      print("molted");
    }
  }
  bpt[0]+=pvel[0];
  bpt[1]+=pvel[1];
  bpt[2]+=pvel[2];
  
  fill(255);
  float[] xypt = baryToCart(bpt,tripoints);
  println(bpt[0] +","+ bpt[1]+","+ bpt[2]);
  String s = "b<"+bpt[0]+",\n"+bpt[1]+",\n" +bpt[2]+">"; 
  text(s,xypt[0],xypt[1]);
  ellipse(xypt[0],xypt[1],10,10);
}

void drawTriStuff()
{
  float rOff = 0;//millis()/1000.f;
  float radius = width/2.f;
  for(int i = 0; i < 3; i++)
  {
    tripoints[i][0] = width/2 + radius * cos(rOff+(TWO_PI/3)*i);
    tripoints[i][1] = height/2 +radius * sin(rOff+(TWO_PI/3)*i);
  }
    
    loadPixels();
  for(int i = 0; i < pixels.length; i++)
  {
    float[] xy = {i%width,i/width};
    float[] b = barycentricFromCartesian(xy,tripoints);
    if( (abs(b[0]+b[1]+b[2])- 1) < .0001)
    {
      pixels[i] = color(255*b[0],255*b[1],255*b[2]);
    }
    else
    {
      pixels[i] = color(255*random(1),255*random(1),255*random(1));
    }
  }
  updatePixels();
  
  noFill();
  beginShape(TRIANGLES);
  for(int i = 0; i < tripoints.length;i++)
  {
    vertex(tripoints[i][0],tripoints[i][1]);
  }
  endShape();
}
