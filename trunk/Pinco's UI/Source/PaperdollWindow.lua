----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PaperdollWindow = {}

PaperdollWindow.MenuRequest = 0
PaperdollWindow.CurrentBG = ""
PaperdollWindow.TID = {}
PaperdollWindow.TID.CLOTHING	= 1077861	--CLOTHING
PaperdollWindow.TID.ARMOR		= 1077862	--ARMOR
PaperdollWindow.TID.PAPERDOLL	= 1077863 	--PAPERDOLL
PaperdollWindow.TID.PROFILE 	= 1078990   --PROFILE

PaperdollWindow.PAPERDOLLSLOTID 	= {}

PaperdollWindow.PAPERDOLLSLOTID.FEET 		= 13
PaperdollWindow.PAPERDOLLSLOTID.HEAD 		= 1
PaperdollWindow.PAPERDOLLSLOTID.SHIRT 		= 14   
PaperdollWindow.PAPERDOLLSLOTID.PANTS 		= 19 
PaperdollWindow.PAPERDOLLSLOTID.KILT		= 11
PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR   = 17
PaperdollWindow.PAPERDOLLSLOTID.TALONS		= 13

PaperdollWindow.HUMAN = 1
PaperdollWindow.ELF = 2
PaperdollWindow.GARGOYLE = 3

PaperdollWindow.WINDOWSCALE = 1

PaperdollWindow.CurrentTab = 1

PaperdollWindow.Organize = false
PaperdollWindow.OrganizeBag = nil
PaperdollWindow.OrganizeParent = nil
PaperdollWindow.CanPickUp = true
PaperdollWindow.TimePassedSincePickUp = 0
PaperdollWindow.BlockClosing = false

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
ItemSlot = {}
ItemSlot.NUM_BUTTONS = 12

ItemSlot.BUTTONSTATE_EMPTY = 0
ItemSlot.BUTTONSTATE_NORMAL = 1
ItemSlot.BUTTONSTATE_ACTIVE = 2
ItemSlot.BUTTONSTATE_DISABLED = 3

ItemSlot.ItemIds = {}
ItemSlot.ObjectTypes = {}
ItemSlot.ButtonStates = {}

PaperdollWindow.OpenPaperdolls = {}
PaperdollWindow.ActivePaperdollImage = 0
PaperdollWindow.ActivePaperdollObject = 0
PaperdollWindow.ArmorSlots = 12

PaperdollWindow.Locked = false

PaperdollWindow.BlankSlot = {}
PaperdollWindow.BlankSlot[1]  = { SlotNameTid = 1079897, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[2]  = { SlotNameTid = 1079898, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[3]  = { SlotNameTid = 1079899, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[4]  = { SlotNameTid = 1079900, SlotDescTid = 1079917 }
PaperdollWindow.BlankSlot[5]  = { SlotNameTid = 1079901, SlotDescTid = 1079918 }
PaperdollWindow.BlankSlot[6]  = { SlotNameTid = 1079902, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[7]  = { SlotNameTid = 1079903, SlotDescTid = 1079919 }
PaperdollWindow.BlankSlot[8]  = { SlotNameTid = 1079904, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[9]  = { SlotNameTid = 1079905, SlotDescTid = 1079920 }
PaperdollWindow.BlankSlot[10] = { SlotNameTid = 1079906, SlotDescTid = 1079917 }
PaperdollWindow.BlankSlot[11] = { SlotNameTid = 1079907, SlotDescTid = 1079916, SlotNameTidTwo = 1115375}
PaperdollWindow.BlankSlot[12] = { SlotNameTid = 1079908, SlotDescTid = 1079921 }
PaperdollWindow.BlankSlot[13] = { SlotNameTid = 1079909, SlotDescTid = nil, SlotNameTidTwo = 1115377}
PaperdollWindow.BlankSlot[14] = { SlotNameTid = 1079910, SlotDescTid = nil }
PaperdollWindow.BlankSlot[15] = { SlotNameTid = 1079911, SlotDescTid = nil }
PaperdollWindow.BlankSlot[16] = { SlotNameTid = 1079912, SlotDescTid = nil }
PaperdollWindow.BlankSlot[17] = { SlotNameTid = 1079913, SlotDescTid = nil, SlotNameTidTwo = 1115376 }
PaperdollWindow.BlankSlot[18] = { SlotNameTid = 1079914, SlotDescTid = nil }
PaperdollWindow.BlankSlot[19] = { SlotNameTid = 1079915, SlotDescTid = nil }

---------------------------------------------------------------------
function PaperdollWindow.OnShown()
	local id = WindowGetId(SystemData.ActiveWindow.name)
	
	if (EnhancePack.BlockOthersPaperdoll and id ~= WindowData.PlayerStatus.PlayerId) or EnhancePack.PaperdollRequest == SystemData.ActiveWindow.name then
		WindowSetShowing(SystemData.ActiveWindow.name, false)
		if (EnhancePack.PaperdollRequest == SystemData.ActiveWindow.name) then
			EnhancePack.UpdateTargetDetails()
		end
		EnhancePack.PaperdollRequest = nil
		if id ~= WindowData.CurrentTarget.TargetId then
			UnregisterWindowData(WindowData.Paperdoll.Type,id)	
		end
		return
	end
	
	
end

function PaperdollWindow.CountPaperdollData()
	local a = 0
	for key, value in pairs(WindowData.Paperdoll) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function PaperdollWindow.Initialize()	
	local id = SystemData.Paperdoll.Id
	
	local windowName = "PaperdollWindow"..id
	WindowSetShowing(windowName, false)
	Interface.DestroyWindowOnClose[windowName] = true

	RegisterWindowData(WindowData.Paperdoll.Type,id)
	RegisterWindowData(WindowData.PlayerStatus.Type,0)

	WindowRegisterEventHandler( windowName, WindowData.Paperdoll.Event, "PaperdollWindow.HandleUpdatePaperdollEvent")
	WindowRegisterEventHandler( windowName, SystemData.Events.UPDATE_CHAR_PROFILE, "PaperdollWindow.UpdateCharProfile")
	
	WindowSetId(windowName, id)
	WindowSetId(windowName.."ToggleInventory", id)
	
	PaperdollWindow.OpenPaperdolls[id] = true
	
	--local scale = WindowGetScale(windowName) * PaperdollWindow.WINDOWSCALE
	--WindowSetScale(windowName, scale )
	
	EnhancePack.LoadScale( windowName )
	
	--When the paperdoll first gets created with item slots
	PaperdollWindow.UpdatePaperdoll(windowName,id)
	
	ButtonSetText(windowName.."TabButton2", EnhancePack.GetStringFromTid(PaperdollWindow.TID.CLOTHING))

	--ButtonSetText(windowName.."TabButton1", L"Character")
	--ButtonSetText(windowName.."TabButton3", EnhancePack.GetStringFromTid(PaperdollWindow.TID.PROFILE) )
WindowSetShowing(windowName.."TabButton1", false)
	WindowSetShowing(windowName.."TabButton2", false)
WindowSetShowing(windowName.."TabButton3", false)
	
	PaperdollWindow.CurrentTab = 1
	PaperdollWindow.UnselectAllTabs(windowName, id, 3)
	PaperdollWindow.SelectTab(windowName, 1)
	
	--WindowUtils.SetActiveDialogTitle( GetStringFromTid(PaperdollWindow.TID.PAPERDOLL) )
	
	-- set the bar at the bottom to the full name
	if( SystemData.Paperdoll.Name ~= nil ) then
		SystemData.Paperdoll.Name = wstring.gsub(SystemData.Paperdoll.Name, L", ", L"<BR>")
		LabelSetText(windowName.."TitleName",SystemData.Paperdoll.Name)
	end
	
	WindowSetShowing(windowName.."ToggleCharacterSheet", false)
	WindowSetShowing(windowName.."ToggleCharacterAbilities", false)

	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players backpack then use the saved position
	if( id == playerId ) then
		if(WindowData.Paperdoll[id].backpackId ~= nil ) then
			local backpackName = "ContainerWindow_"..WindowData.Paperdoll[id].backpackId
			if DoesWindowNameExist(backpackName) and WindowGetShowing(backpackName) then
				ButtonSetPressedFlag( windowName.."ToggleInventory", true )
			end		
		end
		WindowSetShowing(windowName.."ToggleCharacterSheet", true)
		WindowSetShowing(windowName.."ToggleCharacterAbilities", true)
		WindowSetShowing(windowName.."TitleOrganize", true)
		WindowUtils.RestoreWindowPosition(windowName, false, "pdollself")
		local characterSheetName = windowName.."ToggleCharacterSheet"
		local showing = WindowGetShowing("CharacterSheet")
		ButtonSetPressedFlag( characterSheetName, showing )
		EnhancePack.PaperdollOpen = true
		CustomSettings.SaveBoolean( "EnhancePackPaperdollOpen",EnhancePack.PaperdollOpen )
		
		ButtonSetPressedFlag("MenuBarWindowTogglePaperdoll",true)
		
    else
		--WindowSetShowing(windowName.."TabWindow1ToggleVirtues",false)
		WindowSetShowing(windowName.."TitleOrganize", false)
		WindowUtils.RestoreWindowPosition(windowName, false,"PaperdollOthers" )
	end

	RegisterWindowData(WindowData.MobileStatus.Type, id)	
	
	if (WindowData.MobileStatus[id].Race == PaperdollWindow.GARGOYLE) then
		WindowSetShowing(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.SHIRT, false)
		--WindowClearAnchors(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.SHIRT+1)
		--WindowAddAnchor(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.SHIRT+1, "topleft", windowName.."TabWindow1", "topleft", 2, 113)
		--WindowClearAnchors(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET)
		--WindowAddAnchor(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET, "topleft", windowName.."TabWindow1", "topleft", 2, 54)
		
		WindowSetShowing(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.PANTS, false)

		WindowSetShowing(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD, false)
		--WindowClearAnchors(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD+1)
		--WindowAddAnchor(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD+1, "topleft", windowName.."TabWindow1", "topleft", 2, 54)
		
		WindowClearAnchors(windowName.."TabWindow1ItemSlotButton7")
		WindowAddAnchor(windowName.."TabWindow1ItemSlotButton7", "topright", windowName.."TabWindow1", "topright", 2, 84)
		
		WindowClearAnchors(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET)
		WindowAddAnchor(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET, "bottomleft", windowName.."TabWindow1ItemSlotButton11", "topleft", 0, 0)
		WindowClearAnchors(windowName.."TabWindow1ItemSlotButton4")
		WindowAddAnchor(windowName.."TabWindow1ItemSlotButton4", "bottomleft", windowName.."TabWindow1ItemSlotButton3", "topleft", 0, 0)
		
		local button
		button = windowName.."TabWindow1ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.KILT)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots", UI.Kilt.STATE_NORMAL.x, UI.Kilt.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots", UI.Kilt.STATE_NORMAL_HIGHLITE.x, UI.Kilt.STATE_NORMAL_HIGHLITE.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots", UI.Kilt.STATE_PRESSED.x, UI.Kilt.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots", UI.Kilt.STATE_PRESSED_HIGHLITE.x, UI.Kilt.STATE_PRESSED_HIGHLITE.y)
			
		button = windowName.."TabWindow1ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots", UI.Wingarmor.STATE_NORMAL.x, UI.Wingarmor.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots", UI.Wingarmor.STATE_NORMAL_HIGHLITE.x, UI.Wingarmor.STATE_NORMAL_HIGHLITE.y)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots", UI.Wingarmor.STATE_PRESSED.x, UI.Wingarmor.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots", UI.Wingarmor.STATE_PRESSED_HIGHLITE.x, UI.Wingarmor.STATE_PRESSED_HIGHLITE.y)
		
		button = windowName.."TabWindow1ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.TALONS)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots", UI.Talons.STATE_NORMAL.x, UI.Talons.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots", UI.Talons.STATE_NORMAL_HIGHLITE.x, UI.Talons.STATE_NORMAL_HIGHLITE.y)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots", UI.Talons.STATE_PRESSED.x, UI.Talons.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots", UI.Talons.STATE_PRESSED_HIGHLITE.x, UI.Talons.STATE_PRESSED_HIGHLITE.y)		
		
	end
	SnapUtils.SnappableWindows[windowName] = true
	
	
	if (id ~= WindowData.PlayerStatus.PlayerId) then
		WindowSetShowing(windowName .. "ToggleLock", false)
		WindowSetShowing(windowName .. "HelpButton", false)
	else
		WindowSetShowing(windowName .. "ToggleLock", true)
		WindowSetShowing(windowName .. "HelpButton", true)
	end
	
	if (EnhancePack.BlockOthersPaperdoll and id ~= WindowData.PlayerStatus.PlayerId) then
		DestroyWindow(windowName)
		SnapUtils.SnappableWindows[windowName] = nil
	end
	WindowSetShowing(windowName, true)
	ButtonSetPressedFlag(windowName .. "ToggleLock",PaperdollWindow.Locked)
	PaperdollWindow.SwitchLabelTexture()
	
end

function PaperdollWindow.LockTooltip()
	if ( PaperdollWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 5))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 6))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PaperdollWindow.SwitchLabelTexture()
	for id, val in pairs(PaperdollWindow.OpenPaperdolls) do
		local windowName = "PaperdollWindow"..id
		if (DoesWindowNameExist(windowName)) then
			DynamicImageSetTexture(windowName .."TitleBg", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Label", 0, 0 )
			LabelSetTextColor(windowName .."TitleName", MiniTexturePack.DB[MiniTexturePack.Current].PaperdollLabelColor.r, MiniTexturePack.DB[MiniTexturePack.Current].PaperdollLabelColor.g, MiniTexturePack.DB[MiniTexturePack.Current].PaperdollLabelColor.b)
		end
	end
	
end

function PaperdollWindow.Lock()
	PaperdollWindow.Locked = not PaperdollWindow.Locked 
	CustomSettings.SaveBoolean( "PdollWindowLocked", PaperdollWindow.Locked  )
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	ButtonSetPressedFlag(windowName .. "ToggleLock",PaperdollWindow.Locked)
end

function PaperdollWindow.CloseWindow()
	if PaperdollWindow.BlockClosing then
		PaperdollWindow.BlockClosing = false
		return
	end
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	if (id == WindowData.PlayerStatus.PlayerId) then
		EnhancePack.PaperdollOpen = false
		CustomSettings.SaveBoolean( "EnhancePackPaperdollOpen",EnhancePack.PaperdollOpen )
	end
	UO_DefaultWindow.CloseDialog()
end

--function PaperdollWindow.VirtuesTooltip()
--		btnName = SystemData.ActiveWindow.name
--		Tooltips.CreateTextOnlyTooltip(btnName, GetStringFromTid(1077439))
--		Tooltips.Finalize()
--		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
--end
		
		
function PaperdollWindow.Shutdown()
	PaperdollWindow.CurrentBG = ""
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	
		
	-- only save the position of the players character window
	local playerId = WindowData.PlayerStatus.PlayerId
	
	if( paperdollId == playerId ) then
		WindowUtils.SaveWindowPosition(windowName, false, "pdollself")
		PaperdollWindow.Organize = false
		if ( DoesWindowNameExist("UndressWarningDialog")) then
			DestroyWindow("UndressWarningDialog")
		end
		ButtonSetPressedFlag("MenuBarWindowTogglePaperdoll",false)
		
		-- update profile text
		--if(PaperdollWindow.CurrentTab == 3) then
		--	local infoText = TextEditBoxGetText(windowName.."TabWindow3ProfileEditText")
	--		UpdateCharProfile(paperdollId,infoText)
	--	end
	else
		WindowUtils.SaveWindowPosition(windowName, false, "PaperdollOthers")
	end
	
	if paperdollId ~= WindowData.CurrentTarget.TargetId then
		UnregisterWindowData(WindowData.Paperdoll.Type,paperdollId)	
	end
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	UnregisterWindowData(WindowData.MobileStatus.Type, paperdollId)		
	PaperdollWindow.OpenPaperdolls[paperdollId] = nil
	
	if( ItemProperties.GetCurrentWindow() == windowName ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	-- removes the paperdoll from uo_interface's list of open paperdolls
	ClosePaperdoll(paperdollId)
	SnapUtils.SnappableWindows[windowName] = nil
	
end

function PaperdollWindow.OnMouseDrag()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	windowName = "PaperdollWindow"..paperdollId
	if (paperdollId == WindowData.PlayerStatus.PlayerId) then
		if (not PaperdollWindow.Locked ) then
			SnapUtils.StartWindowSnap(windowName, PaperdollWindow.WINDOWSCALE)
			WindowSetMoving(windowName,true)
		else
			WindowSetMoving(windowName,false)
		end
	end
	
end

function PaperdollWindow.HandleUpdatePaperdollEvent()
	
    PaperdollWindow.UpdatePaperdoll(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)
end

function PaperdollWindow.UpdatePaperdoll(windowName,paperdollId, NotLoadScale)
	if (not DoesWindowNameExist(windowName)) then
		return
	end
	
	if( paperdollId == WindowGetId(windowName) ) then
		local elementIcon
		local elementBg
		local element
		local topButton 
		local pdscale = WindowGetScale(windowName)
		WindowSetScale(windowName.. "ToggleProfile", pdscale - (pdscale * 0.45))
		WindowSetScale(windowName.. "ToggleLock", pdscale - (pdscale * 0.45))
		WindowSetScale(windowName.. "ToggleCharacterAbilities", pdscale - (pdscale * 0.20))
		WindowSetScale(windowName.. "ToggleCharacterSheet", pdscale - (pdscale * 0.20))
		WindowSetScale(windowName.. "ToggleInventory", pdscale - (pdscale * 0.05))

		
		RegisterWindowData(WindowData.Paperdoll.Type, paperdollId)
		for index = 1, WindowData.Paperdoll[paperdollId].numSlots  do
			
			--if( index <= PaperdollWindow.ArmorSlots) then
				element = windowName.."TabWindow1ItemSlotButton"..tostring(index)
				elementIcon = windowName.."TabWindow1ItemSlotButton"..tostring(index).."SquareIcon"
				elementBg =  windowName.."TabWindow1ItemSlotButton"..tostring(index).."SquareBg"
				topButton = windowName.."TabWindow1ItemSlotButton"..index
				
				WindowSetScale(element , pdscale - (pdscale * 0.15) )
			--else
			--	elementIcon = windowName.."TabWindow2ItemSlotButton"..tostring(index).."SquareIcon"
			--	elementBg =  windowName.."TabWindow2ItemSlotButton"..tostring(index).."SquareBg"
			--	topButton = windowName.."TabWindow2ItemSlotButton"..index
			--end
			
			--Debug.Print("Index = "..index.." window name = "..tostring(elementIcon))
			WindowSetAlpha(elementBg, 0.8)	
			
			if (WindowData.Paperdoll[paperdollId][index].slotId == 0) then
				ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_EMPTY
				ItemSlot.ItemIds[index] = 0
				ItemSlot.ObjectTypes[index] = 0	
				WindowSetShowing(elementIcon, false)
				WindowSetShowing(elementBg, false)			
				if (index == 12) then
					WindowSetScale(windowName.."TabWindow1ItemSlotButton12" , pdscale  )
					ButtonSetTexture(windowName.."TabWindow1ItemSlotButton12", Button.ButtonState.NORMAL, "paperdoll_slots", 174, 116)
					ButtonSetTexture(windowName.."TabWindow1ItemSlotButton12", Button.ButtonState.PRESSED, "paperdoll_slots", 174, 116)
					ButtonSetTexture(windowName.."TabWindow1ItemSlotButton12", Button.ButtonState.DISABLED, "paperdoll_slots", 174, 116)
					WindowSetShowing( windowName.."TabWindow1ItemSlotButton12SquareBg", false)
				end	
			else
				--Debug.Print(" window name slotId textureName = "..tostring(WindowData.Paperdoll[paperdollId][index].slotTextureName))
				
				ItemSlot.ItemIds[index] = WindowData.Paperdoll[paperdollId][index].slotId
				WindowData.UpdateInstanceId = ItemSlot.ItemIds[index]
				HotbarSystem.UpdateItemSlot()
				ItemSlot.ObjectTypes[index] = WindowData.Paperdoll[paperdollId][index].slotTextureName
				ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_NORMAL
	
				data = WindowData.Paperdoll[paperdollId][index]
				EquipmentData.UpdateItemIcon(elementIcon, data)			
						
				-- DAB TODO UPDATE ANCHORS
				parent = WindowGetParent(elementIcon)
				local w, h = data.newWidth, data.newHeight

				WindowClearAnchors(elementIcon)
				WindowAddAnchor(elementIcon, "topleft", parent, "topleft", (58-w)/2, (58-h)/2)
				
				WindowSetShowing(elementIcon, true)
				WindowSetShowing(elementBg, true)
				if (index == 12) then
					WindowSetScale(windowName.."TabWindow1ItemSlotButton12" , pdscale + (pdscale * 0.7) )
					ButtonSetTexture(windowName.."TabWindow1ItemSlotButton12", Button.ButtonState.NORMAL, "", 0, 0)
					ButtonSetTexture(windowName.."TabWindow1ItemSlotButton12", Button.ButtonState.PRESSED, "", 0, 0)
					ButtonSetTexture(windowName.."TabWindow1ItemSlotButton12", Button.ButtonState.DISABLED, "", 0, 0)
					WindowSetShowing( windowName.."TabWindow1ItemSlotButton12SquareBg", false)
				end	
			end	
		end
		
		
		local textureData = SystemData.PaperdollTexture[paperdollId]
		if textureData ~= nil then
			
			local tabNames = { windowName.."TabWindow1", windowName.."TabWindow2" }
			
			-- Check if the paperdoll texture has changed by comparing old/new dimensions
			local texWidth, texHeight = WindowGetDimensions(tabNames[1])
			local newWidth, newHeight = textureData.Width, textureData.Height
			if texWidth ~= newWidth or texHeight ~= newHeight then
				
				local tabTextureNames = { tabNames[1].."Texture", tabNames[2].."Texture" }
				local tabLegacyTextureNames = { tabNames[1].."LegacyTexture", tabNames[2].."LegacyTexture" }
				
				local visibleTextures, hiddenTextures
				local showBackground
				
				if textureData.IsLegacy == 1 then
					visibleTextures = tabLegacyTextureNames
					hiddenTextures = tabTextureNames
					showBackground = true
					newWidth = newWidth * 2
					newHeight = newHeight * 2
				else
					visibleTextures = tabTextureNames
					hiddenTextures = tabLegacyTextureNames
					showBackground = false
				end
				
				local paperdollTextureName = "paperdoll_texture"..paperdollId
				for index, paperdollTexture in ipairs(visibleTextures) do
					WindowSetShowing(paperdollTexture, true)
					WindowSetHandleInput(paperdollTexture, true)
					WindowSetDimensions(paperdollTexture, newWidth, newHeight)
					WindowClearAnchors(paperdollTexture)
					WindowAddAnchor(paperdollTexture, "center", tabNames[index], "topleft", textureData.xOffset, textureData.yOffset + 30)	
					DynamicImageSetTexture(paperdollTexture, paperdollTextureName, 0, 0)
				end
				
				for index, paperdollTexture in ipairs(hiddenTextures) do
					WindowSetShowing(paperdollTexture, false)
					WindowSetHandleInput(paperdollTexture, false)
					DynamicImageSetTexture(paperdollTexture, "", 0, 0)
				end
				
				--local tabBackgroundNames = { tabNames[1].."BlackBackground", tabNames[2].."BlackBackground" }
				--for index, paperdollBackground in ipairs(tabBackgroundNames) do
				--	WindowSetShowing(paperdollBackground, showBackground)
				--end
				
			end

		end	
	end
	if (not NotLoadScale) then
		WindowSetScale(windowName, SystemData.Settings.Interface.customUiScale * 0.80)
		local paperdollId = WindowGetId(windowName)
		PaperdollWindow.UpdatePaperdoll(windowName,paperdollId, true)
		EnhancePack.LoadScale( windowName )
	end
	
	local playerId = WindowData.PlayerStatus.PlayerId
	if(WindowGetShowing("PropertiesInfoWindow") and not PropertiesInfo.InSearch) then
		PropertiesInfo.Restart()
	end
	
end
function PaperdollWindow.GetMouseSlotId()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	local slotId = GetPaperdollObject(paperdollId, WindowGetScale(windowName))
	return paperdollId, slotId
end

function PaperdollWindow.OnPaperdollTextureLButtonDown()
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()
	
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and slotId ~= 0 )
	then
		RegisterWindowData(WindowData.ObjectInfo.Type, slotId)
        HandleSingleLeftClkTarget(slotId)
		UnregisterWindowData(WindowData.ObjectInfo.Type, slotId)
		return
	end
	
	--Debug.Print("PaperdollWindow.OnPaperdollTextureLButtonDblClk()"..paperdollId)
	if( slotId ~= 0 ) then	
		DragSlotSetObjectMouseClickData(slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
	end
end

function PaperdollWindow.OnPaperdollTextureLButtonUp()
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()

	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		if( slotId ~= 0 ) then
			DragSlotDropObjectToPaperdollEquipment(slotId)
		else
			DragSlotDropObjectToPaperdoll(paperdollId)
		end
	end
end

function PaperdollWindow.OnPaperdollTextureLButtonDblClk()
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()
	UserActionUseItem(slotId,false)
end


function PaperdollWindow.OnPaperdollTextureRButtonDown()
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()

	
	if( slotId ~= 0 ) then
		PaperdollWindow.MenuRequest = slotId
		RequestContextMenu(slotId)
	end
end

			
function PaperdollWindow.OnPaperdollTextureMouseOver()
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()
	PaperdollWindow.ActivePaperdollImage = paperdollId
end

function PaperdollWindow.OnPaperdollTextureMouseEnd()
	PaperdollWindow.ActivePaperdollImage = 0
	PaperdollWindow.ActivePaperdollObject = 0

	ItemProperties.ClearMouseOverItem()
end

function PaperdollWindow.SlotLButtonDown()
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotId = WindowData.Paperdoll[paperdollId][slotIndex].slotId
	
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and slotId ~= 0 )
	then
		RegisterWindowData(WindowData.ObjectInfo.Type, slotId)
		HandleSingleLeftClkTarget(slotId)		
		UnregisterWindowData(WindowData.ObjectInfo.Type, slotId)
		return
	end

	DragSlotSetObjectMouseClickData(slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
end

function PaperdollWindow.SlotLButtonUp()
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local objectId = WindowData.Paperdoll[paperdollId][slotIndex].slotId
	
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		if( objectId ~= 0 ) then
			DragSlotDropObjectToPaperdollEquipment(objectId)
		else
			DragSlotDropObjectToPaperdoll(paperdollId)
		end
	end
end

function PaperdollWindow.SlotLButtonDblClk()
    local dialog = WindowUtils.GetActiveDialog()
	local PaperdollId = WindowGetId(dialog)
	local SlotNum = WindowGetId(SystemData.ActiveWindow.name)
	local SlotId = WindowData.Paperdoll[PaperdollId][SlotNum].slotId	
	
	UserActionUseItem(SlotId,false)
end

function PaperdollWindow.SlotRButtonDown()
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotId = WindowData.Paperdoll[paperdollId][slotIndex].slotId

	local playerId = WindowData.PlayerStatus.PlayerId
	if( paperdollId == playerId and slotId ~= 0 ) then
		RequestContextMenu(slotId)
		PaperdollWindow.MenuRequest = slotId
		PaperdollWindow.BlockClosing = true
	end
end

function PaperdollWindow.ItemMouseOver()
	local SlotNum = WindowGetId(SystemData.ActiveWindow.name)
	local dialog = WindowUtils.GetActiveDialog()
	local PaperdollId = WindowGetId(dialog)
	local SlotId = WindowData.Paperdoll[PaperdollId][SlotNum].slotId
	local itemData
	local slotTitle

	if SlotId ~= 0 then
		itemData = {
			windowName = dialog,
			itemId = SlotId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
			detail = ItemProperties.DETAIL_LONG,
			data = WindowData.Paperdoll[PaperdollId][SlotNum]
		}
	elseif (WindowData.MobileStatus[PaperdollId]) then
		local EmptySlotBodyText		
		if ( ((WindowData.MobileStatus[PaperdollId].Race == PaperdollWindow.GARGOYLE) and ((PaperdollWindow.PAPERDOLLSLOTID.TALONS == SlotNum) or ( PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR == SlotNum) or (PaperdollWindow.PAPERDOLLSLOTID.KILT == SlotNum))) ) then											
				slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTidTwo)			
		else				
			if (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079914) then -- robe
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5061) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079912) then -- sash
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5062) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079910) then -- shirt
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5063) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079913) then -- cloak
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5064) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079915) then -- pants
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5065) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079908) then -- talisman
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5068) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079903) then -- earrings
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5069) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079901) then -- rings
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5057) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079905) then -- bracelet
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5056) 
			else
				slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTid )					
			end
				
		end				
		
		if (PaperdollWindow.BlankSlot[SlotNum].SlotDescTid) then			
			EmptySlotBodyText = GetStringFromTid(  PaperdollWindow.BlankSlot[SlotNum].SlotDescTid )
		else
			EmptySlotBodyText = L""			
		end
		
	-- Remove the next two lines of comments to show these only for the player's own paperdoll.
-- 		if( SystemData.Paperdoll.Id == WindowData.PlayerStatus.PlayerId ) then
			itemData = {
				windowName = "EmptyPaperdollSlot"..SlotNum,
				itemId = SlotNum,
				itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
				binding = L"",
				detail = ItemProperties.DETAIL_LONG,
				title = slotTitle,
				body = EmptySlotBodyText,
			}	
--		end 
	end
	ItemProperties.SetActiveItem(itemData)
	if (PaperdollId == WindowData.PlayerStatus.PlayerId) then
		ItemPropertiesEvaluator.PaperdollSlotOver = true
	end
end

function PaperdollWindow.Organizes()
	
	PaperdollWindow.OrganizeBag = nil
	PaperdollWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())
	if (not PaperdollWindow.Organize) then
		if (Organizer.Undresses_Cont[Organizer.ActiveUndress] == 0) then
			RequestTargetInfo()
			EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 584), 1152, true)
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "PaperdollWindow.OrganizeTargetInfoReceived")
		else
			PaperdollWindow.OrganizeBag = Organizer.Undresses_Cont[Organizer.ActiveUndress]
			PaperdollWindow.Organize = true
			return
		end
	end
	PaperdollWindow.Organize = false
end

function PaperdollWindow.OrganizeTargetInfoReceived()
	PaperdollWindow.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (PaperdollWindow.OrganizeBag and PaperdollWindow.OrganizeBag ~= 0) then
		PaperdollWindow.Organize = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
end

function PaperdollWindow.OrganizeTooltip()
	if (not PaperdollWindow.Organize) then
		local name = L"Undress " .. Organizer.ActiveUndress
		if (Organizer.Undresses_Desc[Organizer.ActiveUndress] ~= L"") then
			name = Organizer.Undresses_Desc[Organizer.ActiveUndress]
		end
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 586) .. L"\n".. UI.GetCliloc(SystemData.Settings.Language.type, 851) .. name)
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 588))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end


function PaperdollWindow.OrganizerContext()
	for i=1, Organizer.Undresses do
		local name = L"Use Undress " .. i
		if (Organizer.Undresses_Desc[i] ~= L"") then
			name = Organizer.Undresses_Desc[i]
		end
		ContextMenu.CreateLuaContextMenuItemWithString(name,0,i,2,Organizer.ActiveUndress == i)
	end
	ContextMenu.ActivateLuaContextMenu(PaperdollWindow.ContextMenuCallback)
end

function PaperdollWindow.ContextMenuCallback( returnCode, param )
	Organizer.ActiveUndress = returnCode
	CustomSettings.SaveNumber( "OrganizerActiveUndress" , Organizer.ActiveUndress )
end

function PaperdollWindow.OnUpdate(timePassed)
	
	if( PaperdollWindow.ActivePaperdollImage ~= 0 ) then
		local dialog = WindowUtils.GetActiveDialog()
		local windowName = "PaperdollWindow"..PaperdollWindow.ActivePaperdollImage
		local SlotId = GetPaperdollObject(PaperdollWindow.ActivePaperdollImage, WindowGetScale(windowName))
		

		if SlotId ~= 0 and (PaperdollWindow.ActivePaperdollObject == 0 or
		                   PaperdollWindow.ActivePaperdollObject ~= SlotId) then
			PaperdollWindow.ActivePaperdollObject = SlotId
			local itemData = { windowName = dialog,
								itemId = SlotId,
								itemType = WindowData.ItemProperties.TYPE_ITEM,
								detail = ItemProperties.DETAIL_LONG }
			
			ItemProperties.SetActiveItem(itemData)
			ItemPropertiesEvaluator.PaperdollSlotOver = true
		elseif SlotId == 0 and PaperdollWindow.ActivePaperdollObject ~= 0 then
			PaperdollWindow.ActivePaperdollObject = 0
			ItemProperties.ClearMouseOverItem()
		end
	end
	
	if(PaperdollWindow.CanPickUp == false) then
		PaperdollWindow.TimePassedSincePickUp = PaperdollWindow.TimePassedSincePickUp + timePassed
		if(PaperdollWindow.TimePassedSincePickUp >= 1.2) then
			PaperdollWindow.CanPickUp = true	
		end
	end
	
	if (PaperdollWindow.Organize == true and SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		DragSlotDropObjectToObjectAtIndex(PaperdollWindow.OrganizeBag,0)
	elseif (PaperdollWindow.Organize == true and PaperdollWindow.CanPickUp == true and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM) then
		local paperdollId = WindowData.PlayerStatus.PlayerId
		for index = 1, WindowData.Paperdoll[paperdollId].numSlots  do

			if (WindowData.Paperdoll[paperdollId][index].slotId ~= 0) then
				for j=1,  Organizer.Undresses_Items[Organizer.ActiveUndress] do
					local itemL = Organizer.Undress[Organizer.ActiveUndress][j]
						
					if(itemL.id > 0  and itemL.id == WindowData.Paperdoll[paperdollId][index].slotId) then
						DragSlotSetObjectMouseClickData(WindowData.Paperdoll[paperdollId][index].slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
						PaperdollWindow.TimePassedSincePickUp = 0
						PaperdollWindow.CanPickUp = false
						return
					end
				end
					
				
			end
		end
		PaperdollWindow.Organize = false
	end
	
	if (PaperdollWindow.Organize and not DoesWindowNameExist("UndressWarningDialog")) then
		local Warning = 
			{
				windowName = "UndressWarning",
				title = UI.GetCliloc(SystemData.Settings.Language.type, 593),
				body= UI.GetCliloc(SystemData.Settings.Language.type, 594),
			}
			UO_StandardDialog.CreateDialog(Warning)	
	elseif (not PaperdollWindow.Organize and DoesWindowNameExist("UndressWarningDialog")) then
		DestroyWindow("UndressWarningDialog")
	end
end

function PaperdollWindow.ToggleInventoryWindow()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local inventoryName = windowName.."ToggleInventory"
	if (ButtonGetDisabledFlag(inventoryName) ) then
		return
	end
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true  ) then
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		HandleSingleLeftClkTarget(backpackId)
		ButtonSetPressedFlag( inventoryName, true )
	elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.PlayerStatus.PlayerId)
	    ButtonSetPressedFlag( inventoryName, true )
	else
		local showing = false
		local playerId = WindowData.PlayerStatus.PlayerId
		if( id == playerId ) then
			MenuBarWindow.ToggleInventoryWindow()	
		elseif( WindowData.Paperdoll[id].backpackId ~= nil ) then
			UserActionUseItem(WindowData.Paperdoll[id].backpackId,false)
		end
		
		local backpackName = "ContainerWindow_"..WindowData.Paperdoll[id].backpackId
		if(DoesWindowNameExist(backpackName)) then
			showing = WindowGetShowing(backpackName)
		end
	end	
	--ButtonSetPressedFlag( inventoryName, not showing )	
end

function PaperdollWindow.ToggleTab()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local buttonId = WindowGetId(SystemData.ActiveWindow.name)
	local parent = "PaperdollWindow"..id
	
	PaperdollWindow.UnselectAllTabs(parent, id, 3)
	PaperdollWindow.SelectTab(parent, buttonId)
end

function PaperdollWindow.UnselectAllTabs(parent, id, numTabs)
	-- update profile text if paperdoll belongs to player
	local playerId = WindowData.PlayerStatus.PlayerId
	--if( id == playerId and PaperdollWindow.CurrentTab == 3 ) then
	--	local windowName = "PaperdollWindow"..id
		--local infoText = TextEditBoxGetText(windowName.."TabWindow3ProfileEditText")
	--	UpdateCharProfile(id,infoText)
	--end
	
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		local tabSelected = tabName.."TabSelected"
		local tabWindow = parent.."TabWindow"..i
		WindowSetShowing(tabSelected, false)
		WindowSetShowing(tabWindow, false)
		ButtonSetDisabledFlag(tabName, false)
	end
end

function PaperdollWindow.SelectTab(parent, tabNum)
	local tabName = parent.."TabButton"..tabNum
	local tabSelected= tabName.."TabSelected"
	local tabWindow = parent.."TabWindow"..tabNum
	WindowSetShowing(tabSelected, true)
	WindowSetShowing(tabWindow, true)
	ButtonSetDisabledFlag(tabName, true)
	
	local characterSheetButton = parent.."ToggleCharacterSheet"
	local characterAbilitiesButton = parent.."ToggleCharacterAbilities"
	local inventoryButton = parent.."ToggleInventory"
	
	PaperdollWindow.CurrentTab = tabNum
	
	if (PaperdollWindow.CurrentTab == 3) then
		-- get the character's profile data
		SystemData.ActiveObject.Id = WindowGetId(WindowUtils.GetActiveDialog())
		BroadcastEvent(SystemData.Events.REQUEST_OPEN_CHAR_PROFILE)
		
		WindowSetShowing(characterSheetButton, false)
		WindowSetShowing(characterAbilitiesButton, false)
		WindowSetShowing(inventoryButton, false)
	else
		WindowSetShowing(inventoryButton, true)
		local playerId = WindowData.PlayerStatus.PlayerId
		local id = WindowGetId(WindowUtils.GetActiveDialog())
		
		if (playerId == id) then
			WindowSetShowing(characterSheetButton, true)
			WindowSetShowing(characterAbilitiesButton, true)
		end
	end
end

function PaperdollWindow.ToggleCharacterSheet()
	EnhancePack.ToggleCharacterSheet()
	--local id = WindowGetId(WindowUtils.GetActiveDialog())
	--local windowName = "PaperdollWindow"..id
	--local characterSheetName = windowName.."ToggleCharacterSheet"
	--if (ButtonGetDisabledFlag(characterSheetName) ) then
	--	return
	--end
	--showing = WindowGetShowing("CharacterSheet")
	--local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players paperdoll toggle character sheet
	--if( id == playerId ) then
	--	ToggleWindowByName("CharacterSheet", "", nil)
	--	ButtonSetPressedFlag( characterSheetName, not showing )
	--end
end
function PaperdollWindow.ToggleProfile()
	
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..paperdollId
	ProfileWindow.Close()
	WindowSetShowing("ProfileWindow", not WindowGetShowing("ProfileWindow"))

	
	if (WindowGetShowing("ProfileWindow")) then
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			TextEditBoxSetFont(ProfileWindow.WindowName.."ProfileEditScrollWChildText",  "font_verdana")
			LabelSetFont(ProfileWindow.WindowName.."ProfileViewScrollChildText",  "font_verdana", 12)
		else
			TextEditBoxSetFont(ProfileWindow.WindowName.."ProfileEditScrollWChildText",  "UO_DefaultText")
			LabelSetFont(ProfileWindow.WindowName.."ProfileViewScrollChildText",  "UO_DefaultText", 12)
		end
		if (ProfileWindow.ProfileId ~= 0) then
			local windowName2 = "PaperdollWindow"..ProfileWindow.ProfileId
			ButtonSetPressedFlag( windowName2.."ToggleProfile",false)
		end
		LabelSetText(ProfileWindow.WindowName.."Age",L"")
		if( LabelGetText(windowName.."TitleName") ~= nil ) then
			LabelSetText(ProfileWindow.WindowName.."CharName",LabelGetText(windowName.."TitleName"))
		end
		WindowUtils.RestoreWindowPosition(ProfileWindow.WindowName)
		ProfileWindow.ProfileId = paperdollId				
	else
		ProfileWindow.Close()
	end
	ButtonSetPressedFlag( windowName.."ToggleProfile", WindowGetShowing("ProfileWindow" ))
end

function PaperdollWindow.ToggleProfileTooltip()
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, GetStringFromTid(3000179))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PaperdollWindow.ToggleCharacterAbilities()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local characterSheetName = windowName.."ToggleCharacterAbilities"
	if (ButtonGetDisabledFlag(characterSheetName) ) then
		return
	end
	showing = WindowGetShowing("CharacterAbilities")
	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players paperdoll toggle character sheet
	if( id == playerId ) then
		ToggleWindowByName("CharacterAbilities", "", nil)
		ButtonSetPressedFlag( characterSheetName, not showing )
	end
end

function PaperdollWindow.UpdateCharProfile(id)
	
    if( id == WindowData.CharProfile.Id ) then
       local tabName = ProfileWindow.WindowName --SystemData.ActiveWindow.name.."TabWindow3"
       
        if( id == WindowData.PlayerStatus.PlayerId ) then
			WindowSetShowing(ProfileWindow.WindowName.."ProfileView",false)
			WindowSetShowing(ProfileWindow.WindowName.."ProfileEdit",true)		
            TextEditBoxSetText(tabName.."ProfileEditScrollWChildText",WindowData.CharProfile.Info)
            local tid = L"This account is ~1_VAL~ months" --GetStringFromTid(1080020)
			if (wstring.find(WindowData.CharProfile.Age, L"old")) then
				tid = tid.. L" old"
			end
			if (wstring.find(WindowData.CharProfile.Age, L".")) then
				tid = tid.. L"."
			end
			local final = nil
			if (wstring.find(WindowData.CharProfile.Age, L"Can not determine this account's age")==nil) then
				local val = wstring.sub(tid, 1, wstring.find(tid , L"~1_VAL~") - 1)

				final = wstring.gsub(WindowData.CharProfile.Age, val, L"")

				val = wstring.sub(tid, wstring.find(tid , L"~1_VAL~") + 7)

				final = wstring.gsub(final, val, L"")
				
			end
			local finalText 
			
			if (final ~= nil) then
				local age = string.gsub(WStringToString(final), " ", "")

				age = tonumber(age)
				local year = math.floor(age / 12)
				local months = age - (year * 12)
				
				finalText = UI.GetCliloc(SystemData.Settings.Language.type, 1) .. L"\n"

				if (year > 0) then
					if (months > 0) then
						finalText = finalText .. year .. L" " .. UI.GetCliloc(SystemData.Settings.Language.type, 2) .. L" "  .. months .. L" " .. UI.GetCliloc(SystemData.Settings.Language.type, 3)
					else
						finalText = finalText .. year .. L" " .. UI.GetCliloc(SystemData.Settings.Language.type, 4)
					end
				else
					finalText = finalText  .. months .. L" " ..UI.GetCliloc(SystemData.Settings.Language.type, 3)
				end
			else
				finalText = L"Can not determine this account's age"
			end
            LabelSetText(tabName.."Age",finalText)
        else
			WindowSetShowing(ProfileWindow.WindowName.."ProfileEdit",false)		
			WindowSetShowing(ProfileWindow.WindowName.."ProfileView",true)
            LabelSetText(tabName.."ProfileViewScrollChildText",WindowData.CharProfile.Info)
            LabelSetText(tabName.."Age",L"")
            ScrollWindowUpdateScrollRect(tabName.."ProfileViewScroll")
        end
        ProfileWindow.ProfileLoaded = true
        ProfileWindow.Retries = 0
    else
		WindowSetShowing(ProfileWindow.WindowName.."ProfileEdit",false)		
		WindowSetShowing(ProfileWindow.WindowName.."ProfileView",true)
		ProfileWindow.ProfileLoaded = false
		
    end
end

function PaperdollWindow.OnMouseOverToggleCharacterAbilities()
	local text = GetStringFromTid(1112228)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PaperdollWindow.OnMouseOverToggleCharacterSheet()
	local text = GetStringFromTid(1077437)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function PaperdollWindow.OnMouseOverToggleInventory()
	local buttonName = SystemData.ActiveWindow.name
	local paperdollId = WindowGetId(buttonName)
	
	if(paperdollId == WindowData.PlayerStatus.PlayerId) then
		ItemProperties.OnPlayerBackpackMouseover()
	end
end