#version 100
precision mediump float;
varying mediump vec4 colorVarying;
varying mediump vec2 texCoordv;
uniform sampler2D sampler;
void main() {
    //gl_FragColor = vec4(texCoordv, 1.0, 1.0);
    gl_FragColor = texture2D(sampler, texCoordv) * colorVarying; 
}