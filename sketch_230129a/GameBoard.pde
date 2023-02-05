class GameBoard{
  public int bWidth = 50;
  public int bHeight = 50;
  public Can cans[];
  public Wall walls[];
    
  public GameBoard()
  {
  }
  
  public GameBoard(GameBoard gb)
  {
    this.bWidth = gb.bWidth;
    this.bHeight = gb.bHeight;
    this.cans = gb.cans.clone();
    this.walls = gb.walls.clone();
  }
  
  public void makeCans(int canCount)
  {
    cans = new Can[canCount];
    for(int i = 0; i < canCount; i++)
    {
      cans[i] = new Can((int)random(bWidth), (int)random(bHeight));
    }
  }
  
  public void makeBorderWalls()
  {
    int borderCount = bWidth*2 + bHeight*2 - 4;
    walls = new Wall[borderCount];
    int startIndex = 0;
    for(int i = 0; i < bWidth; i++,startIndex++)
    {
      walls[startIndex] = new Wall(i,0);
    }
    for(int i = 0; i < bWidth; i++,startIndex++)
    {
      walls[startIndex] = new Wall(i,bHeight-1);
    }
    for(int i = 1; i < bHeight-1; i++,startIndex++)
    {
      walls[startIndex] = new Wall(0,i);
    }
        for(int i = 1; i < bHeight-1; i++,startIndex++)
    {
      walls[startIndex] = new Wall(bWidth-1,i);
    }
  }
}
