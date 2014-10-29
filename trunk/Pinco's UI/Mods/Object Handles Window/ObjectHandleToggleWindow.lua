----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ObjectHandleToggleWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

ObjectHandleToggleWindow.WindowName = "ObjectHandleToggleWindow"
ObjectHandleToggleWindow.LabelName = ObjectHandleToggleWindow.WindowName .. "Type"
ObjectHandleToggleWindow.ShowItemsOnly = false
ObjectHandleToggleWindow.ShowLostItemsOnly = false
ObjectHandleToggleWindow.lock = false

ObjectHandleToggleWindow.URIFilter = ""

ObjectHandleToggleWindow.CurrentFilter = ""

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ObjectHandleToggleWindow.Initialize()
    ObjectHandleToggleWindow.UpdateText()
    WindowUtils.RestoreWindowPosition(ObjectHandleToggleWindow.WindowName, false)
    SnapUtils.SnappableWindows["ObjectHandleToggleWindow"] = true
    ObjectHandleToggleWindow.ShowItemsOnly = CustomSettings.LoadBoolean( "ObjectHandleToggleWindowShowItemsOnly", ObjectHandleToggleWindow.ShowItemsOnly )
    ObjectHandleToggleWindow.ShowLostItemsOnly = CustomSettings.LoadBoolean( "ObjectHandleToggleWindowShowLostItemsOnly", ObjectHandleToggleWindow.ShowLostItemsOnly ) 
    ObjectHandleToggleWindow.lock = CustomSettings.LoadBoolean( "ObjectHandleToggleWindowlock", ObjectHandleToggleWindow.lock ) 
    WindowSetShowing("ObjectHandleToggleWindow", EnhancePack.ObjectHandle)
    if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(ObjectHandleToggleWindow.LabelName,  "font_sagoe_bold_shadow_14", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	else
		LabelSetFont(ObjectHandleToggleWindow.LabelName,  "UO_DefaultText_ASIA_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
end

function ObjectHandleToggleWindow.Shutdown()
    WindowUtils.SaveWindowPosition(ObjectHandleToggleWindow.WindowName)
    SnapUtils.SnappableWindows["ObjectHandleToggleWindow"] = nil
end

function ObjectHandleToggleWindow.OnLButtonDown()
	if ( not ObjectHandleToggleWindow.lock) then
		SnapUtils.StartWindowSnap("ObjectHandleToggleWindow")
	end
end

function ObjectHandleToggleWindow.ContextMenuCallback( returnCode, param )
    if( param ~= nil ) then
		if (returnCode == "items") then
			SystemData.Settings.GameOptions.objectHandleFilter = 0
			ObjectHandleToggleWindow.ShowItemsOnly = true
			ObjectHandleToggleWindow.ShowLostItemsOnly = false
			CustomSettings.SaveBoolean( "ObjectHandleToggleWindowShowItemsOnly", true )
			CustomSettings.SaveBoolean( "ObjectHandleToggleWindowShowLostItemsOnly", false)
			UserSettingsChanged()
			ObjectHandleToggleWindow.UpdateText()
		elseif (returnCode == "lostitems") then
			SystemData.Settings.GameOptions.objectHandleFilter = 0
			ObjectHandleToggleWindow.ShowLostItemsOnly = true
			ObjectHandleToggleWindow.ShowItemsOnly = false
			CustomSettings.SaveBoolean( "ObjectHandleToggleWindowShowItemsOnly", false )
			CustomSettings.SaveBoolean( "ObjectHandleToggleWindowShowLostItemsOnly", true )
			UserSettingsChanged()
			ObjectHandleToggleWindow.UpdateText()
		elseif (returnCode == "setfilter") then
			local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,844), subtitle=UI.GetCliloc(SystemData.Settings.Language.type ,846), callfunction=ObjectHandleToggleWindow.SetFilter, id=2}
			RenameWindow.Create(rdata)
		elseif (returnCode == "addfilter") then
			local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,844), subtitle=UI.GetCliloc(SystemData.Settings.Language.type ,846), callfunction=ObjectHandleToggleWindow.SetFilter, id=3}
			RenameWindow.Create(rdata)
		elseif (returnCode == "removefilter") then
			ObjectHandleToggleWindow.CurrentFilter = ""
		elseif ( returnCode=="Lock" ) then
			ObjectHandleToggleWindow.lock = not ObjectHandleToggleWindow.lock
			CustomSettings.SaveBoolean( "ObjectHandleToggleWindowlock", ObjectHandleToggleWindow.lock )
			WindowSetMovable("ObjectHandleToggleWindow", not ObjectHandleToggleWindow.lock )
		elseif (returnCode ~= "nil") then
			ObjectHandleToggleWindow.ShowItemsOnly = false
			ObjectHandleToggleWindow.ShowLostItemsOnly = false
			CustomSettings.SaveBoolean( "ObjectHandleToggleWindowShowItemsOnly", false )
			CustomSettings.SaveBoolean( "ObjectHandleToggleWindowShowLostItemsOnly", false)
			SystemData.Settings.GameOptions.objectHandleFilter = returnCode-1
			--Event is old SA is a function
			UserSettingsChanged()
			ObjectHandleToggleWindow.UpdateText()
		end
    end
end

function ObjectHandleToggleWindow.SetFilter(j, newval)
	if j == 2 then
		ObjectHandleToggleWindow.CurrentFilter = newval
	elseif j == 3 then
		ObjectHandleToggleWindow.CurrentFilter = ObjectHandleToggleWindow.CurrentFilter .. L"|" .. newval
	end
end

function ObjectHandleToggleWindow.UpdateText()
	if (ObjectHandleToggleWindow.ShowItemsOnly) then
		LabelSetText(ObjectHandleToggleWindow.LabelName, UI.GetCliloc(SystemData.Settings.Language.type, 336))
	elseif (ObjectHandleToggleWindow.ShowLostItemsOnly) then
		LabelSetText(ObjectHandleToggleWindow.LabelName, UI.GetCliloc(SystemData.Settings.Language.type, 780))
	else
		local filter
		for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
			if( SystemData.Settings.GameOptions.objectHandleFilter == SettingsWindow.ObjectHandles[filter].id )then
				LabelSetText(ObjectHandleToggleWindow.LabelName, GetStringFromTid(SettingsWindow.ObjectHandles[filter].tid))
			end
		end
		
		--Update the Settings Window too, without reloading the whole SettingsWindow resources!
		for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
			if( SystemData.Settings.GameOptions.objectHandleFilter == SettingsWindow.ObjectHandles[filter].id )then
				ComboBoxSetSelectedMenuItem( "SettingsOptionsObjHandleFilterCombo", filter )
			end
		end
    end
end


					
function ObjectHandleToggleWindow.ShowContextMenu()
    local filter
    for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
        local text = GetStringFromTid( SettingsWindow.ObjectHandles[filter].tid )
        ContextMenu.CreateLuaContextMenuItem(SettingsWindow.ObjectHandles[filter].tid,0,filter,filter,SystemData.Settings.GameOptions.objectHandleFilter == SettingsWindow.ObjectHandles[filter].id and not ObjectHandleToggleWindow.ShowItemsOnly and not ObjectHandleToggleWindow.ShowLostItemsOnly)
    end
    ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 336),0,"items",2,ObjectHandleToggleWindow.ShowItemsOnly)
    ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 780),0,"lostitems",2,ObjectHandleToggleWindow.ShowLostItemsOnly)
    
    ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"nil",2, false)
    
    if (ObjectHandleToggleWindow.CurrentFilter == "") then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 844),0,"setfilter",2, false)
    else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5027),0,"addfilter",2, false)
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 845),0,"removefilter",2, false)
    end
    if(ObjectHandleToggleWindow.lock) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 289),0,"Lock",1,false)
	else
	   ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 290),0,"Lock",1,false)
	end
    ContextMenu.ActivateLuaContextMenu(ObjectHandleToggleWindow.ContextMenuCallback)
end
