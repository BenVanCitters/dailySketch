class BShape
{
  //array of <x,y,z> pairs
  float[][] verts;
  //array of <1,2,3> vertex indecies
  int[][] tris;
  int h_count = 5;
  int w_count = 1000;
  float firstRadius = 400;
  float secondRadius = 80;
  float thirdRadius = 0;
  float fourthRadius = 20; //radius of solid

  float firstRotCount = 3;
  float secondRotCount = 13;
  float thirdRotCount = 13;
  //float fourthRotCount = 1;

  public BShape(float firstRadius,
  float secondRadius,
  float thirdRadius,
  float fourthRadius,

  float firstRotCount,
  float secondRotCount,
  float thirdRotCount,  int h_count,
  int w_count)
  {
    
   this.firstRadius =firstRadius;
   this.secondRadius = secondRadius;
   this.thirdRadius = thirdRadius;
   this.fourthRadius = fourthRadius; //radius of solid

   this.firstRotCount = firstRotCount;
   this.secondRotCount = secondRotCount;
   this.thirdRotCount = thirdRotCount;
  
    tris = new int[ ( (h_count)*(w_count)*2 )][3];
    int tindex = 0;
    for(int i = 0; i < w_count; i++)
    {
     for(int j = 0; j < h_count; j++)
      {
        int UL = i+j*w_count;
        int UR = ((i+1)%w_count)+j*w_count;
        int LL = i+((j+1)%h_count)*w_count;
        int LR = ((i+1)%w_count)+((j+1)%h_count)*w_count;
        
        tris[tindex++] = new int[]{UL,UR,LL};
        tris[tindex++] = new int[]{UR,LR,LL};
      }
    }
    
    verts = new float[h_count*w_count][3];
    float[] last2ndCircPt = {0,0,0};
    float[] cur2ndCircPt = {0,0,0};
    float[] last3rdCircPt = {0,0,0};
    float[] cur3rdCircPt = {0,0,0};
    for(int i = -1; i < w_count; i++)
    {
     for(int j = -1; j < h_count; j++)
      {
        int index = i+j*w_count;
        float curRadian1st = firstRotCount*i*TWO_PI/(w_count);
        float curRadian2nd = secondRotCount*i*TWO_PI/(w_count);
        float curRadian3nd = thirdRotCount*i*TWO_PI/(w_count);
        float curRadian4th = j*TWO_PI/(h_count);
        
        float r2 = secondRadius;

        float[] posOnUnitCircle = {cos(curRadian1st),
                                   sin(curRadian1st),
                                   0}; 
        float[] posOn1stCircle = {firstRadius * posOnUnitCircle[0],
                                  firstRadius * posOnUnitCircle[1],
                                  0}; 
        float[] up = {0,0,1}; 
        float[] posOn2ndUnitCircle = {cos(curRadian2nd),
                                      sin(curRadian2nd)}; 
        float[] secndCircleNorm = {posOn2ndUnitCircle[0] * posOnUnitCircle[0],
                                   posOn2ndUnitCircle[0] * posOnUnitCircle[1],
                                   posOn2ndUnitCircle[1] * up[2]}; 
        
        float[] posOn2ndCircle = {r2 * secndCircleNorm[0],
                                  r2 * secndCircleNorm[1],
                                  r2 * secndCircleNorm[2]}; 
        cur2ndCircPt = new float[]{posOn1stCircle[0] + posOn2ndCircle[0],
                                           posOn1stCircle[1] + posOn2ndCircle[1],
                                           posOn1stCircle[2] + posOn2ndCircle[2]};         
        float[] thirdCircForward = {cur2ndCircPt[0]-last2ndCircPt[0],
                                    cur2ndCircPt[1]-last2ndCircPt[1],
                                    cur2ndCircPt[2]-last2ndCircPt[2]};                                                         
        
        float[] thirdNorm = crossProd(normalized(thirdCircForward), normalized(secndCircleNorm));
        float[] posOn3ndUnitCircle = {cos(curRadian3nd),
                                      sin(curRadian3nd)}; 
        float[] thirdNormd = {posOn3ndUnitCircle[0]*secndCircleNorm[0] + posOn3ndUnitCircle[1]*thirdNorm[0],
                              posOn3ndUnitCircle[0]*secndCircleNorm[1] + posOn3ndUnitCircle[1]*thirdNorm[1],
                              posOn3ndUnitCircle[0]*secndCircleNorm[2] + posOn3ndUnitCircle[1]*thirdNorm[2]};
        float[] posOn3rdCircle = {thirdRadius*thirdNormd[0],
                                  thirdRadius*thirdNormd[1],
                                  thirdRadius*thirdNormd[2]};
         cur3rdCircPt = new float[]{posOn1stCircle[0] + posOn2ndCircle[0] + posOn3rdCircle[0],
                                    posOn1stCircle[1] + posOn2ndCircle[1] + posOn3rdCircle[1],
                                    posOn1stCircle[2] + posOn2ndCircle[2] + posOn3rdCircle[2]};        
        //
        float[] fourthCircForward = {cur3rdCircPt[0]-last3rdCircPt[0],
                                     cur3rdCircPt[1]-last3rdCircPt[1],
                                     cur3rdCircPt[2]-last3rdCircPt[2]};                                                         
        
        float[] fourthNorm = crossProd(normalized(fourthCircForward), normalized(thirdNormd));
        float[] posOn4thUnitCircle = {cos(curRadian4th),
                                      sin(curRadian4th)}; 
        float[] fourthNormd = {posOn4thUnitCircle[0]*thirdNormd[0] + posOn4thUnitCircle[1]*fourthNorm[0],
                               posOn4thUnitCircle[0]*thirdNormd[1] + posOn4thUnitCircle[1]*fourthNorm[1],
                               posOn4thUnitCircle[0]*thirdNormd[2] + posOn4thUnitCircle[1]*fourthNorm[2]};
        float[] posOn4thCircle = {fourthRadius*fourthNormd[0],
                                  fourthRadius*fourthNormd[1],
                                  fourthRadius*fourthNormd[2]};
        if(i>=0 && j>=0)
        {
          verts[index] = new float[]{posOn1stCircle[0] + posOn2ndCircle[0] + posOn3rdCircle[0] + posOn4thCircle[0],
                                     posOn1stCircle[1] + posOn2ndCircle[1] + posOn3rdCircle[1] + posOn4thCircle[1],
                                     posOn1stCircle[2] + posOn2ndCircle[2] + posOn3rdCircle[2] + posOn4thCircle[2]};
        }
      }
      if(cur2ndCircPt[0] != last2ndCircPt[0] || cur2ndCircPt[1] != last2ndCircPt[1] || cur2ndCircPt[2] != last2ndCircPt[2] ) 
      {
          last2ndCircPt = cur2ndCircPt;
      }
      if(cur3rdCircPt[0] != last3rdCircPt[0] || cur3rdCircPt[1] != last3rdCircPt[1] || cur3rdCircPt[2] != last3rdCircPt[2] ) 
      {
          last3rdCircPt = cur3rdCircPt;
      }
    }  
  }
  
  void draw()
  {
    
    
 //   for(int i = 0; i < w_count; i++)
 //   {
 //   beginShape();
 //   for(int j = 0; j < h_count; j++)
 //     {
 //       int index = i+j*w_count;
 //       vertex(verts[index][0],
 //              verts[index][1],
 //              verts[index][2]);
 //     } 
   
 //endShape(); 
 // }
    //noStroke();
    beginShape(TRIANGLES);
    //noFill();
    noStroke();
    colorMode(HSB,255);
    for(int i = 0; i < tris.length; i++)
    {      
      //float pct = (millis()/7000.f+i*1.f/tris.length)%1.f;
      //int c = (i%2)*color(255*pct,255,255);
      //fill(c);
      for(int j = 0; j < tris[i].length; j++)
      {
      int idx = tris[i][j];
      vertex(verts[idx][0],
             verts[idx][1],
             verts[idx][2]);
      }
    }
    endShape(); 
  }
  
  void saveAsOBJ()
  {
    print("saving...");
    String[] lines = new String[verts.length+tris.length];
    int lineIndex = 0;
    for(int i = 0; i < verts.length; i++)
    {
      lines[lineIndex++] = "v " + verts[i][0] + " " +verts[i][2] + " " +verts[i][1];
    }
    for(int i = 0; i < tris.length; i++)
    {
      int v[] = {tris[i][0]+1,tris[i][1]+1,tris[i][2]+1};
      lines[lineIndex++] = "f " + v[0] + " " +v[1] + " " + v[2];
    }
    saveStrings("file.obj", lines);
    print("saved!");
  }
}
