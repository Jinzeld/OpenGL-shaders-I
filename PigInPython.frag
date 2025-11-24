#version 120

varying vec3 vN;
varying vec3 vL;
varying vec3 vE;

const vec3 Color = vec3(0.0, 1.0, 0.5);
const vec3 SpecularColor = vec3(1.0, 1.0, 1.0);
const float Ka = 0.1;
const float Kd = 0.6;
const float Ks = 0.3;
const float Shininess = 30.0;

void main()
{
    vec3 myColor = Color;
    
    vec3 Normal = normalize(vN);
    vec3 Light = normalize(vL);
    vec3 Eye = normalize(vE);
    
    vec3 ambient = Ka * myColor;
    
    float dd = max(dot(Normal, Light), 0.0);
    vec3 diffuse = Kd * dd * myColor;
    
    float s = 0.0;
    if (dd > 0.0) {
        vec3 ref = normalize(reflect(-Light, Normal));
        float cosphi = dot(Eye, ref);
        if (cosphi > 0.0) {
            s = pow(max(cosphi, 0.0), Shininess);
        }
    }
    vec3 specular = Ks * s * SpecularColor;
    
    gl_FragColor = vec4(ambient + diffuse + specular, 1.0);
}