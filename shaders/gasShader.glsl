uniform float time;

varying vec3 norm;
varying vec3 pos;

//Fractal Brownian Motion
float fbm(vec3 pos)
{
	float freq = 0.4;
	float amplitude = 0.5;
	float lacunarity = 3.0;
	float gain = 0.65;
	float total = 0.0;
	
	float movement = snoise(pos+vec3(1.0, 1.0, 1.0)*0.05*time);
	
	for(float i = 0.0; i < 5.0; ++i)
	{
		total += amplitude * snoise(pos * freq) * 0.5;
		freq = freq * lacunarity * movement;
		amplitude *= gain;
	}
	return total;		
}

void main() {
	vec3 col = vec3(0.36, 0.188, 0.18);
	col += fbm(pos * 0.07);

	gl_FragColor = vec4(col, 1.0);
}
