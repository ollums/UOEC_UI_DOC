----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PartyHealthBar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

PartyHealthBar.hasWindow = {}
PartyHealthBar.windowDisabled = {}

PartyHealthBar.mouseOverId = 0

PartyHealthBar.DEFAULT_WINDOW_START_X = 0
PartyHealthBar.DEFAULT_WINDOW_START_Y = 110

PartyHealthBar.WINDOW_WIDTH = 175
PartyHealthBar.WINDOW_HEIGHT = 55

PartyHealthBar.Spells = { Heal = 29, Cure = 11, Cleanse = 201, CloseWounds = 202 }
PartyHealthBar.SpellsTID = { Heal = 1015012, Cure = 1015023, Cleanse = 1060493, CloseWounds = 1060494 }

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function PartyHealthBar.CreateHealthBar(mobileId, useDefaultPos)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	local windowName = "PartyHealthBar_"..memberIndex
	
	-- Create and register if doesn't exist
	if( DoesWindowNameExist(windowName) == false ) then
		CreateWindowFromTemplate(windowName, "PartyHealthBar", "Root")
		
		WindowSetId(windowName, mobileId)
		WindowSetId(windowName.."CloseButton", mobileId)
		WindowSetId(windowName.."RedButton", mobileId)
		WindowSetId(windowName.."GreenButton", mobileId)
		
		LabelSetText(windowName.."Number", L""..memberIndex)
		
		PartyHealthBar.RegisterHealthBar(windowName)
		
		Interface.DestroyWindowOnClose[windowName] = true
	end

	PartyHealthBar.UpdateStatus(mobileId)
	PartyHealthBar.UpdateName(mobileId)
	PartyHealthBar.UpdateHealthBarColor(mobileId)

	WindowUtils.RestoreWindowPosition(windowName)

	PartyHealthBar.HandleAnchorWindow(windowName, useDefaultPos)
	WindowAssignFocus(windowName, true)
end

function PartyHealthBar.RefreshHealthBar(windowIndex, mobileId)
	local windowName = "PartyHealthBar_"..windowIndex
	
	if (DoesWindowNameExist(windowName)) then
		local currentId = WindowGetId(windowName)
		
		if (currentId ~= mobileId) then
			PartyHealthBar.CloseWindowByIndex(windowIndex)
			if (mobileId ~= 0) then
				PartyHealthBar.CreateHealthBar(mobileId, true)
			end
		end
	end
end

function PartyHealthBar.OnShutdown()
    local windowName = WindowUtils.GetActiveDialog()
	PartyHealthBar.UnregisterHealthBar(windowName)
end

--Sets the Window close to where the player dragged their mouse
function PartyHealthBar.HandleAnchorWindow(windowName, useDefaultPos)
	if (useDefaultPos == true) then
		if(WindowUtils.CanRestorePosition(windowName) == false) then
			local mobileId = WindowGetId(windowName)
			local windowIndex = HealthBarManager.GetMemberIndex(mobileId)
			
			local xPos = PartyHealthBar.DEFAULT_WINDOW_START_X + ( math.floor((windowIndex - 1) / 5) * PartyHealthBar.WINDOW_WIDTH )
			local yPos = PartyHealthBar.DEFAULT_WINDOW_START_Y + ( ((windowIndex - 1) % 5) * PartyHealthBar.WINDOW_HEIGHT )
			
			WindowSetOffsetFromParent(windowName, xPos, yPos)
			return
		end
		
		return
	end

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
	
	SnapUtils.StartWindowSnap(windowName)
	
	WindowSetOffsetFromParent(windowName, propWindowX * scaleFactor, propWindowY * scaleFactor)
end

function PartyHealthBar.RegisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
	
	WindowRegisterEventHandler(windowName, WindowData.MobileStatus.Event, "PartyHealthBar.HandleMobileStatusUpdate")
	WindowRegisterEventHandler(windowName, WindowData.MobileName.Event, "PartyHealthBar.HandleMobileNameUpdate")
	WindowRegisterEventHandler(windowName, WindowData.HealthBarColor.Event, "PartyHealthBar.HandleHealthBarColorUpdate")
	WindowRegisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW, "PartyHealthBar.HandleHealthBarStateUpdate")
	WindowRegisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW, "PartyHealthBar.HandleHealthBarStateUpdate")
	
	RegisterWindowData(WindowData.MobileStatus.Type, mobileId)
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
		
	PartyHealthBar.hasWindow[mobileId] = true
	PartyHealthBar.windowDisabled[mobileId] = false
	
	SnapUtils.SnappableWindows[windowName] = true
end

function PartyHealthBar.UnregisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
	
	WindowUnregisterEventHandler(windowName, WindowData.MobileStatus.Event)
	WindowUnregisterEventHandler(windowName, WindowData.MobileName.Event)
	WindowUnregisterEventHandler(windowName, WindowData.HealthBarColor.Event)
	WindowUnregisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW)
	WindowUnregisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW)
	
	UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
	UnregisterWindowData(WindowData.MobileName.Type, mobileId)
	UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)

	PartyHealthBar.hasWindow[mobileId] = nil
	PartyHealthBar.windowDisabled[mobileId] = nil
	
	SnapUtils.SnappableWindows[windowName] = nil
	
	WindowUtils.SaveWindowPosition(windowName)
	
	if (PartyHealthBar.mouseOverId == mobileId) then
		PartyHealthBar.OnMouseOverEnd()
	end
end

function PartyHealthBar.HasWindow(mobileId)
	if( PartyHealthBar.hasWindow[mobileId] == true ) then
		return true
	end
	
	return false
end

function PartyHealthBar.HasWindowByIndex(windowIndex)
	return DoesWindowNameExist("PartyHealthBar_"..windowIndex)
end

function PartyHealthBar.GetWindowName(mobileId)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	return "PartyHealthBar_"..memberIndex
end

function PartyHealthBar.HandleMobileStatusUpdate()
    PartyHealthBar.UpdateStatus(WindowData.UpdateInstanceId)
end

function PartyHealthBar.UpdateStatus(mobileId)
	if(PartyHealthBar.hasWindow[mobileId] == true) then
		local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
		local windowName = "PartyHealthBar_"..memberIndex

		--Set mobile's health status bar
		local curHealth = WindowData.MobileStatus[mobileId].CurrentHealth
		local maxHealth = WindowData.MobileStatus[mobileId].MaxHealth
		local curMana =  WindowData.MobileStatus[mobileId].CurrentMana
		local maxMana =  WindowData.MobileStatus[mobileId].MaxMana
		local curStamina = WindowData.MobileStatus[mobileId].CurrentStamina
		local maxStamina = WindowData.MobileStatus[mobileId].MaxStamina
		
		-- If current and max mana and stamina are zero and mobileId isn't dead, then updates have not come in yet
		if( curMana == 0 and maxMana == 0 and WindowData.MobileStatus[mobileId].IsDead == false) then
			curMana = 1
			maxMana = 1
		end
		if( curStamina == 0 and maxStamina == 0 and WindowData.MobileStatus[mobileId].IsDead == false) then
			curStamina = 1
			maxStamina = 1
		end
		
		StatusBarSetCurrentValue( windowName.."HealthBar", curHealth )
		StatusBarSetMaximumValue( windowName.."HealthBar", maxHealth )
		StatusBarSetCurrentValue( windowName.."ManaBar", curMana )
		StatusBarSetMaximumValue( windowName.."ManaBar", maxMana )
		StatusBarSetCurrentValue( windowName.."StaminaBar", curStamina )
		StatusBarSetMaximumValue( windowName.."StaminaBar", maxStamina )
	end
end

function PartyHealthBar.HandleMobileNameUpdate()
    PartyHealthBar.UpdateName(WindowData.UpdateInstanceId)
end

function PartyHealthBar.UpdateName(mobileId)
	if(PartyHealthBar.hasWindow[mobileId] == true) then
		if(WindowData.MobileName[mobileId] ~= nil) then
			local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
			local windowName = "PartyHealthBar_"..memberIndex
			local data = WindowData.MobileName[mobileId]
			
			LabelSetText(windowName.."Name", data.MobName)
			WindowUtils.FitTextToLabel(windowName.."Name", data.MobName)
			NameColor.UpdateLabelNameColor(windowName.."Name", data.Notoriety+1)
		else
			LabelSetText(windowName.."Name", L"???" )
		end
	end
end

function PartyHealthBar.HandleHealthBarColorUpdate()
    PartyHealthBar.UpdateHealthBarColor(WindowData.UpdateInstanceId)
end

function PartyHealthBar.UpdateHealthBarColor(mobileId)
	if(PartyHealthBar.hasWindow[mobileId] == true) then
		local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
		local windowName = "PartyHealthBar_"..memberIndex
		local healthBarWindow = windowName.."HealthBar"
		
		HealthBarColor.UpdateHealthBarColor(healthBarWindow, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end

function PartyHealthBar.HandleHealthBarStateUpdate()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	PartyHealthBar.UpdateHealthBarState(mobileId)
end

function PartyHealthBar.UpdateHealthBarState(mobileId)
	if(PartyHealthBar.hasWindow[mobileId] == true) then
		local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
		local windowName = "PartyHealthBar_"..memberIndex
		
		-- enable window
		if( IsHealthBarEnabled(mobileId) == true and PartyHealthBar.windowDisabled[mobileId]==true ) then
			WindowSetShowing(windowName.."HealthBar", true)
			WindowSetShowing(windowName.."ManaBar", true)
			WindowSetShowing(windowName.."StaminaBar", true)
			
			PartyHealthBar.windowDisabled[mobileId] = false
		-- disable window
		elseif( IsHealthBarEnabled(mobileId) == false and PartyHealthBar.windowDisabled[mobileId]==false ) then
			WindowSetShowing(windowName.."HealthBar",false)
			WindowSetShowing(windowName.."ManaBar", false)
			WindowSetShowing(windowName.."StaminaBar", false)
			
			LabelSetTextColor(windowName.."Name", 128, 128, 128)
			
			PartyHealthBar.windowDisabled[mobileId] = true
		end
	end
end

function PartyHealthBar.CloseWindow()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	local windowName = "PartyHealthBar_"..memberIndex
	DestroyWindow(windowName)
end

function PartyHealthBar.CloseWindowByIndex(windowIndex)
	local windowName = "PartyHealthBar_"..windowIndex
	DestroyWindow(windowName)
end

function PartyHealthBar.CloseWindowByMobileId(mobileId)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	local windowName = "PartyHealthBar_"..memberIndex
	DestroyWindow(windowName)
end

function PartyHealthBar.OnMouseDrag()
    SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
end

function PartyHealthBar.OnLButtonDown()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(PartyHealthBar.windowDisabled[mobileId] == false) then
		HandleSingleLeftClkTarget(mobileId)
	end
end

function PartyHealthBar.OnLButtonUp()
	if(SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	    DragSlotDropObjectToObject(mobileId)
	end
end

function PartyHealthBar.OnLButtonDblClk()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(PartyHealthBar.windowDisabled[mobileId] == false) then
		UserActionUseItem(mobileId,false)
	end
end

function PartyHealthBar.OnRButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(PartyHealthBar.windowDisabled[mobileId] == false) then
		RequestContextMenu(mobileId)
	end
end

function PartyHealthBar.OnMouseOver()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
	local windowName = "PartyHealthBar_"..memberIndex
	if(PartyHealthBar.windowDisabled[mobileId] == false and WindowGetMoving(windowName) == false) then
		local itemData =
		{
			windowName = windowName,
			itemId = mobileId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}					
		ItemProperties.SetActiveItem(itemData)
		PartyHealthBar.mouseOverId = mobileId
	end
end

function PartyHealthBar.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	PartyHealthBar.mouseOverId = 0
end

function PartyHealthBar.RedButton_OnLButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(mobileId) then
		local spellId = PartyHealthBar.Spells.Heal
		if (HealthBarManager.UseSchool == HealthBarManager.SpellSchools.CHIVALRY) then
			spellId = PartyHealthBar.Spells.CloseWounds
		end
		
		UserActionCastSpellOnId(spellId, mobileId)
	end
end

function PartyHealthBar.RedButton_OnMouseOver()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	
	local spellId = PartyHealthBar.Spells.Heal
	if (HealthBarManager.UseSchool == HealthBarManager.SpellSchools.CHIVALRY) then
		spellId = PartyHealthBar.Spells.CloseWounds
	end
	
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = spellId,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SPELL,
						detail = ItemProperties.DETAIL_SHORT }
						
	ItemProperties.SetActiveItem(itemData)
	PartyHealthBar.mouseOverId = mobileId
end

function PartyHealthBar.GreenButton_OnLButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(mobileId) then
		local spellId = PartyHealthBar.Spells.Cure
		if (HealthBarManager.UseSchool == HealthBarManager.SpellSchools.CHIVALRY) then
			spellId = PartyHealthBar.Spells.Cleanse
		end
		
		UserActionCastSpellOnId(spellId, mobileId)
	end
end

function PartyHealthBar.GreenButton_OnMouseOver()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	
	local spellId = PartyHealthBar.Spells.Cure
	if (HealthBarManager.UseSchool == HealthBarManager.SpellSchools.CHIVALRY) then
		spellId = PartyHealthBar.Spells.Cleanse
	end
	
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = spellId,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SPELL,
						detail = ItemProperties.DETAIL_SHORT }
						
	ItemProperties.SetActiveItem(itemData)
	PartyHealthBar.mouseOverId = mobileId
end