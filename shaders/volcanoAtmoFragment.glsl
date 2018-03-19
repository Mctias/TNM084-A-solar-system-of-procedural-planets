uniform float time;

varying vec3 pos;
varying vec3 norm;

void main() {
	
	vec3 col = vec3(1.0, 0.0, 0.0);

	vec3 lightPos = vec3(0.0, 0.0, 0.0);
	vec3 l = normalize(lightPos - pos);


	float diffuseLighting = max(0.0, l.x);

	gl_FragColor = vec4(col*diffuseLighting, 0.3);
}
