----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PetWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

PetWindow.tid = { PET = 1077432}
PetWindow.OffetSize = 45
PetWindow.windowX = 175
PetWindow.windowY = 60
PetWindow.windowOffset = 5
PetWindow.Locked = false
PetWindow.CheckTime = 1
PetWindow.Delta = 1
PetWindow.Hidden = false
PetWindow.SortedPet = {}

PetWindow.CloseLeft= false

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function PetWindow.Initialize()
	local windowName = "PetWindow"
	local titleName = windowName.."ShowViewName"
	local hideTitleName = windowName.."HideViewName"
	LabelSetText(titleName, GetStringFromTid(PetWindow.tid.PET) )
	
	LabelSetText(hideTitleName, GetStringFromTid(PetWindow.tid.PET) )
	
	RegisterWindowData(WindowData.Pets.Type, 0)	
	WindowRegisterEventHandler( "PetWindow", WindowData.Pets.Event, "PetWindow.UpdatePet")
	--WindowRegisterEventHandler( "PetWindow", WindowData.MobileName.Event, "PetWindow.HandleUpdateNameEvent")
	--WindowRegisterEventHandler( "PetWindow", WindowData.MobileStatus.Event, "PetWindow.HandleUpdateStatusEvent")
	--WindowRegisterEventHandler( "PetWindow", WindowData.HealthBarColor.Event, "PetWindow.HandleTintHealthBarEvent")
	
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(titleName,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont(hideTitleName,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	WindowUtils.RestoreWindowPosition("PetWindow", false)
	
	WindowSetTintColor(windowName .. "ShowViewTitleBar", 0,0,0)
	WindowSetAlpha(windowName .. "ShowViewFrame", 0.5)
	WindowSetScale(windowName, SystemData.Settings.Interface.customUiScale * 0.80)

	PetWindow.ShowPet()
end


function PetWindow.Shutdown()
	local windowName = "PetWindow"
	local showName = windowName.."ShowView"
	SnapUtils.SnappableWindows[showName] = nil
	
	UnregisterWindowData(WindowData.Pets.Type, 0)	
	WindowUtils.SaveWindowPosition(windowName)
end

function PetWindow.HideAll()
	local windowName = "PetWindow"
	
	WindowSetShowing(windowName, false)
end

function PetWindow.ShowWindow()
	local windowName = "PetWindow"
	WindowSetShowing(windowName, true)
	
end

function PetWindow.Lock()
	if (PetWindow.Locked) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 313),0,"unlock",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 314),0,"lock",2,false)
	end
	if (PetWindow.CloseLeft) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 291),0,"closeRight",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 293),0,"closeLeft",2,false)
	end
	ContextMenu.ActivateLuaContextMenu(PetWindow.ContextMenuCallback)
end

function PetWindow.ContextMenuCallback( returnCode, param )	
	if ( returnCode=="unlock" ) then
		PetWindow.Locked = false 
		CustomSettings.SaveBoolean( "PetWindowLocked", PetWindow.Locked  )
	elseif ( returnCode=="lock" ) then
		PetWindow.Locked = true 
		CustomSettings.SaveBoolean( "PetWindowLocked", PetWindow.Locked  )
	elseif ( returnCode=="closeRight" ) then
		PetWindow.CloseLeft = false
		CustomSettings.SaveBoolean( "PetWindowCloseLeft", PetWindow.CloseLeft  )
		WindowClearAnchors("PetWindowHideView")
		WindowAddAnchor("PetWindowHideView", "topright", "PetWindow", "topright", 0, 0 )
		PetWindow.ButtonRotation()
	elseif ( returnCode=="closeLeft" ) then
		PetWindow.CloseLeft = true 
		CustomSettings.SaveBoolean( "PetWindowCloseLeft", PetWindow.CloseLeft  )
		WindowClearAnchors("PetWindowHideView")
		WindowAddAnchor("PetWindowHideView", "topleft", "PetWindow", "topleft", 0, 0 )
		PetWindow.ButtonRotation()
	end
end



function PetWindow.OnLButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	
	if(SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		DragSlotDropObjectToObject(mobileId)
	end

end
function PetWindow.Update(timePassed)
end

function PetWindow.ButtonRotation()
	local showName = "PetWindowShowView"
	local hideName = "PetWindowHideView"
		
	if PetWindow.CloseLeft then
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

function PetWindow.UpdatePet()
	if (MobilesOnScreen) then
		
			
		if(WindowData.Pets.PetId ~= nil ) then
		
			local petSize = table.getn(WindowData.Pets.PetId)
			if (petSize > 0) then
				--for mobileId, value in pairs(MobilesOnScreen.ReversePet) do
				--	MobilesOnScreen.ReversePet[mobileId] = nil
				--end
				PetWindow.SortedPet = {}
				for numPet = 1, petSize do
					local mobileId = WindowData.Pets.PetId[numPet]
					MobilesOnScreen.ReversePet[mobileId] = true
					PetWindow.SortedPet[numPet] = mobileId
					MobilesOnScreen.UpdateAnchors()
				end
			end
			PetWindow.UpdateAnchors()
		end
	end
	
end

function PetWindow.ShowPetToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 315))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	WindowSetAlpha(SystemData.ActiveWindow.name,1)
end

function PetWindow.ShowPetToolTipEnd()
	WindowSetAlpha(SystemData.ActiveWindow.name,0.5)
end

function PetWindow.HidePetToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,UI.GetCliloc(SystemData.Settings.Language.type, 316) )
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	WindowSetAlpha(SystemData.ActiveWindow.name,1)
end

function PetWindow.HidePetToolTipEnd()
	WindowSetAlpha(SystemData.ActiveWindow.name,0.5)
end

function PetWindow.UpdateAnchors()
	if (EnhancePack.TimeSinceLogin < 1) then
		return
	end
	
	if (WindowGetShowing("PetWindowHideView")) then
		return
	end
	
	local visible = 0

	local prevMob = 0
	for key, value in pairsByKeys(PetWindow.SortedPet) do
		mobileId = value
		value = MobilesOnScreen.ReversePet[value]
		if (value and IsMobile(mobileId) and MobilesOnScreen.IsPet(mobileId)) then
			local windowName = "MobileHealthBar_"..mobileId
			local windowPrev = "MobileHealthBar_"..prevMob
			if (not DoesWindowNameExist(windowName) and IsMobile(mobileId)) then
				MobileHealthBar.Forced = true
				EnhancePack.CreateHealthBar(mobileId)
				MobileHealthBar.Forced = nil
			end
			if (DoesWindowNameExist(windowName) and not MobileHealthBar.Handled[mobileId] and IsMobile(mobileId)) then
				local parent = "PetWindow"
				local showName = parent.."ShowView"
				visible = visible + 1
				WindowClearAnchors(windowName)
				if ( visible == 1 or not DoesWindowNameExist(windowPrev)) then
					WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
				else
					WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
				end
				prevMob = mobileId
			end
		end
	end
	
end


function PetWindow.OnMouseDrag()
	if ( not PetWindow.Locked) then
		SnapUtils.StartWindowSnap("PetWindow")
		WindowSetMoving("PetWindow",true)
	else
		WindowSetMoving("PetWindow",false)
	end
end




function PetWindow.HidePet()
	local windowName = "PetWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	
	local newWindowPosX, newWindowPosY = WindowGetScreenPosition(windowName)
    if(newWindowPosX < 0) then
		WindowUtils.CopyScreenPosition(windowName,windowName,newWindowPosX,0)
    end
	WindowSetAlpha(hideName .. "ShowButton",0.5)
	WindowSetAlpha(hideName .. "ShowButtonR",0.5)
	
	WindowSetShowing(showName, false)
	WindowSetShowing(hideName, true)
	
	SnapUtils.SnappableWindows[showName] = nil
	local petSize = table.getn(WindowData.Pets.PetId)
	for numPet = 1, petSize do
		local mobileId = WindowData.Pets.PetId[numPet]
		if(not MobileHealthBar.Handled[mobileId]) then
			if (MobileHealthBar.hasWindow[mobileId]) then
				MobileHealthBar.CloseWindowByMobileId(mobileId)
			end
		end
	end
	PetWindow.Hidden = true
	CustomSettings.SaveBoolean( "PetWindowHidden", true )
	PetWindow.ButtonRotation()
	
end

function PetWindow.ShowPet()
	local windowName = "PetWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
		
	WindowSetAlpha(showName .. "HideButton",0.5)
	WindowSetAlpha(showName .. "HideButtonR",0.5)
	WindowSetShowing(showName, true)
	WindowSetShowing(hideName, false)
	
	SnapUtils.SnappableWindows[showName] = true
	
	PetWindow.Hidden = false
	if (CustomSettings) then
		CustomSettings.SaveBoolean( "PetWindowHidden", false )
	end
	
	PetWindow.UpdatePet()
	PetWindow.ButtonRotation()
end






