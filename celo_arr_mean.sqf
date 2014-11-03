celo_fnc_getMean = {
	_ret = 0;
	if ((count _this) > 0) then { 
		{_ret = _ret + _x} foreach _this;
		_ret = _ret / (count _this);
	};
	_ret
};