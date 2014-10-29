----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TargetWindow = {}
TargetWindow.Locked = false

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
TargetWindow.CurrentTarget = nil

TargetWindow.Delta = 0
TargetWindow.DeltaC = 0


TargetWindow.TargetId = 0
TargetWindow.HasTarget = false
TargetWindow.TargetType = 0
TargetWindow.MobileType = 2
TargetWindow.ObjectType = 3
TargetWindow.CorpseType = 4

TargetWindow.RegisterTime = {}

TargetWindow.PreviousTargets = {}

TargetWindow.Buttons = {}

TargetWindow.PortTexture = nil

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function TargetWindow.Initialize()
--	Debug.PrintToDebugConsole(L"Initialize TARGET WINDOW")
    StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
	StatusBarSetMaximumValue( "TargetWindowHealthBar", 100 )

	RegisterWindowData(WindowData.CurrentTarget.Type,0)
	WindowRegisterEventHandler( "TargetWindow", WindowData.CurrentTarget.Event, "TargetWindow.UpdateTarget")
	WindowRegisterEventHandler( "TargetWindow", WindowData.MobileStatus.Event, "TargetWindow.MobileStatusUpdate")
	WindowRegisterEventHandler( "TargetWindow", WindowData.MobileName.Event, "TargetWindow.HandleUpdateNameEvent")
	WindowRegisterEventHandler( "TargetWindow", WindowData.ObjectInfo.Event, "TargetWindow.UpdateObjectInfo")
	WindowRegisterEventHandler( "TargetWindow", WindowData.HealthBarColor.Event, "TargetWindow.HandleTintHealthBarEvent")
	
	SnapUtils.SnappableWindows["TargetWindow"] = true
	WindowUtils.RestoreWindowPosition("TargetWindow")
	
	ButtonSetTexture("TargetWindowLock", InterfaceCore.ButtonStates.STATE_NORMAL, UI.Lock.texture, UI.Lock.STATE_NORMAL.x, UI.Lock.STATE_NORMAL.y)
	ButtonSetTexture("TargetWindowLock", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_NORMAL_HIGHLITE.x, UI.Lock.STATE_NORMAL_HIGHLITE.y)
	ButtonSetTexture("TargetWindowLock", InterfaceCore.ButtonStates.STATE_PRESSED, UI.Lock.texture, UI.Lock.STATE_PRESSED.x, UI.Lock.STATE_PRESSED.y)
	ButtonSetTexture("TargetWindowLock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_PRESSED_HIGHLITE.x, UI.Lock.STATE_PRESSED_HIGHLITE.y)
	
	if WindowData.CurrentTarget.TargetId ~= 0 then
		TargetWindow.Context = "done"
		BroadcastEvent(WindowData.CurrentTarget.Event) 
		TargetWindow.Context = nil
	end
end

function TargetWindow.Shutdown()

	TargetWindow.ClearPreviousTarget()
	SnapUtils.SnappableWindows["TargetWindow"] = nil
	UnregisterWindowData(WindowData.CurrentTarget.Type,0)
	
	WindowUtils.SaveWindowPosition("TargetWindow")
end

function TargetWindow.ClearPreviousTarget()
	for i = 1, #TargetWindow.Buttons do
		if DoesWindowNameExist(TargetWindow.Buttons[i]) then
			DestroyWindow(TargetWindow.Buttons[i])
		end
	end
	TargetWindow.Buttons  = {}
	TargetWindow.Context = nil
	if( TargetWindow.HasTarget == true ) then
		
			WindowSetShowing("TargetWindow",false)
			if(TargetWindow.TargetType == TargetWindow.MobileType) then
				UnregisterWindowData(WindowData.MobileName.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.MobileStatus.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
				TargetWindow.RegisterTime[TargetWindow.TargetId] = nil
				local max = table.getn(TargetWindow.PreviousTargets)
				if (TargetWindow.PreviousTargets[max] ~= TargetWindow.TargetId) then
					table.insert(TargetWindow.PreviousTargets,TargetWindow.TargetId) 
				end
			elseif(TargetWindow.TargetType == TargetWindow.ObjectType or
			    TargetWindow.TargetType == TargetWindow.CorpseType) then
				UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)			
			end
			LabelSetText("TargetWindowName", L"")
			StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
			WindowSetShowing("TargetWindowPortrait", false)
			WindowSetShowing("TargetWindowDisabled", false)
			WindowSetShowing("TargetWindowObject", false)
			TargetWindow.TargetType = 0
			TargetWindow.TargetId = nil
	end
	MobileHealthBar.HandleBackGround()
end	

function TargetWindow.OnMoveStart()
	if ( not TargetWindow.Locked ) then
		WindowSetMoving("TargetWindow", true)
		SnapUtils.StartWindowSnap("TargetWindow")
	end
end

function TargetWindow.Lock()
	TargetWindow.Locked = not TargetWindow.Locked 
	CustomSettings.SaveBoolean( "TargetWindowLocked", TargetWindow.Locked  )
end

function TargetWindow.LockTooltip()
	if ( TargetWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,UI.GetCliloc(SystemData.Settings.Language.type, 327))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 328))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end


function TargetWindow.UnregisterPreviousTargetData()

	--If previous target was a mobile unregister data with the previous target
	if( TargetWindow.HasTarget == true) then
		if(TargetWindow.TargetType == TargetWindow.MobileType) then
			UnregisterWindowData(WindowData.MobileName.Type,TargetWindow.TargetId)
			UnregisterWindowData(WindowData.MobileStatus.Type,TargetWindow.TargetId)	
			UnregisterWindowData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
			TargetWindow.RegisterTime[TargetWindow.TargetId] = nil
		elseif(TargetWindow.TargetType == TargetWindow.ObjectType or
			   TargetWindow.TargetType == TargetWindow.CorpseType) then
			UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)	

		end
	end
end

function TargetWindow.UpdateMobile()
	
	if( TargetWindow.HasTarget == false or
	(TargetWindow.HasTarget == true and WindowData.CurrentTarget.TargetId ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
		
		if (IsHealthBarEnabled(WindowData.CurrentTarget.TargetId) and IsMobile(WindowData.CurrentTarget.TargetId)) then
			--Update the local targetType as a mobile type
			TargetWindow.TargetType = TargetWindow.MobileType
			WindowSetShowing("TargetWindow",true)
			
			RegisterWindowData(WindowData.MobileName.Type, WindowData.CurrentTarget.TargetId)
			RegisterWindowData(WindowData.MobileStatus.Type,WindowData.CurrentTarget.TargetId)
			RegisterWindowData(WindowData.HealthBarColor.Type,WindowData.CurrentTarget.TargetId)

			TargetWindow.UpdateStatus(WindowData.CurrentTarget.TargetId)	
			TargetWindow.UpdateName(WindowData.CurrentTarget.TargetId)	
			TargetWindow.TargetId = WindowData.CurrentTarget.TargetId
			TargetWindow.TintHealthBar(WindowData.CurrentTarget.TargetId)
			
			TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] = EnhancePack.TimeSinceLogin
						
			
			
			if( WindowData.CurrentTarget.HasPaperdoll ) then
				
				
				local textureData = SystemData.PaperdollTexture[WindowData.CurrentTarget.TargetId]	
				if( textureData ~= nil) then
					local x, y, scale
					if textureData.IsLegacy == 1 then
						x, y = -88, 14
						scale = 0.8
					else
						x, y = -11, -191
						scale = 0.432
					end
					
					CircleImageSetTexture("TargetWindowPortrait", "paperdoll_texture"..WindowData.CurrentTarget.TargetId, x - textureData.xOffset, y - textureData.yOffset)
					CircleImageSetTextureScale("TargetWindowPortrait", scale)
				end			
			else
			
				if (not TargetWindow.PortTexture) then
					CircleImageSetTextureScale("TargetWindowPortrait",0.843)
					CircleImageSetTexture("TargetWindowPortrait","target_portrait",32,32);
					UpdatePortrait("target_portrait",true,WindowData.CurrentTarget.TargetId);
				else
					CircleImageSetTextureScale("TargetWindowPortrait",0.843)
					CircleImageSetTexture("TargetWindowPortrait",TargetWindow.PortTexture,32,32);
				end
			end
			
			--WindowSetShowing("TargetWindowHealthBarImage", true)
			WindowSetShowing("TargetWindowPortrait", true)
			WindowSetShowing("TargetWindowObject", false)
		end
	end
	local max = table.getn(TargetWindow.PreviousTargets)
	if (TargetWindow.PreviousTargets[max] ~= TargetWindow.TargetId) then
		table.insert(TargetWindow.PreviousTargets,TargetWindow.TargetId) 
	end
	if (EnhancePack) then
		EnhancePack.UpdateTargetDetails()
	end
	if not TargetWindow.Context and WindowGetShowing("TargetWindow") then
		TargetWindow.Context = true
		RequestContextMenu(WindowData.CurrentTarget.TargetId)
	end
end

function TargetWindow.UpdateButtons()
	if not WindowGetShowing("TargetWindow") and not TargetWindow.Context then
		return
	end
	for i = 1, #TargetWindow.Buttons do
		if DoesWindowNameExist(TargetWindow.Buttons[i]) then
			DestroyWindow(TargetWindow.Buttons[i])
		end
	end
	TargetWindow.Buttons  = {}
	TargetWindow.Context = true
	RequestContextMenu(WindowData.CurrentTarget.TargetId)
end

function TargetWindow.UpdateObject()
	if( (TargetWindow.HasTarget == false) or
		(TargetWindow.HasTarget == true and WindowData.CurrentTarget.TargetId ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
		
		--Update the local targetType to Object type
		TargetWindow.TargetType = TargetWindow.ObjectType
		WindowSetShowing("TargetWindow",true)
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId
		
		UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)
		RegisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)
		local itemData = WindowData.ObjectInfo[TargetWindow.TargetId]
		if not itemData then
			itemData = {name = GetObjectProperties( TargetWindow.TargetId, 1 )}
		end
		StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
		LabelSetText("TargetWindowName", itemData.name)
		
		
		NameColor.UpdateLabelNameColor("TargetWindowName", NameColor.Notoriety.NONE)

        EquipmentData.UpdateItemIcon("TargetWindowObject", itemData)

		--WindowSetShowing("TargetWindowHealthBarImage", false)
		WindowSetShowing("TargetWindowObject", true)
		WindowSetShowing("TargetWindowDisabled", false)
		UpdatePortrait("target_portrait",false,0);
		WindowSetShowing("TargetWindowPortrait", false)
	end
	if (EnhancePack) then
		EnhancePack.UpdateTargetDetails()
	end
end

--Corpse will show the portrait of the mobile, but use the item properites for the name
function TargetWindow.UpdateCorpse()
	if( (TargetWindow.HasTarget == false) or
		(TargetWindow.HasTarget == true and WindowData.CurrentTarget.TargetId ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
		WindowSetShowing("TargetWindowDisabled",false)
		
		--Update the local targetType to Object type
		TargetWindow.TargetType = TargetWindow.CorpseType
		WindowSetShowing("TargetWindow",true)
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId
		
		RegisterWindowData(WindowData.ObjectInfo.Type,WindowData.CurrentTarget.TargetId)
		local itemData = WindowData.ObjectInfo[WindowData.CurrentTarget.TargetId]
		if not itemData then
			UnregisterWindowData(WindowData.ObjectInfo.Type,WindowData.CurrentTarget.TargetId)
			RegisterWindowData(WindowData.ObjectInfo.Type,WindowData.CurrentTarget.TargetId)
		end
		
		StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
		LabelSetText("TargetWindowName", itemData.name)
		
		NameColor.UpdateLabelNameColor("TargetWindowName", NameColor.Notoriety.NONE)
		
		CircleImageSetTextureScale("TargetWindowPortrait",0.843)
		CircleImageSetTexture("TargetWindowPortrait","target_portrait",32,32);		
		UpdatePortrait("target_portrait",true,WindowData.CurrentTarget.TargetId);
		--WindowSetShowing("TargetWindowHealthBarImage", false)
		WindowSetShowing("TargetWindowPortrait", true)
		WindowSetShowing("TargetWindowObject", false)
	end
	if (EnhancePack) then
		EnhancePack.UpdateTargetDetails()
	end
end

function TargetWindow.UpdateTarget()
	LabelSetText("TargetWindowHits", L"")
	--Check to see if the target is a mobile or object first, if it is a mobile then show the portrait of the mobile
	--otherwise show the object texture
	local show = WindowGetShowing("TargetWindow")
	if (EnhancePack.wasWar and show and WindowData.CurrentTarget.TargetId ~= WindowData.PlayerStatus.PlayerId) then
		if	(not MobilesOnScreen.IsPet(WindowData.CurrentTarget.TargetId) and EnhancePack.ToggleWarOnPet) or 
			(not IsPartyMember( WindowData.CurrentTarget.TargetId ) and EnhancePack.ToggleWarOnParty) or 
			((not WindowData.MobileName[WindowData.CurrentTarget.TargetId] or ObjectHandleWindow.Notoriety.FRIEND ~= WindowData.MobileName[WindowData.CurrentTarget.TargetId].Notoriety+1 or not FriendList.IsFriend(WindowData.CurrentTarget.TargetId)) and EnhancePack.ToggleWarOnGuild ) then
		
			EnhancePack.wasWar = false
			UserActionToggleWarMode()
		end
	end
	for i = 1, #TargetWindow.Buttons do
		if DoesWindowNameExist(TargetWindow.Buttons[i]) then
			DestroyWindow(TargetWindow.Buttons[i])
		end
	end
	TargetWindow.Buttons  = {}
	
	if(WindowData.CurrentTarget.TargetType == TargetWindow.MobileType) then
		TargetWindow.UpdateMobile()
	else
		if(WindowData.CurrentTarget.TargetType == TargetWindow.ObjectType) then
			TargetWindow.UpdateObject()
		else
			if(WindowData.CurrentTarget.TargetType == TargetWindow.CorpseType) then
				TargetWindow.UpdateCorpse()
			else
				TargetWindow.ClearPreviousTarget()
			end
		end
	end 
	-- End of registering for the mobileType

	TargetWindow.HasTarget = WindowData.CurrentTarget.HasTarget	
	MobileHealthBar.HandleBackGround(WindowData.CurrentTarget.TargetId)
end

function TargetWindow.ForceUpdate(timePassed)

	if TargetWindow.TargetId ~= 0 and WindowGetShowing("TargetWindow") then
		TargetWindow.Delta = TargetWindow.Delta + timePassed
		TargetWindow.DeltaC = TargetWindow.DeltaC + timePassed
		if TargetWindow.DeltaC > 1 then
			TargetWindow.DeltaC = 0
			if TargetWindow.Context == true then
				RequestContextMenu(WindowData.CurrentTarget.TargetId)
			end
		end
		if TargetWindow.Delta > 0.2 then
			local itemData = WindowData.ObjectInfo[TargetWindow.TargetId]
			if not itemData and not IsMobile(TargetWindow.TargetId) then
				UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)
				RegisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)
			end
			itemData = WindowData.MobileStatus[TargetWindow.TargetId]
			if not itemData and IsMobile(TargetWindow.TargetId) then
				UnregisterWindowData(WindowData.MobileStatus.Type, TargetWindow.TargetId)
				RegisterWindowData(WindowData.MobileStatus.Type, TargetWindow.TargetId)
			end
			TargetWindow.Delta = 0
		end
	else
		TargetWindow.Context = nil
	end
	

	if not (DoesPlayerHaveItem(TargetWindow.TargetId) or TargetWindow.TargetId == WindowData.PlayerStatus.PlayerId) then
		WindowSetFontAlpha("TargetWindowDistance", 0.7)
		LabelSetText("TargetWindowDistance", UI.GetCliloc(SystemData.Settings.Language.type, 5026) .. towstring(GetDistanceFromPlayer(TargetWindow.TargetId)))
	else
		WindowSetFontAlpha("TargetWindowDistance", 0)
	end
end

function TargetWindow.MobileStatusUpdate()
    TargetWindow.UpdateStatus(WindowData.UpdateInstanceId)
end

function TargetWindow.UpdateStatus(targetId)	
	if( targetId == WindowData.CurrentTarget.TargetId) then
		if not WindowData.MobileStatus[WindowData.CurrentTarget.TargetId] then
			UnregisterWindowData(WindowData.MobileStatus.Type, WindowData.CurrentTarget.TargetId)
			RegisterWindowData(WindowData.MobileStatus.Type, WindowData.CurrentTarget.TargetId)
		end
		StatusBarSetCurrentValue( "TargetWindowHealthBar", WindowData.MobileStatus[WindowData.CurrentTarget.TargetId].CurrentHealth )	
		StatusBarSetMaximumValue( "TargetWindowHealthBar", WindowData.MobileStatus[WindowData.CurrentTarget.TargetId].MaxHealth )			
		if( WindowData.MobileStatus[WindowData.CurrentTarget.TargetId].IsDead) then
			LabelSetText("TargetWindowHits", StringToWString("Health: 0%"))
		else
			HotbarSystem.CurrentTargLife = 100
			if(TargetWindow.TargetType == TargetWindow.MobileType and MobileHealthBar.IsReallyEnabled(targetId) and IsMobile(targetId)) then
				
				local data = WindowData.MobileName[targetId]
				if not data then
					UnregisterWindowData(WindowData.MobileName.Type, targetId)
					RegisterWindowData(WindowData.MobileName.Type, targetId)
				end
				if ( data ~= nil ) then
					if (data.Notoriety+1 < 8) then
						local curr = WindowData.MobileStatus[targetId].CurrentHealth 
						local max = WindowData.MobileStatus[targetId].MaxHealth 
						local perc = (curr/max)*100
						if (tostring(perc) == "-1.#IND") then
							perc = 0
							if EnhancePack.TimeSinceLogin >= TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] + 0.2 then
								UnregisterWindowData(WindowData.MobileStatus.Type, WindowData.CurrentTarget.TargetId)
								TargetWindow.RegisterTime[WindowData.CurrentTarget.TargetId] = EnhancePack.TimeSinceLogin
								return
							end
						end
						HotbarSystem.CurrentTargLife = perc
						perc = math.floor(perc)
						local gb = math.floor(2.55 * perc)
						LabelSetTextColor("TargetWindowHits", 255, gb, gb)
						LabelSetText("TargetWindowHits", StringToWString("Health: " .. tostring(perc) .. "%"))
					else
						LabelSetText("TargetWindowHits", UI.GetCliloc(SystemData.Settings.Language.type, 475))
						
						LabelSetTextColor("TargetWindowHits", 255, 255, 0)
					end	
				end
			end
            WindowSetShowing("TargetWindowDisabled",false)
		end
	end
end

function TargetWindow.HandleUpdateNameEvent()
    TargetWindow.UpdateName(WindowData.UpdateInstanceId)
end

function TargetWindow.UpdateName(targetId)	
	
	
		if( targetId == WindowData.CurrentTarget.TargetId and WindowData.MobileName[WindowData.CurrentTarget.TargetId] ~= nil ) then
			OverheadText.ChangelingNameCheck(WindowData.MobileName[WindowData.CurrentTarget.TargetId], "TargetWindow", WindowData.CurrentTarget.TargetId)
			
			local noto = WindowData.MobileName[WindowData.CurrentTarget.TargetId].Notoriety+1
			if (targetId == EnhancePack.CurrentHonor) then
				noto = {r=163, g=73, b=164}
				LabelSetTextColor("TargetWindowName", noto.r, noto.g, noto.b)
			else
				NameColor.UpdateLabelNameColor("TargetWindowName", WindowData.MobileName[WindowData.CurrentTarget.TargetId].Notoriety+1)
			end
			
		end
		if (EnhancePack) then
			EnhancePack.UpdateTargetDetails()
		end

end

function TargetWindow.HandleTintHealthBarEvent()
    TargetWindow.TintHealthBar(WindowData.UpdateInstanceId)
end

function TargetWindow.TintHealthBar(mobileId)
	if( mobileId == WindowData.CurrentTarget.TargetId ) then
		local windowTintName = "TargetWindowHealthBar"
		--Colors the health bar to the correct color
		HealthBarColor.UpdateHealthBarColor(windowTintName, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end

function TargetWindow.UpdateObjectInfo()
	if( WindowData.UpdateInstanceId == WindowData.CurrentTarget.TargetId ) then
		itemData = WindowData.ObjectInfo[WindowData.CurrentTarget.TargetId]
		LabelSetText("TargetWindowName", itemData.name)
	end	
	
end

--When players double clice on the target window, send a request object use packet
function TargetWindow.OnItemDblClicked()
	
	local id = TargetWindow.TargetId
	local data = WindowData.MobileName[id]
	if not data then
		RegisterWindowData(WindowData.MobileName.Type, id)
	end
	if ( data ~= nil ) then
		local prop = GetObjectProperties( id, 2 )
		if prop == "" or prop == L"" then
			prop = nil
		end
		local tid = wstring.gsub(GetStringFromTid(1062449), L"~1_NAME~", L"")  -- : Shop Name: ~1_NAME~
		local qg = GetStringFromTid(1072269) -- : Quest Giver
		local cleanUp = GetStringFromTid(1151317)
		local cleanName = wstring.trim(wstring.lower(WindowData.MobileName[id].MobName)) 
		if (prop and (wstring.find(wstring.lower(prop), wstring.lower(tid)) or prop == qg)) or cleanName == L"a mysterious wisp" or prop == cleanUp  then
			UserActionUseItem(id,false)
		else
			local name = WStringToString(WindowData.MobileName[id].MobName)
			if (data.Notoriety+1 == 8 ) then
				ObjectHandleWindow.Buy = id
				EnhancePack.PlayerContextItemRequest = true
				local banker = string.find(name, "The Banker") or string.find(name, "The Minter") 
				if banker then
					ContextMenu.PlayerRequest = 120
				else
					ContextMenu.PlayerRequest = 110
				end
				TargetWindow.Context = nil
				RequestContextMenu(id)
			else
				UserActionUseItem(id,false)
			end
		end
	else
		UserActionUseItem(id,false)
	end
	
	
end

function TargetWindow.OnRClick()
	TargetWindow.Context = nil
	RequestContextMenu(TargetWindow.TargetId)
end

function TargetWindow.OnLClick()
	WindowSetMoving("TargetWindow", false)
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.CurrentTarget.TargetId)
	else
		--Let the targeting manager handle single left click on the target
		EnhancePack.HonorMobile(WindowData.CurrentTarget.TargetId)
		HandleSingleLeftClkTarget(WindowData.CurrentTarget.TargetId)
	end
end
TargetWindow.mouseOverId = 0
function TargetWindow.OnMouseOver()
	TargetWindow.mouseOverId = WindowData.CurrentTarget.TargetId
	local itemData =
	{
		windowName = "TargetWindow",
		itemId = WindowData.CurrentTarget.TargetId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)	
end

function TargetWindow.OnMouseOverEnd()
	TargetWindow.mouseOverId = 0
	ItemProperties.ClearMouseOverItem()
end

function TargetWindow.ButtonsUse()
	local wind = string.gsub(SystemData.ActiveWindow.name, "Label", "")
	wind = string.gsub(wind, "Icon", "")
	if ButtonGetDisabledFlag(wind) then
		return
	end
	EnhancePack.PlayerContextItemRequest = true
	TargetWindow.Context = nil
	ContextMenu.PlayerRequest = WindowGetId(wind)
	RequestContextMenu(TargetWindow.TargetId)
end