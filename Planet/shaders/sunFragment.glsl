precision mediump float;

varying float surfaceLevel;
varying vec3 pos;
varying float t;



//Sun color. Basically red and yellow noise that moves and glows
vec3 sunF(vec3 p)
{
	float n =  snoise(0.3 * p * (sin(t * 0.02) + 2.0));
	n *= sin(t * 3.0) + 2.0;

	vec3 blue=vec3(0.55, 0.09, 0.09);
	vec3 blueN=vec3(1.0, 1.0, 0.0);
	blue += 0.05 * snoise(p * 0.1);
	vec3 yellow = vec3(1.0, 1.0, 0.0);
	//yellow-=0.2*snoise(2.0*p);

	blue=mix(blue, yellow, clamp(n, 0.0, 1.0));

	return blue;
}

void main() {
	vec3 sunColor = sunF(pos);
	
	gl_FragColor = vec4(sunColor ,1.0) ;
}