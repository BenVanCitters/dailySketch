SurfTex s;
SquareMarcher sm = new SquareMarcher();
void setup()
{
  size(900,900);
  s = new SurfTex();
  s.renderTex();
  render();
}

void draw()
{
//  s.renderTex();
//render();
}

void render()
{
  image(s.g(),0,0);
  background(255);
  long start =  java.lang.System.currentTimeMillis();
  int cdivs = 1;
  int blockCount = 7;
  for(int i = 0; i < cdivs; i++)
  {
  stroke(0,0,255);
    sm.march(s.g(),160,blockCount,blockCount);
  //stroke(255,0,0);  
  //  sm.march(s.g(),120,blockCount,blockCount);
  //stroke(0,255,0);
  //  sm.march(s.g(),95,blockCount,blockCount);
  }
  long duration =  java.lang.System.currentTimeMillis()-start;
  println("printing took " + duration + " milliseconds");
  int blocks = cdivs*blockCount*blockCount;
  float perBlock = duration *1.f/(blocks);
  println("printed " + blocks + " blocks" );
  println("each block took " + perBlock + " milliseconds");
  println("can march " + (1000.f/60)/perBlock + " blocks at 60fps");
}
void mouseClicked()
{
  s.renderTex();
  render();
}
