float fbm(vec3 pos, float t)
{
	float freq = 7.0+sin(t*0.01)*10.0;
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

uniform float time;

varying vec3 pos;


void main() {
	vec4 col=vec4(1.0, 1.0, 1.0, 0.0);
	col+=fbm(pos*0.004, time);

	

	gl_FragColor = vec4(col);

	if (gl_FragColor.a < 0.1)
    {
        discard; 
    }
}
