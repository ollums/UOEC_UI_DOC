----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DragWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
 
----------------------------------------------------------------
-- DragWindow Functions
----------------------------------------------------------------
function DragWindow.Initialize()
    if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
        WindowSetDimensions("DragWindow", SystemData.DragItem.itemWidth, SystemData.DragItem.itemHeight)
        WindowSetShowing("DragWindowAction",false)
        
        item = 
        {
			itemId = SystemData.DragItem.itemId,
            iconName = SystemData.DragItem.itemName,
            newWidth = SystemData.DragItem.itemWidth,
            newHeight = SystemData.DragItem.itemHeight,
            iconScale = SystemData.DragItem.itemScale,
            hueId = SystemData.DragItem.itemHueId,
            hue = SystemData.DragItem.itemHue,
			objectType = SystemData.DragItem.itemType,
			iconId = SystemData.DragItem.itemType
        }
        DynamicImageSetTexture( "DragWindowItemMulti", "", 0, 0 )
        EquipmentData.UpdateItemIcon("DragWindowItem", item)  
        
        RegisterWindowData(WindowData.ObjectInfo.Type, item.itemId)
        local itemdata = WindowData.ObjectInfo[item.itemId]
		if not itemdata then
			RegisterWindowData(WindowData.ObjectInfo.Type, item.itemId)
			itemdata = WindowData.ObjectInfo[item.itemId]
		end
        if itemdata and itemdata.quantity > 1 and item.objectType ~= 3821 and item.objectType ~= 3824 then
			EquipmentData.UpdateItemIcon("DragWindowItemMulti", item)   
		end
            
	elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ACTION ) then
	    local x, y = WindowGetDimensions("DragWindowAction")
	    
	    local disabled = false
	    if( SystemData.DragItem.actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
			disabled = not UserActionIsTargetModeCompat(SystemData.MacroSystem.STATIC_MACRO_ID, SystemData.DragItem.actionId, 0)
	    else
			disabled = not UserActionIsActionTypeTargetModeCompat(SystemData.DragItem.actionType)
		end
		
        WindowSetDimensions("DragWindow", x, y)
        HotbarSystem.UpdateActionButton("DragWindowAction", SystemData.DragItem.actionType, SystemData.DragItem.actionId, SystemData.DragItem.actionIconId, disabled )
	    WindowSetShowing("DragWindowItem",false)
	    
		local tintColor = HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE]
		WindowSetTintColor("DragWindowActionOverlay",tintColor.r,tintColor.g,tintColor.b)
		WindowSetShowing("DragWindowActionHotkeyBackground",false)   
		WindowSetShowing("DragWindowActionQuantityBackground", false)
    end
    
    DragWindow.Update()
end

function DragWindow.Shutdown()
end

function DragWindow.Update()
    local posX = SystemData.MousePosition.x/InterfaceCore.scale
    local posY = SystemData.MousePosition.y/InterfaceCore.scale

    WindowClearAnchors("DragWindow")
    if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		WindowAddAnchor("DragWindow", "topleft", "Root", "center", posX, posY)


    elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ACTION ) then
        WindowAddAnchor("DragWindow", "topleft", "Root", "topleft", posX, posY)
    end
end