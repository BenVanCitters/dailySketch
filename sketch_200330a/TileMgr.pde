class TileMgr
{
  ArrayList<RTile> tiles;
  int hCount;
  int wCount;
  public TileMgr()
  {
    initTiles(25,25);
  }
  
  void initTiles(int hCount, int wCount)
  {
    this.hCount = hCount;
    this.wCount = wCount;
    float tileWidth = width*1.f/wCount;
    float tileHeight = height*1.f/hCount;
    tiles = new ArrayList<RTile>();
    int[] colors = {color(255,245,100),color(10,70,120),color(0,0,255)};
    for(int i = 0; i<wCount;i++)
    {
      for(int j = 0; j<hCount;j++)
      {
        RTile t = new RTileO(tileWidth,tileHeight,colors);
        if(random(1)>.5)
        t = new RTileX(tileWidth,tileHeight,colors);
        t.pos = new float[]{i*tileWidth,
                            j*tileHeight};
        tiles.add(t);
      } 
    }
  }
  
  void draw()
  {
    for(RTile t : tiles)
    {
      pushMatrix();
      translate(t.pos[0],t.pos[1]);
      t.draw();
      popMatrix();
    }
  }
}
