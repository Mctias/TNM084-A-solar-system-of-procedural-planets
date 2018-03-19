varying vec3 pos;

void main(){
  pos = position;
  gl_Position = projectionMatrix * modelViewMatrix*vec4(pos, 1.0);
}
