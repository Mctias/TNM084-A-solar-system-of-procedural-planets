uniform float time;

varying vec3 pos;
varying vec3 norm;

float clampDot(vec3 a, vec3 b) {
  return clamp(dot(a, b), 0.0, 1.0);
}

void main() {

	vec3 color = vec3(0.0,0.0,1.0);
	
	color *= abs(0.05 / (sin( pos.x + sin(pos.y+time*4.0)* 0.3 ) * 20.0) )*100.0;

	gl_FragColor = vec4(color, 0.8);
}
