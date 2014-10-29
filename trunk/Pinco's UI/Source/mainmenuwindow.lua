----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MainMenuWindow = {}
MainMenuWindow.TID ={}
MainMenuWindow.TID.MAIN_MENU	 = 1049755	-- Main Menu
MainMenuWindow.TID.LOG_OUT		 = 3000128	-- Log Out
MainMenuWindow.TID.EXIT_GAME	 = 1077859	-- Exit Game
MainMenuWindow.TID.USER_SETTINGS = 1077814	-- User Settings
MainMenuWindow.TID.BUG_REPORT	 = 1077790	-- Bug Report
MainMenuWindow.TID.HELP          = 1061037  -- Help
MainMenuWindow.TID.MACROS        = 3000172	-- Macros 
MainMenuWindow.TID.ACTIONS       = 1079812	-- Actions 
MainMenuWindow.delta = 0
MainMenuWindow.animStarted = false

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function MainMenuWindow.Initialize()
	
	WindowSetAlpha( "MainMenuWindow", 1.00 )
	WindowSetAlpha( "MainMenuWindow", 1.00 )
	
	-- Label & Button Titles
	WindowUtils.SetWindowTitle("MainMenuWindow",GetStringFromTid(MainMenuWindow.TID.MAIN_MENU))
	
	LabelSetText("MainMenuWindowLogOutItemText", GetStringFromTid(MainMenuWindow.TID.LOG_OUT) )
	LabelSetText("MainMenuWindowExitGameItemText", GetStringFromTid(MainMenuWindow.TID.EXIT_GAME) )
	LabelSetText("MainMenuWindowUserSettingsItemText", GetStringFromTid(MainMenuWindow.TID.USER_SETTINGS) )
	LabelSetText("MainMenuWindowAgentsSettingsItemText",UI.GetCliloc(SystemData.Settings.Language.type, 611) )
	LabelSetText("MainMenuWindowFriendListItemText",UI.GetCliloc(SystemData.Settings.Language.type, 852) )
	LabelSetText("MainMenuWindowMacrosItemText", GetStringFromTid(MainMenuWindow.TID.MACROS) )
	LabelSetText("MainMenuWindowActionsItemText", GetStringFromTid(MainMenuWindow.TID.ACTIONS) )
	LabelSetText("MainMenuWindowHelpItemText", GetStringFromTid(MainMenuWindow.TID.HELP) )
	
	LabelSetText("MainMenuWindowBugReportItemText", GetStringFromTid(MainMenuWindow.TID.BUG_REPORT) )
	LabelSetText("MainMenuWindowDebugWindowItemText", L"Debug Window")
	WindowUtils.RestoreWindowPosition("MainMenuWindow")
	WindowSetShowing("MainMenuWindowChrome_UO_WindowCloseButton", false)
	WindowClearAnchors("MainMenuWindowChrome_UO_TitleBar_WindowTitle")
	WindowAddAnchor("MainMenuWindowChrome_UO_TitleBar_WindowTitle", "center", "MainMenuWindowChrome_UO_TitleBar", "center", 0, 0 )

end

-- OnShutdown Handler
function MainMenuWindow.Shutdown()
	WindowUtils.SaveWindowPosition("MainMenuWindow")
end

function MainMenuWindow.OnLogOut()	
	-- Broadcast the event
	if (EnhancePack.CanLogout > EnhancePack.TimeSinceLogin) then

		local okayButton = { textTid=UO_StandardDialog.TID_OKAY , callback=function()BroadcastEvent( SystemData.Events.LOG_OUT )end }
		local cancelButton = { text=GetStringFromTid(UO_StandardDialog.TID_CANCEL)}
		local DestroyConfirmWindow = 
		{
		    windowName = "LogOutWarning",
			title = UI.GetCliloc(SystemData.Settings.Language.type, 838),
			body = UI.GetCliloc(SystemData.Settings.Language.type, 839) ,
			buttons = { okayButton, cancelButton }
		}
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)	
		WindowSetDimensions("LogOutWarningDialog", 350, 300)
		return
	end
	BroadcastEvent( SystemData.Events.LOG_OUT )
end

function MainMenuWindow.OnOpenUserSettings()	
	EnhancePack.ReloadSettings()
	ToggleWindowByName( "SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenMacros()	
	ToggleWindowByName( "MacroWindow", "", MainMenuWindow.OnOpenMacros )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenActions()	
	ToggleWindowByName( "ActionsWindow", "", MainMenuWindow.OnOpenActions )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenBugReportItem()	
	ToggleWindowByName( "BugReportWindow", "", MainMenuWindow.ToggleBugReportWindow )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenHelp()
    BroadcastEvent( SystemData.Events.REQUEST_OPEN_HELP_MENU )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.ToggleSettingsWindow()	
	ToggleWindowByName( "SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow )	
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.ToggleBugReportWindow()	
	ToggleWindowByName( "BugReportWindow", "", MainMenuWindow.ToggleBugReportWindow )	
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnToggleAgentsSettings()
	ToggleWindowByName( "OrganizerWindow", "", MainMenuWindow.OnToggleAgentsSettings )	
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnToggleDebugWindow()	
	ToggleWindowByName( "DebugWindow", "", MainMenuWindow.OnToggleDebugWindow )	
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnToggleFriendList()	
	ToggleWindowByName( "FriendList", "", MainMenuWindow.OnToggleFriendList )	
	WindowSetShowing("MainMenuWindow",false)
end

--function MainMenuWindow.OnUpdate(timepassed)
--	MainMenuWindow.delta = MainMenuWindow.delta + timepassed
--	if (MainMenuWindow.delta > 1.1 and not MainMenuWindow.animStarted) then
--		MainMenuWindow.animStarted = true
--		--WindowSetShowing("MainMenuWindowFlamestrike", false)
--		WindowSetShowing("MainMenuWindowFlamestrikeLoop", true)
--	end
--end

function MainMenuWindow.OnShown()
	--WindowSetShowing("MainMenuWindowFlamestrikeLoop", false)
	--WindowSetShowing("MainMenuWindowFlamestrike", true)
	--MainMenuWindow.delta = 0
	--MainMenuWindow.animStarted = false
    ButtonSetPressedFlag("MenuBarWindowToggleMainMenu",false)
    AnimatedImageStartAnimation( "MainMenuWindowFlamestrike", 1, true, false, 0.0 ) 
    --AnimatedImageStartAnimation( "MainMenuWindowFlamestrikeLoop", 1, true, false, 0 ) 
    if (MainMenuWindow.notnow) then
		MainMenuWindow.notnow = false
		WindowSetShowing("MainMenuWindow", false)
	end
end

function MainMenuWindow.OnHidden()
    ButtonSetPressedFlag("MenuBarWindowToggleMainMenu",false)
end
