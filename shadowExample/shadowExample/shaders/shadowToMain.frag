
precision highp float;

uniform sampler2D lightMap;
varying vec4 shadowPos;

//out vec4 fragColor;
void main()
{
//    if(texture2D(lightMap, shadowPos.st).a < shadowPos.z)
//    {
//      gl_FragColor = vec4(1.0,1.0,1.0,1.0);
//    }
//    else
//    {
//      gl_FragColor = vec4(0.0,0.0,0.0,1.0);
//    }
    
    vec4 shadowColor = texture2D(lightMap, shadowPos.st);
    float val = shadowColor.z;
//    fragColor = vec4(val,val,val,1.0);
    gl_FragColor = vec4(0.0,1.0,0.0,1.0);
}