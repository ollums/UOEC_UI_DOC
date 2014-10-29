----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

UO_DefaultWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

UO_DefaultWindow.WindowDestroyQueue = {}

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------


function UO_DefaultWindow.CloseDialog()
	local activeDialog = WindowUtils.GetActiveDialog()
	
	local Id = WindowGetId(activeDialog)
	if (Id ~= nil and Id == EnhancePack.PlayerBackpack) then
		EnhancePack.BackpackOpen = false
		CustomSettings.SaveBoolean( "EnhancePackBackpackOpen", EnhancePack.BackpackOpen )
	end
	
	if (Id ~= nil and id == WindowData.PlayerStatus.PlayerId) then
		EnhancePack.PaperdollOpen = false
		CustomSettings.SaveBoolean( "EnhancePackPaperdollOpen", EnhancePack.PaperdollOpen )
	end
	
	--If the On Close Callback is not nil that means the window has a call back function they want to run before
	--the window closes
	if( Interface.OnCloseCallBack[activeDialog] ~= nil) then
		Interface.OnCloseCallBack[activeDialog]()
	end
	
	if DoesWindowNameExist( activeDialog ) then
		if( Interface.DestroyWindowOnClose[activeDialog] ~= nil ) then
			DestroyWindow(activeDialog)
		else
			WindowSetShowing(activeDialog, false)
		end
		if DoesWindowNameExist( activeDialog.."Chrome_UO_WindowCloseButton" ) then
			ButtonSetPressedFlag(activeDialog.."Chrome_UO_WindowCloseButton", false)
		end
	end
	
end

function UO_DefaultWindow.CloseTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1052061))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function UO_DefaultWindow.CloseParent()
    WindowSetShowing(WindowGetParent(SystemData.ActiveWindow.name), false)
end
