class CanBotOperations
{
  CanBot mutate(CanBot cb)
  {
    for(int i = 0; i < cb.actionMap.length; i++)
    {
      if(random(1.f) > .9)
        cb.actionMap[i] = (int)(random(4));
    }
    return cb;
  }
  
  int[] blend(CanBot cba, CanBot cbb)
  {
    int[] actionMapA = cba.actionMap;
    int[] actionMapB = cbb.actionMap;
    
    int[] actionMapResult = new int[cba.actionMap.length];
    for(int i = 0; i < actionMapA.length; i++)
    {
      if(i%2==0)
        actionMapResult[i] = actionMapA[i];
      else
        actionMapResult[i] = actionMapB[i];
    }
    return actionMapResult;
  }
  
  ArrayList<CanBot> selectBots(ArrayList<CanBot> bots)
  {
    java.util.Collections.sort(bots);
    //take the top half!
    ArrayList<CanBot> selectedResults = new ArrayList<CanBot>( bots.subList(0, bots.size()*3/4) );// new ArrayList<CanBot>();
    return selectedResults;
  }
  
  CanBot[][] getPairingsFromSelected(ArrayList<CanBot> bots, int pairingCount)
  {
    CanBot[][] pairings = new CanBot[pairingCount][2];
    for(int i = 0; i < pairingCount; i++)
    {
      int randIndex = (int)( random( bots.size() ) );
      CanBot CanBotA = bots.remove(randIndex);
      randIndex = (int)( random( bots.size() ) );
      CanBot CanBotB = bots.remove(randIndex);
      pairings[i] = new CanBot[]{CanBotA, CanBotB}; 
      bots.add(CanBotA);
      bots.add(CanBotB);
    }
    return pairings;
  }
  
  CanBot[] getNewBotsFromPairings(CanBot[][] pairings)
  {
    CanBot[] babyResults = new CanBot[pairings.length];
    
    for(int i = 0; i < pairings.length; i++)
    {
      int[] actionMap = blend(pairings[i][0], pairings[i][1]);
      
       babyResults[i] = mutate( new CanBot(actionMap) );
    }
    return babyResults;
  }
}
