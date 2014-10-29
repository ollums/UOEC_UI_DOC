----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
MapWindow.Big = false

MapWindow.ComboBCK = false
			  
MapWindow.Rotation = 45
MapWindow.ZoomScale = 0.1
MapWindow.IsDragging = false
MapWindow.IsMouseOver = false
MapWindow.TypeEnabled = {}
MapWindow.LegendVisible = false
MapWindow.CenterOnPlayer = true
MapWindow.Tilt = false

MapWindow.WINDOW_WIDTH_MAX = 716
MapWindow.WINDOW_HEIGHT_MAX = 776
MapWindow.MAP_WIDTH_DIFFERENCE = 26
MapWindow.MAP_HEIGHT_DIFFERENCE = 111

MapWindow.LegendItemTextColors = { normal={r=255,g=255,b=255}, disabled={r=80,g=80,b=80} }

MapWindow.Locked = false

-----------------------------------------------------------------
-- MapCommon Helper Functions
-----------------------------------------------------------------

----------------------------------------------------------------
-- Event Functions
----------------------------------------------------------------

function MapWindow.Initialize()
	WindowUtils.RestoreWindowPosition("MapWindow", true)
	WindowSetScale("MapWindow", SystemData.Settings.Interface.customUiScale * 0.80)
	
	
	MapWindow.OnResizeEnd("MapWindow")
	
    -- Static text initialization
    --WindowUtils.SetWindowTitle("MapWindow",GetStringFromTid(MapCommon.TID.Atlas))

    -- Update registration
    RegisterWindowData(WindowData.Radar.Type,0)
    RegisterWindowData(WindowData.WaypointDisplay.Type,0)
    RegisterWindowData(WindowData.WaypointList.Type,0)
    
    WindowRegisterEventHandler("MapWindow", WindowData.Radar.Event, "MapWindow.UpdateMap")
    WindowRegisterEventHandler("MapWindow", WindowData.WaypointList.Event, "MapWindow.UpdateWaypoints")
    
    local isVisible = WindowGetShowing("MapWindow")
    CreateWindow("LegendWindow",isVisible)
    
    ComboBoxClearMenuItems( "MapWindowFacetCombo" )
    for facet = 0, (MapCommon.NumFacets - 1) do
		--Debug.Print("Adding: "..tostring(GetStringFromTid(UORadarGetFacetLabel(facet))))
        ComboBoxAddMenuItem( "MapWindowFacetCombo", GetStringFromTid(UORadarGetFacetLabel(facet)) )
    end


    LabelSetText("MapWindowTiltLabel", UI.GetCliloc(SystemData.Settings.Language.type, 303))
    ButtonSetCheckButtonFlag( "MapWindowTiltButton", true )
    ButtonSetPressedFlag( "MapWindowTiltButton", MapWindow.Tilt )
    
    LabelSetText("MapWindowCenterOnPlayerLabel", GetStringFromTid(1112059))
    ButtonSetCheckButtonFlag( "MapWindowCenterOnPlayerButton", true )
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
    
    WindowSetScale("MapWindowCoordsText", 0.9 * InterfaceCore.scale)
    if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		WindowSetDimensions("MapWindowPlayerCoordsText",250,70)
    end
    WindowSetScale("MapWindowPlayerCoordsText", 0.9 * InterfaceCore.scale)
    
    

	WindowSetScale("MapWindowCenterOnPlayerButton", 0.9 * InterfaceCore.scale)
	WindowSetScale("MapWindowCenterOnPlayerLabel", 0.9 * InterfaceCore.scale)
	WindowSetScale("MapWindowTiltButton", 0.9 * InterfaceCore.scale)
	WindowSetScale("MapWindowTiltLabel", 0.9 * InterfaceCore.scale)
    
    ButtonSetTexture("MapWindowLock", InterfaceCore.ButtonStates.STATE_NORMAL, UI.Lock.texture, UI.Lock.STATE_NORMAL.x , UI.Lock.STATE_NORMAL.y)
	ButtonSetTexture("MapWindowLock",InterfaceCore.ButtonStates.STATE_PRESSED, UI.Lock.texture, UI.Lock.STATE_PRESSED.x, UI.Lock.STATE_PRESSED.y)
	ButtonSetTexture("MapWindowLock", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_NORMAL_HIGHLITE.x, UI.Lock.STATE_NORMAL_HIGHLITE.y) -- 248
	ButtonSetTexture("MapWindowLock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_PRESSED_HIGHLITE.x, UI.Lock.STATE_PRESSED_HIGHLITE.y) -- 248
	WindowAddAnchor("MapWindowLock", "topright", "MapWindow", "topright", -5, 0)
	WindowSetShowing("MapWindowLegendToggle", false)
    MapWindow.PopulateMapLegend()
    SnapUtils.SnappableWindows["MapWindow"] = true
   WindowSetShowing("MapWindowToggleRadarButton", false)
   
   if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont("MapWindowCoordsText",  "font_verdana_bold_shadow_small", 16)
	else
		LabelSetFont("MapWindowCoordsText",  "UO_DefaultText", 10)
	end
   	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont("MapWindowPlayerCoordsText",  "font_verdana_bold_shadow_small", 16)
	else
		LabelSetFont("MapWindowPlayerCoordsText",  "UO_DefaultText", 10)
	end
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont("MapWindowCenterOnPlayerLabel",  "font_verdana_bold_shadow_small", 16)
	else
		LabelSetFont("MapWindowCenterOnPlayerLabel",  "UO_DefaultText", 10)
	end
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont("MapWindowTiltLabel",  "font_verdana_bold_shadow_small", 12)
	else
		LabelSetFont("MapWindowTiltLabel",  "UO_DefaultText", 10)
	end
end

function MapWindow.ToggleCombos(value)
	local was = EnhancePack.ShowMapCombos
	EnhancePack.ShowMapCombos = value
	CustomSettings.SaveBoolean( "EnhancePackShowMapCombos" , EnhancePack.ShowMapCombos )
	WindowSetShowing("MapWindowFacetCombo", EnhancePack.ShowMapCombos)
	WindowSetShowing("MapWindowFacetNextButton", EnhancePack.ShowMapCombos)
	WindowSetShowing("MapWindowFacetPrevButton", EnhancePack.ShowMapCombos)
	WindowSetShowing("MapWindowAreaCombo", EnhancePack.ShowMapCombos)
	WindowSetShowing("MapWindowAreaNextButton", EnhancePack.ShowMapCombos)
	WindowSetShowing("MapWindowAreaPrevButton", EnhancePack.ShowMapCombos)
	WindowClearAnchors("Map")
	if (not EnhancePack.ShowMapCombos) then
		WindowAddAnchor("Map", "topleft", "MapWindow", "topleft", 12, 35 )
		WindowAddAnchor("Map", "bottomright", "MapWindow", "bottomright", -12, -13 )
		MapWindow.MAP_HEIGHT_DIFFERENCE = MapWindow.MAP_HEIGHT_DIFFERENCE -55
	else
		MapWindow.MAP_HEIGHT_DIFFERENCE = 111
		WindowAddAnchor("Map", "bottom", "MapWindowAreaCombo", "top", 0, 3 )
		local windowWidth, windowHeight = WindowGetDimensions("MapWindow")
		WindowSetDimensions("Map", windowWidth - MapWindow.MAP_WIDTH_DIFFERENCE, windowHeight - MapWindow.MAP_HEIGHT_DIFFERENCE)
		
	end
end


function MapWindow.LockTooltip()
	if ( MapWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 304))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 305))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.Lock()
	MapWindow.Locked = not MapWindow.Locked 
	CustomSettings.SaveBoolean( "MapWindowLocked", MapWindow.Locked  )
end

function MapWindow.Shutdown()
	if (MapWindow.Big) then
		MapWindow.BigToggle()
	end
	WindowUtils.SaveWindowPosition("MapWindow")
    UnregisterWindowData(WindowData.Radar.Type,0)
    UnregisterWindowData(WindowData.WaypointDisplay.Type,0)
    UnregisterWindowData(WindowData.WaypointList.Type,0)
    SnapUtils.SnappableWindows["MapWindow"] = nil
end

function MapWindow.OnMouseDrag()
	if (not MapWindow.Locked ) then
		SnapUtils.StartWindowSnap("MapWindow")
		WindowSetMoving("MapWindow",true)
	else
		WindowSetMoving("MapWindow",false)
	end
end

function MapWindow.UpdateMap()
	local oldArea = ( ComboBoxGetSelectedMenuItem( "MapWindowAreaCombo" ) - 1 )
	local oldFacet = ( ComboBoxGetSelectedMenuItem( "MapWindowFacetCombo" ) - 1 )
	if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME) then
		local facet = UOGetRadarFacet()
		if (facet ~= nil) then
	
			ComboBoxSetSelectedMenuItem( "MapWindowFacetCombo", (facet + 1) )    
				
			ComboBoxClearMenuItems( "MapWindowAreaCombo" )
			for areaIndex = 0, (UORadarGetAreaCount(facet) - 1) do
				ComboBoxAddMenuItem( "MapWindowAreaCombo", GetStringFromTid(UORadarGetAreaLabel(facet, areaIndex)) )
			end
			
			local area = UOGetRadarArea()

			ComboBoxSetSelectedMenuItem( "MapWindowAreaCombo", (area + 1) )

			
			DynamicImageSetTextureScale("MapImage", WindowData.Radar.TexScale)
			DynamicImageSetTexture("MapImage","radar_texture", WindowData.Radar.TexCoordX, WindowData.Radar.TexCoordY)
			if MapWindow.Tilt then
				DynamicImageSetRotation("MapImage", 0)
				if (DoesWindowNameExist("MapCompass")) then
					DynamicImageSetRotation( "MapCompass", 0 )
				end
			else
				DynamicImageSetRotation("MapImage", WindowData.Radar.TexRotation)
				if (DoesWindowNameExist("MapCompass")) then
					DynamicImageSetRotation( "MapCompass", WindowData.Radar.TexRotation )
				end
			end
			
			
			MapCommon.ForcedUpdate = (oldArea ~= area) or (oldFacet ~= facet)
			if (MapCommon.ForcedUpdate) then
				for waypointId, value in pairs(MapCommon.WaypointsIconFacet) do
					local windowName = "Waypoint"..waypointId..MapCommon.ActiveView
					if (value ~= facet) then
						if (DoesWindowNameExist(windowName)) then
							MapCommon.WaypointViewInfo[MapCommon.ActiveView].Windows[waypointId] = nil
							DestroyWindow(windowName)
						end
					end
				end
			end
			MapCommon.UpdateWaypoints(MapCommon.ActiveView)
			MapCommon.WaypointsDirty = true
		end
    end
    

end

function MapWindow.UpdateWaypoints()
    if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
        MapCommon.WaypointsDirty = true
    end
end

function MapWindow.PopulateMapLegend()
    if( WindowData.WaypointDisplay.displayTypes.ATLAS ~= nil and WindowData.WaypointDisplay.typeNames ~= nil ) then
        local prevWindowName = nil
    
        for index=1, table.getn(WindowData.WaypointDisplay.typeNames) do
            if WindowData.WaypointDisplay.displayTypes.ATLAS[index].isDisplayed then
                local windowName = "MapLegend"..index             
                
                CreateWindowFromTemplate(windowName,"MapLegendItemTemplate", "LegendWindow" )
                WindowSetId(windowName, index)
                
                if( prevWindowName == nil ) then
                    WindowAddAnchor(windowName, "top", "LegendWindow", "top", 10, 10)
                else
                    WindowAddAnchor(windowName, "bottom", prevWindowName, "top", 0, 0)
                end
                prevWindowName = windowName
                
                local waypointName = WindowData.WaypointDisplay.typeNames[index]
                LabelSetText(windowName.."Text", waypointName)
                
                local iconId = WindowData.WaypointDisplay.displayTypes.ATLAS[index].iconId
                MapCommon.UpdateWaypointIcon(iconId,windowName.."Icon") 
                
                MapWindow.TypeEnabled[index] = true
            end
        end
    end
end

function MapWindow.ActivateMap()
    if( MapCommon.ActiveView ~= MapCommon.MAP_MODE_NAME ) then
        local mapTextureWidth, mapTextureHeight = WindowGetDimensions("MapImage")

	    UORadarSetWindowSize(mapTextureWidth, mapTextureHeight, true, MapWindow.CenterOnPlayer)
	    if MapWindow.Tilt then
				UOSetRadarRotation(0)
	    else
				UOSetRadarRotation(MapWindow.Rotation)
	    end	
	    
	    UORadarSetWindowOffset(0, 0)

	    WindowSetShowing("RadarWindow", false)
	    WindowSetShowing("MapWindow", true)
	    
	    MapCommon.ActiveView = MapCommon.MAP_MODE_NAME
	    
	    
		
		SystemData.Settings.Interface.mapMode = MapCommon.MAP_ATLAS
	    
	    local facet = UOGetRadarFacet()
	    local area = UOGetRadarArea()
	    MapCommon.UpdateZoomValues(facet, area)
	    if(MapWindow.CenterOnPlayer == true) then
			MapCommon.AdjustZoom(-20)
		else
			MapCommon.AdjustZoom(0)
		end
	    
	    MapWindow.UpdateMap()
	    MapWindow.UpdateWaypoints()
	end
	
end

-----------------------------------------------------------------
-- Input Event Handlers
-----------------------------------------------------------------

function MapWindow.MapOnMouseWheel(x, y, delta)
   	MapCommon.AdjustZoom(-delta)
end

function MapWindow.ZoomOutOnLButtonUp()
   	MapCommon.AdjustZoom(1)
end

function MapWindow.ZoomOutOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomOut))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.ZoomInOnLButtonUp()
    MapCommon.AdjustZoom(-1)
end

function MapWindow.ZoomInOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomIn))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.MapMouseDrag(flags,deltaX,deltaY)
    if( MapWindow.IsDragging and (deltaX ~= 0 or deltaY ~= 0) ) then
        MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, false)
        
        local facet = UOGetRadarFacet()
        local area = UOGetRadarArea()
             
		local mapCenterX, mapCenterY = UOGetRadarCenter()
		
				
		local winCenterX, winCenterY = UOGetWorldPosToRadar(mapCenterX,mapCenterY)
		
		
		local offsetX = winCenterX - deltaX
		local offsetY = winCenterY - deltaY
		local useScale = false
	       
		local newCenterX, newCenterY = UOGetRadarPosToWorld(offsetX,offsetY,useScale)

		if (area == 0) then
		
			if (newCenterX >=MapCommon.sextantMaximumX- 50) then
				newCenterX=MapCommon.sextantMaximumX - 50
			end
			
			if (newCenterX <= 0) then
				newCenterX=50
			end
			
			if (newCenterY >=MapCommon.sextantMaximumY- 50) then
				newCenterY=MapCommon.sextantMaximumY- 50
			end
			
			if (newCenterY <= 0) then
				newCenterY=50
			end
		else
			if (newCenterX >=7670- 50) then
				newCenterX=7670 - 50
			end
			
			if (newCenterX <= 0) then
				newCenterX=MapCommon.sextantMaximumX
			end
			
			if (newCenterY >=MapCommon.sextantMaximumY- 50) then
				newCenterY=MapCommon.sextantMaximumY- 50
			end
			
			if (newCenterY <= 0) then
				newCenterY=50
			end
		end
		UOCenterRadarOnLocation(newCenterX, newCenterY, facet, area, false)
	    MapCommon.ForcedUpdate = true
		MapCommon.UpdateWaypoints(MapCommon.ActiveView)
		MapCommon.WaypointsDirty = true
    end
end

function MapWindow.ToggleRadarOnLButtonUp()
    RadarWindow.ActivateRadar()
end

function MapWindow.ToggleRadarOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ShowRadar))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.ToggleFacetUpOnLButtonUp()
	local facet = UOGetRadarFacet() + 1
	
	if (facet >= MapCommon.NumFacets) then
		facet = 0
	end

	MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
	UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
	MapCommon.ChangeMap(facet, 0)
end

function MapWindow.ToggleFacetDownOnLButtonUp()
	local facet = UOGetRadarFacet() - 1
	
	if (facet < 0) then
		facet = MapCommon.NumFacets - 1
	end
	
	MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
	UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
	MapCommon.ChangeMap(facet,0)
end

function MapWindow.ToggleAreaUpOnLButtonUp()
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea() + 1
	
	if (area >= UORadarGetAreaCount(facet)) then
		area = 0
	end
	
	MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
	UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
	MapCommon.ChangeMap(facet, area)
end

function MapWindow.ToggleAreaDownOnLButtonUp()
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea() - 1
	
	if (area < 0) then
		area = UORadarGetAreaCount(facet) - 1
	end

	MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
	UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
	MapCommon.ChangeMap(facet, area)
end

function MapWindow.MapOnRButtonUp(flags,x,y)
	local useScale = false
	local scale = WindowGetScale("MapWindow")
	local waypointX, waypointY = UOGetRadarPosToWorld(x/scale, y/scale, useScale)
	local params = {x=waypointX, y=waypointY, facetId=UOGetRadarFacet()} 
	
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea()
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
	
	if (x1 < waypointX and y1 < waypointY and x2 > waypointX and y2 > waypointY) then
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.CreateWaypoint,0,MapCommon.ContextReturnCodes.CREATE_WAYPOINT,params)
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5103),0,"magnetize", params,false)

		if (not EnhancePack.ShowMapCombos) then
			ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
		end
	end
	if (not EnhancePack.ShowMapCombos) then
		local subMenu = {}
		local currfacet = UOGetRadarFacet()
		for facet = 0, (MapCommon.NumFacets - 1) do
			table.insert(subMenu, { str = GetStringFromTid(UORadarGetFacetLabel(facet)),flags=0,returnCode="callFacet"..facet,pressed=facet==currfacet })

		end

		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 306),0,0,"null",false,subMenu)
		subMenu = {}
		local currArea = UOGetRadarArea()
		for areaIndex = 0, (UORadarGetAreaCount(currfacet) - 1) do
			table.insert(subMenu, { str = GetStringFromTid(UORadarGetAreaLabel(currfacet, areaIndex)),flags=0,returnCode="callArea"..areaIndex,pressed=areaIndex==currArea })

		end

		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 307),0,0,"null",false,subMenu)
	end
	ContextMenu.ActivateLuaContextMenu(MapCommon.ContextMenuCallback)
end

function MapWindow.LegendIconOnLButtonUp()
    local windowName = SystemData.ActiveWindow.name
    waypointType = WindowGetId(windowName)
    
    MapWindow.TypeEnabled[waypointType] = not MapWindow.TypeEnabled[waypointType]
    
    local alpha = 1.0
    local color = MapWindow.LegendItemTextColors.normal
    if( MapWindow.TypeEnabled[waypointType] == false ) then
		alpha = 0.5
		color = MapWindow.LegendItemTextColors.disabled
	end
    WindowSetAlpha(windowName,alpha)
    LabelSetTextColor(windowName.."Text",color.r,color.g,color.b)
    
    MapCommon.WaypointsDirty = true
end

function MapWindow.CenterOnPlayerOnLButtonUp()
	MapWindow.CenterOnPlayer = ButtonGetPressedFlag( "MapWindowCenterOnPlayerButton" )
	UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
	for waypointId, value in pairs(MapCommon.WaypointsIconFacet) do
		local windowName = "Waypoint"..waypointId..MapCommon.ActiveView
		if (value ~= facet) then
			if (DoesWindowNameExist(windowName)) then
				MapCommon.WaypointViewInfo[MapCommon.ActiveView].Windows[waypointId] = nil
				DestroyWindow(windowName)
			end
		end
	end
	MapCommon.ForcedUpdate = true
	MapCommon.UpdateWaypoints(MapCommon.ActiveView)
end

function MapWindow.TiltOnLButtonUp()
	MapWindow.Tilt = ButtonGetPressedFlag( "MapWindowTiltButton" )
	CustomSettings.SaveBoolean( "MapWindowTilt" , MapWindow.Tilt )
	if MapWindow.Tilt then
			UOSetRadarRotation(0)
	else
			UOSetRadarRotation(MapWindow.Rotation)
	end	
end

function MapWindow.MapOnLButtonDown()
    MapWindow.IsDragging = true
    
    MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
    UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
end

function MapWindow.MapOnLButtonUp()
    MapWindow.IsDragging = false
    MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, true)
end

function MapWindow.MapOnLButtonDblClk(flags,x,y)
	local useScale = false
	local scale = WindowGetScale("MapWindow")
	local worldX, worldY = UOGetRadarPosToWorld(x/scale, y/scale, useScale)
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea()
	if( UORadarIsLocationInArea(worldX, worldY, facet, area) ) then
		UOCenterRadarOnLocation(worldX, worldY, facet, area, true)
	end	

    MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
    UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)	
end

function MapWindow.OnMouseOver()
	MapWindow.IsMouseOver = true
end

function MapWindow.OnMouseOverEnd()
    MapWindow.IsDragging = false
    MapWindow.IsMouseOver = false
    MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, true)
end

function MapWindow.SelectArea()
	local facet = UOGetRadarFacet()
    local area = ( ComboBoxGetSelectedMenuItem( "MapWindowAreaCombo" ) - 1 )
    
    if( area ~= UOGetRadarArea() ) then
		MapWindow.CenterOnPlayer = false
        ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
        UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
        MapCommon.ChangeMap(facet, area )
    end
end

function MapWindow.SelectFacet()
    local facet = ( ComboBoxGetSelectedMenuItem( "MapWindowFacetCombo" ) - 1 )
    local area = UOGetRadarArea()
    
    if( facet ~= UOGetRadarFacet() ) then
		MapWindow.CenterOnPlayer = false
        ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
        UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
        MapCommon.ChangeMap(facet, 0 )
    end
end

function MapWindow.OnLegendToggle()
	MapWindow.LegendVisible = not MapWindow.LegendVisible
	--Debug.Print("LegendWindow Visible: "..tostring(MapWindow.LegendVisible))
	ButtonSetPressedFlag("MapWindowLegendToggle", MapWindow.LegendVisible)
	WindowSetShowing("LegendWindow",MapWindow.LegendVisible)
end

function MapWindow.OnShown()
	if( MapWindow.LegendVisible == true ) then
		WindowSetShowing("LegendWindow",true)
	end
end

function MapWindow.OnUpdate(timePassed)
	if( WindowGetShowing("MapWindow") == true and MapWindow.IsMouseOver == true) then
		local windowX, windowY = WindowGetScreenPosition("MapImage")
		local mouseX = SystemData.MousePosition.x - windowX
		local mouseY = SystemData.MousePosition.y - windowY
	    local useScale = false
		local scale = WindowGetScale("MapWindow")
		local x, y = UOGetRadarPosToWorld(mouseX/scale, mouseY/scale, useScale)

		local facet = UOGetRadarFacet()
		local area = UOGetRadarArea()	    
	    local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
		if (x1 < x and y1 < y and x2 > x and y2 > y) then
			local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, facet)
			local Sextant = latStr..L"'"..latDir..L" "..longStr..L"'"..longDir .. L"\n" .. x .. L", " .. y
			
	
			LabelSetText("MapWindowCoordsText", Sextant)
		else
			LabelSetText("MapWindowCoordsText", L"")
		end
	elseif (MapCommon.WaypointIsMouseOver == false) then
		LabelSetText("MapWindowCoordsText", L"")
	end
end

function MapWindow.OnHidden()
	WindowSetShowing("LegendWindow",false)
	SystemData.Settings.Interface.mapMode = MapCommon.MAP_HIDDEN
	EnhancePack.MapVisible = false
	CustomSettings.SaveBoolean( "EnhancePackMapVisible", EnhancePack.MapVisible)
end

function MapWindow.OnLegendButtonMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ShowLegend))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.OnResizeBegin()
	local windowName = WindowUtils.GetActiveDialog()
	local widthMin = 400
	local heightMin = 400
    WindowUtils.BeginResize( windowName, "topleft", widthMin, heightMin, false, MapWindow.OnResizeEnd)
end

function MapWindow.BigToggle()
	MapWindow.Big = not MapWindow.Big
	local MapZoom
		
	if (MapWindow.Big) then
		WindowUtils.SaveWindowPosition("MapWindow", false)
		MapZoom = CustomSettings.LoadNumber( "MapZoomBig" , -100)
		local w = CustomSettings.LoadNumber( "MapWindowBigW" , 716)
		local h = CustomSettings.LoadNumber( "MapWindowBigH" , 776)

		WindowSetDimensions("MapWindow", w , h)
		MapWindow.OnResizeEnd("MapWindow")
		WindowSetScale("MapWindow", SystemData.Settings.Interface.customUiScale * 0.80)
		EnhancePack.LoadScale( "MapWindow" )
		
		MapWindow.ComboBCK = EnhancePack.ShowMapCombos
		MapWindow.ToggleCombos(true)
		WindowClearAnchors("MapWindow")
		WindowAddAnchor("MapWindow", "center", "Root", "center",0,0)
		WindowUtils.RestoreWindowPosition("MapWindow", false, "mapwindowBig")
		MapCommon.ForcedUpdate = true
		MapCommon.UpdateWaypoints(MapCommon.ActiveView)
		
	else
		WindowUtils.SaveWindowPosition("MapWindow", false, "mapwindowBig")
		MapZoom = CustomSettings.LoadNumber( "MapZoom" , -100)
		local w = CustomSettings.LoadNumber( "MapWindowW" , 716)
		local h = CustomSettings.LoadNumber( "MapWindowH" , 776)
		WindowSetDimensions("MapWindow", w , h)
		MapWindow.OnResizeEnd("MapWindow")
		WindowSetScale("MapWindow", SystemData.Settings.Interface.customUiScale * 0.80)
		EnhancePack.LoadScale( "MapWindow" )
		MapWindow.ToggleCombos(MapWindow.ComboBCK)
		WindowSetShowing("MapWindow".."ResizeButton", true)
		WindowUtils.RestoreWindowPosition("MapWindow", true)
		MapCommon.ForcedUpdate = true
		MapCommon.UpdateWaypoints(MapCommon.ActiveView)
	end
	if (MapZoom ~= nil) then
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = MapZoom
			MapCommon.AdjustZoom(MapCommon.ZoomLevel[MapCommon.ActiveView].Current)
		end
end

function MapWindow.BigOnMouseOver()
	if (MapWindow.Big) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 309))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 310))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.OnResizeEnd(curWindow)
	local windowWidth, windowHeight = WindowGetDimensions("MapWindow")
	--Debug.Print("MapWindow.OnResizeEnd("..curWindow..") width = "..windowWidth.." height = "..windowHeight)
	
	if(windowWidth > MapWindow.WINDOW_WIDTH_MAX) then
		windowWidth = MapWindow.WINDOW_WIDTH_MAX
	end
	
	if(windowHeight > MapWindow.WINDOW_HEIGHT_MAX) then
		windowHeight = MapWindow.WINDOW_HEIGHT_MAX
	end
	
	local legendScale = windowHeight / MapWindow.WINDOW_HEIGHT_MAX
	if (DoesWindowNameExist("LegendWindow")) then
		WindowSetScale("LegendWindow", legendScale * InterfaceCore.scale)
	end
	
	WindowSetDimensions("MapWindow", windowWidth, windowHeight)
	if (CustomSettings) then
		if (MapWindow.Big) then
			CustomSettings.SaveNumber( "MapWindowBigW" , windowWidth)
			CustomSettings.SaveNumber( "MapWindowBigH" , windowHeight )
		else
			CustomSettings.SaveNumber( "MapWindowW" , windowWidth)
			CustomSettings.SaveNumber( "MapWindowH" , windowHeight )
		end
	end
	
	WindowSetDimensions("Map", windowWidth - MapWindow.MAP_WIDTH_DIFFERENCE, windowHeight - MapWindow.MAP_HEIGHT_DIFFERENCE)
	 local topWidth, topHeight = WindowGetDimensions("MapWindow".."Top")
	WindowSetDimensions("MapWindow".."Top",windowWidth + 30,topHeight)
	local bottomWidth, bottomHeight = WindowGetDimensions("MapWindow".."Bottom")
	WindowSetDimensions("MapWindow".."Bottom",windowWidth + 30,bottomHeight)
	MapCommon.ForcedUpdate = true
	MapCommon.UpdateWaypoints(MapCommon.ActiveView)
end