----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ContainerWindow = {}
ContainerWindow.OpenContainers = {}
ContainerWindow.RegisteredItems = {}
ContainerWindow.ViewModes = {}

ContainerWindow.ItemMouseOverId = 0 

ContainerWindow.DeltaRefresh = 0

ContainerWindow.KnowsRelics = {}
ContainerWindow.KnowsArti = {}
ContainerWindow.KnowsSet = {}

ContainerWindow.DEFAULT_START_POSITION = { x=100,y=100 }
ContainerWindow.MAX_VALUES = { x=1280, y=1024 }
ContainerWindow.POSITION_OFFSET = 30
ContainerWindow.TimePassedSincePickUp = 0
ContainerWindow.CanPickUp = true

ContainerWindow.TID_GRID_MODE = 1079439
ContainerWindow.TID_FREEFORM_MODE = 1079440
ContainerWindow.TID_LIST_MODE = 1079441

ContainerWindow.ScrollbarWidth = 12

ContainerWindow.waitItems = 0
ContainerWindow.waitGump = 0
ContainerWindow.waitLegacy = 0

ContainerWindow.Grid = {}
ContainerWindow.Grid.PaddingTop = 50
ContainerWindow.Grid.PaddingLeft = 12
ContainerWindow.Grid.PaddingBottom = 15
ContainerWindow.Grid.PaddingRight = 26
ContainerWindow.Grid.SocketSize = 57
ContainerWindow.Grid.MinWidth = 320
ContainerWindow.Grid.NumSockets = {}

ContainerWindow.List = {}
ContainerWindow.List.PaddingTop = 50
ContainerWindow.List.PaddingLeft = 0
ContainerWindow.List.PaddingBottom = 15
ContainerWindow.List.PaddingRight = 14
ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5
ContainerWindow.List.ItemHeight = 60
ContainerWindow.List.MinWidth = 320

ContainerWindow.MAX_INVENTORY_SLOTS = 125

ContainerWindow.CHESS_GUMP = 2330
ContainerWindow.BACKGAMMON_GUMP = 2350
ContainerWindow.PLAGUE_BEAST_GUMP = 10851

-- used for windows the player doesn't own
ContainerWindow.Cascade = {}
ContainerWindow.Cascade.Movement = { x=0, y=0 }

ContainerWindow.Locked = false

ContainerWindow.delta = 0
ContainerWindow.deltaItem = 0

ContainerWindow.LootDrag = false

ContainerWindow.Organize = false
ContainerWindow.OrganizeBag = nil
ContainerWindow.OrganizeParent = nil
ContainerWindow.LootAll = false

ContainerWindow.Restock = false
ContainerWindow.HoldShiftBackup = nil
ContainerWindow.DragAmount = 0
ContainerWindow.RestockID = 0
ContainerWindow.RestockHue = 0
ContainerWindow.RestockDragStart = false
ContainerWindow.CurrentAmountArray = {}
ContainerWindow.RestockDelta = 0

ContainerWindow.LastUsesDelta = {}
ContainerWindow.CurrentUses = {}

----------------------------------------------------------------
-- ContainerWindow Functions
----------------------------------------------------------------

-- Helper function
function ContainerWindow.ReleaseRegisteredObjects(id )

	if( ContainerWindow.RegisteredItems[id] ~= nil ) then
		for ids, value in pairs(ContainerWindow.RegisteredItems[id]) do
			UnregisterWindowData(WindowData.ObjectInfo.Type, ids)
		end
	end
	ContainerWindow.RegisteredItems[id] = {}

end

function ContainerWindow.CountObjectData()
	local a = 0
	for key, value in pairs(WindowData.ObjectInfo) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function ContainerWindow.CountContainersData()
	local a = 0
	for key, value in pairs(WindowData.ContainerWindow) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

-- sets legacy container art
function ContainerWindow.SetLegacyContainer( gumpID, windowID )
	
	this = "ContainerWindow_" .. windowID -- SystemData.ActiveWindow.name
	
	-- hide unwanted container elements
	WindowSetShowing( this.."Chrome", false )
	WindowSetShowing( this.."Title", false )
	if (DoesWindowNameExist(this.."Background")) then
		WindowSetShowing( this.."Background", false )
	end
	WindowSetScale(this,InterfaceCore.scale)

    if( gumpID == nil or gumpID == 0 ) then
        --Debug.Print("ContainerWindow.SetLegacyContainer: gumpID is nil!")
        ContainerWindow.waitLegacy = windowID
        return
    end

	local texture = gumpID
	local xSize, ySize
	local scale = SystemData.FreeformInventory.Scale
	texture, xSize, ySize = RequestGumpArt( texture )
	local textureSize = xSize
	if (textureSize < ySize) then
		textureSize = ySize
	end
	
	local yAnchor = 0
	if (gumpID == ContainerWindow.CHESS_GUMP) then
		yAnchor = 20
	end
	
	-- show legacy container art
	WindowSetDimensions( this, xSize * scale, ySize * scale )
	WindowSetShowing( this.."LegacyContainerArt", true )
	WindowAddAnchor( this.."LegacyContainerArt", "topleft", this, "topleft", 0, yAnchor )
	WindowSetDimensions( this.."LegacyContainerArt", xSize * scale, ySize * scale )
	DynamicImageSetTexture( this.."LegacyContainerArt", texture, 0, 0 )
	DynamicImageSetTextureScale( this.."LegacyContainerArt", scale )
	
	DynamicImageSetTextureDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	WindowSetDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	DynamicImageSetTexture(this.."FreeformView", "freeformcontainer_texture"..windowID, 0, 0)
	DynamicImageSetTextureScale(this.."FreeformView", InterfaceCore.scale * scale)
	
		
	requestedContainerArt = requestedContainerArt or {}
	requestedContainerArt = texture

end

-- OnInitialize Handler
function ContainerWindow.Initialize()
	

	local id = SystemData.DynamicWindowId
	this = "ContainerWindow_" .. id--SystemData.ActiveWindow.name
--	if (ContainerWindow.OpenContainers[id]) then
--		return
--	end
	if (id == EnhancePack.PlayerBackpack) then
		EnhancePack.BackpackOpen = true
		CustomSettings.SaveBoolean( "EnhancePackBackpackOpen", EnhancePack.BackpackOpen )
	end
	
	local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers

	WindowSetId(this, id)
	
	ButtonSetTexture(this .. "Restock", InterfaceCore.ButtonStates.STATE_NORMAL, UI.UpArrow.texture, UI.UpArrow.STATE_NORMAL.x, UI.UpArrow.STATE_NORMAL.y)
	ButtonSetTexture(this .. "Restock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.UpArrow.texture, UI.UpArrow.STATE_NORMAL_HIGHLITE.x, UI.UpArrow.STATE_NORMAL_HIGHLITE.y)
	ButtonSetTexture(this .. "Restock", InterfaceCore.ButtonStates.STATE_PRESSED, UI.UpArrow.texture, UI.UpArrow.STATE_PRESSED.x, UI.UpArrow.STATE_PRESSED.y) -- 248
	ButtonSetTexture(this .. "Restock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.UpArrow.texture, UI.UpArrow.STATE_PRESSED_HIGHLITE.x, UI.UpArrow.STATE_PRESSED_HIGHLITE.y) -- 248

	Interface.DestroyWindowOnClose[this] = true

	ContainerWindow.OpenContainers[id] = {open = true, cascading = false, slotsWide = 0, slotsHigh = 0}


	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)

	--UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	RegisterWindowData(WindowData.ContainerWindow.Type, id)
	
	WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "ContainerWindow.MiniModelUpdate")
	WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "ContainerWindow.HandleUpdateObjectEvent")

	local gumpID = WindowData.ContainerWindow[id].gumpNum
	
	
	--Debug.PrintToDebugConsole( "legacyContainersMode = "..tostring( legacyContainersMode ) )
	--Debug.PrintToDebugConsole( "container id = "..gumpID )
	local item = WindowData.ObjectInfo[id]
	if (item  ~= nil) then
		local name = wstring.lower(item.name)
		local texto = string.find(WStringToString(name) , "a corpse of ")
		if ( texto ~= nil and EnhancePack.EnableAutoIgnoreCorpses) then
			WindowData.ContainerWindow[id].isCorpse = true 
		end
		local texto = string.find(WStringToString(name) , " corpse")
		if ( texto ~= nil and EnhancePack.EnableAutoIgnoreCorpses) then
			WindowData.ContainerWindow[id].isCorpse = true 
		end
		local texto = string.find(WStringToString(name) , "remains of ")
		if ( texto ~= nil and EnhancePack.EnableAutoIgnoreCorpses) then
			WindowData.ContainerWindow[id].isCorpse = true 
		end
		local texto = string.find(WStringToString(name) , "bones")
		if ( texto ~= nil and EnhancePack.EnableAutoIgnoreCorpses) then
			WindowData.ContainerWindow[id].isCorpse = true 
		end
	end 
	if (gumpID == 9) then
		WindowData.ContainerWindow[id].isCorpse = true 
	end

	-- determine the container's view mode
	if (legacyContainersMode or gumpID == ContainerWindow.CHESS_GUMP or gumpID == ContainerWindow.BACKGAMMON_GUMP 
			or gumpID == ContainerWindow.PLAGUE_BEAST_GUMP ) then
        ContainerWindow.ViewModes[id] = "Freeform"	
        
        if ( EnhancePack.OpenedCorpse ~= 0 and EnhancePack.EnableAutoIgnoreCorpses) then
			local count = table.getn(EnhancePack.IgnoreItems)
			local found = false
			for i=1, count do
				if ( EnhancePack.IgnoreItems[i] and EnhancePack.IgnoreItems[i].id == EnhancePack.OpenedCorpse) then
					ObjectHandle.DestroyObjectWindow(EnhancePack.IgnoreItems[i].id) 
					EnhancePack.OpenedCorpse = 0
					found = true
					break
				end
    		end
    		if ( not found ) then
    			local data =  { id = EnhancePack.OpenedCorpse, decayTime = EnhancePack.Setting.GlobalTime + 1800}
    			table.insert(EnhancePack.IgnoreItems, data)
    			ObjectHandleWindow.ForceIgnore = EnhancePack.OpenedCorpse
    			EnhancePack.IgnoreSharing(objectId)
				EnhancePack.OpenedCorpse = 0
    		end
		end
        
	elseif WindowData.ContainerWindow[id].isCorpse then
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultCorpseMode
		if ( EnhancePack.OpenedCorpse ~= 0 and EnhancePack.EnableAutoIgnoreCorpses) then
			local count = table.getn(EnhancePack.IgnoreItems)
			local found = false
			for i=1, count do
				if ( EnhancePack.IgnoreItems[i] and EnhancePack.IgnoreItems[i] == EnhancePack.OpenedCorpse) then
					ObjectHandle.DestroyObjectWindow(EnhancePack.IgnoreItems[i]) 
					EnhancePack.OpenedCorpse = 0
					found = true
					break
				end
    		end
    		if ( not found ) then
    			local data =  { id = EnhancePack.OpenedCorpse, decayTime = EnhancePack.Setting.GlobalTime + 1800}
    			table.insert(EnhancePack.IgnoreItems, data)
    			ObjectHandleWindow.ForceIgnore = EnhancePack.OpenedCorpse
    			EnhancePack.IgnoreSharing(objectId)
				EnhancePack.OpenedCorpse = 0
    		end
		end
		
	elseif IsInPlayerBackPack(id) then
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then -- we found the preserved viewmode
				ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.ContainerViewModes.ViewModes[i]
				break
			end
		end
		
		-- if the id wasn't found or if the container's viewmode was manually changed to "Freeform" with legacy containers 
		-- turned off, use the default setting
		if not ContainerWindow.ViewModes[id] or ContainerWindow.ViewModes[id] == "Freeform" then
			ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
			
			-- insert the new container setting into the shared vector
			local newContainerIndex = table.getn(SystemData.Settings.Interface.ContainerViewModes.ViewModes) + 1
			SystemData.Settings.Interface.ContainerViewModes.Ids[newContainerIndex] = id
			SystemData.Settings.Interface.ContainerViewModes.ViewModes[newContainerIndex] = ContainerWindow.ViewModes[id]
		end
		
	else
		-- use the default container mode
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
	end
	-- done getting view mode
	
	
	if (ContainerWindow.ViewModes[id] == "Freeform") then
		
		if (not WindowData.ContainerWindow[id] and not WindowData.ContainerWindow[id].ContainedItems) then
			ContainerWindow.waitGump = id
		else
			ContainerWindow.SetLegacyContainer( gumpID, id )
		end
		WindowSetShowing( this.."ViewButton", false )
		WindowSetShowing( this.."ResizeButton", false )
		WindowSetShowing( this.."LootAll", false )
	else
		WindowSetShowing( this.."ViewButton", true )
	end
	
	
	WindowData.ContainerWindow[id].numCreatedSlots = 0
	WindowData.ContainerWindow[id].maxSlots = SystemData.ActiveContainer.NumSlots
		
	-- if this container belongs to the player then use the saved position
	--if IsInPlayerBackPack(id) then
	local restorename = this
	if WindowData.ContainerWindow[id].isCorpse then
		WindowUtils.RestoreWindowPosition(this, true, "CORPSECont", false)
		restorename = "CORPSECont"
	else
		WindowUtils.RestoreWindowPosition(this, true, "CID" .. id, false)
		restorename = "CID" .. id
	end
		
	-- if the window position can't be restored, try to place this container near its parent container
	if not WindowUtils.CanRestorePosition(restorename) then
		local parentContainerId = GetParentContainer(id)

		WindowClearAnchors(this)
		if parentContainerId ~= 0 and DoesWindowNameExist("ContainerWindow_"..parentContainerId) then
			-- offset this container from the parent
			local x, y = WindowGetScreenPosition("ContainerWindow_"..parentContainerId)	
			x = math.floor((x + ContainerWindow.POSITION_OFFSET) / InterfaceCore.scale + 0.5)
			y = math.floor((y + ContainerWindow.POSITION_OFFSET) / InterfaceCore.scale + 0.5)
			WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	
		else
			WindowAddAnchor(this, "topleft", "Root", "topleft", 200, 200)	
		end
	end
	
	-- if this is the players backpack then update the paperdoll backpack icon
	if (WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK]) then
		local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		if( id == playerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(true)
			WindowSetShowing( this.."LootAll", false )
		end
	end
		

	ContainerWindow.Grid.PaddingTop = 50
	ContainerWindow.Grid.PaddingLeft = 12
	ContainerWindow.Grid.PaddingBottom = 15
	ContainerWindow.Grid.PaddingRight = 26
	ContainerWindow.Grid.SocketSize = 57
	ContainerWindow.List.PaddingTop = 50
	ContainerWindow.List.PaddingLeft = 0
	ContainerWindow.List.PaddingBottom = 15
	ContainerWindow.List.PaddingRight = 14
	ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5

	ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, UI.Lock.texture, UI.Lock.STATE_NORMAL.x, UI.Lock.STATE_NORMAL.y)
	ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_NORMAL_HIGHLITE.x, UI.Lock.STATE_NORMAL_HIGHLITE.y)
	ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, UI.Lock.texture, UI.Lock.STATE_PRESSED.x, UI.Lock.STATE_PRESSED.y) -- 248
	ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_PRESSED_HIGHLITE.x, UI.Lock.STATE_PRESSED_HIGHLITE.y) -- 248
	WindowSetShowing(this.."Lock", false)
	WindowSetShowing(this.."Organize", false)
	WindowSetShowing(this.."Restock", false)	
	WindowSetShowing(this.."Search", false)			
	WindowSetShowing(this.."LootAll", false)
	
				
	if (WindowData.ContainerWindow[id].maxSlots > 200 and ContainerWindow.ViewModes[id] ~= "Freeform") then
		ContainerWindow.ViewModes[id] = "List"
		WindowSetShowing(this.. "ViewButton", false)
	end
	
	if (ContainerWindow.ViewModes[id] ~= "Freeform" ) then
	
		if (EnhancePack.GridLegacy ) then
			ContainerWindow.LegacyGridDock(this)
		else
			if (EnhancePack.PlayerBackpack == id ) then
				WindowClearAnchors(this.."Lock")
				WindowSetShowing(this.."Lock", true)
				WindowAddAnchor( this.."Lock", "topright", this, "topright", -45, 0)
				WindowSetMovable(this,not ContainerWindow.Locked )	
			end
			if (ContainerWindow.ViewModes[id] ~= "Freeform" ) then
				WindowClearAnchors(this.."Organize")
				WindowAddAnchor( this.."Organize", "topleft", this, "topleft", 0, 5)
				WindowClearAnchors(this.."Restock")
				WindowAddAnchor( this.."Restock", "topright", this.."Organize", "topright", 25, -7)
				WindowSetShowing(this.."Organize", true)
				WindowSetShowing(this.."Restock", true)
			else
				WindowSetShowing(this.."Organize", false)
				WindowSetShowing(this.."Restock", false)
			end
		end
	else
		if (EnhancePack.PlayerBackpack == id ) then
			WindowClearAnchors(this.."Lock")
			WindowSetShowing(this.."Lock", true)
			WindowSetLayer(this.."Lock", Window.Layers.OVERLAY	)
			WindowAddAnchor( this.."Lock", "topright", this.."LegacyContainerArt", "topright", -45, 0)
			WindowSetMovable(this,not ContainerWindow.Locked )	
		end
	end

	
	ContainerWindow.UpdateContents(id, true)
	
	
	
	if (ContainerWindow.ViewModes[id] == "List") then
		ContainerWindow.UpdateListViewSockets(id)
	elseif (ContainerWindow.ViewModes[id] ~= "Freeform") then
		-- default to grid view if not using list or freeform containers
		ContainerWindow.ViewModes[id] = "Grid"
		--ContainerWindow.UpdateGridViewSockets(id)
	end
	
	
	
	
	if (EnhancePack.TrapBoxID ~= 0 and EnhancePack.TrapBoxID == id) then
		--Debug.Print(tostring(EnhancePack.TrapBoxID) .. " - " .. tostring(id))
		WindowClearAnchors(this)
		WindowAddAnchor(this, "topleft", "Root", "topleft", -400, -400)	
    end
    

    if (ContainerWindow.ViewModes[id] ~= "Freeform") then
		WindowSetScale(this, SystemData.Settings.Interface.customUiScale * 0.80)
		EnhancePack.LoadScale( this )
		
		ContainerWindow.LegacyGridDock(this)
	end 
	
end

function ContainerWindow.Shutdown()
	--Debug.Print("ContainerWindow.Shutdown: "..WindowUtils.GetActiveDialog())
	
	

	local id = WindowGetId(WindowUtils.GetActiveDialog())
	this = "ContainerWindow_"..id
	
	ContainerWindow.waitItems = 0
	ContainerWindow.waitGump = 0
	ContainerWindow.waitLegacy = 0
	-- if the container is in the cascade, don't save its position
	if ContainerWindow.IsCascading(id) then
		ContainerWindow.RemoveFromCascade(id)
	else
		if WindowData.ContainerWindow[id] and WindowData.ContainerWindow[id].isCorpse then
			WindowUtils.SaveWindowPosition(this, false, "CORPSECont")
		else
			WindowUtils.SaveWindowPosition(this, false, "CID" .. id)
		end
	end
	
	if IsInPlayerBackPack(id) then
		
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then
				SystemData.Settings.Interface.ContainerViewModes.ViewModes[i] = ContainerWindow.ViewModes[id]
				break
			end
		end
		
		local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		if( id == playerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(false)
		end 
	end

	if( ContainerWindow.ViewModes[id] ~= "Freeform" ) then
		if ContainerWindow.RegisteredItems[id] then
			for ids, value in pairs(ContainerWindow.RegisteredItems[id]) do
				ContainerWindow.KnowsRelics[ids] = nil
				ContainerWindow.KnowsArti[ids] = nil
				ContainerWindow.KnowsSet[ids] = nil
			end
		end
		ContainerWindow.ReleaseRegisteredObjects(id)
	end
	
	ContainerWindow.ViewModes[id] = nil
	ContainerWindow.OpenContainers[id] = nil
	ContainerWindow.RegisteredItems[id] = nil
	
	UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	UnregisterWindowData(WindowData.ObjectInfo.Type, id)
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	
	if( ItemProperties.GetCurrentWindow() == this ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	GumpManagerOnCloseContainer(id)
	
	if tonumber(requestedContainerArt) ~= nil then
		ReleaseGumpArt( tonumber( requestedContainerArt ) )
	end

end

function ContainerWindow.SearchItem()
	ContainerSearch.Container = WindowGetId(WindowUtils.GetActiveDialog())
	ContainerSearch.Toggle()	
end

function ContainerWindow.SearchAllTooltip()

	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 818))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.LootAllBtn()
	ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())
	ContainerWindow.LootAll = not ContainerWindow.LootAll 
	
end

function ContainerWindow.LootAllTooltip()

	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 815))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end


function ContainerWindow.LockTooltip()
	
	if ( ContainerWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 260))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 261))
	end
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.Lock()
	local dialog = WindowUtils.GetActiveDialog()
	ContainerWindow.Locked = not ContainerWindow.Locked 
	CustomSettings.SaveBoolean( "ContainerWindowLocked", ContainerWindow.Locked  )
	WindowSetMovable(dialog,not ContainerWindow.Locked )
end

function ContainerWindow.OnSetMoving(isMoving)
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if ContainerWindow.IsCascading(id) then
		local windowName = "ContainerWindow_"..id
		local x, y = WindowGetScreenPosition(windowName)
		if isMoving then
			ContainerWindow.Cascade.Movement.x = x
			ContainerWindow.Cascade.Movement.y = y
		else
			if ContainerWindow.Cascade.Movement.x ~= x and ContainerWindow.Cascade.Movement.y ~= y then
				ContainerWindow.RemoveFromCascade(id)
			end
		end
	end
	
end

function ContainerWindow.SetInventoryButtonPressed(pressed)
	if (WindowData.PlayerStatus.PlayerId) then
		ButtonSetPressedFlag("MenuBarWindowToggleInventory", pressed)
		local my_paperdoll = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
		local my_paperdoll_backpackicon = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId.."ToggleInventory"
		if DoesWindowNameExist(my_paperdoll) and WindowGetShowing(my_paperdoll) then
			ButtonSetPressedFlag( my_paperdoll_backpackicon, pressed)
		end	
	end
end

function ContainerWindow.HideAllContents(parent, numItems)

	local id = WindowGetId(parent)
	local data = WindowData.ContainerWindow[id]
	for i=1,data.maxSlots do
		if DoesWindowNameExist(parent.."GridViewSocket"..i.."Icon") then
			DynamicImageSetTexture(parent.."GridViewSocket"..i.."Icon", "", 0, 0);
			if DoesWindowNameExist(parent.."GridViewSocket"..i.."IconMulti") then
				DynamicImageSetTexture( parent.."GridViewSocket"..i.."IconMulti", "", 0, 0 )
			end
			LabelSetText(parent.."GridViewSocket"..i.."Quantity", L"")
		end
		if i <= numItems then
			if DoesWindowNameExist(parent.."ListViewScrollChildItem"..i) then
				LabelSetText(parent.."ListViewScrollChildItem"..i.."Name", L"" )
				DynamicImageSetTexture(parent.."ListViewScrollChildItem"..i.."Icon", "", 0, 0);
				WindowSetShowing(parent.."ListViewScrollChildItem"..i, false)
			end
		end
	end
end

function ContainerWindow.CreateListViewSlots(dialog, low, high)

	local parent = dialog.."ListViewScrollChild"
	local id = WindowGetId(dialog)
	local data = WindowData.ContainerWindow[id]

	for i=low, high do
		slotName = parent.."Item"..i
		CreateWindowFromTemplate(slotName, "ContainerItemTemplate", parent)
		WindowSetId(slotName,i)
		WindowSetId(slotName.."Icon", i)
        
		if i == 1 then
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 0)
            WindowAddAnchor(slotName, "topright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		else
			WindowAddAnchor(slotName, "bottomleft", parent.."Item"..i-1, "topleft", 0, 0)
            WindowAddAnchor(slotName, "bottomright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		end
	end
end

function ContainerWindow.MiniModelUpdate()
	local id = WindowData.UpdateInstanceId

	if (ContainerWindow.OpenContainers[id] and ContainerWindow.OpenContainers[id].inUpdate) then
		return
	end
	--if( id == WindowGetId(SystemData.ActiveWindow.name) ) then

		if((not ContainerWindow.OpenContainers[id] ) or (ContainerWindow.OpenContainers[id].LastUpdate and ContainerWindow.OpenContainers[id].LastUpdate < ContainerWindow.DeltaRefresh)) then
			ContainerWindow.UpdateContents(id)	
		else
			return
		end
		
	--end
	if (ContainerSearch.Container == id) then
		ContainerSearch.UpdateList()
	end
end

function ContainerWindow.UpdateContents(id)
	if not id then
		return
	end

	if ( (WindowData.ContainerWindow[id].isCorpse  or gumpID == 9) and ( ContainerWindow.ViewModes[id] ~= "Freeform" )  ) then
		if (ContainerWindow.OpenContainers[id] and ContainerWindow.OpenContainers[id].inUpdate) then
			return
		end
	end
	-- Debug.Print("UPDATE " .. id)
	local gumpID = WindowData.ContainerWindow[id].gumpNum
	if (not ContainerWindow.OpenContainers[id]) then
		ContainerWindow.OpenContainers[id] = {}
	end
	ContainerWindow.OpenContainers[id].inUpdate = true
	
	this = "ContainerWindow_"..id
	
	
	if(not DoesWindowNameExist(this)) then
		return
	end
	
	local list_view_this = this.."ListView"        
	local grid_view_this = this.."GridView"
	local freeform_view_this = this.."FreeformView"
	
	local data = WindowData.ContainerWindow[id]
	if (data.maxSlots > 200) then
		ContainerWindow.ViewModes[id] = "List"
	end
	-- store the scrollbar offset so we can restore it when we are done
	local listOffset = ScrollWindowGetOffset(list_view_this)
	local gridOffset = ScrollWindowGetOffset(grid_view_this)
	
	-- Create any contents slots we need
	local contents = data.ContainedItems
	local numItems = data.numItems
	local numCreatedSlots = data.numCreatedSlots or 1
	if numItems > numCreatedSlots then
		ContainerWindow.CreateListViewSlots(this, numCreatedSlots+1, numItems)
		data.numCreatedSlots = numItems
	end

	if ContainerWindow.ViewModes[id] ~= "List" then
		if not data.numGridSockets or data.numGridSockets < data.maxSlots then
			ContainerWindow.CreateGridViewSockets(this, 1, data.maxSlots)
			data.numGridSockets = data.maxSlots;
		end
	end
	-- Turn off all contents to start
	ContainerWindow.HideAllContents(this, numCreatedSlots)
	if ContainerWindow.ViewModes[id] == "List" then
		WindowSetShowing(list_view_this , true)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, false)
		
	elseif ContainerWindow.ViewModes[id] == "Grid" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, true)
		WindowSetShowing(freeform_view_this, false)

	elseif ContainerWindow.ViewModes[id] == "Freeform" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, true)	
	end
	
	LabelSetText(this.."Title", data.containerName)
	if (data.containerName and data.containerName ~= L"" and data.containerName ~= "") then
		WindowUtils.FitTextToLabel(this.."Title", data.containerName)
	end
	
	if( ContainerWindow.ViewModes[id] ~= "Freeform" ) then
		ContainerWindow.ReleaseRegisteredObjects(id)
		
		local gumpID = WindowData.ContainerWindow[id].gumpNum
		
		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[id].ContainedItems[i]
			if item then
				UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
				RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
				if not ContainerWindow.RegisteredItems[id] then
					ContainerWindow.RegisteredItems[id] = {}
				end
				ContainerWindow.RegisteredItems[id][item.objectId] = true
				if not ( (WindowData.ContainerWindow[id].isCorpse  or gumpID == 9) and EnhancePack.LootSort) then
					ContainerWindow.UpdateObject(this,item.objectId)
				end
			end
		end
		
		
		if ( (WindowData.ContainerWindow[id].isCorpse  or gumpID == 9) and EnhancePack.LootSort) then
			local newArray = {}

			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				if (type(p) == "string") then
					p = StringToWString(p)
				end
				
				
				local objType = WindowData.ObjectInfo[item.objectId].objectType
				if ( p == UI.GetCliloc(SystemData.Settings.Language.type, 262) or objType == 3821) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end

				end
			end	
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local props = GetObjectProperties( item.objectId )
				if not props then
					continue
				end
				local hasls = false
				for k = 1, table.getn(props) do
					if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
						text = string.find(WStringToString(props[k]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072517)), 1, 9)) -- "Lifespan:"
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
						text = wfind(props[k] , wstring.sub(EnhancePack.GetStringFromTid(1072517), 1, 3)) -- "Lifespan:"
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
						text = wfind(props[k] , wstring.sub(EnhancePack.GetStringFromTid(1072517), 1, 3)) -- "Lifespan:"
					end
					if text then
						hasls = true
						break
					end
				end
				if ( hasls) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end

				end
			end	
				
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if not itemdata then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				if (type(p) == "string") then
					p = StringToWString(p)
				end
				if (ContainerWindow.KnowsArti[item.objectId] == true) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end

				end
			end
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				if (type(p) == "string") then
					p = StringToWString(p)
				end

				if (ContainerWindow.KnowsSet[item.objectId] == true) then
						
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end
				end
			end	
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				if (type(p) == "string") then
					p = StringToWString(p)
				end
				local text = wstring.find(p , UI.GetCliloc(SystemData.Settings.Language.type, 263))

				if ( p == UI.GetCliloc(SystemData.Settings.Language.type, 264) or text) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end

				end
			end		
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				if (type(p) == "string") then
					p = StringToWString(p)
				end

				if (IsMaterial(p)) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end

				end
			end	
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				if (type(p) == "string") then
					p = StringToWString(p)
				end

				if (IsMagicalReagent(p)) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end

				end
			end	
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				
				if (type(p) == "string") then
					p = StringToWString(p)
				end
				if (ContainerWindow.KnowsRelics[item.objectId]) then
					--itemdata.name = L"(Relic) ".. itemdata.name
					--if (not wstring.find(itemdata.name, L"[(]Relic[)]") ) then
					--	itemdata.name = L"(Relic) ".. itemdata.name
					--end
					local ElementName = "ContainerWindow_" .. id .. "ListViewScrollChildItem"..i.."Name"
					LabelSetTextColor(ElementName, EnhancePack.PLAIN_COLOR.r, EnhancePack.PLAIN_COLOR.g, EnhancePack.PLAIN_COLOR.b)
					
					if (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031697) ) then
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.RESIDUE_COLOR.r, EnhancePack.RESIDUE_COLOR.g, EnhancePack.RESIDUE_COLOR.b)
						end
					elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031698) ) then
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.ESSENCE_COLOR.r, EnhancePack.ESSENCE_COLOR.g, EnhancePack.ESSENCE_COLOR.b)
						end
					elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031699) ) then
						--if (not wstring.find(item.name, L"[(]Relic[)]") ) then
						--	item.name = L"(Relic) " .. item.name
						--end
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.RELIC_COLOR.r, EnhancePack.RELIC_COLOR.g, EnhancePack.RELIC_COLOR.b)
						end
						
					end
					if( ContainerWindow.KnowsRelics[item.objectId] == GetStringFromTid(1031699)) then -- relic
						local found = false
						for j = 1, table.getn(newArray) do
							local item2 = newArray[j]
							if (item.objectId == item2.objectId) then
								found = true
								break
							end
						end
						if not found then
							item.gridIndex = table.getn(newArray) + 1
							table.insert(newArray, item)
						end
					end

				end

			end	
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				
				if (type(p) == "string") then
					p = StringToWString(p)
				end
				if (ContainerWindow.KnowsRelics[item.objectId]) then
					--itemdata.name = L"(Relic) ".. itemdata.name
					--if (not wstring.find(itemdata.name, L"[(]Relic[)]") ) then
					--	itemdata.name = L"(Relic) ".. itemdata.name
					--end
					local ElementName = "ContainerWindow_" .. id .. "ListViewScrollChildItem"..i.."Name"
					LabelSetTextColor(ElementName, EnhancePack.PLAIN_COLOR.r, EnhancePack.PLAIN_COLOR.g, EnhancePack.PLAIN_COLOR.b)
					
					if (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031697) ) then
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.RESIDUE_COLOR.r, EnhancePack.RESIDUE_COLOR.g, EnhancePack.RESIDUE_COLOR.b)
						end
					elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031698) ) then
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.ESSENCE_COLOR.r, EnhancePack.ESSENCE_COLOR.g, EnhancePack.ESSENCE_COLOR.b)
						end
					elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031699) ) then
						--if (not wstring.find(item.name, L"[(]Relic[)]") ) then
						--	item.name = L"(Relic) " .. item.name
						--end
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.RELIC_COLOR.r, EnhancePack.RELIC_COLOR.g, EnhancePack.RELIC_COLOR.b)
						end
						
					end
					
					if( ContainerWindow.KnowsRelics[item.objectId] == GetStringFromTid(1031698)) then -- essence
						local found = false
						for j = 1, table.getn(newArray) do
							local item2 = newArray[j]
							if (item.objectId == item2.objectId) then
								found = true
								break
							end
						end
						if not found then
							item.gridIndex = table.getn(newArray) + 1
							table.insert(newArray, item)
						end
					end
					
				end

			end	
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				
				if (type(p) == "string") then
					p = StringToWString(p)
				end
				if (ContainerWindow.KnowsRelics[item.objectId]) then
					--itemdata.name = L"(Relic) ".. itemdata.name
					--if (not wstring.find(itemdata.name, L"[(]Relic[)]") ) then
					--	itemdata.name = L"(Relic) ".. itemdata.name
					--end
					local ElementName = "ContainerWindow_" .. id .. "ListViewScrollChildItem"..i.."Name"
					LabelSetTextColor(ElementName, EnhancePack.PLAIN_COLOR.r, EnhancePack.PLAIN_COLOR.g, EnhancePack.PLAIN_COLOR.b)
					
					if (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031697) ) then
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.RESIDUE_COLOR.r, EnhancePack.RESIDUE_COLOR.g, EnhancePack.RESIDUE_COLOR.b)
						end
					elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031698) ) then
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.ESSENCE_COLOR.r, EnhancePack.ESSENCE_COLOR.g, EnhancePack.ESSENCE_COLOR.b)
						end
					elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031699) ) then
						--if (not wstring.find(item.name, L"[(]Relic[)]") ) then
						--	item.name = L"(Relic) " .. item.name
						--end
						if(DoesWindowNameExist(ElementName)) then
							LabelSetTextColor(ElementName, EnhancePack.RELIC_COLOR.r, EnhancePack.RELIC_COLOR.g, EnhancePack.RELIC_COLOR.b)
						end
						
					end
					
					if( ContainerWindow.KnowsRelics[item.objectId] == GetStringFromTid(1031697)) then -- residue
						local found = false
						for j = 1, table.getn(newArray) do
							local item2 = newArray[j]
							if (item.objectId == item2.objectId) then
								found = true
								break
							end
						end
						if not found then
							item.gridIndex = table.getn(newArray) + 1
							table.insert(newArray, item)
						end
					end
				end

			end	
			
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				if not WindowData.ObjectInfo[item.objectId] then
					continue
				end
				local objType = WindowData.ObjectInfo[item.objectId].objectType
				local name = WindowData.ObjectInfo[item.objectId].name
				if not name or type(name) == "string" or name == L"" then
					continue
				end
				local isJwel = false
				for k,v in pairs(ItemPropertiesEvaluator.JewelryNames) do
					k = wstring.gsub(k, L"%[" , L"")
					k = wstring.gsub(k, L"%]" , L"")
					if wstring.find(wstring.lower(name), wstring.lower(k)) then
						isJwel = true
						break
					end
				end
				if(isJwel or objType == 7942 or objType == 7945 or objType == 4230 or objType == 4234 or objType == 16913 or objType == 16914) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end
				end
			end
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				if not WindowData.ObjectInfo[item.objectId] then
					continue
				end
				local name = WindowData.ObjectInfo[item.objectId].name
				if not name or type(name) == "string" or name == L"" then
					continue
				end
				local isArmor = false
				for k,v in pairs(ItemPropertiesEvaluator.ArmorNames) do
					k = wstring.gsub(k, L"%[" , L"")
					k = wstring.gsub(k, L"%]" , L"")
					if wstring.find(wstring.lower(name), wstring.lower(k)) then
						isArmor = true
						break
					end
				end
				if not isArmor then
					for k,v in pairs(ItemPropertiesEvaluator.GargArmorNames) do
						k = wstring.gsub(k, L"%[" , L"")
						k = wstring.gsub(k, L"%]" , L"")
						if wstring.find(wstring.lower(name), wstring.lower(k)) then
							isArmor = true
							break
						end
					end
					if not isArmor then
						for k,v in pairs(ItemPropertiesEvaluator.HatNames) do
							k = wstring.gsub(k, L"%[" , L"")
							k = wstring.gsub(k, L"%]" , L"")
							if wstring.find(wstring.lower(name), wstring.lower(k)) then
								isArmor = true
								break
							end
						end
					end
				end
				if(isArmor) then
					
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end
				end
			end
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				if not WindowData.ObjectInfo[item.objectId] then
					continue
				end
				local name = WindowData.ObjectInfo[item.objectId].name
				if not name or type(name) == "string" or name == L"" then
					continue
				end
				local isWeapon = false
				for k,v in pairs(ItemPropertiesEvaluator.WeaponNames) do
					k = wstring.gsub(k, L"%[" , L"")
					k = wstring.gsub(k, L"%]" , L"")
					if wstring.find(wstring.lower(name), wstring.lower(k)) then
						isWeapon = true
						break
					end
				end
				if(isWeapon) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end
				end
			end
			
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				if not WindowData.ObjectInfo[item.objectId] then
					continue
				end
				local name = WindowData.ObjectInfo[item.objectId].name
				if not name or type(name) == "string" or name == L"" then
					continue
				end
				local isShield = false
				for k,v in pairs(ItemPropertiesEvaluator.ShieldNames) do
					k = wstring.gsub(k, L"%[" , L"")
					k = wstring.gsub(k, L"%]" , L"")
					if wstring.find(wstring.lower(name), wstring.lower(k)) then
						isShield = true
						break
					end
				end
				if(isShield) then
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end
				end
			end
			for i = 1, numItems do
				item = WindowData.ContainerWindow[id].ContainedItems[i]
				if not WindowData.ObjectInfo[item.objectId] then
					continue
				end
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if (not itemdata) then
					continue
				end
				local p = Shopkeeper.stripFirstNumber(itemdata.name)
				if (type(p) == "string") then
					p = StringToWString(p)
				end

				if (itemdata.hueId > 0 and not ContainerWindow.KnowsRelics[item.objectId]) then
						
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end
				end
			end	
			
			if (table.getn(newArray) < numItems) then
				for i = 1, numItems do
					item = WindowData.ContainerWindow[id].ContainedItems[i]
					local found = false
					for j = 1, table.getn(newArray) do
						local item2 = newArray[j]
						if (item.objectId == item2.objectId) then
							found = true
							break
						end
					end
					if not found then
						item.gridIndex = table.getn(newArray) + 1
						table.insert(newArray, item)
					end
				end
			end

			WindowData.ContainerWindow[id].ContainedItems = {}
			for i = 1, numItems do
				local item = newArray[i]
				if item then
					table.insert(WindowData.ContainerWindow[id].ContainedItems, item)
					ContainerWindow.UpdateObject(this,item.objectId)
				end
			end
			
		end
		local scl = WindowGetScale(this)
		
		if (ContainerWindow.ViewModes[id] == "List") then
			for i = 1, numItems do

				if ( DoesWindowNameExist(list_view_this.."ScrollChildItem"..i) and LabelGetText(list_view_this.."ScrollChildItem"..i.."Name" ) == "") then
					WindowSetShowing(list_view_this.."ScrollChildItem"..i, false)
					
					WindowSetScale(list_view_this.."ScrollChildItem"..i, scl)
				end
			end
		end
		
		-- Update the scroll windows
		ScrollWindowUpdateScrollRect( list_view_this )   	
		local maxOffset = VerticalScrollbarGetMaxScrollPosition(list_view_this.."Scrollbar")
		if( listOffset > maxOffset ) then
		    listOffset = maxOffset
		end
		ScrollWindowSetOffset(list_view_this,listOffset)

		ScrollWindowUpdateScrollRect(grid_view_this) 
		maxOffset = VerticalScrollbarGetMaxScrollPosition(grid_view_this.."Scrollbar")
		if( gridOffset > maxOffset ) then
		    gridOffset = maxOffset
		end
		ScrollWindowSetOffset(grid_view_this,gridOffset)		
	end
	local font = "font_verdana_shadow_med2_16"
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		font = "UO_DefaultText"
	end
	LabelSetFont(this.."Content", font, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetText(this.."Content", L"")
	if (EnhancePack.ToggleContentsInfo) then
		local content = ContainerWindow.GetContent(id)
		if content then
			LabelSetFont(this.."Content", font, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetText(this.."Content", content)
		end
	end
	--ContainerWindow.LegacyGridDock(this)
	ContainerWindow.OpenContainers[id].inUpdate = false
	ContainerWindow.OpenContainers[id].LastUpdate = ContainerWindow.DeltaRefresh + 0.25
	
	
end


function ContainerWindow.HandleUpdateObjectEvent()
    ContainerWindow.UpdateObject(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)
end

function ContainerWindow.UpdateObject(windowName,updateId)
	if(not DoesWindowNameExist(windowName)) then
		return
	end
	if( WindowData.ObjectInfo[updateId] ~= nil ) then
		local containerId = WindowData.ObjectInfo[updateId].containerId
	    -- if this object is in my container
	    if( containerId == WindowGetId(windowName) ) then
		    -- find the slot index
		    containedItems = WindowData.ContainerWindow[containerId].ContainedItems
		    numItems = WindowData.ContainerWindow[containerId].numItems
		    listIndex = 0
		    for i=1, numItems do
			    if( containedItems[i] and containedItems[i].objectId == updateId ) then
				    listIndex = i
				    gridIndex = (containedItems[i].gridIndex)
				    break
			    end
		    end

		    local item = WindowData.ObjectInfo[updateId]
			if item.name == L"" or not item.name then

				if(DoesWindowNameExist(windowName.."ListViewScrollChildItem"..listIndex)) then
					WindowSetShowing(windowName.."ListViewScrollChildItem"..listIndex, false)
				end
				return
			end
    		
    		if ContainerWindow.ViewModes[containerId] == "List" then
				-- Name
				local scl = WindowGetScale(windowName) --InterfaceCore.scale
				ElementName = windowName.."ListViewScrollChildItem"..listIndex.."Name"
				if (DoesWindowNameExist(ElementName) and ContainerWindow.ViewModes[WindowGetId(windowName)] ~= "Freeform") then
					WindowSetScale(ElementName, scl)
				end
				local font = "font_verdana_bold_shadow_small"
				if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
						font = "UO_DefaultText"
				end
				if(DoesWindowNameExist(ElementName)) then
					LabelSetFont(ElementName,font , WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				end
				local text = wstring.find(item.name , UI.GetCliloc(SystemData.Settings.Language.type, 265))
				local gumpID = WindowData.ContainerWindow[containerId].gumpNum
				if (text and (WindowData.ContainerWindow[containerId].isCorpse or gumpID == 9)) and (ContainerWindow.OpenContainers[containerId].LateUpdate and ContainerWindow.OpenContainers[containerId].LateUpdate > 1) then
					text = wstring.find(item.name , UI.GetCliloc(SystemData.Settings.Language.type, 266))
					if (text) then
						item.name = UI.GetCliloc(SystemData.Settings.Language.type, 267)
					end
					text = wstring.find(item.name , UI.GetCliloc(SystemData.Settings.Language.type, 268))
					if (text) then
						item.name = UI.GetCliloc(SystemData.Settings.Language.type, 269)
					end
					text = wstring.find(item.name , UI.GetCliloc(SystemData.Settings.Language.type, 270))
					if (text) then
						item.name = UI.GetCliloc(SystemData.Settings.Language.type, 271)
					end
					text = wstring.find(item.name , UI.GetCliloc(SystemData.Settings.Language.type, 272))
					if (text) then
						item.name = UI.GetCliloc(SystemData.Settings.Language.type, 273)
					end
					text = wstring.find(item.name , UI.GetCliloc(SystemData.Settings.Language.type, 274))
					if (text) then
						item.name = UI.GetCliloc(SystemData.Settings.Language.type, 275)
					end
					text = wstring.find(item.name , UI.GetCliloc(SystemData.Settings.Language.type, 276))
					if (text) then
						item.name = UI.GetCliloc(SystemData.Settings.Language.type, 277)
					end
					text = wstring.find(item.name , UI.GetCliloc(SystemData.Settings.Language.type, 278))
					if (text) then
						item.name = UI.GetCliloc(SystemData.Settings.Language.type, 279)
					end
					
				end
					
				if (WindowData.ContainerWindow[containerId].isCorpse  or gumpID == 9) then
					if ContainerWindow.KnowsArti[updateId] == nil then
						ContainerWindow.KnowsArti[updateId] = IsArtifact(item.name, updateId) or IsReplica(item.name, updateId)
					end
					if ContainerWindow.KnowsSet[updateId] == nil then
						ContainerWindow.KnowsSet[updateId] = IsSet(item.name, updateId)
					end
					
					if ( ContainerWindow.KnowsRelics[updateId] == nil) then
					
						ContainerWindow.KnowsRelics[updateId] = false
						if (ContainerWindow.KnowsArti[updateId] == false and ContainerWindow.KnowsSet[updateId] == false) then
							local prop = GetObjectProperties( updateId )
							if prop then
								local relic = ItemProperties.ItemParsing(prop, true)
								if (relic) then
									if (relic == GetStringFromTid(1031697)) then
										ContainerWindow.KnowsRelics[updateId] = relic
									elseif (relic == GetStringFromTid(1031698)) then
										ContainerWindow.KnowsRelics[updateId] = relic
									elseif (relic == GetStringFromTid(1031699)) then
										ContainerWindow.KnowsRelics[updateId] = relic
									end
								end
							end
						end
					end
				end
				if (wstring.lower(item.name) == GetStringFromTid(1041361)) then -- a bank check
					local prop = GetObjectProperties( updateId, 4 )
					if(DoesWindowNameExist(ElementName)) then
						LabelSetText(ElementName, item.name .. L"\n" .. prop)
					end
				elseif(DoesWindowNameExist(ElementName)) then
					LabelSetText(ElementName, item.name )
				end
				
				local uses = ContainerWindow.GetUses(updateId, containerId)
				if( uses and DoesWindowNameExist(ElementName)) then
					LabelSetText(ElementName, item.name .. L"\n   " .. WindowUtils.Decapitalizing(wstring.gsub(GetStringFromTid(1060584), L"~1_val~", uses)))
				end
				
				LabelSetTextColor(ElementName, EnhancePack.PLAIN_COLOR.r, EnhancePack.PLAIN_COLOR.g, EnhancePack.PLAIN_COLOR.b)
				
				if (ContainerWindow.KnowsArti[updateId] == true) then
					LabelSetTextColor(ElementName, EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)
				elseif (ContainerWindow.KnowsSet[updateId] == true) then
					LabelSetTextColor(ElementName, EnhancePack.SET_COLOR.r, EnhancePack.SET_COLOR.g, EnhancePack.SET_COLOR.b)				
				elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031697) ) then
					if(DoesWindowNameExist(ElementName)) then
						LabelSetTextColor(ElementName, EnhancePack.RESIDUE_COLOR.r, EnhancePack.RESIDUE_COLOR.g, EnhancePack.RESIDUE_COLOR.b)
					end
				elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031698) ) then
					if(DoesWindowNameExist(ElementName)) then
						LabelSetTextColor(ElementName, EnhancePack.ESSENCE_COLOR.r, EnhancePack.ESSENCE_COLOR.g, EnhancePack.ESSENCE_COLOR.b)
					end
				elseif (ContainerWindow.KnowsRelics[updateId] == GetStringFromTid(1031699) ) then
					--if (not wstring.find(item.name, L"[(]Relic[)]") ) then
					--	item.name = L"(Relic) " .. item.name
					--end
					if(DoesWindowNameExist(ElementName)) then
						LabelSetTextColor(ElementName, EnhancePack.RELIC_COLOR.r, EnhancePack.RELIC_COLOR.g, EnhancePack.RELIC_COLOR.b)
					end
				
				end
				
				if(DoesWindowNameExist(ElementName)) then
					WindowSetShowing(ElementName, true)
				end

				-- Icon
				elementIcon = windowName.."ListViewScrollChildItem"..listIndex.."Icon"		    
				if( DoesWindowNameExist(elementIcon) and item.iconName ~= "" ) then
					if ( EnhancePack.TrapBoxID == 0 and EnhancePack.oldTrapBoxID == updateId) then
						EnhancePack.oldTrapBoxID = 0
					end
					if ( EnhancePack.LootBoxID == 0 and EnhancePack.oldLootBoxID == updateId) then
						EnhancePack.oldLootBoxID = 0
					end
					item.id = updateId
					EquipmentData.UpdateItemIcon(elementIcon, item)
	    			
					parent = WindowGetParent(elementIcon)
					WindowClearAnchors(elementIcon)
					local w = item.newWidth or 45
					local h = item.newHeight or 45
					WindowAddAnchor(elementIcon, "topleft", parent, "topleft", 15+((45-w)/2), 10+((45-h)/2))
					if(DoesWindowNameExist(this.."ListViewScrollChildItem"..listIndex)) then
						WindowSetShowing(this.."ListViewScrollChildItem"..listIndex, true)
					end

					WindowSetShowing(elementIcon, true)
				elseif( DoesWindowNameExist(elementIcon) ) then
					WindowSetShowing(elementIcon, false)
				end
			else
			
				 -- Grid View Icon & Quantity Label
		    
				if( item.iconName ~= "" ) then
					elementIcon = windowName.."GridViewSocket"..gridIndex.."Icon"
					if DoesWindowNameExist(elementIcon .. "Multi") then
						DynamicImageSetTexture( elementIcon .. "Multi", "", 0, 0 )
						WindowSetShowing(elementIcon .. "Multi", false)
					end
					if DoesWindowNameExist(elementIcon) then
						item.id = updateId
						EquipmentData.UpdateItemIcon(elementIcon, item)	
						if item.quantity > 1 and item.objectType ~= 3821 and item.objectType ~= 3824 then
							if DoesWindowNameExist(elementIcon .. "Multi") then
								EquipmentData.UpdateItemIcon(elementIcon .. "Multi", item)
								WindowSetShowing(elementIcon .. "Multi", true)	
							end
						end
						local gridViewItemLabel = windowName.."GridViewSocket"..gridIndex.."Quantity"
						LabelSetText(gridViewItemLabel, L"")
						
						local uses =  ContainerWindow.GetUses(updateId, containerId)
						if( item.quantity ~= nil and item.quantity > 1 ) then 
							LabelSetText(gridViewItemLabel, L""..WindowUtils.AddCommasToNumber(item.quantity))
						elseif( uses) then
							LabelSetText(gridViewItemLabel, L""..uses)
						end
					end
				end
				
		    end
		    
	    end
	end 
end

function ContainerWindow.GetContent(contId)
	local prop = GetObjectProperties(contId, "last")
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BANK)
	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BANK)
	if (WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK] and contId == WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK].objectId) or prop == nil then
		local items, qta, wgt = ContainerWindow.ScanQuantities(contId)
		if prop then
			lprop = wstring.lower(prop)
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
				txt = wstring.sub(lprop, 10)
				text = string.find(WStringToString(txt) , ",")
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
				txt = wstring.sub(lprop, 7)
				text = string.find(WStringToString(txt) , ",")
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
				txt = wstring.sub(lprop, 7)
				text = string.find(WStringToString(txt) , " ")
			end
			
			local cont = wstring.trim(txt)
			
			local base
			local final = L""
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
				base  = StringToWString(string.sub(WStringToString(EnhancePack.GetStringFromTid(1072241)), 1, 9)) .. wstring.sub(txt, 0, text + 1)
				txt = wstring.sub(txt, text + 1, wstring.len(txt) - 7)
				final = StringToWString(string.sub(WStringToString(EnhancePack.GetStringFromTid(1072789)), -6))
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
				base  = wstring.sub(lprop, 1, text - 1) .. wstring.sub(txt, 0, text + 6)
				txt = wstring.sub(txt, text + 6, wstring.len(txt) )
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
				base  =  wstring.sub(GetStringFromTid(1072241), 1, 6) .. wstring.sub(txt, 0, text + 5)
				txt = wstring.sub(lprop, 10)
				final = wstring.sub(EnhancePack.GetStringFromTid(1072789), -1)
			end
			text = wstring.find(cont , L"[/]")


			if ( text ~= nil) then
				base = wstring.sub(base, 1, wstring.find(base, L" "))

				local max =  wstring.sub(cont, text+1, wstring.find(cont, L" "))
				
				max = WindowUtils.AddCommasToNumber(max)
				prop = base .. qta .. L"/" .. max .. L" " .. WindowUtils.AddCommasToNumber(wgt) .. L" " .. final
			end
		else
			prop = ReplaceTokens(GetStringFromTid(1073841), {towstring(qta), towstring(125), WindowUtils.AddCommasToNumber(wgt)})   -- Contents: ~1_COUNT~/~2_MAXCOUNT~ items, ~3_WEIGHT~ stones
		end
	end

	if prop and prop ~= L"" and wstring.find(prop, L":") then
		return prop
	end
end

function ContainerWindow.ScanSubCont(id, allItems)
	RegisterWindowData(WindowData.ContainerWindow.Type, id)
	local qta = 0
	local wgt = 0
	if not WindowData.ContainerWindow[id] then
	
		local props = ItemProperties.GetObjectProperties(id)
		if props then
			for i =1, #props do
				lprop = wstring.lower(props[i])
				if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
					text = string.find(WStringToString(props[i]) , string.sub(WStringToString(GetStringFromTid(1072225)), 1, -13)) -- "Weight:" 
				elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
					text = wstring.find(props[i] , wstring.sub(GetStringFromTid(1072225), 1, -19)) -- "Weight:" 
				else
					text = wstring.find(props[i] , wstring.sub(GetStringFromTid(1072225), 1, -11)) -- "Weight:" 
				end
				if ( text ~= nil and lprop ~= GetStringFromTid(1149699) ) then
					local num 
					if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
						num = wstring.sub(lprop, 8, -7)
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
						num = wstring.sub(lprop, 4)
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
						num = wstring.sub(lprop, 3, -2)
					end
					wgt = wgt + tonumber(num)
					break
				end
			end
		end
		UnregisterWindowData(WindowData.ContainerWindow.Type, id)		
		return allItems, qta, wgt
	else	
		local numItems = WindowData.ContainerWindow[id].numItems
		
		local props = ItemProperties.GetObjectProperties(id)
		if props then
			for i =1, #props do
				lprop = wstring.lower(props[i])
				if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
					text = string.find(WStringToString(props[i]) , string.sub(WStringToString(GetStringFromTid(1072225)), 1, -13)) -- "Weight:" 
				elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
					text = wstring.find(props[i] , wstring.sub(GetStringFromTid(1072225), 1, -19)) -- "Weight:" 
				else
					text = wstring.find(props[i] , wstring.sub(GetStringFromTid(1072225), 1, -11)) -- "Weight:" 
				end
				if ( text ~= nil and lprop ~= GetStringFromTid(1149699) ) then
					local num 
					if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
						num = wstring.sub(lprop, 8, -7)
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
						num = wstring.sub(lprop, 4)
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
						num = wstring.sub(lprop, 3, -2)
					end
					wgt = wgt + tonumber(num)
					break
				end
			end	
			
			for i =1, #props do
				lprop = wstring.lower(props[i])
				
				if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
					text = string.find(WStringToString(props[i]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072241)), 1, 9)) -- "Contents:"
				elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
					text = string.find(WStringToString(props[i]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072241)), 1, 6)) -- "Contents:"
				elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
					text =  string.find(WStringToString(props[i]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072241)), 1, 5)) -- "Contents:"
				end
				
				if ( text ~= nil) then
					local txt
					
					if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
						txt = wstring.sub(lprop, 10)
						text = string.find(WStringToString(txt) , ",")
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
						txt = wstring.sub(lprop, 7)
						text = string.find(WStringToString(txt) , ",")
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
						txt = wstring.sub(lprop, 7)
						text = string.find(WStringToString(txt) , " ")
					end
					
					text = string.find(WStringToString(txt) , "[/]")
					local val = 0
					if ( text ~= nil) then
						local actual =  wstring.sub(txt, 2,  text - 1)
						
						actual = WindowUtils.AddCommasToNumber(actual)
						local max =  wstring.sub(txt, text+1, wstring.len(txt))
						max = WindowUtils.AddCommasToNumber(max)

						val = tonumber(actual)

					end
					qta = val

					break
				end
			end	
		end
		for i = 1, numItems do
			local item = WindowData.ContainerWindow[id].ContainedItems[i]
			allItems = ContainerSearch.ScanSubCont(item.objectId, allItems)
			table.insert(allItems,item.objectId )
		end
		
		UnregisterWindowData(WindowData.ContainerWindow.Type, id)	
	end
	
	return allItems, qta, wgt
end

function ContainerWindow.ScanQuantities(backpackId)
	if not WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK] then
		return
	end
	local AllItems = {}
	local qta = 0 
	local wgt = 0
	if not WindowData.ContainerWindow[backpackId] then
		RegisterWindowData(WindowData.ContainerWindow.Type, backpackId)
	end
	local numItems = WindowData.ContainerWindow[backpackId].numItems
	qta = numItems
	for i = 1, numItems do
		local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		AllItems, qt, wg = ContainerWindow.ScanSubCont(item.objectId, AllItems)
		table.insert(AllItems,item.objectId )
		qta = qta + qt
		wgt = wgt + wg
	end
	
	if wgt > 0 then
		
		local props = ItemProperties.GetObjectProperties(backpackId)
		if props then
			for i =1, #props do
				lprop = wstring.lower(props[i])
				
				if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
					text = string.find(WStringToString(props[i]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072241)), 1, 9)) -- "Contents:"
				elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
					text = string.find(WStringToString(props[i]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072241)), 1, 6)) -- "Contents:"
				elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
					text =  string.find(WStringToString(props[i]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072241)), 1, 5)) -- "Contents:"
				end
				
				if ( text ~= nil) then
					local txt

					if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
						txt = wstring.sub(lprop, 10)
						text = string.find(WStringToString(txt) , ",")
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
						txt = wstring.sub(lprop, 7)
						text = string.find(WStringToString(txt) , ",")
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
						txt = wstring.sub(lprop, 7)
						text = string.find(WStringToString(txt) , " ")
					end
					
					
					local base
					local final = L""
					if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
						base  = StringToWString(string.sub(WStringToString(EnhancePack.GetStringFromTid(1072241)), 1, 9)) .. wstring.sub(txt, 0, text + 1)
						txt = wstring.sub(txt, text + 1, wstring.len(txt) - 7)
						final = StringToWString(string.sub(WStringToString(EnhancePack.GetStringFromTid(1072789)), -6))
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
						base  = wstring.sub(lprop, 1, text - 1) .. wstring.sub(txt, 0, text + 6)
						txt = wstring.sub(txt, text + 6, wstring.len(txt) )
					elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
						base  =  wstring.sub(GetStringFromTid(1072241), 1, 6) .. wstring.sub(txt, 0, text + 5)
						txt = wstring.sub(lprop, 10)
						final = wstring.sub(EnhancePack.GetStringFromTid(1072789), -1)
					end
					
					
					text = string.find(WStringToString(txt) , "[/]")
					local val
					if ( text ~= nil) then
						local actual =  wstring.sub(txt, 2,  text - 1)
						actual = WindowUtils.AddCommasToNumber(actual)
						local max =  wstring.sub(txt, text+1, wstring.len(txt))
						max = WindowUtils.AddCommasToNumber(max)
						val = tonumber(actual)
					else
						val = tonumber(txt)
					end
					wgt = wgt + val
					break
				end
			end	
		end
	end
	
	return AllItems, qta, wgt
end

function ContainerWindow.UpdateUses()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	local usesSTR = wstring.lower(wstring.gsub(GetStringFromTid(1060584), L"~1_val~", L""))
	local chargesSTR = wstring.lower(wstring.gsub(GetStringFromTid(1060741), L"~1_val~", L""))
	local petalsSTR = wstring.lower(wstring.gsub(GetStringFromTid(1062925), L"~1_COUNT~", L""))


	local getObj = GetObjectProperties
	
	ContainerWindow.CurrentUses[id] = {}
	
	if (WindowData.ContainerWindow[id]) then
		local numItems = WindowData.ContainerWindow[id].numItems
		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[id].ContainedItems[i]
			local objectId = item.objectId

			local props = getObj( objectId)
			local amount
			
			if not props then
				continue
			end
			
			for j = 1, #props do
				prop = props[j]
				
				if not prop or prop == L"" then
					continue
				end
				
				prop = wstring.lower(prop)
				

				if (prop and wstring.find(prop, usesSTR)) then -- uses
					amount = wstring.gsub(prop, usesSTR, L"")
					amount = tonumber(amount)
					ContainerWindow.CurrentUses[id][objectId] = EnhancePack.Knumber(amount)
				end
				

				
				if (prop and not amount and wstring.find(prop, chargesSTR)) then -- charges
					amount = wstring.gsub(prop, chargesSTR, L"")
					amount = tonumber(amount)
					ContainerWindow.CurrentUses[id][objectId] = EnhancePack.Knumber(amount)
				end
				
				if (prop and not amount and wstring.find(prop, petalsSTR)) then -- petals
					amount = wstring.gsub(prop, petalsSTR, L"")
					amount = tonumber(amount)
					ContainerWindow.CurrentUses[id][objectId] = EnhancePack.Knumber(amount)
				end
			end
		end
	end
	
	ContainerWindow.LastUsesDelta[id] = 0
	ContainerWindow.UpdateContents(id)
end

function ContainerWindow.GetUses(objectId, contId)
	
	if not ContainerWindow.CurrentUses[contId] then
		return
	end
	
	return ContainerWindow.CurrentUses[contId][objectId]
end

function ContainerWindow.ToggleView()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if( WindowData.ContainerWindow[id] and WindowData.ContainerWindow[id].isSnooped == false ) then
		
        if (ContainerWindow.ViewModes[id] == "List") then
		    ContainerWindow.ViewModes[id] = "Grid"
		    ContainerWindow.UpdateGridViewSockets(id)
        elseif( ContainerWindow.ViewModes[id] == "Grid" ) then 
    	    ContainerWindow.ViewModes[id] = "List"
			ContainerWindow.UpdateListViewSockets(id)
	    end
		ContainerWindow.LegacyGridDock(WindowUtils.GetActiveDialog())
       ContainerWindow.UpdateContents(id)
    end
    
    local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	if( id == playerBackpack ) then
		SystemData.Settings.Interface.inventoryMode = ContainerWindow.ViewModes[id]
	elseif( WindowData.ContainerWindow[id] and WindowData.ContainerWindow[id].isCorpse == true ) then
		SystemData.Settings.Interface.defaultCorpseMode = ContainerWindow.ViewModes[id]
	else
		SystemData.Settings.Interface.defaultContainerMode = ContainerWindow.ViewModes[id]
	end
	
	SettingsWindow.UpdateSettings()
	
	 
end

function ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
    local slotNum = nil
    
    if( ContainerWindow.ViewModes[containerId] == "Grid" ) then
        local containedItems = WindowData.ContainerWindow[containerId].ContainedItems
        
        if( WindowData.ContainerWindow[containerId].ContainedItems ) then
            for index, item in ipairs(WindowData.ContainerWindow[containerId].ContainedItems) do
                --Debug.Print("Comparing to: "..tostring(item.gridIndex))
	            if( item.gridIndex == gridIndex ) then
		            slotNum = index
		            break
	            end
            end
        end
    else
        slotNum = gridIndex
    end
    
    return slotNum
end

ContainerWindow.Runics = {
-- L"Dull Copper Runic Hammer"
[GetStringFromTid(1049020)] = true,
-- L"Shadow Runic Hammer"
[GetStringFromTid(1049021)] = true,
-- L"Copper Runic Hammer"
[GetStringFromTid(1049022)] = true,
-- L"Bronze Runic Hammer"
[GetStringFromTid(1049023)] = true,
-- L"Golden Runic Hammer"
[GetStringFromTid(1049024)] = true,
-- L"Agapite Runic Hammer"
[GetStringFromTid(1049025)] = true,
-- L"Verite Runic Hammer"
[GetStringFromTid(1049026)] = true,
-- L"Valorite Runic Hammer"
[GetStringFromTid(1049027)] = true,

-- L"Spined Runic Sewing Kit"
[wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061118))] = true,
-- L"Horned Runic Sewing Kit"
[wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061117))] = true,
-- L"Barbed Runic Sewing Kit"
[wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061116))] = true,

-- L"Oak Runic Fletcher's Tools"
[GetStringFromTid(1072628)] = true,
-- L"Ash Runic Fletcher's Tools"
[GetStringFromTid(1072629)] = true,
-- L"Yew Runic Fletcher's Tools"
[GetStringFromTid(1072630)] = true,
-- L"Heartwood Runic Fletcher's Tools"
[GetStringFromTid(1072631)] = true,

-- L"Oak Runic Dovetail Saw"
[GetStringFromTid(1072634)] = true,
-- L"Ash Runic Dovetail Saw"
[GetStringFromTid(1072635)] = true,
-- L"Yew Runic Dovetail Saw"
[GetStringFromTid(1072636)] = true,
-- L"Heartwood Runic Dovetail Saw"
[GetStringFromTid(1072637)] = true,

-- L"Dull Copper Runic Mallet and Chisel"
[GetStringFromTid(1111796)] = true,
-- L"Shadow Runic Mallet and Chisel"
[GetStringFromTid(1111797)] = true,
-- L"Copper Runic Mallet and Chisel"
[GetStringFromTid(1111798)] = true,
-- L"Bronze Runic Mallet and Chisel"
[GetStringFromTid(1111799)] = true,
-- L"Golden Runic Mallet and Chisel"
[GetStringFromTid(1111800)] = true,
-- L"Agapite Runic Mallet and Chisel"
[GetStringFromTid(1111801)] = true,
-- L"Verite Runic Mallet and Chisel"
[GetStringFromTid(1111802)] = true,
-- L"Valorite Runic Mallet and Chisel"
[GetStringFromTid(1111803)] = true,
}

ContainerWindow.DragOne = false
function ContainerWindow.OnItemClicked(flags)
	HotbarSystem.Pressed = false
    local this = WindowUtils.GetActiveDialog()
    if (string.find(this, "goldcoins")) then
        containerId = WindowGetId(this)
        index = WindowGetId(this .. "Icon")
        item = WindowData.ContainerWindow[containerId].ContainedItems[index]


        objectId = item.objectId
            
        if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
            HandleSingleLeftClkTarget(objectId)
        elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
            DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
        end

    else
    
        local containerId = WindowGetId(WindowUtils.GetActiveDialog())
        local slotNum = WindowGetId(SystemData.ActiveWindow.name)
        
        slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)

        if( slotNum ~= nil ) then
            if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
                local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
                if (EnhancePack.HighlightLast and EnhancePack.HighlightLast ~= 0 and EnhancePack.WaitReforge) then
					UnregisterWindowData(WindowData.ObjectInfo.Type, EnhancePack.HighlightLast)
					RegisterWindowData(WindowData.ObjectInfo.Type, EnhancePack.HighlightLast)
			
					local itemdata = WindowData.ObjectInfo[EnhancePack.HighlightLast]
					if (itemdata and ContainerWindow.Runics[wstring.lower(itemdata.name)]) then
						
						local props = GetObjectProperties( objectId)
						
						if props and not ContainerWindow.Runics[wstring.lower(props[1])] and not EnhancePack.RepairRequest then
							local exc = false
							for j = 1, table.getn(props) do
								if wstring.lower(props[j]) == GetStringFromTid(1060636) then
									exc = true
									break
								end
							end
							
							if exc then
								HandleSingleLeftClkTarget(objectId)
							else
								local OK = { textTid=UO_StandardDialog.TID_OKAY , callback=function() HandleSingleLeftClkTarget(objectId) end }
			
								local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL , callback=function() HandleSingleLeftClkTarget(0) end}
								local body = UI.GetCliloc(SystemData.Settings.Language.type, 981)
								local DestroyConfirmWindow = 
											{
												windowName = "ReforgeDialog",
												titleTid = 1152080, -- REFORGE ITEM
												body = body,
												buttons = { OK, cancelButton }
											}
								UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
							end
							
						else
							HandleSingleLeftClkTarget(objectId)
						end
					else
						HandleSingleLeftClkTarget(objectId)
					end
                else
					HandleSingleLeftClkTarget(objectId)
				end
                
            elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
                local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
                DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
            end
        end
    end
end

function ContainerWindow.OnItemRelease()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		local gridIndex = WindowGetId(SystemData.ActiveWindow.name)
		local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
		local slot = nil
	
        if( WindowData.ContainerWindow[containerId].ContainedItems ~= nil and slotNum ~= nil) then
            slot = WindowData.ContainerWindow[containerId].ContainedItems[slotNum]
        end
		
		SystemData.ActiveContainer.SlotsWide = ContainerWindow.OpenContainers[containerId].slotsWide
		SystemData.ActiveContainer.SlotsHigh = ContainerWindow.OpenContainers[containerId].slotsHigh
        
        --Debug.Print("OnItemRelease: "..tostring(slot))
		-- This happens when you drop an item onto an empty grid socket
		
		if (not slot) then
            DragSlotDropObjectToContainer(containerId,gridIndex)
			return
		end
		
		local clickedObjId = slot.objectId
		if (clickedObjId ~= EnhancePack.TrapBoxID) then
			if ContainerWindow.ViewModes[containerId] == "Grid" then
				DragSlotDropObjectToObjectAtIndex(clickedObjId,gridIndex)
			else
				DragSlotDropObjectToObjectAtIndex(clickedObjId,0)
			end
        end
         ContainerWindow.UpdateContents(containerId)
	end
end

function ContainerWindow.OnContainerRelease(slotNum)
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		DragSlotDropObjectToContainer(containerId,0)
		ContainerWindow.UpdateContents(containerId)
	end
end

function ContainerWindow.OnItemDblClicked()
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)

	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)
	if( slotNum ~= nil ) then
	    local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
    	
    	if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] then
    		local pdollWeapon = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId
	    	RegisterWindowData(WindowData.ObjectInfo.Type, pdollWeapon)
	    	
    		if pdollWeapon and pdollWeapon ~= 0 and WindowData.ObjectInfo[pdollWeapon] then
    			if not WindowData.ObjectInfo[objectId] then
    				return
    			end
    			local objType = WindowData.ObjectInfo[objectId].objectType
    			
    			local pdollType = WindowData.ObjectInfo[pdollWeapon].objectType
	    		
    			local hammerEquip = false
    			for i=1, #CraftingTool.Tools[WindowData.SkillsCSV[8].NameTid] do
    				if pdollType == CraftingTool.Tools[WindowData.SkillsCSV[8].NameTid][i] then
    					hammerEquip = true
    					break
    				end
    			end
	    		
    			if hammerEquip then
    				if objType == pdollType then
    					objectId = pdollWeapon
    				else
    					for i=1, #CraftingTool.Tools[WindowData.SkillsCSV[8].NameTid] do
    						if objType == CraftingTool.Tools[WindowData.SkillsCSV[8].NameTid][i] then
    							objectId = pdollWeapon
    							break
    						end
    					end
    				end
    			end
    		end
    	end
	    EnhancePack.UserActionUseItem(objectId,false,"ContainerWindow_"..containerId)
	end
end

function ContainerWindow.OnItemRButtonUp()

end

function ContainerWindow.BDown()	
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then

		local objectId = containerId
		HandleSingleLeftClkTarget(objectId)
	end
end
ContainerWindow.ZoomedItem = ""
ContainerWindow.ZoomedItemScale = 0

function ContainerWindow.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local index = WindowGetId(this)
	local dialog = WindowUtils.GetActiveDialog()
	local containerId = WindowGetId(dialog)
	local containedItems = WindowData.ContainerWindow[containerId].ContainedItems
    local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)

	
    if( slotNum ~= nil and containedItems and containedItems[slotNum] ~= nil ) then
	    objectId = containedItems[slotNum].objectId
    	
	    if objectId then
			ContainerWindow.ItemMouseOverId = objectId
		    local itemData = { windowName = dialog,
						       itemId = objectId,
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
		    			       detail = ItemProperties.DETAIL_LONG }
		    ItemProperties.SetActiveItem(itemData)
	    end
	end
end

function ContainerWindow.OnItemGet(flags)

		local index = WindowGetId(SystemData.ActiveWindow.name)
		local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
		local gumpID = WindowData.ContainerWindow[containerId].gumpNum
		if (slotNum ~= nil) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
		
			if (objectId ~= nil or objectId ~= 0) then
				-- If player is trying to get objects from a container that is not from the players backpack have it dropped
				-- into the players backpack

				if flags == SystemData.ButtonFlags.CONTROL and  WindowData.ObjectInfo[objectId].quantity > 1 then
					ContainerWindow.DragOne = true
					ContainerWindow.HoldShiftBackup = SystemData.Settings.GameOptions.holdShiftToUnstack
					SystemData.Settings.GameOptions.holdShiftToUnstack = false
					UserSettingsChanged()
					DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
					return
				end
				local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
				if((WindowData.ContainerWindow[containerId].isCorpse == true or gumpID == 9) or (EnhancePack.QuickLootEverywhere and containerId ~= playerBackpack) ) then
					if( ContainerWindow.CanPickUp == true) then
						local itemData = WindowData.ObjectInfo[objectId]
						
						if (EnhancePack.LootBoxID == 0 or (itemData.objectType == 3821 and not EnhancePack.GoldLootBag)) then
							DragSlotAutoPickupObject(objectId)
						else
							ContainerWindow.DragAmount = itemData.quantity
							DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
							ContainerWindow.LootDrag = true
						end
						
						
						ContainerWindow.TimePassedSincePickUp = 0
						ContainerWindow.CanPickUp = false
					else
						PrintTidToChatWindow(1045157,1)
					end
				else
					TargetWindow.Context = nil
					RequestContextMenu(objectId)
				end
			end
		end
	
end

function ContainerWindow.OrganizerContext()
	if ( not ContainerWindow.Organize) then
		for i=1, Organizer.Organizers do
			local name = L"Use Organizer " .. i
			if (Organizer.Organizers_Desc[i] ~= L"") then
				name = Organizer.Organizers_Desc[i]
			end
			ContextMenu.CreateLuaContextMenuItemWithString(name ,0,i,2,Organizer.ActiveOrganizer == i)
		end
		ContextMenu.ActivateLuaContextMenu(ContainerWindow.ContextMenuCallback)
	end
end

function ContainerWindow.ContextMenuCallback( returnCode, param )
	Organizer.ActiveOrganizer = returnCode
	CustomSettings.SaveNumber( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )
end

function ContainerWindow.Organizes()
	
	ContainerWindow.OrganizeBag = nil
	ContainerWindow.OrganizeParent = nil
	if ( not ContainerWindow.Organize) then
		ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())
		if (Organizer.Organizers_Cont[Organizer.ActiveOrganizer] == 0) then
			RequestTargetInfo()
			EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 584), 1152, true)
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ContainerWindow.OrganizeTargetInfoReceived")
		else
			ContainerWindow.OrganizeBag = Organizer.Organizers_Cont[Organizer.ActiveOrganizer]
			ContainerWindow.Organize = true
			return
		end
	end
	
	ContainerWindow.Organize = false
end

function ContainerWindow.OrganizeTargetInfoReceived()
	ContainerWindow.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (ContainerWindow.OrganizeBag ~= nil  and ContainerWindow.OrganizeBag ~= 0 ) then
		ContainerWindow.Organize = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
end

function ContainerWindow.OrganizeTooltip()
	if (not ContainerWindow.Organize) then
		local name = L"Organizer " .. Organizer.ActiveOrganizer
		if (Organizer.Organizers_Desc[Organizer.ActiveOrganizer] ~= L"") then
			name = Organizer.Organizers_Desc[Organizer.ActiveOrganizer]
		end
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 585) .. L"\n".. UI.GetCliloc(SystemData.Settings.Language.type, 851) .. name)
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 587))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.RestockContext()
	if ( not ContainerWindow.Restock) then
		for i=1, Organizer.Restocks do
			local name = L"Use Restock " .. i
			if (Organizer.Restocks_Desc[i] ~= L"") then
				name = Organizer.Restocks_Desc[i]
			end
			ContextMenu.CreateLuaContextMenuItemWithString(name,0,i,2,Organizer.ActiveRestock == i)
		end
		ContextMenu.ActivateLuaContextMenu(ContainerWindow.RestockContextMenuCallback)
	end
end

function ContainerWindow.RestockContextMenuCallback( returnCode, param )
	Organizer.ActiveRestock = returnCode
	CustomSettings.SaveNumber( "OrganizerActiveRestock" , Organizer.ActiveRestock )
end

function ContainerWindow.RestockTooltip()
	if (not ContainerWindow.Restock) then
		local name = L"Restock " .. Organizer.ActiveRestock
		if (Organizer.Restocks_Desc[Organizer.ActiveRestock] ~= L"") then
			name = Organizer.Restocks_Desc[Organizer.ActiveRestock]
		end
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 606) .. L"\n".. UI.GetCliloc(SystemData.Settings.Language.type, 851) .. name)
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 607))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.Restocks()
	
	ContainerWindow.OrganizeBag = nil
	ContainerWindow.OrganizeParent = nil
	if ( not ContainerWindow.Restock) then
		ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())
		if (Organizer.Restocks_Cont[Organizer.ActiveRestock] == 0) then
			RequestTargetInfo()
			EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 584), 1152, true)
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ContainerWindow.RestockTargetInfoReceived")
		else
			ContainerWindow.OrganizeBag = Organizer.Restocks_Cont[Organizer.ActiveRestock]
			ContainerWindow.CurrentAmountArray = {}
			for i=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
				local itemL = Organizer.Restock[Organizer.ActiveRestock][i]
				if not ContainerWindow.CurrentAmountArray[itemL.type] then
					ContainerWindow.CurrentAmountArray[itemL.type] = {}
				end
				if not ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] then
					ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
				end
				ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
			end
			
			if WindowData.ContainerWindow[ContainerWindow.OrganizeBag] then
				local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].numItems
				for i = 1, numItems  do
					local item = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].ContainedItems[i]
					local itemData = WindowData.ObjectInfo[item.objectId]
					for tp, h in pairs(ContainerWindow.CurrentAmountArray) do
						if (tp == itemData.objectType and h[itemData.hueId]) then
							ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] =ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] + itemData.quantity
						end
					end
				end
			else
				EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 608), 33, true)
				ContainerWindow.OrganizeBag = nil
				return
			end
			ContainerWindow.HoldShiftBackup = SystemData.Settings.GameOptions.holdShiftToUnstack
			SystemData.Settings.GameOptions.holdShiftToUnstack = false 
			UserSettingsChanged()
			ContainerWindow.Restock = true
			return
		end
	else
		GenericQuantity.OnCancel()
		SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
		ContainerWindow.HoldShiftBackup = nil
		UserSettingsChanged()
	end
	
	ContainerWindow.Restock = false
end

function ContainerWindow.RestockTargetInfoReceived()

	ContainerWindow.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (ContainerWindow.OrganizeBag ~= nil and ContainerWindow.OrganizeBag ~= 0) then
		ContainerWindow.CurrentAmountArray = {}
		for i=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
			local itemL = Organizer.Restock[Organizer.ActiveRestock][i]
			if not ContainerWindow.CurrentAmountArray[itemL.type] then
				ContainerWindow.CurrentAmountArray[itemL.type] = {}
			end
			if not ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] then
				ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
			end
			ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
		end
		
		if WindowData.ContainerWindow[ContainerWindow.OrganizeBag] then
			local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].numItems
			for i = 1, numItems  do
				local item = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].ContainedItems[i]
				local itemData = WindowData.ObjectInfo[item.objectId]
				for tp, h in pairs(ContainerWindow.CurrentAmountArray) do
					if (tp == itemData.objectType and h[itemData.hueId]) then
						ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] =ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] + itemData.quantity
					end
				end
			end
		else
			WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
			EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 608), 33, true)
			ContainerWindow.OrganizeBag = nil
			return
		end
		ContainerWindow.HoldShiftBackup = SystemData.Settings.GameOptions.holdShiftToUnstack
		SystemData.Settings.GameOptions.holdShiftToUnstack = false 
		UserSettingsChanged()
		ContainerWindow.Restock = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
end

function ContainerWindow.UpdatePickupTimer(timePassed)
	for id, value in pairs(ContainerWindow.LastUsesDelta) do
		if (ContainerWindow.LastUsesDelta[id]) then
			ContainerWindow.LastUsesDelta[id] = ContainerWindow.LastUsesDelta[id] + timePassed
			if ContainerWindow.LastUsesDelta[id] > 5 then
				ContainerWindow.CurrentUses[id] = {}
				ContainerWindow.LastUsesDelta[id] = nil
				ContainerWindow.UpdateContents(id)
			end
		end
	end
	
	ContainerWindow.DeltaRefresh = ContainerWindow.DeltaRefresh + timePassed
	
	if (ContainerWindow.waitItems and ContainerWindow.waitItems ~= 0) then
		if (not DoesWindowNameExist("ContainerWindow_"..ContainerWindow.waitItems)) then
			ContainerWindow.waitItems = nil
			
		elseif (WindowData.ContainerWindow[ContainerWindow.waitItems] and WindowData.ContainerWindow[ContainerWindow.waitItems].ContainedItems) then
			if (EnhancePack.GridLegacy) then
				ContainerWindow.LegacyGridDock("ContainerWindow_"..ContainerWindow.waitItems)
			else
				ContainerWindow.DefaultUpdateGridViewSockets(ContainerWindow.waitItems)
			end
			ContainerWindow.UpdateContents(ContainerWindow.waitItems)
			ContainerWindow.waitItems = 0
		end
	end
	if (ContainerWindow.waitGump ~= 0) then	
		if (WindowData.ContainerWindow[ContainerWindow.waitGump] and WindowData.ContainerWindow[ContainerWindow.waitGump].ContainedItems) then
			if( ContainerWindow.ViewModes[ContainerWindow.waitGump] == "Freeform" ) then
				ContainerWindow.SetLegacyContainer( WindowData.ContainerWindow[ContainerWindow.waitGump].gumpNum, id )
			else
				ContainerWindow.LegacyGridDock("ContainerWindow_"..ContainerWindow.waitGump)
			end
			ContainerWindow.waitGump = 0
		end

	end
	
	if (ContainerWindow.waitLegacy ~= 0) then
		if (WindowData.ContainerWindow[ContainerWindow.waitLegacy] and WindowData.ContainerWindow[ContainerWindow.waitLegacy].gumpNum and WindowData.ContainerWindow[ContainerWindow.waitLegacy].gumpNum ~= 0 and WindowData.ContainerWindow[ContainerWindow.waitLegacy].ContainedItems) then
			ContainerWindow.SetLegacyContainer( WindowData.ContainerWindow[ContainerWindow.waitLegacy].gumpNum, ContainerWindow.waitLegacy )
			ContainerWindow.UpdateContents(ContainerWindow.waitLegacy)
			ContainerWindow.waitLegacy = 0
		end
	end
	
	if (ContainerWindow.delta < 0.5) then
		ContainerWindow.delta = ContainerWindow.delta + timePassed
	else
		ContainerWindow.delta = 0
		for id, value in pairs(ContainerWindow.OpenContainers) do
			if (not WindowData.ContainerWindow[id] or ContainerWindow.OpenContainers[id].inUpdate) then
				continue
			end
			local gumpID = WindowData.ContainerWindow[id].gumpNum
			this = "ContainerWindow_"  .. id
			if not DoesWindowNameExist(this) then
				UnregisterWindowData(WindowData.ContainerWindow.Type,id)
				continue
			end
			--if ((WindowData.ContainerWindow[id].isCorpse or gumpID == 9) ) then
				this = "ContainerWindow_"..id

				local list_view_this = this.."ListView" 
				local listOffset = ScrollWindowGetOffset(list_view_this)
				ScrollWindowUpdateScrollRect( list_view_this )   	
				local maxOffset = VerticalScrollbarGetMaxScrollPosition(list_view_this.."Scrollbar")
				if( listOffset > maxOffset ) then
					listOffset = maxOffset
				end
				ScrollWindowSetOffset(list_view_this,listOffset)

				if (ContainerWindow.OpenContainers[id].LastUpdate and ContainerWindow.OpenContainers[id].LastUpdate < ContainerWindow.DeltaRefresh) then
					ContainerWindow.UpdateContents(id)
				end
				
				ScrollWindowUpdateScrollRect( list_view_this  )

				ScrollWindowUpdateScrollRect( this.."GridView"  ) 
				
			--end
		end
	end
	if(ContainerWindow.CanPickUp == false) then
		ContainerWindow.TimePassedSincePickUp = ContainerWindow.TimePassedSincePickUp + timePassed
		if(ContainerWindow.TimePassedSincePickUp >= 1.2) then
			ContainerWindow.CanPickUp = true	
		end
	end
	if (ContainerWindow.DragOne) then
		if (DoesWindowNameExist("GenericQuantityWindow")) then
			ContainerWindow.DragOne = false
			DragSlotQuantityRequestResult(1)
			SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
			ContainerWindow.HoldShiftBackup = nil
			UserSettingsChanged()
		end
		
	end
	if (ContainerWindow.DragRestock) then
		if (DoesWindowNameExist("GenericQuantityWindow")) then
			DragSlotQuantityRequestResult(ContainerWindow.DragRestock)
			ContainerWindow.DragRestock = false
			local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
			DragSlotDropObjectToObjectAtIndex(backpackId,0)
			if ContainerWindow.HoldShiftBackup then
				SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
				UserSettingsChanged()
				ContainerWindow.HoldShiftBackup = nil
			end			
		end
		
	end
	
	if (ContainerWindow.LootDrag and (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM or DoesWindowNameExist("GenericQuantityWindow"))) then
		local containerId = EnhancePack.LootBoxID
		if ( IsInPlayerBackPack(containerId)) then
			if not SystemData.Settings.GameOptions.holdShiftToUnstack then
				DragSlotQuantityRequestResult(ContainerWindow.DragAmount)
			end
			DragSlotDropObjectToObjectAtIndex(containerId,0)
		end
		ContainerWindow.LootDrag = false
		return
	end
	
	if (ContainerWindow.Organize == true and (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM or DoesWindowNameExist("GenericQuantityWindow"))) then
		if (SystemData.DragItem.GenericQuantity) then
			DragSlotQuantityRequestResult(SystemData.DragItem.GenericQuantity)
		end
		DragSlotDropObjectToObjectAtIndex(ContainerWindow.OrganizeBag,0)
	elseif (ContainerWindow.Organize == true and ContainerWindow.CanPickUp == true and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM) then
		if not DoesWindowNameExist("ContainerWindow_"..ContainerWindow.OrganizeParent)  then
			ContainerWindow.Organize = false
			return
		end
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		local found = false
		local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
			local itemData = WindowData.ObjectInfo[item.objectId]
			if (itemData) then
				if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
					for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
						local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
						if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
							if(backpackId == ContainerWindow.OrganizeBag) then
								DragSlotAutoPickupObject(item.objectId)
							else
								DragSlotSetObjectMouseClickData(item.objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
							end
							ContainerWindow.TimePassedSincePickUp = 0
							ContainerWindow.CanPickUp = false
							found  = true
							return
						elseif(itemL.id > 0  and itemL.id == item.objectId) then
							if(backpackId == ContainerWindow.OrganizeBag) then
								DragSlotAutoPickupObject(item.objectId)
							else
								DragSlotSetObjectMouseClickData(item.objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
							end
							ContainerWindow.TimePassedSincePickUp = 0
							ContainerWindow.CanPickUp = false
							ContainerWindow.Organize = true
							return
						end
					end
				end	
			end
		end
		ContainerWindow.Organize = found
		if not found and Organizer.Organizers_CloseCont[Organizer.ActiveOrganizer] then
			if DoesWindowNameExist( "ContainerWindow_" .. ContainerWindow.OrganizeParent ) then
				DestroyWindow("ContainerWindow_" .. ContainerWindow.OrganizeParent)
			end
		end
		
	end
	
	
	
	if (ContainerWindow.Organize and not DoesWindowNameExist("OrganizerWarningDialog")) then
		local Warning = 
			{
				windowName = "OrganizerWarning",
				title = UI.GetCliloc(SystemData.Settings.Language.type, 591),
				body= UI.GetCliloc(SystemData.Settings.Language.type, 592),
			}
			UO_StandardDialog.CreateDialog(Warning)	
	elseif (not ContainerWindow.Organize and DoesWindowNameExist("OrganizerWarningDialog")) then
		DestroyWindow("OrganizerWarningDialog")
	end
	
	
	
	if (ContainerWindow.Restock == true and (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM or DoesWindowNameExist("GenericQuantityWindow"))) then
		if (ContainerWindow.DragAmount) then
			DragSlotQuantityRequestResult(ContainerWindow.DragAmount)
		end
		DragSlotDropObjectToObjectAtIndex(ContainerWindow.OrganizeBag,0)
		ContainerWindow.CurrentAmountArray[ContainerWindow.RestockID][ContainerWindow.RestockHue] = ContainerWindow.CurrentAmountArray[ContainerWindow.RestockID][ContainerWindow.RestockHue] +ContainerWindow.DragAmount
	elseif (ContainerWindow.Restock == true and ContainerWindow.CanPickUp == true and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM) then
		if not DoesWindowNameExist("ContainerWindow_"..ContainerWindow.OrganizeBag)  or not DoesWindowNameExist("ContainerWindow_"..ContainerWindow.OrganizeParent)  then
			GenericQuantity.OnCancel()
			SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
			UserSettingsChanged()
			ContainerWindow.HoldShiftBackup = nil
			ContainerWindow.Restock = false
			return
		end
		
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		local found = false
		local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems

		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
			local itemData = WindowData.ObjectInfo[item.objectId]			
						
			if (itemData) then
				if (Organizer.Restock[Organizer.ActiveRestock]) then
					for j=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
						local itemL = Organizer.Restock[Organizer.ActiveRestock][j]
						if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
							
							ContainerWindow.DragAmount = itemL.qta - ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue]
							if (ContainerWindow.DragAmount > 0) then
								ContainerWindow.RestockID = itemL.type
								ContainerWindow.RestockHue = itemL.hue
								if itemData.quantity < ContainerWindow.DragAmount then
									ContainerWindow.DragAmount = itemData.quantity
								end
								DragSlotSetObjectMouseClickData(item.objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
								ContainerWindow.TimePassedSincePickUp = 0
								ContainerWindow.CanPickUp = false
								ContainerWindow.Restock = true
								return
							end
						end
					end	
				end
			end
		end
		ContainerWindow.Restock = found
		if not ContainerWindow.Restock  then
			GenericQuantity.OnCancel()
			SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
			ContainerWindow.HoldShiftBackup = nil
			UserSettingsChanged()
		end
		
	end

		
	if (ContainerWindow.Restock and not DoesWindowNameExist("RestockWarningDialog")) then
		local Warning = 
			{
				windowName = "RestockWarning",
				title = UI.GetCliloc(SystemData.Settings.Language.type, 810),
				body= UI.GetCliloc(SystemData.Settings.Language.type, 592),
			}
			UO_StandardDialog.CreateDialog(Warning)	
	elseif (not ContainerWindow.Restock and DoesWindowNameExist("RestockWarningDialog")) then
		DestroyWindow("RestockWarningDialog")
	end
	
	
	if (ContainerWindow.LootAll == true and (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM or DoesWindowNameExist("GenericQuantityWindow"))) then
		if (ContainerWindow.DragAmount) then
			DragSlotQuantityRequestResult(ContainerWindow.DragAmount)
		end
		DragSlotDropObjectToObjectAtIndex(ContainerWindow.OrganizeBag,0)
		ContainerWindow.CurrentAmountArray[ContainerWindow.LootAllID][ContainerWindow.LootAllHue] = ContainerWindow.CurrentAmountArray[ContainerWindow.LootAllID][ContainerWindow.LootAllHue] +ContainerWindow.DragAmount
	elseif (ContainerWindow.LootAll == true and ContainerWindow.CanPickUp == true and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM) then
		if not DoesWindowNameExist("ContainerWindow_"..ContainerWindow.OrganizeParent) then
			GenericQuantity.OnCancel()
			ContainerWindow.LootAll = false
			return
		end
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		local found = false
		if (WindowData.ContainerWindow[ContainerWindow.OrganizeParent]) then
			local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems

			for i = 1, numItems  do
				local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
				local itemData = WindowData.ObjectInfo[item.objectId]			
							
				if (itemData) then		
					local p = Shopkeeper.stripFirstNumber(itemData.name)
					if (type(p) == "string") then
						p = StringToWString(p)
					end
					local loot = false
					if (EnhancePack.LootAllButTrash) then
						if ( p == UI.GetCliloc(SystemData.Settings.Language.type, 262) or objType == 3821) then -- GOLD
							loot = true
						end
						if (IsArtifact(p) or IsReplica(p) or IsSet(p)) then
							loot = true
						end
						if ( p == UI.GetCliloc(SystemData.Settings.Language.type, 264) or text) then -- Treasure chest
							loot = true
						end
						if (IsMaterial(p)) then
							loot = true
						end
						if (IsMagicalReagent(p)) then
							loot = true
						end
						if (ContainerWindow.KnowsRelics[item.objectId]) then
							loot = true
						end
					else
						loot = true
					end
					if (not loot) then
						continue
					end
					ContainerWindow.DragAmount = itemData.quantity
					if (EnhancePack.LootBoxID == 0 or (itemData.objectType == 3821 and not EnhancePack.GoldLootBag)) then
						DragSlotAutoPickupObject(item.objectId)
					else
						ContainerWindow.DragAmount = itemData.quantity
						DragSlotSetObjectMouseClickData(item.objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
						ContainerWindow.LootDrag = true
					end
					ContainerWindow.TimePassedSincePickUp = 0
					ContainerWindow.CanPickUp = false
					ContainerWindow.LootAll = true
					return
						
				end
			end
		end
		ContainerWindow.LootAll = found
		if DoesWindowNameExist( "ContainerWindow_" .. ContainerWindow.OrganizeParent ) then
			DestroyWindow("ContainerWindow_" .. ContainerWindow.OrganizeParent)
		end
	end

		
	if (ContainerWindow.LootAll and not DoesWindowNameExist("LootAllWarningDialog")) then
		local Warning = 
			{
				windowName = "LootAllWarning",
				title = UI.GetCliloc(SystemData.Settings.Language.type, 816),
				body= UI.GetCliloc(SystemData.Settings.Language.type, 592),
			}
			UO_StandardDialog.CreateDialog(Warning)	
	elseif (not ContainerWindow.LootAll and DoesWindowNameExist("LootAllWarningDialog")) then
		DestroyWindow("LootAllWarningDialog")
	end
end


function ContainerWindow.OnResizeBegin()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local minHeight
	local minWidth

	if (ContainerWindow.ViewModes[id] == "List") then
		minWidth = ContainerWindow.List.MinWidth
		minHeight = minWidth
	else -- "Grid"
		minWidth = ContainerWindow.Grid.MinWidth
		minHeight = minWidth
	end
	
    WindowUtils.BeginResize( WindowUtils.GetActiveDialog(), "topleft", minWidth, minHeight, false, ContainerWindow.OnResizeEnd)
end

function ContainerWindow.OnResizeEnd()
	local windowName = WindowUtils.resizeWindow
	local id = WindowGetId(windowName)

	--if (ContainerWindow.ViewModes[id] == "List" ) then
    --    ContainerWindow.UpdateListViewSockets(id)
	--elseif (ContainerWindow.ViewModes[id] == "Grid" ) then
    --   ContainerWindow.UpdateGridViewSockets(id)
    --end
	ContainerWindow.LegacyGridDock(windowName)
    ContainerWindow.UpdateContents(id) 
end

function ContainerWindow.UpdateListViewSockets(id)	
	--Debug.Print("ContainerWindow.UpdateListViewSockets("..id..")")
	
	local windowName = "ContainerWindow_"..id
	local listViewName = windowName.."ListView"
	local scrollchildName = listViewName.."ScrollChild"
	
	ContainerWindow.LegacyGridDock(windowName)	 
	

end

function ContainerWindow.DefaultUpdateGridViewSockets(id)
	if not DoesWindowNameExist("ContainerWindow_" .. id) then
		return
	end
	--Debug.Print("ContainerWindow.UpdateGridViewSockets("..id..")")
	if (not WindowData.ContainerWindow[id] or not WindowData.ContainerWindow[id].ContainedItems) then
		ContainerWindow.waitItems = id
		return
	end
	local data = WindowData.ContainerWindow[id]
	
	local windowName = "ContainerWindow_"..id
	local gridViewName = windowName.."GridView"
	local scrollViewChildName = gridViewName.."ScrollChild"
	
	-- determine the grid dimensions based on window width and height
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local GRID_WIDTH = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / ContainerWindow.Grid.SocketSize + 0.5)	
	local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / ContainerWindow.Grid.SocketSize + 0.5)
	local numSockets = GRID_WIDTH * GRID_HEIGHT
	local allSocketsVisible = numSockets >= data.maxSlots
		
	-- if numSockets is less than 125, we need additional rows to provide at least 125 sockets.
	if not allSocketsVisible then
		GRID_HEIGHT = math.ceil(data.maxSlots / GRID_WIDTH)
		numSockets = GRID_WIDTH * GRID_HEIGHT
	end
	
	if not data.numGridSockets then
		ContainerWindow.CreateGridViewSockets(windowName, 1, numSockets)
	else
		-- create additional padding sockets if needed or destroy extra ones from the last resize
		if data.numGridSockets > numSockets then
			ContainerWindow.DestroyGridViewSockets(windowName, numSockets + 1, data.numGridSockets)
		elseif data.numGridSockets < numSockets then
			ContainerWindow.CreateGridViewSockets(windowName, data.numGridSockets + 1, numSockets)
		end
	end
	data.numGridSockets = numSockets
	local scl = WindowGetScale(windowName)
	-- position and anchor the sockets
	for i = 1, data.numGridSockets do
		local socketName = windowName.."GridViewSocket"..i 
		WindowClearAnchors(socketName)
			
		if i == 1 then
			WindowAddAnchor(socketName, "topleft", scrollViewChildName, "topleft", 0, 0)
		elseif (i % GRID_WIDTH) == 1 then
			WindowAddAnchor(socketName, "bottomleft", windowName.."GridViewSocket"..i-GRID_WIDTH, "topleft", 0, 1)
		else
			WindowAddAnchor(socketName, "topright", windowName.."GridViewSocket"..i-1, "topleft", 1, 0)
		end
		WindowSetShowing(socketName, true)
		WindowSetScale(socketName, scl)
		if DoesWindowNameExist(socketName .. "IconMulti") then
			WindowSetShowing(socketName .. "IconMulti", false)
		end
	end
	
	-- dimensions for the entire grid view with GRID_WIDTH x GRID_HEIGHT dimensions
	local newGridWidth = GRID_WIDTH * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingLeft
	local newGridHeight = GRID_HEIGHT * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingTop
	
	-- fit the window width to the grid width
	local newWindowWidth = newGridWidth + ContainerWindow.Grid.PaddingRight
	local newWindowHeight = windowHeight
	
	-- if we can see every slot in the container, snap the window height to the grid and hide the void created 
	-- by the missing scrollbar
	if allSocketsVisible then
		newWindowHeight = newGridHeight + ContainerWindow.Grid.PaddingBottom
		newWindowWidth = newWindowWidth - ContainerWindow.ScrollbarWidth
	else
		newWindowHeight = windowHeight
		newGridHeight = windowHeight - (ContainerWindow.Grid.PaddingBottom + ContainerWindow.Grid.PaddingTop)
	end
	
	WindowSetDimensions(windowName, newWindowWidth, newWindowHeight)
	WindowSetDimensions(gridViewName, newGridWidth, newGridHeight)
	WindowSetDimensions(scrollViewChildName, newGridWidth, newGridHeight)
	
	ScrollWindowUpdateScrollRect(gridViewName) 
	
	if ContainerWindow.OpenContainers[id] then
		ContainerWindow.OpenContainers[id].slotsWide = GRID_WIDTH
		ContainerWindow.OpenContainers[id].slotsHigh = GRID_HEIGHT
	end
	
end

function ContainerWindow.LegacyGridDock(this)
	if not DoesWindowNameExist(this) then
		return
	end
	local id = WindowGetId(this)
	WindowSetShowing(this.."GridView", false)
	if not id or not WindowData.ContainerWindow[id] or ContainerWindow.ViewModes[id] == "Freeform"	then
		if (id) then
			ContainerWindow.waitGump = id
		end
		return
	end
	if (ContainerWindow.ViewModes[id] ~= "Freeform" ) then
		EnhancePack.LoadScale( this )
	end
	if (not EnhancePack.GridLegacy ) then
		ContainerWindow.Grid.PaddingTop = 50
		ContainerWindow.Grid.PaddingLeft = 12
		ContainerWindow.Grid.PaddingBottom = 15
		ContainerWindow.Grid.PaddingRight = 26
		ContainerWindow.Grid.SocketSize = 57
		ContainerWindow.Grid.MinWidth = 320
		
		ContainerWindow.List.PaddingTop = 50
		ContainerWindow.List.PaddingLeft = 0
		ContainerWindow.List.PaddingBottom = 15
		ContainerWindow.List.PaddingRight = 14
		ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5
		ContainerWindow.List.ItemHeight = 60
		ContainerWindow.List.MinWidth = 320
		ContainerWindow.CreateGridViewSockets(this, 1, 125)
		
		if (ContainerWindow.ViewModes[id] == "List") then
			local windowName = "ContainerWindow_"..id
			local listViewName = windowName.."ListView"
			local scrollchildName = listViewName.."ScrollChild"
			
			local windowWidth, windowHeight = WindowGetDimensions(windowName)
			local newListHeight = windowHeight - (ContainerWindow.List.PaddingTop + ContainerWindow.List.PaddingBottom)
			local newListWidth = windowWidth - (ContainerWindow.List.PaddingRight + ContainerWindow.List.PaddingLeft)
		    
			WindowSetDimensions(listViewName, newListWidth, newListHeight)
			WindowSetDimensions(scrollchildName, newListWidth, newListHeight)
			
			ScrollWindowUpdateScrollRect(listViewName) 
		else
			ContainerWindow.DefaultUpdateGridViewSockets(id)
		end
		if (ContainerWindow.ViewModes[id] ~= "Freeform" ) then
			if (EnhancePack.PlayerBackpack ~= id  and WindowData.ContainerWindow[id].gumpNum ~= 1422) then
				WindowClearAnchors(this.."Restock")
				WindowAddAnchor( this.."Restock", "topleft", this.."ViewButton", "topleft", -25, -5)
				WindowClearAnchors(this.."Organize")
				WindowAddAnchor( this.."Organize", "topleft", this.."Restock", "topright", -2, 10)
				WindowClearAnchors(this.."LootAll")
					WindowAddAnchor( this.."LootAll", "topleft", this.."Restock", "topright", 0, 0)
				WindowSetShowing(this.."Organize", true)
				WindowSetShowing(this.."Restock", true)
				WindowSetShowing(this.."Search", true)	
				WindowSetShowing(this.."LootAll", true)
				WindowClearAnchors(this.."Search")
				WindowAddAnchor( this.."Search", "topleft", this, "topleft", 5, -5)
				WindowClearAnchors(this.."LootAll")
				WindowAddAnchor( this.."LootAll", "topright", this.."Search", "topleft", 5, 0)
				WindowClearAnchors(this.."Content")
					WindowAddAnchor( this.."Content", "bottom", this, "top", 5, 5)
			elseif (WindowData.ContainerWindow[id].gumpNum ~= 1422) then
				WindowSetShowing(this.."LootAll", false)
				WindowSetShowing(this.."Search", true)	
				WindowClearAnchors(this.."Search")
				WindowAddAnchor( this.."Search", "topright", this.."Restock", "topleft", -2, 0)
				WindowClearAnchors(this.."LootAll")
					WindowAddAnchor( this.."LootAll", "topleft", this.."Restock", "topright", 0, 0)
					WindowClearAnchors(this.."Content")
					WindowAddAnchor( this.."Content", "bottom", this, "top", 5, 5)
			end
		end
		return
	end

	local gumpID = WindowData.ContainerWindow[id].gumpNum
	--Debug.Print(gumpID)
	if (gumpID < 9) then
		ContainerWindow.waitGump = id
		return
	end

	if (EnhancePack.GridLegacy ) then
		
			ContainerWindow.Grid.PaddingTop = 50
			ContainerWindow.Grid.PaddingLeft = 12
			ContainerWindow.Grid.PaddingBottom = 15
			ContainerWindow.Grid.PaddingRight = 26
			ContainerWindow.Grid.SocketSize = 57
			ContainerWindow.List.PaddingTop = 50
			ContainerWindow.List.PaddingLeft = 0
			ContainerWindow.List.PaddingBottom = 15
			ContainerWindow.List.PaddingRight = 14
			ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5

			WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
			WindowSetShowing( this.."Chrome", false )
			--WindowSetShowing( this.."Title", false )
			--gumpID = 1422 -- <-- TEST 81
			local texture = gumpID
			requestedContainerArt = requestedContainerArt or {}
			requestedContainerArt = texture
			local xSize, ySize
			local scale = 2.0
			texture, xSize, ySize = RequestGumpArt( texture )
			local textureSize = xSize
			if (textureSize < ySize) then
				textureSize = ySize
			end
			
			ContainerWindow.Grid.PaddingTop = 30
			ContainerWindow.List.PaddingTop = 30
				
			-- show legacy container art
			
			WindowSetShowing( this.."LegacyContainerArt", true )
			--WindowClearAnchors(this.."LegacyContainerArt")
			WindowSetShowing( this.."ResizeButton", false )
			WindowSetShowing( this.."Title", false )
			local font = "font_verdana_bold_shadow"
			if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
					font = "UO_DefaultText"
			end
			

				
			LabelSetFont( this.."Title", font, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
			if ( gumpID == 9 ) then
				
				
				ContainerWindow.Grid.PaddingTop = 170
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 170
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				
				WindowAddAnchor( this.."ViewButton", "Top", this, "center", 5, 105)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 30, 150)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 150)
				
			end
			
			if ( gumpID == 60 ) then
				ContainerWindow.Grid.PaddingTop = 170
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 160
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 170
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 140
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				
				
				
				if (EnhancePack.PlayerBackpack == id ) then
					WindowClearAnchors(this.."Lock")
					WindowSetShowing(this.."Lock", true)
					WindowAddAnchor( this.."Lock", "topright", this, "topright", -90, 0)
					WindowSetMovable(this,not ContainerWindow.Locked )
					WindowClearAnchors(this.."Organize")
					WindowAddAnchor( this.."Organize", "topleft", this.."Lock", "topleft", 20, 10)
					WindowClearAnchors(this.."Restock")
					WindowAddAnchor( this.."Restock", "topright", this.."Lock", "topright", -25, 0)
					WindowSetShowing(this.."Organize", true)
					WindowSetShowing(this.."Restock", true)
				end
				
				
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", -2, -65)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 90, 100)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 70, 90)
				
			end
			
			if ( gumpID == 61 ) then
				ContainerWindow.Grid.PaddingTop = 220
				ContainerWindow.Grid.PaddingLeft = 0
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 120
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 220
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 120
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", -20, -75)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 60, 100)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 40, 90)
				
			end
			
			if ( gumpID == 62 ) then
				ContainerWindow.Grid.PaddingTop = 220
				ContainerWindow.Grid.PaddingLeft = 0
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 100
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 210
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 100
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", -20, -75)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 60, 80)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 50, 70)
				
			end
			
			
			if ( gumpID == 63 ) then
				ContainerWindow.Grid.PaddingTop = 140
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 140
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", -2, -45)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 30, 80)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft",20, 70)
				
			end
			
			if ( gumpID == 64 ) then
				ContainerWindow.Grid.PaddingTop = 130
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 130
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", -10, -20)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 95)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 15, 90)
				
			end
			
			if ( gumpID == 65 ) then
				ContainerWindow.Grid.PaddingTop = 165
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 100
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 165
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 100
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -50)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 60, 60)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 40, 60)
				
			end
			
			if ( gumpID == 66 ) then
				ContainerWindow.Grid.PaddingTop = 310
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 310
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 35
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 2, -75)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 38, 205)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 15, 205)
				
			end
			
			if ( gumpID == 67 ) then
				ContainerWindow.Grid.PaddingTop = 170
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 170
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 35
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 35, 102)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 15, 102)
				
			end
			
			if ( gumpID == 68 ) then
				ContainerWindow.Grid.PaddingTop = 80
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 80
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 50
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -30)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 45, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 15, 20)
				
			end
			
			if ( gumpID == 72 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", -5, -30)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 30, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 15, 20)
				
			end
			
			if ( gumpID == 73 ) then
				ContainerWindow.Grid.PaddingTop = 310
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 310
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 35
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 2, -75)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 38, 205)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 15, 205)
				
			end
			
			if ( gumpID == 74 ) then
				ContainerWindow.Grid.PaddingTop = 310
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 310
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 35
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 2, -75)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 38, 205)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 15, 205)
				
			end
			
			if ( gumpID == 75 ) then
				ContainerWindow.Grid.PaddingTop = 170
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 170
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 35
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 35, 102)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 15, 102)
				
			end
			
			if ( gumpID == 76 ) then
				ContainerWindow.Grid.PaddingTop = 185
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 200
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 180
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 190
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "top", this, "center", 5, 30)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 95, 150)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 75, 150)
				
			end
			
			if ( gumpID == 77 ) then
				ContainerWindow.Grid.PaddingTop = 20
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 20
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 30
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", -10, -10)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 10, 10)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 0, 10)
				
			end
			
			if ( gumpID == 78 ) then
				ContainerWindow.Grid.PaddingTop = 55
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 60
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "top", this, "center", 9, 10)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 35, 40)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 30)
				
			end
			
			if ( gumpID == 79 ) then
				ContainerWindow.Grid.PaddingTop = 55
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 60
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "top", this, "center", 9, 10)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 35, 40)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 30)
				
			end
			
			if ( gumpID == 81 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 258 ) then
				ContainerWindow.Grid.PaddingTop = 92
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 110
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 92
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 90
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -80)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 50, 0)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 35, 0)
				
			end
			
			if ( gumpID == 259 ) then
				ContainerWindow.Grid.PaddingTop = 190
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 160
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 190
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 130
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -120)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 90, 40)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 65, 40)
				
			end
			
			if ( gumpID == 260 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 0
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 261 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 262 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 263 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 264 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 80
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 80
				ContainerWindow.List.BlackText = true

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 50, 40)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 40, 40)
				
			end
			
			if ( gumpID == 265 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 266 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 267 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 268 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 0
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 269 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 270 ) then
				ContainerWindow.Grid.PaddingTop = 85
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 80
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 25, 20)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 15)
				
			end
			
			if ( gumpID == 278 ) then
				ContainerWindow.Grid.PaddingTop = 120
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 80
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 120
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 80
				ContainerWindow.List.BlackText = true

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -40)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 55, 70)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 40, 70)
				
			end
			
			if ( gumpID == 282 ) then
				ContainerWindow.Grid.PaddingTop = 260
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 40
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 260
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 40
				ContainerWindow.List.BlackText = false

				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "top", this, "center", 0, 30)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 20, 130)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 130)
				
			end
			
			if ( gumpID == 283 ) then
				ContainerWindow.Grid.PaddingTop = 110
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 160
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 110
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 150
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -80)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 80, 0)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 80, 0)
				
			end
			
			if ( gumpID == 284 ) then
				ContainerWindow.Grid.PaddingTop = 250
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 160
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 250
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 160
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -80)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 70, 40)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 70, 40)
				
			end
			
			if ( gumpID == 285 ) then
				ContainerWindow.Grid.PaddingTop = 250
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 130
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 250
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 130
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -80)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 60, 60)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 60, 60)
				
			end
			
			if ( gumpID == 286 ) then
				ContainerWindow.Grid.PaddingTop = 110
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 80
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 104
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 80
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "top", this, "center", -40, 10)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 60, 32)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 60, 30)
				
			end
			
			if ( gumpID == 287 ) then
				ContainerWindow.Grid.PaddingTop = 130
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 130
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 130
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 130
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 10, -20)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 80, 0)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 80, 0)
				
			end
			
			if ( gumpID == 288 ) then
				ContainerWindow.Grid.PaddingTop = 140
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 130
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 140
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 130
				ContainerWindow.List.BlackText = false
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", -5, -50)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 80, 35)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 80, 35)
				
			end
			
			if ( gumpID == 289 ) then
				ContainerWindow.Grid.PaddingTop = 160
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 280
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 160
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 240
				ContainerWindow.List.BlackText = false
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -80)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 150, 60)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 130, 60)
				
			end
			
			if ( gumpID == 1156 ) then
				ContainerWindow.Grid.PaddingTop = 170
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 160
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 50
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -20)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 20, 90)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 80)
				
			end
			
			if ( gumpID == 1422 ) then
				ContainerWindow.Grid.PaddingTop = 220
				ContainerWindow.Grid.PaddingLeft = 130
				ContainerWindow.Grid.PaddingBottom = 170
				ContainerWindow.Grid.PaddingRight = 130
				ContainerWindow.Grid.BlackText = false
				ContainerWindow.List.PaddingTop = 160
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 50
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "top", this, "center", 0, 165)
				WindowClearAnchors(this.."Organize")
					WindowAddAnchor( this.."Organize", "topright", this.."ViewButton", "topright", 40, 2)
					WindowClearAnchors(this.."Search")
					WindowAddAnchor( this.."Search", "topright", this.."Organize", "topleft", 15, -5)
					WindowClearAnchors(this.."Restock")
					WindowAddAnchor( this.."Restock", "topleft", this.."ViewButton", "topleft", -45, -5)
					WindowClearAnchors(this.."LootAll")
					WindowAddAnchor( this.."LootAll", "topleft", this.."ViewButton", "topleft", -95, -5)
					WindowClearAnchors(this.."Content")
					WindowAddAnchor( this.."Content", "bottom", this, "top", 5, -25)
					WindowSetShowing(this.."Organize", true)
					WindowSetShowing(this.."Restock", true)
					WindowSetShowing(this.."Search", true)	
					WindowSetShowing(this.."LootAll", true)
					
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 138, 220)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 80)
				
			end
			
			if ( gumpID == 19724 ) then
				ContainerWindow.Grid.PaddingTop = 170
				ContainerWindow.Grid.PaddingLeft = 12
				ContainerWindow.Grid.PaddingBottom = 15
				ContainerWindow.Grid.PaddingRight = 50
				ContainerWindow.Grid.BlackText = true
				ContainerWindow.List.PaddingTop = 160
				ContainerWindow.List.PaddingLeft = 0
				ContainerWindow.List.PaddingBottom = 15
				ContainerWindow.List.PaddingRight = 50
				ContainerWindow.List.BlackText = true
				
				LabelSetTextColor (this.."Title", 255,26,31)
				WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
				WindowClearAnchors(this.."GridView")
				WindowClearAnchors(this.."ListView")
				WindowClearAnchors(this.."ViewButton")
				WindowAddAnchor( this.."ViewButton", "bottom", this, "center", 0, -20)
				WindowAddAnchor( this.."GridView", "topleft", this, "topleft", 20, 90)
				WindowAddAnchor( this.."ListView", "topleft", this, "topleft", 20, 80)
				
			end
			
			WindowClearAnchors(this.."LegacyContainerArt")
			WindowSetDimensions( this.."LegacyContainerArt", xSize * scale, ySize * scale )
			DynamicImageSetTexture( this.."LegacyContainerArt", texture, 0, 0 )
			DynamicImageSetTextureScale( this.."LegacyContainerArt", scale )
			WindowAddAnchor( this.."LegacyContainerArt", "topleft", this, "topleft", 0, 0)
			if ( EnhancePack.GridLegacy ) then
				if (EnhancePack.PlayerBackpack ~= id and gumpID ~= 1422) then
					WindowClearAnchors(this.."Organize")
					WindowAddAnchor( this.."Organize", "topright", this.."ViewButton", "topright", 20, 2)
					WindowClearAnchors(this.."Search")
					WindowAddAnchor( this.."Search", "topright", this.."Organize", "topright", 30, -5)
					WindowClearAnchors(this.."Restock")
					WindowAddAnchor( this.."Restock", "topleft", this.."ViewButton", "topleft", -25, -5)
					WindowClearAnchors(this.."LootAll")
					WindowAddAnchor( this.."LootAll", "topleft", this.."Restock", "topright", 0, 0)
					WindowClearAnchors(this.."Content")
					WindowAddAnchor( this.."Content", "bottom", this, "top", 5, 5)
					WindowSetShowing(this.."Organize", true)
					WindowSetShowing(this.."Restock", true)
					WindowSetShowing(this.."Search", true)	
					WindowSetShowing(this.."LootAll", true)
					
					
				elseif (gumpID ~= 1422) then
					WindowSetShowing(this.."Search", true)	
					WindowClearAnchors(this.."Search")
					WindowAddAnchor( this.."Search", "topleft", this.."Restock", "topright", -2, 0)
					WindowClearAnchors(this.."LootAll")
					WindowAddAnchor( this.."LootAll", "topleft", this.."Restock", "topright", 0, 0)
					WindowClearAnchors(this.."Content")
					WindowAddAnchor( this.."Content", "bottom", this, "top", 5, 5)
				end
			end
			
			
			local listViewName = this.."ListView"
			local scrollchildName = listViewName.."ScrollChild"
			local windowWidth, windowHeight = WindowGetDimensions(this)
			
			
			local newListHeight = windowHeight - (ContainerWindow.List.PaddingTop + ContainerWindow.List.PaddingBottom)
			local newListWidth = windowWidth - (ContainerWindow.List.PaddingRight + ContainerWindow.List.PaddingLeft)
		    RegisterWindowData(WindowData.ContainerWindow.Type, id)
		    local data = WindowData.ContainerWindow[id]
		    
		    local h = 60 * data.numItems
		    
			WindowSetDimensions(listViewName, newListWidth, newListHeight)
			WindowSetDimensions(scrollchildName, newListWidth, h)
			
			
			
			ScrollWindowUpdateScrollRect( this.."ListView"  ) 
			
			
			local maxOffset = VerticalScrollbarGetMaxScrollPosition(listViewName.."Scrollbar")
			local listOffset = ScrollWindowGetOffset(listViewName)
			if( listOffset > maxOffset ) then
				listOffset = maxOffset
			end
			ScrollWindowSetOffset(listViewName,listOffset)
			
			local data = WindowData.ContainerWindow[id]
			
			local gridViewName = this.."GridView"
			scrollViewChildName = gridViewName.."ScrollChild"
			
			
			local GRID_WIDTH = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / (ContainerWindow.Grid.SocketSize + 0.5))	
			local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / (ContainerWindow.Grid.SocketSize + 0.5))
			local numSockets = GRID_WIDTH * GRID_HEIGHT
			local allSocketsVisible = numSockets >= data.maxSlots
				
			-- if numSockets is less than 125, we need additional rows to provide at least 125 sockets.
			if not allSocketsVisible then
				GRID_HEIGHT = math.ceil(data.maxSlots / GRID_WIDTH)
				numSockets = GRID_WIDTH * GRID_HEIGHT
			end
			
			-- dimensions for the entire grid view with GRID_WIDTH x GRID_HEIGHT dimensions
			local newGridWidth = GRID_WIDTH * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingLeft
			local newGridHeight = GRID_HEIGHT * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingTop
			
			-- fit the window width to the grid width
			local newWindowWidth = newGridWidth + ContainerWindow.Grid.PaddingRight
			local newWindowHeight = windowHeight
			
			-- if we can see every slot in the container, snap the window height to the grid and hide the void created 
			-- by the missing scrollbar
			if allSocketsVisible then
				newWindowHeight = newGridHeight + ContainerWindow.Grid.PaddingBottom
				newWindowWidth = newWindowWidth - ContainerWindow.ScrollbarWidth
			else
				newWindowHeight = windowHeight
				newGridHeight = windowHeight - (ContainerWindow.Grid.PaddingBottom + ContainerWindow.Grid.PaddingTop) 
			end
			
			WindowSetDimensions(gridViewName, newGridWidth, newGridHeight)
			WindowClearAnchors(gridViewName .. "Scrollbar")
			WindowAddAnchor(gridViewName .. "Scrollbar", "topright", gridViewName, "topleft", 0-ContainerWindow.ScrollbarWidth, 0)
			--
			
			
		    
		    
		    
			if (ContainerWindow.ViewModes[id] == "Grid") then
				ContainerWindow.UpdateGridViewSockets(id, true)
			end
	
			
			
			
		end
end

function ContainerWindow.UpdateGridViewSockets(id, redo)
	--Debug.Print("ContainerWindow.UpdateGridViewSockets("..id..")")
	if (not WindowData.ContainerWindow[id] or not WindowData.ContainerWindow[id].ContainedItems) then
		ContainerWindow.waitItems = id
		return
	end
	local data = WindowData.ContainerWindow[id]
	
	local windowName = "ContainerWindow_"..id
	local gridViewName = windowName.."GridView"
	local scrollViewChildName = gridViewName.."ScrollChild"
	local gumpID = WindowData.ContainerWindow[id].gumpNum
	
	-- determine the grid dimensions based on window width and height
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local GRID_WIDTH = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / ContainerWindow.Grid.SocketSize + 0.5)	
	local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / ContainerWindow.Grid.SocketSize + 0.5)
	local numSockets = GRID_WIDTH * GRID_HEIGHT
	local allSocketsVisible = numSockets >= data.maxSlots
		
	-- if numSockets is less than 125, we need additional rows to provide at least 125 sockets.
	if not allSocketsVisible then
		GRID_HEIGHT = math.ceil(data.maxSlots / GRID_WIDTH)
		numSockets = GRID_WIDTH * GRID_HEIGHT
	end
	
	if not data.numGridSockets then
		ContainerWindow.CreateGridViewSockets(windowName, 1, numSockets)
	else
		-- create additional padding sockets if needed or destroy extra ones from the last resize
		if data.numGridSockets > numSockets then
			ContainerWindow.DestroyGridViewSockets(windowName, numSockets + 1, data.numGridSockets)
		elseif data.numGridSockets < numSockets then
			ContainerWindow.CreateGridViewSockets(windowName, data.numGridSockets + 1, numSockets)
		end
	end
	local x,y = WindowGetDimensions(gridViewName)
	x = GRID_WIDTH * ContainerWindow.Grid.SocketSize
	WindowSetDimensions(gridViewName, x + ContainerWindow.ScrollbarWidth , y)
	scrollViewChildName = gridViewName.."ScrollChild"
	local h = GRID_HEIGHT * ContainerWindow.Grid.SocketSize
	WindowSetDimensions(scrollViewChildName, x, h)
	local scl = WindowGetScale(windowName)
	data.numGridSockets = numSockets

	
		-- position and anchor the sockets
		for i = 1, data.numGridSockets do

			local socketName = windowName.."GridViewSocket"..i 
			if(DoesWindowNameExist(socketName)) then
				WindowClearAnchors(socketName)
			else
				ContainerWindow.CreateGridViewSockets(windowName, 1, numSockets)
				ContainerWindow.UpdateGridViewSockets(id)
				return
			end
				WindowSetScale(socketName, scl)
			if i == 1 then
				WindowAddAnchor(socketName, "topleft", scrollViewChildName, "topleft", 0, 0)
			elseif (i % GRID_WIDTH) == 1 then
				WindowAddAnchor(socketName, "bottomleft", windowName.."GridViewSocket"..i-GRID_WIDTH, "topleft", 0, 1)
			else
				WindowAddAnchor(socketName, "topright", windowName.."GridViewSocket"..i-1, "topleft", 1, 0)
			end
			if DoesWindowNameExist(socketName .. "IconMulti") then
				WindowSetShowing(socketName .. "IconMulti", false)
			end
			WindowSetShowing(socketName, true)	
		end

	
	

	if ContainerWindow.OpenContainers[id] then
		ContainerWindow.OpenContainers[id].slotsWide = GRID_WIDTH
		ContainerWindow.OpenContainers[id].slotsHigh = GRID_HEIGHT
	end
    WindowSetShowing(this.."GridView", true)

	ScrollWindowUpdateScrollRect( windowName.."GridView"  ) 
			
	--ContainerWindow.LegacyGridDock(windowName)
end

function ContainerWindow.CreateGridViewSockets(dialog, lower, upper)
	if(not DoesWindowNameExist(dialog)) then
		return
	end
	local id = WindowGetId(dialog)
	
	local data = WindowData.ContainerWindow[id]
	
	if not lower then
		lower = 1
	end
	
	if not upper then
		upper = data.maxSlots
	end
	
	if (upper > 200) then
		if (data.numItems > 0) then
			upper = data.numItems
		else
			upper = 1
		end
	end

	--Debug.Print("ContainerWindow.CreateGridViewSockets("..dialog..") lower = "..lower.." upper = "..upper)
	
	local parent = dialog.."GridViewScrollChild"
	
	local color = false
	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		local socketTemplate
		
		if i > data.maxSlots then
			socketTemplate = "GridViewSocketBaseTemplate"
		else
			if (not EnhancePack.ExtraBrightContainers) then
				socketTemplate = "GridViewSocketTemplate"
			else
				socketTemplate = "ColoredGridViewSocketTemplate"
			end
		end
		
		-- use the transparent grid background for legacy container views
		local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers
		if( legacyContainersMode == true ) then
		    socketTemplate = "GridViewSocketLegacyTemplate"
		end
		if (DoesWindowNameExist(socketName)) then
			DestroyWindow(socketName)
		end
		CreateWindowFromTemplate(socketName, socketTemplate, parent)
		
		if (EnhancePack and not EnhancePack.EnableContainerGrid) then
			ButtonSetTexture(socketName, Button.ButtonState.NORMAL, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.HIGHLIGHTED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.DISABLED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.PRESSED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.PRESSED_HIGHLIGHTED, "", 0, 0)
		end
		WindowSetTintColor(socketName, EnhancePack.BaseGridColor.r,EnhancePack.BaseGridColor.g,EnhancePack.BaseGridColor.b)
		
		if (color and EnhancePack.AlternateGrid) then
			WindowSetTintColor(socketName, EnhancePack.AlternateBackpack.r,EnhancePack.AlternateBackpack.g,EnhancePack.AlternateBackpack.b)
		end
		color = not color
		WindowSetId(socketName, i)
		WindowSetShowing(socketName, false)
		
		if i > data.maxSlots then
			WindowSetAlpha(socketName, 0.5)
			WindowSetTintColor(socketName, 10, 10, 10)
		end
	end
	WindowSetShowing(dialog.."GridView", false)
end

function ContainerWindow.ViewButtonMouseOver()
	local messageText = L""
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	
	if (ContainerWindow.ViewModes[containerId] == "Grid" ) then
        messageText = GetStringFromTid(ContainerWindow.TID_LIST_MODE)
        messageText = messageText .. UI.GetCliloc(SystemData.Settings.Language.type, 5031)
	elseif (ContainerWindow.ViewModes[containerId] == "List" ) then
        messageText = GetStringFromTid(ContainerWindow.TID_GRID_MODE)
        messageText = messageText .. UI.GetCliloc(SystemData.Settings.Language.type, 5031)
    end
    
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = containerId,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = L""}

	ItemProperties.SetActiveItem(itemData)
end

function ContainerWindow.DestroyGridViewSockets(dialog, lower, upper)
	local id = WindowGetId(dialog)
	local data = WindowData.ContainerWindow[id]
	
	if not lower then
		lower = 1
	end
	
	if not upper then
    upper = data.maxSlots
	end

	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		if (DoesWindowNameExist(socketName)) then
			DestroyWindow(socketName)
		end
	end
end

function ContainerWindow.GetTopOfCascade()
	local cascadeSize = table.getn(ContainerWindow.Cascade)
	if cascadeSize > 0 then
		-- loop from n to 1 , removing windows with cascading == false and returning the first
		-- with cascading == true
		for i = cascadeSize, 1, -1 do
			local windowId = ContainerWindow.Cascade[i]
			if ContainerWindow.IsCascading(windowId) then
				return windowId
			else
				ContainerWindow.Cascade[i] = nil
			end
		end
	end
	
	return nil;
end

function ContainerWindow.IsCascading(windowId)
	if ContainerWindow.OpenContainers[windowId] then
		return ContainerWindow.OpenContainers[windowId].cascading
	else
		return false
	end
end

function ContainerWindow.AddToCascade(windowId)
	if ContainerWindow.OpenContainers[windowId] then
		local cascadeSize = table.getn(ContainerWindow.Cascade) + 1
		ContainerWindow.Cascade[cascadeSize] = windowId
		ContainerWindow.OpenContainers[windowId].cascading = true
	end
end

function ContainerWindow.RemoveFromCascade(windowId)
	-- since this is called often. the ContainerWindow.Cascade array is resized in GetTopOfCascade
	if ContainerWindow.OpenContainers[windowId] then
		ContainerWindow.OpenContainers[windowId].cascading = false
	end
end
