#version 100
attribute highp vec3 position;
attribute highp vec4 color;
attribute highp vec2 texCoords;
varying mediump vec4 colorVarying;
varying mediump vec2 texCoordv;
uniform highp mat4 proj;
uniform highp mat4 view;
void main() {
	gl_Position = proj * view * vec4(position,1); 
	colorVarying = color; texCoordv = texCoords;
}