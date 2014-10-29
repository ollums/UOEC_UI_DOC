----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

GenericGump = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
 
----------------------------------------------------------------
-- GenericGump Functions
----------------------------------------------------------------

function GenericGump.OnClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name
    
    GenericGumpOnClicked(gumpId, windowName)
end

function GenericGump.OnDoubleClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name
    
    GenericGumpOnDoubleClicked(gumpId, windowName)
end

function GenericGump.OnRClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    
    GenericGumpOnRClicked(gumpId)    
end

function GenericGump.OnMouseOver()
	local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name
    local dialog = WindowUtils.GetActiveDialog()
    
    tooltipText = GenericGumpGetToolTipText(gumpId, windowName)
    
    if( tooltipText ~= nil and tooltipText ~= L"" ) then
		Tooltips.CreateTextOnlyTooltip(windowName, tooltipText)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	else
		--Debug.Print(L"Tooltip data was nil")
    end
    
    
	objectId = GenericGumpGetItemPropertiesId(gumpId, windowName)
    
    
    if( objectId ~= nil and objectId ~= 0 ) then
		    local itemData = { windowName = dialog,
						       itemId = objectId,
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
		    			       detail = ItemProperties.DETAIL_LONG }
		    ItemProperties.SetActiveItem(itemData)      
	
    end
    
end

function GenericGump.OnHyperLinkClicked(link)
    OpenWebBrowser(WStringToString(link))
end