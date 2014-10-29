----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ObjectHandleWindow = {}
ObjectHandle = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------


ObjectHandleWindow.LootDrag = false
ObjectHandleWindow.OrganizeBag = 0
ObjectHandleWindow.Organize = false

--If the health bar for it is already open
ObjectHandleWindow.hasWindow = {}
ObjectHandleWindow.ObjectsData ={}
ObjectHandleWindow.ReverseObjectLookUp ={} 

--Default gray color of objects for their object handles
ObjectHandleWindow.grayColor = { r=172, g=172, b=172 }
ObjectHandleWindow.whiteColor = { r= 255, g=255, b= 255 }

ObjectHandleWindow.WindowShiftOffset = 15

ObjectHandleWindow.mouseOverId = 0

--Theses are used for mobiles only for setting the tint color of the object handle window
ObjectHandleWindow.Notoriety = {NONE = 1, INNOCENT = 2, FRIEND = 3, CANATTACK =4, CRIMINAL=5, ENEMY=6, MURDERER=7, INVULNERABLE=8 }
ObjectHandleWindow.TextColors = {}
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.NONE]    =  { r=64,   g=64,   b=255 } --- BLUE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.INNOCENT]   = { r=128,   g=128,   b=255 } --- BLUE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.FRIEND]   = { r=0,   g=159,   b=0 } --- GREEN 
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.CANATTACK]   = { r=64, g=64, b=64 } --- GREY/SYS
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.CRIMINAL]   = { r=64, g=64, b=64 } --- GREY/SYS
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.ENEMY]  = { r=255, g=128, b=0   } --- ORANGE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.MURDERER]  =  { r=255, g=0  , b=0  } --- RED  
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.INVULNERABLE]  = { r=251, g=194, b=2   } --- YELLOW 

ObjectHandleWindow.REFRESH_DELAY = 1
ObjectHandleWindow.RefreshTimer = 0
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ObjectHandleWindow.Initialize()
	WindowRegisterEventHandler( "Root", SystemData.Events.CREATE_OBJECT_HANDLES, "ObjectHandleWindow.CreateObjectHandles")
	WindowRegisterEventHandler( "Root", SystemData.Events.DESTROY_OBJECT_HANDLES, "ObjectHandleWindow.DestroyObjectHandles")
end

function ObjectHandleWindow.retrieveObjectsData( objectsData )
	if not objectsData then
		--Debug.PrintToDebugConsole( L"ERROR: objectsData does not exist." )
		return false
	end      
				
	objectsData.Names = WindowData.ObjectHandle.Names
	objectsData.ObjectId = WindowData.ObjectHandle.ObjectId
	objectsData.XPos = WindowData.ObjectHandle.XPos
	objectsData.YPos = WindowData.ObjectHandle.YPos
	objectsData.IsMobile = WindowData.ObjectHandle.IsMobile
	objectsData.Notoriety = WindowData.ObjectHandle.Notoriety
	
	return true
end

--Creates all the object handles for all the objects that are on screen
function ObjectHandleWindow.CreateObjectHandles()
	local objectsData = {}
	if( ObjectHandleWindow.retrieveObjectsData(objectsData) ) then
		ObjectHandleWindow.ObjectsData = objectsData
		local numberObjects = table.getn(ObjectHandleWindow.ObjectsData.ObjectId)
		for i=1, numberObjects do
			local objectId = ObjectHandleWindow.ObjectsData.ObjectId[i]
			local windowName = "ObjectHandleWindow"..objectId
			
			if (ObjectHandleToggleWindow.ShowItemsOnly and not ObjectHandleWindow.ObjectsData.IsMobile[i]) then
				
				
				local windowTintName = windowName.."Tint"
				local labelName = windowName.."TintName"
				local labelBGName = windowName.."TintNameBG"
				CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
				
				AttachWindowToWorldObject(objectId, windowName)
				
				WindowSetId(windowName, objectId)
				ObjectHandleWindow.hasWindow[objectId] = true
				ObjectHandleWindow.ReverseObjectLookUp[objectId] = i
				LabelSetText(labelName, ObjectHandleWindow.ObjectsData.Names[i])
				LabelSetText(labelBGName, ObjectHandleWindow.ObjectsData.Names[i])

				--Set the color of the window based off of the notoriety
				if(ObjectHandleWindow.ObjectsData.IsMobile[i]) then
					local hue = ObjectHandleWindow.TextColors[ObjectHandleWindow.ObjectsData.Notoriety[i]+1]
					--Debug.Print("Seting tint color mobile r ="..hue.r.."g = "..hue.g.."b = "..hue.b)
					WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
				else
					--Debug.Print("Seting tint color object r ="..ObjectHandleWindow.grayColor.r.."g = "..ObjectHandleWindow.grayColor.g.."b = "..ObjectHandleWindow.grayColor.b)
					WindowSetTintColor(windowTintName, ObjectHandleWindow.grayColor.r, ObjectHandleWindow.grayColor.g,ObjectHandleWindow.grayColor.b)
					
				end
			else

				local windowTintName = windowName.."Tint"
				local labelName = windowName.."TintName"
				local labelBGName = windowName.."TintNameBG"
				CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
				
				AttachWindowToWorldObject(objectId, windowName)
				
				WindowSetId(windowName, objectId)
				ObjectHandleWindow.hasWindow[objectId] = true
				ObjectHandleWindow.ReverseObjectLookUp[objectId] = i
				LabelSetText(labelName, ObjectHandleWindow.ObjectsData.Names[i])
				LabelSetText(labelBGName, ObjectHandleWindow.ObjectsData.Names[i])
				
				--Set the color of the window based off of the notoriety
				if(ObjectHandleWindow.ObjectsData.IsMobile[i]) then
					local hue = ObjectHandleWindow.TextColors[ObjectHandleWindow.ObjectsData.Notoriety[i]+1]
					--Debug.Print("Seting tint color mobile r ="..hue.r.."g = "..hue.g.."b = "..hue.b)
					WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
				else
					--Debug.Print("Seting tint color object r ="..ObjectHandleWindow.grayColor.r.."g = "..ObjectHandleWindow.grayColor.g.."b = "..ObjectHandleWindow.grayColor.b)
					WindowSetTintColor(windowTintName, ObjectHandleWindow.grayColor.r, ObjectHandleWindow.grayColor.g,ObjectHandleWindow.grayColor.b)
					
				end
			end
		end
	end 
end

--Destroys all the object handles on the screen when the user lets go of ctrl+shift
function ObjectHandleWindow.DestroyObjectHandles()
	for key, value in pairs(ObjectHandleWindow.hasWindow) do
		ObjectHandle.DestroyObjectWindow(key) 
	end
	if (ObjectHandleWindow.mouseOverId == key) then
		ObjectHandleWindow.mouseOverId = 0
		ItemProperties.ClearMouseOverItem()
	end
	WindowData.ObjectHandle.ObjectId = {}
end

--Destroy object handle when player right clicks the window
function ObjectHandleWindow.OnClickClose()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	ObjectHandle.DestroyObjectWindow(objectId) 
	ItemProperties.ClearMouseOverItem()
end

--Used on mobiles, if they have a context menu and they single click the context menu will come up
function ObjectHandleWindow.OnRClick()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[objectId]
	--Request context menu if the object halde they left click is an object
	if( (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) and ObjectHandleWindow.ObjectsData.IsMobile[tableLoc] and not ObjectHandleWindow.Buy ) then
		TargetWindow.Context = nil
		RequestContextMenu(objectId)
	end
end

--When player double clicks the object handle window it acts as if they double-clicked the object itself
function ObjectHandleWindow.OnDblClick()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	
	UserActionUseItem(objectId,false)
end

function ObjectHandleWindow.OnItemClicked()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	if(objectId ~= nil)then
		--If player has a targeting cursor up and they target a object handle window
		--send a event telling the client they selected a target
		if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			--Let player select there window as there target
			HandleSingleLeftClkTarget(objectId)
			return
		end
		
		local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[objectId]
		--If player is trying to drag the object handle window, have it act as if they are trying to pickup the object
		if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) then
			local cursorData
			
			if( (ObjectHandleWindow.ObjectsData.IsMobile[tableLoc] == false ) ) then
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_OBJECT)
			else				
				HealthBarManager.OnBeginDragHealthBar(objectId)
			end
		end
	end
end

function ObjectHandleWindow.OnLButtonUp()
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		
	    DragSlotDropObjectToObject(mobileId)
	end
	HandleSingleLeftClkTarget(mobileId)
	local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[mobileId]
	--Request context menu if the object halde they left click is an object
	if( (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) and ObjectHandleWindow.ObjectsData.IsMobile[tableLoc]) then
		TargetWindow.Context = nil
		RequestContextMenu(mobileId)
	end
end

--Destroy object handle window and reset the data to nil
function ObjectHandle.DestroyObjectWindow(objectId) 
	local windowName = "ObjectHandleWindow"..objectId
	if( ObjectHandleWindow.hasWindow[objectId] == true) then
		DetachWindowFromWorldObject(objectId, windowName)
		DestroyWindow(windowName)
		UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
		ObjectHandleWindow.hasWindow[objectId] = nil
		ObjectHandleWindow.ReverseObjectLookUp[objectId] = nil
	end
	
	if (ObjectHandleWindow.mouseOverId == objectId) then
		ObjectHandleWindow.mouseOverId = 0
		ItemProperties.ClearMouseOverItem()
	end
end

function ObjectHandleWindow.OnMouseOver()
	
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	local itemData =
	{
		windowName = "ObjectHandleWindow",
		itemId = objectId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)
	ObjectHandleWindow.mouseOverId = objectId
end



function ObjectHandleWindow.CreateSingle(objectId, name, noto, isMobile)

	local windowName = "ObjectHandleWindow"..objectId
	
	if (ObjectHandleToggleWindow.ShowItemsOnly and isMobile) then
		
		
		local windowTintName = windowName.."Tint"
		local labelName = windowName.."TintName"
		local labelBGName = windowName.."TintNameBG"
		CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
		
		AttachWindowToWorldObject(objectId, windowName)
		
		WindowSetId(windowName, objectId)
		ObjectHandleWindow.hasWindow[objectId] = true
		ObjectHandleWindow.ReverseObjectLookUp[objectId] = i
		LabelSetText(labelName, name)
		LabelSetText(labelBGName, name)

		--Set the color of the window based off of the notoriety
		if(ObjectHandleWindow.ObjectsData.IsMobile[i]) then
			local hue = ObjectHandleWindow.TextColors[noto+1]
			--Debug.Print("Seting tint color mobile r ="..hue.r.."g = "..hue.g.."b = "..hue.b)
			WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
		else
			--Debug.Print("Seting tint color object r ="..ObjectHandleWindow.grayColor.r.."g = "..ObjectHandleWindow.grayColor.g.."b = "..ObjectHandleWindow.grayColor.b)
			WindowSetTintColor(windowTintName, ObjectHandleWindow.grayColor.r, ObjectHandleWindow.grayColor.g,ObjectHandleWindow.grayColor.b)
			
		end
	else

		local windowTintName = windowName.."Tint"
		local labelName = windowName.."TintName"
		local labelBGName = windowName.."TintNameBG"
		CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
		
		AttachWindowToWorldObject(objectId, windowName)
		
		WindowSetId(windowName, objectId)
		ObjectHandleWindow.hasWindow[objectId] = true
		ObjectHandleWindow.ReverseObjectLookUp[objectId] = i
		LabelSetText(labelName, name)
		LabelSetText(labelBGName, name)
		
		--Set the color of the window based off of the notoriety
		if(ObjectHandleWindow.ObjectsData.IsMobile[i]) then
			local hue = ObjectHandleWindow.TextColors[noto+1]
			--Debug.Print("Seting tint color mobile r ="..hue.r.."g = "..hue.g.."b = "..hue.b)
			WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
		else
			--Debug.Print("Seting tint color object r ="..ObjectHandleWindow.grayColor.r.."g = "..ObjectHandleWindow.grayColor.g.."b = "..ObjectHandleWindow.grayColor.b)
			WindowSetTintColor(windowTintName, ObjectHandleWindow.grayColor.r, ObjectHandleWindow.grayColor.g,ObjectHandleWindow.grayColor.b)
			
		end
	end

end

ObjectHandleWindow.lastItem = 0
ObjectHandleWindow.cooldown = 0
ObjectHandleWindow.static = {}

ObjectHandleWindow.ForceIgnore = nil
function ObjectHandleWindow.OnUpdate(timePassed)
	if (ObjectHandleWindow.ForceIgnore) then
		ObjectHandle.DestroyObjectWindow(ObjectHandleWindow.ForceIgnore) 
		ObjectHandleWindow.ForceIgnore = nil
	end

	local objData = {}
		
	ObjectHandleWindow.RefreshTimer = ObjectHandleWindow.RefreshTimer + timePassed
	if(ObjectHandleWindow.RefreshTimer > ObjectHandleWindow.REFRESH_DELAY) then	
		ObjectHandleWindow.RefreshTimer = 0
		for key, value in pairs(ObjectHandleWindow.hasWindow) do
			if not(IsValidObject(key)) or DoesPlayerHaveItem(key) then
				ObjectHandle.DestroyObjectWindow(key) 
			end
		end
	end
	
	
	if ObjectHandleWindow.LootDrag then
		
		if ObjectHandleWindow.cooldown > 1.5 then
			ObjectHandleWindow.static[ObjectHandleWindow.lastItem] = true
			ObjectHandleWindow.cooldown = 0
			DragSlotDropObjectToObjectAtIndex(ObjectHandleWindow.OrganizeBag,0)
			ObjectHandleWindow.LootDrag = false
			ObjectHandleWindow.Organize = false
			ContainerWindow.CanPickUp = true
		else
			if ((SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM or DoesWindowNameExist("GenericQuantityWindow"))) then
				if SystemData.DragItem.GenericQuantity then
					DragSlotQuantityRequestResult(SystemData.DragItem.GenericQuantity)
				end
				DragSlotDropObjectToObjectAtIndex(ObjectHandleWindow.OrganizeBag,0)

				ObjectHandleWindow.LootDrag = SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM
				ObjectHandle.DestroyObjectWindow(ObjectHandleWindow.lastItem)
				return
			end
		end
	end
	

	
	
	local num = 0
	local okObjects = {}
	for key, value in pairs(ObjectHandleWindow.hasWindow) do
		if IsMobile(key) or ObjectHandleWindow.static[key] then
			continue
		end
		if (IsValidObject(key) and GetDistanceFromPlayer(key) <=2 ) then
			RegisterWindowData(WindowData.ObjectInfo.Type, key)
			local itemData = WindowData.ObjectInfo[key]
					
			if (itemData) then
				local add = false
				if EnhancePack.ScavengeAll then
					add = true
				else
					for j=1,  Organizer.Scavengers_Items[Organizer.ActiveScavenger] do
						local itemData = WindowData.ObjectInfo[key]
						
						if (itemData) then
							local itemL = Organizer.Scavenger[Organizer.ActiveScavenger][j]
							if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
								add = true
								break
							end
						end
					end
				end
				if add then
					okObjects[key] = true
					num = num + 1
				end
			end
		end
	end
	
	if num > 0 then
		if (Organizer.Scavengers_Items[Organizer.ActiveScavenger] > 0 or EnhancePack.ScavengeAll) and ContainerWindow.CanPickUp and not ObjectHandleWindow.LootDrag then
			
			if (not DoesWindowNameExist("OrganizerWarningDialog") and not ObjectHandleWindow.Organize) then
				local Warning = 
				{
					windowName = "OrganizerWarning",
					title = UI.GetCliloc(SystemData.Settings.Language.type, 5039),
					body= UI.GetCliloc(SystemData.Settings.Language.type, 5038),
				}
				UO_StandardDialog.CreateDialog(Warning)	
			end
			
			local found = false
			local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
			ObjectHandleWindow.OrganizeBag = Organizer.Scavengers_Cont[Organizer.ActiveScavenger]
			if not ObjectHandleWindow.OrganizeBag or ObjectHandleWindow.OrganizeBag == 0 then
				ObjectHandleWindow.OrganizeBag = backpackId
			end
			
			for key, value in pairs(okObjects) do

					DragSlotSetObjectMouseClickData(key, SystemData.DragSource.SOURCETYPE_OBJECT)
					ObjectHandleWindow.LootDrag = true
					ObjectHandleWindow.Organize = true
					ContainerWindow.TimePassedSincePickUp = 0
					ContainerWindow.CanPickUp = false
					ObjectHandleWindow.lastItem = key
					ObjectHandleWindow.cooldown = 0
					return

			end
			ObjectHandleWindow.Organize = false
		end
			
		if (ObjectHandleWindow.Organize and not DoesWindowNameExist("OrganizerWarningDialog")) then
			local Warning = 
				{
					windowName = "OrganizerWarning",
					title = UI.GetCliloc(SystemData.Settings.Language.type, 5039),
					body= UI.GetCliloc(SystemData.Settings.Language.type, 5038),
				}
				UO_StandardDialog.CreateDialog(Warning)	
		elseif (not ObjectHandleWindow.Organize and DoesWindowNameExist("OrganizerWarningDialog")) then
			DestroyWindow("OrganizerWarningDialog")
		end
	end
end

function ObjectHandleWindow.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	ObjectHandleWindow.mouseOverId = 0
end