
float rotation = 0;
float[] motionSince = {0,0};
int curIndex = 0;
String abc = "    I wandered lonely as a cloud That floats on high o'er vales and hills, When all at once I saw a crowd, A host, of golden daffodils; Beside the lake, beneath the trees, Fluttering and dancing in the breeze. Continuous as the stars that shine And twinkle on the milky way, They stretched in never-ending line Along the margin of a bay: Ten thousand saw I at a glance, Tossing their heads in sprightly dance. The waves beside them danced; but they Out-did the sparkling waves in glee: A poet could not but be gay, In such a jocund company: I gazed—and gazed—but little thought What wealth the show to me had brought: For oft, when on my couch I lie In vacant or in pensive mood, They flash upon that inward eye Which is the bliss of solitude; And then my heart with pleasure fills, And dances with the daffodils.    ";

void setup()
{
  size(700,700,P2D);
  textSize(60);
  background(0,0,170);

  noiseDetail(4,.3);
}


void draw()
{
  background(0,0,170);
  pushMatrix();
    //translate(width/2,height/2);
    rotation = 4*TWO_PI*(noise(millis()/5200.f));
  
    //translate(-width/2,-height/2);
    float d = -5;
    float[] motion = {d*cos(rotation),d*sin(rotation)};
    motionSince[0]+=motion[0];
    motionSince[1]+=motion[1];
    translate(motion[0],motion[1]);
    image(g,0,0,width,height);
  popMatrix();

pushMatrix();
  fill(255,255,0,255);
  stroke(255,255,0,255);
  translate(width/2,height/2);
  

  rotate(rotation);
//  rotate(TWO_PI*noise(millis()/777.f));
  
  float motionLength = dist(0,0,motionSince[0],motionSince[1]);
  float maxMotionL = 40;
  if(motionLength>maxMotionL)
  {
    String out = ""+abc.charAt((int)(curIndex));
    text(out,0,0);
    motionSince[0]=0;motionSince[1]=0;
    curIndex = (curIndex+1)%abc.length();
  }
  popMatrix();
  
}

void mouseClicked()
{
 background(0,0,170);
 curIndex=0;
}
