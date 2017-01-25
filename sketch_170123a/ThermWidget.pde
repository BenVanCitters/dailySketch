abstract class ThermWidget
{
  float[] pos={0,0};
  float[] wxh={100,100};
  float temperatureRange[] = {0,60};
  float temperature = 56;
  
  abstract void draw();
  final void setPos(float x, float y){pos[0]=x;pos[1]=y;}
  final void setPos(int x, int y){pos[0]=x;pos[1]=y;}
  final void setWxH(float w, float h){wxh[0]=w;wxh[1]=h;}
  final void setWxH(int w, int h){wxh[0]=w;wxh[1]=h;}
}
