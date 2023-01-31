class DragPoint{
  public float[] pos ={0,0};
public float[] uv ={0,0};
  public boolean selected = false;
  public boolean clickedOn(int x, int y){ return dist(pos[0],pos[1],x,y) < 10;}
  void draw(){ellipse(pos[0],pos[1],5,5);}
  public String toStr(){return "pos: {" + pos[0]+","+ pos[1] + "}"+" uv:{" + uv[0]+","+uv[1]+"} selected: " + selected;}
}

class ColorLine
{
  DragPoint start = new DragPoint();
  DragPoint end = new DragPoint();
  PImage img;
  float[][] lineCols;
  public ColorLine()
  {
    img = loadImage("pic.jpg");
    img.loadPixels();
  }
  
  public void draw()
  {
    image(img,0,0,width,height);
    start.draw();end.draw();
    line(start.pos[0],start.pos[1],end.pos[0],end.pos[1]);
    if(null != lineCols)
    {
      drawSeries(0,color(255,0,0));
      drawSeries(1,color(0,255,0));
      drawSeries(2,color(0,0,255));
      drawSeries(3,color(255));
      drawSeries(4,color(200));
      drawSeries(5,color(150));
    }
  }
  
  void drawSeries(int seriesIndex, int c)
  {
    pushStyle();
      float wth = width;
      float spc = wth*1.f/lineCols.length;
      noFill();
      
      stroke(c);
      beginShape();
      for(int i = 0; i < lineCols.length; i++)
      {
        vertex(spc*i,lineCols[i][seriesIndex]);
      }
      endShape();
    popStyle();
  }
  //calc the color vals in between
  private void setLinePoints()
  {
    if(null == img) return;
    //println("start: " + start.pos[0] + "," + start.pos[1]);
    //println("end: " + end.pos[0] + "," + end.pos[1]);
    
    //println("startuv: " + start.uv[0] + "," + start.uv[1]);
    //println("enduv: " + end.uv[0] + "," + end.uv[1]);
    float len = dist(start.uv[0]*img.width,
                     start.uv[1]*img.height,
                     end.uv[0]*img.width,
                     end.uv[1]*img.height);
    float count = 600;//(len/500);
    lineCols = new float[(int)count][6];
    float [] step = {end.uv[0]-start.uv[0],
                     end.uv[1]-start.uv[1]};
    step[0]/=count;step[1]/=count;
    //println("count: " + count);
    //println("step: " + step[0] + ", " +step[1]);
    for(int i = 0; i < lineCols.length; i++)
    {
      float[] curUV = {start.uv[0],start.uv[1]};
      curUV[0] += step[0]*i;
      curUV[1] += step[1]*i;
      int c = img.get((int)(curUV[0]*img.width),
                      (int)(curUV[1]*img.height));
      lineCols[i][0] = red(c);
      lineCols[i][1] = green(c);
      lineCols[i][2] = blue(c);
      lineCols[i][3] = hue(c);
      lineCols[i][4] = saturation(c);
      lineCols[i][5] = brightness(c);
    }
  }
  
  void mouseDown()
  {
    println("mouseDown start:" + start.toStr());
    if(start.clickedOn(mouseX,mouseY))
    {
      start.selected = true;
      println("start selected");   
    }
    else if(end.clickedOn(mouseX,mouseY))
    {
      end.selected = true;
      println("end selected");
    }
    println("mouseDown start:" + start.toStr());
  }
  
  void printMouse()
  { println("mousexy: " + mouseX+","+mouseY);  }
  
  void mouseDrag()
  {
    //println("b mouseDrag start:" + start.toStr());
    float[] nPos = {mouseX,mouseY};
    float[] nUV = {mouseX*1.f/width,mouseY*1.f/height};
   //printMouse();
    if(start.selected)
    {  
    start.pos[0] = nPos[0]; 
    start.pos[1] = nPos[1]; 
    start.uv[0]=nUV[0];
    start.uv[1]=nUV[1];}
    else if(end.selected)
    { end.pos[0] = nPos[0]; end.pos[1] = nPos[1]; end.uv[0]=nUV[0];end.uv[1]=nUV[1];}
    //println("e mouseDrag start:" + start.toStr());
    setLinePoints();
    
  }
  void mouseRelease()
  {
    //mouseDrag();
    //if(start.selected || end.selected)
    //{
      //setLinePoints();
    //}
    start.selected = false;
    end.selected = false;
  }
}
