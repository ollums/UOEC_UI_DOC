----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MobileHealthBar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MobileHealthBar.hasWindow = {}
MobileHealthBar.windowDisabled = {}
MobileHealthBar.mouseOverId = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MobileHealthBar.CreateHealthBar(mobileId)
    local windowName = "MobileHealthBar_"..mobileId
	
	-- Create and register if doesn't exist
	if( DoesWindowNameExist(windowName) == false ) then
		CreateWindowFromTemplate(windowName, "MobileHealthBar", "Root")
		
		WindowSetId(windowName, mobileId)
		WindowSetId(windowName.."CloseButton", mobileId)
		
		MobileHealthBar.RegisterHealthBar(windowName)
		
		LabelSetText( windowName.."HealthBarLabel", L"H:" )
		
		Interface.DestroyWindowOnClose[windowName] = true
	end

	MobileHealthBar.UpdateStatus(mobileId)
	MobileHealthBar.UpdateName(mobileId)
	MobileHealthBar.UpdateHealthBarColor(mobileId)
	MobileHealthBar.UpdateHealthBarState(mobileId)

	MobileHealthBar.HandleAnchorWindow(windowName)
	WindowAssignFocus(windowName, true)
end

--Sets the Window close to where the player dragged their mouse
function MobileHealthBar.HandleAnchorWindow(healthWindow)
	local propWindowX = 0
	local propWindowY = 0
	local scaleFactor = 1/InterfaceCore.scale	
	
	local propWindowWidth = 180
	local propWindowHeight = 38
	
	-- Set the position
	local mouseX = SystemData.MousePosition.x - 30
	if mouseX + (propWindowWidth / scaleFactor) > SystemData.screenResolution.x then
		propWindowX = mouseX - (propWindowWidth / scaleFactor)
	else
		propWindowX = mouseX
	end
		
	local mouseY = SystemData.MousePosition.y - 15
	if mouseY + (propWindowHeight / scaleFactor) > SystemData.screenResolution.y then
		propWindowY = mouseY - (propWindowHeight / scaleFactor)
	else
		propWindowY = mouseY
	end
	
	SnapUtils.StartWindowSnap(healthWindow)
	
	WindowSetOffsetFromParent(healthWindow, propWindowX * scaleFactor, propWindowY * scaleFactor)
end

function MobileHealthBar.RegisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
	
	WindowRegisterEventHandler(windowName, WindowData.MobileStatus.Event, "MobileHealthBar.HandleMobileStatusUpdate")
	WindowRegisterEventHandler(windowName, WindowData.MobileName.Event, "MobileHealthBar.HandleMobileNameUpdate")
	WindowRegisterEventHandler(windowName, WindowData.HealthBarColor.Event, "MobileHealthBar.HandleHealthBarColorUpdate")
	WindowRegisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW, "MobileHealthBar.HandleHealthBarStateUpdate")
	WindowRegisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW, "MobileHealthBar.HandleHealthBarStateUpdate")
	
	RegisterWindowData(WindowData.MobileStatus.Type, mobileId)
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
		
	MobileHealthBar.hasWindow[mobileId] = true
	MobileHealthBar.windowDisabled[mobileId] = false
	
	SnapUtils.SnappableWindows[windowName] = true
end

function MobileHealthBar.UnregisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
	
	WindowUnregisterEventHandler(windowName, WindowData.MobileStatus.Event)
	WindowUnregisterEventHandler(windowName, WindowData.MobileName.Event)
	WindowUnregisterEventHandler(windowName, WindowData.HealthBarColor.Event)
	WindowUnregisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW)
	WindowUnregisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW)
	
	UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
	UnregisterWindowData(WindowData.MobileName.Type, mobileId)
	UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)

	MobileHealthBar.hasWindow[mobileId] = nil
	MobileHealthBar.windowDisabled[mobileId] = nil
	
	SnapUtils.SnappableWindows[windowName] = nil
	
	if (MobileHealthBar.mouseOverId == mobileId) then
		MobileHealthBar.OnMouseOverEnd()
	end
end

function MobileHealthBar.HasWindow(mobileId)
	if( MobileHealthBar.hasWindow[mobileId] == true ) then
		return true
	end
	
	return false
end

function MobileHealthBar.GetWindowName(mobileId)
	return "MobileHealthBar_"..mobileId
end

function MobileHealthBar.HandleMobileStatusUpdate()
    MobileHealthBar.UpdateStatus(WindowData.UpdateInstanceId)
end

function MobileHealthBar.UpdateStatus(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		local windowName = "MobileHealthBar_"..mobileId

		--Set mobile's health status bar
		local curHealth = WindowData.MobileStatus[mobileId].CurrentHealth
		local maxHealth = WindowData.MobileStatus[mobileId].MaxHealth
		
		StatusBarSetCurrentValue( windowName.."HealthBar", curHealth )	
		StatusBarSetMaximumValue( windowName.."HealthBar", maxHealth )
	end
end

function MobileHealthBar.HandleMobileNameUpdate()
	if (IsMobile(WindowData.UpdateInstanceId)) then
		MobileHealthBar.UpdateName(WindowData.UpdateInstanceId)
	else
		DestroyWindow("MobileHealthBar_"..WindowData.UpdateInstanceId)
	end
end

function MobileHealthBar.UpdateName(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		if(WindowData.MobileName[mobileId] ~= nil) then
			local windowName = "MobileHealthBar_"..mobileId
			local data = WindowData.MobileName[mobileId]
			
			LabelSetText(windowName.."Name", data.MobName)
			WindowUtils.FitTextToLabel(windowName.."Name", data.MobName)
			NameColor.UpdateLabelNameColor(windowName.."Name", data.Notoriety+1)
		else
			LabelSetText(windowName.."Name", L"???" )
		end
	end
end

function MobileHealthBar.HandleHealthBarColorUpdate()
    MobileHealthBar.UpdateHealthBarColor(WindowData.UpdateInstanceId)
end

function MobileHealthBar.UpdateHealthBarColor(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		local windowName = "MobileHealthBar_"..mobileId
		local healthBarWindow = windowName.."HealthBar"
		
		HealthBarColor.UpdateHealthBarColor(healthBarWindow, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end

function MobileHealthBar.HandleHealthBarStateUpdate()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	MobileHealthBar.UpdateHealthBarState(mobileId)
end

function MobileHealthBar.UpdateHealthBarState(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		-- enable window
		if( IsHealthBarEnabled(mobileId) == true and MobileHealthBar.windowDisabled[mobileId]==true ) then
			local windowName = "MobileHealthBar_"..mobileId
			WindowSetShowing(windowName.."HealthBar", true)
			
			LabelSetTextColor(windowName.."HealthBarLabel", 255, 255, 255)
			
			MobileHealthBar.windowDisabled[mobileId] = false
		-- disable window
		elseif( IsHealthBarEnabled(mobileId) == false and MobileHealthBar.windowDisabled[mobileId]==false ) then
			local windowName = "MobileHealthBar_"..mobileId
			WindowSetShowing(windowName.."HealthBar",false)
			
			LabelSetTextColor(windowName.."Name", 128, 128, 128)
			LabelSetTextColor(windowName.."HealthBarLabel", 128, 128, 128)
			
			MobileHealthBar.windowDisabled[mobileId] = true
		end
	end
end

function MobileHealthBar.CloseWindow()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local windowName = "MobileHealthBar_"..mobileId
	DestroyWindow(windowName)
end

function MobileHealthBar.CloseWindowByMobileId(mobileId)
	local windowName = "MobileHealthBar_"..mobileId
	DestroyWindow(windowName)
end

function MobileHealthBar.OnShutdown()
    local windowName = WindowUtils.GetActiveDialog()
	MobileHealthBar.UnregisterHealthBar(windowName)
end

function MobileHealthBar.OnMouseDrag()
    SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
end

function MobileHealthBar.OnLButtonDown()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(MobileHealthBar.windowDisabled[mobileId] == false) then
		HandleSingleLeftClkTarget(mobileId)
	end
end

function MobileHealthBar.OnLButtonUp()
	if(SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	    DragSlotDropObjectToObject(mobileId)
	end
end

function MobileHealthBar.OnLButtonDblClk()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(MobileHealthBar.windowDisabled[mobileId] == false) then
		UserActionUseItem(mobileId,false)
	end
end

function MobileHealthBar.OnRButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(MobileHealthBar.windowDisabled[mobileId] == false) then
		RequestContextMenu(mobileId)
	end
end

function MobileHealthBar.OnMouseOver()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local windowName = "MobileHealthBar_"..mobileId
	if(MobileHealthBar.windowDisabled[mobileId] == false and WindowGetMoving(windowName) == false) then
		local itemData =
		{
			windowName = windowName,
			itemId = mobileId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}					
		ItemProperties.SetActiveItem(itemData)
		MobileHealthBar.mouseOverId = mobileId
	end
end

function MobileHealthBar.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	MobileHealthBar.mouseOverId = 0
end