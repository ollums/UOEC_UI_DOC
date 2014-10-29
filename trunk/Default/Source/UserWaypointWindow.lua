----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

UserWaypointWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

UserWaypointWindow.TID = { Okay = 3000093, Cancel=1006045, CreateWaypoint=1079482, EditWaypoint=1079483,
					     Create=1077830, DeleteWaypoint=1079484, SelectAFacet=1079512, Type=1078603,
					     WaypointName=1079514, Coordinates=1079515, X=1112100, Y=1112101,
					     SelectAnIcon=1079519, MissingWaypointNameError=1079520, InvalidRangeCoordError=1079521,
					     Lat=1080540, Long=1080541, ViewWaypoint=1079571, East=1075387, West=1075390,
					     North=1075389, South=1075386}

UserWaypointWindow.Params = nil
UserWaypointWindow.XYcoords = false

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function UserWaypointWindow.Initialize()
	RegisterWindowData(WindowData.WaypointDisplay.Type,0)

	LabelSetText("UserWaypointWindowNamePrompt", GetStringFromTid(UserWaypointWindow.TID.WaypointName))
	LabelSetText("UserWaypointWindowTypePrompt", GetStringFromTid(UserWaypointWindow.TID.Type))
    LabelSetText("UserWaypointWindowFacetPrompt", GetStringFromTid(UserWaypointWindow.TID.SelectAFacet))
    
	LabelSetText("UserWaypointWindowLatPrompt", GetStringFromTid(UserWaypointWindow.TID.Lat))
	LabelSetText("UserWaypointWindowLongPrompt", GetStringFromTid(UserWaypointWindow.TID.Long))
	
	LabelSetText("UserWaypointWindowXPrompt", GetStringFromTid(UserWaypointWindow.TID.X))
	LabelSetText("UserWaypointWindowYPrompt", GetStringFromTid(UserWaypointWindow.TID.Y))
	
	-- Set up Latitude direction combo box
	ComboBoxAddMenuItem( "UserWaypointWindowLatDirCombo", GetStringFromTid(UserWaypointWindow.TID.North) )
	ComboBoxAddMenuItem( "UserWaypointWindowLatDirCombo", GetStringFromTid(UserWaypointWindow.TID.South) )
	
	-- Set up Longitude direction combo box
	ComboBoxAddMenuItem( "UserWaypointWindowLongDirCombo", GetStringFromTid(UserWaypointWindow.TID.West) )
	ComboBoxAddMenuItem( "UserWaypointWindowLongDirCombo", GetStringFromTid(UserWaypointWindow.TID.East) )
	
	ButtonSetText("UserWaypointWindowOKButton",  GetStringFromTid(UserWaypointWindow.TID.Okay)) 
	ButtonSetText("UserWaypointWindowCancelButton",  GetStringFromTid(UserWaypointWindow.TID.Cancel))

    -- These are not editable yet
	WindowSetShowing("UserWaypointWindowTypeText",false)
	WindowSetShowing("UserWaypointWindowFacetText",false)
end

function UserWaypointWindow.Shutdown()
	UnregisterWindowData(WindowData.WaypointDisplay.Type,0)
end

function UserWaypointWindow.InitializeCreateWaypointData(params)
	-- DEFAULT VALUES FOR NEW CUSTOM WAYPOINTS
	params.type = MapCommon.WaypointCustomType
	
	UserWaypointWindow.Params = params
	
	WindowUtils.SetWindowTitle("UserWaypointWindow", GetStringFromTid(UserWaypointWindow.TID.CreateWaypoint))
	WindowSetShowing("UserWaypointWindowCancelButton", true)
	
	TextEditBoxSetText("UserWaypointWindowNameTextEditBox",L"")
	LabelSetText("UserWaypointWindowTypeLabel",WindowData.WaypointDisplay.typeNames[params.type])
	
	UserWaypointWindow.XYcoords = false
	
	UserWaypointWindow.UpdateCoordInfo(params.x, params.y, params.facetId)
	
	WindowSetShowing("UserWaypointWindowNameText",true)
	WindowSetShowing("UserWaypointWindowNameLabel",false)
	
	-- Hide display-only windows
	WindowSetShowing("UserWaypointWindowLatLabel",false)
	WindowSetShowing("UserWaypointWindowLongLabel",false)
	WindowSetShowing("UserWaypointWindowXLabel",false)
	WindowSetShowing("UserWaypointWindowYLabel",false)
	
	-- Show input-related windows
	WindowSetShowing("UserWaypointWindowLatText",true)
	WindowSetShowing("UserWaypointWindowLongText",true)
	WindowSetShowing("UserWaypointWindowLatDirCombo",true)
	WindowSetShowing("UserWaypointWindowLongDirCombo",true)
	WindowSetShowing("UserWaypointWindowXText",true)
	WindowSetShowing("UserWaypointWindowYText",true)
	
	-- Show latitude/longitude windows first
	WindowSetShowing("UserWaypointWindowLat",true)
	WindowSetShowing("UserWaypointWindowLong",true)
	WindowSetShowing("UserWaypointWindowX",false)
	WindowSetShowing("UserWaypointWindowY",false)
	
    WindowSetShowing("UserWaypointWindow", true)
    WindowAssignFocus("UserWaypointWindowNameTextEditBox", true)	
end

function UserWaypointWindow.InitializeViewWaypointData(params)
    UserWaypointWindow.Params = params

	WindowUtils.SetWindowTitle("UserWaypointWindow",  GetStringFromTid(UserWaypointWindow.TID.ViewWaypoint))
	
	WindowSetShowing("UserWaypointWindowCancelButton", false)
	
	LabelSetText("UserWaypointWindowNameLabel",params.name)
	LabelSetText("UserWaypointWindowTypeLabel",WindowData.WaypointDisplay.typeNames[params.type])
	
	UserWaypointWindow.XYcoords = false
	
	UserWaypointWindow.UpdateCoordInfo(params.x, params.y, params.facetId)
	
	WindowSetShowing("UserWaypointWindowNameText",false)
	WindowSetShowing("UserWaypointWindowNameLabel",true)
	
	-- Show display-only windows
	WindowSetShowing("UserWaypointWindowLatLabel",true)
	WindowSetShowing("UserWaypointWindowLongLabel",true)
	WindowSetShowing("UserWaypointWindowXLabel",true)
	WindowSetShowing("UserWaypointWindowYLabel",true)
	
	-- Hide input-related windows
	WindowSetShowing("UserWaypointWindowLatText",false)
	WindowSetShowing("UserWaypointWindowLongText",false)
	WindowSetShowing("UserWaypointWindowLatDirCombo",false)
	WindowSetShowing("UserWaypointWindowLongDirCombo",false)
	WindowSetShowing("UserWaypointWindowXText",false)
	WindowSetShowing("UserWaypointWindowYText",false)
	
	-- Show latitude/longitude windows first
	WindowSetShowing("UserWaypointWindowLat",true)
	WindowSetShowing("UserWaypointWindowLong",true)
	WindowSetShowing("UserWaypointWindowX",false)
	WindowSetShowing("UserWaypointWindowY",false)
	
    WindowSetShowing("UserWaypointWindow", true)	
end

function UserWaypointWindow.ToggleCoord()
	if (UserWaypointWindow.XYcoords == false) then
		-- Show X/Y windows
		WindowSetShowing("UserWaypointWindowLat",false)
		WindowSetShowing("UserWaypointWindowLong",false)
		WindowSetShowing("UserWaypointWindowX",true)
		WindowSetShowing("UserWaypointWindowY",true)
		
		-- If waypoint is being created
		if (UserWaypointWindow.Params.type == MapCommon.WaypointCustomType) then
			-- Retrieve latitude/longitude values
			local area = UOGetRadarArea()
			local latVal = tonumber(TextEditBoxGetText("UserWaypointWindowLatTextEditBox"))
			local longVal = tonumber(TextEditBoxGetText("UserWaypointWindowLongTextEditBox"))
			local latDir = L"N"
			local longDir = L"W"
			if (ComboBoxGetSelectedMenuItem("UserWaypointWindowLatDirCombo") == 2) then
				latDir = L"S"
			end
			if (ComboBoxGetSelectedMenuItem("UserWaypointWindowLongDirCombo") == 2) then
				longDir = L"E"
			end
			
			-- Convert to latitude/longitude to x/y
			UserWaypointWindow.Params.x, UserWaypointWindow.Params.y = MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, UserWaypointWindow.Params.facetId, area)
			
			-- Update input boxes with new values
			UserWaypointWindow.UpdateCoordInfo(UserWaypointWindow.Params.x, UserWaypointWindow.Params.y, UserWaypointWindow.Params.facetId)
			
			-- Hide N/S and W/E comboboxes
			WindowSetShowing("UserWaypointWindowLatDirCombo",false)
			WindowSetShowing("UserWaypointWindowLongDirCombo",false)
		end
		
		UserWaypointWindow.XYcoords = true
	else
		-- Show Latitude/Longitude windows
		WindowSetShowing("UserWaypointWindowLat",true)
		WindowSetShowing("UserWaypointWindowLong",true)
		WindowSetShowing("UserWaypointWindowX",false)
		WindowSetShowing("UserWaypointWindowY",false)
		
		-- If waypoint is being created
		if (UserWaypointWindow.Params.type == MapCommon.WaypointCustomType) then
			-- Retrieve x/y values
			UserWaypointWindow.Params.x = tonumber(TextEditBoxGetText("UserWaypointWindowXTextEditBox"))
			UserWaypointWindow.Params.y = tonumber(TextEditBoxGetText("UserWaypointWindowYTextEditBox"))
			
			-- Update the input boxes with new values
			UserWaypointWindow.UpdateCoordInfo(UserWaypointWindow.Params.x, UserWaypointWindow.Params.y, UserWaypointWindow.Params.facetId)
			
			-- Show N/S and W/E comboboxes
			WindowSetShowing("UserWaypointWindowLatDirCombo",true)
			WindowSetShowing("UserWaypointWindowLongDirCombo",true)
		end
		
		UserWaypointWindow.XYcoords = false
	end
end

function UserWaypointWindow.ToggleCoordMouseOver()
	local buttonName = "UserWaypointWindowToggleCoordButton"
	local text = GetStringFromTid(1112099)
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function UserWaypointWindow.UpdateCoordInfo(x, y, facet)
	LabelSetText("UserWaypointWindowFacetLabel",GetStringFromTid(UORadarGetFacetLabel(facet)))
	
	local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, facet)
	
	-- If waypoint is being created
	if(UserWaypointWindow.Params.type == MapCommon.WaypointCustomType) then
		TextEditBoxSetText("UserWaypointWindowLatTextEditBox", latStr)
		TextEditBoxSetText("UserWaypointWindowLongTextEditBox", longStr)
		TextEditBoxSetText("UserWaypointWindowXTextEditBox", StringToWString(string.format("%.0f",x)) )
		TextEditBoxSetText("UserWaypointWindowYTextEditBox", StringToWString(string.format("%.0f",y)) )
		
		if(latDir == L"N") then
			ComboBoxSetSelectedMenuItem( "UserWaypointWindowLatDirCombo", 1)
		else
			ComboBoxSetSelectedMenuItem( "UserWaypointWindowLatDirCombo", 2)
		end
		
		if(longDir == L"W") then
			ComboBoxSetSelectedMenuItem( "UserWaypointWindowLongDirCombo", 1)
		else
			ComboBoxSetSelectedMenuItem( "UserWaypointWindowLongDirCombo", 2)
		end
	else
		LabelSetText("UserWaypointWindowLatLabel",latStr..L"'"..latDir)
		LabelSetText("UserWaypointWindowLongLabel",longStr..L"'"..longDir)
		LabelSetText("UserWaypointWindowXLabel", StringToWString(string.format("%.0f",x)) )
		LabelSetText("UserWaypointWindowYLabel", StringToWString(string.format("%.0f",y)) )
	end
end

function UserWaypointWindow.OnOkay()
	-- If waypoint is being created
    if( UserWaypointWindow.Params.type == MapCommon.WaypointCustomType ) then
		-- Retrieve waypoint name
        local name = TextEditBoxGetText("UserWaypointWindowNameTextEditBox")
        if( name == L"" ) then
            return
        end
        
        if (UserWaypointWindow.XYcoords == true) then
			-- Retreive x/y coords
			local x = TextEditBoxGetText("UserWaypointWindowXTextEditBox")
			local y = TextEditBoxGetText("UserWaypointWindowYTextEditBox")
			
			if (x == L"" or y == L"") then
				return
			end
			
			UserWaypointWindow.Params.x = tonumber(x)
			UserWaypointWindow.Params.y = tonumber(y)
        else
			-- Retrieve latitude/longitude coords
			local latVal = TextEditBoxGetText("UserWaypointWindowLatTextEditBox")
			local longVal = TextEditBoxGetText("UserWaypointWindowLongTextEditBox")
			if (latVal == L"" or longVal == L"") then
				return
			end
			local latDir = L"N"
			local longDir = L"W"
			if (ComboBoxGetSelectedMenuItem("UserWaypointWindowLatDirCombo") == 2) then
				latDir = L"S"
			end
			if (ComboBoxGetSelectedMenuItem("UserWaypointWindowLongDirCombo") == 2) then
				longDir = L"E"
			end
			local area = UOGetRadarArea()
			
			-- Convert to x/y coords
			UserWaypointWindow.Params.x, UserWaypointWindow.Params.y = MapCommon.ConvertToXYMinutes(tonumber(latVal), tonumber(longVal), latDir, longDir, UserWaypointWindow.Params.facetId, area)
        end
        
        UOCreateUserWaypoint( UserWaypointWindow.Params.type, UserWaypointWindow.Params.x, UserWaypointWindow.Params.y, UserWaypointWindow.Params.facetId, name )
    end
    
    WindowSetShowing("UserWaypointWindow", false)	
end

function UserWaypointWindow.OnCancel()
    WindowSetShowing("UserWaypointWindow", false)
end