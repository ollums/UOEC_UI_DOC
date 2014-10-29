
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DurabilityBar = {}
DurabilityBar.CloseLeft = false
DurabilityBar.Hidden = false
DurabilityBar.locked = false
DurabilityBar.delta = 0

DurabilityBar.ItemBars = {}
DurabilityBar.Bars = {}


function DurabilityBar.Initialize()
	local windowName = "DurabilityBar"
	SnapUtils.SnappableWindows[windowName] = true
	
	
	WindowClearAnchors("DurabilityBarHideView")
	DurabilityBar.CloseLeft = CustomSettings.LoadBoolean( "DurabilityBarCloseLeft", DurabilityBar.CloseLeft)
	
	DurabilityBar.ButtonRotation()
	
	if (DurabilityBar.CloseLeft) then
		WindowAddAnchor("DurabilityBarHideView", "topleft", "DurabilityBar", "topleft", 0, 0 )
	else
		WindowAddAnchor("DurabilityBarHideView", "topright", "DurabilityBar", "topright", 0, 0 )
	end
	WindowClearAnchors("DurabilityBar")

	WindowAddAnchor("DurabilityBar", "right", "ResizeWindow", "right",0,0)
	WindowUtils.RestoreWindowPosition("DurabilityBar", false)
	
	local titleName = windowName.."ShowViewName"
	LabelSetText(titleName, GetStringFromTid(1017323) )
	
	local hideTitleName = windowName.."HideViewName"

	LabelSetText(hideTitleName, GetStringFromTid(1017323) )
	
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(titleName,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont(hideTitleName,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
		
	DurabilityBar.locked = CustomSettings.LoadBoolean( "LockDurabilityBar", false )
	WindowSetMovable(windowName, not DurabilityBar.locked )
	
	local visible = CustomSettings.LoadBoolean( "DurabilityBarVisible", DurabilityBar.Hidden )
	
	if (visible) then
		DurabilityBar.ShowItems()
	else
		DurabilityBar.HideItems()
	end
	
	WindowSetTintColor(windowName .. "ShowViewTitleBar", 0,0,0)
	WindowSetAlpha(windowName .. "ShowViewFrame", 0.5)
	WindowSetScale(windowName, SystemData.Settings.Interface.customUiScale * 0.80)
	EnhancePack.LoadScale( windowName )
end

function DurabilityBar.Shutdown()
	WindowUtils.SaveWindowPosition("DurabilityBar")
	SnapUtils.SnappableWindows["DurabilityBar"] = nil
end

function DurabilityBar.ButtonRotation()
	local showName = "DurabilityBarShowView"
	local hideName = "DurabilityBarHideView"
		
	if DurabilityBar.CloseLeft then
		WindowSetShowing(showName .. "HideButtonR", false)
		WindowSetShowing(showName .. "HideButton", true)
		WindowSetShowing(hideName .. "ShowButtonR", false)
		WindowSetShowing(hideName .. "ShowButton", true)
		WindowClearAnchors(hideName .. "Name")
		WindowAddAnchor(hideName .. "Name", "bottomleft", hideName, "topleft", 10, -20)
	else
		WindowSetShowing(showName .. "HideButtonR", true)
		WindowSetShowing(showName .. "HideButton", false)
		WindowSetShowing(hideName .. "ShowButtonR", true)
		WindowSetShowing(hideName .. "ShowButton", false)
		WindowClearAnchors(hideName .. "Name")
		WindowAddAnchor(hideName .. "Name", "bottomright", hideName, "topright", 0, -20)
	end
end

function DurabilityBar.ShowItemsToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 812))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	WindowSetAlpha(SystemData.ActiveWindow.name,1)
end

function DurabilityBar.ShowPetToolTipEnd()
	WindowSetAlpha(SystemData.ActiveWindow.name,0.5)
end

function DurabilityBar.HideItemsToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 813))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	WindowSetAlpha(SystemData.ActiveWindow.name,1)
end

function DurabilityBar.HidePetToolTipEnd()
	WindowSetAlpha(SystemData.ActiveWindow.name,0.5)
end

function DurabilityBar.ShowItems()
	local windowName = "DurabilityBar"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	
	WindowSetShowing(showName, true)
	WindowSetShowing(hideName, false)
	
	WindowSetAlpha(showName .. "HideButton",0.5)
	WindowSetAlpha(showName .. "HideButtonR",0.5)
	
	SnapUtils.SnappableWindows[showName] = true
	
	DurabilityBar.Hidden = false
	CustomSettings.SaveBoolean( "DurabilityBarVisible", true )
end

function DurabilityBar.HideItems()
	local windowName = "DurabilityBar"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	WindowSetShowing(showName, false)
	WindowSetShowing(hideName, true)
	
	WindowSetAlpha(hideName .. "ShowButton",0.5)
	WindowSetAlpha(hideName .. "ShowButtonR",0.5)
	
	SnapUtils.SnappableWindows[showName] = nil
	
	DurabilityBar.Hidden = true
	CustomSettings.SaveBoolean( "DurabilityBarVisible", false )
	DurabilityBar.Clear()
end

function DurabilityBar.RContextMenu()
	local windowname = WindowGetId(WindowUtils.GetActiveDialog())
	if(DurabilityBar.locked) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 289),0,"Lock",1,false)
	else
	   ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 290),0,"Lock",1,false)
	end
	
	if (DurabilityBar.CloseLeft) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 291),0,"closeRight",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 293),0,"closeLeft",2,false)
	end

	ContextMenu.ActivateLuaContextMenu(DurabilityBar.ContextMenuCallback)
end

function DurabilityBar.ContextMenuCallback( returnCode, param )	
	local windowName = "DurabilityBar"
	if ( returnCode=="Lock" ) then
		DurabilityBar.locked = not DurabilityBar.locked
		CustomSettings.SaveBoolean( "LockDurabilityBar", DurabilityBar.locked )
		WindowSetMovable(windowName, not DurabilityBar.locked )
	end
	
	if ( returnCode=="closeRight" ) then
		DurabilityBar.CloseLeft = false
		CustomSettings.SaveBoolean( "DurabilityBarCloseLeft", DurabilityBar.CloseLeft  )
		WindowClearAnchors("DurabilityBarHideView")
		WindowAddAnchor("DurabilityBarHideView", "topright", "DurabilityBar", "topright", 0, 0 )
		DurabilityBar.ButtonRotation()
	elseif ( returnCode=="closeLeft" ) then
		DurabilityBar.CloseLeft = true 
		CustomSettings.SaveBoolean( "DurabilityBarCloseLeft", DurabilityBar.CloseLeft  )
		WindowClearAnchors("DurabilityBarHideView")
		WindowAddAnchor("DurabilityBarHideView", "topleft", "DurabilityBar", "topleft", 0, 0 )
		DurabilityBar.ButtonRotation()
	end

end

function DurabilityBar.OnMouseDrag()
	if ( not DurabilityBar.locked) then
		SnapUtils.StartWindowSnap("DurabilityBar")
	end
end

function DurabilityBar.Update(timepassed)
	end

function DurabilityBar.Clear()
	if (DurabilityBar.Bars and WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId]) then
		for index = 1, WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId].numSlots  do
			if (DoesWindowNameExist("ItemHealthBar_" .. index)) then
				DestroyWindow("ItemHealthBar_" .. index)
			end
		end

	end
end


function DurabilityBar.Scale(x, y, delta)
	EnhancePack.Scale(x, y, delta)
	DurabilityBar.HandleAnchors()
end

function DurabilityBar.HandleAnchors()
	if (DurabilityBar.Hidden) then
		return
	end
	local prev = 0
	local bars = 0
	for index = 1, WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId].numSlots  do
		local windowName = "ItemHealthBar_" .. index
		if (DoesWindowNameExist(windowName)) then
			bars = bars +1
			local parent = "DurabilityBar"
			local showName = parent.."ShowView"
			local windowPrev = "ItemHealthBar_".. prev
			
			if not DoesWindowNameExist(windowPrev) and index > 1 then
				local found = false
				for j = index-1, 1, -1 do
					if (DoesWindowNameExist("ItemHealthBar_" .. j)) then
						windowPrev = "ItemHealthBar_".. j
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)
			
			local scale = WindowGetScale("DurabilityBar")
			local alpha = WindowGetAlpha("DurabilityBar")

			WindowSetScale(windowName, scale )
			WindowSetAlpha(windowName, alpha )
			WindowSetFontAlpha(windowName, alpha)
			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			prev = index
		end
	end
end

function DurabilityBar.CreateItemBar(itemId, index)
    local windowName = "ItemHealthBar_"..index

	-- Create and register if doesn't exist
	if( DoesWindowNameExist(windowName) == false ) then
		CreateWindowFromTemplate(windowName, "ItemHealthBar", "Root")
		if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont(windowName .. "Name",  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		WindowSetDimensions(windowName, 190, 50)
		WindowSetId(windowName, itemId)
		local scale = WindowGetScale("DurabilityBar")
		if (scale > 0.65) then
			scale = 0.65
		end
		WindowSetScale(windowName, scale )
				
		Interface.DestroyWindowOnClose[windowName] = true
	end
end

function DurabilityBar.OnLButtonDown( flags, x, y )
	local itemId = WindowGetId(WindowUtils.GetActiveDialog())

	
	HandleSingleLeftClkTarget(itemId)
	
end

function DurabilityBar.OnMouseOver()
	local itemId = WindowGetId(SystemData.ActiveWindow.name)
	local windowName = "ItemHealthBar_"..itemId
	itemData =
			{
				windowName = windowName,
				itemId = itemId,
				itemType = WindowData.ItemProperties.TYPE_ITEM,
			}
	ItemProperties.SetActiveItem(itemData)
end

function DurabilityBar.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
end

function DurabilityBar.OnRButtonUp()
	local itemId = WindowGetId(SystemData.ActiveWindow.name)
	RequestContextMenu(itemId)
end

function DurabilityBar.OnLButtonDblClk()
	local itemId = WindowGetId(WindowUtils.GetActiveDialog())
	UserActionUseItem(itemId,false)
end

function DurabilityBar.OnShutDown()
	local windowName = WindowUtils.GetActiveDialog()
	local itemId = WindowGetId(SystemData.ActiveWindow.name)
	for i = 1, table.getn(DurabilityBar.ItemBars) do
		if (DurabilityBar.ItemBars[i]==itemId) then
			table.remove(DurabilityBar.ItemBars, i)
			break
		end
	end
	DestroyWindow(windowName)
end