import processing.video.*;

Movie video;
int xRes= 150;
int yRes= 150;
ScanPoint[] scanPoints;
void setup() {
  size(700,700,P3D);
  
  initVideo();
  initShape();
}

void initShape()
{
  scanPoints = new ScanPoint[xRes*yRes];
  float[] xyScrSpc={width*1.f/xRes,height*1.f/yRes};
  
   if(video.pixels == null)
     return;

  textureMode(NORMAL);
  noFill();
  int pointIndex = 0;
  for(int i = 0; i < yRes; i++)
  {
    float yPct = .1+.8*i*1.f/yRes;
    for(int j = 0; j < xRes; j++)
    {
      float xPct = .1+.8*j*1.f/xRes;
      float[] nPos = {xPct,yPct};
      ScanPoint tmp = new ScanPoint(nPos);
      scanPoints[pointIndex++] = tmp;
    }
    i++;
    yPct = .1+.8*i*1.f/yRes;
    for(int j = xRes-1; j >=0; j--)
    {
      float xPct = .1+.8*j*1.f/xRes;
      float[] nPos = {xPct,yPct};
      ScanPoint tmp = new ScanPoint(nPos);
      scanPoints[pointIndex++] = tmp;
    }
  }
  endShape();  
}

void initVideo()
{
  video = new Movie(this, "/Users/admin/Documents/Processing/dailySketch/sketch_170127a/sloppy.mov");
  video.loop();
  video.volume(0);
}

void movieEvent(Movie movie) {
  video.read();  
  video.loadPixels();
}

void draw() {    
  background(0);
  strokeWeight(3);
  
  float[] xyScrSpc={width*1.f/xRes,height*1.f/yRes};
  
   if(video.pixels == null)
     return;

  textureMode(NORMAL);
  noFill();
  beginShape();
  float tm = millis()/5000.f;
//  texture(video);
//float zScale = mouseY*1.f/height;
//scale(1,1,zScale);
float[] mousePos = {mouseX,mouseY,0};
float powerSin = 1;//sin(tm*5);
  for(int i = 0; i < scanPoints.length; i++)
  {
    float[] mForce = {-mousePos[0]+scanPoints[i].targPos[0],
                      -mousePos[1]+scanPoints[i].targPos[1],
                      -mousePos[2]+scanPoints[i].targPos[2]};
                      
    float mDist = dist(0,0,0,mForce[0],mForce[1],mForce[2]);
    float fNorm[]={mForce[0]/mDist,mForce[1]/mDist,mForce[2]/mDist};
    fNorm = new float[]{fNorm[1],fNorm[0],0};
    float sinD = sin(mDist/20)*350/(mDist*.5);
    mDist/=10;
    mDist += random(-.1,.1);
    mForce[0] /= mDist; mForce[1] /= mDist; mForce[2] /= mDist;
    mForce[0] *= 9*powerSin; 
    mForce[1] *= 9*powerSin; 
    mForce[2] *= 9*powerSin;
    fNorm[0] *=sinD;
    fNorm[1] *=sinD;
    fNorm[2] *=sinD;
    mForce[0] +=fNorm[0]; 
    mForce[1] += fNorm[1]; 
    mForce[2] +=fNorm[2];
    scanPoints[i].vel[0] += mForce[0]; 
    scanPoints[i].vel[1] += mForce[1];
    scanPoints[i].vel[2] += mForce[2];
    scanPoints[i].update(0);
    
    stroke(colorFromMov(scanPoints[i]));
    vertex(scanPoints[i].pos[0],
    scanPoints[i].pos[1],
    scanPoints[i].pos[2]);
  }
//  for(int i = 0; i < yRes; i++)
//  {
//    for(int j = 0; j < xRes; j++)
//    {
//      float pos[] = {xyScrSpc[0]*j,xyScrSpc[1]*i,350*noise(i/30.f,j/30.f,tm)};
//      float[] nPos = {pos[0]/width,pos[1]/height};
//      stroke(colorFromMov(nPos));
//      vertex(pos[0],pos[1],pos[2]);//,pos[0]/width,pos[1]/height);
//    }
//    i++;
//    for(int j = xRes-1; j >=0; j--)
//    {
//      float pos[] = {xyScrSpc[0]*j,xyScrSpc[1]*i,350*noise(i/30.f,j/30.f,tm)};
//      float nPos[] = {pos[0]/width,pos[1]/height};
//      stroke(colorFromMov(nPos));
//      vertex(pos[0],pos[1],pos[2]);//,pos[0]/width,pos[1]/height);
//    }
//  }
  endShape();  
  
}  

int colorFromMov(float[] norm)
{
  int[] xy = {(int)(norm[0]*1280),(int)(norm[1]*=720)};
  int index = xy[1]*1280+xy[0];
  if(video.pixels == null)// || index < 0 || index >video.pixels.length)
    return 0;
  return video.pixels[index];
}

int colorFromMov(ScanPoint sp)
{
  if(video.pixels == null)
    return 0;
  return video.pixels[sp.videoPixelIndex];
}

