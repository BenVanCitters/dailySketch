class SquareMarcher
{
  public SquareMarcher()
  {}
  
  public void march(PGraphics g, float thresh, int hDivs, int vDivs)
  {
    g.loadPixels();
    float divW = (g.width-1)*1.f/hDivs;
    float divH = (g.height-1)*1.f/vDivs;
    for(int i = 0; i < hDivs; i++)
    {
      float ipct = i*1.f/hDivs;
      for(int j = 0; j < vDivs; j++)
      {
        float jpct = j*1.f/vDivs;
        float[][] quadPos = {{i*divW,j*divH},
                             {(i+1)*divW,j*divH},
                             {(i+1)*divW,(j+1)*divH},
                             {i*divW,(j+1)*divH}};
        
        march(g,quadPos,thresh);
      } 
    }
  }
  
  // faster but returns results equivalent to g.get((int)xy[0],(int)xy[1]); 
  int myGet(PGraphics g, float[] xy)
  {
    int index = (int)xy[0]+(int)xy[1]*g.width;
    return g.pixels[index];
  }
  
  //does logical AND to get val of blue channel
  int myBright(int c)
  {
   return c >> 16 & 0xFF; //red
   //return c >> 8 & 0xFF; //green?
    //return  c & 0xFF;//blue
  }
  
  private void march(PGraphics g,float[][] quadPos,float thresh)
  {
    float[] ULp = quadPos[0];
    float[] URp = quadPos[1];
    float[] LRp = quadPos[2];
    float[] LLp = quadPos[3];
    float[] MLp = {(ULp[0]+LLp[0])/2.f,//mid left pos
                   (ULp[1]+LLp[1])/2.f};                       
    float[] MUp = {(ULp[0]+URp[0])/2.f,//mid upper pos
                   (ULp[1]+URp[1])/2.f};                
    float[] MRp = {(URp[0]+LRp[0])/2.f,//mid right pos
                   (URp[1]+LRp[1])/2.f};                
    float[] MBp = {(LLp[0]+LRp[0])/2.f,//mid base pos
                   (LLp[1]+LRp[1])/2.f};


    int[] corners = {0,0,0,0}; //UL,UR,LR,LL
    //if(g.get(0,0) > thresh)
    corners[0] = myGet(g,ULp);//g.get((int)ULp[0],(int)ULp[1]); 
    corners[1] = myGet(g,URp);//g.get((int)URp[0],(int)URp[1]); 
    corners[2] = myGet(g,LRp);//g.get((int)LRp[0],(int)LRp[1]); 
    corners[3] = myGet(g,LLp);//g.get((int)LLp[0],(int)LLp[1]);
    
    boolean UL = myBright(corners[0]) > thresh;
    boolean UR = myBright(corners[1]) > thresh;
    boolean LR = myBright(corners[2]) > thresh;
    boolean LL = myBright(corners[3]) > thresh;       
    int caseNum  = UL ?8:0;
        caseNum |= UR ?4:0;
        caseNum |= LR ?2:0;
        caseNum |= LL ?1:0;
    switch(caseNum) 
    {
      case 1:
      case 14:
        //println("case 1/14");
        line(MLp[0],MLp[1],MBp[0],MBp[1]);
        break;
      case 2:    
      case 13:
        //println("case 2/13");
        line(MRp[0],MRp[1],MBp[0],MBp[1]);
        break;
      case 3:
      case 12:
       //println("case 3/12");
        line(MLp[0],MLp[1],MRp[0],MRp[1]);
        break;
      case 4:
      case 11:
        //println("case 4/11");
        line(MUp[0],MUp[1],MRp[0],MRp[1]);
        break;
      case 5:
        //println("case 5");
        line(MLp[0],MLp[1],MUp[0],MUp[1]);
        line(MRp[0],MRp[1],MBp[0],MBp[1]);
        break;
      case 6:
      case 9:
        //println("case 6/9");
        line(MUp[0],MUp[1],MBp[0],MBp[1]);
        break;
      case 7:
      case 8:
        //println("case 7/8");
        line(MLp[0],MLp[1],MUp[0],MUp[1]);
        break;

      case 10:
        //println("case10");
        line(MLp[0],MLp[1],MBp[0],MBp[1]);
        line(MUp[0],MUp[1],MRp[0],MRp[1]);
        break;

      default:
    }
      
    //if( !UL && !UR&& !LR&& !LL)//case0
    //{
    //  //println("case0");
    //  //nothing
    //}
    //else if( !UL && !UR && !LR && LL)//case1
    //{
    //  //println("case1");
    //  //line(MLp[0],MLp[1],MBp[0],MBp[1]);
    //}
    //else if( !UL && !UR && LR && !LL)//case2
    //{
    //  //println("case2");
    //  //line(MRp[0],MRp[1],MBp[0],MBp[1]);
    //}
    //else if( !UL && !UR && LR && LL)//case3
    //{     
    //  ////println("case3");
    //  //line(MLp[0],MLp[1],MRp[0],MRp[1]);
    //}
    //else if( !UL && UR && !LR && !LL)//case4
    //{
    //  ////println("case4");
    //  //line(MUp[0],MUp[1],MRp[0],MRp[1]);
    //}
    //else if( !UL && UR && !LR && LL)//case5
    //{
    //  ////println("case5");
    //  //line(MLp[0],MLp[1],MUp[0],MUp[1]);
    //  //line(MRp[0],MRp[1],MBp[0],MBp[1]);
    //}
    //else if( !UL && UR && LR && !LL)//case6
    //{
    //  //println("case6");
    //  //line(MUp[0],MUp[1],MBp[0],MBp[1]);
    //}
    //else if( !UL && UR && LR && LL)//case7
    //{
    //  ////println("case7");
    //  //line(MLp[0],MLp[1],MUp[0],MUp[1]);
    //}
    //else if( UL && !UR && !LR && !LL)//case8
    //{
    //  ////println("case8");
    //  //line(MLp[0],MLp[1],MUp[0],MUp[1]);
    //}
    //else if( UL && !UR && !LR && LL)//case9
    //{
    //  ////println("case9");
    //  //line(MUp[0],MUp[1],MBp[0],MBp[1]);
    //}
    //else if( UL && !UR && LR && !LL)//case10
    //{
    //  ////println("case10");
    //  //line(MLp[0],MLp[1],MBp[0],MBp[1]);
    //  //line(MUp[0],MUp[1],MRp[0],MRp[1]);
    //}
    //else if( UL && !UR && LR && LL)//case11
    //{
    //  ////println("case11");
    //  //line(MUp[0],MUp[1],MRp[0],MRp[1]);
    //}
    //else if( UL && UR && !LR && !LL)//case12
    //{
    //  ////println("case12");
    //  //line(MLp[0],MLp[1],MRp[0],MRp[1]);
    //}
    //else if( UL && UR && !LR && LL)//case13
    //{
    //  ////println("case13");
    //  //line(MRp[0],MRp[1],MBp[0],MBp[1]);
    //}
    //else if( UL && UR && LR && !LL)//case14
    //{
    //  ////println("case14");
    //  //line(MLp[0],MLp[1],MBp[0],MBp[1]);
    //}
    //else if( UL && UR && LR && LL)//case15
    //{
    //  //println("case15");
    //  //nothing
    //}
    //println("brightness 0: " + brightness(corners[0]) + 
    //                " 1: " + brightness(corners[1]) + 
    //                " 2: " + brightness(corners[2])+ 
    //                " 3: " + brightness(corners[3]));
    //println("corners 0: " + corners[0] + " 1: " + corners[1] + " 2: " + corners[2]+ " 3: " + corners[3]);
    //println("UL: " + UL + " UR: " + UR + " LR: " + LR + " LL: " + LL);
    
    
  }
    
}
