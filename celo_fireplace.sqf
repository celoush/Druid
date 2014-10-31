celo_fnc_turn_fireplace = {
	//conYellow("Fireplace");

 	_actual_group = call celo_fnc_get_actual_group;
	_fireplaces = nearestObjects [player, ["FirePlace_burning_F","Land_FirePlace_F"], 100];

	[2,1] call celo_fnc_get_actual_hvozd_power_for_ability;
	if (count _fireplaces == 0) exitWith { titleText [localize "STR_CELO_fireplace_not_Found","PLAIN DOWN"]; false};
	_fireplace = _fireplaces select 0;
	//conWhite(str _fireplace);
	[3,10] call celo_fnc_get_actual_hvozd_power_for_ability;	
	addCamShake [0.5, 0.5, 50];
	if (inflamed  _fireplace) then {
		_fireplace inflame false;
		titleText [localize "STR_CELO_fireplace_off","PLAIN DOWN"];
		[_actual_group,4,getpos _fireplace,2 + random 1] call celo_fnc_setGroupFear;
	} else {
		_fireplace inflame true;
		titleText [localize "STR_CELO_fireplace_on","PLAIN DOWN"];
		[_actual_group,4,getpos _fireplace,10 + random 5] call celo_fnc_setGroupFear;
	};
	resetCamShake;
};