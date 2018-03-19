varying float surfaceLevel;
varying vec3 pos;
varying float t;

uniform float time;

void main()
{
  pos=position;
  t=time;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}