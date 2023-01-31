class RTile
{
  float t_width,t_height;
  int c[];
  public float[] pos;
  PGraphics t;
    float strokew = 4;
  public RTile(){ this(1,1,new int[]{0}); }
  
  //calls rendertile, inits the graphics
  public RTile(float w, float h, int[] col){
    t_width= w; t_height = h;
    t = createGraphics((int)w,(int)h,P3D);
    c = col;
    t.beginDraw();
    renderTile();
    t.endDraw();
  }
  public void renderTile() {}
  
  public void draw() { image(t,0,0,t_width,t_height); }
}

class RTile1 extends RTile
{
  public RTile1(float w, float h, int[] col){super(w,h, col);}
  public void renderTile() 
  { 
    t.background(c[1]);
    
     strokew = 5;
    
     for(int i = 0; i < 4; i++)
      {       
        t.pushMatrix();
          t.translate(t.width/2.f,t.height/2.f);
          t.rotate(HALF_PI*i);
          if(random(2)<.6)
          {//line
            t.strokeWeight(strokew);
            t.stroke(c[0]);
            t.fill(c[1]);
            t.translate(-t.width/2.f,-t.height/2.f);
            t.ellipse(0,0,
                      t.width,t.height);
          }
          else
          {//dot
            t.translate(-t.width/2.f,0);
            t.noStroke();
            t.fill(c[0]);
            t.ellipse(0,0,
                      strokew,strokew);
          }
        t.popMatrix();
     }
  }
}

class RTile2 extends RTile
{
  public RTile2(float w, float h, int[] col){super(w,h, col);}
  public void renderTile()
  {
    strokew = 4;
    t.beginDraw();
    t.background(c[1]);
    t.strokeWeight(strokew);
    t.translate(t_width/2.f,t_height/2.f);
    t.rotate(HALF_PI*(int)(random(4)) );
    t.translate(2,0);
    //t.ellipse(0,0,0,0);
    t.stroke(c[0]);
    t.fill(c[1]);
    float ang = .63;
    t.arc(0,0,1.1*t_width,t_height*.8,HALF_PI*ang,TWO_PI-HALF_PI*ang,CHORD);

  }
}

class RTileX extends RTile
{
  public RTileX(float w, float h, int[] col){super(w,h, col);}
  public void renderTile()
  {
    strokew = 4;
    t.background(c[1]);
    t.strokeWeight(strokew);
    t.stroke(c[0]);
    t.line(0,0,t_width,t_height);
    
    t.line(0,t_height,t_width,0);
  }
}
class RTileO extends RTile
{
  public RTileO(float w, float h, int[] col){super(w,h, col);}
  public void renderTile()
  {
    strokew = 4;
    t.background(c[1]);
    t.strokeWeight(strokew);
    t.fill(c[1]);
    t.stroke(c[0]);
    t.ellipse(t_width/2,t_height/2,t_width-strokew,t_height-strokew);
  }
}
