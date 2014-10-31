celo_fnc_getMedian = {
	private ["_ret","_arr","_i"];
	_ret = false;
	_arr = _this call BIS_fnc_sortNum;	
	if (((count _arr) % 2) == 0) then { // musim udelat prumer 
		_i = count _arr / 2;
		_ret = ((_arr select (_i - 1)) + (_arr select _i)) / 2;
	} else {
		_ret = _arr select (floor ((count _arr) / 2));
	};
	_ret
};