
precision highp float;

varying vec4 shadowPos;
uniform mat4 lightVPMat;
attribute vec4 position;
uniform mat4 modelViewProjectionMatrix;

void main()
{
    shadowPos = lightVPMat * position;
    gl_Position   = modelViewProjectionMatrix * position;
}