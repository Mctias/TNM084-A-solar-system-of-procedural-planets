varying float surfaceLevel;
varying vec3 worldCoord;
varying vec3 nNormal;
varying float t;

uniform float time;

void main()
{
  //Height and spread of the land
  float landH = 3.0;
  float landS = 2.0;
 
  vec3 pos=position;
  float elevation = snoise(landS*(pos*0.02))*landH;
  elevation += landH*snoise(landS*(pos*0.02))*0.5;
 
  
  //Variable used to help make the mountain limit more logical
  float rescaledElevation=elevation/landH;
    
  float spikes = 1.0;
  float mountainH =5.0; 

  //Mountain structure
  //if(rescaledElevation>0.5)
  //{
    //for(float freq=1.0;freq<256.0;freq++)
    //{
      //  elevation+=(0.09/freq)*snoise(freq*pos*spikes)*mountainH;
    //}
  //}
  if(elevation > 2.5)
  {
    elevation=-0.1;
  }
  
  //Displacement is 0 if -0.02>elevation
  float disp=max(elevation,-0.03);
  
  //Water structure (waves... kinda)
  float waves=0.0;
  if(disp<=-0.01)
  {
     waves=snoise(0.1*pos)*0.3;
     disp-=waves;
  }

  //Here we move the position along normal
  vec3 posi = pos+normal*disp;
   
  surfaceLevel=elevation/landH; //Rescaled the elevation again
  
  worldCoord=pos;
  nNormal = normal;
  t=time;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(posi, 1.0);
}