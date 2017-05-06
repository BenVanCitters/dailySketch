

String thus[];// = loadStrings("thusSpake.txt");
void setup()
{
  size(500,500);
  thus = loadStrings("thusSpake.txt");
  println("arraySz: " + thus.length);
}

void draw()
{
  textSize(32);
  background(0);
  float tm = millis()/1000.f;
  float charsPerSecond = mouseX*60.f/width;
  int charCount = 10;
  String fragment = getStringForCurrentTime(tm,charsPerSecond,charCount);
//  println(fragment);

  text(fragment, 100, 100); 
}

String getStringForCurrentTime(float seconds, float charsPerSecond, int charCount)
{
  
  String result = "";
  long startChar = (int)(charsPerSecond*seconds); 
  
  long curChar = 0;
  for(int i = 0; i < thus.length; i++)
  { 
    if(startChar > (curChar + thus[i].length() ) )
    {
      curChar += thus[i].length();
    }
    else
    {
      long inStrIndex =  startChar - curChar;
      long charsToGet = (int)min(max(0,charCount-result.length()), //remaining chars for the result
                            max(0,thus[i].length()-inStrIndex)); //or max number of reamining chars that can be pulled from this line
      for(int j = 0; j < charsToGet; j++)
      {
        int index = (int)(inStrIndex+j);
        result += thus[i].charAt(index);
        startChar++;
      }
      if(result.length() >= charCount)
      {
        break;
      }
      curChar += thus[i].length();
    }
  }
  return result;
}

