//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
//void setup(){size(100,100);}void draw(){set(r(width),r(height),color(r(255),r(255),r(255)));}int r(int e){return(int)random(e);}
void setup(){size(500,500);}void draw(){loadPixels();for(int i=0;i<pixels.length;)pixels[i++]+=(int)random(pow(2,31));updatePixels();}
