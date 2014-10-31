celo_fnc_getRandBool = {
	private ["_ret"];
	if (random 1 > 0.7) then {
		_ret = 1;
	} else {
		_ret = 0;
	};
	_ret
};