#version 100
attribute highp vec3 position;
attribute highp vec2 texCoords;
varying mediump vec2 texCoordv;
void main() { 
    gl_Position = vec4(position,1); 
    texCoordv = texCoords;
}