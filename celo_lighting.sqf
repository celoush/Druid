celo_fnc_lighting_effect = {
	private ["_light","_lightning","_class","_distance","_pos"];
	enableCamShake true;
	addCamShake [1, 2, 50];

	_pos = [_this, 0, [], [[]]] call BIS_fnc_param;

	_bolt = createvehicle ["LightningBolt",_pos,[],0,"can collide"];
	_bolt setposatl _pos;
	_bolt setdamage 1;

	_light = "#lightpoint" createvehiclelocal _pos;
	_light setposatl [_pos select 0,_pos select 1,(_pos select 2) + 100];
	_light setLightDayLight true;
	_light setLightBrightness 313;
	//_light setLightAmbient [0.15, 0.15, 0.2];
	_light setLightAmbient [0.05, 0.05, 0.1];
	//_light setlightcolor [0.85, 0.85, 0];
	_light setlightcolor [0.95, 0.95, 0];
	sleep 0.15;
	_light setLightBrightness 0;
	sleep (random 0.15);

	_class = ["lightning1_F","lightning2_F"] call bis_Fnc_selectrandom;
	_lightning = _class createvehiclelocal [100,100,100];
	_lightning setdir random 360;
	_lightning setpos [_pos select 0,_pos select 1,0];

	deletevehicle _lightning;
	deletevehicle _light;
	resetCamShake;
};


celo_fnc_create_lighting = {
	_pos = [druid] call celo_fnc_lighting_pos;
	[_pos] spawn celo_fnc_lighting_effect;
	_pos
};