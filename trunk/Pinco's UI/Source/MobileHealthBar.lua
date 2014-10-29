----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MobileHealthBar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MobileHealthBar.hasWindow = {}
MobileHealthBar.RegisterTime = {}
MobileHealthBar.ObjecHasWindow = {}
MobileHealthBar.CreateTime = {}
MobileHealthBar.CrabNum = {}
MobileHealthBar.CheckStatus = {}
MobileHealthBar.windowDisabled = {}
MobileHealthBar.mouseOverId = 0
MobileHealthBar.delta = 0
MobileHealthBar.CloseStyle = false
MobileHealthBar.PetCloseStyle = false

MobileHealthBar.Changelings = {}
MobileHealthBar.Irks = {}
MobileHealthBar.Guiles = {}
MobileHealthBar.Spites = {}
MobileHealthBar.Travestys = {}

MobileHealthBar.Handled = {}

MobileHealthBar.Forced = nil

MobileHealthBar.ExpandH = 25

MobileHealthBar.SummonTimer = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MobileHealthBar.CountMobileStatusData()
	local a = 0
	for key, value in pairs(WindowData.MobileStatus) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function MobileHealthBar.CreateHealthBar(mobileId)
    local windowName = "MobileHealthBar_"..mobileId

	-- Create and register if doesn't exist
	if( DoesWindowNameExist(windowName) == false ) then
		CreateWindowFromTemplate(windowName, "MobileHealthBar", "Root")
		
		WindowSetId(windowName, mobileId)
		WindowSetId(windowName.."CloseButton", mobileId)
		--WindowSetId(windowName.."Extract", mobileId)
		
		MobileHealthBar.RegisterHealthBar(windowName)
		
		if (IsMobile(mobileId)) then
			LabelSetText( windowName.."HealthBarLabel", L"H:" )
			
		end
		WindowSetScale(windowName, 0.8)
		Interface.DestroyWindowOnClose[windowName] = true
	end
	
	
	--WindowSetShowing(windowName .. "RedButton", false)
	if (IsMobile(mobileId)) then
		
		--WindowSetShowing(windowName .. "GreenButton", false)
		MobileHealthBar.UpdateStatus(mobileId)
		MobileHealthBar.UpdateName(mobileId)
		MobileHealthBar.UpdateHealthBarColor(mobileId)
		MobileHealthBar.UpdateHealthBarState(mobileId)	
	end
	MobileHealthBar.HandleAnchorWindow(windowName)
	if (WindowGetShowing(windowName) )then
		WindowAssignFocus(windowName, true)
	end

			
end
function MobileHealthBar.HandleBackGround()
	for mobileId, value in pairs(MobileHealthBar.hasWindow) do
		local windowName = "MobileHealthBar_"..mobileId .. "Frame"
		local bar = "MobileHealthBar_"..mobileId 
		
		if( DoesWindowNameExist(windowName) ) then
			MobileHealthBar.UpdateStatus(mobileId)
			if( TargetWindow.HasTarget) then
				if (TargetWindow.TargetId == mobileId) then
					if ( not DoesWindowNameExist(bar .. "GlowingEffect")) then
						CreateWindowFromTemplate(bar .. "GlowingEffect", "MobHBHighlightEffect", bar)
						WindowClearAnchors(bar .. "GlowingEffect")
						WindowSetParent(bar .. "GlowingEffect", bar)
						WindowAddAnchor(bar .. "GlowingEffect", "center", bar, "center", 0, 0)
						WindowSetLayer(bar .. "GlowingEffect",Window.Layers.BACKGROUND)
						WindowSetAlpha(bar .. "GlowingEffect", 0.6)
						local sc = WindowGetScale(bar)
						WindowSetScale(bar .. "GlowingEffect", sc)
						if (not IsMobile(mobileId)) then
							WindowClearAnchors(bar .. "GlowingEffect")
							WindowAddAnchor(bar .. "GlowingEffect", "topright", bar, "topright", 0, 0)
							WindowAddAnchor(bar .. "GlowingEffect", "bottomleft", bar, "bottomleft", 0, 0)
						end
						local data = WindowData.MobileName[mobileId]
						if (data) then
							local noto = NameColor.TextColors[data.Notoriety+1]
							if (mobileId == EnhancePack.CurrentHonor) then
								noto = {r=163, g=73, b=164}
							end
							WindowSetTintColor(bar .. "GlowingEffect", noto.r,noto.g,noto.b)
						end
						AnimatedImageStartAnimation( bar .. "GlowingEffect", 1, true, false, 0.0 ) 
						WindowSetShowing(bar .. "Background", false)
					end
					local data = WindowData.MobileName[mobileId]
					if (data) then
						local noto = NameColor.TextColors[data.Notoriety+1]
						if (mobileId == EnhancePack.CurrentHonor) then
							noto = {r=163, g=73, b=164}
						end
						WindowSetTintColor(windowName, noto.r,noto.g,noto.b)
					end
				else
					WindowSetShowing(bar .. "Background", true)
					if ( DoesWindowNameExist(bar .. "GlowingEffect")) then
						AnimatedImageStopAnimation( bar .. "GlowingEffect")  
						DestroyWindow( bar .. "GlowingEffect" )
					end
					local data = WindowData.MobileName[mobileId]
					if (data) then
						local noto = NameColor.TextColors[data.Notoriety+1]
						if (mobileId == EnhancePack.CurrentHonor) then
							noto = {r=163, g=73, b=164}
						end
						WindowSetTintColor(windowName, noto.r,noto.g,noto.b)
					end
				end
			else
				local data = WindowData.MobileName[mobileId]
				if (data) then
					local noto = NameColor.TextColors[data.Notoriety+1]
					if (mobileId == EnhancePack.CurrentHonor) then
						noto = {r=163, g=73, b=164}
					end
					WindowSetTintColor(windowName, noto.r,noto.g,noto.b)
				end
			end
		end	
	end
end

--Sets the Window close to where the player dragged their mouse
function MobileHealthBar.HandleAnchorWindow(healthWindow)
	if (not DoesWindowNameExist(healthWindow)) then
		return
	end
	
	local mobileId = WindowGetId(healthWindow)
		
	if (MobileHealthBar and not MobileHealthBar.ObjecHasWindow[mobileId]) then
		WindowSetScale(healthWindow, SystemData.Settings.Interface.customUiScale * 0.80)

		EnhancePack.LoadScale( "MobileHealthBarSCALE" )
		local x, y = WindowGetDimensions(healthWindow)
		MobilesOnScreen.BarsY = y
		MobilesOnScreen.BarScale = WindowGetScale(healthWindow)
	end

	if (IsMobile(mobileId)) then

		if ( MobileHealthBar.Forced == false) then
			local propWindowX = 0
			local propWindowY = 0
			local scale = WindowGetScale(healthWindow)
			local scaleFactor = 1/scale
			
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
	else

		
		
		local item = WindowData.ObjectInfo[mobileId]
		if ( item ~= nil ) then
			if (not DoesWindowNameExist(healthWindow)) then
				return
			end
			local x, y = WindowGetDimensions( healthWindow )
			WindowSetDimensions(healthWindow, 190 / 2, 55)
			
			
			WindowSetScale(healthWindow, 0.5)
			--WindowClearAnchors(healthWindow .. "Name")
			--WindowForceProcessAnchors(healthWindow .. "Name")
			--WindowSetDimensions(healthWindow.. "Name", 145/2, 32)
			--LabelSetTextAlign(healthWindow .. "Name", "center")
			LabelSetTextAlign(healthWindow .. "HealthBarLabel", "center")
			WindowSetDimensions(healthWindow.. "HealthBarLabel", 155/2, 25)
			--WindowAddAnchor(healthWindow .. "Name", "topleft", healthWindow .. "HealthBar", "topleft", 20, -13)	
		
		
			MobileHealthBar.ObjecHasWindow[mobileId] = true
			local texto = string.find(WStringToString(item.name) , "Lobster Trap")
			local text2 = string.find(WStringToString(item.name) , "Empty ")
			local text3 = string.find(WStringToString(item.name) , "Full ")
			if ( texto ~= nil and text2 == nil and text3 == nil) then
				AttachWindowToWorldObject(mobileId, healthWindow)
			else
				local propWindowX = 0
				local propWindowY = 0
				local scale = WindowGetScale(healthWindow)
				local scaleFactor = 1/scale
				
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
		end
		
	end
	
	
	
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
	MobileHealthBar.RegisterTime[mobileId] = EnhancePack.TimeSinceLogin
	MobileHealthBar.windowDisabled[mobileId] = false
	if (SnapUtils.SnappableWindows[windowName] == nil) then
		SnapUtils.SnappableWindows[windowName] = true
	end
	WindowSetShowing(windowName .. "Wod", false)
end

function MobileHealthBar.UnregisterHealthBar(windowName)
	local mobileId = WindowGetId(windowName)
	
	WindowUnregisterEventHandler(windowName, WindowData.MobileStatus.Event)
	WindowUnregisterEventHandler(windowName, WindowData.MobileName.Event)
	WindowUnregisterEventHandler(windowName, WindowData.HealthBarColor.Event)
	WindowUnregisterEventHandler(windowName, SystemData.Events.ENABLE_HEALTHBAR_WINDOW)
	WindowUnregisterEventHandler(windowName, SystemData.Events.DISABLE_HEALTHBAR_WINDOW)
	
	--UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
	UnregisterWindowData(WindowData.MobileName.Type, mobileId)
	UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)

	MobileHealthBar.hasWindow[mobileId] = nil
	MobileHealthBar.windowDisabled[mobileId] = nil
	MobileHealthBar.RegisterTime[mobileId] = nil
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
	local windowName = "MobileHealthBar_"..mobileId

	if not WindowData.MobileStatus[mobileId] then
		RegisterWindowData(WindowData.MobileStatus.Type, mobileId)
	end
	if(WindowData.MobileStatus[mobileId] and MobileHealthBar.hasWindow[mobileId] == true) then -- and IsMobile(mobileId)
		--Set mobile's health status bar
		local curHealth = WindowData.MobileStatus[mobileId].CurrentHealth
		local maxHealth = WindowData.MobileStatus[mobileId].MaxHealth
		
		StatusBarSetCurrentValue( windowName.."HealthBar", curHealth )	
		StatusBarSetMaximumValue( windowName.."HealthBar", maxHealth )

			
		--WindowSetFontAlpha(windowName .. "HealthBarTimeSpan", 0.5)
		local data = WindowData.MobileName[mobileId]
		if (data) then
			if (EnhancePack.ShowCloseExtract and MobileHealthBar.Handled[mobileId] ~= nil) then
				WindowSetShowing( windowName .. "CloseButton", MobileHealthBar.Handled[mobileId])
				WindowSetShowing( windowName .. "Extract", not MobileHealthBar.Handled[mobileId])
			else
				WindowSetShowing( windowName .. "CloseButton", false)
				WindowSetShowing( windowName .. "Extract", false)
			end
		
			if (DoesWindowNameExist(windowName.."Inventory") ) then
				local backpackId = 0
				if WindowData.Paperdoll[mobileId] then
					backpackId = WindowData.Paperdoll[mobileId].backpackId
				else
					RegisterWindowData(WindowData.Paperdoll.Type, mobileId)
					if WindowData.Paperdoll[mobileId] then
						backpackId = WindowData.Paperdoll[mobileId].backpackId
					end
					UnregisterWindowData(WindowData.Paperdoll.Type, mobileId)
				end
				
				if backpackId ~= 0 then
					WindowSetShowing( windowName.."Inventory", true)
				else
					WindowSetShowing( windowName.."Inventory", false)
				end
			end
			
			
			local perc = math.floor((curHealth/maxHealth)*100)
			if (tostring(perc) == "-1.#IND") then
				perc = 0
				MobileHealthBar.CheckStatus[mobileId] = true
				if EnhancePack.TimeSinceLogin >= MobileHealthBar.RegisterTime[mobileId] + 1 then
					MobileHealthBar.RegisterTime[mobileId] = EnhancePack.TimeSinceLogin
					return
				end
			end
			local name = data.MobName
			local show = true
			if (MobilesOnScreen.IsSummon(name) and (EnhancePack.EnableIgnoreSummons or EnhancePack.LowHPPETPercDisabled)) then
				show = false
			end
				
			if ( MobilesOnScreen.IsPet(mobileId) and perc > 0 and show) then
				if (perc <=EnhancePack.LowPETHPPerc and EnhancePack.Fade <= 0) then
					EnhancePack.SendCenterScreenTexture("lowhppet")
					EnhancePack.LOWHPPetStarted = true
				elseif(perc > EnhancePack.LowPETHPPerc) then
					if (EnhancePack.LOWHPPetStarted) then
						EnhancePack.LOWHPPetStarted = false
						WindowStopAlphaAnimation("MainCenterScreenTexture")
						WindowSetAlpha("MainCenterScreenTexture", 0)
						EnhancePack.Fade = 0
					end
				end
			end
							
			LabelSetText(windowName .. "HealthBarPerc", L"0%")

			local dead =  WindowData.MobileStatus[mobileId].IsDead
			
			if (perc ~= nil and perc >= 0 and  mobileId ~= WindowData.PlayerStatus.PlayerId ) then
				MobileHealthBar.CheckStatus[mobileId] = nil
				WindowSetShowing(windowName.."HealthBarPerc",true)
				local gb = math.floor(2.55 * perc)
				LabelSetTextColor(windowName .. "HealthBarPerc", 255, gb, gb)
				LabelSetText(windowName .. "HealthBarPerc", perc .. L"%")
				if (WindowData.SkillsCSV) then
					local serverId = WindowData.SkillsCSV[EnhancePack.SpellweavingID].ServerId
					local skillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue / 10
					
					if (skillLevel >= 80 and EnhancePack.HealthBarWod and data.Notoriety+1 ~= 3 and not MobilesOnScreen.IsPet(mobileId) and not dead) then
			
						local circleLimit = EnhancePack.ArcaneFocusLevel * 5
						
						if (circleLimit <= 0) then
							circleLimit = 0
						end
						
						if (perc <= circleLimit) then 
							WindowSetShowing(windowName .. "Wod", true)			
						else
							WindowSetShowing(windowName .. "Wod", false)				
						end

					end
				end
			elseif ((data == nil or tostring(perc) == "-1.#IND") and not MobileHealthBar.Handled[mobileId] and  mobileId ~= WindowData.PlayerStatus.PlayerId ) then
				MobileHealthBar.CheckStatus[mobileId] = true
				
			else
				WindowSetShowing(windowName .. "HealthBarPerc", false)		
			end
		end
	end
end


function MobileHealthBar.HandleMobileNameUpdate()
	if (IsMobile(WindowData.UpdateInstanceId)) then
		MobileHealthBar.HandleHealthBarStateUpdate()
		MobileHealthBar.UpdateName(WindowData.UpdateInstanceId)
		MobileHealthBar.HandleHealthBarColorUpdate()
	end
end

function MobileHealthBar.UpdateName(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		if(WindowData.MobileName[mobileId] ~= nil) then
			local windowName = "MobileHealthBar_"..mobileId
			local data = WindowData.MobileName[mobileId]
			
			if (data) then
				local text = string.find(WStringToString(data.MobName) , "Changeling")
				if ( MobileHealthBar.Changelings[mobileId] and not text) then
					LabelSetText(windowName.."Name", data.MobName .. L" (Changeling)")
				else
					LabelSetText(windowName.."Name", data.MobName)
				end
				
				local text = string.find(WStringToString(data.MobName) , "Irk")
				if ( MobileHealthBar.Irks[mobileId] and not text) then
					LabelSetText(windowName.."Name", data.MobName .. L" (Irk)")
				else
					LabelSetText(windowName.."Name", data.MobName)
				end
				
				local text = string.find(WStringToString(data.MobName) , "Guile")
				if ( MobileHealthBar.Guiles[mobileId] and not text) then
					LabelSetText(windowName.."Name", data.MobName .. L" (Guile)")
				else
					LabelSetText(windowName.."Name", data.MobName)
				end
				
				local text = string.find(WStringToString(data.MobName) , "Spite")
				if ( MobileHealthBar.Spites[mobileId] and not text) then
					LabelSetText(windowName.."Name", data.MobName .. L" (Spite)")
				else
					LabelSetText(windowName.."Name", data.MobName)
				end
				
				local text = string.find(WStringToString(data.MobName) , "Travesty")
				if ( MobileHealthBar.Travestys[mobileId] and not text) then
					LabelSetText(windowName.."Name", data.MobName .. L" (Travesty)")
				else
					LabelSetText(windowName.."Name", data.MobName)
				end
				
				WindowUtils.FitTextToLabel(windowName.."Name", data.MobName)
				local r,g,b = LabelGetTextColor(windowName.."Name")
				NameColor.UpdateLabelNameColor(windowName.."Name", data.Notoriety+1)
				local newr,newg,newb = LabelGetTextColor(windowName.."Name")
				local noto = NameColor.TextColors[data.Notoriety+1]
				if (mobileId == EnhancePack.CurrentHonor) then
					noto = {r=163, g=73, b=164}
				end
				LabelSetTextColor(windowName.."Name", noto.r, noto.g, noto.b)
				if (not MobilesOnScreen.SavedFilter[data.Notoriety+1] and MobileHealthBar.Handled[mobileId] == false and not MobilesOnScreen.IsPet(mobileId)) then
					-- MobilesOnScreen.RemoveHealthBar(mobileId)
					MobilesOnScreen.UpdateAnchors()
				elseif(MobileHealthBar.Handled[mobileId] == false and (r~=newr or g~=newg or b~=newb)) then
					MobilesOnScreen.Sort()
				end
				WindowSetTintColor(windowName .. "Background", noto.r,noto.g,noto.b)
			else
				LabelSetText(windowName.."Name", L"???" )
			end
		else
			local r,g,b = LabelGetTextColor(windowName.."Name")
			local noto = EnhancePack.NotoCalc(r,g,b)
			
			if (not MobilesOnScreen.SavedFilter[noto] and MobileHealthBar.Handled[mobileId] == false and not MobilesOnScreen.IsPet(mobileId)) then
				-- MobilesOnScreen.RemoveHealthBar(mobileId)
				MobilesOnScreen.UpdateAnchors()
			end
			LabelSetText(windowName.."Name", L"???" )
		end
	end
end

function MobileHealthBar.CloseButton_OnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 311))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MobileHealthBar.Extract_OnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 312) )
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MobileHealthBar.ExtractWindow(windowName)

	local mobileId =0

	
	if (windowName ~= nil and type(windowName) == "string") then
		mobileId = WindowGetId(windowName)
	else
		 mobileId = WindowGetId(WindowUtils.GetActiveDialog())
		 windowName = "MobileHealthBar_"..mobileId
	end
	
	MobileHealthBar.Handled[mobileId] = true

	if (EnhancePack.ShowCloseExtract) then
		WindowSetShowing( windowName .. "CloseButton", true)
		WindowSetShowing( windowName .. "Extract", false)
	else
		WindowSetShowing( windowName .. "CloseButton", false)
		WindowSetShowing( windowName .. "Extract", false)
	end
	
	
	
	if (MobilesOnScreen.IsPet(mobileId)) then
		PetWindow.UpdateAnchors()
	elseif (IsMobile(mobileId)) then

			--MobilesOnScreen.RemoveHealthBar(mobileId, true, true)

			MobilesOnScreen.UpdateAnchors()
			


	else
		MobileHealthBar.HandleAnchorWindow(windowName)
		
		return
	end
	MobileHealthBar.HandleAnchorWindow(windowName)
	WindowClearAnchors(windowName)
		local propWindowX = 0
		local propWindowY = 0
		local scale = WindowGetScale(windowName)
		
		local scaleFactor = 1/scale
		
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
		
		WindowSetOffsetFromParent(windowName, propWindowX * scaleFactor, propWindowY * scaleFactor)
		
		SnapUtils.StartWindowSnap(windowName)
	
	
end

function MobileHealthBar.HandleHealthBarColorUpdate()
    MobileHealthBar.UpdateHealthBarColor(WindowData.UpdateInstanceId)
end

function MobileHealthBar.UpdateHealthBarColor(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true) then
		local windowName = "MobileHealthBar_"..mobileId
		local healthBarWindow = windowName.."HealthBar"
		if (WindowData.HealthBarColor[mobileId] ~= nil) then
			HealthBarColor.UpdateHealthBarColor(healthBarWindow, WindowData.HealthBarColor[mobileId].VisualStateId)
		end
	end
end

function MobileHealthBar.HandleHealthBarStateUpdate()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	MobileHealthBar.UpdateHealthBarState(mobileId)
end

function MobileHealthBar.IsReallyEnabled(mobileId)
	-- ONLY FOR MOBILES!!!
	if (mobileId == nil) then
		return false
	end
	
	if ( IsHealthBarEnabled(mobileId)) then
		if (not IsMobile(mobileId)) then
			return false
		end
	else
		return false
	end
	return true
end

function MobileHealthBar.UpdateHealthBarState(mobileId)
	if(MobileHealthBar.hasWindow[mobileId] == true and not MobileHealthBar.ObjecHasWindow[mobileId]) then
		-- enable window
		
		local enabled = MobileHealthBar.IsReallyEnabled(mobileId) 
		if( enabled  ) then
			local windowName = "MobileHealthBar_"..mobileId
			WindowSetShowing(windowName.."HealthBar", true)
			
			LabelSetTextColor(windowName.."HealthBarLabel", 255, 255, 255)
			MobileHealthBar.windowDisabled[mobileId] = false
		-- disable window
		else
			
			if (not MobileHealthBar.Handled[mobileId]) then
				MobileHealthBar.CloseWindowByMobileId(mobileId)		

			else
				local windowName = "MobileHealthBar_"..mobileId
				WindowSetShowing(windowName .. "Wod", false)
				WindowSetShowing(windowName.."HealthBar",false)
				
				LabelSetTextColor(windowName.."Name", 128, 128, 128)
				LabelSetTextColor(windowName.."HealthBarLabel", 128, 128, 128)
				WindowSetShowing(windowName .. "HealthBarPerc", false)
				
				MobileHealthBar.windowDisabled[mobileId] = true
			end
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
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	MobileHealthBar.UnregisterHealthBar(windowName)
	
	MobileHealthBar.CrabNum[mobileId] = nil
	MobileHealthBar.CreateTime[mobileId] = nil

	if (not MobileHealthBar.Forced) then
	
		MobileHealthBar.Handled[mobileId] = nil
		if (MobilesOnScreen.IsPet(mobileId)) then
			PetWindow.UpdatePet()
		else
			--MobilesOnScreen.RemoveHealthBar(mobileId, true)
			
		end
	end
	MobilesOnScreen.UpdateAnchors()
	
end


function MobileHealthBar.OnLButtonDown( flags, x, y )
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())

	if (flags == SystemData.ButtonFlags.CONTROL and not MobileHealthBar.Handled[mobileId] and not (WindowData.Cursor and WindowData.Cursor.target == true)) then
		MobileHealthBar.ExtractWindow(WindowUtils.GetActiveDialog())
		return
	end
	
	
	if (flags == SystemData.ButtonFlags.ALT and MobileHealthBar.Handled[mobileId] and not (WindowData.Cursor and WindowData.Cursor.target == true) ) then
		EnhancePack.HealthbarCloseWindow()
		return
	end
	


	if(MobileHealthBar.windowDisabled[mobileId] == false) then
		
		EnhancePack.HonorMobile(mobileId)
		HandleSingleLeftClkTarget(mobileId)
	end
	
	if ( not MobileHealthBar.Handled[mobileId] ) then
		return
	end
	
	local windowName = "MobileHealthBar_"..mobileId
	
	WindowSetMoving(WindowUtils.GetActiveDialog(),true)
	
	SnapUtils.StartWindowSnap(windowName)
end

function MobileHealthBar.OnLButtonUp()
	WindowSetMoving(WindowUtils.GetActiveDialog(),false)
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
	    DragSlotDropObjectToObject(mobileId)
	end
end

function MobileHealthBar.OnLButtonDblClk()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	
	if(MobileHealthBar.windowDisabled[mobileId] == false) then
		
		local id = mobileId
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
					RequestContextMenu(id)
				else
					UserActionUseItem(id,false)
				end
			end
		else
			UserActionUseItem(id,false)
		end
		
		
	end
end

function MobileHealthBar.OnRButtonUp()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local petSize = table.getn(WindowData.Pets.PetId)
	local numPet
	for numPet = 1, petSize do
		MobilesOnScreen.ReversePet[WindowData.Pets.PetId[numPet]] = true
	end
	if (MobilesOnScreen.IsPet(mobileId)) then
		if (not MobileHealthBar.PetCloseStyle) then
			if(MobileHealthBar.windowDisabled[mobileId] == false) then
				RequestContextMenu(mobileId)
			end
		else
			EnhancePack.HealthbarCloseWindowByMobileId(mobileId)
		end
	else
		if (not MobileHealthBar.CloseStyle) then
			if(MobileHealthBar.windowDisabled[mobileId] == false) then
				RequestContextMenu(mobileId)
			end
		else
			EnhancePack.HealthbarCloseWindowByMobileId(mobileId)
		end
	end
end

function MobileHealthBar.OnMouseOver()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	local windowName = "MobileHealthBar_"..mobileId

	if (string.find(SystemData.ActiveWindow.name, "Inventory")) then
		mobileId = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
		local backpackId = 0
		if WindowData.Paperdoll[mobileId] then
			backpackId = WindowData.Paperdoll[mobileId].backpackId
		else
			RegisterWindowData(WindowData.Paperdoll.Type, mobileId)
			if WindowData.Paperdoll[mobileId] then
				backpackId = WindowData.Paperdoll[mobileId].backpackId
			end
			UnregisterWindowData(WindowData.Paperdoll.Type, mobileId)
		end
		--RegisterWindowData(WindowData.ContainerWindow.Type, backpackId)
		local itemData = {
			windowName = name,
			itemId = backpackId,
			itemType = WindowData.ItemProperties.TYPE_ITEM
		}
							   
		ItemProperties.SetActiveItem(itemData)
		--UnregisterWindowData(WindowData.ContainerWindow.Type, backpackId)
		return
	end
	if(string.find(SystemData.ActiveWindow.name, "Bod")) then
		local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 5555,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	GetStringFromTid(3006152), -- Bulk Order Info
							body = UI.GetCliloc(SystemData.Settings.Language.type, 784)}
							
		ItemProperties.SetActiveItem(itemData)
		return
	end
	if(string.find(SystemData.ActiveWindow.name, "Talk")) then
		local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 5555,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	GetStringFromTid(3006146), -- Talk
							body = UI.GetCliloc(SystemData.Settings.Language.type, 785)}
							
		ItemProperties.SetActiveItem(itemData)
		return
	end
	if(string.find(SystemData.ActiveWindow.name, "Bank")) then
		local itemData = { windowName = SystemData.ActiveWindow.name,
							itemId = 5555,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	UI.GetCliloc(SystemData.Settings.Language.type, 787),
							body = UI.GetCliloc(SystemData.Settings.Language.type, 786)}
							
		ItemProperties.SetActiveItem(itemData)
		return
	end
	
	if(MobileHealthBar.windowDisabled[mobileId] == false and WindowGetMoving(windowName) == false) then
		MobileHealthBar.mouseOverId = mobileId

		local item = WindowData.ObjectInfo[mobileId]
		local itemData
		if (item ) then
			local texto = string.find(WStringToString(item.name) , "Lobster Trap")
			local text2 = string.find(WStringToString(item.name) , "Empty ")
			local text3 = string.find(WStringToString(item.name) , "Full ")
			if ( texto ~= nil and text2 == nil and text3 == nil) then
				local body = wstring.gsub(UI.GetCliloc(SystemData.Settings.Language.type, 583), L"_TIME_", StringToWString(Hourglass.SecondsToClock(EnhancePack.TimeSinceLogin - MobileHealthBar.CreateTime[mobileId], true)))
				itemData = { windowName = windowName,
								itemId = 12515,
								itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
								binding = L"",
								detail = nil,
								title =	item.name,
								body = body
							}
			else
				itemData =
				{
					windowName = windowName,
					itemId = mobileId,
					itemType = WindowData.ItemProperties.TYPE_ITEM,
				}
			end
		else
			itemData =
			{
				windowName = windowName,
				itemId = mobileId,
				itemType = WindowData.ItemProperties.TYPE_ITEM,
			}				
		end	
		ItemProperties.SetActiveItem(itemData)
		
	end
end

function MobileHealthBar.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	MobileHealthBar.mouseOverId = 0
	if (DoesWindowNameExist("MobileArrow")) then
		DestroyWindow("MobileArrow")
	end
end



function MobileHealthBar.Null()
end





function MobileHealthBar.kill(mobileId)

	local spellId = 614
		
	UserActionCastSpellOnId(spellId, mobileId)
end

function MobileHealthBar.WodButton_OnLButtonUp()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if(mobileId) then
		local data = WindowData.MobileName[mobileId]
		if (data.Notoriety+1 == 1 or data.Notoriety+1 == 2) then
			if (SystemData.Settings.GameOptions.queryBeforeCriminalAction) then
				local okayButton = { textTid=1013076, callback=function()  MobileHealthBar.kill(mobileId ) end }
                local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL, callback=MobileHealthBar.Null();}
				local DestroyConfirmWindow = 
				{
				    windowName = "Warning"..mobileId,
					title = GetStringFromTid(1111873),
					body= GetStringFromTid(3000032),
					buttons = { okayButton, cancelButton }
				}
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
			else
				MobileHealthBar.kill(mobileId )
			end
		else
			MobileHealthBar.kill(mobileId )
		end 
		
	end
end


function MobileHealthBar.WodButton_OnMouseOver()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	
	local spellId = 614
	
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = spellId,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SPELL,
						detail = ItemProperties.DETAIL_SHORT }
						
	ItemProperties.SetActiveItem(itemData)
	PartyHealthBar.mouseOverId = mobileId
end

function MobileHealthBar.OnBPackLButtonUp()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local mobileId = WindowGetId( parent )
	local bakcpackId = 0
	if WindowData.Paperdoll[mobileId] then
		backpackId = WindowData.Paperdoll[mobileId].backpackId
	else
		RegisterWindowData(WindowData.Paperdoll.Type, mobileId)
		if WindowData.Paperdoll[mobileId] then
			backpackId = WindowData.Paperdoll[mobileId].backpackId
		end
		UnregisterWindowData(WindowData.Paperdoll.Type, mobileId)
	end
	
	if backpackId and
	backpackId ~= 0 then
		UserActionUseItem(backpackId, false)
	end
end

function MobileHealthBar.OnBodLButtonUp()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	EnhancePack.PlayerContextItemRequest = true
	ContextMenu.PlayerRequest = 403
	local mobileId = WindowGetId( parent )
	RequestContextMenu(mobileId)
end

function MobileHealthBar.OnTalkLButtonUp()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	EnhancePack.PlayerContextItemRequest = true
	ContextMenu.PlayerRequest = 303
	local mobileId = WindowGetId( parent )
	RequestContextMenu(mobileId)
end

function MobileHealthBar.OnBankLButtonUp()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	EnhancePack.PlayerContextItemRequest = true
	ContextMenu.PlayerRequest = 120
	local mobileId = WindowGetId( parent )
	RequestContextMenu(mobileId)
end

