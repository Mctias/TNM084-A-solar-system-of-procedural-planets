//precision mediump float;

varying float surfaceLevel;
varying vec3 pos;
varying vec3 norm;

uniform float time;

void main()
{
  //Height and spread of the land
  float landH = 5.0;
  float landS = 3.0;

  float elevation = snoise(landS*(position*0.02))*landH;
  
  //Variable used to help make the mountain limit more logical
  float rescaledElevation=elevation/landH;
    
  float spikes = 1.0;
  float mountainH =5.0; 

  //Mountain structure
  if(rescaledElevation>0.5)
  {
     
    for(float freq=1.0;freq<256.0;freq++)
    {
        elevation+=(0.09/freq)*snoise(freq*position*spikes)*mountainH;
    }
  }
  
  //Displacement is 0 if -0.02>elevation
  float disp=max(elevation,-0.03);
  
  //Water structure (waves... kinda)
  float waves=0.0;
  if(disp<=-0.01)
  {
     waves=snoise((position*(sin(time*0.01)-0.5)))*0.3;
     disp+=waves;
  }

  surfaceLevel=elevation/landH; //Rescaled the elevation again
  
  pos = position;
  norm = normal;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(position+normal*disp, 1.0);
}