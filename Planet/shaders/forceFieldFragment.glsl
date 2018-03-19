uniform float time;

varying vec3 pos;
varying vec3 norm;

float clampDot(vec3 a, vec3 b) {
  return clamp(dot(a, b), 0.0, 1.0);
}

void main() {
	
	//float ka = 0.05;
	//float kd = 1.0;
	//float ks = 1.0;
	//float shine = 1.0;

	//vec3 lightPos = vec3(100.0, 100.0, 100.0);

	//vec3 l = normalize(lightPos - pos);
	//vec3 v = normalize(cameraPosition-pos);
	//vec3 r = - reflect(l, norm);

	//vec3 aLight = vec3(0.0,0.0,0.3);
	//vec3 dLight = vec3(0.1);
	//vec3 sLight = vec3(0.0,0.0,0.3);

	//vec3 phong = ka*aLight
	//+ kd * clampDot(l, norm) * dLight
	//+ ks * pow(clampDot(r, v), shine) * sLight;

	vec3 color = vec3(0.0,0.0,1.0);
	
	color *= abs(0.05 / (sin( pos.x + sin(pos.y+time*4.0)* 0.3 ) * 20.0) )*100.0;

	gl_FragColor = vec4(color, 0.8);

}
