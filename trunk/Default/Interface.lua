----------------------------------------------------------------
-- Global functions
----------------------------------------------------------------

function ToggleWindowByName( wndName, btnName, toggleFunction, onOpenFunction, onCloseFunction )
	local showing = WindowGetShowing( wndName )
	showing = not showing	
	WindowSetShowing( wndName, showing )
	
	if (btnName ~= "") then
		ButtonSetPressedFlag( btnName, showing )
	end
	
	if( onOpenFunction ~= nil and showing == true ) then
	    onOpenFunction()
	elseif( onCloseFunction ~= nil and showing == false ) then
	    onCloseFunction()
	end
end

----------------------------------------------------------------
-- In-Game Interface Initialization Variables
----------------------------------------------------------------

Interface.TID = { accept=1013076, cancel=1011012 }

-- In the future, this could be exposed by c++:
Interface.PLAYWINDOWSET = 2

function Interface.CreatePlayWindowSet()
	--Builds the data for player
	UOBuildTableFromCSV("Data/GameData/playerstats.csv", "PlayerStatsDataCSV")
	
	CreateWindow( "ResizeWindow", true )
	CreateWindow( "MainMenuWindow", false )
	CreateWindow( "SettingsWindow", false )
	CreateWindow( "CharacterSheet", false )
	CreateWindow( "CharacterAbilities", false )
	CreateWindow( "ItemProperties", false )
	CreateWindow( "BugReportWindow", false )
	CreateWindow( "SkillsWindow", false )
	CreateWindow( "MacroWindow", false )	
	CreateWindow( "StatusWindow", true )
	CreateWindow( "MenuBarWindow", true )
	CreateWindow( "PetWindow", true )
	CreateWindow( "TargetWindow", false )
	CreateWindow( "ContextMenu", false )
	CreateWindow( "ActionsWindow", false )
	CreateWindow( "ActionEditText", false )
	CreateWindow( "ActionEditSlider", false )
	CreateWindow( "ActionEditMacro", false )
	CreateWindow( "ActionEditEquip", false )
	CreateWindow( "ActionEditUnEquip", false )
	CreateWindow( "ActionEditArmDisarm", false )
	CreateWindow( "ActionEditTargetByResource", false )
	CreateWindow( "ActionEditTargetByObjectId", false )
	CreateWindow( "MapWindow", false )
	CreateWindow( "RadarWindow", true )
	CreateWindow( "SkillsInfo", false )	
	CreateWindow( "UserWaypointWindow", false)
	
	if( SystemData.Settings.Interface.showTipoftheDay ) then
		CreateWindow( "TipoftheDayWindow", true)
	end
			
	WindowRegisterEventHandler("Root", SystemData.Events.BUG_REPORT_SCREEN, "Interface.InitBugReport")	
	WindowRegisterEventHandler( "Root", SystemData.Events.CHARACTER_SETTINGS_UPDATED, "Interface.RetrieveCharacterSettings")
	WindowRegisterEventHandler( "Root", SystemData.Events.WINDOWS_SETTINGS_UPDATED, "Interface.UpdateWindowsSettings")
	WindowRegisterEventHandler( "Root", SystemData.Events.OPEN_CRIMINAL_NOTIFICATION_GUMP, "Interface.ShowCriminalNotificationGump")
	WindowRegisterEventHandler( "Root", SystemData.Events.SHOW_PARTY_INVITE, "Interface.ShowPartyInvite")
	
	HotbarSystem.Initialize()
	GGManager.Initialize()	
	DamageWindow.Initialize()
	EquipmentData.Initialize()
	HealthBarManager.Initialize()
	ObjectHandleWindow.Initialize()
	OverheadText.InitializeEvents()
    StaticTextWindow.Initialize()
    MapCommon.Initialize()
    QueryWindow.Initialize()
    
	WindowRegisterEventHandler( "Root", SystemData.Events.DEBUGPRINT_TO_CONSOLE, "Interface.OnDebugPrint")
	
	if SystemData.Settings.Interface.mapMode == MapCommon.MAP_RADAR then
		RadarWindow.ActivateRadar()
	elseif SystemData.Settings.Interface.mapMode == MapCommon.MAP_ATLAS then
		MapWindow.ActivateMap()
	else
		WindowSetShowing("MapWindow", false)
		WindowSetShowing("RadarWindow", false)
	end
end

function Interface.InitBugReport()
	ToggleWindowByName( "BugReportWindow", "", MainMenuWindow.ToggleBugReportWindow )
end

function Interface.Update( timePassed )
	BuffDebuff.Update( timePassed )
	
	DamageWindow.UpdateTime( timePassed )
	ResizeWindow.Update(timePassed)
	OverheadText.Update(timePassed)
	ContainerWindow.UpdatePickupTimer(timePassed)
	ContextMenu.Update(timePassed)
	StaticTextWindow.Update( timePassed )
	HotbarSystem.Update(timePassed)
	MapCommon.Update(timePassed)
end

function Interface.Shutdown()
	EquipmentData.Shutdown()
	HotbarSystem.Shutdown()
	
	MapCommon.Shutdown()
	--Unload playerstatsData used for character sheet and the hotbar system
	UOUnloadCSVTable("PlayerStatsDataCSV")
end

function Interface.OnDebugPrint()
	Debug.PrintToDebugConsole(DebugData.DebugString)
end

function Interface.RetrieveCharacterSettings()
	--WindowUtils.RetrieveWindowSettings()
end

function Interface.UpdateWindowsSettings()
	WindowUtils.SendWindowSettings()
end

function Interface.ShowCriminalNotificationGump()
	local okButton = { textTid = Interface.TID.accept, callback = Interface.AcceptCriminalNotification }
	local cancelButton = { textTid = Interface.TID.cancel, callback = nil }
	local windowData = 
	{
		windowName = "ShowCriminalNotification", 
		titleTid = 1111873, -- "Warning"
		bodyTid = 3000032, -- This may flag you criminal!
		buttons = { okButton, cancelButton }
	}
	UO_StandardDialog.CreateDialog( windowData )	
end

function Interface.ShowPartyInvite()
	CreateWindow( "PartyInviteWindow", true )
end

function Interface.AcceptCriminalNotification()
	AcceptCriminalNotification()		
end