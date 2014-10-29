----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Shopkeeper = {}
Shopkeeper.TID ={}
Shopkeeper.TID.SELLABLE		= 1077865		-- SELLABLE ITEMS
Shopkeeper.TID.SALES		= 1077867		-- PENDING SALES
Shopkeeper.TID.NPCSTORE		= 1077868		-- NPC STORE
Shopkeeper.TID.PURCHASES	= 1077869		-- PENDING PURCHASES
Shopkeeper.TID.NPCVENDOR	= 1077870		-- NPC VENDOR
Shopkeeper.TID.Accept		= 1013076		-- Accept
Shopkeeper.TID.Cancel		= 1006045		-- Cancel
--Shopkeeper.TID.Spent		= 1077871		-- "Spent: "
Shopkeeper.TID.Spent		= 1079160		-- Total Gold --3000087	Total 
Shopkeeper.TID.Quantity		= 1077826		-- Quantity
Shopkeeper.TID.Items		= 1077872		-- Items
Shopkeeper.TID.Cost			= 1060034		-- Cost
Shopkeeper.TID.Purchase		= 1011530		-- Purchase
Shopkeeper.TID.All			= 1077866		-- All
Shopkeeper.TID.Remove		= 1011403		-- Remove
Shopkeeper.TID.Clear		= 3000154		-- Clear

Shopkeeper.REFRESH_DELAY = 0.3
Shopkeeper.QUANTITY_DELAY = 0.3
Shopkeeper.LEFT_SIDE_ID = 0
Shopkeeper.RIGHT_SIDE_ID = 1
----------------------------------------------------------------
-- Shopkeeper Functions
----------------------------------------------------------------

function Shopkeeper.stripFirstNumber(wStr)
	local tempStr = wstring.gsub(wStr, L"^%d* ", L"" )
	return tempStr
end

function Shopkeeper.GetItemIndexById(merchantId, itemId)
    if( Shopkeeper[merchantId].Items ~= nil ) then
        for index, data in ipairs(Shopkeeper[merchantId].Items) do
            if( data.id == itemId ) then
                return index
            end
        end
    end
end

-- OnInitialize Handler
function Shopkeeper.Initialize()
    local this = SystemData.ActiveWindow.name
    local merchantId = SystemData.DynamicWindowId
    
    WindowSetId(this, merchantId)
    Interface.DestroyWindowOnClose[this] = true  
	
	-- Initialize static data
    WindowUtils.SetWindowTitle (this, GetStringFromTid(Shopkeeper.TID.NPCVENDOR) )

    ButtonSetText("PurchaseButton", GetStringFromTid(Shopkeeper.TID.Accept))
    ButtonSetText("CancelPurchaseButton", GetStringFromTid(Shopkeeper.TID.Clear))    

    LabelSetText ("TotalCostText", GetStringFromTid(Shopkeeper.TID.Spent))
    
    LabelSetText ("ShopItemsHeaderQuantityHeader", GetStringFromTid(Shopkeeper.TID.Quantity))
    LabelSetText ("ShopItemsHeaderItemNamesHeader", GetStringFromTid(Shopkeeper.TID.Items))
    LabelSetText ("ShopItemsHeaderItemCostsHeader", GetStringFromTid(Shopkeeper.TID.Cost))
    LabelSetText ("ShopItemsHeaderItemPurchaseHeader", GetStringFromTid(Shopkeeper.TID.Purchase))
    
    LabelSetText ("PurchasedItemsHeaderQuantityHeader", GetStringFromTid(Shopkeeper.TID.Quantity))
    LabelSetText ("PurchasedItemsHeaderItemNamesHeader", GetStringFromTid(Shopkeeper.TID.Items))
    LabelSetText ("PurchasedItemsHeaderItemCostsHeader", GetStringFromTid(Shopkeeper.TID.Cost))
    LabelSetText ("PurchasedItemsHeaderItemPurchaseHeader", GetStringFromTid(Shopkeeper.TID.Purchase))
    
    -- Initialize dynamic data
    Shopkeeper[merchantId] = {}
    Shopkeeper[merchantId].RefreshTimer = 0
    Shopkeeper[merchantId].OfferAccepted = false
    Shopkeeper[merchantId].IsSelling = WindowData.ShopData.IsSelling
    Shopkeeper[merchantId].Items = {}
    Shopkeeper[merchantId].IsQuantityUpdating = false
    Shopkeeper[merchantId].QuantityUpdate = {}
    
	if( WindowData.ShopData.IsSelling == true ) then    
		LabelSetText ("StoreName", GetStringFromTid(Shopkeeper.TID.SELLABLE	) )
		LabelSetText ("PurchaseListTitle", GetStringFromTid(Shopkeeper.TID.SALES) )	
		
		Shopkeeper.UpdateSellItems(this, merchantId)
	else	    
		-- get the sell container id
		RegisterWindowData(WindowData.ObjectInfo.Type, merchantId)
		Shopkeeper[merchantId].sellContainerId = WindowData.ObjectInfo[merchantId].sellContainerId

		RegisterWindowData(WindowData.ContainerWindow.Type, Shopkeeper[merchantId].sellContainerId)
		WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "Shopkeeper.HandleUpdateBuyItemsEvent")
		WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "Shopkeeper.HandleUpdateObjectEvent")
		WindowRegisterEventHandler(this, WindowData.ItemProperties.Event, "Shopkeeper.HandleUpdateObjectNameEvent")
		
		LabelSetText ("StoreName", GetStringFromTid(Shopkeeper.TID.NPCSTORE) )
		LabelSetText ("PurchaseListTitle", GetStringFromTid(Shopkeeper.TID.PURCHASES) )
		
		Shopkeeper.UpdateBuyItems(this, merchantId)
	end  
	
	--Get the amount of gold player has
	WindowRegisterEventHandler(this, WindowData.PlayerStatus.Event, "Shopkeeper.UpdatePlayersGold")
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	Shopkeeper[merchantId].PlayerGold = WindowData.PlayerStatus.Gold
	Shopkeeper[merchantId].TotalPurchaseCost = 0
	
    Shopkeeper.UpdatePlayersGold(merchantId)
end

function Shopkeeper.OnUpdate(timePassed) 
    local this = SystemData.ActiveWindow.name
    local merchantId = WindowGetId(this)
    Shopkeeper[merchantId].RefreshTimer = Shopkeeper[merchantId].RefreshTimer + timePassed
    if( Shopkeeper[merchantId].RefreshTimer > Shopkeeper.REFRESH_DELAY and
            Shopkeeper[merchantId].IsDirty == true ) then
        Shopkeeper.RefreshLists(this,merchantId)
    end
    
    if( Shopkeeper[merchantId].IsQuantityUpdating == true ) then
        Shopkeeper[merchantId].QuantityUpdate.Timer = Shopkeeper[merchantId].QuantityUpdate.Timer + timePassed
        if( Shopkeeper[merchantId].QuantityUpdate.Timer > Shopkeeper.QUANTITY_DELAY ) then
            Shopkeeper.UpdateItemRightQuantity(this, merchantId, Shopkeeper[merchantId].QuantityUpdate.ItemIndex, Shopkeeper[merchantId].QuantityUpdate.Amount)
        end
    end  
end

function Shopkeeper.UpdateSellItems(this, merchantId) 
    -- for selling we can assume that the list will never change while the window is open   
    
    local numItems = table.getn(WindowData.ShopData.Sell.Names)
    
    local itemList = Shopkeeper[merchantId].Items
    
    for itemIndex=1, numItems do
        if( WindowData.ShopData.Sell.Quantities[itemIndex] ~= 0 ) then
            itemList[itemIndex] = {}
            itemList[itemIndex].id = WindowData.ShopData.Sell.Ids[itemIndex]
		    itemList[itemIndex].leftQuantity = WindowData.ShopData.Sell.Quantities[itemIndex]
		    itemList[itemIndex].rightQuantity = 0 
		    itemList[itemIndex].totalQuantity = WindowData.ShopData.Sell.Quantities[itemIndex]
		    itemList[itemIndex].value = WindowData.ShopData.Sell.Prices[itemIndex]
		    itemList[itemIndex].name = Shopkeeper.stripFirstNumber( WindowData.ShopData.Sell.Names[itemIndex] )
		    itemList[itemIndex].objType = WindowData.ShopData.Sell.Types[itemIndex]
		end
    end
    
    Shopkeeper[merchantId].IsDirty = true
end

function Shopkeeper.HandleUpdateBuyItemsEvent()
    local this = SystemData.ActiveWindow.name
    local merchantId = WindowGetId(this)
    local sellContainer = WindowData.UpdateInstanceId
    
    if( Shopkeeper[merchantId].sellContainerId == sellContainer ) then
        Shopkeeper.UpdateBuyItems(this, merchantId)
    end
end

function Shopkeeper.UpdateBuyItems(this, merchantId)
    -- the list of buy items can be updated at any time (if any item is removed we simply set its quantities to 0)
    
    local sellContainerId = Shopkeeper[merchantId].sellContainerId
    local data = WindowData.ContainerWindow[sellContainerId]
    
    if( data == nil ) then
        return
    end
    
    local itemList = Shopkeeper[merchantId].Items
    
    for index, itemData in ipairs(itemList) do
        if( itemData.registered == true ) then
        	UnregisterWindowData(WindowData.ObjectInfo.Type, itemData.id)
            UnregisterWindowData(WindowData.ItemProperties.Type, itemData.id)
            itemData.registered = false        
        end
        itemData.found = false
    end
    
	for i = 1, data.numItems do
	    local item = data.ContainedItems[i]
	    
	    -- register for updates to this object
	    RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
	    RegisterWindowData(WindowData.ItemProperties.Type, item.objectId)	    
	    
	    -- if the item doesnt exist create an empty record
	    local itemIndex = Shopkeeper.GetItemIndexById(merchantId, item.objectId)
	    if( itemIndex == nil ) then
	        itemIndex = table.getn(itemList) + 1
	        itemList[itemIndex] = {}
	        itemList[itemIndex].id = item.objectId
	    end
	    
	    itemList[itemIndex].found = true
	    itemList[itemIndex].registered = true
	    
	    --Debug.Print("Initial: "..tostring(itemIndex)..", "..tostring(item.objectId))
	    
	    Shopkeeper.UpdateBuyObject(this, merchantId, item.objectId)
	end
	
	-- if any of the items have been removed, just clear out the quantities
	-- so we dont mess up the index order
	for index, data in ipairs(itemList) do
	    if( data.found == false ) then
	        data.totalQuantity = 0
	        data.leftQuantity = 0
	        data.rightQuantity = 0
	    end
	end
	
	Shopkeeper[merchantId].IsDirty = true
end

function Shopkeeper.HandleUpdateObjectEvent()
    local this = SystemData.ActiveWindow.name
    local merchantId = WindowGetId(SystemData.ActiveWindow.name)
    local objectId = WindowData.UpdateInstanceId
    
    Shopkeeper.UpdateBuyObject(this, merchantId, objectId)
end

function Shopkeeper.HandleUpdateObjectNameEvent()
    local this = SystemData.ActiveWindow.name
    local merchantId = WindowGetId(SystemData.ActiveWindow.name)
    local objectId = WindowData.UpdateInstanceId

    Shopkeeper.UpdateBuyObject(this, merchantId, objectId)
end


function Shopkeeper.UpdateBuyObject(this, merchantId, objectId)

    local itemIndex = Shopkeeper.GetItemIndexById(merchantId, objectId)
    if( itemIndex == nil ) then
        return
    end
    
    local itemList = Shopkeeper[merchantId].Items    
    
    if( itemIndex ~= nil and merchantId ~= nil ) then
        local item = WindowData.ObjectInfo[objectId]
        local itemData = itemList[itemIndex]

	    itemData.value = item.shopValue
	    itemData.objType = item.objectType
	    
        if( WindowData.ItemProperties[objectId] ~= nil ) then
            local itemProps = WindowData.ItemProperties[objectId].PropertiesList	    
	        if( itemProps[1] ~= nil ) then
	            itemData.name = Shopkeeper.stripFirstNumber(itemProps[1])
	            --Debug.Print("Name: "..tostring(Shopkeeper.stripFirstNumber(itemProps[1]))..", Value: "..tostring(item.shopValue))
	        else
	            itemData.name = L""
	        end
	    end
	    
	    --Debug.Print("Updated Object: "..tostring(itemIndex)..", "..tostring(itemData.id))
        
        -- calculate the new left, right and total quantities
        if( itemData.totalQuantity == nil ) then
	        itemData.leftQuantity = item.shopQuantity
	        itemData.rightQuantity = 0 	        
	    else
	        if( itemData.rightQuantity > item.shopQuantity ) then
	            itemData.rightQuantity = item.shopQuantity
	            itemData.leftQuantity = 0
	        else
	            itemData.leftQuantity = item.shopQuantity - itemData.rightQuantity
	        end
	    end
	    itemData.totalQuantity = item.shopQuantity
    end
    
    Shopkeeper[merchantId].IsDirty = true
end

function Shopkeeper.UpdateItemIcon(merchantId,elementIcon,itemData)
    if( Shopkeeper[merchantId].IsSelling ) then
	    local name, x, y, scale, newWidth, newHeight = RequestTileArt(itemData.objType,30,30)
	    DynamicImageSetTextureDimensions(elementIcon, newWidth, newHeight)
	    WindowSetDimensions(elementIcon, newWidth, newHeight)
	    DynamicImageSetTexture(elementIcon, name, x, y )
	    DynamicImageSetTextureScale(elementIcon, scale)		        
    else
        if( WindowData.ObjectInfo[itemData.id] ~= nil ) then
            local iconData = WindowData.ObjectInfo[itemData.id]
            EquipmentData.UpdateItemIcon(elementIcon, iconData)
        end
    end
end

function Shopkeeper.RefreshLists(window,merchantId)
    --Debug.Print("Shopkeeper.RefreshLists")
    Shopkeeper[merchantId].IsDirty = false

	local shopData = Shopkeeper[merchantId]
    if( shopData ~= nil ) then
        -- first destroy all the old windows
        if( shopData.LeftWindows ~= nil ) then
            for index, data in ipairs(shopData.LeftWindows) do
				DestroyWindow(data.name)
            end
        end
        shopData.LeftWindows = {}
        if( shopData.RightWindows ~= nil ) then
            for index, data in ipairs(shopData.RightWindows) do
                DestroyWindow(data.name)
            end        
        end        
        shopData.RightWindows = {}
        
        Shopkeeper[merchantId].TotalPurchaseCost = 0
        
        if( shopData.Items ~= nil ) then
            local leftIndex = 1
            local rightIndex = 1
            for index, data in ipairs(shopData.Items) do
                if( data.leftQuantity > 0 and data.value > 0 ) then
                    local itemWindowName = window.."LeftItem"..leftIndex
                    CreateWindowFromTemplate( itemWindowName, "ShopItemTemplate", "ShopItemsScrollWindowScrollChild" )
                    WindowClearAnchors(itemWindowName)
                    if (leftIndex == 1)  then
                        WindowAddAnchor( itemWindowName, "topleft", "ShopItemsScrollWindowScrollChild", "topleft", 5, 5)
                    else
                        local prevWindowName = window.."LeftItem"..(leftIndex-1)
                        WindowAddAnchor( itemWindowName, "bottomleft", prevWindowName, "topleft", 0, 5)                               
                    end
                    
                    ButtonSetText(itemWindowName.."BuyMore",L"+")
                    ButtonSetText(itemWindowName.."BuyLess",L"-")
                    ButtonSetText(itemWindowName.."BuyAll",GetStringFromTid(Shopkeeper.TID.All))
                    
                    if( data.name ~= nil ) then
                        LabelSetText(itemWindowName.."Name",data.name)
                    end
                    LabelSetText(itemWindowName.."Cost",L""..data.value)                        
                    LabelSetText(itemWindowName.."Quantity", L""..data.leftQuantity )

                    local elementIcon = itemWindowName.."IconHolderSquareIcon"
                    Shopkeeper.UpdateItemIcon(merchantId, elementIcon,data)      
                         
                    shopData.LeftWindows[leftIndex] = {name=itemWindowName,itemIndex=index}
                    WindowSetId(itemWindowName,index)
                    WindowSetId(itemWindowName.."BuyMore",Shopkeeper.LEFT_SIDE_ID)
                    WindowSetId(itemWindowName.."BuyLess",Shopkeeper.LEFT_SIDE_ID)
                    WindowSetId(itemWindowName.."BuyAll",Shopkeeper.LEFT_SIDE_ID)                    
                    
                    leftIndex = leftIndex + 1
                end
                if( data.rightQuantity > 0 and data.value > 0) then
                    local itemWindowName = window.."RightItem"..rightIndex
                    CreateWindowFromTemplate( itemWindowName, "ShopItemTemplate", "PurchasedItemsScrollWindowScrollChild" )        
                        
                    WindowClearAnchors(itemWindowName)
                    if (rightIndex == 1) then
                        WindowAddAnchor( itemWindowName, "topleft", "PurchasedItemsScrollWindowScrollChild", "topleft", 5, 5)        
                    else
                        local prevWindowName = window.."RightItem"..(rightIndex-1)
                        WindowAddAnchor( itemWindowName, "bottomleft", prevWindowName, "topleft", 0, 5)                               
                    end           

                    ButtonSetText(itemWindowName.."BuyMore",L"+")
                    ButtonSetText(itemWindowName.."BuyLess",L"-")
                    ButtonSetText(itemWindowName.."BuyAll",GetStringFromTid(Shopkeeper.TID.Clear))
                    
                    if( data.name ~= nil ) then
                        LabelSetText(itemWindowName.."Name",data.name)
                    end
                    LabelSetText(itemWindowName.."Cost",L""..data.value)    
                    LabelSetText(itemWindowName.."Quantity",L""..data.rightQuantity)
                    
                    local elementIcon = itemWindowName.."IconHolderSquareIcon"
                    Shopkeeper.UpdateItemIcon(merchantId,elementIcon,data)      
                                        
                    shopData.RightWindows[rightIndex] = {name=itemWindowName,itemIndex=index}
                    WindowSetId(itemWindowName,index)
                    WindowSetId(itemWindowName.."BuyMore",Shopkeeper.RIGHT_SIDE_ID)
                    WindowSetId(itemWindowName.."BuyLess",Shopkeeper.RIGHT_SIDE_ID)
                    WindowSetId(itemWindowName.."BuyAll",Shopkeeper.RIGHT_SIDE_ID)                    
                    
                    Shopkeeper[merchantId].TotalPurchaseCost = Shopkeeper[merchantId].TotalPurchaseCost + (data.rightQuantity*data.value)
                    
                    rightIndex = rightIndex + 1                      
                end          
            end
            
            ScrollWindowUpdateScrollRect("PurchasedItemsScrollWindow")
            ScrollWindowUpdateScrollRect("ShopItemsScrollWindow")
            
            Shopkeeper.UpdatePlayersGold(merchantId)
        end
        
        Shopkeeper[merchantId].RefreshTimer = 0
    end
end

function Shopkeeper.ItemMouseOver()
	local itemWindow = SystemData.ActiveWindow.name
	local itemWindowParent = WindowGetParent(itemWindow)
	local itemLocalId = WindowGetId(itemWindowParent)

	local merchantWindow = WindowUtils.GetActiveDialog()
	local merchantId = WindowGetId(merchantWindow)
	
	if( Shopkeeper[merchantId] ~= nil and Shopkeeper[merchantId].Items ~= nil ) then
	    local itemId = Shopkeeper[merchantId].Items[itemLocalId].id
		
		if itemId then
			local itemData = { windowName = itemWindowParent,
							   itemId = itemId,
							   itemType = WindowData.ItemProperties.TYPE_ITEM,
							   detail = ItemProperties.DETAIL_LONG }
			ItemProperties.SetActiveItem(itemData)
		end
	end
end

function Shopkeeper.OnBuyOne()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)
    local itemIndex = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    Shopkeeper.UpdateItemRightQuantity(this, merchantId, itemIndex, 1)
end

function Shopkeeper.OnBuyMore()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)
    local itemIndex = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    Shopkeeper.UpdateItemRightQuantity(this, merchantId, itemIndex, 1)
    
    Shopkeeper[merchantId].IsQuantityUpdating = true
    Shopkeeper[merchantId].QuantityUpdate.Amount = 1
    Shopkeeper[merchantId].QuantityUpdate.Timer = 0
    Shopkeeper[merchantId].QuantityUpdate.ItemIndex = itemIndex
end

function Shopkeeper.OnBuyLess()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)
    local itemIndex = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    Shopkeeper.UpdateItemRightQuantity(this, merchantId, itemIndex, -1)

    Shopkeeper[merchantId].IsQuantityUpdating = true
    Shopkeeper[merchantId].QuantityUpdate.Amount = -1
    Shopkeeper[merchantId].QuantityUpdate.Timer = 0
    Shopkeeper[merchantId].QuantityUpdate.ItemIndex = itemIndex
end

function Shopkeeper.OnStopUpdating()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)

    Shopkeeper[merchantId].IsQuantityUpdating = false
end

function Shopkeeper.OnBuyAll()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)
    local itemIndex = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
    local windowSide = WindowGetId(SystemData.ActiveWindow.name)
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    
    if( Shopkeeper[merchantId] ~= nil and
            Shopkeeper[merchantId].Items ~= nil and
            Shopkeeper[merchantId].Items[itemIndex] ~= nil ) then
        local itemData = Shopkeeper[merchantId].Items[itemIndex]
        if( itemData.leftQuantity ~= nil and
                itemData.rightQuantity ~= nil ) then
            if( windowSide == Shopkeeper.LEFT_SIDE_ID ) then
                itemData.leftQuantity = 0
                itemData.rightQuantity = itemData.totalQuantity
            else
                itemData.leftQuantity = itemData.totalQuantity  
                itemData.rightQuantity = 0        
            end
            Shopkeeper.RefreshLists(this, merchantId)
        end
    end    
end

function Shopkeeper.UpdateItemRightQuantity(this, merchantId, itemIndex, amount)
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    if( Shopkeeper[merchantId] ~= nil and
            Shopkeeper[merchantId].Items ~= nil and
            Shopkeeper[merchantId].Items[itemIndex] ~= nil ) then
        local itemData = Shopkeeper[merchantId].Items[itemIndex]
        if( itemData.leftQuantity ~= nil and
                itemData.rightQuantity ~= nil and
                (itemData.leftQuantity - amount >= 0) and
                (itemData.rightQuantity + amount >= 0) ) then
            itemData.leftQuantity = itemData.leftQuantity - amount
            itemData.rightQuantity = itemData.rightQuantity + amount
            Shopkeeper.RefreshLists(this, merchantId)
        end
    end
end

function Shopkeeper.Shutdown()	
	local this = SystemData.ActiveWindow.name
	local merchantId = WindowGetId(this)

    if( Shopkeeper[merchantId] ~= nil ) then
	    UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
    	
	    if( Shopkeeper[merchantId].IsSelling == false ) then
	        UnregisterWindowData(WindowData.ObjectInfo.Type, merchantId)
	        UnregisterWindowData(WindowData.ContainerWindow.Type, Shopkeeper[merchantId].sellContainerId)
    	    
	        if( Shopkeeper[merchantId].Items ~= nil ) then
	            for index, data in ipairs(Shopkeeper[merchantId].Items) do
	                if( data.registered == true ) then
	                	UnregisterWindowData(WindowData.ObjectInfo.Type, data.id)
	                    UnregisterWindowData(WindowData.ItemProperties.Type, data.id)
	                    data.registered = false
	                end
	            end
	            
	            Shopkeeper[merchantId].Items = nil
	        end
	    end
        
	    if( Shopkeeper[merchantId].OfferAccepted == false ) then
		    BroadcastEvent(SystemData.Events.SHOP_CANCEL_OFFER)
	    end
	    
	    Shopkeeper[merchantId] = nil
	end
	
	if( ItemProperties.GetCurrentWindow() == this ) then
		ItemProperties.ClearMouseOverItem()
	end		
end
	
function Shopkeeper.UpdatePlayersGold(merchantId)
    if( Shopkeeper[merchantId] ~= nil ) then
	    Shopkeeper[merchantId].PlayerGold = WindowData.PlayerStatus.Gold
	    LabelSetText ("TotalCostVal", L""..Shopkeeper[merchantId].TotalPurchaseCost..L"/"..Shopkeeper[merchantId].PlayerGold)
	end
end

function Shopkeeper.PurchaseItems()
	local this = WindowUtils.GetActiveDialog()
	local merchantId = WindowGetId(this)
	
	if( Shopkeeper[merchantId] ~= nil and
	        Shopkeeper[merchantId].Items ~= nil ) then
	    local itemList = Shopkeeper[merchantId].Items
	    local sellIndex = 1
	    for itemIndex, data in ipairs(itemList) do
	        if( data.rightQuantity > 0 ) then
	            --Debug.Print("Buying: "..tostring(data.id)..", "..tostring(data.value))
		        WindowData.ShopData.OfferIds[sellIndex] = data.id
		        WindowData.ShopData.OfferQuantities[sellIndex] = data.rightQuantity
		        sellIndex = sellIndex + 1
		    end
		end

		Shopkeeper[merchantId].OfferAccepted = true
	    BroadcastEvent(SystemData.Events.SHOP_OFFER_ACCEPT)
	end
	   
	DestroyWindow(this) 
end

function Shopkeeper.CancelPurchase()
	local this = WindowUtils.GetActiveDialog()
	local merchantId = WindowGetId(this)
	
	if( Shopkeeper[merchantId] ~= nil and
	        Shopkeeper[merchantId].Items ~= nil ) then
	    local itemList = Shopkeeper[merchantId].Items
	    for itemIndex, data in ipairs(itemList) do
			data.leftQuantity = data.totalQuantity
	        data.rightQuantity = 0
	    end
    
        Shopkeeper[merchantId].IsDirty = true
    end	    
end