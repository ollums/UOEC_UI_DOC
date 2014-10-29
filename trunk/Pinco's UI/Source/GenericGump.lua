----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

GenericGump = {}

GenericGump.Gumps = {}
GenericGump.GGumps = {}
GenericGump.GGumpsLabel = {}
GenericGump.GGumpsButtons = {}

GenericGump.delta = 0

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
 
----------------------------------------------------------------
-- GenericGump Functions
----------------------------------------------------------------
function GenericGump.Initialize()
    local windowName = SystemData.ActiveWindow.name
	--EnhancePack.LoadScale( windowName )
	--Debug.Print(WindowGetScale(windowName))
	GenericGump.Gumps[windowName] = true
	--WindowSetScale (windowName,1.5)
	Interface.DestroyWindowOnClose[windowName] = true
	WindowSetShowing(windowName, false)
	if (EnhancePack.WaitQuest == true) then
		EnhancePack.WaitQuest = windowName
	end
	if (EnhancePack.WaitVirt == true) then
		EnhancePack.WaitVirt = windowName
	end
	if (EnhancePack.WaitGuild == true) then
		EnhancePack.WaitGuild = windowName
	end
end

function GenericGump.ButtonInit()
	local win = string.gsub(SystemData.ActiveWindow.name, "GenericGumpItem", "")
	win = tonumber(win)
	GenericGump.GGumpsButtons[win] = true
end

function GenericGump.Shutdown()
	local windowName = SystemData.ActiveWindow.name
	GenericGump.GGumps[windowName] = nil
	EnhancePack.SecurityGumpID = 0
end


function GenericGump.Test()
	 local windowName = SystemData.ActiveWindow.name
	 if (not EnhancePack.VetRewClosed) then
		if (EnhancePack.TimeSinceLogin < 20 and (EnhancePack.AutoCloseVetRew)) then
			if LabelGetText(windowName) then
				GenericGump.GGumpsLabel[windowName] = true
			end
		end
	end
end

function GenericGump.Test2()
	local windowName = SystemData.ActiveWindow.name
	if LabelGetText(windowName) then
		GenericGump.GGumpsLabel[windowName] = true
	end
end

function GenericGump.OnClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name
    GenericGumpOnClicked(gumpId, windowName)
    EnhancePack.WaitQuest = false
    EnhancePack.WaitGuild = false
    --Debug.Print("CLICK: " .. SystemData.ActiveWindow.name)
    
end

function GenericGump.OnDoubleClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name

    GenericGumpOnDoubleClicked(gumpId, windowName)
end

function GenericGump.OnRClicked()
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    
    GenericGumpOnRClicked(gumpId)   
    EnhancePack.WaitVirt = false 
    EnhancePack.WaitGuild = false
end

function BRlines(str)
  local t = {}
  local function helper(line) table.insert(t, line) return "" end
  helper((str:gsub("(.-)<br><br>", helper)))
  return t
end

function GenericGump.GetReforgingDesc(index)
	--Powerful Re-Forging causes the item to have slightly more magical power.<br><br>Structural Re-Forging causes the item to have more magical power, but the item will be Brittle.<br><br>Fortified Re-Forging causes the item to have higher durability.<br><br>Fundamental Re-Forging causes the item to have significantly more magical power, but the item cannot be repaired. Its durability will be increased.<br><br>Integral Re-Forging further increases the item's durability.<br><br>Grand Artifice guarantees that the resulting item will have one name, either a prefix or a suffix.<br><br>Inspired Artifice allows you to choose which name will be added to the item.<br><br>Exalted Artifice guarantees that the item will have two names, both a prefix and a suffix.<br><br>Sublime Artifice allows you to choose a name to be added to the item.<br><br>You must use both Inspired Artifice and Sublime Artifice in conjunction if you wish to choose both names to add to the item.
	local desc = BRlines(WStringToString(GetStringFromTid(1151965)))
	--Debug.Print(table.getn(desc))
	return StringToWString(desc[index])
end

GenericGump.ToolTips = {
[GetStringFromTid(1151954)] = GenericGump.GetReforgingDesc(1); --Powerful Re-Forging
[GetStringFromTid(1151955)] = GenericGump.GetReforgingDesc(2); --Structural Re-Forging
[GetStringFromTid(1151956)] = GenericGump.GetReforgingDesc(3); --Fortified Re-Forging
[GetStringFromTid(1151957)] = GenericGump.GetReforgingDesc(4); --Fundamental Re-Forging
[GetStringFromTid(1151958)] = GenericGump.GetReforgingDesc(5); --Integral Re-Forging
[GetStringFromTid(1151961)] = GenericGump.GetReforgingDesc(6); --Grand Artifice
[GetStringFromTid(1151962)] = GenericGump.GetReforgingDesc(7); --Inspired Artifice
[GetStringFromTid(1151963)] = GenericGump.GetReforgingDesc(8); --Exalted Artifice
[GetStringFromTid(1151964)] = GenericGump.GetReforgingDesc(9); --Sublime Artifice
[GetStringFromTid(1151717)] = UI.GetCliloc(SystemData.Settings.Language.type, 952); --Mighty / of Vitality
[GetStringFromTid(1151706)] = UI.GetCliloc(SystemData.Settings.Language.type, 953); --Mystic / of Sorcery
[GetStringFromTid(1151707)] = UI.GetCliloc(SystemData.Settings.Language.type, 954); --Animated / of Haste
[GetStringFromTid(1151708)] = UI.GetCliloc(SystemData.Settings.Language.type, 955); --Arcane / of Wizardry
[GetStringFromTid(1151709)] = UI.GetCliloc(SystemData.Settings.Language.type, 956); --Exquisite / of Quality
[GetStringFromTid(1151710)] = UI.GetCliloc(SystemData.Settings.Language.type, 957); --Vampiric / of the Vampire
[GetStringFromTid(1151711)] = UI.GetCliloc(SystemData.Settings.Language.type, 958); --Invigorating / of Restoration
[GetStringFromTid(1151712)] = UI.GetCliloc(SystemData.Settings.Language.type, 959); --Fortified / of Defense
[GetStringFromTid(1151713)] = UI.GetCliloc(SystemData.Settings.Language.type, 960); --Auspicious / of Fortune
[GetStringFromTid(1151714)] = UI.GetCliloc(SystemData.Settings.Language.type, 961); --Charmed / of Alchemy
[GetStringFromTid(1151715)] = UI.GetCliloc(SystemData.Settings.Language.type, 962); --Vicious / of Slaughter
[GetStringFromTid(1151716)] = UI.GetCliloc(SystemData.Settings.Language.type, 963); --Towering / of Aegis
}

GenericGump.OverProps = nil
GenericGump.OverPropsWin = nil
GenericGump.OverPropsDesc = nil
GenericGump.BodColor = nil
	
function GenericGump.OnMouseOverEnd()
	GenericGump.OverPropsDesc = nil
	GenericGump.OverPropsWin = nil
	GenericGump.BodColor = nil
	GenericGump.OverPropsDesc = nil
end

function GenericGump.OnMouseOver()
	--Debug.Print(SystemData.ActiveWindow.name .. " PARENT ".. WindowGetParent(SystemData.ActiveWindow.name) )
	
	local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    local windowName = SystemData.ActiveWindow.name
    local dialog = WindowUtils.GetActiveDialog()
    tooltipText = GenericGumpGetToolTipText(gumpId, windowName)
    
if EnhancePack.DEBUGMODE then
	Debug.Print(windowName)
end
	local ok, txt = pcall(LabelGetText, windowName)
	if ok and txt then
		if GenericGump.ToolTips[txt] then
			tooltipText = GenericGump.ToolTips[txt]
		end
	end	
	
    
    if( tooltipText ~= nil and tooltipText ~= L"" ) then
		Tooltips.CreateTextOnlyTooltip(windowName, tooltipText)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
		return
	end

		

    
    
	objectId = GenericGumpGetItemPropertiesId(gumpId, windowName)
    
    
    if( objectId ~= nil and objectId ~= 0 ) then
		    local itemData = { windowName = dialog,
						       itemId = objectId,
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
		    			       detail = ItemProperties.DETAIL_LONG }
		    ItemProperties.SetActiveItem(itemData)      
	
    end
    
    GenericGump.OverProps = nil
	GenericGump.OverPropsWin = nil
	GenericGump.OverPropsDesc = nil

    if txt and txt == GetStringFromTid(1062224) or txt == GetStringFromTid(1062225) then -- small/large
		if EnhancePack.BodBook then
			
			local lastKey = string.gsub(windowName, "GenericGumpItem", "")
			lastKey = tonumber(lastKey)
		
			
			local tab = {}
			table.insert(tab, FormatProperly(GetStringFromTid(1045151))) -- a bulk order deed
			table.insert(tab, FormatProperly(GetStringFromTid(1038021))) -- blessed
			table.insert(tab, FormatProperly(ReplaceTokens(GetStringFromTid(1072225), {L"1"}))) -- weight: 1 stones
			if EnhancePack.BodBook[lastKey].type == GetStringFromTid(1062224) then
				table.insert(tab, FormatProperly(GetStringFromTid(1060654))) -- small bulk order
			else
				table.insert(tab, FormatProperly(GetStringFromTid(1060655))) -- large bulk order
			end

			if EnhancePack.BodBook[lastKey].material == GetStringFromTid(1062226) then -- Iron
				table.insert(tab, FormatProperly(GetStringFromTid(1027152)))  -- L"iron ingots"
			elseif EnhancePack.BodBook[lastKey].material == GetStringFromTid(1018332) then -- : Dull Copper
				table.insert(tab, FormatProperly(GetStringFromTid(1045142))) -- All items must be made with dull copper ingots.
			elseif EnhancePack.BodBook[lastKey].material == GetStringFromTid(1018333) then -- : Shadow Iron
				table.insert(tab, FormatProperly(GetStringFromTid(1045143)))  -- All items must be made with shadow iron ingots.
			elseif EnhancePack.BodBook[lastKey].material == GetStringFromTid(1018334) then -- : Copper
				table.insert(tab, FormatProperly(GetStringFromTid(1045144))) -- All items must be made with copper ingots.
			elseif EnhancePack.BodBook[lastKey].material == GetStringFromTid(1018335) then -- : Bronze
				table.insert(tab, FormatProperly(GetStringFromTid(1045145))) -- All items must be made with bronze ingots.
			elseif EnhancePack.BodBook[lastKey].material == GetStringFromTid(1018336) then -- : Golden
				table.insert(tab, FormatProperly(GetStringFromTid(1045146))) -- All items must be made with gold ingots.
			elseif EnhancePack.BodBook[lastKey].material == GetStringFromTid(1018337) then -- : Agapite
				table.insert(tab, FormatProperly(GetStringFromTid(1045147))) -- All items must be made with agapite ingots.
			elseif EnhancePack.BodBook[lastKey].material == GetStringFromTid(1018338) then -- : Verite
				table.insert(tab, FormatProperly(GetStringFromTid(1045148))) -- All items must be made with verite ingots.
			elseif EnhancePack.BodBook[lastKey].material == GetStringFromTid(1018339) then -- : Valorite
				table.insert(tab, FormatProperly(GetStringFromTid(1045149))) -- All items must be made with valorite ingots.
			else
				table.insert(tab, EnhancePack.BodBook[lastKey].material) 
			end
					
			table.insert(tab, FormatProperly(EnhancePack.BodBook[lastKey].exceptional) 	)

			table.insert(tab, GetStringFromTid(1045138) .. L" " .. EnhancePack.BodBook[lastKey].amount)

			for i=1, #EnhancePack.BodBook[lastKey].parts do
				table.insert(tab, FormatProperly(EnhancePack.BodBook[lastKey].parts[i] .. L": 0"))
			end

			GenericGump.OverProps = tab
			GenericGump.OverPropsDesc = nil
			local itemData = { windowName = dialog,
						       itemId = 1234,
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
		    			       detail = ItemProperties.DETAIL_LONG }
		    ItemProperties.SetActiveItem(itemData)  
		    
		    GenericGump.OverPropsWin = windowName
		end
    end
    
end

GenericGump.Imgs = {}
function GenericGump.CheckImg()
	local windowName = SystemData.ActiveWindow.name
	GenericGump.Imgs[windowName] = true
end

function GenericGump.TBOnMouseOver()
	TextEditBoxSetTextColor (SystemData.ActiveWindow.name, 0, 0, 0)
end

function GenericGump.OnHyperLinkClicked(link)
    OpenWebBrowser(WStringToString(link))
end