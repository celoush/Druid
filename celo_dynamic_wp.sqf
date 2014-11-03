celo_fnc_dynamic_position = {
	_target = _this select 0;
	_distance = _this select 1;
	_random = _this select 2;

	_distance = _distance + random _random;
	_angle = random 360;
	
	_pos = getpos _target vectorAdd [_distance * cos _angle,_distance * sin _angle,0];
	_pos
};

celo_fnc_dynamic_waypoints = {
	_unit = _this;
	
	_grp = group _unit;		

	_pos = [_unit,10,1] call celo_fnc_dynamic_position;

	_wp = _grp addWaypoint [_pos,0];
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointTimeout [2,4,6];
	_grp setCurrentWaypoint _wp;

	_wp = _grp addWaypoint [position _unit,5];
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointTimeout [1,2,3];

	_wp = _grp addWaypoint [position _unit,15];
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointTimeout [2,3,5];

	_wp = _grp addWaypoint [_pos,0];
	_wp setWaypointType "CYCLE";
};