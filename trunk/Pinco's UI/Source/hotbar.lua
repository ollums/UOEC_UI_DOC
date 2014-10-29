----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Hotbar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Hotbar.NUM_BUTTONS = 12

Hotbar.CurrentUseSlot = 0
Hotbar.CurrentUseHotbar = 0

Hotbar.CurrentChangeColorWindow = 0

Hotbar.DarkItemLabel = { r=245,g=229,b=0 }
Hotbar.LightItemLabel = { r=0,g=0,b=0 }

Hotbar.RecordingKey = false
Hotbar.RecordingSlot = 0
Hotbar.RecordingHotbar = 0

Hotbar.HANDLE_OFFSET = 20
Hotbar.BUTTON_SIZE = 50

Hotbar.TID_BINDING_CONFLICT_TITLE = 1079169
Hotbar.TID_BINDING_CONFLICT_BODY = 1079170
Hotbar.TID_BINDING_CONFLICT_QUESTION = 1094839
Hotbar.TID_YES = 1049717
Hotbar.TID_NO = 1049718

Hotbar.TID_TARGET = 1079927 -- "Target:"
Hotbar.TID_BINDING = 1079928 -- "Binding:"

Hotbar.TID_HOTBAR = 1079167 -- "Hotbar"
Hotbar.TID_SLOT = 1079168 -- "Slot"

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

function Hotbar.SetHotbarItem(hotbarId, slot)
	local itemIndex = slot
	local element = "Hotbar"..hotbarId.."Button"..slot	
	local hasItem = HotbarHasItem(hotbarId, itemIndex)
	
	local actionId = UserActionGetId(hotbarId,slot,0)
	if (actionId == 5059) then
		hasItem = false
	end
	--Debug.Print("Hotbar.SetHotbarItem: "..tostring(slot).." itemIndex: "..tostring(itemIndex).." hasItem: "..tostring(hasItem))
	
	-- bail out if this item doesnt exist in c++
	if( hasItem == false ) then
		return
	end
	
	HotbarSystem.RegisterAction(element, hotbarId, itemIndex, 0)
end

function Hotbar.ClearHotbarItem(hotbarId, slot, bUnregister, ignore)
	--Debug.PrintToDebugConsole(L"Hotbar::ClearHotbarSlot Slot: "..slot)

	local itemIndex = slot
	local element = "Hotbar"..hotbarId.."Button"..slot

	HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, 0, bUnregister)	
end

function Hotbar.ReloadHotbar(hotbarId)
	--Debug.Print("Hotbar.ReloadHotbar")
	
	
	for slot = 1, Hotbar.NUM_BUTTONS do	
		Hotbar.SetHotbarItem(hotbarId,slot)
		local element = "Hotbar"..hotbarId.."Button"..slot
		--local iconId = UserActionGetIconId(hotbarId, slot, 0)
		DynamicImageSetRotation(element.."QuantityBackground", 180)
		if ( DoesWindowNameExist(element.."QuantityBackground") ) then
			WindowSetShowing(element.."QuantityBackground", false)
		
			if (tonumber(LabelGetText(element.."Quantity")) > 1) then
				WindowSetShowing(element.."QuantityBackground", true)
			end
		end
		--HotbarSystem.SetHotbarIcon(element, iconId)
	end
	if (EnhancePack) then
		local hotbar = "Hotbar"..hotbarId
		EnhancePack.LoadScale( hotbar )
		local x, y = WindowGetOffsetFromParent(hotbar)
		WindowClearAnchors(hotbar)
		WindowSetOffsetFromParent(hotbar, x, y)
		local closed = CustomSettings.LoadBoolean( hotbar.. "Closed",false )
		if (closed) then
			Hotbar.Shrink(hotbar)
		end
		
		text = CustomSettings.LoadWString( "Hotbar"..hotbarId .. "CustomText", L"" )
		
		if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont("Hotbar"..hotbarId .. "NameH",  "UO_DefaultText_ASIA_13", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("Hotbar"..hotbarId .. "NameV",  "UO_DefaultText_ASIA_13", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("Hotbar"..hotbarId .. "NameVrev",  "UO_DefaultText_ASIA_13", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("Hotbar"..hotbarId .. "NameHrev",  "UO_DefaultText_ASIA_13", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		
		LabelSetText("Hotbar"..hotbarId .. "NameH", text)
		LabelSetText("Hotbar"..hotbarId .. "NameV", text)
		LabelSetText("Hotbar"..hotbarId .. "NameVrev", text)
		LabelSetText("Hotbar"..hotbarId .. "NameHrev", text)
		
		local width, height = WindowGetDimensions(hotbar)
		
		if (not CustomSettings.LoadBoolean( "Hotbar"..hotbarId .. "ReverseText", false ) ) then
			WindowSetShowing("Hotbar"..hotbarId .. "NameVrev", false)
			WindowSetShowing("Hotbar"..hotbarId .. "NameHrev", false)
			if (width < height) then
				WindowSetShowing("Hotbar"..hotbarId .. "NameV", false)
				WindowSetShowing("Hotbar"..hotbarId .. "NameH", true)
			else
				WindowSetShowing("Hotbar"..hotbarId .. "NameV", true)
				WindowSetShowing("Hotbar"..hotbarId .. "NameH", false)
			end
		else
			WindowSetShowing("Hotbar"..hotbarId .. "NameV", false)
			WindowSetShowing("Hotbar"..hotbarId .. "NameH", false)
			if (width < height) then
				WindowSetShowing("Hotbar"..hotbarId .. "NameVrev", false)
				WindowSetShowing("Hotbar"..hotbarId .. "NameHrev", true)
			else
				WindowSetShowing("Hotbar"..hotbarId .. "NameVrev", true)
				WindowSetShowing("Hotbar"..hotbarId .. "NameHrev", false)
			end
		end
		
		width = CustomSettings.LoadNumber( hotbar .. "SizeW", width )
		height = CustomSettings.LoadNumber( hotbar .. "SizeH", height )
		color = CustomSettings.LoadColor(hotbar .. "HandleColor",{r=153,g=153,b=153})
		WindowSetTintColor(hotbar .. "HorizHandle", color.r, color.g, color.b)
		WindowSetTintColor(hotbar .. "VertHandle", color.r, color.g, color.b)
		
		LabelSetTextColor(hotbar .. "NameH", color.r, color.g, color.b)
		LabelSetTextColor(hotbar .. "NameV", color.r, color.g, color.b)
		LabelSetTextColor(hotbar .. "NameVrev", color.r, color.g, color.b)
		LabelSetTextColor(hotbar .. "NameHrev", color.r, color.g, color.b)
		
		if (CustomSettings.LoadBoolean( hotbar .. "LeftToRight", false )) then
			
			if (width > height) then
				
				ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "hud_image", 61, 937)
				ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "hud_image", 85 , 937)
				ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "hud_image", 85 , 937)
				ButtonSetTexture(hotbar .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "hud_image", 85 , 937)
				
				ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "hud_image", 37, 937)
				ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "hud_image", 13 , 937)
				ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "hud_image", 13 , 937)
				ButtonSetTexture(hotbar .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "hud_image", 13 , 937)
				
				
			else
				ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 50, 1)
				ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 76 , 0)
				ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 76 , 0)
				ButtonSetTexture(hotbar .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 76 , 0)
					
				ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 27, 0)
				ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 3 , 2)
				ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 3 , 2)
				ButtonSetTexture(hotbar .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 3 , 2)
				
			end
		end
	end
end

function Hotbar.ShrinkTooltip()
	local windowname = WindowUtils.GetActiveDialog()
	local closed = CustomSettings.LoadBoolean( windowname.. "Closed",false )
	if (closed) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 287))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 288))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	Hotbar.ShowBar("Hotbar" .. hotbarId)
end

function Hotbar.SpecialLock()
	local windowname = WindowUtils.GetActiveDialog()
	if (CustomSettings.LoadBoolean( windowname .. "LockWithHandle", false ) ) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 289),0,"unlock",{wind=windowname},false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 290),0,"lock",{wind=windowname},false)
	end
	
	local width = CustomSettings.LoadNumber( windowname .. "SizeW", 50 )
	local height = CustomSettings.LoadNumber( windowname .. "SizeH", 50 )
	
	local w,h = WindowGetDimensions(windowname)
	if w > width then
		width = w
	end
	if h > height then
		height = h
	end
	
	if (not CustomSettings.LoadBoolean( windowname .. "LeftToRight", false ) ) then
		if (width > height) then
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 291),0,"closeR",{wind=windowname, side =UI.GetCliloc(SystemData.Settings.Language.type, 299)} ,false)
		else
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 292),0,"closeR",{wind=windowname, side =UI.GetCliloc(SystemData.Settings.Language.type, 300)},false)
		end
	else
		if (width > height) then
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 293),0,"closeL",{wind=windowname, side =UI.GetCliloc(SystemData.Settings.Language.type, 301)},false)
		else
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 294),0,"closeL",{wind=windowname, side =UI.GetCliloc(SystemData.Settings.Language.type, 302)},false)
		end
	end
	
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 295),0,"HandleColor",{wind=windowname, side =L"HandleColor"} ,false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 996),0,"Reverse",{wind=windowname} ,false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 997),0,"SetText",{wind=windowname} ,false)
	
	ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallbackLock)
end

function Hotbar.ContextMenuCallbackLock( returnCode, param )
	local windowname = param.wind

	if ( returnCode=="lock" ) then
		CustomSettings.SaveBoolean( windowname .. "LockWithHandle", true )
		ChatWindow.Print(UI.GetCliloc(SystemData.Settings.Language.type, 296))
	elseif ( returnCode=="unlock" ) then
		CustomSettings.SaveBoolean( windowname .. "LockWithHandle", false )
		ChatWindow.Print(UI.GetCliloc(SystemData.Settings.Language.type, 297))
	elseif ( returnCode=="closeR" ) then
		CustomSettings.SaveBoolean( windowname .. "LeftToRight", true )
		ChatWindow.Print(UI.GetCliloc(SystemData.Settings.Language.type, 298) .. param.side .. L"!")
		if (param.side == L"Right") then
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "hud_image", 85 , 937)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "hud_image", 85 , 937)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "hud_image", 85 , 937)
			
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "hud_image", 37, 937)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "hud_image", 13 , 937)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "hud_image", 13 , 937)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "hud_image", 13 , 937)
		else
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 50, 1)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 76 , 0)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 76 , 0)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 76 , 0)
				
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 27, 0)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 3 , 2)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 3 , 2)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 3 , 2)
		end
	elseif ( returnCode=="closeL" ) then
		CustomSettings.SaveBoolean( windowname .. "LeftToRight", false )
		ChatWindow.Print(UI.GetCliloc(SystemData.Settings.Language.type, 298)  .. param.side .. L"!")
		if (param.side == L"Left") then
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "hud_image", 61, 937)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "hud_image", 85 , 937)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "hud_image", 85 , 937)
			ButtonSetTexture(windowname .. "MaximizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "hud_image", 85 , 937)
				
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL, "hud_image", 37, 937)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "hud_image", 13 , 937)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED, "hud_image", 13 , 937)
			ButtonSetTexture(windowname .. "MinimizeButtonH", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "hud_image", 13 , 937)
		else
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 50, 1)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 76 , 0)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 76 , 0)
			ButtonSetTexture(windowname .. "MaximizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 76 , 0)
				
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL, "updown", 27, 0)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "updown", 3 , 2)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED, "updown", 3 , 2)
			ButtonSetTexture(windowname .. "MinimizeButtonV", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "updown", 3 , 2)
		end
	elseif ( returnCode=="Reverse" ) then
		local stat = CustomSettings.LoadBoolean( windowname .. "ReverseText", false )
		CustomSettings.SaveBoolean( windowname .. "ReverseText", not stat )
		local width, height = WindowGetDimensions(windowname)
		if (not CustomSettings.LoadBoolean( windowname .. "ReverseText", false ) ) then
			WindowSetShowing(windowname .. "NameVrev", false)
			WindowSetShowing(windowname .. "NameHrev", false)
			if (width < height) then
				WindowSetShowing(windowname .. "NameV", false)
				WindowSetShowing(windowname .. "NameH", true)
			else
				WindowSetShowing(windowname .. "NameV", true)
				WindowSetShowing(windowname .. "NameH", false)
			end
		else
			WindowSetShowing(windowname .. "NameV", false)
			WindowSetShowing(windowname .. "NameH", false)
			if (width < height) then
				WindowSetShowing(windowname .. "NameVrev", false)
				WindowSetShowing(windowname .. "NameHrev", true)
			else
				WindowSetShowing(windowname .. "NameVrev", true)
				WindowSetShowing(windowname .. "NameHrev", false)
			end
		end
	elseif ( returnCode=="SetText" ) then
		local rdata = {title=GetStringFromTid(1077826), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 595), callfunction=Hotbar.SetText, id=windowname}
		RenameWindow.Create(rdata)
	elseif ( returnCode=="HandleColor" ) then	
		Hotbar.PickColor(param.side, windowname)
	end
	local button = windowname .."ResizeButton"
	if (CustomSettings.LoadBoolean( windowname .. "LockWithHandle", false )) then
		WindowSetShowing(button, false)
	elseif ( not CustomSettings.LoadBoolean( windowname.. "Closed",false )) then
		WindowSetShowing(button, true)
	end
end

function Hotbar.SetText(windowname, text)
	CustomSettings.SaveWString( windowname .. "CustomText", text )
	LabelSetText(windowname .. "NameH", text)
	LabelSetText(windowname .. "NameV", text)
	LabelSetText(windowname .. "NameVrev", text)
	LabelSetText(windowname .. "NameHrev", text)
end

function Hotbar.PickColor(color, windowname)
	Hotbar.CurrentChangeColorWindow = windowname
	local defaultColors = {
		0, --HUE_NONE 
		34, --HUE_RED
		53, --HUE_YELLOW
		63, --HUE_GREEN
		89, --HUE_BLUE
		119, --HUE_PURPLE
		144, --HUE_ORANGE
		368, --HUE_GREEN_2
		946, --HUE_GREY
		}
		local hueTable = {}
		for idx, hue in pairs(defaultColors) do
			for i=0,8 do
				hueTable[(idx-1)*10+i+1] = hue+i
			end
		end
		local Brightness = 1
		CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )
		WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)
		ColorPickerWindow.SetNumColorsPerRow(9)
		ColorPickerWindow.SetSwatchSize(30)
		ColorPickerWindow.SetWindowPadding(4,4)
		ColorPickerWindow.SetFrameEnabled(true)
		ColorPickerWindow.SetCloseButtonEnabled(true)
		ColorPickerWindow.SetColorTable(hueTable,"ColorPicker")
		ColorPickerWindow.DrawColorTable("ColorPicker")
		ColorPickerWindow.SetAfterColorSelectionFunction(Hotbar.ColorPicked)
		local w, h = WindowGetDimensions("ColorPicker")
		WindowAddAnchor( "ColorPicker", "center", "Root", "center", 0, 0)
		ColorPickerWindow.SetFrameEnabled(false)
		WindowSetShowing( "ColorPicker", true )
		ColorPickerWindow.SelectColor("ColorPicker", 1)
end

function Hotbar.ColorPicked()
		local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]
		local color = {}
		color.r, color.g, color.b = HueRGBAValue(huePicked)
		CustomSettings.SaveColor(Hotbar.CurrentChangeColorWindow .. "HandleColor",color)
		WindowSetTintColor(Hotbar.CurrentChangeColorWindow .. "HorizHandle", color.r, color.g, color.b)
		WindowSetTintColor(Hotbar.CurrentChangeColorWindow .. "VertHandle", color.r, color.g, color.b)
		LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameH", color.r, color.g, color.b)
		LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameV", color.r, color.g, color.b)
		LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameVrev", color.r, color.g, color.b)
		LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameHrev", color.r, color.g, color.b)
		DestroyWindow("ColorPicker")
end

function Hotbar.Shrink(hotbar)
	local windowname = WindowUtils.GetActiveDialog() or hotbar
	
	local text = string.find(windowname, "Hotbar")
	if (not text) then
		return
	end
	local currentButton = SystemData.ActiveWindow.name
	local width, height = WindowGetDimensions(windowname)
	
	CustomSettings.SaveNumber( windowname .. "SizeW", width )
	CustomSettings.SaveNumber( windowname .. "SizeH", height )
	local x, y = WindowGetOffsetFromParent(windowname)
	
	CustomSettings.SaveBoolean( windowname.. "Closed",true )
	
	if (not CustomSettings.LoadBoolean( windowname .. "ReverseText", false ) ) then
		WindowSetShowing(windowname .. "NameVrev", false)
		WindowSetShowing(windowname .. "NameHrev", false)
		if (width > height) then
			WindowSetShowing(windowname .. "NameV", false)
			WindowSetShowing(windowname .. "NameH", true)
		else
			WindowSetShowing(windowname .. "NameV", true)
			WindowSetShowing(windowname .. "NameH", false)
		end
	else
		WindowSetShowing(windowname .. "NameV", false)
		WindowSetShowing(windowname .. "NameH", false)
		if (width > height) then
			WindowSetShowing(windowname .. "NameVrev", false)
			WindowSetShowing(windowname .. "NameHrev", true)
		else
			WindowSetShowing(windowname .. "NameVrev", true)
			WindowSetShowing(windowname .. "NameHrev", false)
		end
	end
			
	if (width > height) then
		
		
		WindowSetDimensions(windowname, 20, 50)
		WindowSetShowing(windowname .. "MaximizeButtonH" , true)
		if (currentButton) then
			WindowSetShowing(currentButton , false)
		else
			currentButton = windowname .. "MinimizeButtonH"
			WindowSetShowing(currentButton , false)
		end
		if (CustomSettings.LoadBoolean( windowname .. "LeftToRight", false ) and EnhancePack.TimeSinceLogin > 0.5 ) then
			if (WindowGetAnchorCount(windowname) > 0) then
				WindowClearAnchors(windowname)
			end
			WindowSetOffsetFromParent(windowname, (x + (width - 20)), y)
		end
		
	else
		WindowSetDimensions(windowname, 50, 20)
		WindowSetShowing(windowname .. "MaximizeButtonV" , true)
		if (currentButton) then
			WindowSetShowing(currentButton , false)
		else
			currentButton = windowname .. "MinimizeButtonV"
			WindowSetShowing(currentButton , false)
		end
		if (CustomSettings.LoadBoolean( windowname .. "LeftToRight", false ) and EnhancePack.TimeSinceLogin > 0.5 ) then
			if (WindowGetAnchorCount(windowname) > 0) then
				WindowClearAnchors(windowname)
			end
			WindowSetOffsetFromParent(windowname, x, (y + (height - 20)))
		end
		
	end
	for slot=1, Hotbar.NUM_BUTTONS do
		local button = windowname.."Button"..slot
		WindowSetShowing(button, false)
	end
	button = windowname.."ResizeButton"
	WindowSetShowing(button, false)
	
end

function Hotbar.Enlarge(hotbar)
	local windowname = WindowUtils.GetActiveDialog() or hotbar
	
	local text = string.find(windowname, "Hotbar")
	if (not text) then
		return
	end
	local currentButton = SystemData.ActiveWindow.name
	
	local width = CustomSettings.LoadNumber( windowname .. "SizeW", 50 )
	local height = CustomSettings.LoadNumber( windowname .. "SizeH", 50 )
	local x, y = WindowGetOffsetFromParent(windowname)
	CustomSettings.SaveBoolean( windowname.. "Closed",false )
	WindowSetDimensions(windowname, width, height)
	
	if (not CustomSettings.LoadBoolean( windowname .. "ReverseText", false ) ) then
		WindowSetShowing(windowname .. "NameVrev", false)
		WindowSetShowing(windowname .. "NameHrev", false)
		if (width < height) then
			WindowSetShowing(windowname .. "NameV", false)
			WindowSetShowing(windowname .. "NameH", true)
		else
			WindowSetShowing(windowname .. "NameV", true)
			WindowSetShowing(windowname .. "NameH", false)
		end
	else
		WindowSetShowing(windowname .. "NameV", false)
		WindowSetShowing(windowname .. "NameH", false)
		if (width < height) then
			WindowSetShowing(windowname .. "NameVrev", false)
			WindowSetShowing(windowname .. "NameHrev", true)
		else
			WindowSetShowing(windowname .. "NameVrev", true)
			WindowSetShowing(windowname .. "NameHrev", false)
		end
	end
		
	if (width > height) then
		WindowSetShowing(windowname.. "MinimizeButtonH" , true)

		if (currentButton) then
			WindowSetShowing(currentButton , false)
		else
			currentButton = windowname .. "MinimizeButtonH"
			WindowSetShowing(currentButton , false)
		end
		if (CustomSettings.LoadBoolean( windowname .. "LeftToRight", false ) and EnhancePack.TimeSinceLogin > 0.5 ) then
			if (WindowGetAnchorCount(windowname) > 0) then
				WindowClearAnchors(windowname)
			end
			WindowSetOffsetFromParent(windowname, (x - (width -20)), y)
				
		end
	else
		WindowSetShowing(windowname .. "MinimizeButtonV" , true)
		if (currentButton) then
			WindowSetShowing(currentButton , false)
		else
			currentButton = windowname .. "MinimizeButtonV"
			WindowSetShowing(currentButton , false)
		end
		
		if (CustomSettings.LoadBoolean( windowname .. "LeftToRight", false ) and EnhancePack.TimeSinceLogin > 0.5 ) then
			if (WindowGetAnchorCount(windowname) > 0) then
				WindowClearAnchors(windowname)
			end
			WindowSetOffsetFromParent(windowname, x, (y - (height - 20)))
		end
	end
	local button = windowname.."Button"..1
	WindowSetShowing(button, true)
	
	button = windowname.."ResizeButton"
	WindowSetShowing(button, true)
	
	Hotbar.OnResizeEnd(windowname)

	
end

function Hotbar.SetLocked(hotbarId, locked)
	--Debug.Print("Hotbar.SetLocked: Hotbar"..hotbarId.." is "..(locked and "LOCKED" or "UNLOCKED"))
	
	local curWindow = "Hotbar"..hotbarId
	
	SystemData.Hotbar[hotbarId].Locked = locked
	WindowSetShowing(curWindow.."ResizeButton", not locked)
	Hotbar.OnResizeEnd(curWindow)
end

function Hotbar.UseSlot(hotbarId, slot)

	local itemIndex = slot
	if hotbarId == EnhancePack.ToggleableHotbar then
		Hotbar.ToggleQuickHotbar()
	end
	if( HotbarHasItem(hotbarId, itemIndex) ) then
		HotbarExecuteItem(hotbarId, itemIndex)
	end

end

function Hotbar.ToggleQuickHotbar()
	local quickbar = "Hotbar"..EnhancePack.ToggleableHotbar
	local showing = WindowGetShowing(quickbar)
	if not showing then
		WindowClearAnchors(quickbar)
		local propWindowX = 0
		local propWindowY = 0
		local scale = WindowGetScale(quickbar)
		local scaleFactor = 1/scale
		local propWindowWidth, propWindowHeight = WindowGetDimensions(quickbar)
		
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
	
		WindowSetOffsetFromParent(quickbar, propWindowX * scaleFactor, propWindowY * scaleFactor)
	end
	WindowSetShowing(quickbar, not showing)
	Hotbar.SetLocked(EnhancePack.ToggleableHotbar, true)
end




-- OnInitialize Handler
function Hotbar.Initialize()
	this = SystemData.ActiveWindow.name
	local hotbarId = SystemData.DynamicWindowId
	
	SnapUtils.SnappableWindows[this] = true
	
	WindowSetId(this,hotbarId)
	
	WindowRegisterEventHandler( this, SystemData.Events.INTERFACE_KEY_RECORDED, "Hotbar.KeyRecorded" )
	WindowRegisterEventHandler( this, SystemData.Events.INTERFACE_KEY_CANCEL_RECORD, "Hotbar.KeyCancelRecord" )
	
	-- hotbars positions and sizes are tracked
	WindowUtils.RestoreWindowPosition(this,true)
	if (not SystemData.Hotbar[hotbarId]) then
		return
	end
	Hotbar.SetLocked(hotbarId, SystemData.Hotbar[hotbarId].Locked)
	
	-- set the hotbar labels based on the hotkey
	-- and initialize the slots
	for slot = 1, Hotbar.NUM_BUTTONS do
	   local element = this.."Button"..slot
	   local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]
	   local key2 = SystemData.Hotbar[hotbarId].Bindings[slot]
	   
		if not HotbarSystem.BindingsBackup then
			HotbarSystem.BindingsBackup = {}
		end
	    if not HotbarSystem.BindingsBackup[hotbarId] then
			HotbarSystem.BindingsBackup[hotbarId] = {}
		end
		HotbarSystem.BindingsBackup[hotbarId][slot] = key2

	   HotbarSystem.UpdateBinding(element,key, key2)
	   
	   Hotbar.ClearHotbarItem(hotbarId,slot,false)
	end	
	
	Hotbar.ReloadHotbar(hotbarId)
	
end

-- OnShutdown Handler
function Hotbar.Shutdown()
	--Debug.Print("Hotbar.Shutdown")
	
	this = SystemData.ActiveWindow.name
	hotbarId = WindowGetId(this)
	
	SnapUtils.SnappableWindows[this] = nil
	
	for slot = 1, Hotbar.NUM_BUTTONS do
		Hotbar.ClearHotbarItem(hotbarId,slot,true)
	end
	
	if( ItemProperties.GetCurrentWindow() == "Hotbar"..hotbarId ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	-- save the position of dynamic bars
	WindowUtils.SaveWindowPosition(this)
end

-- OnLButtonDown Handler
function Hotbar.ItemLButtonDown()
	
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	
	local actionId = UserActionGetId(hotbarId,slot,0)
	
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonDown(): Slot "..slot)

	local itemIndex = slot
		
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true and hotbarId ~= 0 )
	then	
	
				
		if ( UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_ITEM ) then
			local objID = UserActionGetId(hotbarId, slot, 0)
			if objID
			and objID ~= 0 
			and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
			then
				HandleSingleLeftClkTarget(objID)
				Hotbar.CurrentUseHotbar = nil
				Hotbar.CurrentUseSlot = nil
			end
		elseif( UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_OBJECTTYPE )
		then
			local specID = UserActionGetId(hotbarId, slot, 0)
			if specID 
			and specID ~= 0 
			then
				local objID = UserActionGetNextObjectId(specID)
				if objID 
				and objID ~= 0 
				and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
				then
					HandleSingleLeftClkTarget(objID)
					Hotbar.CurrentUseHotbar = nil
					Hotbar.CurrentUseSlot = nil
				end
			end
		elseif (actionId == 5015) then
			local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
			HandleSingleLeftClkTarget(backpackId)
		else
			
			if HotbarHasItem(hotbarId, itemIndex)
			and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
			then
				Hotbar.CurrentUseHotbar = hotbarId
				Hotbar.CurrentUseSlot = slot
			end
		end
	else
		if HotbarHasItem(hotbarId, itemIndex) then
			local element = "Hotbar"..hotbarId.."Button"..itemIndex .. "AllowDrag"

			if not SystemData.Hotbar[hotbarId].Locked and not CustomSettings.LoadBoolean( "Hotbar"..hotbarId .. "LockWithHandle", false ) or CustomSettings.LoadBoolean( element, false ) then
				if( UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_OBJECTTYPE ) then
					local specID = UserActionGetId(hotbarId, slot, 0)
					
					if specID and specID ~= 0 then
						local objID = UserActionGetNextObjectId(specID)

						DragSlotSetObjectMouseClickData(objID, SystemData.DragSource.SOURCETYPE_CONTAINER)
					end
				else
				
					local element = "Hotbar"..hotbarId.."Button"..slot
				--	HotbarSystem.FeintSlots[element] = nil
					LabelSetText(element.."BandageTime", L"")
					DragSlotSetExistingActionMouseClickData(hotbarId,slot,0)
					CustomSettings.DeleteSetting( element .. "Custom" )
				end
			end

		    if (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" )) then
				Hotbar.CurrentUseHotbar = hotbarId
				Hotbar.CurrentUseSlot = slot
			end
		end
	end
end


-- OnLButtonUP Handler
function Hotbar.ItemLButtonUp()
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonUp(): Slot = "..StringToWString(tostring(slot)))
	--Debug.PrintToDebugConsole(L"Hotbar::OnLButtonUp(): SystemData.DragItem.DragType =  "..StringToWString(tostring(SystemData.DragItem.DragType)))
	
	if( SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_NONE ) then
		local actionId = UserActionGetId(hotbarId,slot,0)

		if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM and actionId == 5015) then
			DragSlotDropObjectToObject(WindowData.PlayerStatus.PlayerId)
		else
			local dropSuccess = DragSlotDropAction(hotbarId,slot,0)
		    
			if( dropSuccess ) then
				-- clear existing hotbar icon
		        
				Hotbar.ClearHotbarItem(hotbarId,slot,true)	   
				
				local element = "Hotbar"..hotbarId.."Button"..slot
				--HotbarSystem.FeintSlots[element] = nil
				LabelSetText(element.."BandageTime", L"")

				-- get the new action type for this item
				local actionType = UserActionGetType(hotbarId,slot,0)

		        actionId = UserActionGetId(hotbarId,slot,0)
				
				-- open action window if applicable
				local slotWindow = "Hotbar"..hotbarId.."Button"..slot
				
				if (actionId == 10030) then
					EnhancePack.PropsSlot = {HotbarID = hotbarId, SlotID = slot}
					CustomSettings.SaveNumber("EnhancePackPropsSlotHotbarID", hotbarId )
					CustomSettings.SaveNumber("EnhancePackPropsSlotSlotID", slot )
					ActionsWindow.UpdateIcons()
			    end
			    
				-- update hotbar item in ui
				Hotbar.SetHotbarItem(hotbarId,slot)
		        
		        
		        local notarget = false
				local type = UserActionGetType(hotbarId, slot, 0)
				if (type == SystemData.UserAction.TYPE_SPELL and SpellsInfo) then
					for no, value in pairs(SpellsInfo.SpellsData) do
						if value.id == actionId then
							notarget = value.notarget
							break
						end
					end
				end
			    if notarget then
					UserActionSetTargetType(hotbarId,slot,0,SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)
				end
			    
				if (actionId and (actionId < 5000 or (actionId >= 6000 and actionId <= 8000)) or actionId == 5048 or actionId == 5058  or actionId == 5059 or (actionId >=10000 and actionId <= 15000) or (actionId > 15000 and actionId < 15100)) then
					if (actionId == 50 or actionId == 53 or actionId == 54 or actionId == 7000 or actionId == 7001 or actionId == 7002 or actionId == 7003 or actionId == 7004 or actionId == 7005 or (actionId >=10000 and actionId <= 15000) or (actionId >=7020 and actionId <= 7050)) then
						
						
						if (actionId == 10027) then
							local speechText = ActionsWindow.ActionData[actionId].callback
							speechText = wstring.gsub(speechText, L"~TYPE~", L"\"owner\"")
							UserActionSpeechSetText(hotbarId, slot, 0, speechText)
						else
							local speechText = ActionsWindow.ActionData[actionId].callback
							UserActionSpeechSetText(hotbarId, slot, 0, speechText)
						end
						
					else
						ActionEditWindow.OpenEditWindow(actionType,slotWindow,hotbarId,slot,0, actionId)
					end
				elseif (actionId and (actionId > 5000 and actionId < 15000) ) then
					if (actionId >= 5070 and actionId <= 5084) then
						EnhancePack.PetballHotbar = hotbarId
						EnhancePack.PetballSlot= slot
						EnhancePack.PetballSubIndex = 0
						EnhancePack.TargetPetball()
					elseif (actionId >= 5065 and actionId <= 5069) then
						local speechText = ActionsWindow.ActionData[actionId].callback
						UserActionSpeechSetText(hotbarId, slot, 0, speechText)		
					elseif (actionId >= 5085 and actionId <= 5099) then
						EnhancePack.PetballHotbar = hotbarId
						EnhancePack.PetballSlot= slot
						EnhancePack.PetballSubIndex = 0
						EnhancePack.PetballAction = actionId
						EnhancePack.TargetMount()
					else
					
						local speechText = ActionsWindow.ActionData[actionId].callback
						UserActionSpeechSetText(hotbarId, slot, 0, speechText)				   
					end
				end
			end
		end
	elseif( slot == Hotbar.CurrentUseSlot and hotbarId == Hotbar.CurrentUseHotbar ) then
		Hotbar.UseSlot(hotbarId, slot)
	end
end

function Hotbar.ContextMenuCallback(returnCode,param)
	if( string.find(returnCode, "minitxt") ) then
		
		local num = string.gsub(returnCode, "minitxt", "")
		num = tonumber(num)
		local element = "Hotbar"..param.HotbarId.."Button"..param.ItemIndex
		CustomSettings.SaveNumber( element .. "Custom", num )
		--local iconId = UserActionGetIconId(param.HotbarId, param.ItemIndex, param.SubIndex)
		--HotbarSystem.SetHotbarIcon(element, iconId)
		DynamicImageSetTexture( element .."SquareIconBG", MiniTexturePack.DB[num].texture .. "Icon", 0, 0 )	
		LabelSetTextColor(element.."StatsTop", MiniTexturePack.DB[num].PaperdollLabelColor.r, MiniTexturePack.DB[num].PaperdollLabelColor.g, MiniTexturePack.DB[num].PaperdollLabelColor.b)
		LabelSetTextColor(element.."StatsBottom", MiniTexturePack.DB[num].PaperdollLabelColor.r, MiniTexturePack.DB[num].PaperdollLabelColor.g, MiniTexturePack.DB[num].PaperdollLabelColor.b)
		LabelSetTextColor(element.."Stats", MiniTexturePack.DB[num].PaperdollLabelColor.r, MiniTexturePack.DB[num].PaperdollLabelColor.g, MiniTexturePack.DB[num].PaperdollLabelColor.b)
	
		return
	elseif( string.find(returnCode, "enchant") ) then
		local num = string.gsub(returnCode, "enchant", "")
		EnhancePack.ForceEnchant = tonumber(num)
		CustomSettings.SaveNumber( "ForceEnchant", EnhancePack.ForceEnchant )
	elseif( returnCode == "fade" ) then
		CustomSettings.SaveBoolean( "Hotbar"..param.HotbarId.. "Fade",true )
		Hotbar.HideBar("Hotbar"..param.HotbarId)
	elseif( returnCode == "unfade" ) then
		CustomSettings.SaveBoolean( "Hotbar"..param.HotbarId.. "Fade",false )
		Hotbar.ShowBar("Hotbar"..param.HotbarId)
	elseif( returnCode == "setQuick" ) then
		EnhancePack.ToggleableHotbar = param.HotbarId
		CustomSettings.SaveNumber( "EnhancePackToggleableHotbar", EnhancePack.ToggleableHotbar  )
		WindowSetShowing("Hotbar"..param.HotbarId, false)
		Hotbar.SetLocked(param.HotbarId, true)
		
		WindowSetShowing("Hotbar" .. param.HotbarId.."HorizHandle", false)
		WindowSetShowing("Hotbar" .. param.HotbarId.."VertHandle", false)
	
		WindowSetShowing("Hotbar" .. param.HotbarId .. "MaximizeButtonV" , false)
		WindowSetShowing("Hotbar" .. param.HotbarId .. "MaximizeButtonH" , false)
		WindowSetShowing("Hotbar" .. param.HotbarId .. "MinimizeButtonV" , false)
		WindowSetShowing("Hotbar" .. param.HotbarId .. "MinimizeButtonH" , false)
		return
	elseif( returnCode == "unsetQuick" ) then
		Hotbar.ToggleQuickHotbar()
		EnhancePack.ToggleableHotbar = 0
		CustomSettings.SaveNumber( "EnhancePackToggleableHotbar", 0 )
		Hotbar.SetLocked(param.HotbarId, false)
		WindowSetShowing("Hotbar"..param.HotbarId, true)
		Hotbar.ReloadHotbar(param.HotbarId)
		return
	end
	if( param ~= nil ) then
		local bHandled = HotbarSystem.ContextMenuCallback(returnCode,param) 
		if( string.find(returnCode,"org") ) then
			local id = string.gsub(returnCode, "org", "")
			Organizer.ActiveOrganizer = tonumber(id)
			CustomSettings.SaveNumber( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )
		end
		
		
		
		-- if it wasnt handled then check for hotbar specific options
		if( bHandled == false ) then	
		
			if( returnCode == "allowDrag" ) then
				local element = "Hotbar"..param.HotbarId.."Button"..param.ItemIndex .. "AllowDrag"
				CustomSettings.SaveBoolean( element, not CustomSettings.LoadBoolean( element, false )  )
			elseif( returnCode == HotbarSystem.ContextReturnCodes.CLEAR_ITEM ) then
				HotbarSystem.ClearActionIcon(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex, true)
				local element = "Hotbar"..param.HotbarId.."Button"..param.ItemIndex
				if (EnhancePack.PropsSlot and param.HotbarId == EnhancePack.PropsSlot.HotbarID and param.ItemIndex == EnhancePack.PropsSlot.SlotID) then
					EnhancePack.PropsSlot = nil
					CustomSettings.DeleteSetting( "EnhancePackPropsSlotHotbarID" )
					CustomSettings.DeleteSetting( "EnhancePackPropsSlotSlotID" )
					ActionsWindow.UpdateIcons()
				end
				--HotbarSystem.FeintSlots[element] = nil
				LabelSetText(element.."BandageTime", L"")
				HotbarClearItem(param.HotbarId,param.ItemIndex)
				CustomSettings.DeleteSetting( element .. "Custom" )
				local elementDrag = "Hotbar"..param.HotbarId.."Button"..param.ItemIndex .. "AllowDrag"
				CustomSettings.DeleteSetting( elementDrag )
			elseif( returnCode == HotbarSystem.ContextReturnCodes.ASSIGN_KEY ) then
				WindowClearAnchors("AssignHotkeyInfo")
				WindowAddAnchor("AssignHotkeyInfo","topright","Hotbar"..param.HotbarId.."Button"..param.Slot,"bottomleft",0,-6)
				WindowSetShowing("AssignHotkeyInfo",true)
			
				Hotbar.RecordingSlot = param.Slot
				Hotbar.RecordingHotbar = param.HotbarId
				Hotbar.RecordingKey = true
				BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
			elseif( returnCode == HotbarSystem.ContextReturnCodes.NEW_HOTBAR ) then
				HotbarSystem.SpawnNewHotbar()
			elseif( returnCode == HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR ) then
                local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() HotbarSystem.DestroyHotbar(param.HotbarId) end }
                local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL }
                
				local DestroyConfirmWindow = 
				{
				    windowName = "Hotbar"..param.HotbarId,
					titleTid = HotbarSystem.TID_DESTROY_HOTBAR,
					bodyTid = HotbarSystem.TID_DESTROY_CONFIRM,
					buttons = { okayButton, cancelButton }
				}
					
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
			elseif( returnCode == HotbarSystem.ContextReturnCodes.LOCK_HOTBAR) then
				Hotbar.SetLocked(param.HotbarId, not SystemData.Hotbar[param.HotbarId].Locked)
			end	
		end
		
	end
end

function Hotbar.ItemRButtonUp()
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	local param = {Slot=slot,HotbarId=hotbarId}	
	
	--Debug.Print("Hotbar.ItemRButtonUp hotbarId: "..hotbarId.." slot: " .. slot)
	
	if SystemData.Hotbar[hotbarId].Locked then
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_UNLOCK_HOTBAR,0,HotbarSystem.ContextReturnCodes.LOCK_HOTBAR,param)
	else
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_LOCK_HOTBAR,0,HotbarSystem.ContextReturnCodes.LOCK_HOTBAR,param)
	end
	
	ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_NEW_HOTBAR,0,HotbarSystem.ContextReturnCodes.NEW_HOTBAR,param)
	
	if( hotbarId ~= HotbarSystem.STATIC_HOTBAR_ID ) then
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_DESTROY_HOTBAR,0,HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR,param)
	end
	
	if( hotbarId ~= EnhancePack.ToggleableHotbar or EnhancePack.ToggleableHotbar == 0 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 992),0,"setQuick", param,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 993),0,"unsetQuick", param,false)
	end
	
	local fade = CustomSettings.LoadBoolean( "Hotbar"..hotbarId .. "Fade",false )
	if( fade) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5008),0,"unfade", param,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5007),0,"fade", param,false)
	end
	
	local actionId = UserActionGetId(hotbarId,slot,0)
	
		ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_ASSIGN_HOTKEY,0,HotbarSystem.ContextReturnCodes.ASSIGN_KEY,param)

	local itemIndex = slot
	
	if( HotbarHasItem(hotbarId,itemIndex) == true ) then
		local slotWindow = "Hotbar"..hotbarId.."Button"..slot
		HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, 0, slotWindow)
	end
	
	ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallback)
end

function Hotbar.ShowBar(windowName)
	WindowStopAlphaAnimation(windowName)
	local alpha = CustomSettings.LoadNumber( windowName.."ALP", -5 )
	if (alpha ~= nil and alpha ~= -5) then
		WindowSetAlpha(windowName, alpha)
	else
		WindowSetAlpha(windowName, 1)
	end
end

function Hotbar.HideBar(windowName)
	if CustomSettings.LoadBoolean( windowName.. "Fade",false ) then
		local alpha = CustomSettings.LoadNumber( windowName.."ALP", -5 )
		if (alpha == nil or alpha == -5) then
			alpha = 1
		end
		WindowStartAlphaAnimation(windowName, Window.AnimationType.SINGLE_NO_RESET, alpha, 0.01, 2, false, 1, 1 )
	end
end

function Hotbar.ItemMouseOverEnd()
	Hotbar.HideBar(WindowGetParent(SystemData.ActiveWindow.name))
	ItemProperties.ClearMouseOverItem()
end

function Hotbar.HandleMouseOver()
	local this = SystemData.ActiveWindow.name
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	Hotbar.ShowBar("Hotbar" .. hotbarId)
end

-- OnMouseOver Handler
function Hotbar.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(this)
	local itemIndex = slot
	local actionId = UserActionGetId(hotbarId,itemIndex,0)
	local type = UserActionGetType(hotbarId, itemIndex, 0)

	Hotbar.ShowBar("Hotbar" .. hotbarId)
	local actionType = SystemData.UserAction.TYPE_NONE
		-- default id to the slot so it shows the item properties when there is only a binding
		local itemId = slot
		
		local bindingText = L""
		if( SystemData.Hotbar[hotbarId] ~= nil) then
			bindingText = bindingText..SystemData.Hotbar[hotbarId].Bindings[slot]
			if bindingText ~= L"" then
				local patt = WStringToString(bindingText)
				local texto = string.find(patt , "OEM_102")
				if ( texto ~= nil ) then
					patt = string.gsub(patt, "OEM_102", "<")
				end
			
				bindingText = GetStringFromTid(Hotbar.TID_BINDING)..L" "..StringToWString(patt) -- "Binding:"..L" "..<KEY>
			end
		end
		
		if( HotbarHasItem(hotbarId,itemIndex) == true ) then
			actionType = UserActionGetType(hotbarId,itemIndex,0)
			
			if( actionId ~= 0 ) then
				itemId = actionId
			end

			-- if its a macro reference, we need to dereference it
			if( actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
				local macroId = UserActionGetId(hotbarId,itemIndex,0)
				local macroIndex = MacroSystemGetMacroIndexById(macroId)
				actionType = SystemData.UserAction.TYPE_MACRO
				hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID -- - 1000 -- ???
				itemIndex = macroIndex
			end
		end

		if( actionType == SystemData.UserAction.TYPE_SKILL ) then
			bindingText = SkillsWindow.FormatSkillValue(WindowData.SkillDynamicData[itemId].RealSkillValue)..L"%\n"..bindingText -- Tack on the formatted skill level.
			
			-- NOTE: Need to fix this. Id 0 is also a null check, so no tooltip for Alchemy
			itemId = itemId + 1
		end	
		
		if(actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
			bindingText = L""		
		end	
					
		local type = actionType
		local idC = itemId

		local notarget = false
		if (type == SystemData.UserAction.TYPE_SPELL and SpellsInfo) then
			for no, value in pairs(SpellsInfo.SpellsData) do
				if value.id == idC then
					notarget = value.notarget
					break
				end
			end
		end
		
		if type == SystemData.UserAction.TYPE_SKILL and idC ~= 9 then
			noSelf=true
		end
		
		if type == SystemData.UserAction.TYPE_SKILL and (idC ~= 46 or idC ~= 32 or idC ~= 56 or idC ~= 38 or idC ~= 21 or idC ~= 47) then -- meditation, spirit speak, imbuing, tracking, hiding, stealth
			notarget=true
		end
	
		local targetText = L""
		if ( ( UserActionHasTargetType(hotbarId,itemIndex,0) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false ) and not notarget ) then
			local targetType = UserActionGetTargetType(hotbarId,itemIndex,0)
			targetText = GetStringFromTid(Hotbar.TID_TARGET) -- "Target:"
			if targetType == 1 then -- Current
				targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURRENT)
			elseif targetType == 2 then -- Cursor
				targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURSOR)
			elseif targetType == 3 then -- Self
				targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_SELF)
			elseif targetType == 4 then -- Object Id
				targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_OBJECT_ID)
			else
				targetText = L"" -- Bad case; forget about it.
			end
		end
		
	if (actionId and ((actionId > 5000 and actionId < 20000) or (actionId == 53 or actionId == 54 or actionId == 50)) and 
	(actionType ~= SystemData.UserAction.TYPE_SKILL and actionType ~= SystemData.UserAction.TYPE_SPELL  and actionType ~= SystemData.UserAction.TYPE_USE_ITEM)
	) then
		local actionData = ActionsWindow.ActionData[actionId]

		local name = L""
		if (actionData.nameTid) then
			name = GetStringFromTid(actionData.nameTid)
		else
			name = actionData.nameString
		end
		local desc = L""
		if (not actionData.detailTid) then
			desc = actionData.detailString
		else
			desc = GetStringFromTid(actionData.detailTid)
		end
		local itemData
		if (actionId == 5015) then
			local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	
			if backpackId ~= 0 then
				itemData = {
					windowName = "Hotbar"..hotbarId,
					itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
					itemId = backpackId,
					itemType = WindowData.ItemProperties.TYPE_ITEM,
					binding = bindingText, -- As defined above
				}
				ItemProperties.SetActiveItem(itemData)
			end
		else
			if (actionId == 10018) then
				local name = L"Organizer " .. Organizer.ActiveOrganizer
				if (Organizer.Organizers_Desc[Organizer.ActiveOrganizer] ~= L"") then
					name = Organizer.Organizers_Desc[Organizer.ActiveOrganizer]
				end
				desc = desc .. L"\n\n"..UI.GetCliloc(SystemData.Settings.Language.type, 851) ..name
			end
			itemData =
			{
				windowName = "Hotbar"..hotbarId,
				itemId = actionId,
				detail = ItemProperties.DETAIL_LONG,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
				binding = bindingText, -- As defined above
				title =	name,
				body = desc
				
			}	
		end
		ItemProperties.SetActiveItem(itemData)	
	else
		
		local qtaLbl = "Hotbar".. hotbarId .. "Button" ..slot .."Quantity"
		local qta = nil
		if (DoesWindowNameExist(qtaLbl)) then
			qta = LabelGetText(qtaLbl)
		end

		local detailType = ItemProperties.DETAIL_SHORT
		if(SystemData.Settings.Interface.showTooltips) then
			detailType = ItemProperties.DETAIL_LONG
		end
		local itemType = WindowData.ItemProperties.TYPE_ACTION
		if( type == SystemData.UserAction.TYPE_USE_ITEM )  then
			itemType = WindowData.ItemProperties.TYPE_ITEM
	    end
	    local itemData
	    --if (qta and tonumber(qta) == 1) then
		local id = itemId
		if (type == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then
			id = UserActionGetNextObjectId(itemId)
		end
		if(DoesPlayerHaveItem(id)) then
			itemData = { windowName = "Hotbar"..hotbarId,
							itemId = id,
							itemType = WindowData.ItemProperties.TYPE_ITEM,
							detail = ItemProperties.DETAIL_LONG,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							binding = bindingText, -- As defined above
							myTarget = targetText, }
		else

			itemData = { windowName = "Hotbar"..hotbarId,
							itemId = itemId,
							itemType = itemType,
							actionType = actionType,
							detail = detailType,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							binding = bindingText, -- As defined above
							myTarget = targetText, }
		end
		if (DoesWindowNameExist("Hotbar"..hotbarId.."Button"..slot.."Disabled" )) then
			if(not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" )) then
				ItemProperties.SetActiveItem(itemData)
			end
		else
			
			ItemProperties.SetActiveItem(itemData)
		end
	end
end

function Hotbar.KeyRecorded()
	if( Hotbar.RecordingKey == true ) then
		Hotbar.RecordingKey = false
		WindowSetShowing("AssignHotkeyInfo",false)
		
		if( SystemData.BindingConflictType ~= SystemData.BindType.BINDTYPE_NONE )then
			body = GetStringFromTid( Hotbar.TID_BINDING_CONFLICT_BODY )..L"\n\n"..HotbarSystem.GetKeyName(SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType)..L"\n\n"..GetStringFromTid( Hotbar.TID_BINDING_CONFLICT_QUESTION )
			
			local yesButton = { textTid = Hotbar.TID_YES,
								callback =	function()
											HotbarSystem.ReplaceKey(
												SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType,
												Hotbar.RecordingHotbar, Hotbar.RecordingSlot, SystemData.BindType.BINDTYPE_HOTBAR,
												SystemData.RecordedKey, SystemData.RecordedKeySmallDisplay)
											end
							  }
			local noButton = { textTid = Hotbar.TID_NO }
			local windowData = 
			{
				windowName = "Hotbar", 
				titleTid = Hotbar.TID_BINDING_CONFLICT_TITLE, 
				body = body, 
				buttons = { yesButton, noButton }
			}
			UO_StandardDialog.CreateDialog( windowData )
	    else
            SystemData.Hotbar[Hotbar.RecordingHotbar].Bindings[Hotbar.RecordingSlot] = SystemData.RecordedKey
	        SystemData.Hotbar[Hotbar.RecordingHotbar].BindingDisplayStrings[Hotbar.RecordingSlot] = SystemData.RecordedKeySmallDisplay

	        HotbarUpdateBinding(Hotbar.RecordingHotbar,Hotbar.RecordingSlot,SystemData.RecordedKey)
	        local element = "Hotbar"..Hotbar.RecordingHotbar.."Button"..Hotbar.RecordingSlot
	        HotbarSystem.UpdateBinding(element,SystemData.RecordedKeySmallDisplay,SystemData.RecordedKey )
		end
	end
end

function Hotbar.KeyCancelRecord()
	if( Hotbar.RecordingKey == true ) then
		Hotbar.RecordingKey = false
		WindowSetShowing("AssignHotkeyInfo",false)
	end
end

function Hotbar.OnResizeBegin()
	this = WindowUtils.GetActiveDialog()
	local hotbarId = WindowGetId(this)
	if not SystemData.Hotbar[hotbarId].Locked and not CustomSettings.LoadBoolean( this .. "LockWithHandle", false ) then
		local width, height = WindowGetDimensions(this)
		local widthMin = 70
		local heightMin = 70
		if (width >= height) then
			heightMin = 50
		else
			widthMin = 50
		end
		WindowUtils.BeginResize( this, "topleft", widthMin, heightMin, false, Hotbar.OnResizeEnd)
	end
end

function Hotbar.OnResizeEnd(curWindow)
	if (EnhancePack) then
		local closed = CustomSettings.LoadBoolean( curWindow.. "Closed",false )
		if (closed) then
			return
		end
	end
	local width, height = WindowGetDimensions(curWindow)
	
	--Debug.Print("Hotbar.OnResizeEnd: "..curWindow.." width: "..width..", height: "..height)
	
	local hotbarId = WindowGetId(curWindow)
	local locked = SystemData.Hotbar[hotbarId].Locked
	
	-- used to compensate for larger hotbar window size caused by a visible handle
	local handleOffset = locked and 0 or Hotbar.HANDLE_OFFSET
	
	if( width >= height ) then
		-- show the correct handle if not locked
		if not EnhancePack or hotbarId ~= EnhancePack.ToggleableHotbar then
			WindowSetShowing("Hotbar" .. hotbarId.."HorizHandle", not locked)
			WindowSetShowing("Hotbar" .. hotbarId.."VertHandle", false)
		
			WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonV" , false)
			WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonH" , false)
			WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonV" , false)
			WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonH" , true)
		end
		
		-- anchor the first button to the handle if not locked (otherwise anchors the button to the hotbar's top left)
		WindowClearAnchors(curWindow.."Button"..1)
		local shift = 0
		if (EnhancePack and EnhancePack.HotbarNoSpace) then
			shift = 20
		end
		if locked then
			WindowAddAnchor(curWindow.."Button"..1,"topleft",curWindow,"topleft",shift,0)
		else
			WindowAddAnchor(curWindow.."Button"..1,"topright",curWindow.."HorizHandle","topleft",0,0)
		end
		
		-- anchor the rest of the buttons to the previous one
		-- and hide the ones that are outside the window
		for slot=2, Hotbar.NUM_BUTTONS do
			local button = curWindow.."Button"..slot
			if( (slot * Hotbar.BUTTON_SIZE) > (width + handleOffset) ) then
				WindowSetShowing(button, false)
			else
				local relativeTo = curWindow.."Button"..(slot-1)
				WindowClearAnchors(button)
				WindowAddAnchor(button,"topright",relativeTo,"topleft",0,0)			
				WindowSetShowing(button, true)
			end
		end
	
		local numVisibleButtons = math.min(math.floor((width+handleOffset)/Hotbar.BUTTON_SIZE),Hotbar.NUM_BUTTONS)
		local newHeight = Hotbar.BUTTON_SIZE
		local newWidth = math.min((numVisibleButtons * Hotbar.BUTTON_SIZE) + handleOffset, (Hotbar.BUTTON_SIZE * Hotbar.NUM_BUTTONS) + handleOffset)
		if (locked and (EnhancePack and EnhancePack.HotbarNoSpace)) then
			newWidth = width
		end
		WindowSetDimensions(curWindow,newWidth,newHeight)
		
	else
		-- show the correct handle if not locked
		if not EnhancePack or hotbarId ~= EnhancePack.ToggleableHotbar then
			WindowSetShowing("Hotbar" .. hotbarId.."HorizHandle",false)
			WindowSetShowing("Hotbar" .. hotbarId.."VertHandle", not locked)
			WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonV" , false)
			WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonH" , false)
			WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonH" , false)
			WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonV" , true)
		end
		
		-- anchor the first button to the handle if not locked
		WindowClearAnchors(curWindow.."Button"..1)
		local shift = 0
		if (EnhancePack and EnhancePack.HotbarNoSpace) then
			shift = 20
		end
		if locked then
			WindowAddAnchor(curWindow.."Button"..1,"topright",curWindow,"topright",0,shift)
		else
			WindowAddAnchor(curWindow.."Button"..1,"bottomright",curWindow.."VertHandle","topright",0,0)
		end
		
		-- anchor the rest of the buttons to the previous one
		-- and hide the ones that are outside the window
		for slot=2, Hotbar.NUM_BUTTONS do
			local button = curWindow.."Button"..slot
			if( (slot * Hotbar.BUTTON_SIZE) > (height + handleOffset) ) then
				WindowSetShowing(button, false)
			else
				local relativeTo = curWindow.."Button"..(slot-1)
				WindowClearAnchors(button)
				WindowAddAnchor(button,"bottomleft",relativeTo,"topleft",0,0)			
				WindowSetShowing(button, true)
			end
		end

		local numVisibleButtons = math.floor((height+handleOffset)/Hotbar.BUTTON_SIZE)
		local newHeight = math.min((numVisibleButtons * Hotbar.BUTTON_SIZE) + handleOffset, (Hotbar.BUTTON_SIZE * Hotbar.NUM_BUTTONS) + handleOffset)
		local newWidth = Hotbar.BUTTON_SIZE
		if (locked and (EnhancePack and EnhancePack.HotbarNoSpace)) then
			newHeight = height
		end
		WindowSetDimensions(curWindow,newWidth,newHeight)	
		
	end
	if locked then
		WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonV" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MaximizeButtonH" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonV" , false)
		WindowSetShowing("Hotbar" .. hotbarId .. "MinimizeButtonH" , false)
	end
	if (EnhancePack and not CustomSettings.LoadBoolean( curWindow .. "ReverseText", false ) ) then
		WindowSetShowing(curWindow .. "NameVrev", false)
		WindowSetShowing(curWindow .. "NameHrev", false)
		if (width < height) then
			WindowSetShowing(curWindow .. "NameV", false)
			WindowSetShowing(curWindow .. "NameH", true)
		else
			WindowSetShowing(curWindow .. "NameV", true)
			WindowSetShowing(curWindow .. "NameH", false)
		end
	else
		WindowSetShowing(curWindow .. "NameV", false)
		WindowSetShowing(curWindow .. "NameH", false)
		if (width < height) then
			WindowSetShowing(curWindow .. "NameVrev", false)
			WindowSetShowing(curWindow .. "NameHrev", true)
		else
			WindowSetShowing(curWindow .. "NameVrev", true)
			WindowSetShowing(curWindow .. "NameHrev", false)
		end
	end
	
	local button = "Hotbar" .. hotbarId .."ResizeButton"
	if (CustomSettings and CustomSettings.LoadBoolean( "Hotbar" .. hotbarId .. "LockWithHandle", false ) or locked) then
		WindowSetShowing(button, false)
	else
		WindowSetShowing(button, true)
	end
end

function Hotbar.OnHandleLButtonDown(flags, x, y)
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	if (hotbarId == 1000) then
		return
	end
	if not SystemData.Hotbar[hotbarId].Locked and not CustomSettings.LoadBoolean( "Hotbar" .. hotbarId .. "LockWithHandle", false ) then
		hotbarWindow = WindowGetParent(SystemData.ActiveWindow.name)
		SnapUtils.StartWindowSnap( hotbarWindow )
	end
end
