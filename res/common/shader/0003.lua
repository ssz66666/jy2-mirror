#version 100
varying mediump vec4 colorVarying;
varying mediump vec2 texCoordv;
uniform sampler2D sampler;
void main() {
	mediump vec4 col = texture2D(sampler, texCoordv); 
	gl_FragColor = col + colorVarying; 
	gl_FragColor.a = col.a * colorVarying.a; 
}