int hCount = 15;
int vCount = 15;
int sides = 6;
int vertCount = hCount*vCount*sides;

float[][] positions = new float[vertCount][3];
float[][] normalizeVerts = new float[vertCount][3];
float[][] shownVerts = new float[vertCount][3];
int[][] triangles = new int[sides*2*(hCount-1)*(vCount-1)][3];
int groupCount = 2;
mLight[] lights = new mLight[groupCount];
float[][] groupOffSets = {{0,0,1},{0,0,-1},{1,0,0},{-1,0,0},{0,1,0},{0,-1,0}};
ArrayList<ArrayList<int[]>> tris = new ArrayList<ArrayList<int[]>>();


void setup()
{
  size(1300,1300,P3D);
  initVerts();
  initLights();
}

void initLights()
{
  for(int i = 0; i < lights.length; i++)
  {
    lights[i] = new mLight();
  }
}

void initVerts()
{
  int curIndex = 0;
  int indeciesPerSide = hCount*vCount;
  //top
  for(int i = 0; i < indeciesPerSide; i++)
  {
    int index = i+indeciesPerSide*0;
    int x = i%hCount;
    float xPct = (x*1.f/(hCount-1));
    int y = i/hCount;
    float yPct = (y*1.f/(vCount-1));
    positions[index][0] = -.5+xPct;
    positions[index][1] = .5;
    positions[index][2] = -.5+yPct;
  }
  //bottom
  for(int i = 0; i < indeciesPerSide; i++)
  {
    int index = i+indeciesPerSide*1;
    int x = i%hCount;
    float xPct = (x*1.f/(hCount-1));
    int y = i/hCount;
    float yPct = (y*1.f/(vCount-1));
    positions[index][0] = .5-xPct;
    positions[index][1] = -.5;
    positions[index][2] = .5-yPct;
  }
    //fromt
  for(int i = 0; i < indeciesPerSide; i++)
  {
    int index = i+indeciesPerSide*2;
    int x = i%hCount;
    float xPct = (x*1.f/(hCount-1));
    int y = i/hCount;
    float yPct = (y*1.f/(vCount-1));
    positions[index][0] = -.5+xPct;
    positions[index][1] = -.5+yPct;
    positions[index][2] = -.5;
  }
  
  //back
  for(int i = 0; i < indeciesPerSide; i++)
  {
    int index = i+indeciesPerSide*3;
    int x = i%hCount;
    float xPct = (x*1.f/(hCount-1));
    int y = i/hCount;
    float yPct = (y*1.f/(vCount-1));
    positions[index][0] = .5-xPct;
    positions[index][1] = .5-yPct;
    positions[index][2] = .5;
  }
  
    //left
  for(int i = 0; i < indeciesPerSide; i++)
  {
    int index = i+indeciesPerSide*4;
    int x = i%hCount;
    float xPct = (x*1.f/(hCount-1));
    int y = i/hCount;
    float yPct = (y*1.f/(vCount-1));
    positions[index][0] = -.5;
    positions[index][1] = -.5+yPct;
    positions[index][2] = -.5+xPct;
  }
  //right
  for(int i = 0; i < indeciesPerSide; i++)
  {
    int index = i+indeciesPerSide*5;
    int x = i%hCount;
    float xPct = (x*1.f/(hCount-1));
    int y = i/hCount;
    float yPct = (y*1.f/(vCount-1));
    positions[index][0] = .5;
    positions[index][1] = -.5+yPct;
    positions[index][2] = -.5+xPct;
  }
  
  for(int i = 0; i < positions.length; i++)
  {
    normalizeVerts[i] = normalize(positions[i]);
  }

  //triangles
  int triIndex = 0;
  for(int j = 0; j < sides; j++)
  {
    for(int y = 0; y < vCount-1; y++)
    {
      for(int x = 0; x < hCount-1; x++)
      {
        int vIndex = j*vCount*hCount+x+y*hCount;
//        println(vIndex);
        triangles[triIndex][0] = (int)(vIndex);
        triangles[triIndex][1] = (int)(vIndex+1);
        triangles[triIndex][2] = (int)(vIndex+hCount);
        triIndex++;
        triangles[triIndex][0] = (int)(vIndex+1);
        triangles[triIndex][1] = (int)(vIndex+1+hCount);
        triangles[triIndex][2] = (int)(vIndex+hCount);
        triIndex++;
      }
    }
  }
  ArrayList<int[]> triList = new ArrayList<int[]>();
  for(int i = 0; i < triangles.length; i++)
  {
    triList.add(triangles[i]);
  }
  

  for(int i = 0; i < groupCount; i++)
  {
    ArrayList<int[]> ntriList = new ArrayList<int[]>();
    tris.add(ntriList); 
  }
  
  for(int[] tri : triList)//int i = 0; i < triList.size(); i++)
  {
    int rndIndex = (int)(random(groupCount));
    ArrayList<int[]> ntriList = tris.get(rndIndex);
    ntriList.add(tri);
  }
  
}


void draw()
{
  float tm = millis()/1000.f;
  processVerts();
  colorMode(RGB, 255);
  background(180,50,200);
  pushMatrix();
  updateLights();

  translate(width/2,height/2);
  scale(500);
  noStroke();
//  strokeWeight(.001);
  
  for(int i = 0; i < tris.size(); i++)
  {
    ArrayList<int[]> ntriList = tris.get(i);
    int lightIndex = 0;
    mLight l = lights[i];
    colorMode(HSB, 255);
    directionalLight(l.rgbColor[0], 255, 255, 
                     l.dir[0], l.dir[1], l.dir[2]);
    pushMatrix();
    
    rotateX(tm*.2);
    rotateY(tm*.31);
    rotateZ(tm*.41);
    for(int[] tri : ntriList)
    {
     
      beginShape(TRIANGLES);
      for(int j = 0; j < tri.length; j++)
      {
        fill(255);//random(255),random(255),random(255));
        float[] pt = shownVerts[tri[j]];
        vertex(pt[0],pt[1],pt[2]);
      }  
      
      for(int j = 0; j < tri.length; j++)
      {
        fill(255);//random(255),random(255),random(255));
        float[] pt = shownVerts[tri[j]];
        vertex(pt[0]+groupOffSets[i][0]*2,
               pt[1]+groupOffSets[i][1]*2,
               pt[2]+groupOffSets[i][2]*2);
      }  
      endShape();
    }
    popMatrix();
    noLights();
  }
  popMatrix();
  println(frameRate);
}

void updateLights()
{
  float tm = millis()/1000.f;
  for(int i = 0; i < lights.length; i++)
  {
    lights[i].update(tm);
  } 
}

void processVerts()
{
  float tm = millis()/1000.f;
  for(int i = 0; i < positions.length; i++)
  {
    shownVerts[i] = lerp(normalizeVerts[i],positions[i],((1+sin(tm*.2))/2) );
  }
}

float[] lerp(float[] a, float[] b, float amt)
{
  float[] diff = {a[0]-b[0],
                  a[1]-b[1],
                  a[2]-b[2]};
   
  return new float []{diff[0]*amt+b[0],
                      diff[1]*amt+b[1],
                      diff[2]*amt+b[2],}; 
}

float[] normalize(float[] f)
{
  float d = dist(0,0,0,f[0],f[1],f[2]);
  return new float[]{f[0]/d,f[1]/d,f[2]/d};
}
