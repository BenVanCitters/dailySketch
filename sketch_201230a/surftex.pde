class SurfTex
{
 private PGraphics m_g;
 
 PImage img = loadImage("C:/Users/vanci/Desktop/2020-12-30 18_24_30-.png");
 public PGraphics g()
 {
  return m_g; 
 }
 
 public SurfTex()
 {
   m_g = createGraphics(900,900);
   //PImage img = loadImage("C:/Users/vanci/Desktop/2020-12-30 18_24_30-.png");
 }
 void renderTex()
 {
   //noiseDetail(1);
   float t = millis()/1000.f;
   m_g.beginDraw();
   //m_g.loadPixels();
   //for(int i = 0; i < m_g.pixels.length; i++)
   //{
   //  float x = (int)(i%m_g.width); 
   //  float y = (int)(i/m_g.width);
   //  x /= 220.f;
   //  y /= 220.f;
   //  m_g.pixels[i] = color(255*noise(x,y,t));
   //}
   m_g.image(img,0,0);
   //m_g.image(img,0,0,m_g.width,m_g.height);
   m_g.updatePixels();
   m_g.endDraw();
 }
}
