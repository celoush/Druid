celo_fnc_init_navigation = {
	0 spawn {
		_long = 0;
		while {true} do {
			waitUntil { sleep 0.1; (player getVariable "navigate_mode") == 1};
			playMusic ["defcon",_long];
			_ehMStopID = addMusicEventHandler ["MusicStop", {playMusic "defcon"}];
			while {(player getVariable "navigate_mode") == 1} do {
				0.01 call celo_fnc_add_hvozd_power;	
				_long = _long + 1;
				sleep 1;
			};
			removeMusicEventHandler ["MusicStop",_ehMStopID];
			//3 call celo_fnc_setDefaultColors;
			if (!(call celo_fnc_is_active_detection)) then {
				1 fadeMusic 0;
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
			while {(player getVariable "navigate_mode") == 1} do {
				_target_pos = player getVariable "navigate_to";
				_player_pos = getpos player;
				_x = _target_pos select 0;
				_y = _target_pos select 1;

				_a = _player_pos select 0;
				_b = _player_pos select 1;
				
				_angle = (_x-_a) atan2 (_y-_b);

				if (_angle<0) then {_angle = _angle + 360}; 

				_player_dir = getDir player;

				_diff_angle = _angle - _player_dir;
				if (_diff_angle>180) then {_diff_angle = _diff_angle - 360;};
				if (_diff_angle<-180) then {_diff_angle = _diff_angle + 360;};
				_diff_angle = abs _diff_angle;

				_distance = _target_pos distance player;
				_distance_coef = 1.2 - (_distance/2000);

				_sound = _distance_coef * (1-(_diff_angle/180));

				_sound = _sound max 0.1;				

				/*"colorCorrections" ppEffectAdjust [1, 0 + 1.3*_sound, -0.004, [0.0, 0.0, 0.0, 0.0], [1, 0.8, 0.6, 0.5], [0.199, 0.587, 0.114, 0.0]]; 
				"colorCorrections" ppEffectCommit 0;
				"colorCorrections" ppEffectEnable true;*/

				if (_sound != _before) then {
					0.1 fadeMusic _sound;
					_before = _sound;
				};
			};
			waitUntil { sleep 0.4; (player getVariable "navigate_mode") == 1};
		};
	};
};