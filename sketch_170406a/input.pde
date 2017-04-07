void keyPressed() 
{
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      z.beginMove(3);
    } 
    else if (keyCode == DOWN) 
    {
      z.beginMove(1);
    }
    else if (keyCode == LEFT) 
    {
      z.beginMove(2);
    }
    else if (keyCode == RIGHT) 
    {
      z.beginMove(0);
    }   
         
   else 
    {
//      println("pressed key with code: " +  keyCode);
    } 
  }
  else
  {
    if (keyCode == 32) //pressed 'space' 
    {
      z.beginAttack();
    }
  }
//  println("pressed key with code: " +  keyCode);
}
