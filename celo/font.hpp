
// ---------------- Definice typů objektů ----------
// --- Není nutné - Lze použít přímo čísla typu  ---
#define CT_STATIC		0
#define ST_CENTER		2
#define ST_MULTI		16
#define ST_SHADOW		256
#define ST_NO_RECT	512

// ------------ Základní třídy ----------------


class RscText
{
	type=0;
	idc=4294967295;
	style=0;
	h=0.040000;
	colorBackground[]={0,0,0,0};
	colorText[]={0.780000,0.080000,0.520000,0.750000};
	font="PuristaBold";
	sizeEx=0.020000;
};


// ----------------- Třídy titulků -------------------
class RscTitles 
{ 
	titles[] = 
	{

		titlesorb,
		titlesceloush,
		titlesuvadi,
		titleskonec,
	};

	class titlesorb
	{
		name = "";
		duration = 6;
		idd = -1;
		movingEnable = false;
		
		controls[]= {text};

		class text: RscText
		{
			style = ST_MULTI + ST_CENTER + ST_NO_RECT;
			lineSpacing = 1.0;
			text = $STR_CELO_title3;
			x = 0.01; y = 0.4; w = 0.99; h = 0.5;
			colorText[] = {0, 0.5, 0, 1};
			font = "PuristaBold";
			sizeEx = 0.15;
			size = 0.3;
		};

	};

	class titleskonec
	{
		name = "";
		duration = 6;
		idd = -1;
		movingEnable = false;
		
		controls[]= {text};

		class text: RscText
		{
			style = ST_MULTI + ST_CENTER + ST_NO_RECT;
			lineSpacing = 1.0;
			text = $STR_CELO_title4;
			x = 0.1; y = 0.4; w = 0.9; h = 0.5;
			colorText[] = {0, 0.5, 0, 1};
			font = "PuristaBold";
			sizeEx = 0.15;
			size = 0.3;
		};

	};

	class titlesceloush
	{
		name = "";
		duration = 6;
		idd = -1;
		movingEnable = false;
		
		controls[]= {text};

		class text: RscText
		{
			style = ST_MULTI + ST_CENTER + ST_NO_RECT;
			lineSpacing = 1.0;
			text = $STR_CELO_title1;
			x = 0.17; y = 0.4; w = 0.66; h = 0.2;
			colorText[] = {0, 0.5, 0, 1};
			font = "PuristaBold";
			sizeEx = 0.15;
			size = 0.3;
		};

	};

	class titlesuvadi
	{
		name = "";
		duration = 6;
		idd = -1;
		movingEnable = false;
		
		controls[]= {text};

		class text: RscText
		{
			style = ST_MULTI + ST_CENTER + ST_NO_RECT;
			lineSpacing = 1.0;
			text = $STR_CELO_title2;
			x = 0.17; y = 0.4; w = 0.66; h = 0.2;
			colorText[] = {0, 0.5, 0, 1};
			font = "PuristaBold";
			sizeEx = 0.15;
			size = 0.3;
		};

	};

};
