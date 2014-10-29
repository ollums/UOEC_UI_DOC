----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ClockWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

ClockWindow.MouseOverEnd = false
ClockWindow.AlphaDiff = 0.006
ClockWindow.Alpha = 0.6
ClockWindow.RunningTime = 0
ClockWindow.ClockEnabled= false


----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
-- TODO: Ich muss noch die Farben einbinden.
	  -- Testen müssen wir das Ding auch noch.
	  -- LabelSetTextColor einbinden


function ClockWindow.Initialize()
	local parent = "ClockWindow"
	WindowSetAlpha( parent.."WindowBackground", ClockWindow.Alpha )
	WindowSetShowing(parent.."WindowBackground", false)
	WindowSetShowing(parent.."Frame", false)
	--ColorPicker
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
	CreateWindowFromTemplate( "ClockColorPicker", "ColorPickerWindowTemplate", "Root" )
	WindowSetShowing("ClockColorPicker", false)
	WindowSetLayer( "ClockColorPicker", Window.Layers.SECONDARY	)
	ColorPickerWindow.SetNumColorsPerRow(9)
	ColorPickerWindow.SetSwatchSize(30)
	ColorPickerWindow.SetWindowPadding(4,4)
	ColorPickerWindow.SetFrameEnabled(true)
	ColorPickerWindow.SetCloseButtonEnabled(true)
	ColorPickerWindow.SetColorTable(hueTable,"ClockColorPicker")
	ColorPickerWindow.DrawColorTable("ClockColorPicker")
	--restore Settings
	WindowUtils.RestoreWindowPosition(parent)
	ClockWindow.GetClock()
	ClockWindow.ReloadSettings()
	SnapUtils.SnappableWindows["ClockWindow"] = true
end

function ClockWindow.GetClock()
	-- Create Textlog to get Clock into Lua
	TextLogCreateWithLimit("Timerlog", 10)
	TextLogSetEnabled("Timerlog", true)
	TextLogAddEntry("Timerlog", nil, L"Lets get the clock")
	local timestamp, filterType, entryText = TextLogGetEntry( "Timerlog", 0)
	local tempstring = tostring(timestamp)
	EnhancePack.Clock.h = tonumber(string.sub(tempstring , 2,3))
	EnhancePack.Clock.m = tonumber(string.sub(tempstring , 5,6))
	EnhancePack.Clock.s = tonumber(string.sub(tempstring , 8,9))
	TextLogDestroy("Timerlog")
end

function ClockWindow.OnRClick()
	--Context Menue
	--ContextMenu.CreateLuaContextMenuItemWithString(str,flags,returnCode,param,pressed,subMenuOptions,subMenuDelay,textColor)
	if (ClockWindow.Locked == false) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 290),0,"Lock",0,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 289),0,"Unlock",0,false)
	end
	local subMenu = {{ str=L"24h", flags=0, returnCode="24", param=1,pressed= not ClockWindow.Twelve},{ str=L"12h", flags=0, returnCode="12", param=1,pressed= ClockWindow.Twelve},{ tid=1079312, flags=0, returnCode="Color", param=1}}
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 401),0,1,1, nil, subMenu, nil)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 402),0,"Disable",0,false)
	ContextMenu.ActivateLuaContextMenu(ClockWindow.ContextMenuCallback)
end

function ClockWindow.OnMouseDrag()
	if (not ClockWindow.Locked ) then
		SnapUtils.StartWindowSnap("ClockWindow")
		WindowSetMoving("ClockWindow",true)
	else
		WindowSetMoving("ClockWindow",false)
	end

end

function ClockWindow.ContextMenuCallback( returnCode, param )
	--Context Callback
	if (returnCode == "Lock") then
		ClockWindow.Locked = true
		CustomSettings.SaveBoolean( "ClockWindowLocked", ClockWindow.Locked)
	end
	if (returnCode == "Unlock") then
		ClockWindow.Locked = false
		CustomSettings.SaveBoolean( "ClockWindowLocked", ClockWindow.Locked)
	end
	if (returnCode == "12") then
		ClockWindow.Twelve = true
		CustomSettings.SaveBoolean( "ClockWindowTwelve", ClockWindow.Twelve )
	end
	if (returnCode == "24") then
		ClockWindow.Twelve = false
		CustomSettings.SaveBoolean( "ClockWindowTwelve", ClockWindow.Twelve )	
	end
	if (returnCode =="Disable") then
		local DisableClock = 
			{
				windowName = "DisableClock",
				title = UI.GetCliloc(SystemData.Settings.Language.type, 399),
				body= UI.GetCliloc(SystemData.Settings.Language.type, 400),
			}
		UO_StandardDialog.CreateDialog(DisableClock)
		ClockWindow.ClockEnabled = false
		CustomSettings.SaveBoolean( "ShowClock", ClockWindow.ClockEnabled )
		ButtonSetPressedFlag( "SettingsPincoClockButton", ClockWindow.ClockEnabled )
	end
	if (returnCode =="Color") then
		ColorPickerWindow.SetAfterColorSelectionFunction(ClockWindow.ColorPicked)
		WindowClearAnchors( "ClockColorPicker" )
		WindowAddAnchor( "ClockColorPicker", "topleft", "ClockWindowClock", "topleft", 0, 25)
		WindowSetShowing( "ClockColorPicker", true )
		ColorPickerWindow.SelectColor("ClockColorPicker", ClockWindow.Clockcolor)
	end
	ClockWindow.ReloadSettings()
end

function ClockWindow.ColorPicked()
	--Set Color of the clock
	local red, green, blue, alpha
	local huePicked = ColorPickerWindow.colorSelected["ClockColorPicker"]
	red, green, blue, alpha  = HueRGBAValue(huePicked)
	LabelSetTextColor("ClockWindowClock", red, green, blue)
	ClockWindow.Clockcolor = huePicked
	CustomSettings.SaveNumber( "ClockColor", ClockWindow.Clockcolor )

end

function ClockWindow.ReloadSettings()
	ClockWindow.Locked = CustomSettings.LoadBoolean( "ClockWindowLocked", false )
	ClockWindow.Twelve = CustomSettings.LoadBoolean( "ClockWindowTwelve", false )
	ClockWindow.ClockEnabled = CustomSettings.LoadBoolean( "ShowClock", false )
	ClockWindow.Clockcolor = CustomSettings.LoadNumber( "ClockColor", 0 )
	--Lock Status and Disable Status
	WindowSetShowing("ClockWindow", ClockWindow.ClockEnabled)
	WindowSetMovable("ClockWindow", not ClockWindow.Locked)
	--TODO: Include this Setting into Settings Window of Lucis new SA interface
	--Color
	local red, green, blue, alpha =	HueRGBAValue(ClockWindow.Clockcolor)
	LabelSetTextColor("ClockWindowClock", red, green, blue)
	--24/12 Settings fit the label to center
	if(ClockWindow.Twelve == true) then
		WindowClearAnchors("ClockWindowClock")
		WindowAddAnchor("ClockWindowClock","topleft","ClockWindow","topleft",10,12)
	else
		WindowClearAnchors("ClockWindowClock")
		WindowAddAnchor("ClockWindowClock","topleft","ClockWindow","topleft",25,12)
	end	
end

function ClockWindow.OnMouseOver()
	local parent = "ClockWindow"
	--only if the window is not locked
	if (ClockWindow.Locked == false) then
		ClockWindow.MouseOver = false
		ClockWindow.Alpha = 0.6
		WindowSetAlpha(parent.."WindowBackground", ClockWindow.Alpha )
		WindowSetAlpha(parent.."Frame", 1 )
		WindowSetShowing(parent.."WindowBackground", true)
		WindowSetShowing(parent.."Frame", true)
	end
end

function ClockWindow.MouseOverEnd()
	local parent = "ClockWindow"
	ClockWindow.MouseOver = true
end


function ClockWindow.Update(updateTimePassed)
	local parent = "ClockWindow"
	--Update Clock
	
	--	Debug.Print("Die aktuelle Uhrzeit ist: "..tostring(EnhancePack.Clock.h).." : "..tostring(EnhancePack.Clock.m).." : "..tostring(EnhancePack.Clock.s))
	--  Label
		local clockhstr = 0
		local clockmstr = 0
		local clocksstr = 0
	-- 24h/12h Setting
		if (ClockWindow.Twelve == true) then
			if( EnhancePack.Clock.h > 12) then
				local clockhstrtwlv = EnhancePack.Clock.h - 12
				if( clockhstrtwlv < 10) then
					clockhstr = "0"..tostring(clockhstrtwlv)
				else
					clockhstr = tostring(clockhstrtwlv)
				end
			else
				if( EnhancePack.Clock.h < 10) then
					clockhstr = "0"..tostring(EnhancePack.Clock.h)
				else
					clockhstr = tostring(EnhancePack.Clock.h)
				end
			end
		else
			if( EnhancePack.Clock.h < 10) then
				clockhstr = "0"..tostring(EnhancePack.Clock.h)
			else
				clockhstr = tostring(EnhancePack.Clock.h)
			end
		end
		if( EnhancePack.Clock.m < 10) then
			clockmstr = "0"..tostring(EnhancePack.Clock.m)
		else
			clockmstr = tostring(EnhancePack.Clock.m)
		end
		if( EnhancePack.Clock.s < 10) then
			clocksstr = "0"..tostring(EnhancePack.Clock.s)
		else
			clocksstr = tostring(EnhancePack.Clock.s)
		end
		local clockstring = clockhstr.." : "..clockmstr.." : "..clocksstr
		--24/12 am pm
		if (ClockWindow.Twelve == true) then
			if(EnhancePack.Clock.h > 12) then
				clockstring = clockstring.." pm"
			else
				clockstring = clockstring.." am"
			end	
		end
		local clockwstring = StringToWString(clockstring)
		LabelSetText("ClockWindowClock", clockwstring)
		--Statistics Window
		

			
	
	--Aplha Fadeout
	if(ClockWindow.MouseOver == true) then
		ClockWindow.Alpha = ClockWindow.Alpha - ClockWindow.AlphaDiff
		if(ClockWindow.Alpha <= 0) then
			ClockWindow.Alpha = 0
			WindowSetShowing(parent.."WindowBackground", false)
			WindowSetShowing(parent.."Frame", false)
			ClockWindow.MouseOver = false
		else
			WindowSetAlpha(parent.."WindowBackground", ClockWindow.Alpha )
			WindowSetAlpha(parent.."Frame", ClockWindow.Alpha )
		end
	end
	--Update clock every hour to get the correct time
	ClockWindow.RunningTime = ClockWindow.RunningTime + updateTimePassed
	if (ClockWindow.RunningTime >= 3600) then
		ClockWindow.GetClock()
		ClockWindow.RunningTime = 0
	end
	
end



function ClockWindow.Shutdown()
	WindowUtils.SaveWindowPosition("ClockWindow")
	 SnapUtils.SnappableWindows["ClockWindow"] = nil
end
