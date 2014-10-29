----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapWaypoints = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MapWaypoints.TID = { Okay = 3000093, Cancel=1006045, CreateWaypoint=1079482, EditWaypoint=1079483,
					     Create=1077830, DeleteWaypoint=1079484, SelectAFacet=1079512, Type=1078603,
					     WaypointName=1079514, Coordinates=1079515, X=1112100, Y=1112101,
					     SelectAnIcon=1079519, MissingWaypointNameError=1079520, InvalidRangeCoordError=1079521,
					     Lat=1080540, Long=1080541, ViewWaypoint=1079571, East=1075387, West=1075390,
					     North=1075389, South=1075386}

MapWaypoints.Params = nil
MapWaypoints.XYcoords = false

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------


function MapWaypoints.Initialize()
    WindowUtils.RestoreWindowPosition("MapWaypoints")
    WindowUtils.SetWindowTitle("MapWaypoints", GetStringFromTid(MapWaypoints.TID.CreateWaypoint))
    
	LabelSetText("MapWaypointsLatPrompt", GetStringFromTid(MapWaypoints.TID.Lat))
	LabelSetText("MapWaypointsLongPrompt", GetStringFromTid(MapWaypoints.TID.Long))
	
	LabelSetText("MapWaypointsXPrompt", GetStringFromTid(MapWaypoints.TID.X))
	LabelSetText("MapWaypointsYPrompt", GetStringFromTid(MapWaypoints.TID.Y))
	
	-- Set up Latitude direction combo box
	ComboBoxAddMenuItem( "MapWaypointsLatDirCombo", GetStringFromTid(MapWaypoints.TID.North) )
	ComboBoxAddMenuItem( "MapWaypointsLatDirCombo", GetStringFromTid(MapWaypoints.TID.South) )
	
	-- Set up Longitude direction combo box
	ComboBoxAddMenuItem( "MapWaypointsLongDirCombo", GetStringFromTid(MapWaypoints.TID.West) )
	ComboBoxAddMenuItem( "MapWaypointsLongDirCombo", GetStringFromTid(MapWaypoints.TID.East) )
	
	ButtonSetText("MapWaypointsOKButton",  GetStringFromTid(MapWaypoints.TID.Okay)) 
	ButtonSetText("MapWaypointsCancelButton",  GetStringFromTid(MapWaypoints.TID.Cancel))

	WindowSetShowing("MapWaypoints", false)
end

function MapWaypoints.Shutdown()
	WindowUtils.SaveWindowPosition("MapWaypoints")
	DestroyWindow("MapWaypoints")
end

function MapWaypoints.InitializeCreateWaypointData(params)
	
	MapWaypoints.Params = params
	
	--WindowUtils.SetWindowTitle("MapWaypoints", GetStringFromTid(MapWaypoints.TID.CreateWaypoint))
	WindowSetShowing("MapWaypointsCancelButton", true)
	
	
	
	
	
	MapWaypoints.XYcoords = false

	MapWaypoints.UpdateCoordInfo(params.x, params.y, 1)


	
	-- Hide display-only windows
	WindowSetShowing("MapWaypointsLatLabel",false)
	WindowSetShowing("MapWaypointsLongLabel",false)
	WindowSetShowing("MapWaypointsXLabel",false)
	WindowSetShowing("MapWaypointsYLabel",false)
	
	-- Show input-related windows
	WindowSetShowing("MapWaypointsLatText",true)
	WindowSetShowing("MapWaypointsLongText",true)
	WindowSetShowing("MapWaypointsXText",true)
	WindowSetShowing("MapWaypointsYText",true)
	
	
		MapWaypoints.XYcoords = false
		WindowSetShowing("MapWaypointsToggleCoordButton", true)
		MapWaypoints.UpdateCoordInfo(params.x, params.y, params.facetId)
		-- Show latitude/longitude windows first
		WindowSetShowing("MapWaypointsLat",true)
		WindowSetShowing("MapWaypointsLong",true)
		WindowSetShowing("MapWaypointsX",false)
		WindowSetShowing("MapWaypointsY",false)
WindowSetShowing("MapWaypointsLatDirCombo",true)
			WindowSetShowing("MapWaypointsLongDirCombo",true)
	
    WindowSetShowing("MapWaypoints", true)	
end

function MapWaypoints.InitializeViewWaypointData(params)
	WindowSetScale("MapWaypointsTypeIcon", 1)
    MapWaypoints.Params = params

	WindowUtils.SetWindowTitle("MapWaypoints",  GetStringFromTid(MapWaypoints.TID.ViewWaypoint))
	
	WindowSetShowing("MapWaypointsCancelButton", false)
	
	LabelSetText("MapWaypointsNameLabel",params.name)
	--LabelSetText("MapWaypointsTypeLabel",WindowData.WaypointDisplay.typeNames[params.type])
	
	--- ICONS
	ComboBoxClearMenuItems("MapWaypointsTypeLabel")
	local n = table.getn(MapWaypoints.Icons)
	for i = 1, n do
		ComboBoxAddMenuItem( "MapWaypointsTypeLabel", MapWaypoints.Icons[i].name )
	end

	local selection = params.type
	--Debug.Print(params.type)
	if (params.type == 11) then
		selection = 11
	elseif (params.type == 10) then
		selection = 4
	elseif (params.type == 9) then
		selection = 3
	elseif (params.type == 12) then
		selection = 8
	elseif (params.type == 7) then
		selection = 2
	elseif (params.type == 2) then
		selection = 9
	end
	ComboBoxSetSelectedMenuItem( "MapWaypointsTypeLabel", selection)
	
	
	local iconId = MapWaypoints.Icons[selection].id
	local iconTexture, x, y = GetIconData(iconId)
    local iconWidth, iconHeight = UOGetTextureSize("icon"..iconId)

    WindowSetDimensions("MapWaypointsTypeIcon", iconWidth, iconHeight)
    DynamicImageSetTextureDimensions("MapWaypointsTypeIcon", iconWidth, iconHeight)
    DynamicImageSetTexture("MapWaypointsTypeIcon", iconTexture, x, y)
    
	
	
	
	
	WindowSetShowing("MapWaypointsNameText",false)
	WindowSetShowing("MapWaypointsNameLabel",true)
	
	-- Show display-only windows
	WindowSetShowing("MapWaypointsLatLabel",true)
	WindowSetShowing("MapWaypointsLongLabel",true)
	WindowSetShowing("MapWaypointsXLabel",true)
	WindowSetShowing("MapWaypointsYLabel",true)
	
	-- Hide input-related windows
	WindowSetShowing("MapWaypointsLatText",false)
	WindowSetShowing("MapWaypointsLongText",false)
	WindowSetShowing("MapWaypointsLatDirCombo",false)
	WindowSetShowing("MapWaypointsLongDirCombo",false)
	WindowSetShowing("MapWaypointsXText",false)
	WindowSetShowing("MapWaypointsYText",false)
	

	MapWaypoints.XYcoords = false
	WindowSetShowing("MapWaypointsToggleCoordButton", true)
	MapWaypoints.UpdateCoordInfo(params.x, params.y, params.facetId)
	-- Show latitude/longitude windows first
	WindowSetShowing("MapWaypointsLat",true)
	WindowSetShowing("MapWaypointsLong",true)
	WindowSetShowing("MapWaypointsX",false)
	WindowSetShowing("MapWaypointsY",false)
	WindowSetShowing("MapWaypointsLatDirCombo",true)
	WindowSetShowing("MapWaypointsLongDirCombo",true)

	
	
	
    WindowSetShowing("MapWaypoints", true)	
end

function MapWaypoints.ToggleCoord()
	if (MapWaypoints.XYcoords == false) then
		-- Show X/Y windows
		WindowSetShowing("MapWaypointsLat",false)
		WindowSetShowing("MapWaypointsLong",false)
		WindowSetShowing("MapWaypointsX",true)
		WindowSetShowing("MapWaypointsY",true)
		
		-- If waypoint is being created

			-- Retrieve latitude/longitude values
			local area = UOGetRadarArea()
			local latVal = tonumber(TextEditBoxGetText("MapWaypointsLatTextEditBox"))

			local longVal = tonumber(TextEditBoxGetText("MapWaypointsLongTextEditBox"))
			local latDir = L"N"
			local longDir = L"W"
			if (ComboBoxGetSelectedMenuItem("MapWaypointsLatDirCombo") == 2) then
				latDir = L"S"
			end
			if (ComboBoxGetSelectedMenuItem("MapWaypointsLongDirCombo") == 2) then
				longDir = L"E"
			end
			
			-- Convert to latitude/longitude to x/y
			
			MapWaypoints.Params.x, MapWaypoints.Params.y = MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, 1, 0)
			
			-- Update input boxes with new values
			MapWaypoints.UpdateCoordInfo(MapWaypoints.Params.x, MapWaypoints.Params.y, 1)
			
			-- Hide N/S and W/E comboboxes
			WindowSetShowing("MapWaypointsLatDirCombo",false)
			WindowSetShowing("MapWaypointsLongDirCombo",false)
	
		
		MapWaypoints.XYcoords = true
	else
		-- Show Latitude/Longitude windows
		WindowSetShowing("MapWaypointsLat",true)
		WindowSetShowing("MapWaypointsLong",true)
		WindowSetShowing("MapWaypointsX",false)
		WindowSetShowing("MapWaypointsY",false)
		
		-- If waypoint is being created
	
			-- Retrieve x/y values
			MapWaypoints.Params.x = tonumber(TextEditBoxGetText("MapWaypointsXTextEditBox"))
			MapWaypoints.Params.y = tonumber(TextEditBoxGetText("MapWaypointsYTextEditBox"))
			
			-- Update the input boxes with new values
			MapWaypoints.UpdateCoordInfo(MapWaypoints.Params.x, MapWaypoints.Params.y, MapWaypoints.Params.facetId)
			
			-- Show N/S and W/E comboboxes
			WindowSetShowing("MapWaypointsLatDirCombo",true)
			WindowSetShowing("MapWaypointsLongDirCombo",true)

		
		MapWaypoints.XYcoords = false
	end
end

function MapWaypoints.ToggleCoordMouseOver()
	local buttonName = "MapWaypointsToggleCoordButton"
	local text = GetStringFromTid(1112099)
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWaypoints.UpdateCoordInfo(x, y, facet)

	
	local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, 1)
	
	-- If waypoint is being created

		TextEditBoxSetText("MapWaypointsLatTextEditBox", latStr)
		TextEditBoxSetText("MapWaypointsLongTextEditBox", longStr)
		TextEditBoxSetText("MapWaypointsXTextEditBox", StringToWString(string.format("%.0f",x)) )
		TextEditBoxSetText("MapWaypointsYTextEditBox", StringToWString(string.format("%.0f",y)) )
		
		if(latDir == L"N") then
			ComboBoxSetSelectedMenuItem( "MapWaypointsLatDirCombo", 1)
		else
			ComboBoxSetSelectedMenuItem( "MapWaypointsLatDirCombo", 2)
		end
		
		if(longDir == L"W") then
			ComboBoxSetSelectedMenuItem( "MapWaypointsLongDirCombo", 1)
		else
			ComboBoxSetSelectedMenuItem( "MapWaypointsLongDirCombo", 2)
		end

end

function MapWaypoints.OnOkay()
	-- If waypoint is being created
	local toScale = MapWaypoints.Params.mapscale / 100
	local x, y
   
        local area = 0
        if (MapWaypoints.XYcoords == true) then
			-- Retreive x/y coords
			x = TextEditBoxGetText("MapWaypointsXTextEditBox")
			y = TextEditBoxGetText("MapWaypointsYTextEditBox")
			
			if (x == L"" or y == L"") then
				return
			end
			
        else
			-- Retrieve latitude/longitude coords
			local latVal = TextEditBoxGetText("MapWaypointsLatTextEditBox")
			local longVal = TextEditBoxGetText("MapWaypointsLongTextEditBox")
			if (latVal == L"" or longVal == L"") then
				return
			end
			local latDir = L"N"
			local longDir = L"W"
			if (ComboBoxGetSelectedMenuItem("MapWaypointsLatDirCombo") == 2) then
				latDir = L"S"
			end
			if (ComboBoxGetSelectedMenuItem("MapWaypointsLongDirCombo") == 2) then
				longDir = L"E"
			end

			-- Convert to x/y coords
			x, y = MapCommon.ConvertToXYMinutes(tonumber(latVal), tonumber(longVal), latDir, longDir, 1, 0)
			
        end
        local yscale = (CourseMapWindow.MapSize.squarediff / CourseMapWindow.MapSize.height) 
        y = y + (y * yscale)

    x = x * toScale
    y = y * toScale

	if(x >= 0 and x <= CourseMapWindow.CurrMapSize.width and y >= 0 and y <= CourseMapWindow.CurrMapSize.height) then
	
		if (not MapWaypoints.Params.edit) then
			CourseMapAddPoint(MapWaypoints.Params.mapId, x / MapWaypoints.Params.windowScale , y / MapWaypoints.Params.windowScale )
		else
			Debug.Print(x / MapWaypoints.Params.windowScale .. " " .. y / MapWaypoints.Params.windowScale)
			CourseMapMovePoint(MapWaypoints.Params.mapId, MapWaypoints.Params.mapPointId, x / MapWaypoints.Params.windowScale, y / MapWaypoints.Params.windowScale)
		end
	else
		if (MapWaypoints.Params.edit) then
			CourseMapDeletePoint(mapId, mapPointId)
		end
	end
    
    WindowSetShowing("MapWaypoints", false)	
end

function MapWaypoints.Update()
	if (DoesWindowNameExist("CourseMapWindow" .. MapWaypoints.Params.mapId)) then
		if (not WindowGetShowing("CourseMapWindow" .. MapWaypoints.Params.mapId) or not CourseMapIsPlotting(MapWaypoints.Params.mapId)) then
			MapWaypoints.OnCancel()
		end
	else
		MapWaypoints.OnCancel()
	end
end

function MapWaypoints.OnCancel()
    WindowSetShowing("MapWaypoints", false)
end
