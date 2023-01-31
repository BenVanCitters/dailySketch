LEDSim ledSim;

void setup()
{
  size(600,600);
  ledSim = new LEDSim(25);
}


void draw()
{
  background(0);
   
  long m = millis();
  
    float[] a = {255,100,255};
    float[] b = {0,-50,25};
    float[] c = {200,200,0};
    float[] d = {255,100,0};
  drawBez(a,b,c,d);
  ledSim.drawC(m,new CCM(){
    public int getColor(int index,int total, int previous,long millis)
    {
      
float[] a = {255,100,255};
    float[] b = {0,-50,25};
    float[] c = {200,200,0};
    float[] d = {255,100,0};
    
      float s = millis/1000.f;
      float r = (noise(s*.5,index+s*2));    
      //float g = red(previous);
      return colorFromRange(r,a,b,c,d);
    }});
}

//returns color from a float number between 0-1
int colorFromRange(float pct,float[] a,  float[] b,  float[] c,  float[] d)
{
    float[] resultc = bezier(pct, a,b,c,d);
  return color(resultc[0],resultc[1],resultc[2]);
}

void drawBez(float[] a,  float[] b,  float[] c,  float[] d)
{
  pushStyle();
  int count = 100;
  noStroke();
  for(int i = 0; i < count; i++)
  {
    float t = i*1.f/(count-1);
 
    
    float[] result = bezier(t,a,b,c,d);
    int col = color(result[0],result[1],result[2]);
    fill(col);
    rect(0,t*height,100,height*1.f/count);
  } 
  popStyle();
}

void testBezzy()
{
  //beginShape();
  //stroke(255);
  //noFill();
  noStroke();
  int count = 1+(int)(mouseX*500.f/width);
  for(int i = 0; i < count; i++)
  {
    float[] a = {0,0,0};
    float[] b = {width,0,0};
    float[] c = {width,height,0};
    float[] d = {0,height,0};
    float t = i*1.f/(count-1);
    float[] result = bezier(t, a,b,c,d);
    
    
    float[] ac = {0,100,255};
    float[] bc = {255,0,255};
    float[] cc = {255,255,128};
    float[] dc = {0,255,255};
    
    float[] resultc = bezier(t, ac,bc,cc,dc);
    fill(resultc[0],resultc[1],resultc[2]);
    
    ellipse(result[0],result[1],5,5);
  } 
  endShape();
}
