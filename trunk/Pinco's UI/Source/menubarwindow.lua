----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MenuBarWindow = {}
MenuBarWindow.MenuBarData = {}
--MenuBarWindow.MenuBarData["MenuBarWindowToggleHelp"] = {}
--MenuBarWindow.MenuBarData["MenuBarWindowToggleHelp"].ToolTipTid = 1061037 -- Help
--MenuBarWindow.MenuBarData["MenuBarWindowToggleHelp"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"].ToolTipTid = L"Settings" -- Main Menu
MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"].ToggleWindow = "MainMenuWindow"
MenuBarWindow.MenuBarData["MenuBarWindowToggleMap"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleMap"].ToolTipTid = 1077438 -- World Map
MenuBarWindow.MenuBarData["MenuBarWindowToggleMap"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleGuild"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleGuild"].ToolTipTid = 1063308 -- Guild
MenuBarWindow.MenuBarData["MenuBarWindowToggleGuild"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleSkills"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleSkills"].ToolTipTid = L"General" -- Skills
MenuBarWindow.MenuBarData["MenuBarWindowToggleSkills"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleVirtues"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleVirtues"].ToolTipTid = 1077439 -- Virtues
MenuBarWindow.MenuBarData["MenuBarWindowToggleVirtues"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleQuests"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleQuests"].ToolTipTid = L"Customization Menu" -- Quest Journal
MenuBarWindow.MenuBarData["MenuBarWindowToggleQuests"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowTogglePaperdoll"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowTogglePaperdoll"].ToolTipTid = 3000133 -- Character
MenuBarWindow.MenuBarData["MenuBarWindowTogglePaperdoll"].ToggleWindow = nil
MenuBarWindow.MenuBarData["MenuBarWindowToggleChat"] = {}
MenuBarWindow.MenuBarData["MenuBarWindowToggleChat"].ToolTipTid = 1114078 -- Chat
MenuBarWindow.MenuBarData["MenuBarWindowToggleChat"].ToggleWindow = nil

MenuBarWindow.WarMode = 0

MenuBarWindow.MAXIMIZED = "maximized"
MenuBarWindow.MINIMIZED = "minimized"
MenuBarWindow.NUMSTATES = 2

MenuBarWindow.WindowStates = {}
MenuBarWindow.WindowStates[MenuBarWindow.MAXIMIZED] = "MenuBarWindow"
MenuBarWindow.WindowStates[MenuBarWindow.MINIMIZED] = "MenuBarWindowMinimized"

MenuBarWindow.CurState = MenuBarWindow.MAXIMIZED
MenuBarWindow.MinimizedOffset = 375
MenuBarWindow.Locked = false

MenuBarWindow.HuePickerWindowRequest = ""


----------------------------------------------------------------
-- General Functions
----------------------------------------------------------------

function MenuBarWindow.Initialize()
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_BACKPACK_WINDOW, "MenuBarWindow.ToggleInventoryWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_PAPERDOLL_CHARACTER_WINDOW, "MenuBarWindow.TogglePaperdollWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_GUILD_WINDOW, "MenuBarWindow.ToggleGuildWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_SKILLS_WINDOW, "MenuBarWindow.ToggleSkillsWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_VIRTUES_WINDOW, "MenuBarWindow.ToggleVirtuesWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_QUEST_LOG_WINDOW, "MenuBarWindow.ToggleQuestWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_HELP_WINDOW, "MenuBarWindow.ToggleHelpWindow")
	WindowRegisterEventHandler("MenuBarWindow", SystemData.Events.TOGGLE_WORLD_MAP_WINDOW, "MenuBarWindow.ToggleMapWindow")
    WindowRegisterEventHandler("MenuBarWindow", WindowData.PlayerStatus.Event, "MenuBarWindow.ToggleWarMode")

	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	
	CreateWindow("MenuBarWindowMinimized",false)
	
	ButtonSetStayDownFlag("MenuBarWindowWarButton", true)
	ButtonSetStayDownFlag("MenuBarWindowMinimizedWarButton", true)
	
	WindowUtils.RestoreWindowPosition("MenuBarWindow", nil, nil, true)
	
	if not (SystemData.Settings.Interface.menuMode == MenuBarWindow.MAXIMIZED or
			SystemData.Settings.Interface.menuMode == MenuBarWindow.MINIMIZED) then
		SystemData.Settings.Interface.menuMode = MenuBarWindow.MAXIMIZED
	end
	
	MenuBarWindow.SetWindowState(SystemData.Settings.Interface.menuMode)
	WindowSetShowing("MenuBarWindowTogglePaperdoll", false)
	WindowSetShowing("MenuBarWindowToggleVirtues", false)
	
	--WindowSetShowing("MenuBarWindowToggleQuests", false)
	WindowSetShowing("MenuBarWindowToggleGuild", false)
	WindowSetShowing("MenuBarWindowToggleChat", false)
	WindowSetShowing("MenuBarWindowToggleMap", false)
	SnapUtils.SnappableWindows["MenuBarWindowMinimized"] = true
	SnapUtils.SnappableWindows["MenuBarWindow"] = true
end

function MenuBarWindow.Shutdown()
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
	
	if (MenuBarWindow.CurState == MenuBarWindow.MINIMIZED) then
		WindowUtils.CopyScreenPosition("MenuBarWindowMinimized", "MenuBarWindow", -1 * MenuBarWindow.MinimizedOffset * InterfaceCore.scale, 0 )
	end
	
	WindowUtils.SaveWindowPosition("MenuBarWindow")
	SnapUtils.SnappableWindows["MenuBarWindow"] = nil
	SnapUtils.SnappableWindows["MenuBarWindowMinimized"] = nil
end

----------------------------------------------------------------
-- Menu Bar Functions
----------------------------------------------------------------

function MenuBarWindow.SetWindowState(newState)
	--Debug.Print("MenuBarWindow.SetWindowState("..newState..")")
	
    local curState = MenuBarWindow.CurState
    if( newState == MenuBarWindow.CurState ) then
        return
    end
	
    local offset
    if( newState == MenuBarWindow.MAXIMIZED ) then
        offset = -1 * MenuBarWindow.MinimizedOffset * InterfaceCore.scale		
    else
        offset = MenuBarWindow.MinimizedOffset * InterfaceCore.scale
    end
    
	-- hide the current window, copy window coordinates to the new window and adjust the new coordinates if necessary,
	-- then show the window again
    WindowSetShowing(MenuBarWindow.WindowStates[curState],false)
    WindowUtils.CopyScreenPosition(MenuBarWindow.WindowStates[curState],MenuBarWindow.WindowStates[newState],offset,0)
	local newWindowPosX, newWindowPosY = WindowGetScreenPosition(MenuBarWindow.WindowStates[newState])
	
	-- if maximized over the left edge of the screen, push the window to the right a bit
    if (newState == MenuBarWindow.MAXIMIZED and newWindowPosX < 0) then
		WindowUtils.CopyScreenPosition(MenuBarWindow.WindowStates[newState],MenuBarWindow.WindowStates[newState],-newWindowPosX,0)
    end
	
    WindowSetShowing(MenuBarWindow.WindowStates[newState],true)    
    
    MenuBarWindow.CurState = newState
	SystemData.Settings.Interface.menuMode = newState
end

function MenuBarWindow.ToggleWindowState()
	--Debug.Print("MenuBarWindow.ToggleWindowState("..newState..")")
	if( MenuBarWindow.CurState == MenuBarWindow.MAXIMIZED ) then
		MenuBarWindow.SetWindowState(MenuBarWindow.MINIMIZED)
	else
		MenuBarWindow.SetWindowState(MenuBarWindow.MAXIMIZED)
	end
end

function MenuBarWindow.OnRButtonUp()
	if (MenuBarWindow.Locked ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Unlock",0,"unlock",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Lock",0,"lock",2,false)
	end
	ContextMenu.ActivateLuaContextMenu(MenuBarWindow.ContextMenuCallbackLock)
end

function MenuBarWindow.ContextMenuCallbackLock( returnCode, param )
	if ( returnCode=="lock" ) then
		MenuBarWindow.Locked = true
		CustomSettings.SaveBoolean( "MenuBarWindowLock", true )
		ChatWindow.Print(L"Menu Bar LOCKED!")
	elseif ( returnCode=="unlock" ) then
		MenuBarWindow.Locked = false
		CustomSettings.SaveBoolean( "MenuBarWindowLock", false )
		ChatWindow.Print(L"Menu Bar UNLOCKED!")
	end
end

function MenuBarWindow.GetData()
    local windowName = SystemData.ActiveWindow.name
    return MenuBarWindow.MenuBarData[windowName]
end

function MenuBarWindow.OnMouseoverMenuBtn()
	data = MenuBarWindow.GetData()
	btnName = SystemData.ActiveWindow.name
	
	if data ~= nil then

		if (type(data.ToolTipTid) ~= "wstring") then
			text = GetStringFromTid(data.ToolTipTid)
		else
			text = data.ToolTipTid
		end
		Tooltips.CreateTextOnlyTooltip(btnName, text)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	else
		--Debug.Print(L"Tooltip data was nil")
	end 
end

function MenuBarWindow.ToggleMenuButton()	
	--Debug.Print( L"Called MenuBarWindow.ToggleMenuButton()" )

	local enabled = 0
	local active = 0
	
	
	
	
	
	enabled = 0
	if ( SystemData.Settings.Sound.master.enabled ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Sound",0,"disableSound",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Sound",0,"enableSound",2,false)
	end
	
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)

	

	enabled = 0
	if ( EnhancePack.EnableDblClickHotbar ) then
		enabled = 1
	end
		
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Use Single Click for Hotbars",0,"disableDblclk",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Use Double Click for Hotbars",0,"enableDblclk",2,false)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	

	
	enabled = 0
	active = 0
	if ( EnhancePack.ShowSpellName ) then
		enabled = 1
	end
	
	if (EnhancePack.SadMode) then
		active = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Overhead Spell Names",active,"disableSpellname",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Overhead Spell Names",active,"enableSpellname",2,false)
	end
	
	enabled = 0
	if ( not EnhancePack.DisableSpells ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Overhead Spells",0,"disableSpell",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Overhead Spells",0,"enableSpell",2,false)
	end
	
	
	enabled = 0
	if ( EnhancePack.BlockOthersPaperdoll ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Block Others Paperdoll",0,"disablepaper",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Block Others Paperdoll",0,"enablepaper",2,false)
	end
	
	enabled = 0
	if ( MobileHealthBar.CloseStyle ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Healthbar Old Close",0,"disableOldHealth",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Healthbar Old Close",0,"enableOldHealth",2,false)
	end
	
	enabled = 0
	if ( MobileHealthBar.PetCloseStyle ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Pet Healthbar Old Close",0,"disablePetOldHealth",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Pet Healthbar Old Close",0,"enablePetOldHealth",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.HealthBarWod ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable WoD on Healthbars",0,"disableWOD",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable WoD on Healthbars",0,"enableWOD",2,false)
	end
	
	
	enabled = 0
	if ( EnhancePack.ToggleYouSee ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable You See Message",0,"disableYouSee",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable You See Message",0,"enableYouSee",2,false)
	end
	
	enabled = 0
	if ( StatusWindow.AuraEnabled) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Notoriety Aura",0,"disableNoto",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Notoriety Aura",0,"enableNoto",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.ToggleBloodOath ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Auto-Toggle War Mode",0,"disableBlood",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Auto-Toggle War Mode",0,"enableBlood",2,false)
	end
	
	
	
	
	enabled = 0
	if (  EnhancePack.GoldLootBag) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Looted Gold Goes On Backpack",0,"disableGold",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Looted Gold Goes On Loot Bag",0,"enableGold",2,false)
	end
	
	enabled = 0
	if (  EnhancePack.EnableAutoIgnoreCorpses) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Auto-Ignore Corpses",0,"disableAutoIgnore",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Auto-Ignore Corpses",0,"enableAutoIgnore",2,false)
	end

	ContextMenu.CreateLuaContextMenuItemWithString(L"Clear Ignore List",0,"clearIgnore",2,false)
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	enabled = 0
	active = 0
	if ( SystemData.Settings.Interface.LegacyContainers ) then
		enabled = 1
		active = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Legacy Containers",0,"disableLegacy",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Legacy Containers",0,"enableLegacy",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.GridLegacy ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Grid Legacy Containers",active,"disableGridLegacy",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Grid Legacy Containers",active,"enableGridLegacy",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.EnableContainerGrid ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Grid on Containers",active,"disableGrid",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Grid on Containers",active,"enableGrid",2,false)
	end
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	
	enabled = 0
	active = 1
	if ( EnhancePack.DiabloHealthEnable ) then
		enabled = 1
		active = 0
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable  Diablo Healthbars",0,"disableDiablo",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable  Diablo Healthbars",0,"enableDiablo",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.DiabloHealthNumbersEnable ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Health Numbers",active,"disableDiabloNum",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Diablo Health Numbers",active,"enableDiabloNum",2,false)
	end
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
			
		
	local enabled2 = 0
	if ( EnhancePack.ToggleExtraInfo ) then
		enabled2 = 1
	end
	
	if (enabled2 == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Extra Properties Info",0,"disableExtra",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Extra Properties Info",0,"enableExtra",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.IntensityInfo ) then
		enabled = 1
	end
	
	if (enabled2 == 1) then
		active = 0
	else
		active = 1
	end
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Item Intensity Info",active,"disableIntens",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Item Intensity Info",active,"enableIntens",2,false)
	end
	

	
	subMenu = {
			{ str = L"Current",flags=0,returnCode="null",pressed=false,textColor=EnhancePack.EXTRAINFO },
			{ str = L"",flags=0,returnCode="null",pressed=false,textColor=EnhancePack.ENGRAVE_COLOR },
			{ str = L"Red",flags=0,returnCode="colorRed",pressed=false, textColor={r=255, g=0, b=0} },
			{ str = L"Green",flags=0,returnCode="colorGreen",pressed=false, textColor={r=0, g=255, b=0} },
			{ str = L"Blue",flags=0,returnCode="colorBlue",pressed=false,textColor={r=0, g=0, b=255} },
			{ str = L"Yellow",flags=0,returnCode="colorYellow",pressed=false,textColor={r=255, g=255, b=0} },
			{ str = L"Aqua",flags=0,returnCode="colorAqua",pressed=false,textColor={r=0, g=255, b=255} },
			{ str = L"Pink",flags=0,returnCode="colorPink",pressed=false,textColor={r=255, g=0, b=255} },
			{ str = L"White",flags=0,returnCode="colorWhite",pressed=false,textColor={r=255, g=255, b=255} }
			}
	if (enabled2 == 1) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Set Extra Info Color",0,0,"null",false,subMenu)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Set Extra Info Color",1,0,"null",false)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Reset To Default Settings",0,"Reset",2,false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Main Menu",0,"showMain",2,false)
	
	ContextMenu.ActivateLuaContextMenu(MenuBarWindow.ContextMenuCallback)
	
	
	local scaleFactor = 1/0.65
	
	local cmWidth, cmHeight = WindowGetDimensions("ContextMenu")

	WindowSetScale("ContextMenu", 0.65)
	
	
	
	
	local cmWindowX = 0
	local mouseX = SystemData.MousePosition.x
	if mouseX + (cmWidth / scaleFactor) > SystemData.screenResolution.x then
		cmWindowX = mouseX - (cmWidth / scaleFactor)
	else
		cmWindowX = mouseX
	end
		
	local mouseY = SystemData.MousePosition.y
	local cmWindowY = mouseY
	if mouseY + (cmHeight / scaleFactor) > SystemData.screenResolution.y then
		cmWindowY = mouseY - (cmHeight / scaleFactor)
	else
		cmWindowY = mouseY
	end
	
	WindowSetOffsetFromParent("ContextMenu", cmWindowX * scaleFactor, cmWindowY * scaleFactor)	
	
end
function MenuBarWindow.getPos(pos)
	if (pos == EnhancePack.CenterScreenPosition) then
		return 1
	end
	return 0
end
function MenuBarWindow.CustomizeMenu()
	local active = 0
	if (EnhancePack.AuraSpeed == 0) then
		active = 1
	end
	local active1 = 0
	if (EnhancePack.AuraSpeed == 10) then
		active1 = 1
	end
	local active2 = 0
	if (EnhancePack.AuraSpeed == 20) then
		active2 = 1
	end
	local subMenu = {
			{ str = L"Static",flags=active ,returnCode="auraStatic",pressed=false},
			{ str = L"Normal",flags=active1,returnCode="auraNormal",pressed=false},
			{ str = L"Fast",flags=active2,returnCode="auraFast",pressed=false}
			}
	active = 1
	if (StatusWindow.AuraEnabled) then
		active = 0
	end

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Aura Speed",active,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	enabled = 0
	if ( EnhancePack.ToggleScale ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Scale Mode",0,"disableScale",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Scale Mode",0,"enableScale",2,false)
	end
	
	enabled = 0
	if (  EnhancePack.EnableSnapping) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Windows Snap",0,"disableSnap",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Windows Snap",0,"enableSnap",2,false)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	subMenu = {
			{ str = L"Normal",flags=0 ,returnCode="objNormal",pressed=EnhancePack.ObjectHandleScale == InterfaceCore.scale},
			{ str = L"Medium",flags=0,returnCode="objMedium",pressed=EnhancePack.ObjectHandleScale == InterfaceCore.scale * 0.8},
			{ str = L"Small",flags=0,returnCode="objSmall",pressed=EnhancePack.ObjectHandleScale == (InterfaceCore.scale * 2 )/3}
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Object Handle Size",0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = L"Dull",flags=0 ,returnCode="objDull",pressed=EnhancePack.ObjectHandleAlpha == 1},
			{ str = L"Half-Dull",flags=0,returnCode="objHalfTransp",pressed=EnhancePack.ObjectHandleAlpha == 0.6},
			{ str = L"Transparent",flags=0,returnCode="objTransp",pressed=EnhancePack.ObjectHandleAlpha == 0.4}
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Object Handle Opacity",0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	subMenu = {
			{ str = L"Center",flags=MenuBarWindow.getPos(1) ,returnCode="center1",pressed=false},
			{ str = L"Top",flags=MenuBarWindow.getPos(2),returnCode="center2",pressed=false},
			{ str = L"Bottom",flags=MenuBarWindow.getPos(3),returnCode="center3",pressed=false},
			{ str = L"Left",flags=MenuBarWindow.getPos(4),returnCode="center4",pressed=false},
			{ str = L"Right",flags=MenuBarWindow.getPos(5),returnCode="center5",pressed=false}
			}
	if (WindowGetShowing("MainCenterScreenTexture")) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Centerscreen Text Position",1,0,"null",false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Centerscreen Text Position",0,0,"null",false,subMenu)
	end
	
	subMenu = {
			{ str = L"20%",flags=0,returnCode="HP20",pressed=EnhancePack.LowHPPerc == 20 },
			{ str = L"30%",flags=0,returnCode="HP30",pressed=EnhancePack.LowHPPerc == 30 },
			{ str = L"40%",flags=0,returnCode="HP40",pressed=EnhancePack.LowHPPerc == 40 },
			{ str = L"50%",flags=0,returnCode="HP50",pressed=EnhancePack.LowHPPerc == 50 },
			{ str = L"60%",flags=0,returnCode="HP60",pressed=EnhancePack.LowHPPerc == 60 },
			{ str = L"Disabled",flags=0,returnCode="HPdisable",pressed=EnhancePack.LowHPPercDisabled }
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Centerscreen Text Low HP %",0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = L"20%",flags=0,returnCode="PHP20",pressed=EnhancePack.LowPETHPPerc == 20 },
			{ str = L"30%",flags=0,returnCode="PHP30",pressed=EnhancePack.LowPETHPPerc == 30 },
			{ str = L"40%",flags=0,returnCode="PHP40",pressed=EnhancePack.LowPETHPPerc == 40 },
			{ str = L"50%",flags=0,returnCode="PHP50",pressed=EnhancePack.LowPETHPPerc == 50 },
			{ str = L"60%",flags=0,returnCode="PHP60",pressed=EnhancePack.LowPETHPPerc == 60 },
			{ str = L"Ignore Summons",flags=0,returnCode="IgnoreSummons",pressed=EnhancePack.EnableIgnoreSummons },
			{ str = L"Disabled",flags=0,returnCode="HPPETdisable",pressed=EnhancePack.LowHPPETPercDisabled }
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Centerscreen Text Pet Low HP %",0,0,"null",false,subMenu)

	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Overhead Chat Font",0,"setFont",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Overhead Names Font",0,"setNameFont",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Overhead Spells Font",0,"setSpellFont",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Overhead Damage Font",0,"setDamageFont",2,false)
	
	enabled = 0
	if ( EnhancePack.SadMode ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Sad Mode",0,"disableSad",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Sad Mode",0,"enableSad",2,false)
	end
	
	subMenu = {
			{ str = L"Set Default Name Color",flags=0,returnCode="colorDefault",pressed=false, textColor=EnhancePack.TITLE_COLOR },
			{ str = L"Set Default Mods Color",flags=0,returnCode="colorMods",pressed=false, textColor=EnhancePack.BODY_COLOR },
			{ str = L"Set Engrave Color",flags=0,returnCode="colorEngrave",pressed=false,textColor=EnhancePack.ENGRAVE_COLOR },
			{ str = L"Set Artifacts Color",flags=0,returnCode="colorArti",pressed=false, textColor=EnhancePack.ARTIFACT_COLOR },
			{ str = L"Set Sets Color",flags=0,returnCode="colorSet",pressed=false,textColor=EnhancePack.SET_COLOR },
			{ str = L"Set Alert Color",flags=0,returnCode="colorAlert",pressed=false,textColor=EnhancePack.ALERT_COLOR},
			{ str = L"Set Danger Color",flags=0,returnCode="colorDanger",pressed=false,textColor=EnhancePack.DANGER_COLOR},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Set Physical Color",flags=0,returnCode="colorPhys",pressed=false,textColor=EnhancePack.PHYSICAL},
			{ str = L"Set Fire Color",flags=0,returnCode="colorFire",pressed=false,textColor=EnhancePack.FIRE},
			{ str = L"Set Cold Color",flags=0,returnCode="colorCold",pressed=false,textColor=EnhancePack.COLD},
			{ str = L"Set Poison Color",flags=0,returnCode="colorPois",pressed=false,textColor=EnhancePack.POISON},
			{ str = L"Set Energy Color",flags=0,returnCode="colorEner",pressed=false,textColor=EnhancePack.ENERGY}, 
			{ str = L"Set Chaos Color",flags=0,returnCode="colorChaos",pressed=false,textColor=EnhancePack.Chaos},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Set Healing Color",flags=0,returnCode="colorHeal",pressed=false,textColor=EnhancePack.Heal},
			{ str = L"Set Curse Color",flags=0,returnCode="colorCurse",pressed=false,textColor=EnhancePack.Curse},
			{ str = L"Set Paralyze Color",flags=0,returnCode="colorPara",pressed=false,textColor=EnhancePack.Paralyze},
			{ str = L"Set Neutral Color",flags=0,returnCode="colorNeutral",pressed=false,textColor=EnhancePack.Neutral},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Set Overhead Negative Color",flags=0,returnCode="colorNeg",pressed=false,textColor=EnhancePack.OverHeadError},
			{ str = L"Set Overhead Positive Color",flags=0,returnCode="colorPos",pressed=false,textColor=EnhancePack.SpecialColor},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.YOUGETAMAGE_COLOR },
			{ str = L"You take damage",flags=0,returnCode="colorYou",pressed=false,textColor=EnhancePack.YOUGETAMAGE_COLOR},
			{ str = L"Your pet take damage",flags=0,returnCode="colorPet",pressed=false,textColor=EnhancePack.PETGETDAMAGE_COLOR},
			{ str = L"Enemy take damage",flags=0,returnCode="colorEnemy",pressed=false,textColor=EnhancePack.OTHERGETDAMAGE_COLOR}	}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Text Colors",0,0,"null",false,subMenu)
	
	local flagP = 0
	local flagM = 0
	if (EnhancePack.OverhedTextSize <= 0.5) then
		flagM = 1
	end
	if (EnhancePack.OverhedTextSize >= 1.5) then
		flagP = 1
	end
	subMenu = {
			{ str = L"Decrease Size",flags=flagM,returnCode="txtLessSize",pressed=false },
			{ str = L"Increase Size",flags=flagP,returnCode="txtMoreSize",pressed=false}
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Text Size",0,0,"null",false,subMenu)
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	subMenu = {
			{ str = L"Countdown Timer",flags=0,returnCode="colorHBCountdown",pressed=false, textColor=HotbarSystem.CountdownTimer },
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Direct Button",flags=0,returnCode="colorHBPlain",pressed=false, textColor=HotbarSystem.Plain },
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Control + Button",flags=0,returnCode="colorHBControl",pressed=false,textColor=HotbarSystem.Control },
			{ str = L"Alt + Button",flags=0,returnCode="colorHBAlt",pressed=false, textColor=HotbarSystem.Alt },
			{ str = L"Shift + Button",flags=0,returnCode="colorHBShift",pressed=false,textColor=HotbarSystem.Shift },
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Control + Alt + Button",flags=0,returnCode="colorHBCtrlalt",pressed=false,textColor=HotbarSystem.ControlAlt},
			{ str = L"Control + Shift + Button",flags=0,returnCode="colorHBCtrlShift",pressed=false,textColor=HotbarSystem.ControlShift},
			{ str = L"Alt + Shift + Button",flags=0,returnCode="colorHBAltShift",pressed=false,textColor=HotbarSystem.AltShift},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Control + Alt + Shift + Button",flags=0,returnCode="colorHBCtrlAltShift",pressed=false,textColor=HotbarSystem.ControlAltShift}	}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Hotbar Text Colors",0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = L"Target Current",flags=0,returnCode="colorHBCurrent",pressed=false, textColor=HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] },
			{ str = L"Target Self",flags=0,returnCode="colorHBSelf",pressed=false, textColor=HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF] },
			{ str = L"Target Cursor",flags=0,returnCode="colorHBCursor",pressed=false,textColor=HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
			{ str = L"Target Stored",flags=0,returnCode="colorHBStored",pressed=false, textColor=HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] }	}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Hotbar Target Colors",0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Hotbar Border Color",0,"colorHBBorder",false,nil,nil,nil, HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE])
	
	subMenu = {
			{ str = L"1",flags=0,returnCode="1",pressed=HotbarSystem.DefaultSlots == 1},
			{ str = L"2",flags=0,returnCode="2",pressed=HotbarSystem.DefaultSlots == 2},
			{ str = L"3",flags=0,returnCode="3",pressed=HotbarSystem.DefaultSlots == 3},
			{ str = L"4",flags=0,returnCode="4",pressed=HotbarSystem.DefaultSlots == 4 },
			{ str = L"5",flags=0,returnCode="5",pressed=HotbarSystem.DefaultSlots == 5 },
			{ str = L"6",flags=0,returnCode="6",pressed=HotbarSystem.DefaultSlots == 6},
			{ str = L"7",flags=0,returnCode="7",pressed=HotbarSystem.DefaultSlots == 7},
			{ str = L"8",flags=0,returnCode="8",pressed=HotbarSystem.DefaultSlots == 8},
			{ str = L"9",flags=0,returnCode="9",pressed=HotbarSystem.DefaultSlots == 9},
			{ str = L"10",flags=0,returnCode="10",pressed=HotbarSystem.DefaultSlots == 10},
			{ str = L"11",flags=0,returnCode="11",pressed=HotbarSystem.DefaultSlots == 11},
			{ str = L"12",flags=0,returnCode="12",pressed=HotbarSystem.DefaultSlots == 12}	}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Default Hotbar Slots Number",0,0,"null",false,subMenu)
	

	subMenu = {
			{ str = L"Horizontal",flags=0,returnCode="horiz",pressed=HotbarSystem.DefHorizontal},
			{ str = L"Vertical",flags=0,returnCode="vert",pressed=not HotbarSystem.DefHorizontal}
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Default Hotbar Orientation",0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Extra Bright Containers",0,"extraBright",2,EnhancePack.ExtraBrightContainers)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Default Container Grid color",0,"colorGrid",false,nil,nil,nil, EnhancePack.BaseGridColor)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Alternate Grid Color",0,"altergrid",2,EnhancePack.AlternateGrid)
	
	enabled = 0
	
	if (not EnhancePack.AlternateGrid) then
		enabled = 1
	end
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Alternate Grid Color",enabled,"colorGridAlter",false,nil,nil,nil, EnhancePack.AlternateBackpack)
	

	if (EnhancePack.LockChatLine) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Unlock Chat Line",0,"unlockChat",2,false)
	else
		
		ContextMenu.CreateLuaContextMenuItemWithString(L"Lock Chat Line To Game Area",0,"lockChat",2,false)
	end
	
	ContextMenu.ActivateLuaContextMenu(MenuBarWindow.ContextMenuCallback)
	
	
	local scaleFactor = 1/0.7
	
	local cmWidth, cmHeight = WindowGetDimensions("ContextMenu")

	WindowSetScale("ContextMenu", 0.7)
	
	
	
	
	local cmWindowX = 0
	local mouseX = SystemData.MousePosition.x
	if mouseX + (cmWidth / scaleFactor) > SystemData.screenResolution.x then
		cmWindowX = mouseX - (cmWidth / scaleFactor)
	else
		cmWindowX = mouseX
	end
		
	local mouseY = SystemData.MousePosition.y
	local cmWindowY = mouseY
	if mouseY + (cmHeight / scaleFactor) > SystemData.screenResolution.y then
		cmWindowY = mouseY - (cmHeight / scaleFactor)
	else
		cmWindowY = mouseY
	end
	
	WindowSetOffsetFromParent("ContextMenu", cmWindowX * scaleFactor, cmWindowY * scaleFactor)	
end


function MenuBarWindow.ContextMenuCallback( returnCode, param )	
	MenuBarWindow.HuePickerWindowRequest= returnCode
	local text = string.find(MenuBarWindow.HuePickerWindowRequest, "color")
	if (text and not( returnCode == "colorRed" or returnCode=="colorGreen" or returnCode=="colorBlue" or returnCode=="colorYellow" or returnCode=="colorAqua" or returnCode=="colorPink" or returnCode=="colorWhite")) then
		local defaultColors = {
		0, --HUE_NONE 
		34, --HUE_RED
		53, --HUE_YELLOW
		63, --HUE_GREEN
		89, --HUE_BLUE
		119, --HUE_PURPLE
		144, --HUE_ORANGE
		368, --HUE_GREEN_2
		946, --HUE_GREY
		}
		local hueTable = {}
		for idx, hue in pairs(defaultColors) do
			for i=0,8 do
				hueTable[(idx-1)*10+i+1] = hue+i
			end
		end
		local Brightness = 1
		CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )
		WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)
		ColorPickerWindow.SetNumColorsPerRow(9)
		ColorPickerWindow.SetSwatchSize(30)
		ColorPickerWindow.SetWindowPadding(4,4)
		ColorPickerWindow.SetFrameEnabled(true)
		ColorPickerWindow.SetCloseButtonEnabled(true)
		ColorPickerWindow.SetColorTable(hueTable,"ColorPicker")
		ColorPickerWindow.DrawColorTable("ColorPicker")
		ColorPickerWindow.SetAfterColorSelectionFunction(MenuBarWindow.ColorPicked)
		local w, h = WindowGetDimensions("ColorPicker")
		WindowAddAnchor( "ColorPicker", "topleft", "MenuBarWindow", "topleft", 50, -h)
		ColorPickerWindow.SetFrameEnabled(false)
		WindowSetShowing( "ColorPicker", true )
		ColorPickerWindow.SelectColor("ColorPicker", 1)
	end

	if ( returnCode=="enableBlood" ) then
		EnhancePack.ToggleBloodOath = true
		CustomSettings.SaveBoolean( "EnhancePackToggleBloodOath", EnhancePack.ToggleBloodOath )
	elseif(returnCode=="disableBlood") then
		EnhancePack.ToggleBloodOath = false
		CustomSettings.SaveBoolean( "EnhancePackToggleBloodOath", EnhancePack.ToggleBloodOath )
		
	elseif(returnCode=="lockChat") then
		EnhancePack.LockChatLine = true
		CustomSettings.SaveBoolean( "EnhancePackLockChatLine" , EnhancePack.LockChatLine )
		InterfaceCore.ReloadUI()
	elseif(returnCode=="unlockChat") then
		EnhancePack.LockChatLine = false
		CustomSettings.SaveBoolean( "EnhancePackLockChatLine" , EnhancePack.LockChatLine )
		InterfaceCore.ReloadUI()
	elseif(returnCode=="horiz") then
		HotbarSystem.DefHorizontal = true
		CustomSettings.SaveBoolean( "HotbarSystemDefHorizontal" , HotbarSystem.DefHorizontal )
	elseif(returnCode=="vert") then
		HotbarSystem.DefHorizontal = false
		CustomSettings.SaveBoolean( "HotbarSystemDefHorizontal" , HotbarSystem.DefHorizontal )
	elseif(type(tonumber(returnCode)) == "number") then
		HotbarSystem.DefaultSlots = tonumber(returnCode)
		CustomSettings.SaveNumber( "HotbarSystemDefaultSlots" , HotbarSystem.DefaultSlots )
		
	elseif (returnCode=="altergrid") then
		EnhancePack.AlternateGrid = not EnhancePack.AlternateGrid
		CustomSettings.SaveBoolean( "EnhancePackAlternateGrid",EnhancePack.AlternateGrid )
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
	elseif (returnCode=="extraBright") then
		EnhancePack.ExtraBrightContainers = not EnhancePack.ExtraBrightContainers
		CustomSettings.SaveBoolean( "EnhancePackExtraBrightContainers",EnhancePack.ExtraBrightContainers )
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
		
	elseif(returnCode=="disableSnap") then
		EnhancePack.EnableSnapping = false
		CustomSettings.SaveBoolean( "EnhancePackEnableSnapping", EnhancePack.EnableSnapping )
	elseif(returnCode=="enableSnap") then
		EnhancePack.EnableSnapping = true
		CustomSettings.SaveBoolean( "EnhancePackEnableSnapping", EnhancePack.EnableSnapping )
		
	elseif(returnCode=="disableGold") then
		EnhancePack.GoldLootBag = false
		CustomSettings.SaveBoolean( "EnhancePackGoldLootBag", EnhancePack.GoldLootBag )
	elseif(returnCode=="enableGold") then
		EnhancePack.GoldLootBag = true
		CustomSettings.SaveBoolean( "EnhancePackGoldLootBag", EnhancePack.GoldLootBag )
		
	elseif(returnCode=="disableAutoIgnore") then
		EnhancePack.EnableAutoIgnoreCorpses = false
		CustomSettings.SaveBoolean( "EnhancePackEnableAutoIgnoreCorpses", EnhancePack.EnableAutoIgnoreCorpses )
	elseif(returnCode=="enableAutoIgnore") then
		EnhancePack.EnableAutoIgnoreCorpses = true
		CustomSettings.SaveBoolean( "EnhancePackEnableAutoIgnoreCorpses", EnhancePack.EnableAutoIgnoreCorpses )
	
	elseif(returnCode=="disablepaper") then
		EnhancePack.BlockOthersPaperdoll = false
		CustomSettings.SaveBoolean( "EnhancePackBlockOthersPaperdoll", EnhancePack.BlockOthersPaperdoll )
	elseif(returnCode=="enablepaper") then
		EnhancePack.BlockOthersPaperdoll = true
		CustomSettings.SaveBoolean( "EnhancePackBlockOthersPaperdoll", EnhancePack.BlockOthersPaperdoll )
	
	elseif(returnCode=="disableOldHealth") then
		MobileHealthBar.CloseStyle = false
		CustomSettings.SaveBoolean( "MobileHealthBarCloseStyle", MobileHealthBar.CloseStyle )
	elseif(returnCode=="enableOldHealth") then
		MobileHealthBar.CloseStyle = true
		CustomSettings.SaveBoolean( "MobileHealthBarCloseStyle", MobileHealthBar.CloseStyle )
		
	elseif(returnCode=="disablePetOldHealth") then
		MobileHealthBar.PetCloseStyle = false
		CustomSettings.SaveBoolean( "MobileHealthBarPetCloseStyle", MobileHealthBar.PetCloseStyle )
	elseif(returnCode=="enablePetOldHealth") then
		MobileHealthBar.PetCloseStyle = true
		CustomSettings.SaveBoolean( "MobileHealthBarPetCloseStyle", MobileHealthBar.PetCloseStyle )
	
	elseif(returnCode=="disableWOD") then
		EnhancePack.HealthBarWod = false
		CustomSettings.SaveBoolean( "EnhancePackHealthBarWod", EnhancePack.HealthBarWod )
		for key, value in pairs(MobileHealthBar.hasWindow) do
			MobileHealthBar.UpdateStatus(key)
		end
	elseif(returnCode=="enableWOD") then
		EnhancePack.HealthBarWod = true
		CustomSettings.SaveBoolean( "EnhancePackHealthBarWod", EnhancePack.HealthBarWod )
		for key, value in pairs(MobileHealthBar.hasWindow) do
			MobileHealthBar.UpdateStatus(key)
		end
		
		
	elseif(returnCode=="clearIgnore") then
		EnhancePack.IgnoreItems = {}		
	
	elseif(returnCode=="colorRed") then
		EnhancePack.EXTRAINFO ={r=255, g=0, b=0}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorGreen") then
		EnhancePack.EXTRAINFO ={r=0, g=255, b=0} 
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorBlue") then
		EnhancePack.EXTRAINFO ={r=0, g=0, b=255} 
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorYellow") then
		EnhancePack.EXTRAINFO ={r=255, g=255, b=0}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorAqua") then
		EnhancePack.EXTRAINFO ={r=0, g=255, b=255} 
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorPink") then
		EnhancePack.EXTRAINFO ={r=255, g=0, b=255}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorWhite") then
		EnhancePack.EXTRAINFO ={r=255, g=255, b=255}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
		
	elseif ( returnCode=="HP20" ) then
		EnhancePack.LowHPPerc = 20
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HP30" ) then
		EnhancePack.LowHPPerc = 30
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HP40" ) then
		EnhancePack.LowHPPerc = 40
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HP50" ) then
		EnhancePack.LowHPPerc = 50
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HP60" ) then
		EnhancePack.LowHPPerc = 60
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HPdisable" ) then
		EnhancePack.LowHPPercDisabled = not EnhancePack.LowHPPercDisabled
		CustomSettings.SaveBoolean( "EnhancePackLowHPPercDisabled",EnhancePack.LowHPPercDisabled )
		WindowSetShowing("MainCenterScreenTexture",false)
		
	elseif ( returnCode=="PHP20" ) then
		EnhancePack.LowPETHPPerc = 20
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="PHP30" ) then
		EnhancePack.LowPETHPPerc = 30
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="PHP40" ) then
		EnhancePack.LowPETHPPerc = 40
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="PHP50" ) then
		EnhancePack.LowPETHPPerc = 50
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="PHP60" ) then
		EnhancePack.LowPETHPPerc = 60
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="IgnoreSummons" ) then
		EnhancePack.EnableIgnoreSummons = not EnhancePack.EnableIgnoreSummons
		CustomSettings.SaveBoolean( "EnhancePackEnableIgnoreSummons", EnhancePack.EnableIgnoreSummons  )
	elseif ( returnCode=="HPPETdisable" ) then
		EnhancePack.LowHPPETPercDisabled = not EnhancePack.LowHPPETPercDisabled
		CustomSettings.SaveBoolean( "EnhancePackLowHPPETPercDisabled",EnhancePack.LowHPPETPercDisabled )	
		WindowSetShowing("MainCenterScreenTexture",false)
		
	elseif ( returnCode=="disableSad" ) then
		EnhancePack.SadMode =  false
		CustomSettings.SaveBoolean( "EnhancePackSadMode", EnhancePack.SadMode  )
	elseif ( returnCode=="enableSad" ) then
		EnhancePack.ShowSpellName = false
		CustomSettings.SaveBoolean( "EnhancePackShowSpellName", EnhancePack.ShowSpellName )
		EnhancePack.SadMode = true
		CustomSettings.SaveBoolean( "EnhancePackSadMode", EnhancePack.SadMode  )
		
	elseif(returnCode=="center1") then
		EnhancePack.CenterScreenPosition = 1
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
	elseif(returnCode=="center2") then
		EnhancePack.CenterScreenPosition = 2
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
	elseif(returnCode=="center3") then
		EnhancePack.CenterScreenPosition = 3
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
	elseif(returnCode=="center4") then
		EnhancePack.CenterScreenPosition = 4
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
	elseif(returnCode=="center5") then
		EnhancePack.CenterScreenPosition = 5
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
		
		
	elseif(returnCode=="auraStatic") then
		EnhancePack.AuraSpeed = 0
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
	elseif(returnCode=="auraNormal") then
		EnhancePack.AuraSpeed = 10
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
	elseif(returnCode=="auraFast") then
		EnhancePack.AuraSpeed = 20
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
		
	elseif(returnCode=="objNormal") then
		EnhancePack.ObjectHandleScale = InterfaceCore.scale
		CustomSettings.SaveNumber( "EnhancePackObjectHandleScale" , EnhancePack.ObjectHandleScale )
	elseif(returnCode=="objMedium") then
		EnhancePack.ObjectHandleScale = InterfaceCore.scale * 0.8
		CustomSettings.SaveNumber( "EnhancePackObjectHandleScale" , EnhancePack.ObjectHandleScale )
	elseif(returnCode=="objSmall") then
		EnhancePack.ObjectHandleScale = (InterfaceCore.scale * 2 )/3
		CustomSettings.SaveNumber( "EnhancePackObjectHandleScale" , EnhancePack.ObjectHandleScale )	
		
		
	elseif(returnCode=="objDull") then
		EnhancePack.ObjectHandleAlpha = 1
		CustomSettings.SaveNumber( "EnhancePackObjectHandleAlpha" , EnhancePack.ObjectHandleAlpha )
	elseif(returnCode=="objHalfTransp") then
		EnhancePack.ObjectHandleAlpha = 0.6
		CustomSettings.SaveNumber( "EnhancePackObjectHandleAlpha" , EnhancePack.ObjectHandleAlpha )
	elseif(returnCode=="objTransp") then
		EnhancePack.ObjectHandleAlpha = 0.4
		CustomSettings.SaveNumber( "EnhancePackObjectHandleAlpha" , EnhancePack.ObjectHandleAlpha )
			
	elseif(returnCode=="setFont") then
		
		if (not DoesWindowNameExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.Selection = "chat"
		
		WindowSetShowing(FontSelector.RunicFontItem, false)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Chat Font")
		
		
	elseif(returnCode=="setNameFont") then
		if (not DoesWindowNameExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.Selection = "names"
		WindowSetShowing(FontSelector.RunicFontItem, false)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Names Font")
		
	elseif(returnCode=="txtMoreSize") then
		
		EnhancePack.OverhedTextSize =EnhancePack.OverhedTextSize + 0.1
		
		if (EnhancePack.OverhedTextSize > 1.5) then
			EnhancePack.OverhedTextSize = 1.5
		end
		CustomSettings.SaveNumber("EnhancePackOverhedTextSize", EnhancePack.OverhedTextSize)
		EnhancePack.SendOverheadText(L"TEST Message", 23 , false)
	
	elseif(returnCode=="txtLessSize") then	
		EnhancePack.OverhedTextSize =EnhancePack.OverhedTextSize - 0.1
		if (EnhancePack.OverhedTextSize < 0.5) then
			EnhancePack.OverhedTextSize = 0.5
		end
		CustomSettings.SaveNumber("EnhancePackOverhedTextSize", EnhancePack.OverhedTextSize)
		EnhancePack.SendOverheadText(L"TEST Message", 23 , false)
		
	elseif(returnCode=="setDamageFont") then
		if (not DoesWindowNameExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.Selection = "damage"
		WindowSetShowing(FontSelector.RunicFontItem, false)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Damage Font")
			
	elseif(returnCode=="setSpellFont") then
		if (not DoesWindowNameExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.Selection = "spells"
		WindowSetShowing(FontSelector.RunicFontItem, not EnhancePack.ShowSpellName)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Spells Font")

	elseif(returnCode=="disableScale") then
		EnhancePack.ToggleScale = false
		CustomSettings.SaveBoolean( "EnhancePackToggleScale", EnhancePack.ToggleScale )
	elseif(returnCode=="enableScale") then
		EnhancePack.ToggleScale = true
		CustomSettings.SaveBoolean( "EnhancePackToggleScale", EnhancePack.ToggleScale )
		
	
		
	elseif(returnCode=="disableDblclk") then
		EnhancePack.EnableDblClickHotbar = false
		CustomSettings.SaveBoolean( "EnhancePackEnableDblClickHotbar", EnhancePack.EnableDblClickHotbar )
	elseif(returnCode=="enableDblclk") then
		EnhancePack.EnableDblClickHotbar = true
		CustomSettings.SaveBoolean( "EnhancePackEnableDblClickHotbar", EnhancePack.EnableDblClickHotbar )
		
	elseif(returnCode=="disableSpellname") then
		EnhancePack.ShowSpellName = false
		CustomSettings.SaveBoolean( "EnhancePackShowSpellName", EnhancePack.ShowSpellName )
	elseif(returnCode=="enableSpellname") then
		EnhancePack.ShowSpellName = true
		CustomSettings.SaveBoolean( "EnhancePackShowSpellName", EnhancePack.ShowSpellName )
		if (FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName == "runic") then
			OverheadText.SpellsFontIndex = 1
		end
		
	elseif(returnCode=="disableSpell") then
		EnhancePack.DisableSpells = true
		CustomSettings.SaveBoolean( "EnhancePackDisableSpells", EnhancePack.DisableSpells )
	elseif(returnCode=="enableSpell") then
		EnhancePack.DisableSpells = false
		CustomSettings.SaveBoolean( "EnhancePackDisableSpells", EnhancePack.DisableSpells )
		
		
	elseif(returnCode=="disableExtra") then
		EnhancePack.ToggleExtraInfo = false
		CustomSettings.SaveBoolean( "EnhancePackToggleExtraInfo", EnhancePack.ToggleExtraInfo )
	elseif(returnCode=="enableExtra") then
		EnhancePack.ToggleExtraInfo = true
		CustomSettings.SaveBoolean( "EnhancePackToggleExtraInfo", EnhancePack.ToggleExtraInfo )
		
	elseif(returnCode=="disableIntens") then
		EnhancePack.IntensityInfo = false
		CustomSettings.SaveBoolean( "EnhancePackIntensityInfo", EnhancePack.IntensityInfo )
	elseif(returnCode=="enableIntens") then
		EnhancePack.IntensityInfo = true
		CustomSettings.SaveBoolean( "EnhancePackIntensityInfo", EnhancePack.IntensityInfo )
		
	elseif(returnCode=="disableNoto") then
		StatusWindow.AuraEnabled = false
		 HealthBarManager.HandlePartyMemberUpdate()
		CustomSettings.SaveBoolean( "StatusWindowAuraEnabled", StatusWindow.AuraEnabled )
	elseif(returnCode=="enableNoto") then
		StatusWindow.AuraEnabled = true
		 HealthBarManager.HandlePartyMemberUpdate()
		CustomSettings.SaveBoolean( "StatusWindowAuraEnabled", StatusWindow.AuraEnabled )	
		
	elseif(returnCode=="disableDiablo") then
		EnhancePack.DiabloHealthEnable = false
		CustomSettings.SaveBoolean( "DiabloHealthEnable", EnhancePack.DiabloHealthEnable )
		DiabloHealth.CheckToggle()
	elseif(returnCode=="enableDiablo") then
		EnhancePack.DiabloHealthEnable = true
		CustomSettings.SaveBoolean( "DiabloHealthEnable", EnhancePack.DiabloHealthEnable )
		DiabloHealth.CheckToggle()
		
	elseif(returnCode=="disableDiabloNum") then
		EnhancePack.DiabloHealthNumbersEnable = false
		CustomSettings.SaveBoolean( "DiabloHealthNumbersEnable", EnhancePack.DiabloHealthNumbersEnable )
		DiabloHealth.CheckToggle()
	elseif(returnCode=="enableDiabloNum") then
		EnhancePack.DiabloHealthNumbersEnable = true
		CustomSettings.SaveBoolean( "DiabloHealthNumbersEnable", EnhancePack.DiabloHealthNumbersEnable )
		DiabloHealth.CheckToggle()
		
	elseif(returnCode=="disableYouSee") then
		EnhancePack.ToggleYouSee = false
		CustomSettings.SaveBoolean( "EnhancePackToggleYouSee", EnhancePack.ToggleYouSee )
	elseif(returnCode=="enableYouSee") then
		EnhancePack.ToggleYouSee = true
		CustomSettings.SaveBoolean( "EnhancePackToggleYouSee", EnhancePack.ToggleYouSee)
		
	elseif(returnCode=="disableSound") then
		SystemData.Settings.Sound.master.enabled = false
		UserSettingsChanged()
	elseif(returnCode=="enableSound") then
		SystemData.Settings.Sound.master.enabled = true
		UserSettingsChanged()
		
	elseif(returnCode=="disableLegacy") then
		SystemData.Settings.Interface.LegacyContainers = false
		UserSettingsChanged()
		--DestroyWindow("ContainerWindow_"..EnhancePack.PlayerBackpack)
	elseif(returnCode=="enableLegacy") then
		SystemData.Settings.Interface.LegacyContainers = true
		UserSettingsChanged()
		--DestroyWindow("ContainerWindow_"..EnhancePack.PlayerBackpack)
		
	elseif(returnCode=="disableGridLegacy") then
		EnhancePack.GridLegacy = false
		CustomSettings.SaveBoolean( "EnhancePackGridLegacy", EnhancePack.GridLegacy)
		ChatWindow.Print(L"Grid Legacy containers DISABLED", SystemData.ChatLogFilters.SYSTEM )
	elseif(returnCode=="enableGridLegacy") then
		EnhancePack.GridLegacy = true
		CustomSettings.SaveBoolean( "EnhancePackGridLegacy", EnhancePack.GridLegacy )
		ChatWindow.Print(L"Grid Legacy containers ENABLED", SystemData.ChatLogFilters.SYSTEM )
	elseif(returnCode=="disableGrid") then
		EnhancePack.EnableContainerGrid = false
		CustomSettings.SaveBoolean( "EnhancePackEnableContainerGrid", EnhancePack.EnableContainerGrid)
		ChatWindow.Print(L"Grid on containers DISABLED", SystemData.ChatLogFilters.SYSTEM )
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
	elseif(returnCode=="enableGrid") then
		EnhancePack.EnableContainerGrid = true
		CustomSettings.SaveBoolean( "EnhancePackEnableContainerGrid", EnhancePack.EnableContainerGrid )
		ChatWindow.Print(L"Grid on containers ENABLED", SystemData.ChatLogFilters.SYSTEM )
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
		
	elseif(returnCode=="Reset") then
		EnhancePack.Restore()
	elseif(returnCode=="showMain") then
		data = MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"]
	
		-- Setting ToggleWindow to nil indicates that we have to use a custom handler
		if (data.ToggleWindow) then
    		ToggleWindowByName(data.ToggleWindow, SystemData.ActiveWindow.name, MenuBarWindow.ToggleMenuButton)	
		else
			--Debug.Print( L"ERROR MenuBarWindow.ToggleMenuButton - no data found for window = "..StringToWString(SystemData.ActiveWindow.name) )
		end
	end
end

function MenuBarWindow.ColorPicked()
		local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]
		if (MenuBarWindow.HuePickerWindowRequest== "colorDefault") then
			EnhancePack.TITLE_COLOR.r,EnhancePack.TITLE_COLOR.g,EnhancePack.TITLE_COLOR.b,EnhancePack.TITLE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackTITLE_COLOR", EnhancePack.TITLE_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorMods") then
			EnhancePack.BODY_COLOR.r,EnhancePack.BODY_COLOR.g,EnhancePack.BODY_COLOR.b,EnhancePack.BODY_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackBODY_COLOR", EnhancePack.BODY_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorEngrave") then
			EnhancePack.ENGRAVE_COLOR.r,EnhancePack.ENGRAVE_COLOR.g,EnhancePack.ENGRAVE_COLOR.b,EnhancePack.ENGRAVE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackENGRAVE_COLOR", EnhancePack.ENGRAVE_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorArti") then
			EnhancePack.ARTIFACT_COLOR.r,EnhancePack.ARTIFACT_COLOR.g,EnhancePack.ARTIFACT_COLOR.b,EnhancePack.ARTIFACT_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackARTIFACT_COLOR", EnhancePack.ARTIFACT_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorSet") then
			EnhancePack.SET_COLOR.r,EnhancePack.SET_COLOR.g,EnhancePack.SET_COLOR.b,EnhancePack.SET_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackSET_COLOR", EnhancePack.SET_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorAlert") then
			EnhancePack.ALERT_COLOR.r,EnhancePack.ALERT_COLOR.g,EnhancePack.ALERT_COLOR.b,EnhancePack.ALERT_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackALERT_COLOR", EnhancePack.ALERT_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorDanger") then
			EnhancePack.DANGER_COLOR.r,EnhancePack.DANGER_COLOR.g,EnhancePack.DANGER_COLOR.b,EnhancePack.DANGER_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackDANGER_COLOR", EnhancePack.DANGER_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPhys") then
			EnhancePack.PHYSICAL.r,EnhancePack.PHYSICAL.g,EnhancePack.PHYSICAL.b,EnhancePack.PHYSICAL.a  = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPHYSICAL", EnhancePack.PHYSICAL)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorFire") then
			EnhancePack.FIRE.r,EnhancePack.FIRE.g,EnhancePack.FIRE.b,EnhancePack.FIRE.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackFIRE", EnhancePack.FIRE)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorCold") then
			EnhancePack.COLD.r,EnhancePack.COLD.g,EnhancePack.COLD.b,EnhancePack.COLD.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackCOLD", EnhancePack.COLD)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPois") then
			EnhancePack.POISON.r,EnhancePack.POISON.g,EnhancePack.POISON.b,EnhancePack.POISON.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPOISON", EnhancePack.POISON)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorEner") then
			EnhancePack.ENERGY.r,EnhancePack.ENERGY.g,EnhancePack.ENERGY.b,EnhancePack.ENERGY.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackENERGY", EnhancePack.ENERGY)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorChaos") then
			EnhancePack.Chaos.r,EnhancePack.Chaos.g,EnhancePack.Chaos.b,EnhancePack.Chaos.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackChaos", EnhancePack.Chaos)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHeal") then
			EnhancePack.Heal.r,EnhancePack.Heal.g,EnhancePack.Heal.b,EnhancePack.Heal.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackHeal", EnhancePack.Heal)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorCurse") then
			EnhancePack.Curse.r,EnhancePack.Curse.g,EnhancePack.Curse.b,EnhancePack.Curse.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackCurse", EnhancePack.Curse)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPara") then
			EnhancePack.Paralyze.r,EnhancePack.Paralyze.g,EnhancePack.Paralyze.b,EnhancePack.Paralyze.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackParalyze", EnhancePack.Paralyze)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorNeutral") then
			EnhancePack.Neutral.r,EnhancePack.Neutral.g,EnhancePack.Neutral.b,EnhancePack.Neutral.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackNeutral", EnhancePack.Neutral)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorNeg") then
			EnhancePack.OverHeadError.r,EnhancePack.OverHeadError.g,EnhancePack.OverHeadError.b,EnhancePack.OverHeadError.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackOverHeadError", EnhancePack.OverHeadError)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPos") then
			EnhancePack.SpecialColor.r,EnhancePack.SpecialColor.g,EnhancePack.SpecialColor.b,EnhancePack.SpecialColor.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackSpecialColor", EnhancePack.SpecialColor)
			
			
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCountdown") then
			HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b,HotbarSystem.CountdownTimer.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemCountdownTimer", HotbarSystem.CountdownTimer)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBPlain") then
			HotbarSystem.Plain.r,HotbarSystem.Plain.g,HotbarSystem.Plain.b,HotbarSystem.Plain.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemPlain", HotbarSystem.Plain)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBControl") then
			HotbarSystem.Control.r,HotbarSystem.Control.g,HotbarSystem.Control.b,HotbarSystem.Control.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControl", HotbarSystem.Control)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBAlt") then
			HotbarSystem.Alt.r,HotbarSystem.Alt.g,HotbarSystem.Alt.b,HotbarSystem.Alt.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemAlt", HotbarSystem.Alt)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBShift") then
			HotbarSystem.Shift.r,HotbarSystem.Shift.g,HotbarSystem.Shift.b,HotbarSystem.Shift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemShift", HotbarSystem.Shift)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCtrlalt") then
			HotbarSystem.ControlAlt.r,HotbarSystem.ControlAlt.g,HotbarSystem.ControlAlt.b,HotbarSystem.ControlAlt.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlAlt", HotbarSystem.ControlAlt)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBAltShift") then
			HotbarSystem.AltShift.r,HotbarSystem.AltShift.g,HotbarSystem.AltShift.b,HotbarSystem.AltShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemAltShift", HotbarSystem.AltShift)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCtrlAltShift") then
			HotbarSystem.ControlAltShift.r,HotbarSystem.ControlAltShift.g,HotbarSystem.ControlAltShift.b,HotbarSystem.ControlAltShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlAltShift", HotbarSystem.ControlAltShift)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCtrlShift") then
			HotbarSystem.ControlShift.r,HotbarSystem.ControlShift.g,HotbarSystem.ControlShift.b,HotbarSystem.ControlShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlShift", HotbarSystem.ControlShift)
			EnhancePack.UpdateHotbars()
			
		
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCurrent") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_CURRENT", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT])
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBSelf") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_SELF", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF])
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCursor") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_CURSOR", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR])
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBStored") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_OBJECT_ID", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID])
			EnhancePack.UpdateHotbars()
			
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBBorder") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_NONE", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE])
			EnhancePack.UpdateHotbars()
		
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorYou") then
			EnhancePack.YOUGETAMAGE_COLOR.r,EnhancePack.YOUGETAMAGE_COLOR.g,EnhancePack.YOUGETAMAGE_COLOR.b,EnhancePack.YOUGETAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackYOUGETAMAGE_COLOR", EnhancePack.YOUGETAMAGE_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPet") then
			EnhancePack.PETGETDAMAGE_COLOR.r,EnhancePack.PETGETDAMAGE_COLOR.g,EnhancePack.PETGETDAMAGE_COLOR.b,EnhancePack.PETGETDAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPETGETDAMAGE_COLOR", EnhancePack.PETGETDAMAGE_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorEnemy") then
			EnhancePack.OTHERGETDAMAGE_COLOR.r,EnhancePack.OTHERGETDAMAGE_COLOR.g,EnhancePack.OTHERGETDAMAGE_COLOR.b,EnhancePack.OTHERGETDAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackOTHERGETDAMAGE_COLOR", EnhancePack.OTHERGETDAMAGE_COLOR)
			
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorGrid") then
			EnhancePack.BaseGridColor.r,EnhancePack.BaseGridColor.g,EnhancePack.BaseGridColor.b,EnhancePack.BaseGridColor.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackBaseGridColor", EnhancePack.BaseGridColor)
			for id, value in pairs(ContainerWindow.OpenContainers) do
				DestroyWindow("ContainerWindow_"..id)
			end
			
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorGridAlter") then
			EnhancePack.AlternateBackpack.r,EnhancePack.AlternateBackpack.g,EnhancePack.AlternateBackpack.b,EnhancePack.AlternateBackpack.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackAlternateBackpack", EnhancePack.AlternateBackpack)
			for id, value in pairs(ContainerWindow.OpenContainers) do
				DestroyWindow("ContainerWindow_"..id)
			end
		end
		MenuBarWindow.HuePickerWindowRequest= ""
		DestroyWindow("ColorPicker")
end

function MenuBarWindow.ToggleInventoryWindow()
--Debug.Print( L"Called MenuBarWindow.ToggleInventoryWindow()" )
	local objectId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	EnhancePack.PlayerBackpack = objectId
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.PlayerStatus.PlayerId)
	else
		local windowName = "ContainerWindow_"..objectId
		local showing = false
		
		if( DoesWindowNameExist(windowName) ) then
		    showing = WindowGetShowing(windowName)
		end
		
		if (showing == true) then
			DestroyWindow(windowName)
			EnhancePack.BackpackOpen = false
			CustomSettings.SaveBoolean( "EnhancePackBackpackOpen", EnhancePack.BackpackOpen )
		else
			UserActionUseItem(objectId,false)
		end
	end
end

function MenuBarWindow.ToggleMapWindow()
	if WindowGetShowing("MapWindow") then
		WindowSetShowing("RadarWindow", false)
		WindowSetShowing("MapWindow", false)
	else
		MapWindow.ActivateMap()
		WindowSetShowing("MapWindow", true)
	end	
end

function MenuBarWindow.ToggleGuildWindow()
    -- DAB TODO: Make this a toggle
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_GUILD_WINDOW)
end

function MenuBarWindow.ToggleChatWindow()
	if( not DoesWindowExist("ChannelWindow") ) then
		CreateWindow("ChannelWindow", true)
	else
		DestroyWindow("ChannelWindow")
	end
end

function MenuBarWindow.ToggleSkillsWindow()
	SkillsWindow.ToggleSkillsWindow()

	-- if window is active, hilite button on menu bar
	--local WindowName = "SkillsWindow"
	--showing = WindowGetShowing(WindowName)
	
	
	
end

function MenuBarWindow.GeneralWindows()

	local playerId = WindowData.PlayerStatus.PlayerId
	ContextMenu.CreateLuaContextMenuItemWithString(L"Paperdoll",0,"paper",2, DoesWindowNameExist("PaperdollWindow"..playerId))
	ContextMenu.CreateLuaContextMenuItemWithString(L"Skills",0,"skill",2,WindowGetShowing("SkillsWindow"))
	ContextMenu.CreateLuaContextMenuItemWithString(L"Sheet",0,"sheet",2,WindowGetShowing("CharacterSheet"))
	ContextMenu.CreateLuaContextMenuItemWithString(L"Guild",0,"guild",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Virtues",0,"virtues",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Quests",0,"quest",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Show Radar/Atlas",0,"map",2,WindowGetShowing("RadarWindow") or WindowGetShowing("MapWindow"))
	local enabled = 0
	if ( EnhancePack.BookLog ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Book Recorder",0,"disableBook",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Book Recorder",0,"enableBook",2,false)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Chat Channel Settings",0,"chat",2,DoesWindowExist("ChannelWindow"))
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Circle of Transparency",0,"circTrans",2,SystemData.Settings.GameOptions.circleOfTransEnabled)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Foliage",0,"foliage",2,SystemData.Settings.Resolution.displayFoliage )
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Always Run",0,"alwaysrun",2,SystemData.Settings.GameOptions.alwaysRun )
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Ignore Player by Target",0,"IgnorePlayer",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Clock",0,"clock",2,ClockWindow.ClockEnabled)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Hourglass",0,"hourglass",2,Hourglass.HourglassVisible)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Object Handle Window",0,"objhandle",2,EnhancePack.ObjectHandle)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Quick Details Window",0,"quickdt",2,EnhancePack.EnableQuickDetail)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Server Lines Map",0,"serverLine",2,WindowGetShowing("ServerLine"))
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle UO Cartographer",0,"cartogra",2,EnhancePack.EnableCartographer)
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	if (EnhancePack.TrapBoxID ~= 0 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Set A Trapped Box.",1,"trap",2,false)
		ContextMenu.CreateLuaContextMenuItemWithString(L"Un-set The Trapped Box.",0,"untrap",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Set A Trapped Box.",0,"trap",2,false)
		ContextMenu.CreateLuaContextMenuItemWithString(L"Un-set The Trapped Box.",1,"untrap",2,false)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	if (EnhancePack.LootBoxID ~= 0 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Set A Loot Bag.",1,"loot",2,false)
		ContextMenu.CreateLuaContextMenuItemWithString(L"Un-set The Loot Bag.",0,"unloot",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Set A Loot Bag.",0,"loot",2,false)
		ContextMenu.CreateLuaContextMenuItemWithString(L"Un-set The Loot Bag.",1,"unloot",2,false)
	end


	ContextMenu.ActivateLuaContextMenu(MenuBarWindow.ContextMenuCallbackGeneral)
	
	local scaleFactor = 1/0.7
	
	local cmWidth, cmHeight = WindowGetDimensions("ContextMenu")

	WindowSetScale("ContextMenu", 0.7)
	
	
	
	
	local cmWindowX = 0
	local mouseX = SystemData.MousePosition.x
	if mouseX + (cmWidth / scaleFactor) > SystemData.screenResolution.x then
		cmWindowX = mouseX - (cmWidth / scaleFactor)
	else
		cmWindowX = mouseX
	end
		
	local mouseY = SystemData.MousePosition.y
	local cmWindowY = mouseY
	if mouseY + (cmHeight / scaleFactor) > SystemData.screenResolution.y then
		cmWindowY = mouseY - (cmHeight / scaleFactor)
	else
		cmWindowY = mouseY
	end
	
	WindowSetOffsetFromParent("ContextMenu", cmWindowX * scaleFactor, cmWindowY * scaleFactor)	
	
end

function MenuBarWindow.ContextMenuCallbackGeneral( returnCode, param )
	if ( returnCode=="trap" ) then
		EnhancePack.SendOverheadText(L"Target your trap box", 1152, true)
		RequestTargetInfo()
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "EnhancePack.TargetItemRequestTargetInfoReceived")
	elseif ( returnCode=="untrap" ) then
		EnhancePack.UnsetYourTrapbox()
		
	elseif ( returnCode=="loot" ) then
		EnhancePack.SendOverheadText(L"Target your loot bag", 1152, true)
		RequestTargetInfo()
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "EnhancePack.TargetLootRequestTargetInfoReceived")
	elseif ( returnCode=="unloot" ) then
		EnhancePack.UnsetYourLootbag()	
		
	elseif ( returnCode=="skill" ) then
		MenuBarWindow.ToggleSkillsWindow()
	elseif ( returnCode=="paper" ) then
		MenuBarWindow.TogglePaperdollWindow()
	elseif ( returnCode=="sheet" ) then
		MenuBarWindow.ToggleCharacterSheet()
	elseif ( returnCode=="guild" ) then
		MenuBarWindow.ToggleGuildWindow()
	elseif ( returnCode=="virtues" ) then
		MenuBarWindow.ToggleVirtuesWindow()
	elseif ( returnCode=="quest" ) then
		MenuBarWindow.ToggleQuestWindow()
	elseif ( returnCode=="chat" ) then
		MenuBarWindow.ToggleChatWindow()
	elseif ( returnCode=="map" ) then
		MenuBarWindow.ToggleMapWindow()
	elseif ( returnCode=="serverLine" ) then
		ServerLine.Toggle()
	elseif ( returnCode=="cartogra" ) then
		EnhancePack.EnableCartographer = not EnhancePack.EnableCartographer 
		CustomSettings.SaveBoolean( "EnhancePackEnableCartographer",EnhancePack.EnableCartographer )
	elseif(returnCode=="disableBook") then
		EnhancePack.BookLog = false
		CustomSettings.SaveBoolean( "EnhancePackBookLog", EnhancePack.BookLog )
	elseif(returnCode=="enableBook") then
		EnhancePack.BookLog = true
		CustomSettings.SaveBoolean( "EnhancePackBookLog", EnhancePack.BookLog )
	elseif ( returnCode=="circTrans" ) then
		SystemData.Settings.GameOptions.circleOfTransEnabled = not SystemData.Settings.GameOptions.circleOfTransEnabled
		UserSettingsChanged()
	elseif ( returnCode=="foliage" ) then
		SystemData.Settings.Resolution.displayFoliage = not SystemData.Settings.Resolution.displayFoliage
		UserSettingsChanged()
	elseif ( returnCode=="alwaysrun" ) then
		SystemData.Settings.GameOptions.alwaysRun = not SystemData.Settings.GameOptions.alwaysRun 
		UserSettingsChanged()
	elseif ( returnCode=="clock" ) then
		ClockWindow.ClockEnabled = not ClockWindow.ClockEnabled
		CustomSettings.SaveBoolean( "ShowClock", ClockWindow.ClockEnabled)
		ClockWindow.ReloadSettings()
	elseif ( returnCode=="quickdt" ) then
		EnhancePack.EnableQuickDetail = not EnhancePack.EnableQuickDetail
		CustomSettings.SaveBoolean( "EnhancePackEnableQuickDetail", EnhancePack.EnableQuickDetail )
		WindowSetShowing("QuickDetailsWindow", EnhancePack.EnableQuickDetail)
		
	elseif ( returnCode=="objhandle" ) then
		EnhancePack.ObjectHandle = not EnhancePack.ObjectHandle
		CustomSettings.SaveBoolean( "EnhancePackObjectHandle", EnhancePack.ObjectHandle )
		WindowSetShowing("ObjectHandleToggleWindow", EnhancePack.ObjectHandle)
	elseif ( returnCode=="hourglass" ) then
		if ( Hourglass.HourglassVisible ) then Hourglass.Close(); else Hourglass.HourglassVisible = true; WindowSetShowing("Hourglass", true); CustomSettings.SaveBoolean( "HourglassVisible", true ); end
	elseif ( returnCode=="IgnorePlayer" ) then
		RequestTargetInfo()
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "MenuBarWindow.IgnorePlayer")
	end
end
function MenuBarWindow.IgnorePlayer()
	local Id = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	if(IsMobile(Id)) then
		AddPlayerToIgnoreList(Id,WindowData.MobileName[Id].MobName)
		ToggleWindowByName( "SettingsWindow", "", nil )
		ChatWindow.Print(WindowData.MobileName[Id].MobName .. L"will be ignored", SystemData.ChatLogFilters.SYSTEM)
	else
		ChatWindow.Print(L"You can ignore only Players!", SystemData.ChatLogFilters.SYSTEM)
	end
end

function MenuBarWindow.ToggleVirtuesWindow()
    -- DAB TODO: Make this a toggle
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_VIRTUES_LIST )
end

function MenuBarWindow.ToggleQuestWindow()
    -- DAB TODO: Make this a toggle
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_QUEST_LOG )
end

function MenuBarWindow.ToggleHelpWindow()
    -- DAB TODO: Make this a toggle
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_HELP_MENU )
end

function MenuBarWindow.TogglePaperdollWindow()
	playerId = WindowData.PlayerStatus.PlayerId
	local windowName = "PaperdollWindow"..playerId

	if(DoesWindowNameExist(windowName)) then
		DestroyWindow(windowName)
	else
	    UserActionUseItem(playerId,true)
	end
end

function MenuBarWindow.ToggleCharacterSheet()
	ToggleWindowByName("CharacterSheet", "", nil)
end

function MenuBarWindow.ToggleCharacterAbilities()
	ToggleWindowByName("CharacterAbilities", "", nil)
end

function MenuBarWindow.ToggleMainMenu()
	local data = MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"]
	ToggleWindowByName(data.ToggleWindow, SystemData.ActiveWindow.name, MenuBarWindow.ToggleMenuButton)	
end

function MenuBarWindow.ToggleWarMode()

    if( WindowData.PlayerStatus.InWarMode ) then
            MenuBarWindow.WarMode = 1
            ButtonSetPressedFlag( "MenuBarWindowWarButton", true )          
            ButtonSetPressedFlag( "MenuBarWindowMinimizedWarButton", true )
            
    else
            MenuBarWindow.WarMode = 0
            ButtonSetPressedFlag( "MenuBarWindowWarButton", false )
            ButtonSetPressedFlag( "MenuBarWindowMinimizedWarButton", false ) 
    end
end


function MenuBarWindow.ToggleWarModeButton()
        UserActionToggleWarMode()
end

function MenuBarWindow.OnMoveMaximizedEnd()
	WindowSetMoving("MenuBarWindow", false)
end

function MenuBarWindow.OnMoveMaximizedStart()
	if ( not MenuBarWindow.Locked ) then
		SnapUtils.StartWindowSnap("MenuBarWindow")
		WindowSetMoving("MenuBarWindow", true)
	end
end

function MenuBarWindow.OnMoveMinimizedEnd()
	WindowSetMoving("MenuBarWindowMinimized", false)
end

function MenuBarWindow.OnMoveMinimizedStart()
	if ( not MenuBarWindow.Locked ) then
		SnapUtils.StartWindowSnap("MenuBarWindowMinimized")
		WindowSetMoving("MenuBarWindowMinimized", true)
	end
end