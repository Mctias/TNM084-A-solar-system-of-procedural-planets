precision mediump float;

varying float surfaceLevel;
varying vec3 worldCoord;
varying vec3 nNormal;


//Color functions... yay! Makes the colors less boring (adds noise)
vec3 snowF(vec3 p)
{
	
	vec3 snow = vec3(0.9,0.9,0.9);
	snow -= 0.05 * snoise(16.0 * p);

	return snow;
}

vec3 oceanF(vec3 p)
{
	float n =  snoise(0.005*p);

	vec3 blue=vec3(0.1,0.2,0.4);
	vec3 blueN=vec3(0.0,0.0,0.6);
	blueN -= 0.05*snoise(p*0.1);

	blue=mix(blueN, blue, clamp(n, 0.0, 1.0));
	

	return blue;
}

vec3 mountainF(vec3 p)
{
	float n = 0.6 * snoise(0.3*p);
    n += 0.3 * snoise(0.6*p);

    vec3 rockColor  = 0.4*vec3(0.2, 0.2, 0.2);
    vec3 lightRock  = 0.4*vec3(0.5, 0.5, 0.5);
    vec3 rockN  = rockColor - 0.05*snoise(24.0*p);
  
    rockColor = mix(rockColor, lightRock, clamp(n, 0.0, 1.0));
    rockColor = mix(rockColor, rockN, clamp(n, 0.0, 1.0));
	
	return rockColor;
}

vec3 forestF(vec3 p)
{
	
	float n = 0.6 * snoise(0.3*p);
    n += 0.3 * snoise(0.6*p);

    vec3 forest  = 0.4*vec3(0.1, 0.3, 0.1);
    //vec3 lightForsest  = 0.4*vec3(0.1, 0.5, 0.1);
    forest  = forest - 0.05*snoise(24.0*p);

  
    //forest = mix(forest, lightForsest, clamp(n, 0.0, 1.0));
    //forest = mix(forest, forestN, clamp(n, 0.0, 1.0));
	
	return forest;
}

vec3 sandF(vec3 p)
{
	float n =  snoise(0.05*p);
	vec3 sand = vec3(0.4,0.4,0.0);
	vec3 sandN = sand*0.6;
	//sandN -= 0.1*snoise(16.0*p);
	
	sand = mix(sandN, sand, clamp(n, 0.0, 1.0));
	
	return sand;
}

void main() {
	vec3 lightBlue = vec3(0.1, 0.2, 0.7);
	vec3 sandColor = sandF(worldCoord);
	vec3 oceanColor = oceanF(worldCoord);
	vec3 mountainColor = mountainF(worldCoord);
	vec3 snowColor = snowF(worldCoord);
	vec3 forestColor = forestF(worldCoord);
	vec3 baseColor = mountainColor;
	
	//Biome ranges
	float deepMin = -3.0;
	float deepMax = 0.2;
	float sandMin = 0.1;
	float sandMax = 0.3;
	float forestMin = 0.3;
	float forestMax = 0.6;
	float mountainMin = 0.6;	
	float mountainMax = 0.9;
	float snowMin = 0.9;
	float snowMax = 2.0;
	
	//Interpolation length
	float id = 0.3;
	
	//Interpolation with smoothstep
	float depth = smoothstep(deepMin-id, deepMin, surfaceLevel) - smoothstep(deepMax-id, deepMax, surfaceLevel);
	float beach = smoothstep(sandMin-id, sandMin, surfaceLevel) - smoothstep(sandMax-id, sandMax, surfaceLevel);
	float forest = smoothstep(forestMin-id, forestMin, surfaceLevel) - smoothstep(forestMax-id, forestMax, surfaceLevel);
	float mountain = smoothstep(mountainMin-id, mountainMin, surfaceLevel) - smoothstep(mountainMax-id, mountainMax, surfaceLevel);
	float snow = smoothstep(snowMin-id, snowMin, surfaceLevel) - smoothstep(snowMax-id, snowMax, surfaceLevel);
	
	vec3 finalColor = mountainColor;

	//Mix the colors!
    finalColor = mix(finalColor, oceanColor, depth);
	finalColor = mix(finalColor, sandColor, beach);
	finalColor = mix(finalColor, forestColor, forest);	
	finalColor = mix(finalColor, mountainColor, mountain);
	finalColor = mix(finalColor, snowColor, snow);
	
	//Create diffuse lightning using the interpolated normal (I didn't write this)
	vec3 normal = normalize(nNormal);
	float diffuselighting = max(0.0, normal.z);
	
	gl_FragColor = vec4(finalColor ,1.0) ;
}