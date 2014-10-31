//#include "debug_console.hpp";
#include "druid_init.sqf";
druid call celo_fnc_druid_init;

cutText["","BLACK IN",99999999];
0 fadeMusic 0;
0 fadeSound 0;

_camera = "camera" camCreate [8224.21,15472.51,3.44];
_camera cameraEffect ["internal", "BACK"];	

_camera camPrepareTarget [-79405.56,-31284.88,69.95];
_camera camPreparePos [8982.58,15470.18,0.89];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;

_camera camPrepareTarget [-79405.56,-31284.88,70.71];
_camera camPreparePos [8954.77,15455.66,0.90];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 60;

0 spawn {
	sleep 6;
	cutText["","BLACK IN",4];
	playMusic ["skynet",0];
	0 fadeMusic 0.5;
	5 fadeSound 0.2;
};

0 spawn {
	// psane titulky
	sleep 3;
	titleText [localize "STR_CELO_intro_text_1","PLAIN",3];	
	sleep 6;
	titleText [localize "STR_CELO_intro_text_2","PLAIN",3];	
	sleep 6;
	titleText [localize "STR_CELO_intro_text_3","PLAIN",3];	
	sleep 7;
	titleText [localize "STR_CELO_intro_text_4","PLAIN",3];	
	sleep 3;
	titleText [localize "STR_CELO_intro_text_5","PLAIN",3];	
	sleep 7;
	titleText [localize "STR_CELO_intro_text_6","PLAIN",3];	
	sleep 8;
	titleText ["","PLAIN",3];	
};

sleep 38;
cutText["","BLACK OUT",2];
sleep 2;
cutText["","BLACK IN",2];

// music and mission name
0 spawn {	
	sleep 5;
	5 fadeMusic 1;
	titleRsc ["titlesceloush", "PLAIN",3];
	sleep 6;
	titleRsc ["titlesuvadi", "PLAIN",3];
	sleep 6;
	titleRsc ["titlesorb", "PLAIN",3];
};

_camera camPrepareTarget [68625.73,-61452.62,-22707.51];
_camera camPreparePos [8951.04,15400.19,2.94];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;

_camera camPrepareTarget [68625.73,-61452.62,-22707.11];
_camera camPreparePos [8879.52,15492.30,15.76];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 29;

sleep 26;

cutText["","BLACK OUT",2];
sleep 2.5;

_camera camPrepareTarget [-68985.00,-39852.22,29683.56];
_camera camPreparePos [8877.35,15473.28,0.44];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 0;
cutText["","BLACK IN",2];

_camera camPrepareTarget [61485.21,-68655.88,12515.17];
_camera camPreparePos [8877.35,15473.28,0.44];
_camera camPrepareFOV 0.700;
_camera camCommitPrepared 12;
11 fadeMusic 0;
;sleep 9;

cutText["","BLACK OUT",2];
sleep 2.8;
endMission "END1";