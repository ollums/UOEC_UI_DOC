----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapCommon = {}
MapCommon.ForcedUpdate = false
MapCommon.ActiveView = nil

MapCommon.MAP_MODE_NAME = "ATLAS"
MapCommon.RADAR_MODE_NAME = "RADAR"

MapCommon.MAP_HIDDEN = "hidden"
MapCommon.MAP_RADAR = "radar"
MapCommon.MAP_ATLAS = "atlas"

MapCommon.TID = {Waypoints=1078474, WorldMap=1077438, YourLocation=1078897,
			     CreateWaypoint=1079482, EditWaypoint=1079483, DeleteWaypoint=1079484, ViewWaypoint=1079571, Close=1052061,
			     Atlas=1111703, ShowLegend=1111706, ZoomOut=1079289, ZoomIn=1079288, ShowRadar=1112106, ShowAtlas=1112107 }

MapCommon.NumFacets = 6

MapCommon.ZoomLevel = {}
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME] = {}
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Step = 0.05
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Current = 0.05
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Min = -10.0
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Max = 1.0
MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].IconScale = WindowGetScale("MapWindow")
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME] = {}
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].Step = 0.30
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].Current= -0.50
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].Min= -2.0
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].Max= 1.0
MapCommon.ZoomLevel[MapCommon.RADAR_MODE_NAME].IconScale = 1.0

MapCommon.WaypointViewInfo = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME] = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].Parent = "MapImage"
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].Windows = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].x = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].y = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].icon = {}
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].PlayerVisible = true
MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].WaypointsEnabled = true

MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME] = {}
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].Parent = "RadarWindowMap"
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].Windows = {}
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].x = {}
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].y = {}
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].icon = {}
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].PlayerVisible = true
MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].WaypointsEnabled = true

MapCommon.WaypointsIcon = {}
MapCommon.WaypointsTypes = {}
MapCommon.WaypointsIconScale = {}
MapCommon.WaypointsIconFacet = {}

MapCommon.WaypointMaxId = 0
MapCommon.WaypointsDirty = false
MapCommon.WaypointCustomType = 15
MapCommon.WaypointPlayerVisible = true
MapCommon.WaypointPlayerType = 14
MapCommon.WaypointPlayerId = 10000
MapCommon.WaypointIsMouseOver = false

MapCommon.WaypointUpdateRequest = false
MapCommon.RefreshDelay = 0.5

MapCommon.ContextReturnCodes = {}
MapCommon.ContextReturnCodes.CREATE_WAYPOINT = 0
MapCommon.ContextReturnCodes.DELETE_WAYPOINT = 1
MapCommon.ContextReturnCodes.VIEW_WAYPOINT = 2

MapCommon.MapBorder = {}
MapCommon.MapBorder.TOP = 225
MapCommon.MapBorder.BOTTOM = 880
MapCommon.MapBorder.LEFT = 0
MapCommon.MapBorder.RIGHT = 0

--MapCommon.sextantDefaultCenterX=1323
--MapCommon.sextantDefaultCenterY=1624
--MapCommon.sextantLostLandCenterX=5631
--MapCommon.sextantLostLandCenterY=3112
--MapCommon.sextantLostLandTopLeftX = 6144
--MapCommon.sextantLostLandTopRightX = 5120
--MapCommon.sextantLostLandTopLeftY = 2304
--MapCommon.sextantLostLandBottomLeftY = 4096
--MapCommon.sextantMaximumX = 5120;
--MapCommon.sextantMaximumY = 4096;

MapCommon.sextantDefaultCenterX=1323
MapCommon.sextantDefaultCenterY=1624
MapCommon.sextantLostLandCenterX=6144
MapCommon.sextantLostLandCenterY=3112
MapCommon.sextantLostLandTopLeftX = 5120
MapCommon.sextantLostLandTopLeftY = 2304
MapCommon.sextantMaximumX = 5120;
MapCommon.sextantMaximumY = 4096;

MapCommon.sextantFeluccaLostLands = 14
MapCommon.sextantTrammelLostLands = 13

MapCommon.RefreshDelta = 0


----------------------------------------------------------------
-- Functions
----------------------------------------------------------------



function MapCommon.WaypointViewInfo.ATLAS.VisibleFunc(wtype,wx,wy)
		
		if (wtype == MapCommon.WaypointPlayerType and MapWindow.CenterOnPlayer) then
			return true
		end

		local windowWidth,windowHeight = WindowGetDimensions("MapWindow")
		

		local mapCenterX, mapCenterY = UOGetRadarCenter()
		local x2, y2 = UOGetWorldPosToRadar(mapCenterX,mapCenterY)
		y2 = y2 + 22
		
		local wx1, wy1 = UOGetWorldPosToRadar(wx, wy)
		
		local Rw = (windowWidth - (MapWindow.MAP_WIDTH_DIFFERENCE + 60)) / 2
		local Rh = (windowHeight - MapWindow.MAP_HEIGHT_DIFFERENCE) / 2
		local left = x2 - Rw
		local right = x2 + Rw
		local top = y2 - Rh
		local bottom = y2 + Rh - 50

		local FitOnWidth = wx1 > left and wx1 < right
		local FitOnHeight = wy1 > top and wy1 < bottom
		
		local FitOnWindow = FitOnWidth and FitOnHeight
		if (FitOnWindow) then -- CHECK IF THE WAYPOINT IS IN THE AREA
			local area = UOGetRadarArea()
			local facet = UOGetRadarFacet()
			if not area then
				area = 1
			end
			if not facet then
				facet = 1
			end
			local a,b,c,d = UORadarGetAreaDimensions(facet, area)
			FitOnWidth = wx > a and wx < c
			FitOnHeight = wy > b and wy < d

			FitOnWindow = FitOnWidth and FitOnHeight
		end

		return FitOnWindow

end

function MapCommon.WaypointViewInfo.RADAR.VisibleFunc(wtype,wx,wy)
    local radius = (RadarWindow.Size/2)
    local waypointX, waypointY = UOGetWorldPosToRadar(wx, wy)
    local WaypointDistanceFromCenter = ( (math.abs(waypointX - radius)) ^ 2 +
	    							     (math.abs(waypointY - radius)) ^ 2) ^ 0.5
	return (WaypointDistanceFromCenter < radius)
end


function MapCommon.Initialize()
	-- create the player waypoints
    local parent = MapCommon.WaypointViewInfo[MapCommon.RADAR_MODE_NAME].Parent
    local windowName = "Waypoint"..MapCommon.WaypointPlayerId..MapCommon.RADAR_MODE_NAME
    CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parent)
    WindowSetId(windowName,MapCommon.WaypointPlayerId)
    parent = MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].Parent
    windowName = "Waypoint"..MapCommon.WaypointPlayerId..MapCommon.MAP_MODE_NAME
    CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parent)
    WindowSetId(windowName,MapCommon.WaypointPlayerId)
    
    RegisterWindowData(WindowData.PlayerLocation.Type,0)
	
	if not (SystemData.Settings.Interface.mapMode == MapCommon.MAP_HIDDEN or
			SystemData.Settings.Interface.mapMode == MapCommon.MAP_RADAR or
			SystemData.Settings.Interface.mapMode == MapCommon.MAP_ATLAS) then
		SystemData.Settings.Interface.mapMode = MapCommon.MAP_RADAR
	end
	
end

function MapCommon.Shutdown()
    UnregisterWindowData(WindowData.PlayerLocation.Type,0)
end

function MapCommon.Update()
    if( MapCommon.WaypointsDirty == true and
            MapCommon.ActiveView ~= nil and
            MapCommon.WaypointViewInfo[MapCommon.MAP_MODE_NAME].WaypointsEnabled == true ) then
        --MapCommon.UpdateWaypoints(MapCommon.ActiveView)
        MapCommon.WaypointsDirty = false
    end
end

function MapCommon.AdjustZoom(zoomDelta)
	if( MapCommon.ActiveView ~= nil) then
		local step = MapCommon.ZoomLevel[MapCommon.ActiveView].Step
		if (MapCommon.ZoomLevel[MapCommon.ActiveView].Current < 0.0) then
			step = 0.2
		end
		MapCommon.ZoomLevel[MapCommon.ActiveView].Current = MapCommon.ZoomLevel[MapCommon.ActiveView].Current + ( zoomDelta * step )
		
		if (MapCommon.ZoomLevel[MapCommon.ActiveView].Current > MapCommon.ZoomLevel[MapCommon.ActiveView].Max) then
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = MapCommon.ZoomLevel[MapCommon.ActiveView].Max
		end
		if (MapCommon.ZoomLevel[MapCommon.ActiveView].Current < MapCommon.ZoomLevel[MapCommon.ActiveView].Min) then
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = MapCommon.ZoomLevel[MapCommon.ActiveView].Min
		end
		UOSetRadarZoom(MapCommon.ZoomLevel[MapCommon.ActiveView].Current)
		if(CustomSettings ~= nil) then
			if (MapWindow.Big) then
				CustomSettings.SaveNumber( "MapZoomBig" , MapCommon.ZoomLevel[MapCommon.ActiveView].Current )
			else
				CustomSettings.SaveNumber( "MapZoom" , MapCommon.ZoomLevel[MapCommon.ActiveView].Current )
			end
		end
		for waypointId, value in pairs(MapCommon.WaypointsIconFacet) do
			local windowName = "Waypoint"..waypointId..MapCommon.ActiveView
			if (value ~= facet) then
				if (DoesWindowNameExist(windowName)) then
					MapCommon.WaypointViewInfo[MapCommon.ActiveView].Windows[waypointId] = nil
					if (DoesWindowNameExist(windowName)) then
						DestroyWindow(windowName)
					end
				end
			end
		end
		MapCommon.ForcedUpdate = true
		MapCommon.UpdateWaypoints(MapCommon.ActiveView)
	end
end

function MapCommon.ChangeMap(facet, area)
	if not area then
		return
	end
	if not facet then
		return
	end
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
	if not x2 then
		return
	end
	local centerX = ( ( x2 - x1 ) / 2 ) + x1
	local centerY = ( ( y2 - y1 ) / 2 ) + y1
	
	UOCenterRadarOnLocation(centerX, centerY, facet, area, false)
	
	MapCommon.UpdateZoomValues(facet, area)
	
	
	MapCommon.AdjustZoom(0)
end

function MapCommon.UpdateZoomValues(facet, area)
	if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
		local maxZoom = UORadarGetMaxZoomForMap(facet, area)
		
		if( maxZoom > 0 ) then
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = maxZoom
			MapCommon.ZoomLevel[MapCommon.ActiveView].Min = -2.0
			MapCommon.ZoomLevel[MapCommon.ActiveView].Max = maxZoom
			MapCommon.ZoomLevel[MapCommon.ActiveView].Step = MapCommon.ZoomLevel[MapCommon.ActiveView].Max / 5
		else
			MapCommon.ZoomLevel[MapCommon.ActiveView].Current = 0.0
			MapCommon.ZoomLevel[MapCommon.ActiveView].Min = -2.0
			MapCommon.ZoomLevel[MapCommon.ActiveView].Max = 0.0
			MapCommon.ZoomLevel[MapCommon.ActiveView].Step = 0.50
		end
	end
end

function MapCommon.GetWaypointScale(displayMode)
	local iconScale = WindowGetScale("MapWindow")
	if( displayMode == MapCommon.MAP_MODE_NAME ) then
		local iconSpan = MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Max - MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Min
		iconScale = MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Current - MapCommon.ZoomLevel[MapCommon.MAP_MODE_NAME].Min
		if (iconScale < 0) then
			iconScale = 0
		end
		iconScale = 1.0 - (iconScale / iconSpan) * 0.5
	end
	return iconScale;
end

function MapCommon.UpdateWaypointIcon(iconId,windowName,displayMode,waypointId)
	if (not DoesWindowNameExist(windowName) or not MapIcons ) then
		return
	end
	if (type(iconId) == "number") then
		local iconTexture, x, y = GetIconData(iconId)
		local iconWidth, iconHeight = UOGetTextureSize("icon"..iconId)
		local iconScale = MapCommon.GetWaypointScale(displayMode)
		if (MapCommon.WaypointsIconScale[waypointId]) then
			iconScale = MapCommon.WaypointsIconScale[waypointId]
		end
		WindowSetDimensions(windowName, iconWidth* iconScale, iconHeight* iconScale)
		DynamicImageSetTextureDimensions(windowName, iconWidth, iconHeight)
		DynamicImageSetTexture(windowName, iconTexture, x, y)
	else
		local iconWidth, iconHeight = UOGetTextureSize(iconId)
		local iconScale = MapCommon.GetWaypointScale(displayMode)
		if (MapCommon.WaypointsIconScale[waypointId]) then
			iconScale = MapCommon.WaypointsIconScale[waypointId]
		end
		WindowSetDimensions(windowName, iconWidth* iconScale, iconHeight* iconScale)
		DynamicImageSetTextureDimensions(windowName, iconWidth, iconHeight)
		DynamicImageSetTexture(windowName, iconId, 0, 0)
		
	end    
end

function MapCommon.IgnoreWaypoint(scale, type)
	-- types:
	-- 1 corpse
	-- 2 party
	-- 4 quest giver
	-- 6 wandering healer
	-- 7 danger
	-- 9 city
	-- 10 dungeon
	-- 11 shrine
	-- 12 moongate
	-- 15 custom
	if (scale == nil) then
		scale = 1
	end
	if (type ~= nil) then
		if (type == 4 and MapCommon.ZoomLevel[MapCommon.ActiveView].Current > -1) then
			return true
		end
	end
	--if (MapCommon.ZoomLevel[MapCommon.ActiveView].Current > -1 and scale < 0.5 ) then
	--	return true
	--end
	if (MapCommon.ZoomLevel[MapCommon.ActiveView].Current > -0.5 and scale < 0.6 ) then
		return true
	end
	return false
end

function MapCommon.ClearWaypoints(displayMode)
	for waypointId, value in pairs(MapCommon.WaypointViewInfo[displayMode].Windows) do
		local windowName = "Waypoint"..waypointId..displayMode
		if (DoesWindowNameExist(windowName)) then
			DestroyWindow(windowName)
		end
	end
	MapCommon.WaypointViewInfo[displayMode].Windows = {}
	MapCommon.WaypointsIcon = {}
	MapCommon.WaypointsTypes = {}
	MapCommon.WaypointsIconScale = {}
	MapCommon.WaypointsIconFacet = {}
	
	MapCommon.WaypointMouseOverEnd()
end

function MapCommon.DrawPlayer(displayMode, visibleFunc, parentWindow)
	local physicalFacet = UOGetPhysicalRadarFacet()
	
	local windowName = "Waypoint"..MapCommon.WaypointPlayerId..displayMode
	
	local playerVisible = WindowData.PlayerLocation.facet == physicalFacet and visibleFunc(MapCommon.WaypointPlayerType,WindowData.PlayerLocation.x,WindowData.PlayerLocation.y)
    if( playerVisible ~= MapCommon.WaypointViewInfo[displayMode].PlayerVisible ) then
        WindowSetShowing(windowName,playerVisible)
        MapCommon.WaypointViewInfo[displayMode].PlayerVisible = playerVisible
    end
	
    if( playerVisible ) then    
		if (DoesWindowNameExist(windowName)) then 
			DestroyWindow(windowName)
		end
		CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parentWindow)  
		WindowSetId(windowName,MapCommon.WaypointPlayerId) 
        WindowClearAnchors(windowName)
	    local playerX, playerY = UOGetWorldPosToRadar(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y)
	    WindowAddAnchor(windowName, "topleft", parentWindow, "center", playerX, playerY)
	    local iconId = WindowData.WaypointDisplay.displayTypes[displayMode][MapCommon.WaypointPlayerType].iconId
        MapCommon.UpdateWaypointIcon(iconId,windowName,displayMode)
        CreateWindowFromTemplate(windowName .. "Text", "WPText", windowName)
		WindowAddAnchor(windowName .. "Text", "top", windowName, "bottom", 0, -5)
		LabelSetText(windowName .. "Text", UI.GetCliloc(SystemData.Settings.Language.type, 867))
    end
end
function MapCommon.GetWPDataFromString(wname, wtype, wfacet, facet, area)
	if (not wname) then
		return nil
	end
	if (wname == L"Shrine of Wisdom" and wfacet == 4) then
		return nil
	end
	
	local data = {}
	data.icon = "0"
	data.scale = MapCommon.GetWaypointScale(displayMode)
	data.name = wname
	data.facet = wfacet
	data.type = wtype
	
	if (wtype == 11 or wtype == 12 ) then
		data.scale = 0.69		
	end
	if (wtype == 1) then
		data.scale = 0.6
	end
	
	if (wtype == 2) then
		data.icon = "MapIcons_Party"
		data.scale = 0.6
	end
	
	local iconPt = wstring.find(wname, L"_ICON_")
	if (iconPt) then
		
		local scalePt = wstring.find(wname , L"_SCALE_")
		
		data.icon = wstring.sub(wname, iconPt + 6, scalePt - 1)
		
		local dungPt = wstring.find(wname , L"_DUNG_")
		local abyssPt = wstring.find(wname , L"_DUNG_")
		if(dungPt) then
			if (facet ~= 4 and area == 0) then
				return nil
			end
			data.scale = tonumber(tostring(wstring.sub(wname, scalePt + 7, dungPt - 1)))
		elseif(abyssPt) then
			if (facet ~= 5 and area ~= 1) then
				return nil
			end
			data.scale = tonumber(tostring(wstring.sub(wname, scalePt + 7, abyssPt - 1)))
		else
			data.scale = tonumber(tostring(wstring.sub(wname, scalePt + 7, wstring.len(wname))))
			data.tokunoDungeon = false
			data.abyssDungeon = false
		end
		
		if (MapCommon.IgnoreWaypoint(data.scale)) then
			return nil
		end
		
		data.name = wstring.sub(wname, 1 , iconPt - 1)
		return data
	end
	if (MapCommon.IgnoreWaypoint(data.scale)) then
		return nil
	end
	return data
end
function MapCommon.CreateWPOnLocation(wname, wtype, wfacet, wx, wy, displayMode, waypointId, windowName, parentWindow)
	local waypointX, waypointY = UOGetWorldPosToRadar(wx, wy)

    if( MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] == nil ) then
		CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parentWindow)
		MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] = windowName
        WindowSetId(windowName,waypointId)
		if (wtype == 2) then
			CreatePartyWP(windowName, wname)
		end
		WindowClearAnchors(windowName)
        WindowAddAnchor(windowName, "topleft", parentWindow, "center", waypointX, waypointY)
        
        local iconId = WindowData.WaypointDisplay.displayTypes[displayMode][wtype].iconId
        if (MapCommon.WaypointsIcon[waypointId] ~= "0" ) then
			iconId = MapCommon.WaypointsIcon[waypointId]
			if (tonumber(iconId) and tonumber(iconId) ~= 0) then
				iconId = tonumber(iconId)
			else
				iconId = tostring(iconId)
			end
		end
		if (wname == L"Sea Market" and (wfacet == 1 or wfacet == 0)) then
			iconId = 100042
		end
		MapCommon.UpdateWaypointIcon(iconId,windowName,displayMode, waypointId)
    end
end

function CreatePartyWP(windowName, wname)
	local name = wstring.gsub(wname, L"\"", L"")
	CreateWindowFromTemplate(windowName .. "Text", "WPText", windowName)
	WindowAddAnchor(windowName .. "Text", "top", windowName, "bottom", 0, -10)
	LabelSetText(windowName .. "Text", name)

	if (EnhancePack) then
		local pid = 0
		for mobileId, bho in pairs (PartyHealthBar.PartyMembers) do
			if(PartyHealthBar.PartyMembers[mobileId].name and wstring.len(PartyHealthBar.PartyMembers[mobileId].name) > 4) then
				pname = wstring.sub(PartyHealthBar.PartyMembers[mobileId].name, 2, -2)
				if (pname == name) then
					pid = mobileId
					break
				end
			end
		end
		
		RegisterWindowData(WindowData.MobileStatus.Type, pid)
		if (PartyHealthBar.PartyMembers[pid]) then
			local curHealth = PartyHealthBar.PartyMembers[pid].CurrentHealth
			local maxHealth = PartyHealthBar.PartyMembers[pid].MaxHealth
			if maxHealth > 0 then
				CreateWindowFromTemplate(windowName .. "HealthBar", "WPHealthBar", windowName)
				WindowAddAnchor(windowName .. "HealthBar", "bottom", windowName .. "Text", "top", 0, 5)
				WindowSetScale(windowName .. "HealthBar", 0.4)
				
				StatusBarSetMaximumValue( windowName .. "HealthBar", maxHealth )	
				StatusBarSetCurrentValue( windowName .. "HealthBar", curHealth )
				WindowSetTintColor(windowName .. "HealthBar",255, 0, 0)
			elseif (DoesWindowNameExist(windowName .. "HealthBar")) then
				DestroyWindow(windowName .. "HealthBar")
			end
		end
		UnregisterWindowData(WindowData.MobileStatus.Type, pid)
	end
end

function MapCommon.UpdateWaypoints(displayMode)

	if ((MapCommon.RefreshDelta < MapCommon.RefreshDelay and MapCommon.ForcedUpdate == false) or not MapIcons) then
		MapCommon.WaypointUpdateRequest = true
		return
	end
	
	MapCommon.WaypointUpdateRequest = false
	MapCommon.ForcedUpdate = false
	MapCommon.RefreshDelta = 0
	
	
    local parentWindow = MapCommon.WaypointViewInfo[displayMode].Parent
    local visibleFunc = MapCommon.WaypointViewInfo[displayMode].VisibleFunc
    
	MapCommon.ClearWaypoints(displayMode)
	
    MapCommon.DrawPlayer(displayMode, visibleFunc, parentWindow)
   	

    local facet = UOGetRadarFacet()
    local area = UOGetRadarArea()
    if (facet == 5 and (area == 2 or area == 7)) then
		facet = 0
	end
   
    UOSetWaypointMapFacet(facet) 

	local CreateWPOnLocation = MapCommon.CreateWPOnLocation
	
    for waypointId = 1,WindowData.WaypointList.waypointCount do	

		windowName = "Waypoint"..waypointId..displayMode
		
		
        local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId) 
        
        if (wname == nil) then
			continue
		end
		
        if (wtype == 10 ) then
			continue
        end
		if (wtype == 4 and MapCommon.ZoomLevel[MapCommon.ActiveView].Current > -1) then
			continue
		end
		
        if( visibleFunc(wtype,wx,wy) ) then
			
			local data = MapCommon.GetWPDataFromString(wname, wtype, wfacet, facet, area)
			if not data then
				continue
			end
			
			MapCommon.WaypointsTypes[waypointId] = data.type
			MapCommon.WaypointsIconFacet[waypointId] = data.facet
			MapCommon.WaypointsIcon[waypointId] = data.icon
			MapCommon.WaypointsIconScale[waypointId] = data.scale
			
			CreateWPOnLocation(wname, wtype, wfacet, wx, wy, displayMode, waypointId, windowName, parentWindow)
		end
    end
    

    local lastDefault = 10000

    for i = 1, table.getn(Waypoints.Facet[facet]) do	
		waypointId = lastDefault + i
		windowName = "Waypoint"..waypointId..displayMode
		
		local data = Waypoints.UOGetWaypointInfo(i, facet) 
        wtype = data.wtype
        wflags = data.wflags
        wname = data.wname
        wfacet = data.wfacet
        wx = tonumber(data.wx)
        wy = tonumber(data.wy)
        wz = tonumber(data.wz)

        if (wname == nil) then
			continue
		end
		
        if (wtype == 10 ) then
			continue
        end
		if (wtype == 4 and MapCommon.ZoomLevel[MapCommon.ActiveView].Current > -1) then
			continue
		end
		
        if( visibleFunc(wtype,wx,wy) ) then
			
			if (wname == L"Shrine of Wisdom" and wfacet == 4) then
				continue
			end
			if (wtype == 11 or wtype == 12 ) then
				MapCommon.WaypointsIconScale[waypointId] = 0.69		
			end
			
			if (wtype == 1) then
				MapCommon.WaypointsIconScale[waypointId] = 0.6
			end
			
			MapCommon.WaypointsTypes[waypointId] = wtype
			MapCommon.WaypointsIconFacet[waypointId] = wfacet
			MapCommon.WaypointsIcon[waypointId] = Waypoints.Facet[facet][i].Icon
			MapCommon.WaypointsIconScale[waypointId] = Waypoints.Facet[facet][i].Scale
			
			if (MapCommon.IgnoreWaypoint(MapCommon.WaypointsIconScale[waypointId])) then
				continue
			end
				
			
			if (wflags ~= "DUNG" and facet == 4 and area > 0) then
				continue
			end
			
			if (wflags ~= "ABYSS" and facet == 5 and area == 1) then
				continue
			end
        
            CreateWPOnLocation(wname, wtype, wfacet, wx, wy, displayMode, waypointId, windowName, parentWindow)
		end
    end

    for waypointId , whocare in pairs (EnhancePack.GuildMembers)  do
		windowName = "Waypoint"..waypointId..displayMode
		
		if not EnhancePack.GuildMembers[waypointId] then
			continue
		end

		local wx = EnhancePack.GuildMembers[waypointId].x
		local wy = EnhancePack.GuildMembers[waypointId].y
		local wfacet = EnhancePack.GuildMembers[waypointId].facet
		local name = EnhancePack.GuildMembers[waypointId].name
		
		if (not wx or not wy or not facet) then
			continue
		end
		if( visibleFunc(2,wx,wy) and name and not IsPartyMember( waypointId )) then
			MapCommon.WaypointsIcon[waypointId] = "MapIcons_Party"
			MapCommon.WaypointsIconScale[waypointId] = 0.6
			
			local waypointX, waypointY = UOGetWorldPosToRadar(wx, wy)

            if( MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] == nil ) then
				CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parentWindow)
				
				CreateWindowFromTemplate(windowName .. "Text", "WPText", windowName)
				WindowAddAnchor(windowName .. "Text", "top", windowName, "bottom", 0, -10)
				LabelSetText(windowName .. "Text", name)
				
				local curHealth = EnhancePack.GuildMembers[waypointId].CurrentHealth
				local maxHealth = EnhancePack.GuildMembers[waypointId].MaxHealth
				if maxHealth and maxHealth > 0 then
					CreateWindowFromTemplate(windowName .. "HealthBar", "WPHealthBar", windowName)
					WindowAddAnchor(windowName .. "HealthBar", "bottom", windowName .. "Text", "top", 0, 5)
					WindowSetScale(windowName .. "HealthBar", 0.4)
					
					StatusBarSetMaximumValue( windowName .. "HealthBar", maxHealth )	
					StatusBarSetCurrentValue( windowName .. "HealthBar", curHealth )
					WindowSetTintColor(windowName .. "HealthBar",255, 0, 0)
				elseif (DoesWindowNameExist(windowName .. "HealthBar")) then
					DestroyWindow(windowName .. "HealthBar")
				end

				
				MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] = windowName
                WindowSetId(windowName,waypointId)
                
                WindowClearAnchors(windowName)
				WindowAddAnchor(windowName, "topleft", parentWindow, "center", waypointX, waypointY)
				MapCommon.UpdateWaypointIcon("MapIcons_Party",windowName,displayMode, waypointId)
			end
			
		end
    end
    
     for waypointId , whocare in pairs (TrackingPointer.TrackWaypoints)  do
		windowName = "Waypoint"..waypointId..displayMode

		if not TrackingPointer.TrackWaypoints[waypointId] then
			continue
		end

		local wx = TrackingPointer.TrackWaypoints[waypointId].PointerX
		local wy = TrackingPointer.TrackWaypoints[waypointId].PointerY
		local wfacet = TrackingPointer.TrackWaypoints[waypointId].facet
		local name = L"Tracked Target"
		
		if (not wx or not wy or not facet) then
			continue
		end
		if( visibleFunc(2,wx,wy) and name and not IsPartyMember( waypointId ) and not EnhancePack.GuildMembers[waypointId]) then
			MapCommon.WaypointsIcon[waypointId] = "MapIcons_Target"
			MapCommon.WaypointsIconScale[waypointId] = 0.6
			
			local waypointX, waypointY = UOGetWorldPosToRadar(wx, wy)

            if( MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] == nil ) then
				CreateWindowFromTemplate(windowName, "WaypointIconTemplate", parentWindow)
				
				MapCommon.WaypointViewInfo[displayMode].Windows[waypointId] = windowName
                WindowSetId(windowName,waypointId)
                
                WindowClearAnchors(windowName)
				WindowAddAnchor(windowName, "topleft", parentWindow, "center", waypointX, waypointY)
				MapCommon.UpdateWaypointIcon("MapIcons_Target",windowName,displayMode, waypointId)
			end
			
		end
    end
end

function MapCommon.SetWaypointsEnabled(displayMode,isEnabled)
    if( isEnabled ~= MapCommon.WaypointViewInfo[displayMode].WaypointsEnabled ) then
        for windowId, windowName in pairs(MapCommon.WaypointViewInfo[displayMode].Windows) do
            WindowSetShowing(windowName,isEnabled)
        end
        
        if( MapCommon.WaypointViewInfo[displayMode].PlayerVisible ) then
            windowName = "Waypoint"..MapCommon.WaypointPlayerId..displayMode
            WindowSetShowing(windowName,isEnabled)
        end
        
        MapCommon.WaypointViewInfo[displayMode].WaypointsEnabled = isEnabled
    end
end

function MapCommon.GetSextantCenterByArea( facet, area)
	if( (facet == 0 and area == MapCommon.sextantFeluccaLostLands) or (facet == 1 and area == MapCommon.sextantTrammelLostLands) ) then
		return MapCommon.sextantLostLandCenterX, MapCommon.sextantLostLandCenterY
	else
		return MapCommon.sextantDefaultCenterX, MapCommon.sextantDefaultCenterY
	end
	

end

function MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, facet, area)
	local sectCenterX, sectCenterY = MapCommon.GetSextantCenterByArea(facet, area)

	local minutesX = (longVal - math.floor(longVal)) * 100

	local minutesY = (latVal - math.floor(latVal)) * 100
	local ylat = math.floor(latVal)
	local xlong = math.floor(longVal)
	
	local absLat = ylat + (minutesY / 60)
	local absLong = xlong + (minutesX / 60)
	
	if(latDir == L"N") then
		absLat = 360 - absLat
	end
	
	if(longDir == L"W") then
		absLong = 360 - absLong
	end
	
	local x = sectCenterX + ((absLong * MapCommon.sextantMaximumX) / 360)
	local y = sectCenterY + ((absLat * MapCommon.sextantMaximumY) / 360)
	
	--if( (facet == 0 and area == MapCommon.sextantFeluccaLostLands) or (facet == 1 and area == MapCommon.sextantTrammelLostLands) ) then
	--	if (x < MapCommon.sextantLostLandTopRightX) then
	--		x = x + MapCommon.sextantLostLandTopLeftX
	--	end
	--	if (x >= MapCommon.sextantLostLandTopLeftX) then
	--		x = x - MapCommon.sextantLostLandTopLeftX
	--	end
	--	if (y < MapCommon.sextantLostLandTopLeftY) then
	--		y = y + MapCommon.sextantLostLandBottomLeftY
	--	end
	--	if (y >= MapCommon.sextantLostLandBottomLeftY) then
	--		y = y - MapCommon.sextantLostLandBottomLeftY
	--	end
	--else
		if (x < 0) then
			x = x + MapCommon.sextantMaximumX
		end
		if (x >= MapCommon.sextantMaximumX) then
			x = x - MapCommon.sextantMaximumX
		end
		if (y < 0) then
			y = y + MapCommon.sextantMaximumY
		end
		if (y >= MapCommon.sextantMaximumY) then
			y = y - MapCommon.sextantMaximumY
		end		
	--end
	return x, y
end

function MapCommon.GetSextantCenter(x,y,facet)
	if( (facet == 0 or facet == 1) and (x >= MapCommon.sextantLostLandTopLeftX) and (y >= MapCommon.sextantLostLandTopLeftY)) then
		return MapCommon.sextantLostLandCenterX, MapCommon.sextantLostLandCenterY
	else
		return MapCommon.sextantDefaultCenterX, MapCommon.sextantDefaultCenterY
	end
end

function MapCommon.ConvertToMinutesXY(x,y,facet)
	local sectCenterX, sectCenterY = MapCommon.GetSextantCenter(x,y,facet) 
    
	local minutesX = 21600 * (x - sectCenterX) / MapCommon.sextantMaximumX
	local minutesY = 21600 * (y - sectCenterY) / MapCommon.sextantMaximumY

	if minutesX > 10800 then
		minutesX = minutesX - 21600
	end
	if minutesX <= -10800 then
		minutesX = minutesX + 21600
	end
	if minutesY > 10800 then
		minutesY = minutesY - 21600
	end
	if minutesY <= -10800 then
		minutesY = minutesY + 21600
	end
	
	return minutesX, minutesY
end

function MapCommon.GetSextantLocationStrings(x,y,facet)
    local minutesX, minutesY = MapCommon.ConvertToMinutesXY(x,y,facet)
  
    local latDir = L"S"
    local longDir = L"E"
    
    if minutesY < 0 then
		latDir = L"N"
		minutesY = -minutesY
	end
    if minutesX < 0 then
		longDir = L"W"
		minutesX = -minutesX
    end
    
    local latString = StringToWString( string.format( "%d", (minutesY/60) ) )..L"."..StringToWString( string.format( "%02d", (minutesY%60) ) )
    local longString = StringToWString( string.format( "%d", (minutesX/60) ) )..L"."..StringToWString( string.format( "%02d", (minutesX%60) ) )
    
    return latString, longString, latDir, longDir
end

function MapCommon.WaypointMouseOver()
    if( MapCommon.ActiveView ~= nil ) then
        if( DoesWindowExist("WaypointInfo") ) then
            DestroyWindow("WaypointInfo")
        end
        
        MapCommon.WaypointIsMouseOver = true
        
        local waypointId = WindowGetId(SystemData.ActiveWindow.name)
        local waypointWindow = "Waypoint"..waypointId..MapCommon.ActiveView
        local waypointName = "Invalid Waypoint"
        local waypointX = 0
        local waypointY = 0
        
        if( waypointId ~= MapCommon.WaypointPlayerId ) then
			local wtype, wflags, wname, wfacet, wx, wy, wz
			if (waypointId > 50000 ) then
				if (EnhancePack.GuildMembers[waypointId]) then
					wtype = 2
					wflags = 0
					wname = EnhancePack.GuildMembers[waypointId].name
					wfacet = EnhancePack.GuildMembers[waypointId].wfacet
					wx = tonumber(EnhancePack.GuildMembers[waypointId].x)
					wy = tonumber(EnhancePack.GuildMembers[waypointId].y)
					wz = tonumber(EnhancePack.GuildMembers[waypointId].z)
				elseif(TrackingPointer.TrackWaypoints[waypointId]) then
					wtype = 13
					wflags = 0
					wname = L"Tracked Target"
					wfacet = TrackingPointer.TrackWaypoints[waypointId].facet
					wx = tonumber(TrackingPointer.TrackWaypoints[waypointId].PointerX)
					wy = tonumber(TrackingPointer.TrackWaypoints[waypointId].PointerY)
					wz = 0
				else
					wtype = nil
				end
			elseif (waypointId > 10000 ) then
				local data = Waypoints.UOGetWaypointInfo(waypointId - 10000, UOGetRadarFacet()) 
				if data then
					wtype = data.wtype
					wflags = data.wflags
					wname = StringToWString(data.wname)
					wfacet = data.wfacet
					wx = tonumber(data.wx)
					wy = tonumber(data.wy)
					wz = tonumber(data.wz)	
				end
			else
				wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId)
				local texto = string.find(WStringToString(wname) , "_ICON_")
				if (texto) then
					local strip = string.sub(WStringToString(wname), 1 , texto - 1)
					wname = StringToWString(strip)
				end
			end
            if (wtype == nil) then
				DestroyWindow(waypointWindow)
				return
            end
            
            waypointName = wname
            waypointX = wx
            waypointY = wy
            waypointFacet = wfacet
        else
            waypointName = GetStringFromTid(MapCommon.TID.YourLocation)
            waypointX = WindowData.PlayerLocation.x
            waypointY = WindowData.PlayerLocation.y
            waypointFacet = WindowData.PlayerLocation.facet
        end
        
        CreateWindowFromTemplate("WaypointInfo","WaypointInfoTemplate", "Root")
        WindowClearAnchors("WaypointInfo")
        WindowAddAnchor("WaypointInfo","center",waypointWindow,"bottomleft",0,0)
                
        LabelSetText("WaypointInfoDetails",waypointName)
        local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(waypointX, waypointY, waypointFacet)
        LabelSetText("WaypointInfoLocation", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir .. L"\n" .. waypointX .. L", " .. waypointY)
        
        if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
        
			local Sextant = latStr..L"'"..latDir..L" "..longStr..L"'"..longDir .. L"\n" .. waypointX .. L", " .. waypointY
			
	
			LabelSetText("MapWindowCoordsText", Sextant) 
			--LabelSetText("MapWindowCoordsText", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
        end
        
        local w1, h1 = LabelGetTextDimensions("WaypointInfoDetails")
        local w2, h2 = LabelGetTextDimensions("WaypointInfoLocation")
        local infoWindowWidth = math.max(w1,w2) + 6
        local infoWindowHeight = h1 + h2 + 9
        
        WindowSetDimensions("WaypointInfo",infoWindowWidth,infoWindowHeight)
    end
end

function MapCommon.WaypointMouseOverEnd()
	MapCommon.WaypointIsMouseOver = false
	
    if( DoesWindowExist("WaypointInfo") ) then
        DestroyWindow("WaypointInfo")
    end    
end

function MapCommon.WaypointOnRButtonUp()
	local waypointWindowName = SystemData.ActiveWindow.name
	local waypointId = WindowGetId(waypointWindowName)
	local params = {id=waypointId, x=nil, y=nil, facetId=UOGetRadarFacet(), type=nil, name=nil}
	
	if (waypointId == MapCommon.WaypointPlayerId) then
		params.x, params.y = WindowData.PlayerLocation.x, WindowData.PlayerLocation.y
		params.type = MapCommon.WaypointPlayerType
		params.name = GetStringFromTid(MapCommon.TID.YourLocation)
	else
		local wtype, wflags, wname, wfacet, wx, wy, wz, scale
		if (waypointId > 50000 ) then
			if (EnhancePack.GuildMembers[waypointId]) then
				wtype = 2
				wflags = 0
				wname = EnhancePack.GuildMembers[waypointId].name
				wfacet = EnhancePack.GuildMembers[waypointId].wfacet
				wx = tonumber(EnhancePack.GuildMembers[waypointId].x)
				wy = tonumber(EnhancePack.GuildMembers[waypointId].y)
				wz = tonumber(EnhancePack.GuildMembers[waypointId].z)
			elseif(TrackingPointer.TrackWaypoints[waypointId]) then
				wtype = 13
				wflags = 0
				wname = L"Tracked Target"
				wfacet = TrackingPointer.TrackWaypoints[waypointId].facet
				wx = tonumber(TrackingPointer.TrackWaypoints[waypointId].PointerX)
				wy = tonumber(TrackingPointer.TrackWaypoints[waypointId].PointerY)
				wz = 0
			else
				wtype = nil
			end
		elseif (waypointId > 10000 ) then
			local data = Waypoints.UOGetWaypointInfo(waypointId - 10000, UOGetRadarFacet()) 
			if data then
				wtype = data.wtype
				wflags = data.wflags
				wname = StringToWString(data.wname)
				wfacet = data.wfacet
				wx = tonumber(data.wx)
				wy = tonumber(data.wy)
				wz = tonumber(data.wz)	
				scale = Waypoints.Facet[wfacet][waypointId - 10000].Scale
			end

		else
			wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId)
		end
		if (wtype == nil) then
			DestroyWindow(waypointWindowName)
			return
        end
		params.x, params.y = wx, wy
		params.type = wtype
		params.name = wname
		params.scale = scale
	end
	
	-- IF CUSTOM WAYPOINT TYPE, SHOW DELETE WAYPOINT
	if (SystemData.Waypoint.TypeIsCustomizable[params.type] == 1) then
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.DeleteWaypoint,0,MapCommon.ContextReturnCodes.DELETE_WAYPOINT,params)
	-- IF PLAYER WAYPOINT TYPE, SHOW CREATE WAYPOINT UI	
	elseif (waypointId == MapCommon.WaypointPlayerId) then
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.CreateWaypoint,0,MapCommon.ContextReturnCodes.CREATE_WAYPOINT,params)
	-- IF REGULAR WAYPOINT TYPE, SHOW VIEW WAYPOINT UI	
	else
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.ViewWaypoint,0,MapCommon.ContextReturnCodes.VIEW_WAYPOINT,params)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5103),0,"magnetize", params,false)
	
	ContextMenu.ActivateLuaContextMenu(MapCommon.ContextMenuCallback)
end

function MapCommon.ContextMenuCallback(returnCode, params)
	
	if( params ~= nil ) then
		if (returnCode == "magnetize") then
			Compass.Close()
			Compass.MagnetPoint = {waypointId = nil; x = 0; y = 0; facet = 0;}
			Compass.MagnetPoint.x = params.x
			Compass.MagnetPoint.y = params.y
			Compass.MagnetPoint.facet = params.facetId
			Compass.MagnetPoint.waypointId = params.id
			Compass.delta = 100
			WindowSetShowing("Compass", true)
		elseif (returnCode == MapCommon.ContextReturnCodes.CREATE_WAYPOINT) then
			UserWaypointWindow.InitializeCreateWaypointData(params)
		elseif(returnCode == MapCommon.ContextReturnCodes.DELETE_WAYPOINT) then
			UODeleteUserWaypoint(params.id)
			local waypointId = params.id
			local windowName = "Waypoint"..waypointId..MapCommon.ActiveView
			MapCommon.WaypointViewInfo[MapCommon.ActiveView].Windows[waypointId] = nil
			--if (DoesWindowNameExist(windowName)) then
			DestroyWindow(windowName)
			--end
			MapCommon.ForcedUpdate = true
			MapCommon.UpdateWaypoints(MapCommon.ActiveView)
		elseif(returnCode == MapCommon.ContextReturnCodes.VIEW_WAYPOINT) then
			UserWaypointWindow.InitializeViewWaypointData(params)
		end
	else
		local text = string.find(returnCode, "callFacet") 
		if (text) then
			local facet = tonumber(string.sub(returnCode, 10))
			local area = 0
			MapWindow.CenterOnPlayer = false
			ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
			UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
			MapCommon.ChangeMap(facet, area)
		else
			local facet = UOGetRadarFacet()
			local area = tonumber(string.sub(returnCode, 9))
			
			MapWindow.CenterOnPlayer = false
			ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
			UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
			MapCommon.ChangeMap(facet, area)
		end
	end
	
end

function MapCommon.GetRadarBorders(facet, area)
	if not area then
		return 0,0,0,0
	end
	if not facet then
		return 0,0,0,0
	end
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
	
	if( x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil ) then
	    local upperLeftX, upperLeftY = UOGetWorldPosToRadar(x1, y1)
	    local upperRightX, upperRightY = UOGetWorldPosToRadar(x2, y1)
	    local lowerLeftX, lowerLeftY = UOGetWorldPosToRadar(x1, y2)
	    local lowerRightX, lowerRightY = UOGetWorldPosToRadar(x2, y2)
    	
	    -- top, bottom, left, right
	    return upperLeftY, lowerRightY, lowerLeftX, upperRightX
	else
	    return 0,0,0,0
	end
end