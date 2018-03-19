
require([
    "../libs/text!../shaders/vertexShader.glsl",
    "../libs/text!../shaders/fragmentShader.glsl",
    "../libs/text!../shaders/simplex_noise.glsl",
    "../libs/text!../shaders/gasVertex.glsl",
    "../libs/text!../shaders/gasShader.glsl",
    "../libs/text!../shaders/cloudVertex.glsl",
    "../libs/text!../shaders/cloudFragment.glsl",
    "../libs/text!../shaders/atmoVertex.glsl",
    "../libs/text!../shaders/atmoFragment.glsl",
    "../libs/text!../shaders/volcanoVertex.glsl",
    "../libs/text!../shaders/volcanoFragment.glsl",
    "../libs/text!../shaders/sunVertex.glsl",
    "../libs/text!../shaders/sunFragment.glsl",
    "../libs/text!../shaders/forceFieldVertex.glsl",
    "../libs/text!../shaders/forceFieldFragment.glsl",
    "../libs/text!../shaders/volcanoAtmoFragment.glsl",
    "../libs/OrbitControls.js"
],

function(vertexShader, fragmentShader, noise, gasVertex, gasShader, cloudVertex, cloudFragment, atmoVertex, atmoFragment, volcanoVertex, 
		volcanoFragment, sunVertex, sunFragment, forceFieldVertex, forceFieldFragment, volcanoAtmoFragment)
{
	Init();

	function Init()
	{
		"use strict";
		
		var scene = new THREE.Scene();
		var camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000000);

		//var lightPos = THREE.Vector3(100,100,100); 

		var planetUniforms, planetAttributes, atmoUniforms;

		var renderer = new THREE.WebGLRenderer();
		renderer.setSize(window.innerWidth, window.innerHeight);
		renderer.setPixelRatio(window.devicePixelRatio);
		document.body.appendChild(renderer.domElement);
		
		//Makes the scene "follow" the resizing
		window.addEventListener('resize', function()
		{
			var w = window.innerWidth;
			var h = window.innerHeight;
			renderer.setSize(w, h);
			camera.aspect = w/h;
			camera.updateProjectionMatrix();
		});
		
		//Controls
		var controls = new THREE.OrbitControls(camera, renderer.domElement);
		
		//
		//Create the shapes
		//

		//Sun geometries
		var sunGeometry = new THREE.SphereBufferGeometry(100, 300, 300);
		
		//Regular planet geometries
		var regularPlanetGeometry = new THREE.SphereBufferGeometry(30, 300, 300);
		var atmoGeometry = new THREE.SphereBufferGeometry(35.8, 300, 300);
		var cloudGeometry = new THREE.SphereBufferGeometry(35, 300, 300);

		//Volcano planet geometries
		var volcanoPlanetGeometry = new THREE.SphereBufferGeometry(15, 300, 300);
		var volcanoAtmoGeometry = new THREE.SphereBufferGeometry(17, 300, 300);

		//Gas planet geometry
		var gasPlanetGeometry = new THREE.SphereBufferGeometry(50, 32, 32);

		//Shield planet geometry
		var shieldPlanetGeometry = new THREE.SphereBufferGeometry(20, 100, 100);
		var shieldGeometry = new THREE.SphereBufferGeometry(25, 100, 100);

		//Skybox geometry
		var skyboxGeometry = new THREE.CubeGeometry(100000, 100000, 100000);

		//
		//End of shapes
		//
	
		//Create the skybox with traditional images 
		var skyboxMaterials =
		[
			new THREE.MeshBasicMaterial({map: new THREE.TextureLoader().load('textures/front1.png'), side:THREE.DoubleSide}),
			new THREE.MeshBasicMaterial({map: new THREE.TextureLoader().load('textures/back1.png'), side:THREE.DoubleSide}),
			new THREE.MeshBasicMaterial({map: new THREE.TextureLoader().load('textures/up1.png'), side:THREE.DoubleSide}),
			new THREE.MeshBasicMaterial({map: new THREE.TextureLoader().load('textures/down1.png'), side:THREE.DoubleSide}),
			new THREE.MeshBasicMaterial({map: new THREE.TextureLoader().load('textures/right1.png'), side:THREE.DoubleSide}),
			new THREE.MeshBasicMaterial({map: new THREE.TextureLoader().load('textures/left1.png'), side:THREE.DoubleSide})
		];
	
		var skyboxMaterial = new THREE.MeshFaceMaterial(skyboxMaterials);
		var skybox = new THREE.Mesh(skyboxGeometry, skyboxMaterial);

		planetUniforms =
		{
			time:
            {
                type: "f",  //float
                value: 0.0  //initialized to 0
            }
		}

		//	
		//All the shader materials
		//

		var shaderMaterial = new THREE.ShaderMaterial( //For the original planet
        {	
        	uniforms: planetUniforms,
            vertexShader: noise + vertexShader,
            fragmentShader: noise + fragmentShader
        } );
       
        var cloudShaderMaterial = new THREE.ShaderMaterial(
        {	
        	uniforms: planetUniforms,
            vertexShader: noise + cloudVertex,
            fragmentShader: noise + cloudFragment, 
            transparent: true
        } );

        var atmoShaderMaterial = new THREE.ShaderMaterial(
        {	
        	uniforms: planetUniforms,
            vertexShader: noise + atmoVertex,
            fragmentShader: noise + atmoFragment,
            transparent: true
        } );

        var volcanoMaterial = new THREE.ShaderMaterial(
        {	
        	uniforms: planetUniforms,
            vertexShader: noise + volcanoVertex,
            fragmentShader: noise + volcanoFragment
        } );

        var volcanoAtmoMaterial = new THREE.ShaderMaterial(
        {	
        	uniforms: planetUniforms,
            vertexShader: noise + atmoVertex,
            fragmentShader: noise + volcanoAtmoFragment,
            transparent: true
        } );

        var gasShaderMaterial = new THREE.ShaderMaterial(
        {	
        	uniforms: planetUniforms,
            vertexShader: noise + gasVertex,
            fragmentShader: noise + gasShader
        } );

        var sunShaderMaterial = new THREE.ShaderMaterial(
        {	
        	uniforms: planetUniforms,
            vertexShader: noise + sunVertex,
            fragmentShader: noise + sunFragment,
        } );

        var shieldShaderMaterial = new THREE.ShaderMaterial(
        {	
        	uniforms: planetUniforms,
            vertexShader: noise + forceFieldVertex,
            fragmentShader: noise + forceFieldFragment,
            transparent: true
        } );

        //
        //End of shader material making
        //

        //
        //Create meshes, apply shaders, position the spheres and add the to the scene
        //
        var sun = new THREE.Mesh(sunGeometry, sunShaderMaterial);

        var regularPlanet = new THREE.Mesh(regularPlanetGeometry, shaderMaterial);
        var cloudMap = new THREE.Mesh(cloudGeometry, cloudShaderMaterial);
        var atmoMap = new THREE.Mesh(atmoGeometry, atmoShaderMaterial);

        var volcanoPlanet = new THREE.Mesh(volcanoPlanetGeometry, volcanoMaterial);
        var volcanoAtmoMap = new THREE.Mesh(volcanoAtmoGeometry, volcanoAtmoMaterial);

        var gasPlanet = new THREE.Mesh(gasPlanetGeometry, gasShaderMaterial);

        var sheildPlanet = new THREE.Mesh(shieldPlanetGeometry, shaderMaterial);
        var shield = new THREE.Mesh(shieldGeometry, shieldShaderMaterial);
		
		gasPlanet.position.set(1500, 0, -1500);
		
		regularPlanet.position.set(500, 0, 0);
		cloudMap.position.set(500, 0, 0);
		atmoMap.position.set(500, 0, 0);

		volcanoPlanet.position.set(300, 0, 0);
		volcanoAtmoMap.position.set(300, 0, 0);

		sheildPlanet.position.set(750, 0, -750);
		shield.position.set(750, 0, -750);

	
		scene.add(skybox);
		scene.add(sun);
		scene.add(volcanoPlanet);
		scene.add(gasPlanet);
		scene.add(regularPlanet);
		scene.add(cloudMap);
		scene.add(atmoMap);
		scene.add(volcanoAtmoMap);
		scene.add(sheildPlanet);
		scene.add(shield);
		
		//
		//End of mesh creating
		//
	
		//Add pivots so platets can spin around the center
		
		var pivotPoint1 = new THREE.Object3D();
		var pivotPoint2 = new THREE.Object3D();
		var pivotPoint3 = new THREE.Object3D();
		
		sun.add(pivotPoint1);
		sun.add(pivotPoint2);
		sun.add(pivotPoint3);
		
		pivotPoint1.add(volcanoPlanet);
		pivotPoint1.add(volcanoAtmoMap);
		pivotPoint1.add(sheildPlanet);
		pivotPoint1.add(shield);

		pivotPoint2.add(gasPlanet);
		
		pivotPoint3.add(cloudMap);
		pivotPoint3.add(atmoMap);
		pivotPoint3.add(regularPlanet);
		
		camera.position.set(150, 150, -250);
	
		var light = new THREE.PointLight(0xFFFFFF, 2, 10000);
		light.position.set(100,100,100);
		scene.add(light);
		
		//Update
		var update = function ()
		{
			//planet.rotation.x += 0.01;
			pivotPoint1.rotation.y += 0.002;
			pivotPoint2.rotation.y += 0.0003;
			pivotPoint3.rotation.y += 0.001;
	
	
			volcanoPlanet.rotation.y += 0.01;
			gasPlanet.rotation.y += 0.005;
			regularPlanet.rotation.y += 0.001;
			cloudMap.rotation.y += 0.0035;
			sheildPlanet.rotation.y += 0.02;
			shield.rotation.y += 0.02;
		};
		
		//Draw scene
		var render = function ()
		{
			renderer.render(scene, camera);	
		};
		
		//Update, render, repeat
		var GameLoop = function ()
		{
			requestAnimationFrame(GameLoop);
			update();
			render();
			planetUniforms.time.value += 0.01;
		};
		
		GameLoop();
	};	
});	

