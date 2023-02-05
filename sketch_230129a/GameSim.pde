class GameSim
{
  GameBoard board;
  CanBot canBot;
  ArrayList<CanBot> curGeneration;
  int[][] rboard;
  boolean[][] travelled;
  int startingCanCount;
  int curIteration = 0;
  
  int CLEAR = 0;
  int WALL = 1;
  int CAN = 2;
  
  public GameSim(GameBoard gb)
  {
    board = gb;  
    curGeneration = new ArrayList<CanBot>();
  }
  
  void setup()
  {
    rboard = new int[board.bWidth][board.bHeight];
    travelled = new boolean[board.bWidth][board.bHeight];
    canBot = board.cb;
    
    canBot.pos[0] = board.bWidth/2;
    canBot.pos[1] = board.bHeight/2;
    
    //path = new ArrayList<int[]>();
    //path.add(canBot.pos);
    travelled[canBot.pos[0]][canBot.pos[1]] = true;
    //clear the board
    for(int i = 0; i < board.bWidth; i++)
    {
      for(int j = 0; j < board.bHeight; j++)
      {
        rboard[i][j] = CLEAR;
      }
    }
    
    // add the cans
    for(int i = 0; i < board.cans.length; i++)
    {
      int[] index = board.cans[i].pos;
      rboard[index[0]][index[1]] = CAN;
    }
    
    //add the walls
    for(int i = 0; i < board.walls.length; i++)
    {
      int[] index = board.walls[i].pos;
      rboard[index[0]][index[1]] = WALL;
    }
    startingCanCount = getCurrentCanCount();
  }
  
  void endSim()
  {
    canBot.fitness = getFitnessScoreForBot(canBot);
    canBot.exploredPct = getPctAreaExplored();
    curGeneration.add(canBot);
    println("curIteration: " + curIteration + ", canBot.fitness: " + canBot.fitness);
  }
  
  int getCurrentCanCount()
  {
    int canCount = 0;
    for(int i = 0; i < rboard.length; i++)
    {
      for(int j = 0; j < rboard[0].length; j++)
      {
        if(rboard[i][j] == CAN)
          canCount++;
      }
    }
    return canCount;
  }
  void interate()
  {
    //println("iterate " + millis());
    int action = getActionForCurBot();
    doActionForBot(action);
    travelled[canBot.pos[0]][canBot.pos[1]] = true;

    curIteration++;   
    //float curScore = getFitnessScoreForBot(canBot);
   // println("curIteration: " + curIteration + ", curScore: " + curScore);
  }
  
  int  getActionForCurBot()
  {
    //0 = above
    //1=left
    //2=me
    //3=right
    //4=below
    int cx = canBot.pos[0];
    int cy = canBot.pos[1];
    int topVal = (cy >= 0) ? rboard[cx][cy-1] : WALL;
    int leftVal = (cx >= 0) ? rboard[cx-1][cy] : WALL;
    int midVal = rboard[cx][cy];
    int rightVal = (cx < rboard.length-1) ? rboard[cx+1][cy] : WALL;
    int belowVal = (cy < rboard[0].length-1) ? rboard[cx][cy+1] : WALL;
    //encode as 'index'
    int result =        (topVal << 8);
    result = result |  (leftVal << 6);
    result = result |   (midVal << 4);
    result = result | (rightVal << 2);
    result = result | (belowVal << 0);
    int action = canBot.getAction(result);
   
    return action;
  }
  
  void doActionForBot(int action)
  {
    int cx = canBot.pos[0];
    int cy = canBot.pos[1];
    
    if(action == 0)
    {
      //println("go up");
      if(cy > 0 && (rboard[cx][cy-1] != WALL))
      {
        canBot.pos[1] -= 1;
      }
    }
    else if(action == 1)//left
    {
      //println("go left");
      if(cx > 0 && (rboard[cx-1][cy] != WALL))
      {
        canBot.pos[0] -= 1;
      }
    }
    else if(action == 2) //pickup
    {
      //println("pick up");
      if(rboard[cx][cy] == CAN)
      {
        rboard[cx][cy] = CLEAR;
        canBot.cans+=1;
      }
    }
    else if(action == 3) //right
    {
      //println("go right");
      if(cx < rboard.length-1 && (rboard[cx+1][cy] != WALL))
      {
        canBot.pos[0]+=1;
      }
    }
    else if(action == 4) //down
    {
      //println("go down");
      if(cy < rboard[0].length-1 && (rboard[cx][cy+1] != WALL))
      {
        canBot.pos[1]+=1;
      }
    }
    else
    {
      println("WTF received action: " + action +  " at cb pos: " + canBot.pos[0] + " ," + canBot.pos[1]);
    }
  }
  void draw()
  {
    float w = width*1.f/rboard.length;
    float h = height*1.f/rboard[0].length;
    //print("w: " + w);
    for(int i = 0; i < rboard.length; i++)
    {
      for(int j = 0; j < rboard[0].length; j++)
      {
        pushMatrix();
        translate(i*w,j*h);
        if(rboard[i][j] == CLEAR)
          fill(0,0,0);
        if(rboard[i][j] == WALL)
          fill(255,255,255);
        if(rboard[i][j] == CAN)
          fill(100,100,100);
        //stroke(255);
        rect(0,0,w,h);
        popMatrix();
      }
    } 
    pushMatrix();
      translate(canBot.pos[0]*w, canBot.pos[1]*h);
      fill(255,255,0);
      rect(0,0,w,h);
    popMatrix();
  }
  
  float getFitnessScoreForBot(CanBot cb)
  {
    //score should be a combination of total % cans picked up and total area explored %
    float pctAreaExplored = getPctAreaExplored();
    float pctCansGathered = getPctCansCollected(cb);
    return pctAreaExplored*100 + pctCansGathered*300;
  }
  
  float getPctAreaExplored()
  {
    float pctAreaExplored = 0;
    int exploredCount = 0;
    int explorableArea = 0;
    travelled[canBot.pos[0]][canBot.pos[1]] = true;
    for(int i = 0; i < travelled.length; i++)
    {
      for(int j = 0; j < travelled[0].length; j++)
      {
        if(travelled[i][j])
        {
          exploredCount++;
        }
        if(rboard[i][j] != WALL)
        {
          explorableArea++;
        }
      }
    }
    pctAreaExplored = exploredCount*1.f/( explorableArea);
    return pctAreaExplored;
  }
  
  float getPctCansCollected(CanBot cb)
  {
    float pctCansCollected = cb.cans*1.f/startingCanCount;
    //subtract cans remaining from starting cans 
    return pctCansCollected;
  }
}
