class CanBot
{
  float exploredPct;
  float fitness;
  
  int[] pos = new int[2];
  int cans;
  //0 = go up
  //1=go left
  //2= pickup
  //3=go right
  //4=go down
  public int[] actionMap = new int[1024];
  public CanBot(CanBot cb)
  {
    this.actionMap = cb.actionMap.clone();
    this.pos = cb.pos.clone();
    this.cans = cb.cans;
  }
  public CanBot(int[] actionMap)
  {
    this.actionMap = actionMap;
  }
  
  public int getAction(int index)
  {
      //0 = go up
  //1=go left
  //2= pickup
  //3=go right
  //4=go down
   return actionMap[index]; 
  }
}
