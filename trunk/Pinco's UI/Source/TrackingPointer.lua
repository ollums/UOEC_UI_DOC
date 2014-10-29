----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TrackingPointer = {}

TrackingPointer.TrackWaypoints = {}

function TrackingPointer.OnInitialize()
	local windowName = SystemData.ActiveWindow.name

	WindowRegisterEventHandler(windowName, SystemData.Events.UPDATE_TRACKING_POINTER, "TrackingPointer.Update")
end
function TrackingPointer.OnShutdown()
	local windowName = SystemData.ActiveWindow.name
	WindowUnregisterEventHandler(windowName, SystemData.Events.UPDATE_TRACKING_POINTER)
	
	local windowId = WindowGetId(windowName)
	SystemData.TrackingPointer[windowId] = nil
	TrackingPointer.TrackWaypoints[windowId] = nil	
	MapCommon.WaypointUpdateRequest = true
end

function TrackingPointer.Update()
	local windowName = SystemData.ActiveWindow.name
	local windowId = WindowGetId(windowName)
	local pointerData = SystemData.TrackingPointer[windowId]

	if (windowId > 0 and windowId ~= WindowData.PlayerStatus.PlayerId) then
		TrackingPointer.TrackWaypoints[windowId] = pointerData
	end
	if ( pointerData.PointerType ~= 0) then
		
		local visible, x, y, rotation
		visible, x, y, rotation = TranslatePointer(pointerData.PointerType, pointerData.PointerX, pointerData.PointerY)
		TrackingPointer.TrackWaypoints[windowId].facet = WindowData.PlayerLocation.facet
		MapCommon.WaypointUpdateRequest = true
		DynamicImageSetTexture(windowName.."PointerImage", "UO_Common", 368, 0)
		WindowClearAnchors(windowName.."PointerImage")
		WindowAddAnchor(windowName.."PointerImage", "topleft", "ResizeWindow", "center", x, y)
		DynamicImageSetRotation(windowName.."PointerImage", rotation)
		WindowSetShowing(windowName, true)
	end
end