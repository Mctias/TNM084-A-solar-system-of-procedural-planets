uniform float time;

varying vec3 pos;
varying vec3 norm;

void main(){
  pos = position;
  norm = normal; 
  
  gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}
