----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CourseMapWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

CourseMapWindow.X_PADDING = 16
CourseMapWindow.Y_PADDING = 76

CourseMapWindow.X_MAPPOINT_PADDING = 10
CourseMapWindow.Y_MAPPOINT_PADDING = 10

CourseMapWindow.NumPointsCreated = {}
CourseMapWindow.MapPoints = {}

CourseMapWindow.DragMapPoint = ""
CourseMapWindow.DefaultScale = 0
CourseMapWindow.WINDOWSCALE = 1.4

CourseMapWindow.Name = L""

CourseMapWindow.TID = {
	PlotCourse = 3000180,
	StopPlotting = 3000181,
	ClearCourse = 3000182
}

CourseMapWindow.MapSize = { width = 5120; height = 4096; squarediff = 1024}
CourseMapWindow.CurrMapSize = { width = 5120; height = 4096}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function CourseMapWindow.Initialize()
    local mapId = SystemData.ActiveObject.Id
    local windowName = "CourseMapWindow"..mapId
    --Debug.Print(WindowData.ObjectInfo[mapId].name)
    CourseMapWindow.NumPointsCreated[mapId] = 0
    CourseMapWindow.MapPoints[mapId] = {}
    
    Interface.DestroyWindowOnClose[windowName] = true
    
    WindowSetId(windowName,mapId)
    WindowRegisterEventHandler(windowName,SystemData.Events.COURSE_MAP_DATA_UPDATED,"CourseMapWindow.UpdatePoints")
    WindowRegisterEventHandler(windowName,SystemData.Events.COURSE_MAP_STATE_UPDATED,"CourseMapWindow.UpdateState")
    
    local width, height, textureWidth, textureHeight, textureScale = GetCourseMapWindowDimensions(mapId)

    if( width ~= nil and height ~= nil and textureScale ~= nil ) then
        WindowSetDimensions(windowName, width + CourseMapWindow.X_PADDING, height + CourseMapWindow.Y_PADDING)
        CourseMapWindow.CurrMapSize.width = width
        CourseMapWindow.CurrMapSize.height = height
        WindowSetDimensions(windowName.."Texture", width, height)
        DynamicImageSetTextureDimensions(windowName.."Texture", textureWidth, textureHeight)
        DynamicImageSetTextureScale(windowName.."Texture", textureScale)
        DynamicImageSetTexture(windowName.."Texture", "CourseMap"..mapId, 0, 0)
        
        local topWidth, topHeight = WindowGetDimensions(windowName.."Top")
        topWidth = width + CourseMapWindow.X_PADDING + 30
        WindowSetDimensions(windowName.."Top",topWidth,topHeight)
        
        local bottomWidth, bottomHeight = WindowGetDimensions(windowName.."Bottom")
        bottomWidth = width + CourseMapWindow.X_PADDING + 30
        WindowSetDimensions(windowName.."Bottom",bottomWidth,bottomHeight) 
    end
    
    LabelSetText(windowName.."PlotToggle", GetStringFromTid(CourseMapWindow.TID.PlotCourse))
    LabelSetText(windowName.."ClearCourse", GetStringFromTid(CourseMapWindow.TID.ClearCourse))
    WindowSetShowing(windowName.."ClearCourse", false)
     CourseMapWindow.Name = WindowData.ObjectInfo[mapId].name
     
    local text 
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		text = wstring.find(CourseMapWindow.Name, L"Treasure Map")
	elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
		text = wstring.find(CourseMapWindow.Name, wstring.sub(GetStringFromTid(1041517), 1, - 8) )
				
	elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
		text = wstring.find(CourseMapWindow.Name, wstring.sub(GetStringFromTid(1041517), -3) )
	end
					
   
    
    if ( text ~= nil ) then
		WindowSetShowing(windowName.."PlotToggle", false)
		WindowSetShowing(windowName.."ClearCourse", false)
	else
		--CourseMapWindow.WINDOWSCALE = 2.4
    end
    
    CourseMapWindow.DefaultScale = WindowGetScale(windowName)
	WindowSetScale(windowName, CourseMapWindow.DefaultScale * CourseMapWindow.WINDOWSCALE)
	
	EnhancePack.LoadScale( windowName )
end

function CourseMapWindow.Shutdown()
    local mapId = WindowGetId(SystemData.ActiveWindow.name)
    ReleaseCourseMap(mapId)
    CourseMapWindow.MapPoints[mapId] = nil
    CourseMapWindow.NumPointsCreated[mapId] = nil
end


function CourseMapWindow.OnUpdate()
	if(CourseMapWindow.DragMapPoint ~= "") then
		if(WindowGetMoving(CourseMapWindow.DragMapPoint) == false) then
			local windowName = CourseMapWindow.DragMapPoint
			local parentWindow = WindowGetParent(windowName)
			local mapId = WindowGetId(parentWindow)
			local mapPointId = WindowGetId(CourseMapWindow.DragMapPoint)
			local scale = WindowGetScale( parentWindow )
			
			local textureWidth, textureHeight = WindowGetDimensions(parentWindow.."Texture")
			local point, relativePoint, relativeTo, xOffset, yOffset = WindowGetAnchor(CourseMapWindow.DragMapPoint, 1)
			xOffset = xOffset + CourseMapWindow.X_MAPPOINT_PADDING / scale
			yOffset = yOffset + CourseMapWindow.Y_MAPPOINT_PADDING / scale
			
			if(xOffset >= 0 and xOffset <= textureWidth and yOffset >= 0 and yOffset <= textureHeight) then
				CourseMapMovePoint(mapId, mapPointId, xOffset, yOffset)
			else
				CourseMapDeletePoint(mapId, mapPointId)
			end
			
			CourseMapWindow.DragMapPoint = ""
		end
	end
end

function CourseMapWindow.UpdatePoints()
    local mapId = SystemData.ActiveObject.Id
    local windowName = "CourseMapWindow"..mapId
    
    for i=1, CourseMapWindow.NumPointsCreated[mapId] do
        local mapPointName = windowName..mapId.."Point"..i
        WindowSetShowing(mapPointName,false)
    end

    CourseMapWindow.MapPoints[mapId] = {}
    local xPosVec, yPosVec = GetCourseMapData(mapId)
    if( xPosVec ~= nil and yPosVec ~= nil ) then
        for i=1, table.getn(xPosVec) do
            local mapPointName = windowName..mapId.."Point"..i
            
            CourseMapWindow.MapPoints[mapId][i] = {}
            CourseMapWindow.MapPoints[mapId][i].x = xPosVec[i]
            CourseMapWindow.MapPoints[mapId][i].y = yPosVec[i]
            if( i > CourseMapWindow.NumPointsCreated[mapId] ) then
                CreateWindowFromTemplate(mapPointName,"MapPoint",windowName)
                CourseMapWindow.NumPointsCreated[mapId] = CourseMapWindow.NumPointsCreated[mapId] + 1
            end
            
            WindowSetId(mapPointName, i)
            LabelSetText(mapPointName.."Name", L""..i)
            local text 
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
				text = wstring.find(CourseMapWindow.Name, L"Treasure Map")
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
				text = wstring.find(CourseMapWindow.Name, wstring.sub(GetStringFromTid(1041517), 1, - 8) )
						
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
				text = wstring.find(CourseMapWindow.Name, wstring.sub(GetStringFromTid(1041517), -3) )
			end
			if ( text ~= nil ) then
				WindowSetShowing(mapPointName.."Name", false)
			end

             
            WindowClearAnchors(mapPointName)
            WindowSetScale(mapPointName, 1)
            WindowAddAnchor(mapPointName,"topleft",windowName.."Texture","center",xPosVec[i],yPosVec[i])
            WindowSetShowing(mapPointName,true)
        end
    end
    
    
end

function CourseMapWindow.UpdateState()
	local mapId = SystemData.ActiveObject.Id
    local windowName = "CourseMapWindow"..mapId
    
    local text 
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		text = wstring.find(CourseMapWindow.Name, L"Treasure Map")
	elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
		text = wstring.find(CourseMapWindow.Name, wstring.sub(GetStringFromTid(1041517), 1, - 8) )
				
	elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
		text = wstring.find(CourseMapWindow.Name, wstring.sub(GetStringFromTid(1041517), -3) )
	end
    if ( text == nil ) then   
		if(CourseMapIsPlotting(mapId) == true) then
			LabelSetText(windowName.."PlotToggle", GetStringFromTid(CourseMapWindow.TID.StopPlotting))
			LabelSetTextColor(windowName.."PlotToggle", 50, 0, 0)
			WindowSetShowing(windowName.."ClearCourse", true)
		else
			LabelSetText(windowName.."PlotToggle", GetStringFromTid(CourseMapWindow.TID.PlotCourse))
			LabelSetTextColor(windowName.."PlotToggle", 0, 50, 0)
			WindowSetShowing(windowName.."ClearCourse", false)
		end
	end
end

function CourseMapWindow.Map_OnLButtonDown()
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapId = WindowGetId(parentWindow)
	
	if(CourseMapIsPlotting(mapId) == false) then
		WindowSetMoving(parentWindow, true)
	end
end

function CourseMapWindow.Map_OnLButtonUp(flags,x,y)
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapId = WindowGetId(parentWindow)
	if(CourseMapIsPlotting(mapId) == true ) then
		local scale = WindowGetScale( parentWindow )
		
		if (wstring.lower(CourseMapWindow.Name) == wstring.lower(GetStringFromTid(1041204)) or wstring.lower(CourseMapWindow.Name) == wstring.lower(GetStringFromTid(1015233))) then
			
			local mapScale = (CourseMapWindow.CurrMapSize.width / CourseMapWindow.MapSize.width) * 100
			local yscale = (CourseMapWindow.MapSize.squarediff / CourseMapWindow.MapSize.width) 
			
			x = (x / mapScale) * 100
			y = (y / mapScale) * 100
			y = y - (y * yscale)

			MapWaypoints.InitializeCreateWaypointData({x=x, y=y, mapId=mapId, mapscale=mapScale, windowScale=scale})
		else
			CourseMapAddPoint(mapId, x/scale, y/scale)
		end
	else
		WindowSetMoving(parentWindow, false)
	end
end

function CourseMapWindow.PlotToggle_OnLButtonUp()
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapId = WindowGetId(parentWindow)
	
	CourseMapPlotToggle(mapId)
end

function CourseMapWindow.ClearCourse_OnLButtonUp()
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapId = WindowGetId(parentWindow)
	
	CourseMapClearCourse(mapId)
end


function CourseMapWindow.OnContext(flags,x,y)
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapWindow = WindowGetParent(parentWindow)
	local mapId = WindowGetId(mapWindow)
	local scale = WindowGetScale( mapWindow )

	local param = {windowName = windowName; parentWindow = parentWindow; mapWindow = mapWindow; mapId =mapId; scale=scale;}
	if(CourseMapIsPlotting(mapId) == true ) then

		--if (wstring.lower(CourseMapWindow.Name) == wstring.lower(GetStringFromTid(1041204))) then
		--	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1079483),0,"edit",param)
		--end
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1079484),0,"delete",param)
		ContextMenu.ActivateLuaContextMenu(CourseMapWindow.ContextMenuCallback)
	end

	
end
function CourseMapWindow.ContextMenuCallback( returnCode, param )	
	if ( returnCode=="edit" ) then
		local windowName = param.windowName
		local parentWindow = param.parentWindow
		local mapId = param.mapId
		local scale = param.scale
		
		local mapPointId = WindowGetId(WindowGetParent(windowName))
		
		local mapScale = (CourseMapWindow.CurrMapSize.width / CourseMapWindow.MapSize.width) * 100
		local yscale = (CourseMapWindow.MapSize.squarediff / CourseMapWindow.MapSize.width) 
		local textureWidth, textureHeight = WindowGetDimensions(windowName)
		local point, relativePoint, relativeTo, xOffset, yOffset = WindowGetAnchor(WindowGetParent(windowName), 1)
		
		
		--xOffset = xOffset - (xOffset - (xOffset * ( 1 -(mapScale /100)) ))
		--x = (xOffset + CourseMapWindow.X_MAPPOINT_PADDING / scale) / (1 - (mapScale / 100))
		--y = (yOffset + CourseMapWindow.Y_MAPPOINT_PADDING / scale) / (1 - (mapScale / 100))
		
		xOffset = (xOffset  * scale)
		yOffset = (yOffset  * scale) 
		x = xOffset
		y = yOffset
		
		Debug.Print(x .. " " .. y)
		x = (x / mapScale) * 100
		y = (y / mapScale) * 100
		y = y - (y * yscale)

		MapWaypoints.InitializeCreateWaypointData({x=x, y=y, mapId=mapId, mapscale=mapScale, windowScale=scale, edit=true, mapPointId=mapPointId})
	elseif ( returnCode=="delete" ) then
		local windowName = param.windowName
		local mapPointId = WindowGetId(WindowGetParent(windowName))
		local mapId = param.mapId
		CourseMapDeletePoint(mapId, mapPointId)
	end
end


function CourseMapWindow.MapPoint_OnLButtonDown()
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapWindow = WindowGetParent(parentWindow)
	local mapId = WindowGetId(mapWindow)

	if(CourseMapIsPlotting(mapId) == true) then
		CourseMapWindow.DragMapPoint = parentWindow
		WindowSetMoving(parentWindow, true)
	end
end