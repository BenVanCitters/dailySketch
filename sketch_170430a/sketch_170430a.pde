PGraphics graphics1;
PGraphics graphics2;
void setup()
{
  size(1000,1000,P3D);
  graphics1 = createGraphics(width,height,P3D); 
  graphics2 = createGraphics(width,height,P3D);
}

void draw()
{
  background(0);
  drawGraphics1();
  drawGraphics2();
  
  float tm = millis()/1000.f;
  int color1 =   color(255*(1+sin(5+tm/2.3))/2,
                        255*(1+sin(11-tm))/2,
                        255*(1+sin(7+tm*1.03))/2);
    int color2 = color(255*(1+sin(1+tm/3))/2,
                        255*(1+sin(2+tm*1.1))/2,
                        255*(1+sin(3-tm/2))/2);
  blendMode(ADD);
  tint(color1);
  image(graphics1,0,0,width,height);
  tint(color2);
  image(graphics2,0,0,width,height);
  
  blendMode(REPLACE);
  float sz = width/4;
  
  tint(255);
  
  image(graphics1,0,0,sz,sz);
  fill(color1);stroke(color1);
  rect(sz,0,sz,sz);
  tint(color1);
  image(graphics1,sz*2,0,sz,sz);
  text("monochrome,\nsource1",5,10);
  fill(0);stroke(0);text("hue",sz+5,10);
  fill(255);stroke(255);text("multiply",sz*2+5,10);
  
  tint(255);
  image(graphics2,0,sz,sz,sz);
  fill(color2);stroke(color2);
  rect(sz,sz,sz,sz);
  tint(color2);
  image(graphics2,sz*2,sz,sz,sz);
    text("monochrome,\nsource2",5,sz+10);
  fill(0);stroke(0);text("hue",sz+5,sz+10);
  fill(255);stroke(255);text("multiply",sz*2+5,sz+10);
  
  println(frameRate);
}

void drawGraphics1()
{
  graphics1.beginDraw();
  graphics1.clear();
  graphics1.noFill();
  float tm = millis()/1000.f;
  float fColors[] ={(1+sin(5+tm/2.3))/2,
                        (1+sin(11-tm))/2,
                        (1+sin(7+tm*1.03))/2};

  graphics1.pushMatrix();
//  graphics1.lights();
graphics1.directionalLight(255, 255, 255, -1, 1, -1);
graphics1.sphereDetail(15,15);
  graphics1.translate(graphics1.width/2,graphics1.height/2);
  graphics1.rotateZ(millis()/2000.f);
  int count = 15;
  int halfcount = count/2;
  for(int i =-halfcount; i <halfcount; i++)
  {
    float bright = 256*(1+sin(tm*2+i*6.f/halfcount))/2.f;
//    int fillColor = color(bright*fColors[0],
//                          bright*fColors[1],
//                          bright*fColors[2]);
    int fillColor = color(bright);                      
//          graphics1.stroke(fillColor);
graphics1.noStroke();
      graphics1.fill(fillColor);
    for(int j =-halfcount; j <halfcount; j++)
    {

      graphics1.pushMatrix();
      float spacing = 120;
      graphics1.translate(i*spacing,j*spacing);

//      graphics1.ellipse(0,0,40,40);
      graphics1.sphere(40);
      graphics1.popMatrix();
    }
  }
  graphics1.popMatrix();
  graphics1.endDraw();
}

void drawGraphics2()
{
  float tm = millis()/1000.f;
  int fillColor = color(255*(1+sin(1+tm/3))/2,
                        255*(1+sin(2+tm*1.1))/2,
                        255*(1+sin(3-tm/2))/2);
  graphics2.beginDraw();
  graphics2.directionalLight(255, 255, 255, -1, 1, -1);
  graphics2.clear();
  graphics2.noStroke();
//  graphics2.stroke(fillColor);
  graphics2.fill(255);

  graphics2.pushMatrix();
  graphics2.translate(graphics2.width/2,graphics2.height/2);
//  graphics2.rotateZ(-millis()/8000.f);
  for(int i = -25; i <25; i++)
  {
    graphics2.pushMatrix();
    float spacing = 160;
    float hOffSet = (millis()/70.f) % spacing;
    graphics2.translate(hOffSet+i*spacing,0);
    graphics2.rotateY(tm+i/5.f);
//    graphics2.rect(0,0,50,700);
    graphics2.box(60,1000,60);
    graphics2.popMatrix();
  }
  graphics2.popMatrix();
//  graphics2.filter(BLUR,8);
  graphics2.endDraw();
}



