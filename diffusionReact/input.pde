// http://www.openprocessing.org/visuals/?visualID=6268
// wrestled into VJ compatible MIDI form by Jay Silence

import themidibus.*;
 
// MIDI bus for parameter input via Akai LPD8
MidiBus myBus;

boolean debug = false;
void initLPD8()
{
   if (debug) MidiBus.list(); // List all available Midi devices on STDOUT. 
  // Create a new MidiBus with Akai input device and no output device.
  myBus = new MidiBus(this, "LPD8", -1);
}

// Handle keyboard input
void keyPressed()
{
  ////////////////////
  switch(key){
    case 'd':
      debug = !debug;
      println("Debug Output" + (debug?"enabled":"disabled"));
      break;
    case 's':
      saveFrame("sreenCaptures/img-######.png");
      break;
   case 'r':
          d.seed();
      break;
  }
}
 
// MIDI Event handling
void noteOn(int channel, int pad, int velocity) {
  // Receive a noteOn
  if(debug) {
    print("Note On - ");
    print("Channel "+channel);
    print(" - Pad "+pad);
    println(" - Value: "+velocity);
  }
  switch(pad){
    case 36:
    d.seed();
      break;   
    default:
      break;   
  }
}

 
// Right now we are doing nothing on pad release events
void noteOff(int channel, int pad, int velocity) {
    // Receive a noteOff
  if(debug) {
    print("Note Off - ");
    print(" Channel "+channel);
    print(" - Pad "+pad);
    println(" - Value "+velocity);
  }
}
float threshholdSpd = 1;
float szDelta = .5;
void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  if(debug) {
    print("Controller Change - ");
    print("Channel "+channel);
    print(" - Number "+number);
    println(" - Value "+value);
  }
   
   /*
     float k = .062;
  float d.dA = 1.0f;
  float d.dB = .5f;
  float f = .055f;
  float dT = 1.1f;*/
  switch(number){
    case 1:  // = K1
      d.dA  = (value*1.1)/128.f;
      break;
    case 2: // = K2
      d.dB = .75 * value*1.f/128;
      break;  
    case 3: // = K3
      d.dB = .075f * value*1.f/128;
      break;  
    case 4: // = K4
      break;  
    case 5: // = K5
      break;  
      case 6: // = K6
      threshholdSpd = .5f * value*2.f/128;
      break;  
      case 7: // = K6
      wCount = 16.f * value*1.f/128;
      break;  
      case 8: // = K6
      hCount = 9.f * value*1.f/128;
      break;  
//       wCount = 16.f;
//  float hCount = 9.f;
    default:
      break;   
  } 
}
