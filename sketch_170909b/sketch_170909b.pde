float[][] positions;

void setup()
{
  size(600,600,P3D);
//  createPositionsWithCircle(20);
createPositionsWithRegularPoly(20,3);
}

//create position points eveny distributed around a circle
void createPositionsWithCircle(int count)
{
  positions = new float[count][3];
  float circleRadius = 1.f;
  for(int i = 0; i < count; i++)
  {
    float pct = i*1.f/(count-1);
    float currentRadian = TWO_PI*pct;
    positions[i] = new float[] {circleRadius*cos(currentRadian),
                                circleRadius*sin(currentRadian),
                                0};              
  }
}

//create points 'evenly' distributed long the edges of a regular n-sided polygon
void createPositionsWithRegularPoly(int countPerSide,int sides)
{
  positions = new float[countPerSide*sides][3];
  float[][] normTriPoints = new float[sides][3]; 
  for(int i = 0; i < sides; i++)
  {
    float pct = i*TWO_PI/sides;
    normTriPoints[i] = new float[]{cos(pct),sin(pct),0};
  }

  for(int j = 0; j < sides; j++)
  {
    int firstIndex = j;
    int secondIndex = (j+1)%sides;
    float[] firstPos = normTriPoints[firstIndex];
    float[] secondPos = normTriPoints[secondIndex];
      
    println("first: " + firstIndex + " secondIndex: " + secondIndex);
    println("firstPos: " + firstPos[0] + "," + firstPos[1] + " secondPos: " + secondPos[0] + "," + secondPos[1]);
    for(int i = 0; i < countPerSide; i++)
    {
      float pct = i*1.f/(countPerSide);
      positions[countPerSide*j+i] = lerpFromAToB(pct,firstPos,secondPos);              
    }
  }
}

//lerp a 3-vector from a to b
float[] lerpFromAToB(float amt, float[] A, float[] B)
{
  float[] bMinA = {B[0]-A[0],
                   B[1]-A[1],
                   B[2]-A[2]};
  float[] result = {bMinA[0]*amt,
                    bMinA[1]*amt,
                    bMinA[2]*amt};
  result[0]+=A[0];result[1]+=A[1]; result[2]+=A[2];
  return result;
}

//normalize all vectors in the shape
float[][] getUnitCircularPositions()
{
  float[][] newPos = new float[positions.length][3];
  for(int i = 0; i < positions.length; i++)
  {
    float d = dist(0,0,0,positions[i][0],positions[i][1],positions[i][2]);
    newPos[i][0] = positions[i][0]/d;
    newPos[i][1] = positions[i][1]/d;
    newPos[i][2] = positions[i][2]/d;
  }
  return newPos;
}

void draw()
{
  background(0,255,200);
  float tm = millis()/1000.f;
  
  //this doesn't need to happen every frame....
  float[][] triPos = positions;
  float[][] circPos = getUnitCircularPositions();//positions;//
  float[][] myArray = new float[circPos.length][3];
  
  //but this should happen every frame
  float lerpPct = (cos(tm/2)+1)/2;
  for(int i = 0; i < triPos.length; i++)
  {
    myArray[i] = lerpFromAToB(lerpPct,triPos[i],circPos[i]);
  }
  
  pushMatrix();
  noFill();
  stroke(0,0,70);
  strokeWeight(3);
  translate(width/2,height/2);
  rotateZ(tm/8);
    
  int ringCount = 13;
  for(int k = 0; k < ringCount; k++)
  {
    pushMatrix();
    //radius gets smaller as we go on...
    float circleRadius = 400.f - 30*k;
    
    //emphasis ultimately ends up being the part of the ring where the shapes 
    float currentEmphasis = (.1*k+tm/5)%1.f;
    
    for(int i = 0; i < myArray.length; i++)
    {
      float pctThrough = i*1.f/(myArray.length-1);
      pushMatrix();
      translate(circleRadius*myArray[i][0],
                circleRadius*myArray[i][1],
                circleRadius*myArray[i][2]);
      rotateX(tm/1.1);rotateY(tm/2.3);rotateZ(tm/5.03);

      //a inefficient technique of 'wrapping' the guassian curve around discontinuity
      // at the starts and ends of the array (they are represented from t=0-1)
      float gAmt = normGaus(pctThrough,currentEmphasis,.05) + 
                   normGaus(pctThrough-1,currentEmphasis,.05) + 
                   normGaus(pctThrough+1,currentEmphasis,.05);
      float sz = 5 + 2 * gAmt;
      box(sz);
      popMatrix();
    }
    popMatrix();
  }
  popMatrix();
}

// a is height, b is 'position', c is width
float gauss(float x, float a, float b, float c)
{
  return a * exp(-(x-b)*(x-b)/(2*c*c)); 
}

//guassian distribution with area = 1
float normGaus(float x, float mu, float sigma)
{
  float c = sigma;
  float a = 1/(c*sqrt(TWO_PI));
  float b = mu;
  return gauss(x,a,b,c);
}
