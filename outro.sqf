//#include "debug_console.hpp";
#include "druid_init.sqf";
#include "celo_intermezzo_camera.sqf";

cutText[localize "STR_CELO_later_text","BLACK IN",99999999];
playMusic "skynet";

druid call celo_fnc_druid_init;

_camera = "camera" camCreate [8224.21,15472.51,3.44];
_camera cameraEffect ["internal", "BACK"];	

_camera camPrepareTarget [107932.88,23100.11,80.05];
_camera camPreparePos [8229.71,15483.51,3.44];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;

0 fadeSound 0;
bodies = [];

{ 
	if ((side _x)==civilian) then { 
		bodies = bodies + [[typeOf _x,1]];
		_x setDamage 1; 
	} 
} foreach allUnits; // Life

sleep 3;
druid domove [8175.83,15482.01,1.32];
sleep 2;

_camera camPrepareTarget [107349.55,2618.56,80.05];
_camera camPreparePos [8175.83,15482.01,1.32];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 10;

cutText["","BLACK IN",3];
3 fadeSound 0.3;

setAccTime 0.4;

sleep 8.8;
cutText["","BLACK OUT",1];
7 fadeMusic 1;
sleep 1;


bodies spawn celo_fnc_intermezzo_camera;

sleep 14;

cutText[localize "STR_CELO_outro_text","WHITE OUT",3];
3 fadeMusic 0;
sleep 3;
endMission "END1";