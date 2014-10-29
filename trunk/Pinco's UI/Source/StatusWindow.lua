----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

StatusWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
StatusWindow.lastMinHP = 0
StatusWindow.lastMaxHP = 0

StatusWindow.PartyNextUpdate = 0
StatusWindow.GuildNextUpdate = 0

StatusWindow.CurPlayerId = 0

StatusWindow.AuraEnabled = true
StatusWindow.GlowingCreated = false

StatusWindow.Locked = false

StatusWindow.Notoriety = { NONE = 1, INNOCENT = 2, FRIEND = 3, CANATTACK =4, CRIMINAL=5, ENEMY=6, MURDERER=7, INVULNERABLE=8 }

StatusWindow.TextColors = {}
StatusWindow.TextColors[StatusWindow.Notoriety.NONE]         = { r=225, g=225, b=225 } --- GREY/SYS
StatusWindow.TextColors[StatusWindow.Notoriety.INNOCENT]     = { r=0, g=130, b=255 } --- BLUE
StatusWindow.TextColors[StatusWindow.Notoriety.FRIEND]       = { r=0 ,  g=255, b=0   } --- GREEN 
StatusWindow.TextColors[StatusWindow.Notoriety.CANATTACK]    = { r=70, g=70, b=70 } --- GREY/SYS
StatusWindow.TextColors[StatusWindow.Notoriety.CRIMINAL]     = { r=70, g=70, b=70 } --- GREY/SYS
StatusWindow.TextColors[StatusWindow.Notoriety.ENEMY]        = { r=242, g=159, b=77  } --- ORANGE
StatusWindow.TextColors[StatusWindow.Notoriety.MURDERER]     = { r=255, g=0,  b=0  } --- RED  
StatusWindow.TextColors[StatusWindow.Notoriety.INVULNERABLE] = { r=255, g=255, b=0   } --- YELLOW 

StatusWindow.Beat = false
StatusWindow.BeatSlow = false
StatusWindow.BeatMed = false
StatusWindow.BeatFast = false

StatusWindow.NowCriminal = false
StatusWindow.Criminal = false

StatusWindow.delta = 0

StatusWindow.Skills={
[1] = { sop=false, TCName =L"alchemy" },
[2] = { sop=true, TCName =L"anatomy" },
[3] = { sop=true, TCName =L"animallore" },
[4] = { sop=true, TCName =L"animaltaming" },
[5] = { sop=true, TCName =L"archery" },
[6] = { sop=false, TCName =L"armslore" },
[7] = { sop=false, TCName =L"begging" },
[8] = { sop=true, TCName =L"blacksmith" },
[9] = { sop=true, TCName =L"bushido" },
[10] = { sop=false, TCName =L"camping" },
[11] = { sop=false, TCName =L"carpentry" },
[12] = { sop=false, TCName =L"cartography" },
[13] = { sop=true, TCName =L"chivalry" },
[14] = { sop=false, TCName =L"cooking" },
[15] = { sop=false, TCName =L"detecthidden" },
[16] = { sop=true, TCName =L"discordance" },
[17] = { sop=true, TCName =L"evalint" },
[18] = { sop=true, TCName =L"fencing" },
[19] = { sop=true, TCName =L"fishing" },
[20] = { sop=false, TCName =L"fletching" },
[21] = { sop=true, TCName =L"focus" },
[22] = { sop=false, TCName =L"forensics" },
[23] = { sop=true, TCName =L"healing" },
[24] = { sop=false, TCName =L"herding" },
[25] = { sop=false, TCName =L"hiding" },
[26] = { sop=true, TCName =L"imbuing" },
[27] = { sop=false, TCName =L"inscribe" },
[28] = { sop=false, TCName =L"itemid" },
[29] = { sop=false, TCName =L"lockpicking" },
[30] = { sop=false, TCName =L"lumberjacking" },
[31] = { sop=true, TCName =L"macing" },
[32] = { sop=true, TCName =L"magery" },
[33] = { sop=true, TCName =L"magicresist" },
[34] = { sop=true, TCName =L"meditation" },
[35] = { sop=false, TCName =L"mining" },
[36] = { sop=true, TCName =L"musicianship" },
[37] = { sop=true, TCName =L"mysticism" },
[38] = { sop=true, TCName =L"necromancy" },
[39] = { sop=true, TCName =L"ninjitsu" },
[40] = { sop=true, TCName =L"parry" },
[41] = { sop=true, TCName =L"peacemaking" },
[42] = { sop=false, TCName =L"poisoning" },
[43] = { sop=true, TCName =L"provocation" },
[44] = { sop=false, TCName =L"removetrap" },
[45] = { sop=false, TCName =L"snooping" },
[46] = { sop=true, TCName =L"spellweaving" },
[47] = { sop=true, TCName =L"spiritspeak" },
[48] = { sop=true, TCName =L"stealing" },
[49] = { sop=true, TCName =L"stealth" },
[50] = { sop=true, TCName =L"swords" },
[51] = { sop=true, TCName =L"tactics" },
[52] = { sop=true, TCName =L"tailoring" },
[53] = { sop=false, TCName =L"tasteid" },
[54] = { sop=true, TCName =L"throwing" },
[55] = { sop=false, TCName =L"tinkering" },
[56] = { sop=false, TCName =L"tracking" },
[57] = { sop=true, TCName =L"veterinary" },
[58] = { sop=true, TCName =L"wrestling" },
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function StatusWindow.Initialize()
	CreateWindow("DiabloStatusWindow", true)
	RegisterWindowData(WindowData.PlayerStatus.Type,0)
	WindowRegisterEventHandler( "StatusWindow", WindowData.PlayerStatus.Event, "StatusWindow.UpdateStatus")
	StatusWindow.UpdateStatus()
	StatusWindow.ToggleStrLabel()
	SnapUtils.SnappableWindows["StatusWindow"] = true
	SnapUtils.SnappableWindows["DiabloStatusWindow"] = true
	-- TODO: Once someone fixes the baseline alignment of the various fonts (so that English isn't 3 pixels above every other language), remove this hack.
	-- START HACK
	if GetStringFromTid( 1011036 ) ~= L"OKAY" then -- assume not English
		local healthLabelName = "StatusWindowHealthTooltip"
		local manaLabelName = "StatusWindowManaTooltip"
		local staminaLabelName = "StatusWindowStaminaTooltip"
		local healthBarName = "StatusWindowHealthBar"
		local manaBarName = "StatusWindowManaBar"
		local staminaBarName = "StatusWindowStaminaBar"
		WindowClearAnchors( healthLabelName )
		WindowClearAnchors( manaLabelName )
		WindowClearAnchors( staminaLabelName )
		WindowAddAnchor( healthLabelName, "top", healthBarName, "top", 0, -6 )
		WindowAddAnchor( manaLabelName, "top", manaBarName, "top", 0, -6 )
		WindowAddAnchor( staminaLabelName, "top", staminaBarName, "top", 0, -6 )
	end	
	-- END HACK
	WindowUtils.RestoreWindowPosition("DiabloStatusWindow")
	WindowUtils.RestoreWindowPosition("StatusWindow")
	WindowSetShowing("StatusWindowGuardsButton", false)
	ButtonSetTexture("StatusWindowLock", InterfaceCore.ButtonStates.STATE_NORMAL, UI.Lock.texture, UI.Lock.STATE_NORMAL.x, UI.Lock.STATE_NORMAL.y)
	ButtonSetTexture("StatusWindowLock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_NORMAL_HIGHLITE.x, UI.Lock.STATE_NORMAL_HIGHLITE.y)
	ButtonSetTexture("StatusWindowLock", InterfaceCore.ButtonStates.STATE_PRESSED, UI.Lock.texture, UI.Lock.STATE_PRESSED.x, UI.Lock.STATE_PRESSED.y) -- 248
	ButtonSetTexture("StatusWindowLock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_PRESSED_HIGHLITE.x, UI.Lock.STATE_PRESSED_HIGHLITE.y) -- 248
	
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_NORMAL, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL.x, UI.DownArrow.STATE_NORMAL.y)
	ButtonSetTexture("StatusWindowMenu",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL_HIGHLITE.x, UI.DownArrow.STATE_NORMAL_HIGHLITE.y)
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_PRESSED, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED.x, UI.DownArrow.STATE_PRESSED.y) -- 248
	ButtonSetTexture("StatusWindowMenu", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED_HIGHLITE.x, UI.DownArrow.STATE_PRESSED_HIGHLITE.y) -- 248
	
	
	WindowSetShowing("DiabloStatusWindowGuardsButton", false)
	ButtonSetTexture("DiabloStatusWindowLock", InterfaceCore.ButtonStates.STATE_NORMAL, UI.Lock.texture, UI.Lock.STATE_NORMAL.x, UI.Lock.STATE_NORMAL.y)
	ButtonSetTexture("DiabloStatusWindowLock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_NORMAL_HIGHLITE.x, UI.Lock.STATE_NORMAL_HIGHLITE.y)
	ButtonSetTexture("DiabloStatusWindowLock", InterfaceCore.ButtonStates.STATE_PRESSED, UI.Lock.texture, UI.Lock.STATE_PRESSED.x, UI.Lock.STATE_PRESSED.y) -- 248
	ButtonSetTexture("DiabloStatusWindowLock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_PRESSED_HIGHLITE.x, UI.Lock.STATE_PRESSED_HIGHLITE.y) -- 248
	
	ButtonSetTexture("DiabloStatusWindowMenu", InterfaceCore.ButtonStates.STATE_NORMAL, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL.x, UI.DownArrow.STATE_NORMAL.y)
	ButtonSetTexture("DiabloStatusWindowMenu",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL_HIGHLITE.x, UI.DownArrow.STATE_NORMAL_HIGHLITE.y)
	ButtonSetTexture("DiabloStatusWindowMenu", InterfaceCore.ButtonStates.STATE_PRESSED, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED.x, UI.DownArrow.STATE_PRESSED.y) -- 248
	ButtonSetTexture("DiabloStatusWindowMenu", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED_HIGHLITE.x, UI.DownArrow.STATE_PRESSED_HIGHLITE.y) -- 248
	

end

function StatusWindow.ToggleButtons()
	WindowSetShowing("StatusWindowMenu", EnhancePack.StatusButtons)
	WindowSetShowing("StatusWindowRedButton", EnhancePack.StatusButtons)
	WindowSetShowing("StatusWindowGreenButton", EnhancePack.StatusButtons)
	WindowSetShowing("StatusWindowBlueButton", EnhancePack.StatusButtons)
	
	WindowSetShowing("DiabloStatusWindowRedButton", EnhancePack.StatusButtons)
	WindowSetShowing("DiabloStatusWindowGreenButton", EnhancePack.StatusButtons)
	WindowSetShowing("DiabloStatusWindowBlueButton", EnhancePack.StatusButtons)
end

function StatusWindow.TCTools()
	subMenu = {
			{ str = UI.GetCliloc(SystemData.Settings.Language.type, 661),flags=0,returnCode="str",pressed=false },
			{ str = UI.GetCliloc(SystemData.Settings.Language.type, 662),flags=0,returnCode="dex",pressed=false},
			{ str = UI.GetCliloc(SystemData.Settings.Language.type, 663),flags=0,returnCode="int",pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 660),0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[7].NameTid),flags=0,returnCode=7,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[22].NameTid),flags=0,returnCode=22,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[28].NameTid),flags=0,returnCode=28,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[53].NameTid),flags=0,returnCode=53,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 670),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[2].NameTid),flags=0,returnCode=2,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[5].NameTid),flags=0,returnCode=5,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[18].NameTid),flags=0,returnCode=18,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[21].NameTid),flags=0,returnCode=21,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[23].NameTid),flags=0,returnCode=23,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[31].NameTid),flags=0,returnCode=31,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[40].NameTid),flags=0,returnCode=40,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[50].NameTid),flags=0,returnCode=50,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[51].NameTid),flags=0,returnCode=51,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[58].NameTid),flags=0,returnCode=58,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[54].NameTid),flags=0,returnCode=54,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 671),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[1].NameTid),flags=0,returnCode=1,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[6].NameTid),flags=0,returnCode=6,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[8].NameTid),flags=0,returnCode=8,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[11].NameTid),flags=0,returnCode=11,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[12].NameTid),flags=0,returnCode=12,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[14].NameTid),flags=0,returnCode=14,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[20].NameTid),flags=0,returnCode=20,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[27].NameTid),flags=0,returnCode=27,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[30].NameTid),flags=0,returnCode=30,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[35].NameTid),flags=0,returnCode=35,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[52].NameTid),flags=0,returnCode=52,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[55].NameTid),flags=0,returnCode=55,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 672),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[9].NameTid),flags=0,returnCode=9,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[13].NameTid),flags=0,returnCode=13,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[17].NameTid),flags=0,returnCode=17,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[32].NameTid),flags=0,returnCode=32,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[33].NameTid),flags=0,returnCode=33,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[34].NameTid),flags=0,returnCode=34,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[38].NameTid),flags=0,returnCode=38,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[39].NameTid),flags=0,returnCode=39,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[46].NameTid),flags=0,returnCode=46,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[47].NameTid),flags=0,returnCode=47,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[37].NameTid),flags=0,returnCode=37,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[26].NameTid),flags=0,returnCode=26,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 673),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[3].NameTid),flags=0,returnCode=3,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[4].NameTid),flags=0,returnCode=4,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[10].NameTid),flags=0,returnCode=10,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[19].NameTid),flags=0,returnCode=19,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[24].NameTid),flags=0,returnCode=24,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[56].NameTid),flags=0,returnCode=56,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[57].NameTid),flags=0,returnCode=57,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 674),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[15].NameTid),flags=0,returnCode=15,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[25].NameTid),flags=0,returnCode=25,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[29].NameTid),flags=0,returnCode=29,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[42].NameTid),flags=0,returnCode=42,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[44].NameTid),flags=0,returnCode=44,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[45].NameTid),flags=0,returnCode=45,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[48].NameTid),flags=0,returnCode=48,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[49].NameTid),flags=0,returnCode=49,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 675),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(WindowData.SkillsCSV[16].NameTid),flags=0,returnCode=16,pressed=false },
			{ str = GetStringFromTid(WindowData.SkillsCSV[36].NameTid),flags=0,returnCode=36,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[41].NameTid),flags=0,returnCode=41,pressed=false},
			{ str = GetStringFromTid(WindowData.SkillsCSV[43].NameTid),flags=0,returnCode=43,pressed=false},
			}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 676),0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	subMenu = {
			{ str = UI.GetCliloc(SystemData.Settings.Language.type, 678),flags=EnhancePack.ArteReceived,returnCode="arte",pressed=false },
			{ str = UI.GetCliloc(SystemData.Settings.Language.type, 679),flags=EnhancePack.ResReceived,returnCode="res",pressed=false},
			{ str = UI.GetCliloc(SystemData.Settings.Language.type, 680),flags=EnhancePack.AirReceived,returnCode="air",pressed=false},
			{ str = UI.GetCliloc(SystemData.Settings.Language.type, 681),flags=EnhancePack.SeedsReceived,returnCode="seeds",pressed=false},
			}
	if (EnhancePack.ArteReceived + EnhancePack.ResReceived + EnhancePack.AirReceived + EnhancePack.SeedsReceived) >=4 then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 677),1,0,"null",false,nil)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 677),0,0,"null",false,subMenu)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 682),EnhancePack.TokensReceived,"tokens",false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 683),0,"grow",false)

	
	
	ContextMenu.ActivateLuaContextMenu(StatusWindow.TCContextMenuCallback)
end

function StatusWindow.TCContextMenuCallback(returnCode, param)
	if ( returnCode=="arte" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give arties")
		EnhancePack.ArteReceived = 1
		CustomSettings.SaveNumber( "EnhancePackArteReceived" , EnhancePack.ArteReceived )
	elseif ( returnCode=="grow" ) then

		local okayButton = { textTid=UO_StandardDialog.TID_OKAY , callback=function()SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], L"/say Grow_Plant");end }
		local cancelButton = { text=UI.GetCliloc(SystemData.Settings.Language.type, 419)}
		local DestroyConfirmWindow = 
				{
				    windowName = "GrowPlant",
					title = UI.GetCliloc(SystemData.Settings.Language.type, 683),
					body = UI.GetCliloc(SystemData.Settings.Language.type, 684) ,
					buttons = { okayButton, cancelButton }
				}
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

		

	elseif ( returnCode=="res" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give resources")
		EnhancePack.ResReceived = 1
		CustomSettings.SaveNumber( "EnhancePackResReceived" , EnhancePack.ResReceived )
	elseif ( returnCode=="air" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give air")
		EnhancePack.AirReceived = 1
		CustomSettings.SaveNumber( "EnhancePackAirReceived" , EnhancePack.AirReceived )
	elseif ( returnCode=="seeds" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give seeds")
		EnhancePack.SeedsReceived = 1
		CustomSettings.SaveNumber( "EnhancePackSeedsReceived" , EnhancePack.SeedsReceived )
	elseif ( returnCode=="tokens" ) then
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say give tokens")
		EnhancePack.TokensReceived = 1
		CustomSettings.SaveNumber( "EnhancePackTokensReceived" , EnhancePack.TokensReceived )
	elseif ( returnCode=="str" ) then
		local currStr  = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseStr" ),3,-2))
		local currDex = tonumber(WindowData.PlayerStatus["Dexterity"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseDex" ),3,-2))
		local currInt = tonumber(WindowData.PlayerStatus["Intelligence"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseInt" ),3,-2))
			local max = 255 - (currStr + currDex + currInt)
			local tmp = currStr
			max = max + tmp
			if max >= 125 then
				max = 125
			end
			local rdata = {title=GetStringFromTid(1077833), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 665) .. L"10 - " .. max, callfunction=StatusWindow.EditStr, min = 10, max = max, id=L"str"}
			RenameWindow.Create(rdata)

	elseif ( returnCode=="dex" ) then
		local currStr  = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseStr" ),3,-2))
		local currDex = tonumber(WindowData.PlayerStatus["Dexterity"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseDex" ),3,-2))
		local currInt = tonumber(WindowData.PlayerStatus["Intelligence"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseInt" ),3,-2))

			local max = 255 - (currStr + currDex + currInt)
			local tmp = currDex
			max = max + tmp
			if max >= 125 then
				max = 125
			end
			local rdata = {title=GetStringFromTid(1077834), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 665) .. L"10 - " .. max, callfunction=StatusWindow.EditStr, min = 10, max = max, id=L"dex"}
			RenameWindow.Create(rdata)
	elseif ( returnCode=="int" ) then
		local currStr  = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseStr" ),3,-2))
		local currDex = tonumber(WindowData.PlayerStatus["Dexterity"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseDex" ),3,-2))
		local currInt = tonumber(WindowData.PlayerStatus["Intelligence"]) - tonumber(wstring.sub(CharacterSheet.StrDexIntBonus( "IncreaseInt" ),3,-2))

			local max = 255 - (currStr + currDex + currInt)
			local tmp = currInt
			max = max + tmp
			if max >= 125 then
				max = 125
			end
			local rdata = {title=GetStringFromTid(1077834), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 665) .. L"10 - " .. max, callfunction=StatusWindow.EditStr, min = 10, max = max, id=L"int"}
			RenameWindow.Create(rdata)
	elseif (tonumber(returnCode) ~= nil and tonumber(returnCode) > 0) then
		local max = 100
		if (StatusWindow.Skills[returnCode] and StatusWindow.Skills[returnCode].sop == true) then
			max = 120
		end
		local rdata = {title=GetStringFromTid(WindowData.SkillsCSV[returnCode].NameTid), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 665) .. L"0 - " .. max, callfunction=StatusWindow.EditSkill, min = 0, max = max, id=returnCode}
		RenameWindow.Create(rdata)
	end
end
function StatusWindow.EditSkill(id, value, max, min)
	if ( tonumber(value)  ~= nil) then
		
		if tonumber(value) < min then
			value = min
		end
		if tonumber(value) > max then
			value = max
		end
		value = wstring.format(L"%.01f", value)
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say set " .. StatusWindow.Skills[id].TCName .. L" " .. value)
	end
end 

function StatusWindow.EditStr(id, value, max, min)
	
	if ( tonumber(value)  ~= nil) then
		if tonumber(value) < min then
			value = min
		end
		if tonumber(value) > max then
			value = max
		end
		_channel = ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ]
		SendChat( _channel, L"/say set " .. id .. L" " .. value)
	end
end

function StatusWindow.TCToolsTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 664))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

StatusWindow.TCToolsHandle = false
function StatusWindow.TCToolsOver()
	
	if not StatusWindow.TCToolsHandle then
		WindowSetShowing("TCTOOLSWindowIMG", true)
		StatusWindow.TCToolsHandle = true
	end
end

function StatusWindow.TCToolsOnLButtonDown()
	SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
end

function StatusWindow.TCToolsOverend()
	WindowSetShowing("TCTOOLSWindowIMG", false)
	StatusWindow.TCToolsHandle = false
end

function StatusWindow.LockTooltip()
	if ( StatusWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 324))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 325))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.Lock()
	StatusWindow.Locked = not StatusWindow.Locked 
	CustomSettings.SaveBoolean( "StatusWindowLocked", StatusWindow.Locked  )
end


function StatusWindow.MenuTooltip()
	
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 326))
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function StatusWindow.Menu()
	TargetWindow.Context = nil
	RequestContextMenu(WindowData.PlayerStatus.PlayerId)
end


function StatusWindow.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	WindowUtils.SaveWindowPosition("StatusWindow")
	WindowUtils.SaveWindowPosition("DiabloStatusWindow")
	SnapUtils.SnappableWindows["StatusWindow"] = nil
	SnapUtils.SnappableWindows["DiabloStatusWindow"] = nil
	if (DoesWindowNameExist("TCTOOLSWindow")) then
		SnapUtils.SnappableWindows["TCTOOLSWindow"] = false
		WindowUtils.SaveWindowPosition("TCTOOLSWindow")
	end
end

function StatusWindow.Update( timePassed )
	StatusWindow.delta = StatusWindow.delta + timePassed

	if ( WindowData.MobileName[StatusWindow.CurPlayerId] == nil  ) then
		EnhancePack.StatusCall = true
		MobileHealthBar.CreateHealthBar(StatusWindow.CurPlayerId)
		WindowSetShowing("MobileHealthBar_"..StatusWindow.CurPlayerId, false)
		EnhancePack.StatusCall = false
		return
	end
	local curr = WindowData.PlayerStatus.CurrentHealth
	local max = WindowData.PlayerStatus.MaxHealth 
	local perc = (curr/max)*100
	perc = math.floor(perc)

	if (EnhancePack and EnhancePack.HeartBeat and EnhancePack.TimeSinceLogin >=2) then
		
		local deltalimit = 0
		if (perc <= 50 and not EnhancePack.Dead) then
			local changeBeat = false

			if (perc >35 and perc <= 50 and not StatusWindow.BeatSlow) then
				StatusWindow.BeatSlow = true
				StatusWindow.BeatMed = false
				StatusWindow.BeatFast = false
				changeBeat = true
			end
			if (perc >20 and perc <= 35 and not StatusWindow.BeatMed) then
				StatusWindow.BeatSlow = false
				StatusWindow.BeatMed = true
				StatusWindow.BeatFast = false
				changeBeat = true
			end
			if (perc >0 and perc <= 20 and not StatusWindow.BeatFast) then
				StatusWindow.BeatSlow = false
				StatusWindow.BeatMed = false
				StatusWindow.BeatFast = true
				changeBeat = true
			end

			if (changeBeat) then
				if (StatusWindow.BeatSlow ) then
					PlaySound(2,"beatSlow.mp3", 2)
					--Debug.Print("BEATSLOW")
				elseif (StatusWindow.BeatMed) then
					PlaySound(2,"beatMed.mp3", 2)
					--Debug.Print("BEATMED")
				elseif (StatusWindow.BeatFast) then
					PlaySound(2,"beatFast.mp3", 2)
					--Debug.Print("BEATFAST")
				end
				
			end
			StatusWindow.Beat = true
		else
			if (StatusWindow.Beat) then
				PlaySound(2,"", 1)
				StatusWindow.Beat = false
				StatusWindow.BeatSlow = false
				StatusWindow.BeatMed = false
				StatusWindow.BeatFast = false
			end
		end
		
		
	elseif( EnhancePack.Dead) then
		if (StatusWindow.Beat) then
			PlaySound(2,"", 1)
			StatusWindow.Beat = false
			StatusWindow.BeatSlow = false
			StatusWindow.BeatMed = false
			StatusWindow.BeatFast = false
		end
	end
		
		
	local noto = tonumber(WindowData.MobileName[StatusWindow.CurPlayerId].Notoriety+1)
	
	if (noto == StatusWindow.Notoriety.CRIMINAL) then
		if (not StatusWindow.Criminal) then
			StatusWindow.NowCriminal = true
		end
		if (not BuffDebuff.Timers[10026]) then
			StatusWindow.NowCriminal = true
		end
		StatusWindow.Criminal =  true
	elseif( BuffDebuff.ActiveBuffs[10026]) then
		StatusWindow.Criminal =  false
		StatusWindow.NowCriminal = false
		WindowData.BuffDebuffSystem.CurrentBuffId = 10026
		WindowData.BuffDebuff.TimerSeconds = 0
		WindowData.BuffDebuff.HasTimer = true
		WindowData.BuffDebuff.NameVectorSize = 1
		WindowData.BuffDebuff.ToolTipVectorSize = 1
		WindowData.BuffDebuff.IsBeingRemoved = true 
		WindowData.BuffDebuff.NameWStringVector = {[1] = UI.GetCliloc(SystemData.Settings.Language.type, 729)}
		WindowData.BuffDebuff.ToolTipWStringVector = {[1] = UI.GetCliloc(SystemData.Settings.Language.type, 730)}
		BuffDebuff.ShouldCreateNewBuff()
	end
	
	if (StatusWindow.NowCriminal) then
		StatusWindow.NowCriminal = false
		if ( BuffDebuff.ActiveBuffs[1120] == nil ) then
			WindowData.BuffDebuffSystem.CurrentBuffId = 10026
			WindowData.BuffDebuff.TimerSeconds = 119
			WindowData.BuffDebuff.HasTimer = true
			WindowData.BuffDebuff.NameVectorSize = 1
			WindowData.BuffDebuff.ToolTipVectorSize = 1
			WindowData.BuffDebuff.IsBeingRemoved = false 
			WindowData.BuffDebuff.NameWStringVector = {[1] = UI.GetCliloc(SystemData.Settings.Language.type, 729)}
			WindowData.BuffDebuff.ToolTipWStringVector = {[1] = UI.GetCliloc(SystemData.Settings.Language.type, 730)}
			BuffDebuff.ShouldCreateNewBuff()
		end
	end
	
	local speed = EnhancePack.AuraSpeed
	if (StatusWindow.AuraEnabled and StatusWindow.GlowingCreated == false) then
		
		if (not DoesWindowNameExist("GlowingEffectAnimHealth")) then
		
			CreateWindowFromTemplate("GlowingEffectHealth", "StatusTEXTs", "StatusWindow")
			CreateWindowFromTemplate("GlowingEffectAnimHealth", "StatusGlowingEffect", "GlowingEffectHealth")
			WindowClearAnchors("GlowingEffectHealth")
			WindowAddAnchor("GlowingEffectHealth", "center", "StatusWindowPortraitBg", "center", 14, 10)
			WindowSetScale("GlowingEffectHealth", WindowGetScale("StatusWindow"))
		end
		
		if (not DoesWindowNameExist("DiabloGlowingEffectAnimHealth")) then
		
			CreateWindowFromTemplate("DiabloGlowingEffectHealth", "StatusTEXTs", "DiabloStatusWindow")
			CreateWindowFromTemplate("DiabloGlowingEffectAnimHealth", "StatusGlowingEffect", "DiabloGlowingEffectHealth")
			WindowClearAnchors("DiabloGlowingEffectHealth")
			WindowAddAnchor("DiabloGlowingEffectHealth", "center", "DiabloStatusWindowPortraitBg", "center", 14, 11)
			WindowSetScale("DiabloGlowingEffectHealth", WindowGetScale("DiabloStatusWindow"))
		end

		AnimatedImageStartAnimation( "GlowingEffectAnimHealth", 1, true, false, 0.0 )  
		
		AnimatedImageStartAnimation( "DiabloGlowingEffectAnimHealth", 1, true, false, 0.0 )  
		
		
		local gb = math.floor(2.55 * perc)
		--speed = (255 - gb) / 10
		--if (speed < 5) then
		--	speed = 5
		--end
		--if (speed > 20) then
		--	speed = 20
		--end
		AnimatedImageSetPlaySpeed( "GlowingEffectAnimHealth", speed)
		WindowSetTintColor("GlowingEffectAnimHealth",StatusWindow.TextColors[noto].r,StatusWindow.TextColors[noto].g,StatusWindow.TextColors[noto].b)
		 
		AnimatedImageSetPlaySpeed( "DiabloGlowingEffectAnimHealth", speed)
		WindowSetTintColor("DiabloGlowingEffectAnimHealth",StatusWindow.TextColors[noto].r,StatusWindow.TextColors[noto].g,StatusWindow.TextColors[noto].b)
		
		StatusWindow.GlowingCreated = true
	end
	
	if (StatusWindow.GlowingCreated) then
		--speed = (255 - gb) / 10
		--if (speed < 5) then
		--	speed = 5
		--end
		--if (speed > 20) then
		--	speed = 20
		--end

		WindowSetTintColor("GlowingEffectAnimHealth",StatusWindow.TextColors[noto].r,StatusWindow.TextColors[noto].g,StatusWindow.TextColors[noto].b)

		AnimatedImageSetPlaySpeed( "GlowingEffectAnimHealth", speed)
		
		WindowSetTintColor("DiabloGlowingEffectAnimHealth",StatusWindow.TextColors[noto].r,StatusWindow.TextColors[noto].g,StatusWindow.TextColors[noto].b)

		AnimatedImageSetPlaySpeed( "DiabloGlowingEffectAnimHealth", speed)
	end
	
	if (not StatusWindow.AuraEnabled and StatusWindow.GlowingCreated) then
		StatusWindow.GlowingCreated = false
		AnimatedImageStopAnimation( "GlowingEffectAnimHealth" )
		DestroyWindow("GlowingEffectHealth")
		
		AnimatedImageStopAnimation( "DiabloGlowingEffectAnimHealth" )
		DestroyWindow("DiabloGlowingEffectHealth")
	end
end


function StatusWindow.GuardsButton_OnLButtonUp()
	SendChat( _channel, L"/say Guards ! Help Me !!!" )
end

function StatusWindow.GuardsButton_OnMouseOver()

	local spellId = 44

	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = 1234,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	UI.GetCliloc(SystemData.Settings.Language.type, 578),
						body = L""}
						
	ItemProperties.SetActiveItem(itemData)
	PartyHealthBar.mouseOverId = StatusWindow.CurPlayerId
end



function StatusWindow.UpdateStatus()
	--Debug.PrintToDebugConsole(L"UPDATING STATUS")
	
	StatusBarSetMaximumValue( "StatusWindowHealthBar", WindowData.PlayerStatus.MaxHealth )
	StatusBarSetMaximumValue( "StatusWindowManaBar", WindowData.PlayerStatus.MaxMana )
	StatusBarSetMaximumValue( "StatusWindowStaminaBar", WindowData.PlayerStatus.MaxStamina )	
	StatusBarSetCurrentValue( "StatusWindowHealthBar", WindowData.PlayerStatus.CurrentHealth )
	StatusBarSetCurrentValue( "StatusWindowManaBar", WindowData.PlayerStatus.CurrentMana )
	StatusBarSetCurrentValue( "StatusWindowStaminaBar", WindowData.PlayerStatus.CurrentStamina )
	
	if (EnhancePack and EnhancePack.GuildShareHP ~= nil) then
		if (StatusWindow.lastMinHP ~= WindowData.PlayerStatus.CurrentHealth or StatusWindow.lastMaxHP ~= WindowData.PlayerStatus.MaxHealth) then
			if (EnhancePack.PartyShareHP and EnhancePack.TimeSinceLogin > StatusWindow.PartyNextUpdate) and WindowData.PartyMember.partyLeaderId ~= 0 then
				RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
				--Party-cmd:STATUS~<ID>_Name:<name>_HP:<min>-<max>
				local text = L"/party Party-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
				SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
				StatusWindow.PartyNextUpdate = EnhancePack.TimeSinceLogin + 2
				UnregisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
			end
			if (EnhancePack.AllyShareHP == true) then
				if (EnhancePack.AllyShareHP and EnhancePack.AllySharePos and EnhancePack.TimeSinceLogin > StatusWindow.GuildNextUpdate) and not EnhancePack.NotAlliance then
					RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
					--Ally-cmd:STATUS~<ID>_Name:<name>_HP:<min>-<max>
					local text = L"/alliance Ally-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
					SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
					StatusWindow.GuildNextUpdate = EnhancePack.TimeSinceLogin + 2
					UnregisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
				end
			else
				if (EnhancePack.GuildShareHP and EnhancePack.GuildSharePos and EnhancePack.TimeSinceLogin > StatusWindow.GuildNextUpdate) and not EnhancePack.NotGuilded then
					RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
					--Guild-cmd:STATUS~<ID>_Name:<name>_HP:<min>-<max>
					local text = L"/guild Guild-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
					SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
					StatusWindow.GuildNextUpdate = EnhancePack.TimeSinceLogin + 2
					UnregisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
				end
			end
			EnhancePack.UOMapperSend()
		end
		StatusWindow.lastMinHP = WindowData.PlayerStatus.CurrentHealth
		StatusWindow.lastMaxHP = WindowData.PlayerStatus.MaxHealth
	end
	
	--Colors the health bar to the correct color
	HealthBarColor.UpdateHealthBarColor("StatusWindowHealthBar", WindowData.PlayerStatus.VisualStateId)
	
	
	--Update label tooltip health, mana, and stamina
	StatusWindow.UpdateLabelContent()
	
	WindowSetTintColor("StatusWindowPortraitBg", 0, 0, 0)

	
	if( SystemData.PaperdollTexture[WindowData.PlayerStatus.PlayerId] ~= nil) then
		local textureData = SystemData.PaperdollTexture[WindowData.PlayerStatus.PlayerId]	
		local dead = WindowData.PlayerStatus.CurrentHealth <= 0 and WindowData.PlayerStatus.CurrentStamina <= 0
		
		if (WindowData.MobileStatus[WindowData.PlayerStatus.PlayerId] ~= nil ) then
			dead = WindowData.MobileStatus[WindowData.PlayerStatus.PlayerId].IsDead or dead
		end
		if dead then
			WindowSetShowing("StatusWindowPortrait", false)
			WindowSetShowing("StatusWindowDead", true)
			CircleImageSetTexture("StatusWindowDead","dead",-32,-30)
			
			WindowSetShowing("DiabloStatusWindowPortrait", false)
			WindowSetShowing("DiabloStatusWindowDead", true)
			CircleImageSetTexture("DiabloStatusWindowDead","dead",-32,-30)
		else
			WindowSetShowing("StatusWindowPortrait", true)
			WindowSetShowing("StatusWindowDead", false)
			WindowSetShowing("DiabloStatusWindowPortrait", true)
			WindowSetShowing("DiabloStatusWindowDead", false)

			local x, y, scale
			if textureData.IsLegacy == 1 then
				x, y = -88, 10
				scale = 1.75
			else
				x, y = -11, -191
				scale = 0.75
			end
			
			CircleImageSetTexture("StatusWindowPortrait", "paperdoll_texture"..WindowData.PlayerStatus.PlayerId, x - textureData.xOffset, y - textureData.yOffset)
			CircleImageSetTextureScale("StatusWindowPortrait", InterfaceCore.scale * scale)	
			
			CircleImageSetTexture("DiabloStatusWindowPortrait", "paperdoll_texture"..WindowData.PlayerStatus.PlayerId, x - textureData.xOffset, y - textureData.yOffset)
			CircleImageSetTextureScale("DiabloStatusWindowPortrait", InterfaceCore.scale * scale)		
		end
		
		StatusWindow.CurPlayerId = WindowData.PlayerStatus.PlayerId
	end
end

function StatusWindow.OnLButtonUp()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(StatusWindow.CurPlayerId)
	else
		WindowSetMoving("StatusWindow",false)
		WindowSetMoving("DiabloStatusWindow",false)
		HandleSingleLeftClkTarget(WindowData.PlayerStatus.PlayerId)
	end
end


function StatusWindow.OnLButtonDown()
	if (string.find(SystemData.ActiveWindow.name,"DiabloStatusWindow")) then
		if (not StatusWindow.Locked ) then
			SnapUtils.StartWindowSnap("DiabloStatusWindow")
			WindowSetMoving("DiabloStatusWindow",true)
		else
			WindowSetMoving("DiabloStatusWindow",false)
		end
	else
		if (not StatusWindow.Locked ) then
			SnapUtils.StartWindowSnap("StatusWindow")
			WindowSetMoving("StatusWindow",true)
		else
			WindowSetMoving("StatusWindow",false)
		end
	end
end


function StatusWindow.OnRButtonUp()
	TargetWindow.Context = nil
	RequestContextMenu(WindowData.PlayerStatus.PlayerId)
end

function StatusWindow.UpdateLabelContent()
	local healthLabelName = "StatusWindowHealthTooltip"
	local manaLabelName = "StatusWindowManaTooltip"
	local staminaLabelName = "StatusWindowStaminaTooltip"
	local healthStr = L""..WindowData.PlayerStatus.CurrentHealth..L"/"..WindowData.PlayerStatus.MaxHealth
	local manaStr = WindowData.PlayerStatus.CurrentMana..L"/"..WindowData.PlayerStatus.MaxMana
	local staminaStr = WindowData.PlayerStatus.CurrentStamina..L"/"..WindowData.PlayerStatus.MaxStamina
	--local statStr = healthStr..L"<BR>"..manaStr..L"<BR>"..staminaStr
	LabelSetText(healthLabelName, WindowUtils.translateMarkup(healthStr))
	LabelSetText(manaLabelName, WindowUtils.translateMarkup(manaStr))
	LabelSetText(staminaLabelName, WindowUtils.translateMarkup(staminaStr))
end
StatusWindow.Mouseover = false

function StatusWindow.OnMouseOver()
	StatusWindow.Mouseover = true
	local itemData =
	{
		windowName = "ActionsWindow",
		itemId = StatusWindow.CurPlayerId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)	

	if(SystemData.Settings.GameOptions.showStrLabel == false) then
		WindowSetShowing("StatusWindowHealthTooltip", true)
		WindowSetShowing("StatusWindowManaTooltip", true)
		WindowSetShowing("StatusWindowStaminaTooltip", true)
	end
end

function StatusWindow.OnMouseOverEnd()
	StatusWindow.Mouseover = false
	ItemProperties.ClearMouseOverItem()

	if(SystemData.Settings.GameOptions.showStrLabel == false) then
		WindowSetShowing("StatusWindowHealthTooltip", false)
		WindowSetShowing("StatusWindowManaTooltip", false)
		WindowSetShowing("StatusWindowStaminaTooltip", false)
	end
end

function StatusWindow.ToggleStrLabel()
	local healthLabelName = "StatusWindowHealthTooltip"
	local manaLabelName = "StatusWindowManaTooltip"
	local staminaLabelName = "StatusWindowStaminaTooltip"
	if(SystemData.Settings.GameOptions.showStrLabel == false) then
		WindowSetShowing(healthLabelName, false)
		WindowSetShowing(manaLabelName, false)
		WindowSetShowing(staminaLabelName, false)
	else
		WindowSetShowing(healthLabelName, true)
		WindowSetShowing(manaLabelName, true)
		WindowSetShowing(staminaLabelName, true)
	end
end

function StatusWindow.OnMouseDlbClk()
    UserActionUseItem(StatusWindow.CurPlayerId,false)
end