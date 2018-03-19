//precision mediump float;

varying float surfaceLevel;
varying vec3 worldCoord;
varying vec3 nNormal;

uniform float time;

void main()
{
  //Height and spread of the land
  float landH = 5.0;
  float landS = 3.0;
 
  vec3 pos=position;
  float elevation = snoise(landS*(pos*0.02))*landH;
  
  //Variable used to help make the mountain limit more logical
  float rescaledElevation=elevation/landH;
    
  float spikes = 1.0;
  float mountainH =5.0; 

  //Mountain structure
  if(rescaledElevation>0.5)
  {
     
    for(float freq=1.0;freq<256.0;freq++)
    {
        elevation+=(0.09/freq)*snoise(freq*pos*spikes)*mountainH;
    }
  }
  
  //Displacement is 0 if -0.02>elevation
  float disp=max(elevation,-0.03);
  
  //Water structure (waves... kinda)
  float waves=0.0;
  if(disp<=-0.01)
  {
    // waves=snoise(5.0*pos*(sin(0.09)+1.0))*0.06;
     //waves=snoise(5.0*(pos*0.08))*0.5;
     waves=snoise((pos*(sin(time*0.01)-0.5)))*0.3;
     disp+=waves;
  }

  //Here we move the position along normal
  vec3 posi = pos+normal*disp;
   
  surfaceLevel=elevation/landH; //Rescaled the elevation again
  
  worldCoord=pos;
  nNormal = normal;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(posi, 1.0);
}