 GameSim gs;
 
void setup()
{
  size(500,500); 
  
  //create initial bots
  int canBotCount = 500;
  CanBot[] canBots = new CanBot[canBotCount];
  for(int i = 0; i < canBotCount; i++)
  {
    int[] actionMap = buildActionMap();
    canBots[i] = new CanBot(actionMap);
  }
 
    gs = new GameSim();
    GameBoard gb = new GameBoard();
    gb.makeBorderWalls();
    gb.makeCans(100);
  int genCount = 100;
  for(int k = 0; k < genCount; k++)
  {
     
    for(int j = 0; j < canBotCount; j++)
    {
      gs.setup(canBots[j],gb);
      int iterationCount = 1000;
      for(int i = 0; i < iterationCount; i++)
      {
        gs.interate();
      }
      gs.endSim();
    }
     ArrayList<CanBot> bots = gs.curGeneration;
     for(CanBot c : bots)
     {
       //println("fitness: " + c.fitness);
     }
     CanBotOperations ops = new CanBotOperations();
     ArrayList<CanBot> seleccted = ops.selectBots(gs.curGeneration);
     CanBot[][] pairs = ops.getPairingsFromSelected( seleccted, gs.curGeneration.size() );
     canBots = ops.getNewBotsFromPairings(pairs);
     gs.setup(bots.get(0),gb);
     println("gen " + k + ": fitness: " + bots.get(0).fitness);
  }
}

int[] buildActionMap()
{
  //0 = go upfo
  //1=go left
  //2= pickup
  //3=go right
  //4=go down
  int []actionMap = new int[1024];
  for(int i = 0; i < actionMap.length; i++)
  {
    actionMap[i] = (int)(random(4));
  }
  return actionMap;
}
void mouseClicked()
{
  gs.interate();
}
void draw()
{
  gs.draw();
}
