TempGuage tempGuage = new TempGuage();
FMeter fMeter = new FMeter();
NumberRead number = new NumberRead();
ThermWidget[] thermWids = {tempGuage,fMeter,number};

float[] tempRange = {10,60};
float temp = 55;
public void setup()
{
  size(500,500);

  tempGuage.setPos(10,50);
  tempGuage.setWxH(300,100);
  fMeter.setPos(200,200);
  fMeter.setWxH(15,200);
  number.setPos(300,200);
  
  for(int i = 0; i < thermWids.length; i++)
  {
    thermWids[i].temperatureRange = tempRange;
  }
}

public void draw()
{
  float diff = (tempRange[1]-tempRange[0]);
  float temp = tempRange[0]  + diff *   noise(millis()/500.f);
  for(int i = 0; i < thermWids.length; i++)
  {
    thermWids[i].temperature = temp;
  }
 
  clear(); 
  for(int i = 0; i < thermWids.length; i++)
  {
    thermWids[i].draw();
  }
}
