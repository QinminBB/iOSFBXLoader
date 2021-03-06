uniform mat4 projection;
uniform mat4 modelView;
attribute vec4 vPosition;

uniform mat3 normalMatrix;
uniform vec3 vLightPosition;
uniform vec4 vAmbientMaterial;
uniform vec4 vSpecularMaterial;
uniform vec4 vEmissionMaterial;

uniform float shininess;

attribute vec3 vNormal;
attribute vec4 vDiffuseMaterial;

varying vec4 vDestinationColor;

attribute vec2 TexCoordIn;
varying vec2 TexCoordOut;

void main(void)
{
    gl_Position = projection * modelView * vPosition;
    //gl_Position = vPosition* modelView * projection ;
    
    vec3 N = normalMatrix * vNormal;
    vec3 L = normalize(vLightPosition);
    vec3 E = vec3(0, 0, 1);
    vec3 H = normalize(L + E);
    
    float df = max(0.0, dot(N, L));
    float sf = max(0.0, dot(N, H));
    sf = pow(sf, shininess);
    
    vDestinationColor = vAmbientMaterial + df * vDiffuseMaterial + sf * vSpecularMaterial + vEmissionMaterial;
    
    TexCoordOut = TexCoordIn;
    
    //vDestinationColor = vec4(1.0, 0.0, 0.0, 1.0);
}