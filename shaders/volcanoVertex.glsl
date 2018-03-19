varying float surfaceLevel;
varying vec3 pos;
varying vec3 norm;

uniform float time;

void main()
{
  //Height and spread of the land
  float landH = 3.0;
  float landS = 2.0;
 
  float elevation = snoise(landS*(position*0.02))*landH;
  elevation += landH*snoise(landS*(position*0.02))*0.5;
 
  if(elevation > 2.5)
  {
    elevation=-0.1;
  }

  float disp=max(elevation,-0.03);
  
  float waves=0.0;
  if(disp<=-0.01)
  {
     waves=snoise(0.1*position)*0.3;
     disp-=waves;
  }

  surfaceLevel=elevation/landH; //Rescaled the elevation again
  
  pos=position;
  norm = normal;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(position+normal*disp, 1.0);
}