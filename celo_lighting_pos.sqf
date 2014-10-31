celo_fnc_lighting_pos = {
	_target = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

	_distance = 45 + random 10;
	_angle = random 360;
	
	_pos = getpos _target vectorAdd [_distance * cos _angle,_distance * sin _angle,0];
	_pos
};