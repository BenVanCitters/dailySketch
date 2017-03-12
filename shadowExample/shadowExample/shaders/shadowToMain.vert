//#version 330 core
varying vec4 shadowPos;
uniform mat4 lightVPMat;

void main()
{
    shadowPos = lightVPMat * gl_Vertex;
    gl_Position   = gl_ModelViewProjectionMatrix * gl_Vertex;
}