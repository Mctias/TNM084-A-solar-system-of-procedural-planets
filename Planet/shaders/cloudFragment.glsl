uniform float time;

varying vec3 pos;

float fbm(vec3 pos)
{
	float freq = 7.0+sin(time*0.01)*10.0;
	float amplitude = 1.0;
	float octaves = 10.0;
	float lacunarity = 3.0;
	float gain = 0.65;
	float total = 0.0;
	
	
	for(float i = 0.0; i<6.0; ++i)
	{
		total+=amplitude*snoise(pos*freq);
		freq=freq*lacunarity;
		amplitude*=gain;
	}
	return total;		
}

void main() {
	vec4 col=vec4(1.0, 1.0, 1.0, 0.0);
	col+=fbm(pos*0.004);

	gl_FragColor = vec4(col);
}
