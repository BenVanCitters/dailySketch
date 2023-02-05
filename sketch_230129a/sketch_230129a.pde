 GameSim gs;
 
 void setup()
 {
   size(500,500); 
   int []actionMap = buildActionMap();

   CanBot cb = new CanBot(actionMap);
   GameBoard gb = new GameBoard(cb);
   gb.makeBorderWalls();
   gb.makeCans(100);
   gs = new GameSim(gb);
   
   gs.setup();
   for(int i = 0; i < 1000; i++)
   {
     gs.interate();
   }
   gs.endSim();
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
