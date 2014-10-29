----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ContextMenu = {}

ContextMenu.GREYEDOUT 	= 0x01
ContextMenu.SECONDTIER 	= 0x02
ContextMenu.HIGHLIGHTED	= 0x04

ContextMenu.HighlightColor = { r=51, g=102, b=255 }
ContextMenu.DisabledColor = { r=128, g=128, b=128 }
ContextMenu.NormalColor = { r=255, g=255, b=255}

ContextMenu.WINDOW_WIDTH = 275
ContextMenu.ITEM_WINDOW_WIDTH = 270
ContextMenu.ITEM_WINDOW_HEIGHT = 25
ContextMenu.ITEM_WINDOW_SPACING = 2

ContextMenu.NumItemsCreated = {}

-- These variables are used when the context menu is lua drive
ContextMenu.IsLuaDriven = false
ContextMenu.LuaMenuOptions = {}
ContextMenu.LuaCallback = nil

ContextMenu.SubMenuDelayTimer = nil


 
----------------------------------------------------------------
-- ContextMenu Functions
----------------------------------------------------------------

-- subMenuOptions is a table that contains the same information as the main item
-- tid, flags, returnCode, param, pressed
function ContextMenu.CreateLuaContextMenuItem(tid,flags,returnCode,param,pressed,subMenuOptions, subMenuDelay, textColor)
	local index = table.getn(ContextMenu.LuaMenuOptions) + 1

	ContextMenu.LuaMenuOptions[index] = { tid=tid, flags=flags, returnCode=returnCode, param=param, pressed=pressed, subMenuOptions=subMenuOptions, subMenuDelay=subMenuDelay, textColor=textColor}
end

function ContextMenu.CreateLuaContextMenuItemWithString(str,flags,returnCode,param,pressed,subMenuOptions,subMenuDelay,textColor)
	local index = table.getn(ContextMenu.LuaMenuOptions) + 1
	ContextMenu.LuaMenuOptions[index] = { str=str, flags=flags, returnCode=returnCode, param=param, pressed=pressed, subMenuOptions=subMenuOptions, subMenuDelay=subMenuDelay, textColor=textColor}
end

function ContextMenu.ActivateLuaContextMenu(callback)
	ContextMenu.LuaCallback = callback
	ContextMenu.IsLuaDriven = true
	WindowSetShowing("ContextMenu", true)
end

function ContextMenu.GetMenuItemData()
	if( ContextMenu.IsLuaDriven == true ) then
		return ContextMenu.LuaMenuOptions
	elseif( WindowData.ContextMenu ~= nil ) then
		return WindowData.ContextMenu.menuItems
	end
end
ContextMenu.PlayerRequest = 0
function ContextMenu.ExecuteMenuItem(returnCode,param)
	if not WindowGetShowing("ContextMenu") then
		return
	end
	if (EnhancePack.PlayerContextItemRequest) then
		ContextMenu.PlayerRequest = returnCode
	end
	if not WindowData.ContextMenu and not ContextMenu.IsLuaDriven then
		return
	end
	
	if( ContextMenu.IsLuaDriven == true ) then
		ContextMenu.IsLuaDriven = false
		--WindowSetShowing("ContextMenu",false)
		ContextMenu.LuaCallback(returnCode,param)
	else
		

		local found = false
		for i =1, #WindowData.ContextMenu.menuItems do
			if WindowData.ContextMenu.menuItems[i].returnCode == returnCode then
				if WindowData.ContextMenu.menuItems[i].flags == 0 then
					found = true
				end
				break
			elseif WindowData.ContextMenu.menuItems[i].returnCode == 1013 and returnCode == 1014 then
				returnCode = 1013
				found = true
				break
			end
		end
		
		if ObjectHandleWindow.Buy and not found then
						
			PaperdollWindow.WaitForContext = nil
			ObjectHandleWindow.Buy = nil
			returnCode = 520
			found = false
			for i =1, #WindowData.ContextMenu.menuItems do
				if WindowData.ContextMenu.menuItems[i].returnCode == returnCode then
					if WindowData.ContextMenu.menuItems[i].flags == 0 then
						found = true
					end
					break
				end
			end
			if not found then
				ContextMenu.Hide()
				return
			end
		else
			PaperdollWindow.WaitForContext = nil
			ObjectHandleWindow.Buy = nil
			if not found then
				ContextMenu.Hide()
				return
			end
		end

		WindowData.ContextMenu.returnCode = returnCode
		if EnhancePack.DEBUGMODE then
			Debug.Print(returnCode)
		end
		if returnCode == 1014 then
			EnhancePack.ChatPrint(UI.GetCliloc(SystemData.Settings.Language.type, 7024), SystemData.ChatLogFilters.SYSTEM )
		elseif returnCode == 1013 then
			EnhancePack.ChatPrint(UI.GetCliloc(SystemData.Settings.Language.type, 7025), SystemData.ChatLogFilters.SYSTEM )
		end
		BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED) 
		
		
	
		ContextMenu.Hide()
	end
end

-- OnInitialize Handler
function ContextMenu.Initialize()
	WindowSetAlpha("ContextMenuWindowBackground", 0.8)
	
	CreateWindow("ContextMenuSubMenu", false)
	
end

-- OnShown handler
function ContextMenu.Show()
	this = WindowUtils.GetActiveDialog()
	WindowSetAlpha("ContextMenu", 0.001)
	ContextMenu.HideAllItems("ContextMenu")
	local menuItems = ContextMenu.GetMenuItemData()
	if (TargetWindow.Context == true and WindowGetShowing("TargetWindow")) and menuItems and not ContextMenu.IsLuaDriven then
		TargetWindow.Context = "done"
		
		local dock = "TargetWindow"
		
		for i = 1, #menuItems do
			local iconId =10000000 +  menuItems[i].returnCode
			local name, x, y = GetIconData(iconId)
			if not name or name == "" then
				continue
			end
			
			local newWidth, newHeight = UOGetTextureSize("icon"..iconId)
			local scale = 1

			local slot = "TargetWindow" .. iconId .. "Button"
			CreateWindowFromTemplate(slot, "TargetWindowBigButtonTemplate", "Root")
			if #TargetWindow.Buttons <= 0 then
				if WindowGetShowing("TargetWindowDownBG") then
					WindowAddAnchor(slot, "topright", dock, "topleft", 0, 17)
				else
					WindowAddAnchor(slot, "bottomleft", dock, "topleft", 35, 0)
				end
			else
				WindowAddAnchor(slot, "topright", TargetWindow.Buttons[#TargetWindow.Buttons], "topleft", 5, 0)
			end
			table.insert(TargetWindow.Buttons, slot)
			ButtonSetDisabledFlag(slot, false)
			WindowSetShowing(slot.. "Disabled", false)
						
			if iconId == 1000301 then
				if EnhancePack.CurrentCreature and EnhancePack.CurrentCreature.tamable then
					local serverId = WindowData.SkillsCSV[4].ServerId
					local skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
					if skillLevel < EnhancePack.CurrentCreature.tamable then
						ButtonSetDisabledFlag(slot, true)
						WindowSetShowing(slot.. "Disabled", true)
					end
				end
			end
			
			DynamicImageSetTextureDimensions(slot .. "Icon", newWidth*scale, newHeight*scale)
			WindowSetDimensions(slot.. "Icon", newWidth*scale, newHeight*scale)
			DynamicImageSetTexture(slot .. "Icon", name, x, y )
			DynamicImageSetTextureScale(slot .. "Icon", scale)
			WindowSetId(slot, menuItems[i].returnCode)
			local tscale = WindowGetScale("TargetWindow")
			WindowSetScale(slot, tscale - (tscale / 4))
		end

		return
	elseif (EnhancePack.PlayerContextItemRequest and ContextMenu.PlayerRequest ~= 0) then
		ContextMenu.ExecuteMenuItem(ContextMenu.PlayerRequest, nil)
	else
		WindowSetAlpha("ContextMenu", 1)
	end
	
		
	WindowSetScale("ContextMenu", InterfaceCore.scale)
	-- Create any extra menu items that might be needed
	local len = table.getn(menuItems)
	
	ContextMenu.CreateMenuItems(len,"ContextMenu")
	local cmWidth, cmHeight = ContextMenu.FillMenuItems(menuItems,"ContextMenu")	
	--Debug.Print("len: " ..len)
	
	-- Set the position

	scaleFactor = 1/InterfaceCore.scale	

	mouseX = SystemData.MousePosition.x
	if mouseX + (cmWidth / scaleFactor) > SystemData.screenResolution.x then
		cmWindowX = mouseX - (cmWidth / scaleFactor)
	else
		cmWindowX = mouseX
	end
		
	mouseY = SystemData.MousePosition.y
	cmWindowY = mouseY
	if mouseY + (cmHeight / scaleFactor) > SystemData.screenResolution.y then
		cmWindowY = mouseY - (cmHeight / scaleFactor)
	else
		cmWindowY = mouseY
	end
	
	WindowSetOffsetFromParent("ContextMenu", cmWindowX * scaleFactor, cmWindowY * scaleFactor)	
	
end

function ContextMenu.Hide()
    if( WindowData.ContextMenu ~= nil ) then
	    WindowData.ContextMenu.menuItems = {}
	end
	ContextMenu.LuaMenuOptions = {}
	ContextMenu.IsLuaDriven = false
	-- reset submenu timer
	ContextMenu.SubMenuDelayTimer = nil
	ContextMenu.PlayerRequest = 0
end

function ContextMenu.CreateMenuItems(numItemsNeeded,menuWindow)
	ContextMenu.HideAllItems(menuWindow)

	local numHave
	
	if( ContextMenu.NumItemsCreated[menuWindow] == nil ) then
		numHave = 0
	else
		numHave = ContextMenu.NumItemsCreated[menuWindow]
	end
	
	if numHave >= numItemsNeeded then
		return
	end
	local scale = WindowGetScale("ContextMenuSubMenu")
	for i = numHave + 1, numItemsNeeded do
		itemName = menuWindow.."Item"..i
		
		CreateWindowFromTemplate(itemName, "ContextMenuEntryDef", menuWindow)
		WindowSetScale(itemName, scale)
		if i == 1 then
			WindowAddAnchor(itemName, "topleft", menuWindow, "topleft", 3, ContextMenu.ITEM_WINDOW_SPACING)
		else
			WindowAddAnchor(itemName, "bottomleft", menuWindow.."Item"..i-1, "topleft", 0, ContextMenu.ITEM_WINDOW_SPACING)
		end
	end
	
	
	ContextMenu.NumItemsCreated[menuWindow] = numItemsNeeded
end

function ContextMenu.FillMenuItems(menuItems,menuWindow,submenuIndex)
	local len = table.getn(menuItems) 
	
	for i = 1, len do
		--Debug.Print("Adding item index "..i.." menuWindow "..menuWindow)
	
		itemName = menuWindow.."Item"..i
		item = menuItems[i]
		--Debug.Print(L"ITEMTEXT: " .. GetStringFromTid(item.tid))
		if (item.tid) then
			ButtonSetText(itemName, GetStringFromTid(item.tid))
		else
			ButtonSetText(itemName, item.str)
		end
		
		if item.textColor then
			if type(item.textColor) == "table" then
				hueR = item.textColor.r
				hueG = item.textColor.g
				hueB = item.textColor.b
			else
				hueR,hueG,hueB,hueA = HueRGBAValue(item.textColor)
			end
			
			ButtonSetTextColor(itemName, Button.ButtonState.NORMAL, hueR, hueG, hueB)
		elseif item.flags & ContextMenu.GREYEDOUT == 0 then
			ButtonSetTextColor(itemName, Button.ButtonState.NORMAL, ContextMenu.NormalColor.r, ContextMenu.NormalColor.g, ContextMenu.NormalColor.b)
		end
		
		if( item.pressed == true ) then
			ButtonSetPressedFlag(itemName, true)
		else
			ButtonSetPressedFlag(itemName, false)
		end
		
		if( submenuIndex ~= nil and submenuIndex > 0 ) then
			local offset = submenuIndex * 100
			WindowSetId(itemName, i+offset)
		else
			WindowSetId(itemName, i)
		end
		
		WindowSetShowing(itemName, true)
		if item.flags & ContextMenu.GREYEDOUT ~= 0 then
			ButtonSetDisabledFlag(itemName, true)
			ButtonSetPressedFlag(itemName, false)
		else
			-- In case we previously set this item to disabled for a different menu
			ButtonSetDisabledFlag(itemName, false)
		end
		
		if item.flags & ContextMenu.HIGHLIGHTED ~= 0 then
			col = ContextMenu.HighlightColor
			ButtonSetTextColor(itemName, Button.ButtonState.NORMAL, col.r, col.g, col.b)
		end
		
	end
	
	
	local cmWidth = ContextMenu.WINDOW_WIDTH
	local cmHeight = len*(ContextMenu.ITEM_WINDOW_HEIGHT+ContextMenu.ITEM_WINDOW_SPACING)+5
	WindowSetDimensions(menuWindow, cmWidth, cmHeight)
	--Debug.Print("CM Height = "..cmHeight)
	
	return cmWidth, cmHeight
end

function ContextMenu.HideAllItems(menuWindow)
	numHave = ContextMenu.NumItemsCreated[menuWindow]
	
	if numHave then
		for i = 1, numHave do
			WindowSetShowing(menuWindow.."Item"..i, false)
		end
	end
	-- reset submenu timer
	ContextMenu.SubMenuDelayTimer = nil
end

function ContextMenu.MenuItemLButtonUp()
	this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	local dialog = WindowUtils.GetActiveDialog()
	local itemData = ContextMenu.GetMenuItemData()
	
	if( id < 100 ) then
		menuOption = itemData[id]
	else
		local parentId = math.floor(id / 100)
		local subMenuId = id - (parentId*100)
		--Debug.Print("ParentId="..parentId.." subMenuId="..subMenuId)
		menuOption = itemData[parentId].subMenuOptions[subMenuId]
	end
	
	if menuOption and menuOption.returnCode then
		-- If menu option is disabled, DON'T click it!
		if menuOption.flags & ContextMenu.GREYEDOUT ~= 0 then
			return
		end
		
		ContextMenu.ExecuteMenuItem(menuOption.returnCode,menuOption.param)
	else
		--Debug.Print("Error showing context menu: either menuOption or menuOption.returnCode was nil.")
	end
	
	if menuOption and menuOption.textColor then
		if type(menuOption.textColor) == "table" then
				hueR = menuOption.textColor.r
				hueG = menuOption.textColor.g
				hueB = menuOption.textColor.b
			else
				hueR,hueG,hueB,hueA = HueRGBAValue(menuOption.textColor)
			end
		ButtonSetTextColor(this, Button.ButtonState.NORMAL, hueR, hueG, hueB)
	end

	WindowSetShowing("ContextMenu", false)	
	WindowSetShowing("ContextMenuSubMenu", false)	
end

function ContextMenu.MenuItemLButtonDown()
	--Debug.Print("LButtonDown")
	
	this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	local itemData = ContextMenu.GetMenuItemData()
	if( id < 100 ) then
		menuOption = itemData[id]
	else
		local parentId = math.floor(id / 100)
		local subMenuId = id - parentId*100
		menuOption = itemData[parentId].subMenuOptions[subMenuId]
	end
	
	if menuOption and (menuOption.flags & ContextMenu.GREYEDOUT ~= 0) then
		col = ContextMenu.DisabledColor
		ButtonSetTextColor(this, Button.ButtonState.NORMAL, col.r, col.g, col.b)
	end

	if menuOption and menuOption.textColor then
		if type(menuOption.textColor) == "table" then
				hueR = menuOption.textColor.r
				hueG = menuOption.textColor.g
				hueB = menuOption.textColor.b
			else
				hueR,hueG,hueB,hueA = HueRGBAValue(menuOption.textColor)
			end
		ButtonSetTextColor(this, Button.ButtonState.NORMAL, hueR, hueG, hueB)
	end
end

function ContextMenu.Update(timePassed)
	
	if TargetWindow.Context and TargetWindow.Context ~= "done" and not ContextMenu.IsLuaDriven then
		
		if TargetWindow.TargetId ~= 0 and WindowGetShowing("TargetWindow") then
			WindowSetShowing("ContextMenu", false)
		else
			TargetWindow.Context = nil
		end
		return
	end
	if (EnhancePack.PlayerContextItemRequest and ContextMenu.PlayerRequest == 0) or TargetWindow.Context == "done" then
		EnhancePack.PlayerContextItemRequest = false
		WindowSetShowing("ContextMenu", false)
		TargetWindow.Context = nil
		return
	end
	
	if ContextMenu.SubMenuDelayTimer == nil then
		--no sub menu timer
		return
	end

	ContextMenu.SubMenuDelayTimer = ContextMenu.SubMenuDelayTimer - timePassed
	if ContextMenu.SubMenuDelayTimer > 0 then
		--still have to waite
		return
	end

	--time to show the sub menu
	
	--reset timer
	ContextMenu.SubMenuDelayTimer = nil
	
	--show sub menu
	local menuItems = ContextMenu.GetMenuItemData()
	local len = table.getn(menuItems[ContextMenu.SubMenuParentId].subMenuOptions)
	ContextMenu.CreateMenuItems(len,"ContextMenuSubMenu")
	ContextMenu.FillMenuItems(menuItems[ContextMenu.SubMenuParentId].subMenuOptions,"ContextMenuSubMenu",ContextMenu.SubMenuParentId)
	WindowSetShowing("ContextMenuSubMenu",true)
	WindowClearAnchors("ContextMenuSubMenu")
	local scale = WindowGetScale("ContextMenu")
	
	
	-- anchor the sub window based on the main window position
	local width, height = WindowGetDimensions("ContextMenuSubMenu")
	local anchorPosX, anchorPosY = WindowGetScreenPosition(ContextMenu.SubMenuParentItemName)
	if( anchorPosY + height > SystemData.screenResolution.y ) then
		WindowAddAnchor("ContextMenuSubMenu","bottomright",ContextMenu.SubMenuParentItemName,"bottomleft",0,0)
	else
		WindowAddAnchor("ContextMenuSubMenu","topright",ContextMenu.SubMenuParentItemName,"topleft",0,0)
	end
	WindowSetScale("ContextMenuSubMenu", scale)
end

function ContextMenu.MenuItemMouseOver()
	this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	local menuItems = ContextMenu.GetMenuItemData()
	
	if( id < 100 ) then
		if( menuItems[id] and menuItems[id].subMenuOptions ~= nil ) then
			-- set sub menu timer
			if menuItems[id].subMenuDelay == nil then
				ContextMenu.SubMenuDelayTimer = 0
			else
				ContextMenu.SubMenuDelayTimer = menuItems[id].subMenuDelay
			end

			ContextMenu.SubMenuParentId = id
			ContextMenu.SubMenuParentItemName = this
		end

		WindowSetShowing("ContextMenuSubMenu",false)
	end

	local menuOption = menuItems[id]
	if id > 100 then
		local parentId = math.floor(id / 100)
		local subMenuId = id - parentId*100
		menuOption = menuItems[parentId].subMenuOptions[subMenuId]
	end
	if menuOption and menuOption.textColor then
		if type(menuOption.textColor) == "table" then
				hueR = menuOption.textColor.r
				hueG = menuOption.textColor.g
				hueB = menuOption.textColor.b
			else
				hueR,hueG,hueB,hueA = HueRGBAValue(menuOption.textColor)
			end
		ButtonSetTextColor(this, Button.ButtonState.NORMAL, hueR, hueG, hueB)
	end
end

function ContextMenu.MenuItemMouseLeave()
	this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	local menuItems = ContextMenu.GetMenuItemData()

	-- reset submenu timer
	ContextMenu.SubMenuDelayTimer = nil
	
	if( menuItems ~= nil ) then
		local menuOption = menuItems[id]
		if id > 100 then
			local parentId = math.floor(id / 100)
			local subMenuId = id - parentId*100
			if menuItems[parentId] and menuItems[parentId].subMenuOptions then
				menuOption = menuItems[parentId].subMenuOptions[subMenuId]
			end
		end
		
		if menuOption and (menuOption.flags & ContextMenu.HIGHLIGHTED ~= 0) then
			col = ContextMenu.HighlightColor
			ButtonSetTextColor(this, Button.ButtonState.NORMAL, col.r, col.g, col.b)
		end
		
		if menuOption and menuOption.textColor then
			if type(menuOption.textColor) == "table" then
				hueR = menuOption.textColor.r
				hueG = menuOption.textColor.g
				hueB = menuOption.textColor.b
			else
				hueR,hueG,hueB,hueA = HueRGBAValue(menuOption.textColor)
			end
			ButtonSetTextColor(this, Button.ButtonState.NORMAL, hueR, hueG, hueB)
		end
	end
end