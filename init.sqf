#define DIK_1 0x02
#define DIK_2 0x03
#define DIK_3 0x04
#define DIK_4 0x05
#define DIK_5 0x06
#define DIK_6 0x07
#define DIK_7 0x08
#define DIK_8 0x09
#define DIK_9 0x0A

//#include "debug_console.hpp";
#include "celo_lighting.sqf";
#include "celo_lighting_pos.sqf";
#include "celo_trees.sqf";
#include "celo_setfear.sqf";
#include "druid_init.sqf";
#include "celo_arr_median.sqf";
#include "celo_arr_mean.sqf";
#include "celo_navigation.sqf";
#include "celo_fear_detection.sqf";
#include "celo_ghost.sqf";
#include "celo_rest.sqf";
#include "celo_sooth.sqf";
#include "celo_fireplace.sqf";
#include "celo_random_bool.sqf";
#include "celo_hvozd_power.sqf";
#include "celo_intermezzo_camera.sqf";

player call celo_fnc_druid_init;

celo_fnc_setDefaultColors = {
	_time = _this;
	"colorCorrections" ppEffectEnable true;
	"colorCorrections" ppEffectAdjust [0.9, 0.9, 0, [0.45, 0.45, 0.45, 0.0], [0.45, 0.45, 0.45, 0.8], [0.45, 0.45, 0.45, 0.0]];
	"colorCorrections" ppEffectCommit _time; 
};

celo_fnc_unit_check_player = {
	private ["_unit","_contact_count"];
	_unit = _this;
	_contact_count = 0;
	
	sleep random 1;

	while {true} do {

		waitUntil {sleep 0.15;((_unit knowsAbout player >= 1.5) or (!alive _unit))};
		if (!alive _unit) exitWith {false};
		_unit setVariable ["contact",1];
		//conWhite("unit knowsAbout player!!!");
		//conWhite(str _unit);

		_contact_count = _contact_count + 1;

		_unit setVariable ["fear",(_unit getVariable "fear") + (_contact_count*5)];

		if (count celo_druid_groups > 0) then {
			_actual_group = call celo_fnc_get_actual_group;		
			{			
				if ((behaviour _x =="AWARE") or (behaviour _x =="SAFE") or (behaviour _x =="CARELESS")) then {
					_x setBehaviour "COMBAT"
				};
			} foreach (_actual_group select 2);
			if ((behaviour _unit =="AWARE") or (behaviour _unit =="SAFE") or (behaviour _unit =="CARELESS")) then {
				_unit setBehaviour "COMBAT";
			};
			if (count _actual_group > 0) then {
	 			[_actual_group,0,getPos player,0] call celo_fnc_setGroupFear;
	 		};
 		};
		waitUntil {sleep 0.15;((_unit knowsAbout player < 1.5) or (!alive _unit))};
	};
};

0 call celo_fnc_setDefaultColors;

e1_units = [e1_1,e1_2,e1_3,e1_4,e1_5];
e2_units = [e2_1,e2_2,e2_3];
e3_units = [e3_1,e3_2,e3_3];
e4_units = [e4_1,e4_2,e4_3,e4_4,e4_5,e4_6];
e5_units = [e5_1,e5_2,e5_3,e5_4,e5_5];
e6_units = [e6_1,e6_2,e6_3,e6_4];

e1_place setVariable ["fear",0];
e2_place setVariable ["fear",0];
e3_place setVariable ["fear",0];
e4_place setVariable ["fear",0];
e5_place setVariable ["fear",0];
e6_place setVariable ["fear",0];

e_units = e1_units + e2_units + e3_units + e4_units + e5_units + e6_units;

{
	_x setVariable ["contact",0];
	_x setVariable ["fear",random 10];
	_x setVariable ["heroism",20 + random 70];
	_x setVariable ["pride",30 + random 60];
	_x setVariable ["commander",call celo_fnc_getRandBool];

	_x spawn celo_fnc_unit_check_player;
	_x addEventHandler ["hit",{0.5 call celo_fnc_add_hvozd_power;}];
	_x addEventHandler ["killed",{
		(7 + random 5) call celo_fnc_add_hvozd_power;
		// deleting empty group
		{ 			
			_actual_group = _x;
			if (({alive _x} count (_actual_group select 2)) == 0) then {
				//conRed("GROUP DESTROYED");
				_actual_group call celo_fnc_clean_area;
				celo_druid_groups = celo_druid_groups - [_actual_group];
			};
		} foreach celo_druid_groups;
	}];

} foreach e_units;

e1_place setVariable ["heroism",0];
e2_place setVariable ["heroism",0];
e3_place setVariable ["heroism",0];
e4_place setVariable ["heroism",0];
e5_place setVariable ["heroism",0];
e6_place setVariable ["heroism",0];

e1_group = [getPos e1_place,e1_place,e1_units];
e2_group = [getPos e2_place,e2_place,e2_units];
e3_group = [getPos e3_place,e3_place,e3_units];
e4_group = [getPos e4_place,e4_place,e4_units];
e5_group = [getPos e5_place,e5_place,e5_units];
e6_group = [getPos e6_place,e6_place,e6_units];

player setVariable ["ghost_mode",0];
player setVariable ["navigate_mode",0];
player setVariable ["hvozd_power",0];
player setVariable ["fear_detection_mode",0];
player setVariable ["navigate_to",getpos player];
player setVariable ["detection_target",player];

celo_druid_groups = [
	e1_group,e2_group,e3_group,e4_group,e5_group,e6_group
];

// group heroism first load
{
	_group = _x;
	_group_heroism = 0;
	{
		if (((_x getVariable "commander")  == 1) and (_x getVariable "heroism" > _group_heroism)) then {
			_group_heroism = _x getVariable "heroism";
		};
	} foreach (_group select 2);
	_group_heroism = _group_heroism max (30 + count (_group select 2));

	(_group select 1) setVariable ["heroism",_group_heroism];
} foreach celo_druid_groups;

celo_fnc_clean_area = {	
	_this spawn {	
		_group_data = _this; // [position,place,units]		
		_count = 0;
		//conYellow("AREA CLEARED");
		//conWhite(str _this);
		waitUntil { // wait until all are above 100m or dead
			sleep 1;  
			_count = 0;
			_ok = true;
			{
				if (!(alive _x)) then {
					_count = _count + 1;
				};
				if (alive _x and (((getpos _x) distance (_this select 0)) < 75)) then {
					_ok = false;
				};
			} foreach (_group_data select 2);
			_ok
		};
		//conRed("AREA READY FOR SOUL CLEAN");
		hint localize "STR_CELO_soothe_ready";
		player addAction [localize "STR_CELO_sooth_action_name",{_this call celo_fnc_sooth},[_group_data,_count]];
	};
};

call celo_fnc_init_ghost;
call celo_fnc_init_navigation;
call celo_fnc_init_fear_detection;

celo_druid_hvozd_add_powers = [
	0,0,0,0
];

celo_turn_off_modes = {
	_mode_name = _this;

	//conYellow(str _mode_name);

	if ((player getVariable "ghost_mode" == 1) and (_mode_name!="ghost_mode")) then { // turn off ghost mode
		call celo_fnc_turn_ghost_mode;
	};	
	if ((player getVariable "navigate_mode" == 1) and (_mode_name!="navigate_mode")) then { // turn off navigation mode
		player setVariable ["navigate_mode",0];
	};	
	if ((player getVariable "fear_detection_mode" == 1) and (_mode_name!="fear_detection_mode")) then { // turn off fear detection mode
		player setVariable ["fear_detection_mode",0];
	};	
};

celo_fnc_lightning_effect = {
	_actual_group = call celo_fnc_get_actual_group;
	_light_pos = call celo_fnc_create_lighting;
	if (count _actual_group > 0) then {
		[_actual_group,1,_light_pos,((1-overcast) max 0.01)] call celo_fnc_setGroupFear;
	};
	[0,1 + (10*(1-overcast))] call celo_fnc_get_actual_hvozd_power_for_ability;	
	true
};

celo_fnc_demolition_effect = {
	_actual_group = call celo_fnc_get_actual_group;
	_trees_data = call celo_fnc_cut_trees; // [position, objects count]
	if (count _actual_group > 0) then {
		[_actual_group,2,(_trees_data select 0),0.3 * (_trees_data select 1)] call celo_fnc_setGroupFear;
	};
	[1,(_trees_data select 1)] call celo_fnc_get_actual_hvozd_power_for_ability;	
	true
};

celo_fnc_ghost_mode = {
	_actual_group = call celo_fnc_get_actual_group;
	"ghost_mode" call celo_turn_off_modes;
	call celo_fnc_turn_ghost_mode;	
	true
};

celo_fnc_navigation_mode = {
	_actual_group = call celo_fnc_get_actual_group;
	_new_mode = 0;
	"navigate_mode" call celo_turn_off_modes;
	if ((player getVariable "navigate_mode") == 0) then {_new_mode = 1};
	if (count _actual_group > 0) then {
		player setVariable ["navigate_to", _actual_group select 0];	
		player setVariable ["navigate_mode", _new_mode ];	
	} else {
		player setVariable ["navigate_mode", 0 ];	
	};
	true
};

celo_fnc_fear_detection_mode = {
	_actual_group = call celo_fnc_get_actual_group;
	"fear_detection_mode" call celo_turn_off_modes;
	_new_mode = 0;
	if ((player getVariable "fear_detection_mode") == 0) then {_new_mode = 1};
	if (count _actual_group > 0) then {
		player setVariable ["detection_target", _actual_group select 1];	
		player setVariable ["fear_detection_mode", _new_mode ];		
	} else {
		player setVariable ["fear_detection_mode", 0 ];		
	};
	true
};

celo_fnc_rest = {

	0 spawn celo_fnc_rest_event;
		
};

celo_fnc_is_active_detection = {
	_ret = ((player getVariable "fear_detection_mode") == 1) or ((player getVariable "navigate_mode") == 1) or ((player getVariable "ghost_mode") == 1);
	_ret	
};

celo_fnc_keydownFc = {
	_ret = false;
	if (_this select 1 == DIK_1) then { 
		// NAVIGATION MODE
		call celo_fnc_navigation_mode;
		_ret = true;
	}; 	

	if (_this select 1 == DIK_2) then { 
		// FEAR DETECTION MODE
		call celo_fnc_fear_detection_mode;
		_ret = true;
	}; 	
	if (_this select 1 == DIK_3) then { 
		// GHOST MODE
		call celo_fnc_ghost_mode;
		_ret = true;
	}; 	
	if (_this select 1 == DIK_5) then { 
		// REST MODE
		call celo_fnc_rest;
		_ret = true;
	}; 
	if (_this select 1 == DIK_7) then { 
		// LIGHTNING EFFECT
		call celo_fnc_lightning_effect;
		_ret = true;
	};
	if (_this select 1 == DIK_8) then { 
		// DEMOLITION EFFECT
		call celo_fnc_demolition_effect;
		_ret = true;
	};
	if (_this select 1 == DIK_9) then { 
		// FIREPLACE EFFECT
		call celo_fnc_turn_fireplace;
		_ret = true;
	}; 	
	_ret
};

celo_fnc_get_actual_group = {
	_actual = [];
	_i = call celo_fnc_get_actual_group_index;
	if (_i >=0 ) then {
		_actual = celo_druid_groups select _i;
	};
	_actual
};

celo_fnc_get_actual_group_index = {
	_min = 1e+021;
	_i = 0;
	_actual = -1;
	for "_i" from 0 to (count celo_druid_groups - 1) do {
		_pos = (celo_druid_groups select _i) select 0;
		_distance = _pos distance player;
		if (_distance < _min) then {
			_min = _distance;
			_actual = _i;
		};
	};
	_actual	
};

//conBlueTime("MISSION STARTED");

0 spawn {
	waituntil {!(IsNull (findDisplay 46))};
	_keydownEH = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call celo_fnc_keydownFc"];
};

player addAction [localize "STR_CELO_1_navigation_mode",{
	call celo_fnc_navigation_mode;
}];
player addAction [localize "STR_CELO_2_fear_detection_mode",{
	call celo_fnc_fear_detection_mode;
}];
player addAction [localize "STR_CELO_3_ghost_mode",{
	call celo_fnc_ghost_mode;
}];
player addAction [localize "STR_CELO_5_rest",{
	call celo_fnc_rest;
}];
player addAction [localize "STR_CELO_7_lightning",{
	call celo_fnc_lightning_effect;
}];
player addAction [localize "STR_CELO_8_destruction",{
	call celo_fnc_demolition_effect;
}];
player addAction [localize "STR_CELO_9_fireplace",{
	call celo_fnc_turn_fireplace;
}];

0 spawn {
	waitUntil {sleep 2;count celo_druid_groups == 0};
	0 fadeMusic 1;
	playMusic "LeadTrack01_F";
	setAccTime 1;
	15 fadeMusic 0;
	sleep 15;
	["end1",true] call BIS_fnc_endMission;
};

0 spawn {
	private ["_max_power"];
	_max_power = 120 + random 20;
	waitUntil {sleep 3;(player getVariable "hvozd_power") > _max_power };
	setAccTime 1;
	activateKey "klic_celo_druid";
	sleep 1;
	["epicFail",false,2] call BIS_fnc_endMission;
};

{ 
	if ((side _x)==civilian) then { 
		_x setDamage 1; 
	} 
} foreach allUnits; // Life

0 spawn {
	private ["_wait","_text"];

	diary = player createDiaryRecord ["Diary", [localize "STR_CELO_DiaryName",  localize "STR_CELO_DiaryDescription"]];

	_wait = 10;
	sleep 1;
	_text = localize "STR_CELO_hint1"; 
	hintC _text;
	sleep _wait;
	_text = localize "STR_CELO_hint2"; 
	hint _text;
	sleep _wait;
	_text = localize "STR_CELO_hint3"; 
	hint _text;
	sleep _wait;
	_text = localize "STR_CELO_hint4"; 
	hint _text;
	sleep _wait;
	_text = localize "STR_CELO_hint5"; 
	hint _text;
};

0 spawn {
	sleep 0.1;
	player call celo_fnc_druid_init;
};