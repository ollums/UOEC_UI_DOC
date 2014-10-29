----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

HotbarSystem = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

HotbarSystem.BindingsBackup = {}

HotbarSystem.RegisteredSpellIcons = {}

HotbarSystem.CurRequestInfoItem = nil

HotbarSystem.HighlightSpellIconInput = {}
HotbarSystem.HighlightSpellIconInput.highlightSpellID = 0
HotbarSystem.HighlightSpellIconInput.highlightSpellEnabled = 0

HotbarSystem.ContextReturnCodes = {}
HotbarSystem.ContextReturnCodes.CLEAR_ITEM = 1
HotbarSystem.ContextReturnCodes.ASSIGN_KEY = 2
HotbarSystem.ContextReturnCodes.NEW_HOTBAR = 3
HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR = 4
HotbarSystem.ContextReturnCodes.TARGET_SELF = 5
HotbarSystem.ContextReturnCodes.TARGET_CURRENT = 6
HotbarSystem.ContextReturnCodes.TARGET_CURSOR = 7
HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID = 8
HotbarSystem.ContextReturnCodes.EDIT_ITEM = 9
HotbarSystem.ContextReturnCodes.ENABLE_REPEAT = 10
HotbarSystem.ContextReturnCodes.DISABLE_REPEAT = 11
HotbarSystem.ContextReturnCodes.LOCK_HOTBAR = 12

HotbarSystem.TID_CLEAR_ITEM = 1077858
HotbarSystem.TID_ASSIGN_HOTKEY = 1078019
HotbarSystem.TID_NEW_HOTBAR = 1078020
HotbarSystem.TID_DESTROY_HOTBAR = 1078026
HotbarSystem.TID_DESTROY_CONFIRM = 1078027
HotbarSystem.TID_CURSOR = 1078071
HotbarSystem.TID_SELF = 1078072
HotbarSystem.TID_CURRENT = 1078073
HotbarSystem.TID_OBJECT_ID = 1094772
HotbarSystem.TID_TARGET = 1078074
HotbarSystem.TID_EDIT_ITEM = 1078196
HotbarSystem.TID_ENABLE_REPEAT = 1079431 -- "Enable Repeating"
HotbarSystem.TID_DISABLE_REPEAT = 1079433 -- "Disable Repeating"
HotbarSystem.TID_LOCK_HOTBAR = 1115431
HotbarSystem.TID_UNLOCK_HOTBAR = 1115432

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------


HotbarSystem.Spells = {} 

HotbarSystem.STATIC_HOTBAR_ID = 1
HotbarSystem.MAX_HOTBAR_ID = 5000

HotbarSystem.TID_ASSIGN_HOTKEY_DESC = 1078096
HotbarSystem.TID_REQUEST_TARGET_ID_DESC = 1094788

HotbarSystem.BANDAGE_OBJTYPE = 3617
HotbarSystem.BANDAGE_SECOND_OBJTYPE = 3817

HotbarSystem.HealPot_OBJTYPE = 3852

HotbarSystem.SmokeBomb_OBJTYPE = 10248

HotbarSystem.Apple_OBJTYPE = 12248
HotbarSystem.Apple_Color = 1160

HotbarSystem.Grape_OBJTYPE = 12247
HotbarSystem.Grape_Color = 1154

HotbarSystem.OldQTA = 0
HotbarSystem.QTA = 0
HotbarSystem.UpdateQTACycle = 0
HotbarSystem.QTAChangedID = nil
HotbarSystem.Updated = false

HotbarSystem.CurrentTargLife = 100

-- TEMP VARIABLES
HotbarSystem.OffsetX = 945
HotbarSystem.OffsetY = 910
HotbarSystem.OffsetIncrement = -60

HotbarSystem.BandageDelayTime = 0 -- Starts off at 0 since no bandages have been used yet
HotbarSystem.BandageDelayDiff = 1 -- Counts down the timer with a 1 second counter
HotbarSystem.CurrentBandageDelta = 0	  -- How much time has passed since the previous update time
HotbarSystem.BandageSlots = {}

HotbarSystem.HealPotDelayTime = 0 -- Starts off at 0 since no bandages have been used yet
HotbarSystem.HealPotDelayDiff = 1 -- Counts down the timer with a 1 second counter
HotbarSystem.CurrentHealDelta = 0	  -- How much time has passed since the previous update time
HotbarSystem.HealPotSlots = {}

HotbarSystem.AppleDelayTime = 0 -- Starts off at 0 since no bandages have been used yet
HotbarSystem.AppleDelayDiff = 1 -- Counts down the timer with a 1 second counter
HotbarSystem.CurrentAppleDelta = 0	  -- How much time has passed since the previous update time
HotbarSystem.AppleSlots = {}

HotbarSystem.GrapeDelayTime = 0 -- Starts off at 0 since no bandages have been used yet
HotbarSystem.GrapeDelayDiff = 1 -- Counts down the timer with a 1 second counter
HotbarSystem.CurrentGrapeDelta = 0	  -- How much time has passed since the previous update time
HotbarSystem.GrapeSlots = {}

HotbarSystem.WoDSlots = {}
--HotbarSystem.FeintSlots = {}
HotbarSystem.WoDSlotsType = {}

HotbarSystem.SkillDelayTime = 0 -- Starts off at 0 since no Disco have been used yet
HotbarSystem.SkillDelayDiff = 1 -- Counts down the timer with a 1 second counter
HotbarSystem.CurrentSkillDelta = 0	  -- How much time has passed since the previous update time


HotbarSystem.RegisteredGenericObjectType = {}
HotbarSystem.RegisteredObjects = {}
HotbarSystem.ReferencedTextures = {}
HotbarSystem.ObjectSlots = {}
HotbarSystem.ObjectSlotsSize = {}
HotbarSystem.MacroReferenceSlots = {}
HotbarSystem.PlayerStatsElements = {}

HotbarSystem.DarkItemLabel = { r=245,g=229,b=0 }
HotbarSystem.LightItemLabel = { r=255,g=255,b=255 }

HotbarSystem.Plain = { r=255,g=255,b=255 }

HotbarSystem.Control = { r=255,g=0,b=0 }
HotbarSystem.Alt = { r=0,g=255,b=0 }
HotbarSystem.Shift = { r=0,g=92,b=232 }

HotbarSystem.ControlAlt = { r=255,g=255,b=0 }
HotbarSystem.AltShift = { r=0,g=255,b=255 }
HotbarSystem.ControlShift = { r=255,g=0,b=255 }

HotbarSystem.ControlAltShift = { r=179,g=106,b=227 }

HotbarSystem.CountdownTimer = { r=255,g=0,b=0 }

HotbarSystem.DefaultSlots = 12
HotbarSystem.DefHorizontal = true

HotbarSystem.WARNINGLEVEL = 10

HotbarSystem.TargetTypeTintColors = {
    [SystemData.Hotbar.TargetType.TARGETTYPE_NONE] = { r=255,g=180,b=0 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_SELF] = { r=0,g=138,b=255 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] = { r=255,g=0,b=0 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] = { r=91,g=204,b=91 },
    [SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] = { r=200,g=200,b=200 }
}

function HotbarSystem.Initialize()
	-- setup the assign key description window
	CreateWindow("AssignHotkeyInfo",false)
	LabelSetText("AssignHotkeyInfoText",GetStringFromTid(HotbarSystem.TID_ASSIGN_HOTKEY_DESC))
	local x, y = LabelGetTextDimensions( "AssignHotkeyInfoText" )
	WindowSetDimensions("AssignHotkeyInfo",x+16,y+16)
	
	-- setup the "Request Target ID" description window
	CreateWindow("RequestTargetIdInfo",false)
	LabelSetText("RequestTargetIdInfoText",GetStringFromTid(HotbarSystem.TID_REQUEST_TARGET_ID_DESC))
	local x, y = LabelGetTextDimensions( "RequestTargetIdInfoText" )
	WindowSetDimensions("RequestTargetIdInfo",x+16,y+16)
		
	-- create a hotbar for each id in the list
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
		HotbarSystem.SpawnNewHotbar(hotbarId)
	end
	
	--Used to show the stats when players drag their stats into the hotbar
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	WindowRegisterEventHandler( "Root", WindowData.PlayerStatus.Event, "HotbarSystem.UpdatePlayerStat")
	
	WindowRegisterEventHandler( "Root", WindowData.ObjectInfo.Event, "HotbarSystem.UpdateItemSlot")	
	WindowRegisterEventHandler( "Root", SystemData.Events.MACRO_CHANGED, "HotbarSystem.UpdateMacroReferenceSlot")
	WindowRegisterEventHandler( "Root", SystemData.Events.HOTBAR_HIGHLIGHT_SPELL_ICON, "HotbarSystem.HighlightSpellIcon")
	WindowRegisterEventHandler( "Root", SystemData.Events.HOTBAR_UNHIGHLIGHT_SPELL_ICON, "HotbarSystem.UnhighlightSpellIcon")
	WindowRegisterEventHandler( "Root", WindowData.ObjectTypeQuantity.Event, "HotbarSystem.UpdateQuantity")
	WindowRegisterEventHandler( "Root", SystemData.Events.OBJECT_DELAY_TIME, "HotbarSystem.UpdateDelayTime")
	WindowRegisterEventHandler( "Root", SystemData.Events.UPDATE_ACTION_ITEM, "HotbarSystem.HandleUpdateActionItem")
end

function HotbarSystem.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
end

function HotbarSystem.DestroyHotbar(hotbarId)
	for i=1,12 do
		if DoesWindowNameExist("Hotbar"..hotbarId) then
			HotbarSystem.UnbindKey(hotbarId, i, SystemData.BindType.BINDTYPE_HOTBAR)
		end
		local element = "Hotbar"..hotbarId.."Button"..i
		CustomSettings.DeleteSetting( element .. "Custom" )
	end
	CustomSettings.DeleteSetting("Hotbar"..hotbarId .. "SC")
	HotbarUnregister(hotbarId)
	if (EnhancePack.MenuId == hotbarId) then
		EnhancePack.MenuId = -1
		CustomSettings.DeleteSetting( "EnhancePackMenuId" )
	end
	if DoesWindowNameExist("Hotbar"..hotbarId) then
		DestroyWindow("Hotbar"..hotbarId)
	end
	if EnhancePack.PropsSlot and EnhancePack.PropsSlot.HotbarID == hotbarId then
		EnhancePack.PropsSlot = nil
		CustomSettings.DeleteSetting( "EnhancePackPropsSlotHotbarID" )
		CustomSettings.DeleteSetting( "EnhancePackPropsSlotSlotID" )
		ActionsWindow.UpdateIcons()
	end
	-- We dont want to keep track of window positions for hotbars that are permanently destroyed
	WindowUtils.ClearWindowPosition("Hotbar"..hotbarId)
	
end

function HotbarSystem.SpawnNewHotbar(hotbarId)
	-- If the hotbarId is passed in, this thing is already registered in code (from loading UserSettings)
	local setPosition = false
	if( hotbarId == nil ) then
		hotbarId = HotbarSystem.GetNextHotbarId()
		HotbarRegisterNew(hotbarId)
		setPosition = true
		
		-- new hotbars default to unlocked
		SystemData.Hotbar[hotbarId].Locked = false
	end
	
	--Debug.Print("HotbarSystem.SpawnNewHotbar: "..hotbarId)
	
	SystemData.DynamicWindowId = hotbarId
	CreateWindowFromTemplate("Hotbar"..hotbarId, "Hotbar", "Root")
	
	-- dynamic hotbars need to have their position generated when created for the first time
	if( setPosition == true ) then
		if( hotbarId ~= HotbarSystem.STATIC_HOTBAR_ID ) then
			WindowClearAnchors("Hotbar"..hotbarId)
			WindowAddAnchor("Hotbar"..hotbarId, "topleft", "Root", "topleft", HotbarSystem.OffsetX, HotbarSystem.OffsetY)
			HotbarSystem.OffsetY = HotbarSystem.OffsetY + HotbarSystem.OffsetIncrement	
			-- when we get to the top, start over at the bottom
			if( HotbarSystem.OffsetY < 0 ) then
			    HotbarSystem.OffsetY = 910
			end
			
			WindowSetShowing("Hotbar"..hotbarId.."HorizHandle",HotbarSystem.DefHorizontal)
			WindowSetShowing("Hotbar"..hotbarId.."VertHandle", not HotbarSystem.DefHorizontal)
			local xOffset = 0
			local yOffset = 0
			WindowClearAnchors("Hotbar"..hotbarId.."Button"..1)
			if (HotbarSystem.DefHorizontal) then
				xOffset = 20
				yOffset = 0
				WindowSetDimensions("Hotbar"..hotbarId,xOffset + (50 * HotbarSystem.DefaultSlots),50+ yOffset)
				WindowAddAnchor("Hotbar"..hotbarId.."Button"..1,"topright","Hotbar"..hotbarId.."HorizHandle","topleft",0,0)
			else
				yOffset = 20
				xOffset = 0
				WindowSetDimensions("Hotbar"..hotbarId, 50+ xOffset ,yOffset+ (50 * HotbarSystem.DefaultSlots))
				WindowAddAnchor("Hotbar"..hotbarId.."Button"..1,"bottomright","Hotbar"..hotbarId.."VertHandle","topright",0,0)
			end
			
			for slot=2, Hotbar.NUM_BUTTONS do
				local button = "Hotbar"..hotbarId.."Button"..slot		
				local relativeTo = "Hotbar"..hotbarId.."Button"..(slot-1)
				if (HotbarSystem.DefHorizontal) then
					WindowClearAnchors(button)
					WindowAddAnchor(button,"topright",relativeTo,"topleft",0,0)		
				else
					WindowClearAnchors(button)
					WindowAddAnchor(button,"bottomleft",relativeTo,"topleft",0,0)
					
				end
				if (slot > HotbarSystem.DefaultSlots) then
					WindowSetShowing(button, false)
				else
					WindowSetShowing(button, true)
				end
				
			end
		end
	end
	return hotbarId
end

function HotbarSystem.GetNextHotbarId()
	-- find the next available id
	local newHotbarId = 2
	
	while newHotbarId ~= HotbarSystem.MAX_HOTBAR_ID do
		local found = false
		for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
			if( hotbarId == newHotbarId ) then
				found = true
			end
		end
		
		if( found ~= true ) then
			break
		end
		
		newHotbarId = newHotbarId + 1
	end
	
	return newHotbarId
end

function HotbarSystem.RegisterAction(element, hotbarId, itemIndex, subIndex)
	if (element == nil) then
		return
	end
	local type = UserActionGetType(hotbarId, itemIndex, subIndex)
	local id = UserActionGetId(hotbarId, itemIndex, subIndex)
	local iconId = UserActionGetIconId(hotbarId, itemIndex, subIndex)
	local disabled = not UserActionIsTargetModeCompat(hotbarId, itemIndex, subIndex)
	local actionId = UserActionGetId(hotbarId,itemIndex,0)

    if( type == SystemData.UserAction.TYPE_USE_ITEM or
	    type == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then    
		if( HotbarSystem.ObjectSlots[id] == nil ) then
			HotbarSystem.ObjectSlots[id] = {}
			HotbarSystem.ObjectSlotsSize[id] = 0
		end
		HotbarSystem.ObjectSlotsSize[id] = HotbarSystem.ObjectSlotsSize[id] + 1
		HotbarSystem.ObjectSlots[id][element] = {type=type,iconId=iconId}
    elseif( type == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
		if(	HotbarSystem.MacroReferenceSlots[id] == nil ) then
			HotbarSystem.MacroReferenceSlots[id] = {}
		end
		HotbarSystem.MacroReferenceSlots[id][element] = {hotbarId=hotbarId, itemIndex=itemIndex, subIndex=subIndex}
		
		local macroId = UserActionGetId(hotbarId,itemIndex,0)
		local macroIndex = MacroSystemGetMacroIndexById(macroId)
		disabled = not UserActionIsTargetModeCompat(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0)
	elseif( type == SystemData.UserAction.TYPE_PLAYER_STATS ) then
		HotbarSystem.PlayerStatsElements[element] = id
	end
	
	HotbarSystem.UpdateActionButton(element, type, id, iconId, disabled ,hotbarId,itemIndex,subIndex )
	HotbarSystem.UpdateTargetTypeIndicator(element,hotbarId,itemIndex,subIndex)
end

function HotbarSystem.UpdateActionButton(element, type, id, iconId, disabled, hotbarId, itemIndex, subIndex )
	local bDisabled = disabled

	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	WindowSetShowing(element.."Alert",false)
	--Debug.Print("UpdateActionButton: element: "..tostring(element).." actionType: "..tostring(actionType).." actionId: "..tostring(actionId).." iconId: "..tostring(iconId).." isActive: "..tostring(isActive))
	
	-- use item is a crazy special case so handle that first
	if( type == SystemData.UserAction.TYPE_USE_ITEM or
	    type == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then
		
        local item = nil
        local playerHasItem = false
        
		--Debug.Print("Step 1: "..tostring(type))
        if( type == SystemData.UserAction.TYPE_USE_ITEM ) then
		    -- register for this object if its not already registered
		    if( HotbarSystem.RegisteredObjects[element] == nil ) then
				--UnregisterWindowData(WindowData.ObjectInfo.Type, id)
			    RegisterWindowData(WindowData.ObjectInfo.Type, id)
			    HotbarSystem.RegisteredObjects[element] = id		
		    end	
		    
	        item = WindowData.ObjectInfo[id]
	        local enable = false
			for index = 1, table.getn(ItemSlot.ItemIds)  do
				if (ItemSlot.ItemIds[index] == id) then
					enable = true
				end
			end
			if ( DoesPlayerHaveItem(id) or enable ) then
				playerHasItem = true
			end
			--Debug.Print("" .. playerHasItem)
		elseif( type == SystemData.UserAction.TYPE_USE_OBJECTTYPE ) then
	        -- register for this object if its not already registered
	      
	        if( HotbarSystem.RegisteredGenericObjectType[element] == nil ) then
	        --Debug.Print("REGISTER for OBJECTYPE "..id)
				--UnregisterWindowData(WindowData.ObjectTypeQuantity.Type, id)
		        RegisterWindowData(WindowData.ObjectTypeQuantity.Type, id)
		        HotbarSystem.RegisteredGenericObjectType[element] = id
	        end	

		    item = WindowData.ObjectTypeQuantity[id]
		    
		    
		    
		    local enable = false
			for index = 1, table.getn(ItemSlot.ItemIds)  do
				if (ItemSlot.ItemIds[index] == id) then
					enable = true
				end
			end
		    playerHasItem = (item~= nil and item.quantity >= 1) or enable 	        
		end
	
		--Debug.Print("Step 2: "..tostring(playerHasItem))
		
		if( playerHasItem) then
			
			--Debug.Print("Step 3: "..tostring(item.name))	
			if( item ~= nil ) then
			    if( item.name ~= nil and item.quantity >= 1) then
					--Debug.Print("Step 4: UpdateItemIcon")
                    EquipmentData.UpdateItemIcon(elementIcon, item)
			    end
			    
    			

			    if( item.quantity ~= nil) then
				    LabelSetText(element.."Quantity",L"")
				    WindowSetShowing(element.."QuantityBackground", false)
				    if item.quantity < 20 and CustomSettings and CustomSettings.LoadBoolean( element .. "EnableAlert", false ) then
						local alpha = 1.5 - (item.quantity / 20)
						WindowSetShowing(element.."Alert",true)
						WindowSetAlpha(element.."Alert", alpha)
					end
				    if (item.quantity > 1) then
						local labelString
						if (item.quantity >= 1000) then
							local q = item.quantity / 1000
							q = math.floor(q)
							labelString = StringToWString(tostring(q).."K")	
						else
							labelString = StringToWString(tostring(item.quantity))	
						end
						LabelSetText(element.."Quantity",labelString)	
						WindowSetShowing(element.."QuantityBackground", true)
					end
			    end
			end
			
			if(item and item.objectType == HotbarSystem.SmokeBomb_OBJTYPE) then
			
				if( HotbarSystem.WoDSlots[id] == nil ) then
						HotbarSystem.WoDSlots[id] = {}
				end
				HotbarSystem.WoDSlots[id][element] = element
				HotbarSystem.WoDSlotsType[id] = SystemData.UserAction.TYPE_SKILL
			end
			
			--LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
		-- If its not in your pack anymore just use the icon and disable it
		elseif( iconId ~= 0 and iconId ~= nil ) then
			name, x, y, scale, newWidth, newHeight = RequestTileArt(iconId,50,50)
			DynamicImageSetTextureDimensions(elementIcon, newWidth, newHeight)
			WindowSetDimensions(elementIcon, newWidth, newHeight)
			DynamicImageSetTexture(elementIcon, name, x, y )
			DynamicImageSetTextureScale(elementIcon, scale)
			
			--LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
			
			HotbarSystem.ReferencedTextures[element] = iconId	
			bDisabled = true
		end
		local custom = nil
		if (CustomSettings) then
			custom = CustomSettings.LoadNumber( element .. "Custom", nil )
		end
		if (custom) then
			DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[custom].texture .. "Icon", 0, 0 )
		else
			DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
		end	
		WindowSetShowing(elementIcon .."BG", true)
	elseif (type == SystemData.UserAction.TYPE_WEAPON_ABILITY) then
		--if( EquipmentData.CurrentWeaponAbilities[id] ~= nil and EquipmentData.CurrentWeaponAbilities[id] ~= 0 ) then
		--	local abilityId = EquipmentData.CurrentWeaponAbilities[id] + EquipmentData.WEAPONABILITY_ABILITYOFFSET
		--	
		--	if (abilityId == 1020) then
		--		if( HotbarSystem.FeintSlots[element] == nil ) then
		--			HotbarSystem.FeintSlots[element] = {}
		--		end
		--		HotbarSystem.FeintSlots[element] = id
		--	end
		--end
		HotbarSystem.SetHotbarIcon(element, iconId)
		EquipmentData.RegisterWeaponAbilitySlot(element,id)
		--LabelSetTextColor(elementHotkey,HotbarSystem.LightItemLabel.r,HotbarSystem.LightItemLabel.g,HotbarSystem.LightItemLabel.b)
	else
		if ( type == SystemData.UserAction.TYPE_SKILL or id == 614 or id == 604 or id == 613  or id == 36 or id == 104 or id == 203 or id == 402 or id == 403 or id == 404 or id == 1) then
			if( HotbarSystem.WoDSlots[id] == nil ) then
					HotbarSystem.WoDSlots[id] = {}
			end
			HotbarSystem.WoDSlots[id][element] = element
			HotbarSystem.WoDSlotsType[id] = type
		end
		HotbarSystem.SetHotbarIcon(element, iconId)
		HotbarSystem.RegisterSpellIcon(element,id)
	end
	
	if type == SystemData.UserAction.TYPE_SPELL then
		
		if( HotbarSystem.Spells[id] == nil ) then
				HotbarSystem.Spells[id] = {}
		end
		HotbarSystem.Spells[id][element] = element
	end
	
	if( bDisabled == true ) then
		WindowSetShowing(element.."Disabled",true)
		WindowSetShowing(element.."Alert",false)
		ButtonSetDisabledFlag(element,true)
	else	
		WindowSetShowing(element.."Disabled",false)
		ButtonSetDisabledFlag(element,false)
	end
	
	--Need to update label here in case iconId changes
	if (type == SystemData.UserAction.TYPE_PLAYER_STATS) then
		HotbarSystem.UpdatePlayerStatLabel(element, id)
	end
end

function HotbarSystem.UpdateTargetTypeIndicator(element,hotbarId,itemIndex,subIndex)
    --Debug.Print("UpdateTargetTypeIndicator: "..tostring(element)..", "..tostring(hotbarId)..", "..tostring(itemIndex)..", "..tostring(subIndex))
    local type = UserActionGetType(hotbarId, itemIndex, subIndex)
	local idC = UserActionGetId(hotbarId, itemIndex, subIndex)

	local notarget = false
	if (type == SystemData.UserAction.TYPE_SPELL and SpellsInfo) then
		for no, value in pairs(SpellsInfo.SpellsData) do
			if value.id == idC then
				notarget = value.notarget
				break
			end
		end
	end
	
	if type == SystemData.UserAction.TYPE_SKILL and (idC == 46 or idC== 32 or idC== 56 or idC== 38 or idC== 21 or idC== 47) then -- meditation, spirit speak, imbuing, tracking, hiding, stealth
		notarget=true
	end
	
	if( UserActionHasTargetType(hotbarId,itemIndex,subIndex) and SystemData.Settings.GameOptions.legacyTargeting == false and not notarget ) then
	    local targetType = UserActionGetTargetType(hotbarId,itemIndex,subIndex)
	    local tintColor = HotbarSystem.TargetTypeTintColors[targetType]
	    WindowSetTintColor(element.."Overlay",tintColor.r,tintColor.g,tintColor.b)
	else
		local tintColor = HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE]
	    WindowSetTintColor(element.."Overlay",tintColor.r,tintColor.g,tintColor.b)
	end
end

function HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, subIndex, bUnregister)
	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	
	--Debug.Print("HotbarSystem.ClearActionIcon: "..tostring(element).." hotbarId: "..tostring(hotbarId).." itemIndex: "..tostring(itemIndex).." subIndex: "..tostring(subIndex))
	
	DynamicImageSetTextureDimensions(elementIcon, 50, 50)
	WindowSetDimensions(elementIcon, 50, 50)
	DynamicImageSetTexture(elementIcon, "", 0, 0 )
	DynamicImageSetTextureScale(elementIcon, 0.78 )	
	WindowSetTintColor(elementIcon,255,255,255)
	WindowSetAlpha(elementIcon,1.0)
	WindowSetShowing(elementIcon .."BG", false)
    LabelSetText(element.."Quantity",L"")
	WindowSetShowing(element.."QuantityBackground", false)
	--LabelSetTextColor(elementHotkey,HotbarSystem.DarkItemLabel.r,HotbarSystem.DarkItemLabel.g,HotbarSystem.DarkItemLabel.b)
	
	WindowSetShowing(element.."Disabled",false)
	WindowSetShowing(element.."Alert",false)
	ButtonSetDisabledFlag(element,false)
	
	local tintColor = HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE]
	WindowSetTintColor(element.."Overlay",tintColor.r,tintColor.g,tintColor.b)
	
	--Clear the label text when the players stats icon is cleared
	LabelSetText(element.."Stats", L"")
	LabelSetText(element.."StatsTop", L"")
	LabelSetText(element.."StatsBottom",L"")
	HotbarSystem.PlayerStatsElements[element] = nil
	
	if( bUnregister == true ) then
		-- clear out the macro reference if necesary
		for itemId, elements in pairs(HotbarSystem.MacroReferenceSlots) do
			elements[element] = nil
			if( table.getn(elements) == 0 ) then
				elements = nil
			end			
		end

		-- clear the weapon ability (this does nothing if its not a weapon ability)
		EquipmentData.UnregisterWeaponAbilitySlot(element)
		-- clear the spell registration (this does nothing if it is not a spell
		HotbarSystem.UnregisterSpellIcon(element)
		
		-- unregister the object info for this slot if necesary
		if( HotbarSystem.RegisteredObjects[element] ~= nil ) then
			local itemId = HotbarSystem.RegisteredObjects[element]
			--Debug.Print("UNREGISTERING HOTBAR OBJECT: "..tostring(hotbarId)..", "..tostring(itemIndex).." itemId: "..tostring(itemId))
			HotbarSystem.ObjectSlots[itemId][element] = nil
			if( HotbarSystem.ObjectSlots[itemId] ~= nil) then
				if( HotbarSystem.ObjectSlotsSize[itemId] == 1 ) then
					HotbarSystem.ObjectSlots[itemId] = nil
				end
				HotbarSystem.ObjectSlotsSize[itemId] = HotbarSystem.ObjectSlotsSize[itemId] - 1
			end			
			
			UnregisterWindowData(WindowData.ObjectInfo.Type,HotbarSystem.RegisteredObjects[element])
			HotbarSystem.RegisteredObjects[element] = nil
		end
		
		-- unregister the generic object type info for this slot if necesary
		if( HotbarSystem.RegisteredGenericObjectType[element] ~= nil) then
			local itemId = HotbarSystem.RegisteredGenericObjectType[element]
			--Debug.Print("UNREGISTERING HOTBAR OBJECT: "..tostring(hotbarId)..", "..tostring(itemIndex).." itemId: "..tostring(itemId).." element "..element)
			
			HotbarSystem.UpdateQuantityForOneSlot(element)
			HotbarSystem.ObjectSlots[itemId][element] = nil
			if( HotbarSystem.ObjectSlots[itemId] ~= nil) then
				if (HotbarSystem.ObjectSlotsSize[itemId] == 1 ) then
					HotbarSystem.ObjectSlots[itemId] = nil
				end
				HotbarSystem.ObjectSlotsSize[itemId] = HotbarSystem.ObjectSlotsSize[itemId] - 1
			end		
			
			
			UnregisterWindowData(WindowData.ObjectTypeQuantity.Type,HotbarSystem.RegisteredGenericObjectType[element])
			HotbarSystem.RegisteredGenericObjectType[element] = nil
		end
		
		if( HotbarSystem.ReferencedTextures[element] ~= nil ) then
			ReleaseTileArt(HotbarSystem.ReferencedTextures[element])
			HotbarSystem.ReferencedTextures[element] = nil
		end
	end
end

function HotbarSystem.UpdateItemSlot(force)
	local id = WindowData.UpdateInstanceId
	if force then
		id = force
	end
	
	if( HotbarSystem.ObjectSlots[id] ~= nil ) then
		-- if the player has this item then enable it
		local enable = false
		for index = 1, table.getn(ItemSlot.ItemIds)  do
			if (ItemSlot.ItemIds[index] == id) then
				enable = true
			end
		end
		if( DoesPlayerHaveItem(id) or enable ) then
			for element, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
				if (element ~= nil) then	
					WindowSetShowing(element.."Disabled",false)
					ButtonSetDisabledFlag(element,false)
						
					local item = WindowData.ObjectInfo[id]	
					if not item then
						--UnregisterWindowData(WindowData.ObjectInfo.Type, id)
						RegisterWindowData(WindowData.ObjectInfo.Type, id)
					end
					if (item ~= nil) then
						-- also update the image if it isnt set yet
						local elementIcon = element.."SquareIcon"
						-- always update the hue
						DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {item.hueId, item.objectType})
						WindowSetTintColor(elementIcon,item.hue.r,item.hue.g,item.hue.b)
						WindowSetAlpha(elementIcon,item.hue.a/255)	
						if (itemLoc.hotbarId ~= nil) then								
							if( UserActionGetIconId(itemLoc.hotbarId,itemLoc.itemIndex,itemLoc.subIndex) == 0 ) then
								EquipmentData.UpdateItemIcon(elementIcon, item)
							end	
						end
					end
				end		
			end
		-- if this item has left the players backpack then disable it
		else
			for element, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
				WindowSetShowing(element.."Disabled",true)
				WindowSetShowing(element.."Alert",false)
				ButtonSetDisabledFlag(element,true)
			end
		end
	end
end

function HotbarSystem.SetHotbarIcon(element, iconId)
	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	
	if( iconId ~= nil ) then
		WindowSetShowing(elementIcon .."BG", true)
		local custom = nil
		if (CustomSettings) then
			custom = CustomSettings.LoadNumber( element .. "Custom", nil )
		end
		LabelSetFont(element.."StatsTop",  "font_verdana_bold_shadow_med3", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont(element.."StatsBottom",  "font_verdana_bold_shadow_med3", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont(element.."Stats",  "font_verdana_bold_shadow_med3", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			
		if (custom) then
			DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[custom].texture .. "Icon", 0, 0 )
			LabelSetTextColor(element.."StatsTop", MiniTexturePack.DB[custom].StatLabelColor.r, MiniTexturePack.DB[custom].StatLabelColor.g, MiniTexturePack.DB[custom].StatLabelColor.b)
			LabelSetTextColor(element.."StatsBottom", MiniTexturePack.DB[custom].StatLabelColor.r, MiniTexturePack.DB[custom].StatLabelColor.g, MiniTexturePack.DB[custom].StatLabelColor.b)
			LabelSetTextColor(element.."Stats", MiniTexturePack.DB[custom].StatLabelColor.r, MiniTexturePack.DB[custom].StatLabelColor.g, MiniTexturePack.DB[custom].StatLabelColor.b)
		else
			DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
			LabelSetTextColor(element.."StatsTop", MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.r, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.g, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.b)
			LabelSetTextColor(element.."StatsBottom", MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.r, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.g, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.b)
			LabelSetTextColor(element.."Stats", MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.r, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.g, MiniTexturePack.DB[MiniTexturePack.Current].StatLabelColor.b)
		end
		
		if (iconId == 620) then
			DynamicImageSetTextureDimensions(elementIcon, 50, 50)
			WindowSetDimensions(elementIcon, 50, 50)
			DynamicImageSetTexture( elementIcon, MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
			DynamicImageSetTextureScale(elementIcon, 0.78 )
		else
			local texture, x, y = GetIconData( iconId )
			DynamicImageSetTextureDimensions(elementIcon, 50, 50)
			WindowSetDimensions(elementIcon, 50, 50)
			DynamicImageSetTexture( elementIcon, texture, x, y )		
			DynamicImageSetTextureScale(elementIcon, 0.78 )
		end
		
		
		--LabelSetTextColor(elementHotkey,HotbarSystem.LightItemLabel.r,HotbarSystem.LightItemLabel.g,HotbarSystem.LightItemLabel.b)
	end
end

function HotbarSystem.UpdatePlayerStatLabel(element, id)
	local statsName = WStringToString(WindowData.PlayerStatsDataCSV[id].name)
	
	if( WindowData.PlayerStatsDataCSV[id].hasDivider  == true) then
		local curVal = statsName

		local topValue = WindowData.PlayerStatus[curVal]
		local bottomValue = WindowData.PlayerStatus["Max"..statsName]
		if( (statsName == "Health") or (statsName == "Stamina") or (statsName == "Mana") ) then
			curVal = "Current"..statsName
			topValue = WindowData.PlayerStatus[curVal]
			if( topValue <= HotbarSystem.WARNINGLEVEL ) then
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].warningIconId)
			else
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].iconId)
			end	
		end
		
		if( (statsName == "Weight") ) then
			if (topValue >= (bottomValue - HotbarSystem.WARNINGLEVEL) ) then
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].warningIconId)	
			else
				HotbarSystem.SetHotbarIcon(element, WindowData.PlayerStatsDataCSV[id].iconId)
			end
		end
		
		LabelSetText(element.."StatsTop", StringToWString(tostring(topValue))  )
		LabelSetText(element.."StatsBottom", StringToWString(tostring(bottomValue)) )
	else
		local labelString = StringToWString(tostring(WindowData.PlayerStatus[statsName]))
		
		if(statsName == "Damage") then
			labelString = StringToWString(tostring(WindowData.PlayerStatus[statsName]).."-"..tostring(WindowData.PlayerStatus["Max"..statsName])) 
		end
		
		if(statsName == "TithingPoints" or statsName == "Gold")then 
			if (WindowData.PlayerStatus[statsName] >= 1000 )then				
				local tithConcat = WindowData.PlayerStatus[statsName] / 1000
				tithConcat = math.floor(tithConcat)
				labelString = StringToWString(tostring(tithConcat).."K")				
			end	
			LabelSetText(element.."Stats", labelString )
		elseif (CharacterSheet.Caps[statsName]) then
			local cap = CharacterSheet.Caps[statsName] + CharacterSheet.CapsBonus[statsName]
			LabelSetText(element.."StatsTop", labelString  )
			LabelSetText(element.."StatsBottom", StringToWString(tostring(cap)) )
		else
			LabelSetText(element.."Stats", labelString )	
		end		
		
	end

	
end

--Update the players stats on the hotbar when the player stats updates
function HotbarSystem.UpdatePlayerStat()
	local element
	local id
	for element, id in pairs (HotbarSystem.PlayerStatsElements) do
		HotbarSystem.UpdatePlayerStatLabel(element, id)
	end
end

function HotbarSystem.UpdateQuantityForOneSlot(element)
	local elementIcon = element.."SquareIcon"
	LabelSetText(element.."Quantity",L"")
	WindowSetShowing(element.."QuantityBackground", false)
end

function HotbarSystem.UpdateQuantity()

	local id = WindowData.UpdateInstanceId
	local quantity = 0

	local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(id)
	local checkUpdate = (objectType == HotbarSystem.Apple_OBJTYPE or objectType == HotbarSystem.BANDAGE_OBJTYPE or objectType == HotbarSystem.BANDAGE_SECOND_OBJTYPE or objectType == HotbarSystem.HealPot_OBJTYPE or objectType == HotbarSystem.Grape_OBJTYPE)
	
	
	if( HotbarSystem.ObjectSlots[id] ~= nil ) then
		local item = WindowData.ObjectTypeQuantity[id]
		
		if( item ~= nil ) then
			quantity = item.quantity
		end

		for element, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
		
			local oldQuantity = 0
			if ( HotbarSystem.OldQTA <= 0 ) then
				oldQuantity = tonumber(LabelGetText(element.."Quantity"))
			end
			if ( checkUpdate ) then
				if (oldQuantity > 0 ) then
					HotbarSystem.OldQTA = oldQuantity
				end
				if (quantity > 0 ) then
					HotbarSystem.QTA = quantity
				end
				updateNow = (HotbarSystem.OldQTA ~= 0 and HotbarSystem.QTA ~= 0)
				if (updateNow  ) then
					if (HotbarSystem.OldQTA > HotbarSystem.QTA) then
						HotbarSystem.QTAChangedID = id
						--Debug.Print(tostring(HotbarSystem.OldQTA) .. " | " .. tostring(HotbarSystem.QTA))
						HotbarSystem.UpdateDelayTime()
						
					end
					HotbarSystem.QTA = 0
					HotbarSystem.OldQTA = 0
					
				end
				
			end
			local elementIcon = element.."SquareIcon"
			
	
			if(item ~= nil and quantity > 0) then
				WindowSetShowing(element.."Disabled",false)
				ButtonSetDisabledFlag(element,false)
				
                EquipmentData.UpdateItemIcon(elementIcon, item)
			    
			    if quantity < 20 and CustomSettings and CustomSettings.LoadBoolean( element .. "EnableAlert", false ) then
					local alpha = 1.5 - (quantity / 20)
					WindowSetShowing(element.."Alert",true)
					WindowSetAlpha(element.."Alert", alpha)
				else
					WindowSetShowing(element.."Alert",false)
				end
			    
				LabelSetText(element.."Quantity",L"")
				WindowSetShowing(element.."QuantityBackground", false)
				if (quantity > 1) then
		
					local labelString
					if (quantity >= 1000) then
						local q = quantity / 1000
						q = math.floor(q)
						labelString = StringToWString(tostring(q).."K")	
					else
						labelString = StringToWString(tostring(quantity))	
					end
					LabelSetText(element.."Quantity",labelString)	
					WindowSetShowing(element.."QuantityBackground", true)
				end
			else
				WindowSetShowing(element.."Disabled",true)
				WindowSetShowing(element.."Alert",false)
				ButtonSetDisabledFlag(element,true)
				LabelSetText(element.."Quantity",L"")
				WindowSetShowing(element.."QuantityBackground", false)
			end
			
		end
	end
end

function HotbarSystem.UpdateDelayTime()

	for id, element in pairs(HotbarSystem.ObjectSlots) do
		for curElement, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
			local item  = WindowData.ObjectInfo[id]	
			local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(id)
			if ( item ~= nil ) then
				hue = item.hueId
			end

			if((objectType == HotbarSystem.BANDAGE_OBJTYPE or objectType == HotbarSystem.BANDAGE_SECOND_OBJTYPE) and id == HotbarSystem.QTAChangedID) then
				if (SystemData.Hotbar.BandageDelay ~= nil ) then
					HotbarSystem.BandageDelayTime = SystemData.Hotbar.BandageDelay.time
					if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
					if( HotbarSystem.BandageSlots[id] == nil ) then
						HotbarSystem.BandageSlots[id] = {}
					end
					 HotbarSystem.BandageSlots[id][curElement] = curElement
					 LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					 LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
					LabelSetText(curElement.."BandageTime", HotbarSystem.BandageDelayTime..L"s")
					WindowClearAnchors(curElement.."BandageTime")
						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 15, -5)
						WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
						if (not DoesWindowNameExist(curElement .. "Cooldown")) then
									CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
									AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
									AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/HotbarSystem.BandageDelayTime)))
									WindowSetAlpha(curElement .. "Cooldown", 0.65)
									WindowSetShowing(curElement .. "Hotkey", false)
								end
				end
			end
			
			if((objectType == HotbarSystem.HealPot_OBJTYPE) and id == HotbarSystem.QTAChangedID) then
			
				HotbarSystem.HealPotDelayTime = 10
				if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
				if( HotbarSystem.HealPotSlots[id] == nil ) then
					HotbarSystem.HealPotSlots[id] = {}
				end
				 HotbarSystem.HealPotSlots[id][curElement] = curElement
				 LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				LabelSetText(curElement.."BandageTime", HotbarSystem.HealPotDelayTime..L"s")
				LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
				WindowClearAnchors(curElement.."BandageTime")
						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 15, -5)
						WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
						
				if (not DoesWindowNameExist(curElement .. "Cooldown")) then
									CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
									AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
									AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/HotbarSystem.HealPotDelayTime)))
									WindowSetAlpha(curElement .. "Cooldown", 0.65)
									WindowSetShowing(curElement .. "Hotkey", false)
								end
			end
			
			if((objectType == HotbarSystem.Apple_OBJTYPE and hue == HotbarSystem.Apple_Color) and id == HotbarSystem.QTAChangedID) then
				HotbarSystem.AppleDelayTime = 30
				if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
				if( HotbarSystem.AppleSlots[id] == nil ) then
					HotbarSystem.AppleSlots[id] = {}
				end
				 HotbarSystem.AppleSlots[id][curElement] = curElement
				 LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				 LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
				LabelSetText(curElement.."BandageTime", HotbarSystem.AppleDelayTime..L"s")
				WindowClearAnchors(curElement.."BandageTime")
						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 15, -5)
						WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
						if (not DoesWindowNameExist(curElement .. "Cooldown")) then
									CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
									AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
									AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/HotbarSystem.AppleDelayTime)))
									WindowSetAlpha(curElement .. "Cooldown", 0.65)
									WindowSetShowing(curElement .. "Hotkey", false)
								end
			end
			
			if ((objectType == HotbarSystem.Grape_OBJTYPE and hue == HotbarSystem.Grape_Color) and id == HotbarSystem.QTAChangedID) then
				HotbarSystem.GrapeDelayTime = 120
				if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
				if( HotbarSystem.GrapeSlots[id] == nil ) then
					HotbarSystem.GrapeSlots[id] = {}
				end
				 HotbarSystem.GrapeSlots[id][curElement] = curElement
				 LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				 LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
				LabelSetText(curElement.."BandageTime", HotbarSystem.GrapeDelayTime..L"s")
				WindowClearAnchors(curElement.."BandageTime")
						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)
						WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
						if (not DoesWindowNameExist(curElement .. "Cooldown")) then
									CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
									AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
									AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/HotbarSystem.GrapeDelayTime)))
									WindowSetAlpha(curElement .. "Cooldown", 0.65)
									WindowSetShowing(curElement .. "Hotkey", false)
								end
			end
		end
	end
end

function HotbarSystem.HandleUpdateActionItem()
	--Debug.Print("OOO: " .. tostring(SystemData.UpdateActionItem.hotbarId)..", "..tostring(SystemData.UpdateActionItem.itemIndex))
	if( SystemData.UpdateActionItem.hotbarId == SystemData.MacroSystem.STATIC_MACRO_ID ) then
		MacroEditWindow.UpdateMacroActionList("ActionEditMacro", SystemData.UpdateActionItem.hotbarId, SystemData.UpdateActionItem.itemIndex)
	else
		Hotbar.ClearHotbarItem(SystemData.UpdateActionItem.hotbarId,SystemData.UpdateActionItem.itemIndex,true)
		Hotbar.SetHotbarItem(SystemData.UpdateActionItem.hotbarId,SystemData.UpdateActionItem.itemIndex)
	end
end

function HotbarSystem.Update(timePassed)
	HotbarSystem.CurrentSkillDelta = HotbarSystem.CurrentSkillDelta + timePassed
	if(HotbarSystem.CurrentSkillDelta >= HotbarSystem.SkillDelayDiff) then
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime - HotbarSystem.SkillDelayDiff
			HotbarSystem.CurrentSkillDelta = 0
	end
	
	if WindowData.CurrentTarget.TargetId then
		for id, element in pairs(HotbarSystem.Spells) do

			for element, curElement in pairs(HotbarSystem.Spells[id]) do
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					
					local type = UserActionGetType(hotbarId, itemIndex, 1)
					local idC = UserActionGetId(hotbarId, itemIndex, 1)
	
					if ( not HotbarHasItem(hotbarId, itemIndex) or id ~= idC or type ~= SystemData.UserAction.TYPE_SPELL ) then
						HotbarSystem.Spells[id][element] = nil
						WindowSetShowing(element.."Disabled",false)
						ButtonSetDisabledFlag(element,false)
						
					else
						local distance = -1
						for no, value in pairs(SpellsInfo.SpellsData) do
							if value.id== id then
								distance = value.distance
								break
							end
						end
						--TEMPORARILY DISABLED DUE TO GET DISTANCE MALFUNCTION
						bDisabled = false
						if (distance and distance >= 0) then
							local targetType = UserActionGetTargetType(hotbarId,itemIndex,1)
							if targetType and targetType == SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT then
								--bDisabled= GetDistanceFromPlayer(WindowData.CurrentTarget.TargetId) > distance and not DoesPlayerHaveItem(WindowData.CurrentTarget.TargetId)
							elseif targetType and targetType == SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID then
								local targ = UserActionGetTargetId(hotbarId,itemIndex,1)
								--bDisabled= GetDistanceFromPlayer(targ) > distance and not DoesPlayerHaveItem(targ)
							end
						end
						
						if( bDisabled == true ) then
							WindowSetShowing(element.."Disabled",true)
							WindowSetShowing(element.."Alert",false)
							ButtonSetDisabledFlag(element,true)
						else	
							WindowSetShowing(element.."Disabled",false)
							ButtonSetDisabledFlag(element,false)
						end
					end
				end

			end
		end
	end
	
	for id, element in pairs(HotbarSystem.WoDSlots) do
		if ( id == 1 and EnhancePack and HotbarSystem.WoDSlotsType[id] == SystemData.UserAction.TYPE_SKILL) then
			for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][element] = nil
					else
						if (DoesWindowNameExist(element.."SquareIcon")) then
							if (EnhancePack.HonorActive == true) then
								WindowSetTintColor(element.."SquareIcon",255,0,0)
							else
								WindowSetTintColor(element.."SquareIcon",255,255,255)
							end
						end
					end
				end
			end
		end
		
		if ( id == 404 and EnhancePack) then
			for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][element] = nil
					else
						if (DoesWindowNameExist(element.."SquareIcon")) then
		--					if (EnhancePack.CounterAttackActive == true) then
		--						WindowSetTintColor(element.."SquareIcon",255,0,0)
		--					else
							--if (EnhancePack.CounterTime <= 0) then
							--	WindowSetTintColor(element.."SquareIcon",255,255,255)
							--else
							--	WindowSetTintColor(element.."SquareIcon",255,0,0)
							--end
						end
					end
				end
			end
		end
		
		if ( id == 402 and EnhancePack) then
			for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][element] = nil
					else
						if (DoesWindowNameExist(element.."SquareIcon")) then
						--	if (EnhancePack.ConfidenceActive == true) then
						--		WindowSetTintColor(element.."SquareIcon",255,0,0)
						--	else
							if (BuffDebuff.Timers[1093] == nil or BuffDebuff.Timers[1093] <= 0) then
								WindowSetTintColor(element.."SquareIcon",255,255,255)
							else
								WindowSetTintColor(element.."SquareIcon",255,0,0)
							end
						end
					end
				end
			end
		end
		
		
		if ( id == 403 and EnhancePack) then 
			for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
				
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][element] = nil
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
					else
						if (DoesWindowNameExist(element.."SquareIcon")) then
						--	if (EnhancePack.EvasionActive == true) then
						--		WindowSetTintColor(element.."SquareIcon",255,0,0)
						--	else
						--	if (EnhancePack.EvasionTime <= 0) then
						--		WindowSetTintColor(element.."SquareIcon",255,255,255)
						--	else
						--		WindowSetTintColor(element.."SquareIcon",255,0,0)
						--	end
						end
						if (DoesWindowNameExist(curElement.."BandageTime")) then
							if (EnhancePack.EvasionRestart) then
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
								
							end
							if (EnhancePack.EvasionCooldown > 0) then
								if (not DoesWindowNameExist(curElement .. "Cooldown")) then
									CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
									AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
									AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/EnhancePack.EvasionCooldown)))
									WindowSetAlpha(curElement .. "Cooldown", 0.65)
									WindowSetShowing(curElement .. "Hotkey", false)
								end
								
								WindowSetLayer(curElement.."Cooldown",Window.Layers.OVERLAY)
								LabelSetText(curElement.."BandageTime", EnhancePack.EvasionCooldown..L"s")
								LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
								LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
								WindowClearAnchors(curElement.."BandageTime")
								WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)
								
								WindowSetLayer(curElement.."Overlay",Window.Layers.OVERLAY)
								WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
							else
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
								WindowSetShowing(curElement .. "Hotkey", true)
								LabelSetText(curElement.."BandageTime", L"")
							end
						end
					end
				end
				
			end
		end
		
		--if ( id == 203 and EnhancePack) then 
		--	for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
		--		
		--		local patt = element
		--		local fnd = string.find(patt , "Button")
		--		if (fnd ~= nil ) then
		--			local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
		--			local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
		--			if ( not HotbarHasItem(hotbarId, itemIndex) ) then
		--				HotbarSystem.WoDSlots[id][element] = nil
		--			else
		--				if (DoesWindowNameExist(curElement.."BandageTime")) then
		--					if (EnhancePack.ConsecrateCooldown > 0) then
		--						LabelSetText(curElement.."BandageTime", EnhancePack.ConsecrateCooldown..L"s")
		--						LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		--						LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
		--						WindowClearAnchors(curElement.."BandageTime")
		--						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)
		--						WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
		--						WindowSetShowing(curElement.."Disabled",true)
		--						
		--					else
		--						WindowSetShowing(curElement.."Disabled",false)
		--						LabelSetText(curElement.."BandageTime", L"")
		--						
		--					end
		--				end
		--			end
		--		end
		--		
		--	end
		--end
		
		--if ( id == 104 and EnhancePack) then 
		--	for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
		--		
		--		local patt = element
		--		local fnd = string.find(patt , "Button")
		--		if (fnd ~= nil ) then
		--			local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
		--			local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
		--			if ( not HotbarHasItem(hotbarId, itemIndex) ) then
		--				HotbarSystem.WoDSlots[id][element] = nil
		--				WindowSetShowing(curElement .. "Hotkey", true)
		--				LabelSetText(curElement.."BandageTime", L"")
		--				if ( DoesWindowNameExist(curElement.."Cooldown")) then
		--					DestroyWindow(curElement.."Cooldown")
		--				end
		--			else
		--				if (DoesWindowNameExist(curElement.."BandageTime")) then
		--					if (EnhancePack.CurseCooldown > 0) then
		--						if (not DoesWindowNameExist(curElement .. "Cooldown")) then
		--							CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
		--							AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
		--							AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/EnhancePack.CurseCooldown)))
		--							WindowSetAlpha(curElement .. "Cooldown", 0.65)
		--							WindowSetShowing(curElement .. "Hotkey", false)
		--						end
		--						LabelSetText(curElement.."BandageTime", EnhancePack.CurseCooldown..L"s")
		--						LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		--						LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
		--						WindowClearAnchors(curElement.."BandageTime")
		--						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)
		--						WindowSetLayer(curElement.."Overlay",Window.Layers.OVERLAY)
		--						WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
		--							
		--					else
		--
		--						LabelSetText(curElement.."BandageTime", L"")
		--						if ( DoesWindowNameExist(curElement.."Cooldown")) then
		--							DestroyWindow(curElement.."Cooldown")
		--						end
		--						WindowSetShowing(curElement .. "Hotkey", true)
		--					end
		--				end
		--			end
		--		end
				
		--	end
		--end
		
		
		if ( id == 604 and EnhancePack) then 
			for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
				
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][element] = nil
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
					else
						if (DoesWindowNameExist(curElement.."BandageTime")) then
							if (EnhancePack.AttunementRestart) then
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
								
							end
							if (EnhancePack.AttunementCharges>0) then
								LabelSetText(curElement.."BandageTime", L"" .. EnhancePack.AttunementCharges)
								LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
								LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
								WindowClearAnchors(curElement.."BandageTime")
								WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)	
								WindowSetShowing(curElement.."Disabled",true)
								WindowSetShowing(curElement.."Alert",false)
								WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
							elseif (EnhancePack.AttunementCooldown > 0) then
								if (not DoesWindowNameExist(curElement .. "Cooldown")) then
									CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
									AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
									AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/EnhancePack.AttunementCooldown)))
									WindowSetAlpha(curElement .. "Cooldown", 0.65)
									WindowSetShowing(curElement .. "Hotkey", false)
								end
								LabelSetText(curElement.."BandageTime", EnhancePack.AttunementCooldown..L"s")
								LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
								LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
								WindowClearAnchors(curElement.."BandageTime")
								WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)
								WindowSetLayer(curElement.."Overlay",Window.Layers.OVERLAY)
								WindowSetShowing(curElement.."Disabled",false)
								WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
							else
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
								WindowSetShowing(curElement .. "Hotkey", true)
								LabelSetText(curElement.."BandageTime", L"")
								WindowSetShowing(curElement.."Disabled",false)
							end
						end
					end
				end
				
			end
		end
		
		if ( id == 613 and EnhancePack) then 
			for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
				
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][element] = nil
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
					else
						if (DoesWindowNameExist(curElement.."BandageTime")) then
							if (EnhancePack.EtherealVoyageRestart) then
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
								
							end
							if (EnhancePack.EtherealVoyageCooldown > 0) then
								if (not DoesWindowNameExist(curElement .. "Cooldown")) then
									CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
									AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
									AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/EnhancePack.EtherealVoyageCooldown)))
									WindowSetAlpha(curElement .. "Cooldown", 0.65)
									WindowSetShowing(curElement .. "Hotkey", false)
								end
								LabelSetText(curElement.."BandageTime", EnhancePack.EtherealVoyageCooldown..L"s")
								LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
								LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
								WindowClearAnchors(curElement.."BandageTime")
								WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)
								WindowSetLayer(curElement.."Overlay",Window.Layers.OVERLAY)
								WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
							else
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
								WindowSetShowing(curElement .. "Hotkey", true)
								LabelSetText(curElement.."BandageTime", L"")
							end
						end
					end
				end
				
			end
		end
		
		if ( id == 36 and EnhancePack  and HotbarSystem.WoDSlotsType[id] ~= SystemData.UserAction.TYPE_SKILL) then -- WOD
			for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
				
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][element] = nil
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
					else
						if (DoesWindowNameExist(curElement.."BandageTime")) then
							if (EnhancePack.ReflectionRestart) then
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
							end
							if (EnhancePack.ReflectionCharges > 0) then
								LabelSetText(curElement.."BandageTime", L"" .. EnhancePack.ReflectionCharges)
								LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
								LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
								WindowClearAnchors(curElement.."BandageTime")
								WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)	
								WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
								WindowSetShowing(curElement.."Disabled",true)
								WindowSetShowing(curElement.."Alert",false)
							elseif (EnhancePack.ReflectionCooldown > 0) then
								if (not DoesWindowNameExist(curElement .. "Cooldown")) then
									CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
									AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
									AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/EnhancePack.ReflectionCooldown)))
									WindowSetAlpha(curElement .. "Cooldown", 0.65)
									WindowSetShowing(curElement .. "Hotkey", false)
								end
								LabelSetText(curElement.."BandageTime", EnhancePack.ReflectionCooldown..L"s")
								LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
								LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
								WindowClearAnchors(curElement.."BandageTime")
								WindowSetShowing(curElement.."Disabled",false)
								WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)
								WindowSetLayer(curElement.."Overlay",Window.Layers.OVERLAY)
								WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)
							else
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
								WindowSetShowing(curElement .. "Hotkey", true)
								LabelSetText(curElement.."BandageTime", L"")
								WindowSetShowing(curElement.."Disabled",false)
							end
						end
					end
				end
				
			end
		end

		if ( HotbarSystem.WoDSlotsType[id] == SystemData.UserAction.TYPE_SKILL and HotbarSystem.SkillDelayTime >= 0 ) then 
			
			for element, curElement in pairs(HotbarSystem.WoDSlots[id]) do
				
				local patt = element
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][element] = nil
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
					else
						
						if (DoesWindowNameExist(curElement.."BandageTime")) then

							if ( DoesWindowNameExist(curElement.."Cooldown")) then
								if ( HotbarSystem.SkillDelayRestarted) then
									DestroyWindow(curElement.."Cooldown")
								end
								
							end
							if (not DoesWindowNameExist(curElement .. "Cooldown")) then
								CreateWindowFromTemplate(curElement .. "Cooldown", "CooldownEffect", curElement)
								AnimatedImageStartAnimation(curElement .. "Cooldown", 2,false,false,0)
								AnimatedImageSetPlaySpeed(curElement .. "Cooldown", math.max(1, math.floor(EnhancePack.CooldownFrames/HotbarSystem.SkillDelayTime)))
								WindowSetAlpha(curElement .. "Cooldown", 0.65)
								WindowSetShowing(curElement .. "Hotkey", false)
							end
							LabelSetText(curElement.."BandageTime", HotbarSystem.SkillDelayTime..L"s")
							LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
							LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
							WindowClearAnchors(curElement.."BandageTime")
							WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 15, -5)	
							if( HotbarSystem.SkillDelayTime <= 0 ) then
								if ( DoesWindowNameExist(curElement.."Cooldown")) then
									DestroyWindow(curElement.."Cooldown")
								end
								WindowSetShowing(curElement .. "Hotkey", true)
								LabelSetText(curElement.."BandageTime", L"")
							else
								WindowSetLayer(curElement.."Overlay",Window.Layers.OVERLAY)
								WindowSetLayer(curElement.."BandageTime",Window.Layers.OVERLAY)							
							end
						end
					end
				end
				
			end
			
		end
		
		
		if ( id == 614 ) then -- WOD
			for curElement, itemLoc in pairs(HotbarSystem.WoDSlots[id]) do
				local patt = curElement
				local fnd = string.find(patt , "Button")
				if (fnd ~= nil ) then
					local hotbarId = tonumber(string.sub(patt,7, fnd - 1))
					local itemIndex = tonumber(string.sub(patt, fnd + 6 ))
					if ( not HotbarHasItem(hotbarId, itemIndex) ) then
						HotbarSystem.WoDSlots[id][curElement] = nil
						local num = table.getn(EnhancePack.HighlightStarted)
						if ( num > 0 ) then
							for i=1,num do
								local effectName = "GlowingEffect"..hotbarId .."|"..itemIndex
								if ( EnhancePack.HighlightStarted[i] ==  effectName ) then
									AnimatedImageStopAnimation( "GlowingEffectAnim"..hotbarId .."|"..itemIndex)  
									DestroyWindow( "GlowingEffect"..hotbarId .."|"..itemIndex )
									EnhancePack.HighlightStarted[i] = nil
									WindowSetAlpha(curElement .. "SquareIcon", 1.0)
									break
								end
							end
						end
					else
						local circleLimit = EnhancePack.ArcaneFocusLevel * 5
						if (circleLimit <= 0) then
							circleLimit = 0
						end
						if ( HotbarSystem.CurrentTargLife == nil ) then
							HotbarSystem.CurrentTargLife = 100
						end
						local bDisabled = HotbarSystem.CurrentTargLife > circleLimit
						--Debug.Print(tostring(bDisabled))
						--Debug.Print(tostring(curElement))	
						local hotbarName = curElement
						
						local effectIndex = hotbarId .. "|" .. itemIndex

						hotbarName = string.sub(hotbarName,1,fnd-1)
						local create = true
						local idx = -1
						local num = table.getn(EnhancePack.HighlightStarted)
						if ( num > 0 ) then
							for i=1,num do
								local effectName = "GlowingEffect"..effectIndex
								if ( EnhancePack.HighlightStarted[i] ==  effectName ) then
									create = false
									idx = i
								end
							end
						end
						
						if ( WindowData.CurrentTarget.TargetId == 0 ) then
							bDisabled = true
							if (idx > 0 ) then
								create = false
							end
						end
						if( bDisabled == false ) then
							
							if ( create ) then
								CreateWindowFromTemplate("GlowingEffect"..effectIndex, "TEXTs", "Hotbar1")
								CreateWindowFromTemplate("GlowingEffectAnim"..effectIndex, "WodEffect", "GlowingEffect"..effectIndex)
								WindowClearAnchors("GlowingEffect"..effectIndex)
								WindowSetParent("GlowingEffect"..effectIndex, hotbarName)
								WindowAddAnchor("GlowingEffect"..effectIndex, "center", curElement, "center", 0, 0)
								AnimatedImageStartAnimation( "GlowingEffectAnim"..effectIndex, 1, true, false, 0.0 )  
								EnhancePack.HighlightStarted[num+1] = "GlowingEffect"..effectIndex
								WindowSetAlpha(curElement .. "SquareIcon", 0.5)
								WindowSetLayer("GlowingEffect"..effectIndex,Window.Layers.OVERLAY)
								WindowSetLayer(curElement.."Overlay",Window.Layers.OVERLAY)
							end
						else
							if ( create == false ) then
								AnimatedImageStopAnimation( "GlowingEffectAnim"..effectIndex)  
								DestroyWindow( "GlowingEffect"..effectIndex )
								EnhancePack.HighlightStarted[idx] = nil
								WindowSetAlpha(curElement .. "SquareIcon", 1)
							end
						end
					end
				end
				
			end
		end
	end
	if( HotbarSystem.BandageDelayTime > 0 ) then
		HotbarSystem.CurrentBandageDelta = HotbarSystem.CurrentBandageDelta + timePassed
		if(HotbarSystem.CurrentBandageDelta >= HotbarSystem.BandageDelayDiff) then
			HotbarSystem.BandageDelayTime = HotbarSystem.BandageDelayTime - HotbarSystem.BandageDelayDiff
			for id, nextElement in pairs (HotbarSystem.BandageSlots) do
				for element, curElement in pairs(HotbarSystem.BandageSlots[id]) do
					LabelSetText(curElement.."BandageTime", HotbarSystem.BandageDelayTime..L"s")
					LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
					WindowClearAnchors(curElement.."BandageTime")
						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 15, -5)
					if( HotbarSystem.BandageDelayTime <= 0 ) then
						HotbarSystem.BandageSlots[id][element] = nil
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")
					end
				end
			end
			HotbarSystem.CurrentBandageDelta = 0
		end
	end
	
	if( HotbarSystem.HealPotDelayTime > 0 ) then
		HotbarSystem.CurrentHealDelta = HotbarSystem.CurrentHealDelta + timePassed
		if(HotbarSystem.CurrentHealDelta >= HotbarSystem.HealPotDelayDiff) then
			HotbarSystem.HealPotDelayTime = HotbarSystem.HealPotDelayTime - HotbarSystem.HealPotDelayDiff
			for id, nextElement in pairs (HotbarSystem.HealPotSlots) do
				for element, curElement in pairs(HotbarSystem.HealPotSlots[id]) do
					LabelSetText(curElement.."BandageTime", HotbarSystem.HealPotDelayTime..L"s")
					LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
					WindowClearAnchors(curElement.."BandageTime")
						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 15, -5)
					if( HotbarSystem.HealPotDelayTime <= 0 ) then
						HotbarSystem.HealPotSlots[id][element] = nil
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")

					end
				end
			end
			HotbarSystem.CurrentHealDelta = 0
		end
	end
	
	if( HotbarSystem.AppleDelayTime > 0 ) then
		HotbarSystem.CurrentAppleDelta = HotbarSystem.CurrentAppleDelta + timePassed
		if(HotbarSystem.CurrentAppleDelta >= HotbarSystem.AppleDelayDiff) then
			HotbarSystem.AppleDelayTime = HotbarSystem.AppleDelayTime - HotbarSystem.AppleDelayDiff
			for id, nextElement in pairs (HotbarSystem.AppleSlots) do
				for element, curElement in pairs(HotbarSystem.AppleSlots[id]) do
					LabelSetText(curElement.."BandageTime", HotbarSystem.AppleDelayTime..L"s")
					LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
					WindowClearAnchors(curElement.."BandageTime")
						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 15, -5)

					if( HotbarSystem.AppleDelayTime <= 0 ) then
						HotbarSystem.AppleSlots[id][element] = nil
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")

					end
				end
			end
			HotbarSystem.CurrentAppleDelta = 0
		end
	end
	
	if( HotbarSystem.GrapeDelayTime > 0 ) then
		HotbarSystem.CurrentGrapeDelta = HotbarSystem.CurrentGrapeDelta + timePassed
		if(HotbarSystem.CurrentGrapeDelta >= HotbarSystem.GrapeDelayDiff) then
			HotbarSystem.GrapeDelayTime = HotbarSystem.GrapeDelayTime - HotbarSystem.GrapeDelayDiff
			for id, nextElement in pairs (HotbarSystem.GrapeSlots) do
				for element, curElement in pairs(HotbarSystem.GrapeSlots[id]) do
					LabelSetText(curElement.."BandageTime", HotbarSystem.GrapeDelayTime..L"s")
					LabelSetFont(curElement.."BandageTime", "font_verdana_bold_shadow_med", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					LabelSetTextColor(curElement.."BandageTime",HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b)
					WindowClearAnchors(curElement.."BandageTime")
						WindowAddAnchor(curElement.."BandageTime", "center", curElement, "center", 10, -5)
	
					if( HotbarSystem.GrapeDelayTime <= 0 ) then
						HotbarSystem.GrapeSlots[id][element] = nil
						if ( DoesWindowNameExist(curElement.."Cooldown")) then
							DestroyWindow(curElement.."Cooldown")
						end
						WindowSetShowing(curElement .. "Hotkey", true)
						LabelSetText(curElement.."BandageTime", L"")					
					end
				end
			end
			HotbarSystem.CurrentGrapeDelta = 0
		end
	end
	HotbarSystem.SkillDelayRestarted = false
	EnhancePack.ReflectionRestart = false
	EnhancePack.EtherealVoyageRestart = false
	EnhancePack.AttunementRestart = false
	EnhancePack.EvasionRestart = false
end

function HotbarSystem.DisableBandagingMacros(disable)
	if not EnhancePack.DisableBandages then
		return
	end
	for id, e in pairs(HotbarSystem.MacroReferenceSlots) do
		for element, arr in pairs(e) do
			local hotbarId = arr.hotbarId
			local itemIndex = arr.itemIndex
			
			local macroId = UserActionGetId(hotbarId,itemIndex,0)
			local macroIndex = MacroSystemGetMacroIndexById(macroId)

			local numActions = UserActionMacroGetNumActions(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex)
			local hasBandages = false
			for i = 1, numActions do
				local actionId = UserActionGetId(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex,i)
				
				local actionType = UserActionGetType(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, i)
				if (actionType == SystemData.UserAction.TYPE_USE_ITEM or actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then
					local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(actionId)
					if objectType == HotbarSystem.BANDAGE_OBJTYPE or objectType == HotbarSystem.BANDAGE_SECOND_OBJTYPE then
						hasBandages = true
						break
					end
				elseif (actionType == 102 or actionType == 103) then
					hasBandages = true
					break
				end
			end
			if( hasBandages == true ) then
				if  disable == true then
					WindowSetShowing(element.."Disabled",true)
					WindowSetShowing(element.."Alert",false)
					ButtonSetDisabledFlag(element,true)
					if not HotbarSystem.BindingsBackup then
						HotbarSystem.BindingsBackup = {}
					end
					
					SystemData.Hotbar[arr.hotbarId].Bindings[arr.itemIndex] = L""
					
				else	
					WindowSetShowing(element.."Disabled",false)
					ButtonSetDisabledFlag(element,false)
					SystemData.Hotbar[arr.hotbarId].Bindings[arr.itemIndex] = HotbarSystem.BindingsBackup[arr.hotbarId][arr.itemIndex]
				end
				HotbarUpdateBinding(arr.hotbarId,arr.itemIndex,SystemData.Hotbar[arr.hotbarId].Bindings[arr.itemIndex] )
			end

		end
	end
	for id, element in pairs(HotbarSystem.ObjectSlots) do
		for curElement, itemLoc in pairs(HotbarSystem.ObjectSlots[id]) do
			local item  = WindowData.ObjectInfo[id]	
			local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(id)
			if ( item ~= nil ) then
				hue = item.hueId
			end
			
			local fnd = string.find(curElement , "Button")
			local hotbarId = tonumber(string.sub(curElement,7, fnd - 1))
			local itemIndex = tonumber(string.sub(curElement, fnd + 6 ))
			itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex}

			if (objectType == HotbarSystem.BANDAGE_OBJTYPE or objectType == HotbarSystem.BANDAGE_SECOND_OBJTYPE) then
				if( disable == true) then
					WindowSetShowing(curElement.."Disabled",true)
					WindowSetShowing(curElement.."Alert",false)
					ButtonSetDisabledFlag(curElement,true)

					SystemData.Hotbar[itemLoc.hotbarId].Bindings[itemLoc.itemIndex] = L""
				else	
					WindowSetShowing(curElement.."Disabled",false)
					ButtonSetDisabledFlag(curElement,false)
					SystemData.Hotbar[itemLoc.hotbarId].Bindings[itemLoc.itemIndex] = HotbarSystem.BindingsBackup[itemLoc.hotbarId][itemLoc.itemIndex]
					
				end
				HotbarUpdateBinding(itemLoc.hotbarId,itemLoc.itemIndex,SystemData.Hotbar[itemLoc.hotbarId].Bindings[itemLoc.itemIndex] )
			end
		end
	end
	for s, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
		for index = 1, Hotbar.NUM_BUTTONS do
			if not SystemData.Hotbar[hotbarId] then
				continue
			end
			local hotbar = "Hotbar"..hotbarId
			local element = hotbar.."Button"..index
			
			local actionType = UserActionGetType(hotbarId, index, 0)
	
			if( actionType == 102 or actionType == 103) then --bandage self//target
				if  disable == true then
					WindowSetShowing(element.."Disabled",true)
					WindowSetShowing(element.."Alert",false)
					ButtonSetDisabledFlag(element,true)
	

					SystemData.Hotbar[hotbarId].Bindings[index] = L""
					
				else	
					WindowSetShowing(element.."Disabled",false)
					ButtonSetDisabledFlag(element,false)
					SystemData.Hotbar[hotbarId].Bindings[index] = HotbarSystem.BindingsBackup[hotbarId][index]
				end
				HotbarUpdateBinding(hotbarId,index,SystemData.Hotbar[hotbarId].Bindings[index] )
				
			end
		end
	end
	BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )
end

function HotbarSystem.UpdateMacroReferenceSlot(macroIndex)
	local id = WindowData.UpdateInstanceId
	if(macroIndex ~= nil) then
		id = macroIndex
	end
	
	if( HotbarSystem.MacroReferenceSlots[id] ~= nil ) then
		local macroIndex = MacroSystemGetMacroIndexById(id)
		
		for element, itemLoc in pairs(HotbarSystem.MacroReferenceSlots[id]) do
			-- if macroIndex is 0 then the macro was deleted
			if( macroIndex == 0 ) then
				HotbarSystem.ClearActionIcon(element, itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex, true)
				-- right now macro references can only exist in the hotbar
				HotbarClearItem(itemLoc.hotbarId,itemLoc.itemIndex)
			-- else the icon might have changed so reset it
			else
				HotbarSystem.RegisterAction(element, itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
			end
		end
	end
end

function HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, subIndex, slotWindow)
	local actionType = UserActionGetType(hotbarId,itemIndex,subIndex)

	--Debug.Print("HotbarSystem.CreateUserActionContextMenuOptions: "..tostring(hotbarId)..", "..tostring(itemIndex)..", "..tostring(subIndex).." actionType: "..tostring(actionType))
	local actionId = UserActionGetId(hotbarId,itemIndex,subIndex)
	local param = {HotbarId=hotbarId, ItemIndex=itemIndex, SubIndex=subIndex, SlotWindow=slotWindow, ActionType=actionType, ActionId=actionId}
	
	ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_CLEAR_ITEM,0,HotbarSystem.ContextReturnCodes.CLEAR_ITEM,param)
	
	local type = UserActionGetType(hotbarId, itemIndex, subIndex)
	local idC = UserActionGetId(hotbarId, itemIndex, subIndex)
	local cursorOnly=false
	local noSelf=false
	local notarget = false
	if (type == SystemData.UserAction.TYPE_SPELL) then
		for no, value in pairs(SpellsInfo.SpellsData) do
			if value.id == idC then
				notarget = value.notarget
				noSelf = value.noSelf
				cursorOnly = value.cursorOnly
				break
			end
		end
	end
	
	if type == SystemData.UserAction.TYPE_SKILL and idC ~= 9 then
		noSelf=true
	end
	
	if type == SystemData.UserAction.TYPE_SKILL and (idC== 46 or idC== 32 or idC== 56 or idC== 38 or idC== 21 or idC== 47) then -- meditation, spirit speak, imbuing, tracking, hiding, stealth
		notarget=true
	end
	
	if( ( UserActionHasTargetType(hotbarId,itemIndex,subIndex) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false ) and (not notarget) ) then
		local targetType = UserActionGetTargetType(hotbarId,itemIndex,subIndex)
		-- determine which target type is pressed (add one to type for 1 based lua array)
		local pressed = { false, false, false, false }
		pressed[targetType+1] = true
		--Debug.Print("TargetType: "..targetType)
		local subMenu = {
			{ tid = HotbarSystem.TID_SELF,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_SELF,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_SELF] },
			{ tid = HotbarSystem.TID_CURSOR,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURSOR,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
			{ tid = HotbarSystem.TID_OBJECT_ID,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
			{ tid = HotbarSystem.TID_CURRENT,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURRENT,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] } }

		
		if (cursorOnly) then
			subMenu = {
			{ tid = HotbarSystem.TID_CURSOR,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURSOR,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] } }
			
		elseif (noSelf) then
			subMenu = {
			{ tid = HotbarSystem.TID_CURSOR,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURSOR,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
			{ tid = HotbarSystem.TID_OBJECT_ID,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
			{ tid = HotbarSystem.TID_CURRENT,flags=0,returnCode=HotbarSystem.ContextReturnCodes.TARGET_CURRENT,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] } }

		end
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_TARGET,0,0,param,false,subMenu) 
	end	
	
	-- if its a macro reference, we need to dereference it for the edit window
	local editParam = {HotbarId=hotbarId, ItemIndex=itemIndex, SubIndex=subIndex, SlotWindow=slotWindow, ActionType=actionType, ActionId=actionId}
	
	if( actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
		local macroId = UserActionGetId(hotbarId,itemIndex,0)
		local macroIndex = MacroSystemGetMacroIndexById(macroId)
		editParam.ActionType = SystemData.UserAction.TYPE_MACRO
		editParam.HotbarId = SystemData.MacroSystem.STATIC_MACRO_ID
		editParam.ItemIndex = macroIndex
		if not UserActionMacroGetRepeatEnabled( editParam.HotbarId, editParam.ItemIndex ) then
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_ENABLE_REPEAT,0,HotbarSystem.ContextReturnCodes.ENABLE_REPEAT,editParam)
		else
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_DISABLE_REPEAT,0,HotbarSystem.ContextReturnCodes.DISABLE_REPEAT,editParam)
		end
	end		
	
	if( (actionType == SystemData.UserAction.TYPE_USE_ITEM or actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE) and SystemData.Hotbar[editParam.HotbarId]) then 
		if  SystemData.Hotbar[editParam.HotbarId].Locked or CustomSettings.LoadBoolean( "Hotbar" .. editParam.HotbarId .. "LockWithHandle", false ) then  	
			local element = "Hotbar"..editParam.HotbarId.."Button"..editParam.ItemIndex .. "AllowDrag"
					
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 779),0,"allowDrag", editParam,CustomSettings.LoadBoolean( element, false ))
		end
	end
	if (actionType == SystemData.UserAction.TYPE_DELAY) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5016),0,"customDelay",editParam,false)
	end
	local actionData = ActionsWindow.GetActionDataForType(editParam.ActionType)
	if( actionData ~= nil and actionData.editWindow ~= nil) then
		
		if (actionId == 10018) then
			local subMenu = {}
			for i=1, Organizer.Organizers do
				local name = L"Use Organizer " .. i
				if (Organizer.Organizers_Desc[i] ~= L"") then
					name = Organizer.Organizers_Desc[i]
				end
				item = { str = name,flags=0,returnCode="org" .. i,param=param,pressed=Organizer.ActiveOrganizer == i,false }
				table.insert(subMenu, item)
			end

			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 890),0,0,"null",false,subMenu)
		end
		if (actionId == 10023) then
			local speech = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

			if ActionsWindow.ActionData[10023].callback == speech then
				ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 982),0,"setBodResCont",editParam,false)
			else
				ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 983),0,"unsetBodResCont",editParam,false)
			end
		end
		if (actionId == 10027) then
			local speech = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)
			speech = wstring.gsub(speech, L"script EnhancePack.ChangeSecurity[(]\"", L"")
			speech = wstring.gsub(speech, L"\"[)]", L"")
			speech = tostring(speech)
			local subMenu = {
			{ tid = 1061277,flags=0,returnCode="owner",param=param,pressed=speech=="owner" },
			{ tid = 1061278,flags=0,returnCode="coowner",param=param,pressed=speech=="coowner" },
			{ tid = 1061279,flags=0,returnCode="friend",param=param,pressed=speech=="friend" },
			{ tid = 1063455,flags=0,returnCode="guild",param=param,pressed=speech=="guild" },
			{ tid = 1061626,flags=0,returnCode="anyone",param=param,pressed=speech=="anyone" } }

			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5006),0,0,"null",false,subMenu)
		end
	end
	if( actionData ~= nil and actionData.editWindow ~= nil) then
		if (actionId < 5000  or (actionId >= 5070 and actionId <= 5099) or (actionId >= 6000 and actionId <= 6999) or actionId == 5048 or actionId == 5058 or actionId == 5059  or (actionId > 15000 and actionId < 15100))  or actionId == 10021 or actionId == 10041 then
			ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_EDIT_ITEM,0,HotbarSystem.ContextReturnCodes.EDIT_ITEM,editParam)
		end
	end
	
	if( type == SystemData.UserAction.TYPE_USE_ITEM or
	    type == SystemData.UserAction.TYPE_USE_OBJECTTYPE ) then
		if CustomSettings.LoadBoolean( "Hotbar" .. hotbarId .. "Button" .. itemIndex .. "EnableAlert", false ) then
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 7041),0,"toggleAlert", param,false)
		else
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 7040),0,"toggleAlert",param, false)
		end
	end
	
	local type = UserActionGetType(hotbarId, itemIndex, subIndex)

	if type == SystemData.UserAction.TYPE_SPELL  and actionId == 681 then -- enchant
		local element = "Hotbar"..hotbarId.."Button"..itemIndex
		local press = EnhancePack.ForceEnchant
		local subMenu = {
		{ str = GetStringFromTid(1080133),flags=0,returnCode="enchant0",param=param,pressed=press==0,false }; -- Select Enchant
		{ str = GetStringFromTid(1079702),flags=0,returnCode="enchant1",param=param,pressed=press==1,false }; -- Hit Dispel
		{ str = GetStringFromTid(1079703),flags=0,returnCode="enchant2",param=param,pressed=press==2,false }; -- Hit Fireball
		{ str = GetStringFromTid(1079704),flags=0,returnCode="enchant3",param=param,pressed=press==3,false }; -- Hit Harm
		{ str = GetStringFromTid(1079705),flags=0,returnCode="enchant4",param=param,pressed=press==4,false }; -- Hit Lightning
		{ str = GetStringFromTid(1079706),flags=0,returnCode="enchant5",param=param,pressed=press==5,false }; -- Hit Magic Arrow
		}
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1080133),0,0,"null",false,subMenu)
	end
	if(actionId and subIndex == 0) then
		local element = "Hotbar"..hotbarId.."Button"..itemIndex
		local subMenu = {}
		local custom = CustomSettings.LoadNumber( element .. "Custom", nil )
		
		for i = 1, table.getn( MiniTexturePack.DB )do
			local press = false
			if (custom) then
				press =custom == i
			else
				press =MiniTexturePack.Current==i
			end
			item = { str = MiniTexturePack.DB[i].name,flags=0,returnCode="minitxt" .. i,param=param,pressed=press,false }
			table.insert(subMenu, item)
		end
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 732),0,0,"null",false,subMenu)
	end
end

function HotbarSystem.ContextMenuCallback(returnCode,param)
	local bHandled = true
	
	if( returnCode == HotbarSystem.ContextReturnCodes.TARGET_SELF ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_SELF)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_CURRENT ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_CURSOR ) then
		UserActionSetTargetType(param.HotbarId,param.ItemIndex,param.SubIndex,SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID ) then
		HotbarSystem.RequestTargetInfo(param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.EDIT_ITEM ) then
		local actionId = UserActionGetId(param.HotbarId,param.ItemIndex,param.SubIndex)
		if (actionId >= 5070 and actionId <= 5084) then
			EnhancePack.PetballHotbar = param.HotbarId
			EnhancePack.PetballSlot= param.ItemIndex
			EnhancePack.PetballSubIndex = param.SubIndex
			EnhancePack.TargetPetball()
		elseif (actionId >= 5085 and actionId <= 5099) then
			EnhancePack.PetballHotbar = param.HotbarId
			EnhancePack.PetballSlot= param.ItemIndex
			EnhancePack.PetballSubIndex = param.SubIndex
			EnhancePack.PetballAction = actionId
			EnhancePack.TargetMount()
		elseif (actionId == 10021) then
			EnhancePack.PetballHotbar = param.HotbarId
			EnhancePack.PetballSlot= param.ItemIndex
			EnhancePack.PetballSubIndex = param.SubIndex
			EnhancePack.PetballAction = actionId
			EnhancePack.TargetWeaponType()
		elseif (actionId == 10041) then
			EnhancePack.PetballHotbar = param.HotbarId
			EnhancePack.PetballSlot= param.ItemIndex
			EnhancePack.PetballSubIndex = param.SubIndex
			EnhancePack.PetballAction = actionId
			EnhancePack.TargetType()
		else
			WindowSetShowing("ActionsWindow",true) -- Open the actions window
--			--Debug.Print(param.HotbarId)
			ActionEditWindow.OpenEditWindow(param.ActionType,param.SlotWindow,param.HotbarId,param.ItemIndex,param.SubIndex, param.ActionId)
		end
	elseif( returnCode == HotbarSystem.ContextReturnCodes.ENABLE_REPEAT ) then
		UserActionMacroSetRepeatEnabled(param.HotbarId,param.ItemIndex,true)
	elseif( returnCode == HotbarSystem.ContextReturnCodes.DISABLE_REPEAT ) then
		UserActionMacroSetRepeatEnabled(param.HotbarId,param.ItemIndex,false)
	elseif( returnCode == "setBodResCont" ) then
		HotbarSystem.tempParam = param
		RequestTargetInfo()
		EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 822), 1152, true)
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "HotbarSystem.DefaultContainer")
	elseif( returnCode == "unsetBodResCont" ) then	
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, ActionsWindow.ActionData[10023].callback)
	elseif( returnCode == "owner" ) then	
		local cb = wstring.gsub(ActionsWindow.ActionData[10027].callback, L"~TYPE~", L"\"owner\"")
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)
	elseif( returnCode == "coowner" ) then	
		local cb = wstring.gsub(ActionsWindow.ActionData[10027].callback, L"~TYPE~", L"\"coowner\"")
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)
	elseif( returnCode == "friend" ) then	
		local cb = wstring.gsub(ActionsWindow.ActionData[10027].callback, L"~TYPE~", L"\"friend\"")
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)
	elseif( returnCode == "guild" ) then	
		local cb = wstring.gsub(ActionsWindow.ActionData[10027].callback, L"~TYPE~", L"\"guild\"")
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)
	elseif( returnCode == "anyone" ) then	
		local cb = wstring.gsub(ActionsWindow.ActionData[10027].callback, L"~TYPE~", L"\"anyone\"")
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)
	elseif( returnCode == "customDelay" ) then	
		local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type, 5016), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 5017), callfunction=HotbarSystem.CustomDelay, id=param}
		RenameWindow.Create(rdata)
	elseif ( returnCode == "toggleAlert" ) then
		CustomSettings.SaveBoolean( "Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex .. "EnableAlert", not CustomSettings.LoadBoolean( "Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex .. "EnableAlert", false ) )
		if not CustomSettings.LoadBoolean( "Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex .. "EnableAlert", false ) then
			WindowSetShowing("Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex.."Alert",false)
		else
			WindowData.UpdateInstanceId = UserActionGetId(param.HotbarId, param.ItemIndex, param.SubIndex)
			HotbarSystem.UpdateQuantity()
		end
	else
		bHandled = false
	end
	
	return bHandled
end

function HotbarSystem.CustomDelay(param, text)
	local delayValue = tonumber(text) 
	if delayValue and delayValue > 0 then
		UserActionDelaySetDelay(param.HotbarId, param.ItemIndex, param.SubIndex, delayValue)
	end
end

HotbarSystem.tempParam = nil
function HotbarSystem.DefaultContainer()
	local objectId = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	if not objectId or objectId == 0 then
		EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 978), 33, true)
		return
	end
	local param = HotbarSystem.tempParam
	local speechText = L"script EnhancePack.RestockOpenBod(" .. objectId .. L")"
	UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, speechText)	
	
	HotbarSystem.tempParam = nil				
end

function HotbarSystem.RegisterSpellIcon(iconWindow,spellId)
	HotbarSystem.RegisteredSpellIcons[iconWindow] = spellId	
end

function HotbarSystem.UnregisterSpellIcon(iconWindow)
	HotbarSystem.RegisteredSpellIcons[iconWindow] = nil	
end

function HotbarSystem.HighlightSpellIcon()
	local spellId = SystemData.HotbarSystem.HighlightSpellIconInput.highlightSpellID
	local highlightEnabled = SystemData.HotbarSystem.HighlightSpellIconInput.highlightSpellEnabled
	for iconWindow, id in pairs(HotbarSystem.RegisteredSpellIcons) do
		if( iconWindow ~= nil and id == spellId ) then
			if (highlightEnabled ~= 0) then	
				WindowSetTintColor(iconWindow.."SquareIcon",255,0,0)
			end
		end
	end
end

function HotbarSystem.UnhighlightSpellIcon()
	local spellId = SystemData.HotbarSystem.UnhighlightSpellIconInput.highlightSpellID
	local highlightEnabled = SystemData.HotbarSystem.UnhighlightSpellIconInput.highlightSpellEnabled
	for iconWindow, id in pairs(HotbarSystem.RegisteredSpellIcons) do
		if( iconWindow ~= nil and id == spellId ) then
			if (highlightEnabled == 0) then	
				WindowSetTintColor(iconWindow.."SquareIcon",255,255,255)
				--if (id == 404) then
					--EnhancePack.CounterTime = 0
			--	end
			end
		end
	end
end

function HotbarSystem.RequestTargetInfo(windowName, hotbarId, itemIndex, subIndex)
	HotbarSystem.CurRequestInfoItem =
	{
		windowName = windowName,
		hotbarId = hotbarId,
		itemIndex = itemIndex,				
		subIndex = subIndex,
	}

	RequestTargetInfo()
	
	WindowClearAnchors("RequestTargetIdInfo")
	WindowAddAnchor("RequestTargetIdInfo", "topright", windowName, "bottomleft", 0, -6)
	WindowSetShowing("RequestTargetIdInfo", true)
	WindowRegisterEventHandler("RequestTargetIdInfo", SystemData.Events.TARGET_SEND_ID_CLIENT, "HotbarSystem.RequestTargetInfoReceived")
end

function HotbarSystem.RequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
	
	if (objectId ~= 0 and HotbarSystem.CurRequestInfoItem ~= nil) then
		UserActionSetTargetId(HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex, objectId)
		UserActionSetTargetType(HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex, SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID)
		HotbarSystem.UpdateTargetTypeIndicator(HotbarSystem.CurRequestInfoItem.windowName,HotbarSystem.CurRequestInfoItem.hotbarId,HotbarSystem.CurRequestInfoItem.itemIndex,HotbarSystem.CurRequestInfoItem.subIndex)
	end
	
	WindowSetShowing("RequestTargetIdInfo", false)
	WindowUnregisterEventHandler("RequestTargetIdInfo", SystemData.Events.TARGET_SEND_ID_CLIENT)
end

function HotbarSystem.ReplaceKey(oldHotbarId, oldItemIndex, oldType, hotbarId, itemIndex, type, key, shortKey)
	--Debug.Print(key)
	--Debug.Print(shortKey)
	--Debug.Print("----")
	HotbarSystem.UnbindKey(oldHotbarId, oldItemIndex, oldType)
	HotbarSystem.BindKey(hotbarId, itemIndex, type, key, shortKey)
	
	BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )
end

function HotbarSystem.UpdateBinding(element,key, key2)
	if (key ~= nil) then
		local patt = WStringToString(key)
		local texto = string.find(patt , "OEM_102")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "OEM_102", "<")
		end
		
		texto = string.find(patt , "Delete")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Delete", "Del")
		end
		
		texto = string.find(patt , "Num Pad")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Num Pad:", "NP")
		end
		
		texto = string.find(patt , "Space")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Space", "Spc")
		end
		
		texto = string.find(patt , "BackSpc")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "BackSpc", "Back")
		end
		
		texto = string.find(patt , "Insert")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Insert", "Ins")
		end
		
		texto = string.find(patt , "Page Up")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Page Up", "PGUp")
		end
		
		texto = string.find(patt , "Page Dn")
		if ( texto ~= nil ) then
			patt = string.gsub(patt, "Page Dn", "PGDn")
		end

		
		if (string.len(patt) > 4) then
			patt = string.sub(patt, 1, 4)
		end
		key = StringToWString(patt)
	end
	

	-- PLAIN
	LabelSetTextColor(element.."Hotkey",HotbarSystem.Plain.r,HotbarSystem.Plain.g,HotbarSystem.Plain.b)
	
	local patt = WStringToString(key2)
	-- CTRL
	local texto = string.find(patt , "Control")
	if ( texto ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.Control.r,HotbarSystem.Control.g,HotbarSystem.Control.b)
	end
	
	-- ALT
	texto = string.find(patt , "Alt")
	if ( texto ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.Alt.r,HotbarSystem.Alt.g,HotbarSystem.Alt.b)
	end
	
	-- SHIFT
	texto = string.find(patt , "Shift")
	if ( texto ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.Shift.r,HotbarSystem.Shift.g,HotbarSystem.Shift.b)
	end
	
	-- CTRL + SHIFT
	texto = string.find(patt , "Shift")
	local texto2 = string.find(patt , "Control")
	if ( texto ~= nil and texto2 ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.ControlShift.r,HotbarSystem.ControlShift.g,HotbarSystem.ControlShift.b)
	end
	
	-- CTRL + ALT
	texto = string.find(patt , "Alt")
	texto2 = string.find(patt , "Control")
	if ( texto ~= nil and texto2 ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.ControlAlt.r,HotbarSystem.ControlAlt.g,HotbarSystem.ControlAlt.b)
	end
	
	-- ALT + SHIFT
	texto = string.find(patt , "Alt")
	texto2 = string.find(patt , "Shift")
	if ( texto ~= nil and texto2 ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.AltShift.r,HotbarSystem.AltShift.g,HotbarSystem.AltShift.b)
	end
	
	-- CTRL + ALT + SHIFT
	texto = string.find(patt , "Alt")
	texto2 = string.find(patt , "Shift")
	local texto3 = string.find(patt , "Control")
	if ( texto ~= nil and texto2 ~= nil and texto3 ~= nil ) then
		LabelSetTextColor(element.."Hotkey",HotbarSystem.ControlAltShift.r,HotbarSystem.ControlAltShift.g,HotbarSystem.ControlAltShift.b)
	end
	
	LabelSetText(element.."Hotkey", key)
	WindowClearAnchors(element.."Hotkey")
	WindowAddAnchor(element.."Hotkey", "topleft", element, "topleft", -5, 0)	
	LabelSetFont(element.."Hotkey", "font_verdana_bold_shadow_small", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	
	if( key ~= L"" ) then
		WindowSetShowing(element.."HotkeyBackground",true)
	else
		WindowSetShowing(element.."HotkeyBackground",false)
	end
	
	local fnd = string.find(element , "Button")
	local hotbarId = tonumber(string.sub(element,7, fnd - 1))
	local itemIndex = tonumber(string.sub(element, fnd + 6 ))
	
	if not HotbarSystem.BindingsBackup then
		HotbarSystem.BindingsBackup = {}
	end
    if not HotbarSystem.BindingsBackup[hotbarId] then
		HotbarSystem.BindingsBackup[hotbarId] = {}
	end
	HotbarSystem.BindingsBackup[hotbarId][itemIndex] = key2
end

function HotbarSystem.BindKey(hotbarId, itemIndex, type, key, shortKey)
	if(type == SystemData.BindType.BINDTYPE_SETTINGS) then
		SettingsWindow.Keybindings[itemIndex].newValue = key
		SettingsWindow.UpdateKeyBindings()
		
	elseif(type == SystemData.BindType.BINDTYPE_HOTBAR) then
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = key
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = shortKey
		
		HotbarUpdateBinding(hotbarId, itemIndex, key)
		local element = "Hotbar"..hotbarId.."Button"..itemIndex
		HotbarSystem.UpdateBinding(element,shortKey, key)
		
	elseif(type == SystemData.BindType.BINDTYPE_MACRO) then
		UserActionMacroUpdateBinding(hotbarId, itemIndex, key)
		local MacroLabel = "MacroScrollWindowScrollChildItem"..itemIndex.."Binding"
		if( key ~= L"" ) then
			local texto = wstring.find(key , L"+")
			if ( texto ~= nil ) then
				LabelSetText(MacroLabel, key)
			else
				LabelSetText(MacroLabel, shortKey)
			end
		else
			LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
		end
	end
end

function HotbarSystem.UnbindKey(hotbarId, itemIndex, type)
	if( type == SystemData.BindType.BINDTYPE_SETTINGS ) then
		SettingsWindow.Keybindings[itemIndex].newValue = L""
		SettingsWindow.UpdateKeyBindings()
		
	elseif( type == SystemData.BindType.BINDTYPE_HOTBAR ) then
		Debug.Print("Hotbar: " .. hotbarId .. " ID: " .. itemIndex)
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = L""
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = L""
		
		HotbarUpdateBinding(hotbarId, itemIndex, L"")
		local element = "Hotbar"..hotbarId.."Button"..itemIndex
		HotbarSystem.UpdateBinding(element,L"", SystemData.Hotbar[hotbarId].Bindings[itemIndex])
		
	elseif( type == SystemData.BindType.BINDTYPE_MACRO ) then
		UserActionMacroUpdateBinding(hotbarId, itemIndex, L"")
		local MacroLabel = "MacroScrollWindowScrollChildItem"..itemIndex.."Binding"
		LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
	end
end

function HotbarSystem.GetKeyName(hotbarId, itemIndex, type)
	if( type == SystemData.BindType.BINDTYPE_SETTINGS ) then
		return GetStringFromTid( SettingsWindow.Keybindings[itemIndex].tid )
	elseif( type == SystemData.BindType.BINDTYPE_HOTBAR ) then
		return GetStringFromTid( Hotbar.TID_HOTBAR )..L" "..hotbarId..L"  "..GetStringFromTid( Hotbar.TID_SLOT )..L" "..itemIndex
	elseif( type == SystemData.BindType.BINDTYPE_MACRO ) then
		return GetStringFromTid( MacroWindow.TID_MACROCOLON )..L"  "..UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, itemIndex)
	end
end