PImage img;
//long tm = 0;
void setup()
{
  size(900,900,OPENGL); //ugh, even using the 'opengl' renderer won't get me that many image draws at 60fps...
  img = loadImage("img.png");
  makeShape();
  background(0);
}

void draw()
{
  //clear the background
  background(0);
//  lights();
  float tm = frameCount /40.f;//millis()/1000.f;
  float tm2 = millis()/3333.f;
  pushMatrix();
  //position the shape at the center of the screen 
  translate(width/2,height/2);
  //rotate the shape every which way - but slowly and using 'time' (rather than frame number)
  rotateX(1+tm2*1.1);
  rotateY(tm2*-.9);
  rotateZ(2+tm2);
  
  //scale it up a bit
  scale(2);
  //don't hide things spatially - this will cause render bugs due to the 
  //transparent texture - just splat 'em on the screen - last rendered is on top
  hint(DISABLE_DEPTH_TEST);
  //how many can we render whilst getting 60fps on my 2011 macbook air??? 
  int count = 400;//(int)(mouseX*1000.f/width);
//  println("count: " + count);
  noStroke();
  for(int i = 0; i < count; i++)
  {
    pushMatrix();
      rotateX(tm*1.21);
      translate(139*sin(tm*2.13),0,0);
      rotateY(tm*-1.1);
      translate(-113*sin(1+tm*1.2),0,0);
      rotateZ(tm*.911);
      translate(99*sin(4-tm*.98),0,0);
      tint(255*(1+sin((tm+tm2)*12))/2.f,255,255);
      //shape(s,0,0);
      image(img,0,0);
    popMatrix();
    tm+= 1/40.f; //increment "time"
  }
  popMatrix();
//  printFreameRate();
}

// vestigal attempt at getting a better framerate with a pre-build 'pshape'  
// rather than drawing the bitmap with the 'image' command. - note failure 
// - not only did the framerate not improve I lost the ability to dynamically 
// tint the results...
PShape s;
void makeShape()
{
  s = createShape();
  s.beginShape(QUADS);
  s.noStroke();
  s.texture(img);
  s.textureMode(NORMAL);
  s.vertex(0, 0,0,0);
  s.vertex(img.width,0,1,0);
  s.vertex(img.width,img.height,1,1);
  s.vertex(0,img.height,0,1);
  s.endShape();
}

//draw a rect (hopefully in screenspace) along with the framerate 
// as a string inside the rect
void printFreameRate()
{
  pushStyle();
  fill(190);
  rect(0,0,100,50);
  fill(0);
  String fr = "" + frameRate;
  text(fr,0,30);
  popStyle();
}
