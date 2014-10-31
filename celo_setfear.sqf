celo_fnc_setGroupFear = {

	_group = [_this, 0, [], [[]]] call BIS_fnc_param; // [position,place,units]
	_fear_type = [_this, 1, 0, [0]] call BIS_fnc_param;
	_effect_pos = [_this, 2, [], [[]]] call BIS_fnc_param;
	_coef = [_this, 3, 1, [0]] call BIS_fnc_param;

	_add_fear = 0;

	if (_fear_type == 1) then { // lighting

		_add_fear = (100 - ((_effect_pos distance (_group select 0)) max 0)) / 10;

		_add_fear = (_coef * _add_fear) max 5;
	};

	if (_fear_type == 2) then { // trees

		_add_fear = (100 - ((_effect_pos distance (_group select 0)) max 0)) / 10;
		_add_fear = (_add_fear max 1) * _coef;

	};

	if (_fear_type == 4) then { // fireplace
		_add_fear = _coef;
	};

	//conGreen("FEAR");
	//conWhite(str _effect_pos);
	//conWhite(str (_group select 0));
	//conGreen(str _add_fear);
	_fear_arr = [];
	_group_heroism = 0;
	{
		if (alive _x) then {
			_fear = (_x getVariable "fear") + _add_fear;
			_x setVariable ["fear",_fear];
			_fear_arr set [_forEachIndex,_fear];
			if (((_x getVariable "commander")  == 1) and (_x getVariable "heroism" > _group_heroism)) then {
				_group_heroism = _x getVariable "heroism";
			};
		};
	} foreach (_group select 2); // update unit fear

	_group_heroism = _group_heroism max (30 + count (_group select 2)); // if there is no commander

	//_basic_group_fear = _fear_arr call celo_fnc_getMedian;
	_basic_group_fear = _fear_arr call celo_fnc_getMean;
	//conGreen("FEAR ARR");
	//conWhite(str _fear_arr);
	//conGreen("FEAR GROUP");
	//conWhite(str _basic_group_fear);

	_group_fear = _basic_group_fear + count (_group select 2);
	(_group select 1) setVariable ["fear",_group_fear];
	(_group select 1) setVariable ["heroism",_group_heroism];

	//conWhite(str _group_fear);
	//conPurple(str _group_heroism);

	if (_group_fear > (_group_heroism/2)) then {
		{_x setBehaviour "AWARE"} foreach (_group select 2);
		//conGreen("FEAR AWARE");
	};

	if (_group_fear > (_group_heroism*3/4)) then {
		//conGreen("FEAR COMBAT");		
		{
			_x setBehaviour "COMBAT";
			_x setUnitPos "UP";
			_x domove [((getpos _x) select 0) + random 3,((getpos _x) select 1) - random 5,0];
		} foreach (_group select 2);

	};

	if (_group_fear > _group_heroism) then {
		//conRed(" RUN ");
		hint localize "STR_CELO_group_scared";
		//conRed(str celo_druid_groups);
		_group call celo_fnc_clean_area;
		celo_druid_groups = celo_druid_groups - [_group];
		//conWhite(str _group);
		//conBlue(str celo_druid_groups);
		_pos = _group select 0;
		_new_group = objNull;
		_index = -1;
		if (count celo_druid_groups > 0) then {
			_index = call celo_fnc_get_actual_group_index;
			if (_index >= 0) then {
				_new_group = celo_druid_groups select _index;
				_pos = _new_group select 0;
			};
		};
		
		// first version
		{
			_wp = (group _x) addWaypoint [getpos home,0];
			if (alive _x) then {
				//conBlue(str _x);
				_wp setWaypointType "MOVE";
				if (
					(count celo_druid_groups > 0) and 
					((_x getVariable "heroism") > (_x getVariable "fear")) or ((_x getVariable "pride") > (_x getVariable "fear"))) 
				then {
					//conWhite("move to another group");
					_wp setWaypointSpeed "NORMAL";
					_wp setWaypointPosition [_pos,10];
					_wp setWaypointBehaviour "AWARE";
					_wp setWaypointCombatMode "GREEN";
					//conWhite(str _wp);
					[_x,_pos,_index] spawn {
						_unit = _this select 0;
						_pos = _this select 1;
						_index = _this select 2;
						_distance = 30 + random 10;
						waitUntil {(_unit distance _pos) < _distance};
						if (_index >= 0 and (count celo_druid_groups > 0)) then {
							_new_units_group = [_unit] + ((celo_druid_groups select _index) select 2);
							(celo_druid_groups select _index) set [2,_new_units_group]; //add unit to group
						};
					};

				} else {
					//conYellow("zdrha");
					_wp setWaypointSpeed "FULL";
					_wp setWaypointBehaviour "CARELESS";
					_wp setWaypointCombatMode "BLUE";
					_holder = "groundWeaponHolder" createvehicle getpos _x;
					_holder addweaponcargo [primaryWeapon _x,1];
					{  
						_holder addMagazineCargo [_x select 0,1];
					} foreach magazinesAmmo _x;
					removeAllWeapons _x;
				};
				(group _x) setCurrentWaypoint _wp;
			};			
		} foreach (_group select 2);
	};


};