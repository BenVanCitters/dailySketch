PGraphics buffer;
PGraphics renderTarg;
void setup()
{
  size(500,500,P3D);
  renderTarg = createGraphics(width,height,P3D); 
  buffer = createGraphics(width/4,height/4,P3D);
}

void draw()
{
  background(0);
  renderTarg.beginDraw();
  renderTarg.clear();//background(255);
  renderTarg.noFill();
//strokeWeight(.5);
  float tm = millis()/4000.f;
  float amt1 = 3*sin(tm+7);//(1+sin(tm))/2;
  float amt2 = 3*sin(tm/3);
  float amt3 = 3*sin(tm/4.1+1);
  float amt4 = 3*sin(tm/1.41+2);
  float amt5 = ((cos(tm*8)+1)/2);
  int sz = (int)(800);  
  renderTarg.pushMatrix();
  renderTarg.translate(width/2,height/2);
  for(int i = 0; i <sz; i++)
  {
    float pct = i*1.f/sz;// * amt5;
    renderTarg.pushMatrix();
    
    renderTarg.rotateX(amt2*pct*TWO_PI);
    renderTarg.rotateY(amt3*pct*TWO_PI);
    renderTarg.rotateZ(amt4*pct*TWO_PI);
//    renderTarg.translate(-250,-250);
    renderTarg.translate(110*pct*amt1,110*pct*amt3,110*pct*amt2);
//    renderTarg.stroke(255*(1-pct),255*(1-pct),255);
    renderTarg.ellipse(0,0,300,300);   
//   renderTarg.rect(0,0,500,500); 
    renderTarg.popMatrix();
  }
  renderTarg.popMatrix();
  renderTarg.endDraw();
  
  buffer.beginDraw();
  buffer.clear();//background(255);
  buffer.image(renderTarg,0,0,buffer.width,buffer.height);
   buffer.filter(INVERT);
  buffer.filter(BLUR,5);
//   buffer.filter(THRESHOLD);
  buffer.endDraw();  
//translate(mouseX,mouseY);

  image(buffer,0,0,width,height);
  image(renderTarg,0,0,width,height);
}

