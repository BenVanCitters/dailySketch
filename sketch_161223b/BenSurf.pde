
  PGraphics pg;
  class BenSurf
{
  float opacity = 30;
  float[] camRotVel= {  1, 1, 1 };
  float[] camRotVec= { 1, 1, 1 };

  BenLight[] lights;
  public BenSurf()
  {
    pg = createGraphics(width, height, P3D);
  }

  void draw(float dt)
  {
    pg.beginDraw();
    pg.clear();
    placeLights();
    updateCamera(dt);
    
    renderGeo();
    pg.endDraw();
  }

  void placeLights()
  {
    pg.pushMatrix();
      pg.translate(width/2, height/2, 0);
      for (int i = 0; i < this.lights.length;i++)
      {
        this.lights[i].place(pg);
      }
    pg.popMatrix();
  }

  void renderGeo()
  {
    pg.pushMatrix();
      pg.translate(width/2, height/2, 0);
      pg.fill(255);
      pg.noStroke();
      pg.sphereDetail(15, 9);
      pg.sphere(200);
    pg.popMatrix();
  }

  void updateCamera(float dt)
  {
    camRotVec[0] = (dt*camRotVel[0] + camRotVec[0]) % TWO_PI;
    camRotVec[1] = (dt*camRotVel[1] + camRotVec[1]) % TWO_PI;
    camRotVec[2] = (dt*camRotVel[2] + camRotVec[2]) % TWO_PI;
    
    float radius = 400;
    float[] pos = {width/2.0 + radius* cos(camRotVec[0]),
                   height/2.0 + radius* sin(camRotVec[1]),
                   radius* sin(camRotVec[2])};
    pg.camera(pos[0], pos[1], pos[2],  //eyeX, eyeY, eyeZ, 
           width/2.0, height/2.0, 0, //centerX, centerY, centerZ, 
           0, 1, 0);//upX, upY, upZ
    pg.pushMatrix();
//      pg.beginCamera();
////      pg.camera();

//      pg.rotateY(millis()/1000.f);
//      pg.endCamera();
    pg.popMatrix();
  }
}

