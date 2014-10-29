----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ServerLine = {}
ServerLine.Scale = 0

ServerLine.delta = 0
ServerLine.CurrentMap = 0
----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------




function ServerLine.Initialize()
	SnapUtils.SnappableWindows["ServerLine"] = true
	WindowUtils.RestoreWindowPosition("ServerLine")
	if (WindowData.PlayerLocation.facet == 0 ) then
		ServerLine.CurrentMap = 0
		DynamicImageSetTexture( "ServerLineBackground", "ServerLinesFel", 0, 3 )
	else
		ServerLine.CurrentMap = 1
		DynamicImageSetTexture( "ServerLineBackground", "ServerLinesTram", 0, 3 )
	end
	local x, y = WindowGetDimensions( "ServerLineBackground" )
	WindowSetDimensions("ServerLineBackground", x, y-3)
	EnhancePack.LoadScale( "ServerLine" )
	
	
	WindowClearAnchors("ServerLineDot")
    WindowAddAnchor("ServerLineDot", "topleft", "ServerLine", "center", 10, 10)
    local iconId = 100022
    local iconTexture, x, y = GetIconData(iconId)
    local iconWidth, iconHeight = UOGetTextureSize("icon"..iconId)
    iconScale = 1.0
    WindowSetDimensions("ServerLineDot", iconWidth* iconScale, iconHeight* iconScale)
    DynamicImageSetTextureDimensions("ServerLineDot", iconWidth, iconHeight)
    DynamicImageSetTexture("ServerLineDot", iconTexture, x, y)
    if (EnhancePack.ServerLine) then
		WindowSetShowing("ServerLine", EnhancePack.ServerLine)
	end
end

function ServerLine.Shutdown()
	SnapUtils.SnappableWindows["ServerLine"] = nil
	WindowUtils.SaveWindowPosition("ServerLine")
end

function ServerLine.OnLButtonDown()
	SnapUtils.StartWindowSnap("ServerLine")
end

function ServerLine.OnRClick(flags,x,y)
	EnhancePack.ServerLine = false
	CustomSettings.SaveBoolean( "EnhancePackServerLine", EnhancePack.ServerLine )
	ButtonSetPressedFlag( "SettingsPincoServerLinesButton", EnhancePack.ServerLine )
	WindowSetShowing("ServerLine", false )
	EnhancePack.ReloadSettings()
end

function ServerLine.Update( timePassed )
	ServerLine.delta = ServerLine.delta + timePassed
	if (WindowData.PlayerLocation.facet ~= ServerLine.CurrentMap) then
		if (WindowData.PlayerLocation.facet == 0 ) then
			ServerLine.CurrentMap = 0
			DynamicImageSetTexture( "ServerLineBackground", "ServerLinesFel", 0, 3 )
		else
			ServerLine.CurrentMap = 1
			DynamicImageSetTexture( "ServerLineBackground", "ServerLinesTram", 0, 3 )
		end
	end
	if (WindowData.PlayerLocation.facet == 0 or WindowData.PlayerLocation.facet == 1) then
		local x = WindowData.PlayerLocation.x / 7.1
		local y = WindowData.PlayerLocation.y / 7.08
		WindowClearAnchors("ServerLineDot")
		WindowAddAnchor("ServerLineDot", "topleft", "ServerLine", "center", x, y)
		WindowSetTintColor("ServerLineDot", 255,0,0)
		WindowSetShowing("ServerLineDot", true)
	else
		WindowSetShowing("ServerLineDot", false)
	end
	
end

function ServerLine.Toggle()
	
	EnhancePack.ServerLine = not EnhancePack.ServerLine
	CustomSettings.SaveBoolean( "EnhancePackServerLine", EnhancePack.ServerLine )
    WindowSetShowing("ServerLine", EnhancePack.ServerLine)
    EnhancePack.ReloadSettings()
    if(EnhancePack.ServerLine) then
		if (WindowData.PlayerLocation.facet ~= ServerLine.CurrentMap) then
			if (WindowData.PlayerLocation.facet == 0 ) then
				ServerLine.CurrentMap = 0
				DynamicImageSetTexture( "ServerLineBackground", "ServerLinesFel", 0, 3 )
			else
				ServerLine.CurrentMap = 1
				DynamicImageSetTexture( "ServerLineBackground", "ServerLinesTram", 0, 3 )
			end
		end
    end
end



