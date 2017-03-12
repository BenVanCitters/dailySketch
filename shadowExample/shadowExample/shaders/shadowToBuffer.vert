varying vec4 shadowPos;
uniform mat4 lightVPMat;

void main()
{
    gl_Position   = lightVPMat * gl_Vertex;
}