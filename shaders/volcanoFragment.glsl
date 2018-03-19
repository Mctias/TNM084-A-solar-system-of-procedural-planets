uniform float time;

varying float surfaceLevel;
varying vec3 pos;
varying vec3 norm;

//Color functions... yay! Makes the colors less boring (adds noise)
vec3 lavaF(vec3 p)
{
	float n =  snoise(1.0*p*(sin(time*0.02)+2.0));
	n*=sin(time*3.0)+2.0;

	vec3 red=vec3(0.55,0.09,0.09);
	red += 0.05*snoise(p*0.1);
	vec3 yellow = vec3(1.0,1.0,0.0);
	
	red=mix(red, yellow, clamp(n, 0.0, 1.0));

	return red;
}

vec3 mountainF(vec3 p)
{
	float n = 0.6 * snoise(0.3*p);
    n += 0.3 * snoise(0.6*p);

    vec3 rockColor  = 0.4*vec3(0.0, 0.0, 0.0);
    vec3 lightRock  = 0.4*vec3(0.5, 0.5, 0.5);
    vec3 rockN  = rockColor - 0.05*snoise(24.0*p);
  
    rockColor = mix(rockColor, lightRock, clamp(n, 0.0, 1.0));
    rockColor = mix(rockColor, rockN, clamp(n, 0.0, 1.0));
	
	return rockColor;
}

void main() {
	vec3 lightBlue = vec3(0.1, 0.2, 0.7);
	vec3 lavaColor = lavaF(pos);
	vec3 mountainColor = mountainF(pos);
	
	//Biome ranges
	float deepMin = -3.0;
	float deepMax = 0.2;
	float lavaMin = 0.1;
	float mountainMax = 1.0;

	
	//Interpolation length
	float id = 0.3;
	
	//Interpolation with smoothstep
	float depth = smoothstep(deepMin-id, deepMin, surfaceLevel) - smoothstep(deepMax-id, deepMax, surfaceLevel);

	float mountain = smoothstep(lavaMin-id, lavaMin, surfaceLevel) - smoothstep(mountainMax-id, mountainMax, surfaceLevel);
	
	vec3 finalColor = mountainColor;

	//Mix the colors!
    finalColor = mix(finalColor, lavaColor, depth);
	finalColor = mix(finalColor, mountainColor, mountain);

	gl_FragColor = vec4(finalColor,  1.0) ;
}