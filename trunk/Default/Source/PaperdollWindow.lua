----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PaperdollWindow = {}
PaperdollWindow.TID = {}
PaperdollWindow.TID.CLOTHING	= 1077861	--CLOTHING
PaperdollWindow.TID.ARMOR		= 1077862	--ARMOR
PaperdollWindow.TID.PAPERDOLL	= 1077863 	--PAPERDOLL
PaperdollWindow.TID.PROFILE 	= 1078990   --PROFILE

PaperdollWindow.PAPERDOLLSLOTID 	= {}

PaperdollWindow.PAPERDOLLSLOTID.HEAD 		= 1
PaperdollWindow.PAPERDOLLSLOTID.NECK		= 2
PaperdollWindow.PAPERDOLLSLOTID.KILT		= 11
PaperdollWindow.PAPERDOLLSLOTID.HANDS		= 11
PaperdollWindow.PAPERDOLLSLOTID.FEET 		= 13
PaperdollWindow.PAPERDOLLSLOTID.TALONS		= 13
PaperdollWindow.PAPERDOLLSLOTID.SHIRT 		= 14   
PaperdollWindow.PAPERDOLLSLOTID.WAIST		= 15
PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR   = 17
PaperdollWindow.PAPERDOLLSLOTID.CAPE	    = 17
PaperdollWindow.PAPERDOLLSLOTID.PANTS 		= 19

PaperdollWindow.HUMAN = 1
PaperdollWindow.ELF = 2
PaperdollWindow.GARGOYLE = 3

PaperdollWindow.isGargoyle = {}

PaperdollWindow.WINDOWSCALE = 0.86

PaperdollWindow.CurrentTab = 1

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

function PaperdollWindow.Initialize()	
	local id = SystemData.Paperdoll.Id
	local windowName = "PaperdollWindow"..id

	Interface.DestroyWindowOnClose[windowName] = true

	RegisterWindowData(WindowData.Paperdoll.Type,id)
	RegisterWindowData(WindowData.PlayerStatus.Type,0)
	RegisterWindowData(WindowData.MobileStatus.Type, id)

	WindowRegisterEventHandler( windowName, WindowData.Paperdoll.Event, "PaperdollWindow.HandleUpdatePaperdollEvent")
	WindowRegisterEventHandler( windowName, SystemData.Events.UPDATE_CHAR_PROFILE, "PaperdollWindow.UpdateCharProfile")
	
	WindowSetId(windowName, id)
	WindowSetId(windowName.."ToggleInventory", id)
	
	PaperdollWindow.OpenPaperdolls[id] = true
	PaperdollWindow.isGargoyle[id] = false
	
	local scale = WindowGetScale(windowName)
	WindowSetScale(windowName, scale * PaperdollWindow.WINDOWSCALE)
	
	--When the paperdoll first gets created with item slots
	PaperdollWindow.UpdatePaperdoll(windowName,id)
	
	ButtonSetText(windowName.."TabButton2", GetStringFromTid(PaperdollWindow.TID.CLOTHING))
	ButtonSetText(windowName.."TabButton1", GetStringFromTid(PaperdollWindow.TID.ARMOR) )
	ButtonSetText(windowName.."TabButton3", GetStringFromTid(PaperdollWindow.TID.PROFILE) )

	PaperdollWindow.CurrentTab = 1
	PaperdollWindow.UnselectAllTabs(windowName, id, 3)
	PaperdollWindow.SelectTab(windowName, 1)
	
	WindowUtils.SetActiveDialogTitle( GetStringFromTid(PaperdollWindow.TID.PAPERDOLL) )
	
	-- set the bar at the bottom to the full name
	if( SystemData.Paperdoll.Name ~= nil ) then
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
		WindowUtils.RestoreWindowPosition(windowName)
		local characterSheetName = windowName.."ToggleCharacterSheet"
		local showing = WindowGetShowing("CharacterSheet")
		ButtonSetPressedFlag( characterSheetName, showing )
		
		WindowSetShowing(windowName.."TabWindow3ProfileView",false)
		
		ButtonSetPressedFlag("MenuBarWindowTogglePaperdoll",true)
    else
        WindowSetShowing(windowName.."TabWindow3ProfileEdit",false)		
	end	
	
end

function PaperdollWindow.Shutdown()
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())
	windowName = "PaperdollWindow"..paperdollId
		
	-- only save the position of the players character window
	local playerId = WindowData.PlayerStatus.PlayerId
	if( paperdollId == playerId ) then
		WindowUtils.SaveWindowPosition(windowName)
		
		ButtonSetPressedFlag("MenuBarWindowTogglePaperdoll",false)
		
		-- update profile text
		if(PaperdollWindow.CurrentTab == 3) then
			local infoText = TextEditBoxGetText(windowName.."TabWindow3ProfileEditText")
			UpdateCharProfile(paperdollId,infoText)
		end
	end
	
	UnregisterWindowData(WindowData.Paperdoll.Type,paperdollId)
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	UnregisterWindowData(WindowData.MobileStatus.Type, paperdollId)		
	PaperdollWindow.OpenPaperdolls[paperdollId] = false
	PaperdollWindow.isGargoyle[paperdollId] = nil
	
	if( ItemProperties.GetCurrentWindow() == windowName ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	-- removes the paperdoll from uo_interface's list of open paperdolls
	ClosePaperdoll(paperdollId)
end

function PaperdollWindow.HandleUpdatePaperdollEvent()
    PaperdollWindow.UpdatePaperdoll(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)
end

function PaperdollWindow.UpdateRaceSpecificWindows(windowName,paperdollId)
	local newIsGargoyle = WindowData.MobileStatus[paperdollId].Race == PaperdollWindow.GARGOYLE
	if( PaperdollWindow.isGargoyle[paperdollId] == newIsGargoyle ) then
		return
	end
	
	PaperdollWindow.isGargoyle[paperdollId] = newIsGargoyle
	
	if (WindowData.MobileStatus[paperdollId].Race == PaperdollWindow.GARGOYLE) then
		WindowSetShowing(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.SHIRT, false)
		WindowClearAnchors(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.WAIST)
		WindowAddAnchor(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.WAIST, "topleft", windowName.."TabWindow2", "topleft", 2, 113)
		WindowClearAnchors(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET)
		WindowAddAnchor(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET, "topleft", windowName.."TabWindow2", "topleft", 2, 54)
		
		WindowSetShowing(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.PANTS, false)

		WindowSetShowing(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD, false)
		WindowClearAnchors(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.NECK)
		WindowAddAnchor(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.NECK, "topleft", windowName.."TabWindow1", "topleft", 2, 54)
		
		local button
		button = windowName.."TabWindow1ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.KILT)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots", 58, 175)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots", 58, 175)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots", 58, 175)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots", 58, 175)
			
		button = windowName.."TabWindow2ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots", 116, 175)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots", 116, 175)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots", 116, 175)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots", 116, 175)
		
		button = windowName.."TabWindow2ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.TALONS)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots", 174, 175)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots", 174, 175)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots", 174, 175)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots", 174, 175)				
		
		WindowForceProcessAnchors(windowName)
	else
		WindowSetShowing(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.SHIRT, true)
		WindowClearAnchors(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET)
		WindowAddAnchor(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.FEET, "topleft", windowName.."TabWindow2", "topleft", 2, 15)				
		WindowClearAnchors(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.WAIST)
		WindowAddAnchor(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.WAIST, "bottomleft", windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.SHIRT, "topleft", 0, 0)
		
		WindowSetShowing(windowName.."TabWindow2ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.PANTS, true)

		WindowSetShowing(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD, true)
		WindowClearAnchors(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.NECK)
		WindowAddAnchor(windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.NECK, "bottomleft", windowName.."TabWindow1ItemSlotButton"..PaperdollWindow.PAPERDOLLSLOTID.HEAD, "topleft", 0, 0)		
		
		
		local button
		button = windowName.."TabWindow1ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.HANDS)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots", 174, 58)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots", 174, 58)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots", 174, 58)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots", 174, 58)
			
		button = windowName.."TabWindow2ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.CAPE)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots2", 0, 58)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots2", 0, 58)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots2", 0, 58)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots2", 0, 58)
		
		button = windowName.."TabWindow2ItemSlotButton"..tostring(PaperdollWindow.PAPERDOLLSLOTID.FEET)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "paperdoll_slots2", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "paperdoll_slots2", 0, 0)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "paperdoll_slots2", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "paperdoll_slots2", 0, 0)	
		
		WindowForceProcessAnchors(windowName)
	end
end

function PaperdollWindow.UpdatePaperdoll(windowName,paperdollId)
	if( paperdollId == WindowGetId(windowName) ) then
		local elementIcon
		local elementBg
		local topButton 
		
		for index = 1, WindowData.Paperdoll[paperdollId].numSlots  do
			
			if( index <= PaperdollWindow.ArmorSlots) then
				elementIcon = windowName.."TabWindow1ItemSlotButton"..tostring(index).."SquareIcon"
				elementBg =  windowName.."TabWindow1ItemSlotButton"..tostring(index).."SquareBg"
				topButton = windowName.."TabWindow1ItemSlotButton"..index
			else
				elementIcon = windowName.."TabWindow2ItemSlotButton"..tostring(index).."SquareIcon"
				elementBg =  windowName.."TabWindow2ItemSlotButton"..tostring(index).."SquareBg"
				topButton = windowName.."TabWindow2ItemSlotButton"..index
			end
			
			--Debug.Print("Index = "..index.." window name = "..tostring(elementIcon))
			
			if (WindowData.Paperdoll[paperdollId][index].slotId == 0) then
				ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_EMPTY
				ItemSlot.ItemIds[index] = 0
				ItemSlot.ObjectTypes[index] = 0	
				WindowSetShowing(elementIcon, false)
				WindowSetShowing(elementBg, false)				
			else
				--Debug.Print(" window name slotId textureName = "..tostring(WindowData.Paperdoll[paperdollId][index].slotTextureName))
				ItemSlot.ItemIds[index] = WindowData.Paperdoll[paperdollId][index].slotId
				ItemSlot.ObjectTypes[index] = WindowData.Paperdoll[paperdollId][index].slotTextureName
				ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_NORMAL
	
				data = WindowData.Paperdoll[paperdollId][index]
				EquipmentData.UpdateItemIcon(elementIcon, data)			
				
				-- DAB TODO UPDATE ANCHORS
				parent = WindowGetParent(elementIcon)
				WindowClearAnchors(elementIcon)
				WindowAddAnchor(elementIcon, "topleft", parent, "topleft", (58-data.newWidth)/2, (58-data.newHeight)/2)

				WindowSetShowing(elementIcon, true)
				WindowSetShowing(elementBg, true)
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
					WindowAddAnchor(paperdollTexture, "center", tabNames[index], "topleft", textureData.xOffset, textureData.yOffset)	
					DynamicImageSetTexture(paperdollTexture, paperdollTextureName, 0, 0)
				end
				
				for index, paperdollTexture in ipairs(hiddenTextures) do
					WindowSetShowing(paperdollTexture, false)
					WindowSetHandleInput(paperdollTexture, false)
					DynamicImageSetTexture(paperdollTexture, "", 0, 0)
				end
				
				local tabBackgroundNames = { tabNames[1].."BlackBackground", tabNames[2].."BlackBackground" }
				for index, paperdollBackground in ipairs(tabBackgroundNames) do
					WindowSetShowing(paperdollBackground, showBackground)
				end
				
			end

		end	
		
		PaperdollWindow.UpdateRaceSpecificWindows(windowName,paperdollId)
		local playerId = WindowData.PlayerStatus.PlayerId
		if(paperdollId == playerId)then				
			CharacterAbilities.UpdateItemPropInfo()
		end
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
			detail = ItemProperties.DETAIL_LONG
		}
	else
		local EmptySlotBodyText		
		if ( ((WindowData.MobileStatus[PaperdollId].Race == PaperdollWindow.GARGOYLE) and ((PaperdollWindow.PAPERDOLLSLOTID.TALONS == SlotNum) or ( PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR == SlotNum) or (PaperdollWindow.PAPERDOLLSLOTID.KILT == SlotNum))) ) then											
				slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTidTwo)			
		else				
				slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTid )					
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
end

function PaperdollWindow.OnUpdate()
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
		elseif SlotId == 0 and PaperdollWindow.ActivePaperdollObject ~= 0 then
			PaperdollWindow.ActivePaperdollObject = 0
			ItemProperties.ClearMouseOverItem()
		end
	end
end

function PaperdollWindow.ToggleInventoryWindow()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local inventoryName = windowName.."ToggleInventory"
	if (ButtonGetDisabledFlag(inventoryName) ) then
		return
	end
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
	if( id == playerId and PaperdollWindow.CurrentTab == 3 ) then
		local windowName = "PaperdollWindow"..id
		local infoText = TextEditBoxGetText(windowName.."TabWindow3ProfileEditText")
		UpdateCharProfile(id,infoText)
	end
	
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
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local windowName = "PaperdollWindow"..id
	local characterSheetName = windowName.."ToggleCharacterSheet"
	if (ButtonGetDisabledFlag(characterSheetName) ) then
		return
	end
	showing = WindowGetShowing("CharacterSheet")
	local playerId = WindowData.PlayerStatus.PlayerId
	-- if this is the players paperdoll toggle character sheet
	if( id == playerId ) then
		ToggleWindowByName("CharacterSheet", "", nil)
		ButtonSetPressedFlag( characterSheetName, not showing )
	end
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

function PaperdollWindow.UpdateCharProfile()
    local id = WindowGetId(SystemData.ActiveWindow.name)
    if( id == WindowData.CharProfile.Id ) then
        local tabName = SystemData.ActiveWindow.name.."TabWindow3"
        if( id == WindowData.PlayerStatus.PlayerId ) then
            TextEditBoxSetText(tabName.."ProfileEditText",WindowData.CharProfile.Info)
            LabelSetText(tabName.."Age",WindowData.CharProfile.Age)
        else
            LabelSetText(tabName.."ProfileViewScrollChildText",WindowData.CharProfile.Info)
            ScrollWindowUpdateScrollRect(tabName.."ProfileViewScroll")
        end
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
