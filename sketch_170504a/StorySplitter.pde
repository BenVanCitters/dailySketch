class StorySplitter
{
  
    int textDivisions = 124;
  double textTime[] = new double[textDivisions];
  long lastTime = 0;
  String thus[];// = loadStrings("thusSpake.txt");
  int textCharLength = -1;
  String allText ="";
  float[] speeds=new float[textDivisions];
  StorySplitter()
  {
    for(int i = 0; i < textDivisions; i++)
    {
      speeds[i] = 5+random(15);
    }
    loadAndFlattenString("thusSpake.txt");
    
    //load up and use 'courier' font - monospaced
    textFont(createFont("Courier", 16));//200));
    println("arraySz: " + thus.length);
    textCharLength = getTextCharLength();
    println("length: " + textCharLength); 
  }

  void loadAndFlattenString(String fileName)
  {
    thus = loadStrings(fileName);
    for(int i = 0; i < thus.length; i++)
    {
      allText += thus[i];
    }
  }

  void draw()
  {
    //1612 total caharacters can be shown on screen - equals by 4*403 and 13*124
    double dt = (millis() - lastTime)/1000.f;
    lastTime = millis();
    background(0);
    float spd =  mouseY*60.f/height;
    
    int charCount = 52;//(int)(100* mouseX*1.f/width);
    String result = "";
    
    int screenCharsPerFrag = 13; 
    int fragLen = textCharLength/textDivisions;
    for(int i = 0; i < textDivisions; i++)
    {
      textTime[i] += dt*speeds[i];
      int offset = fragLen*i;
      String frag = getStringForCurrentTime((int)(textTime[i]),charCount);
      frag = getFragment(offset, 
                         fragLen*(i+1),
                         (int)(textTime[i]+offset), 
                         screenCharsPerFrag);
      result+=frag;
    }
    
    for(int i = 0; i < 31; i++)
    {
      String s = result.substring(charCount*i, charCount*(i+1));
      text(s, 0, 16+i*16);
    }
    //text(result, 0, 16);
    
    //String fragment = getStringForCurrentTime((int)(textTime),charCount);
    ////println(fragment + " ~~ charCount: " + charCount + " ~~" + textTime);
    //int count = 31;//mouseX*40/width;
    //for(int i = 0; i < count; i++)
    //{
    //  text(fragment, 0, 16+i*16);
    //}
  }

  int modWrap(int index, int start, int end)
  {
    int len = end-start;
    int offs = index-start;
    return (offs%len)+start;
  }

  String getFragment(int startIndex,int endIndex,int offset, int charCount)
  {
    //wrap the offset between the start and end
    int len = endIndex-startIndex;
    int offs = offset-startIndex;
    offset = (offs%len)+startIndex;
    
    String result = "";
    //long startChar = (int)(charsPerSecond*seconds); 
    
    int finalIndex = offset+charCount; 
    for(int i = offset; i < finalIndex; i++)
    { 
      int index = modWrap(i,startIndex,endIndex);
      result += allText.charAt(index);
    }
    return result;
  }


  String getStringForCurrentTime(long startChar, int charCount)
  {
    
    String result = "";
    //long startChar = (int)(charsPerSecond*seconds); 
    
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

  int getTextCharLength()
  {
    int result = 0;
    for(int i = 0; i < thus.length; i++)
    {
      result += thus[i].length();
    }
    return result;
  }
}