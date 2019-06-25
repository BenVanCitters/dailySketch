class BenInput
{
  boolean clockwiseDown = false;
  boolean cclockwiseDown = false;
  boolean forwardDown = false;
  boolean fireDown = false;
  boolean fireOffToOn = false;

  int clockwiseKeyVal = 39;
  int cclockwiseKeyVal = 37;
  int forwardKeyVal = 38;
  int fireKeyVal = 32;
  void keyPressed() 
  { 
   //println(keyCode + " pressed");
    if(keyCode == clockwiseKeyVal)
    { clockwiseDown = true; }
    if(keyCode == cclockwiseKeyVal)
    {  cclockwiseDown = true; }
    if(keyCode == forwardKeyVal)
    { forwardDown = true;  }
    if(keyCode == fireKeyVal)
    { 
      fireOffToOn = (fireDown == false);
      fireDown = true; 
    }
  }
  void keyReleased() 
  {
   // println(keyCode + " released");
    if(keyCode == clockwiseKeyVal)
    { clockwiseDown = false; }
    if(keyCode == cclockwiseKeyVal)
    {  cclockwiseDown = false; }
    if(keyCode == forwardKeyVal)
    { forwardDown = false;  }
    if(keyCode == fireKeyVal)
    { fireDown = false; }
  }
  void update()
  {
    fireOffToOn = false;
  }
}
