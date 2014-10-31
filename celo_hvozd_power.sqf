celo_fnc_add_hvozd_power = {
	player setVariable ["hvozd_power", ((player getVariable "hvozd_power") + _this) max 0];
	//conYellow('hvozd_power');
	//conWhite(str (player getVariable "hvozd_power"));
};

celo_fnc_get_actual_hvozd_power_for_ability = {

	_index = _this select 0; // index
	_add_power = _this select 1; // power add
	_power = celo_druid_hvozd_add_powers select _index;
	_power = _power + _add_power;
	celo_druid_hvozd_add_powers set [_index,_power/5];

	_power call celo_fnc_add_hvozd_power;

};

0 spawn {
	_actual = -1;
	while {true} do {

		waitUntil {sleep 0.15;_actual!=(player getVariable "hvozd_power")};

		_actual = player getVariable "hvozd_power";

		//"colorCorrections" ppEffectAdjust [1, 1 + _actual/50, -0.004, [0.0, 0.0, 0.0, 0.0], [1, 0.8, 0.6, 0.5], [0.199, 0.587, 0.114, 0.0]]; 
		"colorCorrections" ppEffectAdjust [1, 1 - _actual/150, 0, [0.0, 0.0, 0.0, 0.0], [1,1,1,1], [0, 0, 0, 0]]; 		
		"colorCorrections" ppEffectCommit 1;
		"colorCorrections" ppEffectEnable true;

		_val = (0.5 + (_actual/50)) min 1;

		10 setOvercast _val;
		10 setRain _val;
		10 setFog _val;
		10 setGusts _val;

		sleep 1;
		
	};
};