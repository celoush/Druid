celo_fnc_cut_trees = {	
	_distance = 30;
	_angle = 90-getdir druid;
	_count = 0;
	_pos = getpos druid vectorAdd [_distance * cos _angle,_distance * sin _angle,0];
	{
		if (!(_x isKindOf "Man")) then {
			if ((damage _x) < 1) then {
				_count = _count + 1;
			};
			_x setdamage 1; 
		};
	} forEach nearestObjects [_pos,[],15];
	enableCamShake true;
	addCamShake [(_count min 10), 3, 100];
	[_pos,_count]
};