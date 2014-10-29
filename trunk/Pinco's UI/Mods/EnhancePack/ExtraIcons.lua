local UiModName = "ExtraIcons"
local mod = {}

_G[UiModName] = {}
mod = _G[UiModName]

mod.Supers = {
	MacroPickerWindow = {}
}

mod.Subs = {}
for k, v in pairs( mod.Supers ) do
	mod.Subs[k] = {}
end

mod.Icons = { 
-- PLAYER CONTEXT
860091,
860092,
860093,
860094,
860095,
860096,
860097,
860098,
860099,
870100,
870101,
870102,
870192,

-- SPELL CIRCLES
860037,
860038,
860039,
860040,
860041,
860042,
860043,
860044,

-- PINCO's UI & MENU
860000,
860001,
860002,
860003,
860004,
860005,
860006,
860007,
860008,
860009,
860010,
860011,
860012,
860013,
860014,
860015,
860016,
860017,
860018,
860019,
860020,
860021,
860022,
860023,
855030,
860025,
860026,
860027,
860028,
860029,
860030,
860031,
860032,
860033,
860035,
860036,
860046,
860049,
860050,
860051,
860052,
860053,
860055,
860056,
860089,
860090,
870126,
870127,
870128,
870182,
870129,
870133,
870134,
870135,
870136,
870137,
870138,
870139,
870140,
870141,
870142,
870143,
870144,
870145,
870175,
870176,
870177,
870178,
870179,
870181,
870183,
870184,
870185,
870186,
870187,
870188,
870189,
870190,
870191,
870193,
870194,
1000138,
870195,

-- ACTION2
855502,
855090,
855142,
855440,
855055,
855052,
855058,
855085,
855096,
855368,
855364,
855366,
855094,
855098,
855134,
855139,
855132,
855133,
855131,
860045,
860048,
860054,

-- POTIONS
856121,
856001,
856003,
856005,
856007,
856009,
856011,
856013,
856015,
856027,
856030,
856052,
856055,
856058,
856079,
856083,
856100,
856106,
856108,

-- PETS
855064,
855065,
855066,
855067,
855068,
855069,
855080,
855072,
855073,
855074,
855075,
855076,
855077,
855078,
855079,

-- MOUNTS
860100,
860101,
860102,
860103,
860104,
860105,
860106,
860107,
860108,
860109,
860110,
860111,

-- DEFAULT PETS
855101,
855102,
855103,
855104,
855105,

855110,
855111,
855112,
855113,
855114,

-- DRESS
855167,
855152,
855155,
855158,
855161,
855164,
855190,
855191,
855192,
855193,
855194,

855202,
855240,
855241,
855242,
855243,
855244,

855260,
855261,
855262,
855263,
855270,
855271,
855272,
855273,
855274,

855196,
855197,
855198,
855199,

855200,
855201,
855203,
855204,

-- WORKER TALISMAN DRESS
855302,
855305,
855308,
855311,
855314,
855317,
855320,
855323,
855326,
855329,
855332,

-- RESOURCES
1000139,
1000140,
1000141,
1000142,
1000143,
1000144,
1000145,

1000146,
1000147,
1000148,
1000149,
1000150,
1000151,
1000152,
1000153,
1000154,


-- SPEECH COMMANDS
855002,
855005,
855008,
855011,
855012,
855013,
855014,
855015,
855016,
855017,
855018,
855019,
855020,
855021,
855022,
855023,
870180,

-- CANNONS
860047,
855405,
855406,
855407,
855408,
855409,
855410,
855411,
855412,
855413,
855430,
855432,
855434,
855420,
855422,
855403,



-- SUPER SLAYERS
855550,
855551,
855552,
855553,
855554,
855555,
855556,

-- LESSER SLAYERS
855577,
855581,
855585,
855602,
855627,
855630,
855633,
855636,
855639,
855642,
855645,
855676,
855679,
855682,
855701,
855704,
855707,
855710,
855712,

-- TALISMAN SLAYERS
855903,
855906,
855909,
855912,
855915,
855918,
855921,
855924,
855926,
855927,
855995,

-- CONTAINERS
855117,
855118,
855119,
855120,
855121,

-- BARD SUPER SLAYERS
856550,
856551,
856552,
856553,
856554,
856555,
856556,

-- BARD LESSER SLAYERS
856577,
856581,
856585,
856602,
856627,
856630,
856633,
856636,
856639,
856642,
856645,
856676,
856679,
856682,
856701,
856704,
856707,
856710,

-- RUNE LOCATIONS
856127,
856130,
856133,
856136,
856137,
856138,
856139,
856140,
856150,
856151,
856152,
856141,
856143,
856142,
856144,
856153,
856154,
856160,
856180,
856190,
856191,
856192,
856193,
856194,
856215,
856216,
856217,
856218,
856219,
856240,
856241,
856242,
856243,
856244,
856265,
856266,
856267,
856268,
856269,
856275,
856297,

-- CUSTOM BUFFS
870196,
870197,
870198,
870199,
870200,
870201,
870202,
870203,
870204,
870205,

-- NUMBERS
857400,
857401,
857402,
857403,
857404,
857405,
857406,
857407,
857408,
857409,
857410,
857411,
857412,
857413,
857414,
857415,
857416,
857417,
857418,
857419,
857420,
857421,
857422,
857423,
857424,
857425,
857426,
857427,
857428,
857429,

 }
mod.Status = false


function mod.Initialize()
	mod.Supers.MacroPickerWindow.DrawMacroTable = MacroPickerWindow.DrawMacroTable
	MacroPickerWindow.DrawMacroTable = mod.Subs.MacroPickerWindow.DrawMacroTable
end


function  mod.Subs.MacroPickerWindow.DrawMacroTable(parent)

	if not mod.Status then
		for i,v in pairs(mod.Icons) do
			table.insert(MacroPickerWindow.MacroIcons,v)
		end
		mod.Status = true
	end

	 mod.Supers.MacroPickerWindow.DrawMacroTable(parent)
	

end
