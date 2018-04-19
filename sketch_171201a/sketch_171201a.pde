float a[];
float[] amt = new float[50];;
void setup()
{
  size(800,800);
  background(0);
  a = new float[]{width/2,height/2};
  for(int i = 0; i < amt.length; i++)
  {
    amt[i] = 2.5*random(-1,1);
  }
}

float nSin(float t)
{
  return (1+sin(t))/2;
}
float curRadian = 0;
void draw()
{
//  background(0);
//  fill(0,0,0,10);
//  rect(0,0,width,height);
  noStroke();
  fill(255);
  
  float tm = millis()/1000.f;
  
//  curRadian += .05*nSin(tm) + .03 * cos(2+tm*.8);
//  curRadian += ((frameCount)%100 == 0) ? 1 : 0;
//  curRadian += ((frameCount)%37 == 0) ? -.8 : 0;
//  
//  curRadian += ((frameCount)% 121 == 0) ? HALF_PI : 0;
//curRadian = modX(curRadian);

  
  curRadian = modZ(curRadian, amt,5,35);
//  curRadian = modZ(curRadian, amt,20);
  float motion[] ={cos(curRadian), sin(curRadian)};
  float spd = 4;
  motion[0]*=spd; motion[1]*=spd;
  
  a[0] += motion[0];  a[1] += motion[1];
  a[0] = (width *2+a[0]) % width;
  a[1] = (height*2+a[1]) % height;
  ellipse(a[0],a[1],3,3);  
}

float modX(float current)
{
  current += ((frameCount)%50 == 3) ? 1 : 0;
  current += ((frameCount)%50 == 16) ? 1 : 0;  
  current += ((frameCount)%50 == 36) ? -1 : 0;
  current += ((frameCount)%50 == 41) ? -1 : 0;
  return current;
}

float modY(float current)
{
  current += ((frameCount)%25 == 2) ? 1 : 0;
  current += ((frameCount)%25 == 9) ? 2 : 0;
  current += ((frameCount)%25 == 15) ? .1 : 0;  
  current += ((frameCount)%25 == 17) ? -2 : 0;
  current += ((frameCount)%25 == 23) ? -1.1 : 0;
  return current;
}

float modZ(float current, float amt[], int divs, int cycleDur)
{
  //int cycleDur = 20;
  //int divs = (cycleDur*2)/10;
  int divSpacing = cycleDur/divs;
  float cur = 0;
  int mod = (frameCount)%cycleDur;
   float sum  = 0;
   for(int i = 0; i < divs-1; i++)
  { 
    sum += amt[i];
  }
  amt[divs-1] = -sum;
  for(int i = 0; i < divs; i++)
  {
    
    current += (mod == divSpacing*i) ? amt[i] : 0;
  }
  return current;
}

