celo_fnc_init_ghost = {

	celo_druid_ghost_camera = "camera" camCreate getPos player;
	celo_druid_ghost_camera camSetTarget player; 
	celo_druid_ghost_camera camSetFov 0.25;
	celo_druid_ghost_camera cameraEffect ["INTERNAL", "BACK", "rendertarget0"];
	celo_druid_ghost_camera attachTo [player, [0,0,15]];
	celo_druid_ghost_camera camCommit 0;

	0 spawn {
		sleep 0.1;
		player setObjectTextureGlobal [0, "textures\druid.jpg"];
		while {true} do {
			if (player getVariable "ghost_mode" == 1) then {
				0.02 call celo_fnc_add_hvozd_power;			
			};
			sleep 1;
		};
	};
};

celo_fnc_turn_ghost_mode = {
	//conYellow("Ghost");

	if (player getVariable "ghost_mode" == 0) then {		

		celo_druid_ghost_camera = "camera" camCreate getPos player;
		celo_druid_ghost_camera camSetTarget player; 
		celo_druid_ghost_camera camSetFov 0.25;
		celo_druid_ghost_camera cameraEffect ["INTERNAL", "BACK", "rendertarget0"];
		celo_druid_ghost_camera attachTo [player, [0,0,15]];
		celo_druid_ghost_camera camCommit 0;

		player setVariable ["ghost_mode",1];
		playMusic ["fallout",0];
		2 fadeMusic 1;

		player setObjectTextureGlobal [0, "#(argb,512,512,1)r2t(rendertarget0,1.0)"];
		//player allowDamage false;
		player addEventHandler["HandleDamage",{
			//conWhite("Hit");
			player setDamage ((getDammage player) - (_this select 2));
			5*(_this select 2) call celo_fnc_add_hvozd_power;
		}];
	} else {
		player setVariable ["ghost_mode",0];
		player setObjectTextureGlobal [0, "textures\druid.jpg"];
		if (!(call celo_fnc_is_active_detection)) then {
			playMusic "";
		};
		//player allowDamage true;
		player removeAllEventHandlers "HandleDamage";
		//camDestroy celo_druid_ghost_camera;
	}
};