celo_fnc_getMean = {
	_ret = 0;
	if ((count _this) == 0) exitWith { 0 };
	{_ret = _ret + _x} foreach _this;
	_ret = _ret / (count _this);
	_ret
};