#version 120

uniform float uPigD;
uniform float uPigH;

varying vec3 vL;
varying vec3 vN;
varying vec3 vE;

const float PigW = 3.0;
const vec3 LightPosition = vec3(15.0, 15.0, 15.0);

void main()
{
    vec4 MCvertex = gl_Vertex;
    
    float dist = abs(MCvertex.x - uPigD);
    float pulse = 0.0;
    
    if (dist < PigW) {
        pulse = 1.0 - smoothstep(0.0, PigW, dist);
        pulse = pulse * pulse;
    }
    
    float yzscale = 1.0 + pulse * uPigH;
    MCvertex.y *= yzscale;
    MCvertex.z *= yzscale;
    
    vec4 ECposition = gl_ModelViewMatrix * MCvertex;
    
    vN = normalize(gl_NormalMatrix * gl_Normal);
    vL = LightPosition - ECposition.xyz;
    vE = vec3(0.0, 0.0, 0.0) - ECposition.xyz;
    
    gl_Position = gl_ModelViewProjectionMatrix * MCvertex;
}