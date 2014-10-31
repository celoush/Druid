celo_fnc_intermezzo_camera = {
	_this spawn {

		_units_arr = _this;

		_camera = "camera" camCreate [24177,17999.2,5.24423];
		_camera cameraEffect ["internal", "BACK"];		

		_camera camPrepareTarget [23684.07,109592.42,-39512.83];
		_camera camPreparePos [23684.07,17740.36,3.81];
		_camera camPrepareFOV 0.700;
		_camera camCommitPrepared 0;
		cutText["","BLACK IN",999999999];

		_soldiers = [];

		{
			_type = _x select 0;		
			_count = _x select 1;

			for "_i" from 0 to (_count-1) do {
				_group = createGroup WEST;
				_unit = _group createUnit [_type,[23684.07,17749.76,0],[],0,"FORM"];
				_unit setDir 0;
				removeAllWeapons _unit;
				_unit switchMove "AmovPercMstpSnonWnonDnon";
				_unit stop true;
				_unit disableAI "TARGET";
				_unit disableAI "AUTOTARGET";
				_unit disableAI "MOVE";
				_unit disableAI "ANIM";
				_unit disableAI "FSM";
				_soldiers = _soldiers + [_unit];
			};
		} foreach _units_arr;
		cutText["","BLACK IN",2];

		_camera camPrepareTarget [23684.07,109592.42,-39512.75];
		_camera camPreparePos [23684.07,17749.76,3.81];//[23684.07,17755.76,3.81];
		_camera camPrepareFOV 0.700;
		_camera camCommitPrepared 20;

		sleep 17;		

		cutText["","WHITE OUT",2];
		waitUntil {camCommitted _camera};

		player cameraEffect ["terminate","back"];
		camDestroy _camera;
		cutText["","WHITE IN",2];

	};	
};