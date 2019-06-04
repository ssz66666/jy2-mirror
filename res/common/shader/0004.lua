#version 100
varying mediump vec4 colorVarying;
varying mediump vec2 texCoordv;
uniform sampler2D sampler;
void main() { 
    mediump vec4 col = texture2D(sampler, texCoordv); 
    col.r = (col.r * 0.2126 + col.g * 0.7152 + col.b * 0.0722);  
    gl_FragColor = col.rrra; 
}