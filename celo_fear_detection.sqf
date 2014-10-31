celo_fnc_init_fear_detection = {
	0 spawn {
		_long = 0;
		while {true} do {
			waitUntil { sleep 0.1; (player getVariable "fear_detection_mode") == 1};			
			playMusic ["mad",_long];
			_ehMStopID = addMusicEventHandler ["MusicStop", {playMusic "mad"}];
			while {(player getVariable "fear_detection_mode") == 1} do {
				0.01 call celo_fnc_add_hvozd_power;	
				_long = _long + 1;
				sleep 1;
			};
			removeMusicEventHandler ["MusicStop",_ehMStopID];
			if (!(call celo_fnc_is_active_detection)) then {
				1 fadeMusic 0;
				//3 call celo_fnc_setDefaultColors;
				0 spawn {
					sleep 1.1;
					if (!(call celo_fnc_is_active_detection)) then {
						playMusic "";
					};
				};
			};
		};
	};	
	0 spawn {
		_before = 0;
		while {true} do {
			while {(player getVariable "fear_detection_mode") == 1} do {
				if (!(isNil {player getVariable "detection_target"})) then {
					_target = player getVariable "detection_target";

					_fear = _target getVariable "fear";
					_heroism = _target getVariable "heroism";				

					//conYellow('fear and heroism');
					//conWhite(str _fear);
					//conWhite(str _heroism);

					_sound = 1 - (((_heroism - _fear)/100) max 0);

					if (_sound != _before) then {
						0.1 fadeMusic _sound;
						_before = _sound;
						//conYellow("SET FEAR SOUND");
						//conWhite(str _sound);
					};
				};
				sleep 0.3333;
			};
			waitUntil { sleep 0.4; (player getVariable "fear_detection_mode") == 1};
			_before = 0;
		};
	};
};