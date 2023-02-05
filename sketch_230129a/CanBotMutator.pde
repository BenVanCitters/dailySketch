class CanBotMutator
{
  void mutate(CanBot cb)
  {
    int[] actionMap = cb.actionMap;
    for(int i = 0; i < actionMap.length; i++)
    {
      if(random(1.f) > .999)
        actionMap[i] = (int)(random(4));
    }
    cb.actionMap = actionMap;
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
}
