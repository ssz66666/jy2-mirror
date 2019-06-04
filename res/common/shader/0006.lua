#version 100
varying mediump vec2 texCoordv;
uniform sampler2D sampler;
void main() {
    mediump vec4 sum = vec4(0.0);
    mediump vec2 tc = texCoordv;
    sum += texture2D(sampler, vec2(tc.x - 0.006, tc.y)) * 0.1;
    sum += texture2D(sampler, vec2(tc.x - 0.004, tc.y)) * 0.15;
    sum += texture2D(sampler, vec2(tc.x - 0.002, tc.y)) * 0.15;
    sum += texture2D(sampler, vec2(tc.x, tc.y)) * 0.2;
    sum += texture2D(sampler, vec2(tc.x + 0.002, tc.y)) * 0.15;
    sum += texture2D(sampler, vec2(tc.x + 0.004, tc.y)) * 0.15;
    sum += texture2D(sampler, vec2(tc.x + 0.006, tc.y)) * 0.1;
    gl_FragColor = sum;
}