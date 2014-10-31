celo_fnc_rest_event = {
	"" call celo_turn_off_modes;
	setAccTime 1;

	player switchMove "AmovPercMstpSlowWpstDnon_AmovPknlMstpSlowWpstDnon";
	//player switchMove "AmovPercMstpSnonWpstDnon_AmovPsitMstpSnonWpstDnon_ground";
	cutText["","BLACK OUT",2];				
	sleep 3;
	player setCaptive true;
	// power down, units fear down, units heroism up
	(-10 - (random 5)) call celo_fnc_add_hvozd_power;
	{
		_group = _x;
		{
			if (alive _x) then {
				_fear = ((_x getVariable "fear") - ((_x getVariable "heroism")/5)) max 0;
				_x setVariable ["fear",_fear];
				if ((_x getVariable "contact") == 1) then {
					_heroism = (_x getVariable "heroism")*(1+random 0.1);
					_x setVariable ["heroism",_heroism];
				};
			};
		} foreach (_group select 2);

	} foreach celo_druid_groups;

	sleep 1;
	skiptime 1;
	cutText["","BLACK IN",2];

	player switchMove "AmovPsitMstpSrasWrflDnon_AmovPercMstpSlowWrflDnon";
	player setCaptive false;	
};