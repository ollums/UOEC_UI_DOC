----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ItemProperties = {}

ItemProperties.DETAIL_SHORT = 1
ItemProperties.DETAIL_LONG = 2

ItemProperties.MAX_Imbuing_Mods = 5
ItemProperties.RelicIntensity = 451
ItemProperties.EssenceIntensity = 200

ItemProperties.ExtraProps = {}

ItemProperties.PDollItemData = {}

ItemProperties.CurrentItemData = {}

ItemProperties.TITLE_COLOR = { r=243, g=227, b=49 }
ItemProperties.BODY_COLOR = { r=255, g=255, b=255 }

ItemProperties.VirtueData = {}
ItemProperties.VirtueData[1]	= { iconId = 701, nameTid = 1051005, detailTid=1052058 } -- Honor
ItemProperties.VirtueData[2]	= { iconId = 706, nameTid = 1051001, detailTid=1052053 } -- Sacrifice
ItemProperties.VirtueData[3]	= { iconId = 700, nameTid = 1051004, detailTid=1052057 } -- Valor
ItemProperties.VirtueData[4]	= { iconId = 702, nameTid = 1051002, detailTid=1053000 } -- Compassion
ItemProperties.VirtueData[5]	= { iconId = 704, nameTid = 1051007, detailTid=1052060 } -- Honesty
ItemProperties.VirtueData[6]	= { iconId = 707, nameTid = 1051000, detailTid=1052051 } -- Humility
ItemProperties.VirtueData[7]	= { iconId = 703, nameTid = 1051006, detailTid=1052059 } -- Justice
ItemProperties.VirtueData[8]	= { iconId = 705, nameTid = 1051003, detailTid=1052056 } -- Spirituality

ItemProperties.RedMods = {
[wstring.lower(GetStringFromTid(1116209))] = true, -- Brittle
[wstring.lower(GetStringFromTid(1151782))] = true, -- "Cannot Be Repaired"
[wstring.lower(ReplaceTokens(GetStringFromTid(1060436), {L"-100"} ))] = true, -- luck -100
[wstring.lower(GetStringFromTid(1049643))] = true, -- "Cursed"
}

ItemProperties.BlueMods = {
[wstring.lower(GetStringFromTid(1061682))] = true, -- Insured
[wstring.lower(GetStringFromTid(1038021))] = true, -- "blessed"
}

ItemProperties.OldSlayerConversion = {
[wstring.lower(GetStringFromTid(1017384))] = GetStringFromTid(1060479), --Silver
[wstring.lower(GetStringFromTid(1017385))] = GetStringFromTid(1060470), --Orc Slaying
[wstring.lower(GetStringFromTid(1017386))] = GetStringFromTid(1060480), --Troll Slaughter
[wstring.lower(GetStringFromTid(1017387))] = GetStringFromTid(1060468), --Ogre Thrashing
[wstring.lower(GetStringFromTid(1017388))] = GetStringFromTid(1060472), --Repond
[wstring.lower(GetStringFromTid(1017389))] = GetStringFromTid(1060462), --Dragon Slaying
[wstring.lower(GetStringFromTid(1017390))] = GetStringFromTid(1060478), --Terathan
[wstring.lower(GetStringFromTid(1017391))] = GetStringFromTid(1060475), --Snake's Bane
[wstring.lower(GetStringFromTid(1017392))] = GetStringFromTid(1060467), --Lizardman Slaughter
[wstring.lower(GetStringFromTid(1017393))] = GetStringFromTid(1060473), --Reptilian Death
[wstring.lower(GetStringFromTid(1017395))] = GetStringFromTid(1060466), --Gargoyle's Foe
[wstring.lower(GetStringFromTid(1017397))] = GetStringFromTid(1060460), --Exorcism
[wstring.lower(GetStringFromTid(1017398))] = GetStringFromTid(1060469), --Ophidian
[wstring.lower(GetStringFromTid(1017399))] = GetStringFromTid(1060477), --Spider's Death
[wstring.lower(GetStringFromTid(1017400))] = GetStringFromTid(1060474), --Scorpion's Bane
[wstring.lower(GetStringFromTid(1017401))] = GetStringFromTid(1060458), --Arachnid Doom
[wstring.lower(GetStringFromTid(1017402))] = GetStringFromTid(1060465), --Flame Dousing
[wstring.lower(GetStringFromTid(1017403))] = GetStringFromTid(1060481), --Water Dissipation
[wstring.lower(GetStringFromTid(1017404))] = GetStringFromTid(1060457), --Vacuum
[wstring.lower(GetStringFromTid(1017405))] = GetStringFromTid(1060471), --Elemental Health
[wstring.lower(GetStringFromTid(1017406))] = GetStringFromTid(1060463), --Earth Shatter
[wstring.lower(GetStringFromTid(1017407))] = GetStringFromTid(1060459), --Blood Drinking
[wstring.lower(GetStringFromTid(1017408))] = GetStringFromTid(1060476), --Summer Wind
[wstring.lower(GetStringFromTid(1017409))] = GetStringFromTid(1060464), --Elemental Ban
}

ItemProperties.Delta = 0

---------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function ItemProperties.Initialize()
	WindowSetAlpha("ItemPropertiesWindowBackground", 0.8)
	
	WindowData.ItemProperties.numLabels = 0
	
	RegisterWindowData(WindowData.ItemProperties.Type, 0)
	WindowRegisterEventHandler( "ItemProperties", SystemData.Events.UPDATE_ITEM_PROPERTIES, "ItemProperties.UpdateItemPropertiesData")
	
	UOBuildTableFromCSV("Data/GameData/itemprop.csv", "PlayerItemPropCSV")
	
	UOBuildTableFromCSV("Data/GameData/weaponability.csv", "WeaponAbilityDataCSV")
		
end

function ItemProperties.Shutdown()
	UnregisterWindowData(WindowData.ItemProperties.Type, 0)
	UOUnloadCSVTable("PlayerItemPropCSV")
end

function ItemProperties.TryGetProps()
	local properties = WindowData.ItemProperties[0].PropertiesList
	if GenericGump.OverProps then
		properties = GenericGump.OverProps
	end

	local props = {}
	local colorList = WindowData.ItemProperties[0].ColorList
	if colorList then
		for i = 1, #properties do
			local value = towstring( WindowUtils.translateMarkup(properties[i]) )
			table.insert( props, value )
			local colorIdx = (i * 4) - 3
			value = { r=colorList[colorIdx+1], g=colorList[colorIdx+2], b=colorList[colorIdx+3]}
			table.insert( colorList, value )
		end	
	else
		colorList = {}
		for i = 1, #properties do
			local value = towstring( WindowUtils.translateMarkup(properties[i]) )
			table.insert( props, value )
			value = { r=255, g=255, b=255}
			table.insert( colorList, value )
		end	
	end
	GenericGump.OverProps = nil
	return props, colorList
end

function ItemProperties.UpdateItemPropertiesData()
	if (WindowData.ItemProperties.CurrentType == 0) then
		return
	end
	if (ItemProperties.Delta < 1 and EnhancePack.ItmPrpShowing and WindowGetShowing("ItemProperties")) then
		return
	end
	
	
	ItemProperties.Delta = 0
	EnhancePack.ItmPrpShowing = nil
	if EnhancePack.DisableProps then
		return
	end
	
	
	local this = WindowUtils.GetActiveDialog()
	
	local call
	local props
	local colors
	ItemProperties.CurrentItemData.itemType = WindowData.ItemProperties.CurrentType
	EnhancePack.CurrentOnIsMobile = false
	
	if (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM) then
		local ok
		
		ok, props, colors = pcall(ItemProperties.TryGetProps)
		if not ok then
			return
		end
		

		call = ItemProperties.ItemParsing
	elseif( ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ACTION ) then
		call = ItemProperties.ActionParsing
	elseif( ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_WSTRINGDATA ) then

		call = ItemProperties.WStringParsing
	end
	
	
	if (call) then
		local ok, labelText,labelColors,labelFont = pcall(call, {props, false, colors})
		EnhancePack.ErrorTracker(ok, labelText)
		if (ok) then
			if( ItemProperties.CurrentItemData.binding ~= nil and ItemProperties.CurrentItemData.binding ~= L"" ) then
				table.insert(labelText, ItemProperties.CurrentItemData.binding)
				table.insert(labelColors, EnhancePack.BODY_COLOR)
				table.insert(labelFont, ItemProperties.GetFont("normal"))		
			end

			if( ItemProperties.CurrentItemData.myTarget ~= nil and ItemProperties.CurrentItemData.myTarget ~= L"" ) then
				table.insert(labelText, ItemProperties.CurrentItemData.myTarget)
				table.insert(labelColors, EnhancePack.BODY_COLOR)
				table.insert(labelFont, ItemProperties.GetFont("normal"))			
			end
			if (labelText and #labelText > 0) then
				ItemProperties.PopulateWindow(labelText,labelColors,labelFont)
			end
		end
	end
	if WindowData.ItemProperties.CurrentHover ~= 0 then
		UnregisterWindowData(WindowData.ItemProperties.Type, WindowData.ItemProperties.CurrentHover)
		
	end
end
function ItemProperties.ClearWindow()
	if (DoesWindowNameExist("ItemPropertiesItemLabelspace")) then
		DestroyWindow("ItemPropertiesItemLabelspace")
	end
	
	local j = 1
	local labelname = "ItemPropertiesItemLabel" .. j
	while DoesWindowNameExist(labelname) do
		DestroyWindow(labelname)
		j = j + 1
		labelname = "ItemPropertiesItemLabel" .. j
	end
	
	if DoesWindowNameExist("WeaponProperties") then
		
		DestroyWindow("WeaponProperties")
	end
	if DoesWindowNameExist("ArmorProperties") then
		
		DestroyWindow("ArmorProperties")
	end

	WindowSetDimensions("ItemProperties", 0, 0)
	WindowSetShowing("ItemProperties", false)
end

function ItemProperties.ShowWeaponProps()
	if (DoesWindowNameExist("WeaponProperties")) then
		return
	end
	
	CreateWindowFromTemplate("WeaponProperties", "WeaponPropertiesTemplate", "ItemProperties")
	WindowSetAlpha("WeaponPropertiesWindowBackground", 0.8)
		
	LabelSetTextColor("WeaponPropertiesItemName", EnhancePack.PLAIN_COLOR.r, EnhancePack.PLAIN_COLOR.g, EnhancePack.PLAIN_COLOR.b)

	if (ItemProperties.ExtraProps.intensity and ItemProperties.ExtraProps.intensity > 0 and not ItemProperties.ExtraProps.arti and not ItemProperties.ExtraProps.set) then
		if (ItemProperties.ExtraProps.unravelInto == GetStringFromTid(1031697)) then
			LabelSetTextColor("WeaponPropertiesItemName", EnhancePack.RESIDUE_COLOR.r, EnhancePack.RESIDUE_COLOR.g, EnhancePack.RESIDUE_COLOR.b)
		elseif (ItemProperties.ExtraProps.unravelInto == GetStringFromTid(1031698)) then
			LabelSetTextColor("WeaponPropertiesItemName", EnhancePack.ESSENCE_COLOR.r, EnhancePack.ESSENCE_COLOR.g, EnhancePack.ESSENCE_COLOR.b)
		elseif (ItemProperties.ExtraProps.unravelInto == GetStringFromTid(1031699)) then
			LabelSetTextColor("WeaponPropertiesItemName", EnhancePack.RELIC_COLOR.r, EnhancePack.RELIC_COLOR.g, EnhancePack.RELIC_COLOR.b)
		end
	else
		if (ItemProperties.ExtraProps.arti) then
			LabelSetTextColor("WeaponPropertiesItemName", EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)
		elseif (ItemProperties.ExtraProps.set) then
			LabelSetTextColor("WeaponPropertiesItemName", EnhancePack.SET_COLOR.r, EnhancePack.SET_COLOR.g, EnhancePack.SET_COLOR.b)
		end
	end
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesItemName", "UO_DefaultText_ASIA_24", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)		
	end
	LabelSetText("WeaponPropertiesItemName", FormatProperly(ItemProperties.ExtraProps.itemName) )
	
	if (ItemProperties.ExtraProps.exceptional) then
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("WeaponPropertiesItemExc", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("WeaponPropertiesCraftedBy", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
			
		LabelSetText("WeaponPropertiesItemExc", FormatProperly(GetStringFromTid(1060636))) -- L"Exceptional"
		LabelSetText("WeaponPropertiesCraftedBy", ItemProperties.ExtraProps.craftedBy)
		
	else
		WindowSetShowing("WeaponPropertiesItemExc", false)
		WindowSetShowing("WeaponPropertiesCraftedBy", false)
	end

	if (ItemProperties.ExtraProps.engraveText and ItemProperties.ExtraProps.engraveText ~= L"") then
		LabelSetTextColor("WeaponPropertiesEngrave", EnhancePack.ENGRAVE_COLOR.r, EnhancePack.ENGRAVE_COLOR.g, EnhancePack.ENGRAVE_COLOR.b)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("WeaponPropertiesEngrave", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("WeaponPropertiesEngrave", FormatProperly(ItemProperties.ExtraProps.engraveText))
	else
		WindowSetShowing("WeaponPropertiesEngrave", false)
	end
	
	if ( not WindowGetShowing("WeaponPropertiesItemExc") ) then
		if ( not WindowGetShowing("WeaponPropertiesEngrave") ) then
			WindowSetDimensions("WeaponPropertiesInnerFrame", 450, 70)
						
			WindowClearAnchors("WeaponPropertiesItemName")
			WindowAddAnchor("WeaponPropertiesItemName", "top", "WeaponProperties", "top", 0, 10)
			
			WindowClearAnchors("WeaponPropertiesSpecial1")
			WindowAddAnchor("WeaponPropertiesSpecial1", "topleft", "WeaponProperties", "topleft", 20, 10)
			
			WindowClearAnchors("WeaponPropertiesSpecial2")
			WindowAddAnchor("WeaponPropertiesSpecial2", "topright", "WeaponProperties", "topright", -20, 10)
			
		else
			WindowSetDimensions("WeaponPropertiesInnerFrame", 450, 100)
			
			WindowClearAnchors("WeaponPropertiesItemName")
			WindowAddAnchor("WeaponPropertiesItemName", "top", "WeaponProperties", "top", 0, 15)
	
			
			WindowClearAnchors("WeaponPropertiesEngrave")
			WindowAddAnchor("WeaponPropertiesEngrave", "bottom", "WeaponPropertiesItemName", "top", 0, 5)
			
			WindowClearAnchors("WeaponPropertiesSpecial1")
			WindowAddAnchor("WeaponPropertiesSpecial1", "topleft", "WeaponProperties", "topleft", 20, 20)
			
			WindowClearAnchors("WeaponPropertiesSpecial2")
			WindowAddAnchor("WeaponPropertiesSpecial2", "topright", "WeaponProperties", "topright", -20, 20)
		end
	else
		if ( not WindowGetShowing("WeaponPropertiesEngrave") ) then
			WindowClearAnchors("WeaponPropertiesItemName")
			WindowAddAnchor("WeaponPropertiesItemName", "top", "WeaponProperties", "top", 0, 15)
		end
	end
	
	if ItemProperties.ExtraProps.special1 and ItemProperties.ExtraProps.special1 ~= 0 then
		local abilityId = ItemProperties.ExtraProps.special1
		local icon = GetAbilityData(abilityId)
		local iconTexture, x, y = GetIconData(icon)
		
		DynamicImageSetTexture("WeaponPropertiesSpecial1", iconTexture, x, y)
		WindowSetTintColor("WeaponPropertiesSpecial1",190,190,190)
		
		abilityId = ItemProperties.ExtraProps.special2
		icon = GetAbilityData(abilityId)
		iconTexture, x, y = GetIconData(icon)
		
		DynamicImageSetTexture("WeaponPropertiesSpecial2", iconTexture, x, y)
		WindowSetTintColor("WeaponPropertiesSpecial2",190,190,190)
	end
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesItemType", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	LabelSetText("WeaponPropertiesItemType", FormatProperly(ItemProperties.ExtraProps.itemTypeName))
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesLayer", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	if ItemProperties.ExtraProps.twoHanded then
		LabelSetText("WeaponPropertiesLayer", UI.GetCliloc(SystemData.Settings.Language.type, 5044))
	else
		LabelSetText("WeaponPropertiesLayer", UI.GetCliloc(SystemData.Settings.Language.type, 5043))
	end
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesDPSChange", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	if not ItemPropertiesEvaluator.PaperdollSlotOver and ItemProperties.ExtraProps.DPSChange then	
		local text = wstring.format(L"%.2f", ItemProperties.ExtraProps.DPSChange)
		if ItemProperties.ExtraProps.DPSChange > 0 then
			text = L"+" ..  text
			LabelSetTextColor("WeaponPropertiesDPSChange", 0, 255, 0)
		elseif (ItemProperties.ExtraProps.DPSChange < 0) then
			LabelSetTextColor("WeaponPropertiesDPSChange", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
		else
			LabelSetTextColor("WeaponPropertiesDPSChange", 125, 125, 125)
		end
		LabelSetText("WeaponPropertiesDPSChange", L"(" .. text .. L")")
	end
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesDPS", "UO_DefaultText_ASIA_36", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	LabelSetText("WeaponPropertiesDPS", ItemProperties.ExtraProps.dps)
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesDPSLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	LabelSetText("WeaponPropertiesDPSLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5045) )
	
	LabelSetTextColor("WeaponPropertiesDMGPhys", EnhancePack.PHYSICAL.r, EnhancePack.PHYSICAL.g, EnhancePack.PHYSICAL.b)
	LabelSetText("WeaponPropertiesDMGPhys", towstring(ItemProperties.ExtraProps.physD) .. L"%")
	LabelSetTextColor("WeaponPropertiesDMGFire", EnhancePack.FIRE.r, EnhancePack.FIRE.g, EnhancePack.FIRE.b)
	LabelSetText("WeaponPropertiesDMGFire", towstring(ItemProperties.ExtraProps.fireD) .. L"%")
	LabelSetTextColor("WeaponPropertiesDMGCold", EnhancePack.COLD.r, EnhancePack.COLD.g, EnhancePack.COLD.b)
	LabelSetText("WeaponPropertiesDMGCold", towstring(ItemProperties.ExtraProps.coldD) .. L"%")
	LabelSetTextColor("WeaponPropertiesDMGPois", EnhancePack.POISON.r, EnhancePack.POISON.g, EnhancePack.POISON.b)
	LabelSetText("WeaponPropertiesDMGPois", towstring(ItemProperties.ExtraProps.poisD) .. L"%")
	LabelSetTextColor("WeaponPropertiesDMGEner", EnhancePack.ENERGY.r, EnhancePack.ENERGY.g, EnhancePack.ENERGY.b)
	LabelSetText("WeaponPropertiesDMGEner", towstring(ItemProperties.ExtraProps.enerD) .. L"%")

	LabelSetText("WeaponPropertiesDMGVal", ItemProperties.ExtraProps.damage[1] .. L" - " .. ItemProperties.ExtraProps.damage[2])
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesDMGLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	LabelSetText("WeaponPropertiesDMGLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5046) )
	
	local weaponSpeed = ItemProperties.ExtraProps.speed - ( ItemProperties.ExtraProps.speed * (ItemProperties.ExtraProps.ssi / 100))
	if weaponSpeed < 1.25 then
		weaponSpeed = 1.25
	end
	
	LabelSetText("WeaponPropertiesSPDVal", wstring.format(L"%.2f", weaponSpeed ) .. L"s")
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesSPDLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	LabelSetText("WeaponPropertiesSPDLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5047) )
	
	
	local propsStartH = 14
	local WeaponDataH = 56
	
	if ItemProperties.ExtraProps.ranged then
		LabelSetText("WeaponPropertiesRNGVal", ItemProperties.ExtraProps.range)
		LabelSetText("WeaponPropertiesRNGLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5048) )
	else
		WeaponDataH = WeaponDataH - 17
	end
		
	local ll = ItemProperties.LayerToSlot( ItemProperties.ExtraProps.layer )
	local res = ItemProperties.GetEquippedResistances( ll )
	local frst = false
	if ItemProperties.ExtraProps.layer and not ItemPropertiesEvaluator.PaperdollSlotOver and EnhancePack.ToggleItemComparison then
		for name, value in pairs(res) do
			notfound = false
			local fixName = name

			if (value > 0) then
				if #ItemProperties.ExtraProps.props > 0 then
					for i = 1, #ItemProperties.ExtraProps.props do
						if ItemProperties.ExtraProps.props[i].en and ItemProperties.ExtraProps.props[i].en == fixName then
							notfound = false
							break
						else 
							
							notfound = true
						end
					end
				else 		
					notfound = true
				end
				if not notfound then
					continue
				end
			else
				continue
			end
			
			if notfound then
				if not frst then
					frst = true
					data = {original = UI.GetCliloc(SystemData.Settings.Language.type, 5073), value = -1}
					table.insert(ItemProperties.ExtraProps.props, data)
				end
				value = towstring(0-value)
				local original = L""
				if (fixName == L"damage chance increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060401), {L"(" .. value} )) .. L")"
				elseif (fixName == L"swing speed increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060486), {L"(" .. value} )) .. L")"
					
				elseif (fixName == L"lower reagent cost") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060434), {L"(" .. value} )) .. L")"
				elseif (fixName == L"lower mana cost") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060433), {L"(" .. value} )) .. L")"
					
				elseif (fixName == L"hit chance increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060415), {L"(" .. value} )) .. L")"
				elseif (fixName == L"defense chance increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060408), {L"(" .. value} )) .. L")"
					
				elseif (fixName == L"mana regen") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060440), {L"(" .. value} )) .. L")"
				elseif (fixName == L"hit point regen") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060444), {L"(" .. value} )) .. L")"
					
				elseif (fixName == L"hit point increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060431), {L"(" .. value} )) .. L")"
				elseif (fixName == L"mana increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060439), {L"(" .. value} )) .. L")"
				elseif (fixName == L"stamina increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060484), {L"(" .. value} )) .. L")"
				end
				if original ~= L"" then
					data = {original = original, value = value}
					table.insert(ItemProperties.ExtraProps.props, data)
				end
			end
		end
	end
	
	local PropsH = 15
	
	-- PROPS
	for i = 1, #ItemProperties.ExtraProps.props do
		CreateWindowFromTemplate("prop" .. i, "NewItemPropItemDef", "WeaponProperties")
		local prop = ItemProperties.ExtraProps.props[i]
		if i == 1 then
			WindowAddAnchor("prop" .. i, "bottomleft", "WeaponPropertiesElementsTable", "topleft", 0, propsStartH + WeaponDataH)
		else
			if (prop.original == UI.GetCliloc(SystemData.Settings.Language.type, 5073)) then
				WindowAddAnchor("prop" .. i, "bottomleft", "prop" .. i - 1, "topleft", 0, 10)
				PropsH = PropsH + 10
				WindowSetShowing("prop" .. i .. "Dot", false)
			else
				WindowAddAnchor("prop" .. i, "bottomleft", "prop" .. i - 1, "topleft", 0, 0)
			end
		end
		
		
		
		local change = nil
		if ItemProperties.ExtraProps.props[i].en and res[ItemProperties.ExtraProps.props[i].en] and ItemProperties.ExtraProps.layer and not ItemPropertiesEvaluator.PaperdollSlotOver and EnhancePack.ToggleItemComparison then

			change = ItemProperties.ExtraProps.props[i].value - res[ItemProperties.ExtraProps.props[i].en]
			local capText = FormatProperly(ItemProperties.ExtraProps.props[i].en)
			capText = wstring.gsub(capText, L" ", L"")
			local max = CharacterSheet.Caps[tostring(capText)]
			if max then
				if change + WindowData.PlayerStatus[tostring(capText)] > max then
					change = max - (change + WindowData.PlayerStatus[tostring(capText)])
					if change < 0 then
						change = 0
					end
				end
			end
		end
		
		LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		if EnhancePack.IntensityInfo and ItemProperties.ExtraProps.props[i].intensity and ItemProperties.ExtraProps.props[i].intensity > 50 then 
			LabelSetTextColor("prop" .. i .. "Prop", ItemProperties.ExtraProps.props[i].color.r, ItemProperties.ExtraProps.props[i].color.g, ItemProperties.ExtraProps.props[i].color.b)
		else
			if (wstring.lower(prop.original) == wstring.lower(GetStringFromTid(1151821))) then -- luck -100
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
			elseif (wstring.lower(prop.original) == wstring.lower(GetStringFromTid(1094732))) then -- * Requires the "Stygian Abyss" expansion
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
			elseif (wstring.lower(prop.original) == wstring.lower(GetStringFromTid(1116296))) then -- * Requires the "High Seas" booster
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
			elseif (wstring.lower(prop.original) == wstring.lower(GetStringFromTid(1151520))) then -- lost item (Return to gain Honesty)
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
			elseif (tonumber(prop.value) and tonumber(prop.value) < 0) then
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
			end
			if (prop.original == UI.GetCliloc(SystemData.Settings.Language.type, 5073)) then
				LabelSetTextColor("prop" .. i .. "Prop",  125, 125, 125)
			end
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("prop" .. i .. "Prop", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("prop" .. i .. "Prop", FormatProperly(prop.original))
		
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("prop" .. i .. "Cap", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end

		if (prop.cap and type(prop.cap) == "number" and prop.totWeight and prop.totWeight >= 0 and EnhancePack.ToggleExtraInfo) then
			if ItemProperties.ExtraProps.props[i].min then
				LabelSetText("prop" .. i .. "Cap", UI.GetCliloc(SystemData.Settings.Language.type, 876) .. prop.min .. L" - " .. prop.cap)
			else
				LabelSetText("prop" .. i .. "Cap", UI.GetCliloc(SystemData.Settings.Language.type, 877) .. prop.cap)
			end
		end
		
		if change then
			if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
				LabelSetFont("prop" .. i .. "Change", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end
			if change > 0 then
				
				LabelSetTextColor("prop" .. i .. "Change", 0, 255, 0)
				LabelSetText("prop" .. i .. "Change", L"(+" .. change .. L")")
			elseif change <0 then
				
				LabelSetTextColor("prop" .. i .. "Change", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
				LabelSetText("prop" .. i .. "Change", L"(" .. change .. L")")
			else
				
				LabelSetTextColor("prop" .. i .. "Change", 125, 125, 125)
				LabelSetText("prop" .. i .. "Change", L"(" .. change .. L")")
			end
		end
		local w, h = WindowGetDimensions("prop" .. i)	
		PropsH = PropsH + h
	end
	
	-- set the bottom dockspot position
	
	
	
	local SetsH = 15
	
	local full = false
	-- SET PART
	for i = 1, #ItemProperties.ExtraProps.setData do
		CreateWindowFromTemplate("set" .. i, "NewItemPropItemDef", "WeaponProperties")
		if i == 1 then
			if #ItemProperties.ExtraProps.props > 0 then
				WindowAddAnchor("set" .. i, "bottomleft", "prop" .. #ItemProperties.ExtraProps.props, "topleft", 0, propsStartH)
			else
				if not WindowGetShowing("WeaponPropertiesElementsTable") then
					if (LabelGetText("WeaponPropertiesItemType") == L"") then
						WindowAddAnchor("set" .. i, "bottomleft", "WeaponPropertiesInnerFrame", "topleft", 20, 20)
						itemTypeH = 0
						DPSH = 0
						ElmentsTableH = 0
					else
						WindowAddAnchor("set" .. i, "bottomleft", "WeaponPropertiesItemType", "topleft", 5, 20)
						DPSH = 0
						ElmentsTableH = 0
					end
				else
					WindowAddAnchor("set" .. i, "bottomleft", "WeaponPropertiesElementsTable", "topleft", 0, propsStartH)
				end
			end
		else
			WindowAddAnchor("set" .. i, "bottomleft", "set" .. i - 1, "topleft", 0, 0)
		end
		
		if (i < 3) then
			WindowSetShowing("set" .. i .. "Dot", false)
		end
		
		LabelSetTextColor("set" .. i .. "Prop", EnhancePack.SET_COLOR.r, EnhancePack.SET_COLOR.g, EnhancePack.SET_COLOR.b)
		if (not full) then
			WindowSetFontAlpha( "set" .. i .. "Prop", 0.5 )
		end
		
		local prop = ItemProperties.ExtraProps.setData[i]
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("set" .. i .. "Prop", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		local sp = wstring.gsub(wstring.lower(GetStringFromTid(1072376)), L"~1_val~", L"") -- Part of an Weapon Set (~1_val~ pieces)
		sp = wstring.sub(sp, 1, wstring.find(sp, L"[(]") -1)
		local sp2 = wstring.gsub(wstring.lower(GetStringFromTid(1073491)), L"~1_val~", L"") -- Part of a Weapon/Weapon Set (~1_val~ pieces)
		sp2 = wstring.sub(sp2, 1, wstring.find(sp2, L"[(]") -1)
		local sp3 = wstring.gsub(wstring.lower(GetStringFromTid(1080240)), L"~1_val~", L"") -- Part of a Jewelry Set (~1_val~ pieces)
		sp3 = wstring.sub(sp3, 1, wstring.find(sp3, L"[(]") -1)
		
		if (wstring.find(wstring.lower(prop.original), sp) or wstring.find(wstring.lower(prop.original), sp2) or wstring.find(wstring.lower(prop.original), sp3)) then
			LabelSetTextColor("set" .. i .. "Prop", EnhancePack.SET_COLOR.r, EnhancePack.SET_COLOR.g, EnhancePack.SET_COLOR.b)
			WindowSetFontAlpha( "set" .. i .. "Prop", 1 )
		end
		
		local st = wstring.gsub(wstring.lower(GetStringFromTid(1072378)), L"<br>", L"") -- Only when full set is present:
		if (wstring.find(wstring.lower(prop.original), st)) then
			full = false
			LabelSetTextColor("set" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
			WindowSetFontAlpha( "set" .. i .. "Prop", 1 )
		end
		
		st = wstring.lower(GetStringFromTid(1072377)) -- Full Weapon Set Present
		sp =  wstring.lower(GetStringFromTid(1073492)) -- Full Weapon/Weapon Set Present
		sp2 =  wstring.lower(GetStringFromTid(1080241)) -- Full Jewelry Set Present
		if (wstring.find(wstring.lower(prop.original), st) or wstring.find(wstring.lower(prop.original), sp) or wstring.find(wstring.lower(prop.original), sp2)) then
			full = true
			LabelSetTextColor("set" .. i .. "Prop", 0, 255, 0)
			WindowSetFontAlpha( "set" .. i .. "Prop", 1 )
		end
		
		
		
		LabelSetText("set" .. i .. "Prop", FormatProperly(prop.original))
		local w, h = WindowGetDimensions("set" .. i)	
		SetsH = SetsH + h
	end
	
	
	if ( #ItemProperties.ExtraProps.props > 0 ) then
		if #ItemProperties.ExtraProps.setData > 0 then
			WindowAddAnchor("WeaponPropertiesBottomDockspot", "bottomleft", "set" .. #ItemProperties.ExtraProps.setData .. "Prop", "topleft", 0, 20)	
		else
			WindowAddAnchor("WeaponPropertiesBottomDockspot", "bottomleft", "prop" .. #ItemProperties.ExtraProps.props .. "Prop", "topleft", 0, 20)	
		end	
	else
		PropsH = PropsH -14
		if #ItemProperties.ExtraProps.setData > 0 then
			WindowAddAnchor("WeaponPropertiesBottomDockspot", "bottomleft", "set" .. #ItemProperties.ExtraProps.setData .. "Prop", "topleft", 0, 20)	
		else
			WindowAddAnchor("WeaponPropertiesBottomDockspot", "bottomleft", "WeaponPropertiesElementsTable", "topleft", 15, propsStartH + WeaponDataH)
		end
	end
	WindowClearAnchors("WeaponPropertiesSKLReq")
	WindowAddAnchor("WeaponPropertiesSKLReq", "bottomright", "WeaponPropertiesSTRReq", "topright", 0, 0)
	
	WindowClearAnchors("WeaponPropertiesRACEReq")
	WindowAddAnchor("WeaponPropertiesRACEReq", "bottomright", "WeaponPropertiesSKLReq", "topright", 0, 0)
			
	if (ItemProperties.ExtraProps.strReq  > 0) then
		if (ItemProperties.ExtraProps.strReq > WindowData.PlayerStatus.Strength) then
			LabelSetTextColor("WeaponPropertiesSTRReq", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("WeaponPropertiesSTRReq", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("WeaponPropertiesSTRReq", FormatProperly(ReplaceTokens(FormatProperly(GetStringFromTid(1061170)), {towstring(ItemProperties.ExtraProps.strReq)})))
	else
		WindowClearAnchors("WeaponPropertiesSKLReq")
		local w, h = WindowGetDimensions("WeaponPropertiesSKLReq")	
		local dist = (300 - w) +95
		WindowAddAnchor("WeaponPropertiesSKLReq", "topright", "WeaponPropertiesBottomDockspot", "topright", w + dist, 0)
	end
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesSKLReq", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	LabelSetText("WeaponPropertiesSKLReq", ItemProperties.ExtraProps.skillReq)

	
	
	if WindowData.PlayerStatus["Race"] ~= ItemProperties.ExtraProps.raceReq then
		LabelSetTextColor("WeaponPropertiesRACEReq", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
	end

	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesRACEReq", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	if ItemProperties.ExtraProps.raceReq == ItemPropertiesEvaluator.RACE_GARGOYLE then
		LabelSetText("WeaponPropertiesRACEReq", FormatProperly(GetStringFromTid(1111709))) -- gargoyles only
	elseif (ItemProperties.ExtraProps.raceReq == ItemPropertiesEvaluator.RACE_ELF) then
		LabelSetText("WeaponPropertiesRACEReq", FormatProperly(GetStringFromTid(1075086))) -- elves only
	else
		if (ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1011186)) then
			if WindowData.PlayerStatus["Race"] == 1 or  WindowData.PlayerStatus["Race"] == 2 then
				LabelSetTextColor("WeaponPropertiesRACEReq", 255, 255, 255)
			end
			LabelSetText("WeaponPropertiesRACEReq", UI.GetCliloc(SystemData.Settings.Language.type, 5071)) 
		else
			WindowClearAnchors("WeaponPropertiesLine")
			WindowAddAnchor("WeaponPropertiesLine", "bottomright", "WeaponPropertiesSKLReq", "topright", -15, 10)
		end
	end
	
	local col = {r=255,g=255,b=255}
	

	if LabelGetText("WeaponPropertiesRACEReq") == L"" then
		WindowClearAnchors("WeaponPropertiesUsesVal")
		WindowAddAnchor("WeaponPropertiesUsesVal", "bottomright", "WeaponPropertiesRACEReq", "topright", 0, -3)
	end
	
	local InfoH = 102
	
	if (tonumber(ItemProperties.ExtraProps.uses)) then
		if (  tonumber(ItemProperties.ExtraProps.uses) < 10 ) then
			col = EnhancePack.DANGER_COLOR
		elseif ( tonumber(ItemProperties.ExtraProps.uses) <= 20) then
			col = EnhancePack.ALERT_COLOR
		end
		LabelSetTextColor("WeaponPropertiesUsesVal", col.r, col.g, col.b)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("WeaponPropertiesUsesLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("WeaponPropertiesUsesVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
			
		LabelSetText("WeaponPropertiesUsesVal", ItemProperties.ExtraProps.uses)
		LabelSetText("WeaponPropertiesUsesLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5054))
	elseif tonumber(ItemProperties.ExtraProps.poisonCharge) then
		if ( ItemProperties.ExtraProps.poisonCharge < 4 ) then
			col = EnhancePack.DANGER_COLOR
		elseif ( ItemProperties.ExtraProps.poisonCharge <= 8 ) then
			col = EnhancePack.ALERT_COLOR
		end
		LabelSetTextColor("WeaponPropertiesUsesVal", col.r, col.g, col.b)
		
		LabelSetTextColor("WeaponPropertiesUsesLabel", 0, 255, 0)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("WeaponPropertiesUsesLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
			
		WindowSetDimensions("WeaponPropertiesUsesLabel", 200, 20)
		LabelSetText("WeaponPropertiesUsesVal", L"" .. ItemProperties.ExtraProps.poisonCharge)
		LabelSetText("WeaponPropertiesUsesLabel", FormatProperly(ItemProperties.ExtraProps.poison))
	else
		InfoH = InfoH - 17
		WindowClearAnchors("WeaponPropertiesDurabilityVal")
		if LabelGetText("WeaponPropertiesRACEReq") == L"" then
			WindowAddAnchor("WeaponPropertiesDurabilityVal", "bottomright", "WeaponPropertiesRACEReq", "topright", 0, -3)
		else
			WindowAddAnchor("WeaponPropertiesDurabilityVal", "bottomright", "WeaponPropertiesRACEReq", "topright", 0, 17)
		end
	end
	
	col = {r=255,g=255,b=255}
	if ( ItemProperties.ExtraProps.curDurab < ItemProperties.ExtraProps.maxDurab * 0.2 ) then
		col = EnhancePack.DANGER_COLOR
	elseif ( ItemProperties.ExtraProps.curDurab <= ItemProperties.ExtraProps.maxDurab * 0.4) then
		col = EnhancePack.ALERT_COLOR
	end
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesDurabilityLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont("WeaponPropertiesDurabilityVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	LabelSetTextColor("WeaponPropertiesDurabilityVal", col.r, col.g, col.b)		
	LabelSetText("WeaponPropertiesDurabilityVal", ItemProperties.ExtraProps.curDurab .. L" / " ..  ItemProperties.ExtraProps.maxDurab)
	
	
	LabelSetText("WeaponPropertiesDurabilityLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5049))
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("WeaponPropertiesWeightVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont("WeaponPropertiesWeightLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	LabelSetText("WeaponPropertiesWeightVal", ItemProperties.ExtraProps.weight .. L" " .. GetStringFromTid(1044514))
	LabelSetText("WeaponPropertiesWeightLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5050))
	
	if ItemProperties.ExtraProps.intensity and  ItemProperties.ExtraProps.intensity > 0 and ItemProperties.ExtraProps.unravelInto and ItemProperties.ExtraProps.unravelInto ~= L"" then
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("WeaponPropertiesImbuingVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("WeaponPropertiesImbuingLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("WeaponPropertiesUnravelVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("WeaponPropertiesUnravelLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("WeaponPropertiesImbuingVal", L"~" .. ItemProperties.ExtraProps.intensity)
		LabelSetText("WeaponPropertiesImbuingLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5051))
		
		LabelSetText("WeaponPropertiesUnravelVal", ItemProperties.ExtraProps.unravelInto)
		LabelSetText("WeaponPropertiesUnravelLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5052))
	else
		InfoH = InfoH - 34
	end
	
	
	
	-- Marks: Brittle, Imbued, Cannot Be Repaired, Faction Item, Quest Item, Ephemeral
	-- (MAX 4)
	
	local mark = 0
	
	if (ItemProperties.ExtraProps.lockedDown) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			if LabelGetText("WeaponPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		LabelSetTextColor("Marks" .. mark, EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)	
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetText("Marks" .. mark, FormatProperly(ItemProperties.ExtraProps.lockedDown))
	end
	
	
	if (ItemProperties.ExtraProps.altered) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		LabelSetTextColor("Marks" .. mark, EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)	
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1111880)))
	end
	
	if (ItemProperties.ExtraProps.factionItem) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		LabelSetTextColor("Marks" .. mark, EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)	
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1041350)))
	end
	if (ItemProperties.ExtraProps.questItem) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)		
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1072351)))
	end
	if (ItemProperties.ExtraProps.ephemeral) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1152714)))
	end
	if (ItemProperties.ExtraProps.brittle) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1116209)))
	end
	
	if (ItemProperties.ExtraProps.cannotrepair) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1151782)))
	end
	
	if (ItemProperties.ExtraProps.imbued) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("Marks" .. mark, UI.GetCliloc(SystemData.Settings.Language.type,5053))
	end
		
	if (ItemProperties.ExtraProps.reforged) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "WeaponProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "WeaponPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("Marks" .. mark, FormatProperly(ItemProperties.ExtraProps.reforged))
	end
	
	
	local marksH = 20 + (20 * (mark - 1))
	
	if SetsH <= 15 then
		SetsH = 0
	end
	
	if PropsH <= 15 and marksH <= 20 then
		PropsH = 0
	end
	
	
	
	-- Status: Insured, Blessed, Cursed, Blessed For
	-- (MAX 3)
	
	local status = 0
	
	if (ItemProperties.ExtraProps.price and ItemProperties.ExtraProps.price ~= L"") then
		
		local lines = BookTemplate.Commalines(WStringToString(ItemProperties.ExtraProps.price))
		
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "WeaponProperties")
		WindowAddAnchor("status" .. status, "bottomleft", "WeaponPropertiesLine", "topleft", -10, 5)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.TITLE_COLOR.r, EnhancePack.TITLE_COLOR.g, EnhancePack.TITLE_COLOR.b)		
		LabelSetText("status" .. status, towstring(lines[1]))
		
		if towstring(lines[2]) ~= "" then
			status = status + 1
			CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "WeaponProperties")
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
			if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
				LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end	
			LabelSetTextColor("status" .. status, EnhancePack.TITLE_COLOR.r, EnhancePack.TITLE_COLOR.g, EnhancePack.TITLE_COLOR.b)		
			LabelSetText("status" .. status, towstring(lines[2]))
		end
	end
	
	if (ItemProperties.ExtraProps.insured) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "WeaponProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "WeaponPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(GetStringFromTid(1114311)))
	end
	
	if (ItemProperties.ExtraProps.blessed) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "WeaponProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "WeaponPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(GetStringFromTid(1038021)))
	end
	
	if (ItemProperties.ExtraProps.blessedFor) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "WeaponProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "WeaponPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(ItemProperties.ExtraProps.ownedBy))
	end
	
	if (ItemProperties.ExtraProps.ownedBy) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "WeaponProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "WeaponPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(ItemProperties.ExtraProps.blessedFor))
	end
	
	if (ItemProperties.ExtraProps.cursed) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "WeaponProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "WeaponPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(GetStringFromTid(1049643)))
	end
	
	
	if (ItemProperties.ExtraProps.notrade) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "WeaponProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "WeaponPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(GetStringFromTid(1076255)))
	end
	
	local statusH = 5 + (20 * (status - 1) )
	
	if InfoH < statusH then
		InfoH = statusH
	end
	
	-- DESCRIPTIONS
	
	local DescH  = 10
	for i = 1, #ItemProperties.ExtraProps.descs do
		CreateWindowFromTemplate("Desc" .. i, "ItemDescriptionDef", "WeaponProperties")
		if i == 1 then
			if ItemProperties.ExtraProps.intensity and ItemProperties.ExtraProps.intensity > 0 and ItemProperties.ExtraProps.unravelInto and ItemProperties.ExtraProps.unravelInto ~= L"" then
				WindowAddAnchor("Desc" .. i, "bottomright", "WeaponPropertiesUnravelVal", "topright", -10, 5)
			else
				WindowAddAnchor("Desc" .. i, "bottomright", "WeaponPropertiesWeightVal", "topright", -10, 5)
			end			
		else
			WindowAddAnchor("Desc" .. i, "bottomleft", "Desc" .. i - 1, "topleft", 0, 8)
			DescH = DescH + 8
		end
		
		local prop = ItemProperties.ExtraProps.descs[i]
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Desc" .. i, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Desc" .. i, prop.color.r, prop.color.g, prop.color.b)
		LabelSetText("Desc" .. i, prop.original)
		local w, h = WindowGetDimensions("Desc" .. i)	
		DescH = DescH + h
	end

	
	-- RESIZING WINDOW
	local nc, weaponNameBlockH = WindowGetDimensions("WeaponPropertiesInnerFrame")

	local itemTypeH = 25
	local DPSH = 80
	local ElmentsTableH = 48
	
	
	
	local DockSpotH = 21
	local LineH = 12
	

	if #ItemProperties.ExtraProps.descs == 0 then
		DescH = 0
		if InfoH <= 20 and #ItemProperties.ExtraProps.descs == 0 then
			InfoH = 0
			WindowSetShowing("WeaponPropertiesLine", false)
		end
	end
	
	local BottomMargin = 10
	local RequirementsH = 0
	if LabelGetText("WeaponPropertiesRACEReq") ~= L"" then
		if RequirementsH == 0 then
			RequirementsH = RequirementsH + 17
			LineH = LineH + 3
		end
		RequirementsH = RequirementsH + 20
	end
	if LabelGetText("WeaponPropertiesSTRReq") ~= L"" then
		if RequirementsH == 0 then
			RequirementsH = RequirementsH + 17
			LineH = LineH + 3
		end
		RequirementsH = RequirementsH + 20
	end	
	if LabelGetText("WeaponPropertiesSKLReq") ~= L"" then
		if RequirementsH == 0 then
			RequirementsH = RequirementsH + 17
			LineH = LineH + 3
		end
		RequirementsH = RequirementsH + 20
	end	
	
	y = weaponNameBlockH + itemTypeH + DPSH + ElmentsTableH + WeaponDataH + PropsH + SetsH + RequirementsH  + LineH + InfoH  + DescH + BottomMargin
	
	local width, nc = WindowGetDimensions("WeaponProperties")
	
	WindowSetDimensions("WeaponProperties", width, y)
	
	WindowForceProcessAnchors("WeaponProperties")
	
	
	if not WindowGetShowing("ItemProperties") then
	
		-- SHOWS WINDOW
		WindowSetDimensions("ItemProperties", width, y)
		
		local scaleFactor = 1/InterfaceCore.scale	
		
		if not EnhancePack.PropsSlot then
			windowOffset = 16
			
			mouseX = SystemData.MousePosition.x
			propWindowX = mouseX - windowOffset - (width / scaleFactor)
			if propWindowX < 0 then
				propWindowX = mouseX + windowOffset
			end
				
			mouseY = SystemData.MousePosition.y
			propWindowY = mouseY - windowOffset - (y / scaleFactor)
			if propWindowY < 0 then
				propWindowY = mouseY + windowOffset
			end

			WindowSetOffsetFromParent("ItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)
		else
			local props = "Hotbar"..EnhancePack.PropsSlot.HotbarID.."Button"..EnhancePack.PropsSlot.SlotID
			windowOffset = WindowGetDimensions(props) / 2
			local x, y = WindowGetScreenPosition (props)

			x = (x + windowOffset) - (width / scaleFactor)
			y = (y + windowOffset) - (y / scaleFactor)
			
			WindowSetOffsetFromParent("ItemProperties", x*scaleFactor, y*scaleFactor)
		end
		WindowSetShowing("ItemPropertiesWindowBackground", false)
		WindowSetShowing("ItemPropertiesFrame", false)
		WindowSetShowing("ItemProperties", true)
	end
	EnhancePack.ItmPrpShowing = true
end

function ItemProperties.ShowArmorProps()
	if (DoesWindowNameExist("ArmorProperties")) then
		return
	end
	
	CreateWindowFromTemplate("ArmorProperties", "WeaponPropertiesTemplate", "ItemProperties")
	WindowSetAlpha("ArmorPropertiesWindowBackground", 0.8)
		
	LabelSetTextColor("ArmorPropertiesItemName", EnhancePack.PLAIN_COLOR.r, EnhancePack.PLAIN_COLOR.g, EnhancePack.PLAIN_COLOR.b)

	if (ItemProperties.ExtraProps.intensity and ItemProperties.ExtraProps.intensity > 0 and not ItemProperties.ExtraProps.arti and not ItemProperties.ExtraProps.set) then
		if (ItemProperties.ExtraProps.unravelInto == GetStringFromTid(1031697)) then
			LabelSetTextColor("ArmorPropertiesItemName", EnhancePack.RESIDUE_COLOR.r, EnhancePack.RESIDUE_COLOR.g, EnhancePack.RESIDUE_COLOR.b)
		elseif (ItemProperties.ExtraProps.unravelInto == GetStringFromTid(1031698)) then
			LabelSetTextColor("ArmorPropertiesItemName", EnhancePack.ESSENCE_COLOR.r, EnhancePack.ESSENCE_COLOR.g, EnhancePack.ESSENCE_COLOR.b)
		elseif (ItemProperties.ExtraProps.unravelInto == GetStringFromTid(1031699)) then
			LabelSetTextColor("ArmorPropertiesItemName", EnhancePack.RELIC_COLOR.r, EnhancePack.RELIC_COLOR.g, EnhancePack.RELIC_COLOR.b)
		end
	else
		if (ItemProperties.ExtraProps.arti) then
			LabelSetTextColor("ArmorPropertiesItemName", EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)
		elseif (ItemProperties.ExtraProps.set) then
			LabelSetTextColor("ArmorPropertiesItemName", EnhancePack.SET_COLOR.r, EnhancePack.SET_COLOR.g, EnhancePack.SET_COLOR.b)
		end
	end
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("ArmorPropertiesItemName", "UO_DefaultText_ASIA_20", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)		
	end
	WindowSetDimensions("ArmorPropertiesItemName", 430, 40)
	LabelSetText("ArmorPropertiesItemName", FormatProperly(ItemProperties.ExtraProps.itemName) )
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("ArmorPropertiesItemExc", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont("ArmorPropertiesCraftedBy", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
		
	if (ItemProperties.ExtraProps.exceptional) then
		
		LabelSetText("ArmorPropertiesItemExc", FormatProperly(GetStringFromTid(1060636))) -- L"Exceptional"
		LabelSetText("ArmorPropertiesCraftedBy", ItemProperties.ExtraProps.craftedBy)
		
	else
		WindowSetShowing("ArmorPropertiesItemExc", false)
		WindowSetShowing("ArmorPropertiesCraftedBy", false)
	end
	
	
	if (ItemProperties.ExtraProps.engraveText and ItemProperties.ExtraProps.engraveText ~= L"") then
		LabelSetTextColor("ArmorPropertiesEngrave", EnhancePack.ENGRAVE_COLOR.r, EnhancePack.ENGRAVE_COLOR.g, EnhancePack.ENGRAVE_COLOR.b)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesEngrave", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		--WindowSetDimensions("ArmorPropertiesEngrave", 450, 17)
		LabelSetText("ArmorPropertiesEngrave", FormatProperly(ItemProperties.ExtraProps.engraveText))
	else
		WindowSetShowing("ArmorPropertiesEngrave", false)
	end
	
	if ( not WindowGetShowing("ArmorPropertiesItemExc") ) then
		if ( not WindowGetShowing("ArmorPropertiesEngrave") ) then
			WindowSetDimensions("ArmorPropertiesInnerFrame", 450, 70)
						
			WindowClearAnchors("ArmorPropertiesItemName")
			WindowAddAnchor("ArmorPropertiesItemName", "top", "ArmorProperties", "top", 0, 10)
			
			
		else
			local nc, h = WindowGetDimensions("ArmorPropertiesEngrave")
			WindowSetDimensions("ArmorPropertiesInnerFrame", 450, 90 + h)
			--WindowSetDimensions("ArmorPropertiesInnerFrame", 450, 90)
			
			WindowClearAnchors("ArmorPropertiesItemName")
			WindowAddAnchor("ArmorPropertiesItemName", "top", "ArmorProperties", "top", 0, 15)
	
			
			WindowClearAnchors("ArmorPropertiesEngrave")
			WindowAddAnchor("ArmorPropertiesEngrave", "bottom", "ArmorPropertiesItemName", "top", 0, 5)
			
		end
	else
		if ( not WindowGetShowing("ArmorPropertiesEngrave") ) then
			WindowClearAnchors("ArmorPropertiesItemName")
			WindowAddAnchor("ArmorPropertiesItemName", "top", "ArmorProperties", "top", 0, 15)
		else
			local nc, h = WindowGetDimensions("ArmorPropertiesEngrave")
			WindowSetDimensions("ArmorPropertiesInnerFrame", 450, 115 + h)
		end
	end
	
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("ArmorPropertiesItemType", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	LabelSetText("ArmorPropertiesItemType", FormatProperly(ItemProperties.ExtraProps.itemTypeName))
	
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("ArmorPropertiesLayer", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	if ItemProperties.ExtraProps.layer then
		LabelSetText("ArmorPropertiesLayer", ItemProperties.ExtraProps.layer)
	end
	
	local ElmentsTableH = 48
	local propsStartH = 20
	
	local ll = ItemProperties.LayerToSlot( ItemProperties.ExtraProps.layer )
	local res = ItemProperties.GetEquippedResistances( ll )
	local frst = false
	if ItemProperties.ExtraProps.layer and not ItemPropertiesEvaluator.PaperdollSlotOver and EnhancePack.ToggleItemComparison then
		for name, value in pairs(res) do
			notfound = false
			local fixName = name
			
			
			if (value > 0) then
				if #ItemProperties.ExtraProps.props > 0 then
					for i = 1, #ItemProperties.ExtraProps.props do
						if ItemProperties.ExtraProps.props[i].en and ItemProperties.ExtraProps.props[i].en == fixName then
							notfound = false
							break
						else 
							
							notfound = true
						end
					end
				else 		
					notfound = true
				end
				if not notfound then
					continue
				end
			else
				continue
			end
			
			if notfound and value > 0 then
				if not frst then
					frst = true
					data = {original = UI.GetCliloc(SystemData.Settings.Language.type, 5073), value = -1}
					table.insert(ItemProperties.ExtraProps.props, data)
				end
				value = 0-value
				local original = L""
				if (fixName == L"damage chance increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060401), {L"(" .. value} )) .. L")"
				elseif (fixName == L"swing speed increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060486), {L"(" .. value} )) .. L")"
					
				elseif (fixName == L"lower reagent cost") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060434), {L"(" .. value} )) .. L")"
				elseif (fixName == L"lower mana cost") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060433), {L"(" .. value} )) .. L")"
					
				elseif (fixName == L"hit chance increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060415), {L"(" .. value} )) .. L")"
				elseif (fixName == L"defense chance increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060408), {L"(" .. value} )) .. L")"
					
				elseif (fixName == L"mana regen") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060440), {L"(" .. value} )) .. L")"
				elseif (fixName == L"hit point regen") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060444), {L"(" .. value} )) .. L")"
					
				elseif (fixName == L"hit point increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060431), {L"(" .. value} )) .. L")"
				elseif (fixName == L"mana increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060439), {L"(" .. value} )) .. L")"
				elseif (fixName == L"stamina increase") then
					original =FormatProperly(ReplaceTokens(GetStringFromTid(1060484), {L"(" .. value} )) .. L")"
				end
				if original ~= L"" then
					data = {original = original, value = value}
					table.insert(ItemProperties.ExtraProps.props, data)
				end
			end
		end
	end
			
	if ItemProperties.ExtraProps.totalResist > 0 then
		
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesDPS", "UO_DefaultText_ASIA_36", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("ArmorPropertiesDPS", towstring(ItemProperties.ExtraProps.totalResist))
		
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesDPSLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("ArmorPropertiesDPSLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5055) )
            
		
		local resDiff = 0
		local charResDiff = 0
		local totalChanges = 0
		if ItemProperties.ExtraProps.layer and not ItemPropertiesEvaluator.PaperdollSlotOver and EnhancePack.ToggleItemComparison then
			ElmentsTableH = ElmentsTableH + 20
			propsStartH = propsStartH + 17
			
			for name, value in pairs(res) do
				if (name == L"physical resist") then
					if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
						LabelSetFont("ArmorPropertiesPhysDiff", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					end
					value = ItemProperties.ExtraProps.physR - value
					totalChanges = totalChanges + 1
					local chadiff = WindowData.PlayerStatus["PhysicalResist"] + value
					if (chadiff > 70) then
						chadiff = 70
					elseif (chadiff < 0) then
						chadiff = 0
					end
					charResDiff = charResDiff + chadiff
					
					resDiff = resDiff + value
					local text = L"(" .. value .. L")"
					if (value > 0) then
						text = L"(+" .. value .. L")"
						LabelSetTextColor("ArmorPropertiesPhysDiff", 0, 255, 0)
					elseif (value < 0) then
						LabelSetTextColor("ArmorPropertiesPhysDiff", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
					else
						LabelSetTextColor("ArmorPropertiesPhysDiff", 125, 125, 125)
					end
					LabelSetText("ArmorPropertiesPhysDiff", text)
				elseif (name == L"fire resist") then
					if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
						LabelSetFont("ArmorPropertiesFireDiff", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					end
					value = ItemProperties.ExtraProps.fireR - value
					totalChanges = totalChanges + 1
					local chadiff = WindowData.PlayerStatus["FireResist"] + value
					if (chadiff > 70) then
						chadiff = 70
					elseif (chadiff < 0) then
						chadiff = 0
					end
					charResDiff = charResDiff + chadiff
					
					resDiff = resDiff + value
					local text = L"(" .. value .. L")"
					if (value > 0) then
						text = L"(+" .. value .. L")"
						LabelSetTextColor("ArmorPropertiesFireDiff", 0, 255, 0)
					elseif (value < 0) then
						LabelSetTextColor("ArmorPropertiesFireDiff", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
					else
						LabelSetTextColor("ArmorPropertiesFireDiff", 125, 125, 125)
					end
					LabelSetText("ArmorPropertiesFireDiff", text)
				elseif (name == L"cold resist") then
					if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
						LabelSetFont("ArmorPropertiesColdDiff", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					end
					value = ItemProperties.ExtraProps.coldR - value
					totalChanges = totalChanges + 1
					local chadiff = WindowData.PlayerStatus["ColdResist"] + value
					if (chadiff > 70) then
						chadiff = 70
					elseif (chadiff < 0) then
						chadiff = 0
					end
					charResDiff = charResDiff + chadiff
					
					resDiff = resDiff + value
					local text = L"(" .. value .. L")"
					if (value > 0) then
						text = L"(+" .. value .. L")"
						LabelSetTextColor("ArmorPropertiesColdDiff", 0, 255, 0)
					elseif (value < 0) then
						LabelSetTextColor("ArmorPropertiesColdDiff", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
					else
						LabelSetTextColor("ArmorPropertiesColdDiff", 125, 125, 125)
					end
					LabelSetText("ArmorPropertiesColdDiff", text)
				elseif (name == L"poison resist") then
					if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
						LabelSetFont("ArmorPropertiesPoisDiff", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					end
					value = ItemProperties.ExtraProps.poisR - value
					totalChanges = totalChanges + 1
					local chadiff = WindowData.PlayerStatus["PoisonResist"] + value
					if (chadiff > 70) then
						chadiff = 70
					elseif (chadiff < 0) then
						chadiff = 0
					end
					charResDiff = charResDiff + chadiff
					
					resDiff = resDiff + value
					local text = L"(" .. value .. L")"
					if (value > 0) then
						text = L"(+" .. value .. L")"
						LabelSetTextColor("ArmorPropertiesPoisDiff", 0, 255, 0)
					elseif (value < 0) then
						LabelSetTextColor("ArmorPropertiesPoisDiff", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
					else
						LabelSetTextColor("ArmorPropertiesPoisDiff", 125, 125, 125)
					end
					LabelSetText("ArmorPropertiesPoisDiff", text)
			elseif (name == L"energy resist") then
					if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
						LabelSetFont("ArmorPropertiesEnerDiff", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
					end
					value = ItemProperties.ExtraProps.enerR - value
					totalChanges = totalChanges + 1
					local chadiff = WindowData.PlayerStatus["EnergyResist"] + value
					if (chadiff > 75 and WindowData.PlayerStatus["Race"] == 2) then
						chadiff = 75
					elseif (chadiff > 70) then
						chadiff = 70
					elseif (chadiff < 0) then
						chadiff = 0
					end
					charResDiff = charResDiff + chadiff
					
					resDiff = resDiff + value
					local text = L"(" .. value .. L")"
					if (value > 0) then
						text = L"(+" .. value .. L")"
						LabelSetTextColor("ArmorPropertiesEnerDiff", 0, 255, 0)
					elseif (value < 0) then
						LabelSetTextColor("ArmorPropertiesEnerDiff", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
					else
						LabelSetTextColor("ArmorPropertiesEnerDiff", 125, 125, 125)
					end
					LabelSetText("ArmorPropertiesEnerDiff", text)
				end
			end
		end
		local currTotRes = WindowData.PlayerStatus["PhysicalResist"] + WindowData.PlayerStatus["FireResist"] + WindowData.PlayerStatus["ColdResist"] + WindowData.PlayerStatus["PoisonResist"] + WindowData.PlayerStatus["EnergyResist"]

		local earnedRes = charResDiff - currTotRes
		if totalChanges > 0 then
			if earnedRes > 0 then
				earnedRes = L"+" ..  earnedRes
				LabelSetTextColor("ArmorPropertiesDPSChange", 0, 255, 0)
			elseif (earnedRes < 0) then
				LabelSetTextColor("ArmorPropertiesDPSChange", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
			else
				LabelSetTextColor("ArmorPropertiesDPSChange", 125, 125, 125)
			end
			LabelSetText("ArmorPropertiesDPSChange", L"(" .. earnedRes .. L")")
		end
		
		if (EnhancePack.ToggleExtraInfo) then
			WindowClearAnchors("ArmorPropertiesDMGPhys")
			WindowAddAnchor("ArmorPropertiesDMGPhys", "topleft", "ArmorPropertiesElementsTable", "topleft", 27, 0)
			for i = 1, #ItemProperties.ExtraProps.resists do
				local min
				local max = ItemProperties.ExtraProps.resists[i].cap
				if not ItemProperties.ExtraProps.resists[i].min then
					min = 0
				else
					min = ItemProperties.ExtraProps.resists[i].min
				end
				if (ItemProperties.ExtraProps.resists[i].name == L"physical resist") then
					if EnhancePack.IntensityInfo and ItemProperties.ExtraProps.resists[i].intensity and ItemProperties.ExtraProps.resists[i].intensity > 50 then 
						LabelSetTextColor("ArmorPropertiesDMGPhys", ItemProperties.ExtraProps.resists[i].color.r, ItemProperties.ExtraProps.resists[i].color.g, ItemProperties.ExtraProps.resists[i].color.b)
					end
					LabelSetText("ArmorPropertiesPhysCap", towstring(min) .. L" - " .. towstring(max))
				end
				
				if (ItemProperties.ExtraProps.resists[i].name == L"fire resist") then
					if EnhancePack.IntensityInfo and ItemProperties.ExtraProps.resists[i].intensity and ItemProperties.ExtraProps.resists[i].intensity > 50 then 
						LabelSetTextColor("ArmorPropertiesDMGFire", ItemProperties.ExtraProps.resists[i].color.r, ItemProperties.ExtraProps.resists[i].color.g, ItemProperties.ExtraProps.resists[i].color.b)
					end
					LabelSetText("ArmorPropertiesFireCap", towstring(min) .. L" - " .. towstring(max))
				end
				
				if (ItemProperties.ExtraProps.resists[i].name == L"cold resist") then
					if EnhancePack.IntensityInfo and ItemProperties.ExtraProps.resists[i].intensity and ItemProperties.ExtraProps.resists[i].intensity > 50 then 
						LabelSetTextColor("ArmorPropertiesDMGCold", ItemProperties.ExtraProps.resists[i].color.r, ItemProperties.ExtraProps.resists[i].color.g, ItemProperties.ExtraProps.resists[i].color.b)
					end
					LabelSetText("ArmorPropertiesColdCap", towstring(min) .. L" - " .. towstring(max))
				end
				
				if (ItemProperties.ExtraProps.resists[i].name == L"poison resist") then
					if EnhancePack.IntensityInfo and ItemProperties.ExtraProps.resists[i].intensity and ItemProperties.ExtraProps.resists[i].intensity > 50 then 
						LabelSetTextColor("ArmorPropertiesDMGPois", ItemProperties.ExtraProps.resists[i].color.r, ItemProperties.ExtraProps.resists[i].color.g, ItemProperties.ExtraProps.resists[i].color.b)
					end
					LabelSetText("ArmorPropertiesPoisCap", towstring(min) .. L" - " .. towstring(max))
				end
				
				if (ItemProperties.ExtraProps.resists[i].name == L"energy resist") then
					if EnhancePack.IntensityInfo and ItemProperties.ExtraProps.resists[i].intensity and ItemProperties.ExtraProps.resists[i].intensity > 50 then 
						LabelSetTextColor("ArmorPropertiesDMGEner", ItemProperties.ExtraProps.resists[i].color.r, ItemProperties.ExtraProps.resists[i].color.g, ItemProperties.ExtraProps.resists[i].color.b)
					end
					LabelSetText("ArmorPropertiesEnerCap", towstring(min) .. L" - " .. towstring(max))
				end
			end
		end
		
		LabelSetTextColor("ArmorPropertiesDMGPhys", EnhancePack.PHYSICAL.r, EnhancePack.PHYSICAL.g, EnhancePack.PHYSICAL.b)
		LabelSetText("ArmorPropertiesDMGPhys", towstring(ItemProperties.ExtraProps.physR) .. L"%")
		LabelSetTextColor("ArmorPropertiesDMGFire", EnhancePack.FIRE.r, EnhancePack.FIRE.g, EnhancePack.FIRE.b)
		LabelSetText("ArmorPropertiesDMGFire", towstring(ItemProperties.ExtraProps.fireR) .. L"%")
		LabelSetTextColor("ArmorPropertiesDMGCold", EnhancePack.COLD.r, EnhancePack.COLD.g, EnhancePack.COLD.b)
		LabelSetText("ArmorPropertiesDMGCold", towstring(ItemProperties.ExtraProps.coldR) .. L"%")
		LabelSetTextColor("ArmorPropertiesDMGPois", EnhancePack.POISON.r, EnhancePack.POISON.g, EnhancePack.POISON.b)
		LabelSetText("ArmorPropertiesDMGPois", towstring(ItemProperties.ExtraProps.poisR) .. L"%")
		LabelSetTextColor("ArmorPropertiesDMGEner", EnhancePack.ENERGY.r, EnhancePack.ENERGY.g, EnhancePack.ENERGY.b)
		LabelSetText("ArmorPropertiesDMGEner", towstring(ItemProperties.ExtraProps.enerR) .. L"%")
	else
		WindowSetShowing("ArmorPropertiesElementsTable", false)
	end	

	if ItemProperties.ExtraProps.maxresists.physical then
		table.insert(ItemProperties.ExtraProps.props, 1, ItemProperties.ExtraProps.maxresists.physical)
	end
	if ItemProperties.ExtraProps.maxresists.fire then
		table.insert(ItemProperties.ExtraProps.props, 1, ItemProperties.ExtraProps.maxresists.fire)
	end
	if ItemProperties.ExtraProps.maxresists.cold then
		table.insert(ItemProperties.ExtraProps.props, 1, ItemProperties.ExtraProps.maxresists.cold)
	end
	if ItemProperties.ExtraProps.maxresists.poison then
		table.insert(ItemProperties.ExtraProps.props, 1, ItemProperties.ExtraProps.maxresists.poison)
	end
	if ItemProperties.ExtraProps.maxresists.energy then
		table.insert(ItemProperties.ExtraProps.props, 1, ItemProperties.ExtraProps.maxresists.energy)
	end
	
	
	local DPSH = 80
	
	local itemTypeH = 25
	
	local PropsH = 15
	
	-- PROPS
	for i = 1, #ItemProperties.ExtraProps.props do
		CreateWindowFromTemplate("prop" .. i, "NewItemPropItemDef", "ArmorProperties")
		LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		local prop = ItemProperties.ExtraProps.props[i]
		if i == 1 then
			if not WindowGetShowing("ArmorPropertiesElementsTable") then
				if (LabelGetText("ArmorPropertiesItemType") == L"") then
					WindowAddAnchor("prop" .. i, "bottomleft", "ArmorPropertiesInnerFrame", "topleft", 20, 20)
					itemTypeH = 0
					DPSH = 0
					ElmentsTableH = 0
					PropsH = 20
				else
					WindowAddAnchor("prop" .. i, "bottomleft", "ArmorPropertiesItemType", "topleft", 5, 20)
					DPSH = 0
					ElmentsTableH = 0
					PropsH = 20
				end
			else
				WindowAddAnchor("prop" .. i, "bottomleft", "ArmorPropertiesElementsTable", "topleft", 0, propsStartH)
			end
		else
			if (prop.original == UI.GetCliloc(SystemData.Settings.Language.type, 5073)) then
				WindowAddAnchor("prop" .. i, "bottomleft", "prop" .. i - 1, "topleft", 0, 10)
				PropsH = PropsH + 10
				WindowSetShowing("prop" .. i .. "Dot", false)
			else
				WindowAddAnchor("prop" .. i, "bottomleft", "prop" .. i - 1, "topleft", 0, 0)
			end
		end
		
		
		local change = nil
		if ItemProperties.ExtraProps.props[i].en and res[ItemProperties.ExtraProps.props[i].en] and ItemProperties.ExtraProps.layer and not ItemPropertiesEvaluator.PaperdollSlotOver and EnhancePack.ToggleItemComparison then
			change = ItemProperties.ExtraProps.props[i].value - res[ItemProperties.ExtraProps.props[i].en]
			local capText = FormatProperly(ItemProperties.ExtraProps.props[i].en)
			capText = wstring.gsub(capText, L" ", L"")
			local max = CharacterSheet.Caps[tostring(capText)]
			if max then
				if change + WindowData.PlayerStatus[tostring(capText)] > max then
					change = max - (change + WindowData.PlayerStatus[tostring(capText)])
					if change < 0 then
						change = 0
					end
				end
			end
		end
		if EnhancePack.IntensityInfo and ItemProperties.ExtraProps.props[i].intensity and ItemProperties.ExtraProps.props[i].intensity > 50 then 
			if ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_WEARABLE or ItemProperties.ExtraProps.itemTypeName == GetStringFromTid(1011209) then
				if (ItemProperties.ExtraProps.itemTypeName == GetStringFromTid(1023643) or ItemProperties.ExtraProps.itemTypeName == GetStringFromTid(1032120)) then
					local col = EnhancePack.MAGICPROP_COLOR
					local gb = math.floor(2.55 * ItemProperties.ExtraProps.props[i].intensity)
					if gb > 255 then
						gb = 255
					end
					if ItemProperties.ExtraProps.props[i].intensity >= 100 then
						col = EnhancePack.ARTIFACT_COLOR
					else
						local r = 0
						local g = 0
						local b = 0
						if (EnhancePack.EXTRAINFO.r > 0)  then
							r = gb
						end
						if (EnhancePack.EXTRAINFO.g > 0) then
							g = gb
						end
						if (EnhancePack.EXTRAINFO.b > 0) then
							b = gb
						end
						col = {r=r, g=g, b=b}
					end
					LabelSetTextColor("prop" .. i .. "Prop", col.r, col.g, col.b)
				end
			else
				local col = EnhancePack.MAGICPROP_COLOR
				local gb = math.floor(2.55 * ItemProperties.ExtraProps.props[i].intensity)
				if gb > 255 then
					gb = 255
				end
				if ItemProperties.ExtraProps.props[i].intensity >= 100 then
					col = EnhancePack.ARTIFACT_COLOR
				else
					local r = 0
					local g = 0
					local b = 0
					if (EnhancePack.EXTRAINFO.r > 0)  then
						r = gb
					end
					if (EnhancePack.EXTRAINFO.g > 0) then
						g = gb
					end
					if (EnhancePack.EXTRAINFO.b > 0) then
						b = gb
					end
					col = {r=r, g=g, b=b}
				end
				LabelSetTextColor("prop" .. i .. "Prop", col.r, col.g, col.b)
			end
		else
			if (wstring.lower(prop.original) == wstring.lower(GetStringFromTid(1151821))) then -- luck -100
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
			elseif (wstring.lower(prop.original) == wstring.lower(GetStringFromTid(1094732))) then -- * Requires the "Stygian Abyss" expansion
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
			elseif (wstring.lower(prop.original) == wstring.lower(GetStringFromTid(1116296))) then -- * Requires the "High Seas" booster
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
			elseif (wstring.lower(prop.original) == wstring.lower(GetStringFromTid(1151520))) then -- lost item (Return to gain Honesty)
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
			elseif (tonumber(prop.value) and tonumber(prop.value) < 0) then
				LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
			elseif prop.name == L"CANNON" then
				LabelSetTextColor("prop" .. i .. "Prop", prop.color.r, prop.color.g, prop.color.b)
			end
			
			if prop.name == L"FISH" then
				if prop.value >= prop.cap then
					LabelSetTextColor("prop" .. i .. "Prop", 0, 255, 0)
				elseif prop.value == 0 then
					LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
				else
					LabelSetTextColor("prop" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
				end
			end
			
			if (prop.original == UI.GetCliloc(SystemData.Settings.Language.type, 5073)) then
				LabelSetTextColor("prop" .. i .. "Prop", 125, 125, 125)
			end
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("prop" .. i .. "Prop", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("prop" .. i .. "Prop", FormatProperly(prop.original))
		
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("prop" .. i .. "Cap", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		
		if (prop.cap and type(prop.cap) == "number" and prop.totWeight and prop.totWeight >= 0 and EnhancePack.ToggleExtraInfo) then
			if ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_WEARABLE or ItemProperties.ExtraProps.itemTypeName == GetStringFromTid(1011209) then
				if (ItemProperties.ExtraProps.itemTypeName == GetStringFromTid(1023643) or ItemProperties.ExtraProps.itemTypeName == GetStringFromTid(1032120)) then
					
					if ItemProperties.ExtraProps.props[i].min then
						LabelSetText("prop" .. i .. "Cap", UI.GetCliloc(SystemData.Settings.Language.type, 876) .. prop.min .. L" - " .. prop.cap)
					else
						LabelSetText("prop" .. i .. "Cap", UI.GetCliloc(SystemData.Settings.Language.type, 877) .. prop.cap)
					end
				end
			else
				if ItemProperties.ExtraProps.props[i].min then
					LabelSetText("prop" .. i .. "Cap", UI.GetCliloc(SystemData.Settings.Language.type, 876) .. prop.min .. L" - " .. prop.cap)
				else
					LabelSetText("prop" .. i .. "Cap", UI.GetCliloc(SystemData.Settings.Language.type, 877) .. prop.cap)
				end
			end
		end
		
		if change then
			if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
				LabelSetFont("prop" .. i .. "Change", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end
			if change > 0 then
				
				LabelSetTextColor("prop" .. i .. "Change", 0, 255, 0)
				LabelSetText("prop" .. i .. "Change", L"(+" .. change .. L")")
			elseif change <0 then
				
				LabelSetTextColor("prop" .. i .. "Change", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
				LabelSetText("prop" .. i .. "Change", L"(" .. change .. L")")
			else
				
				LabelSetTextColor("prop" .. i .. "Change", 125, 125, 125)
				LabelSetText("prop" .. i .. "Change", L"(" .. change .. L")")
			end
		end
		
		local w, h = WindowGetDimensions("prop" .. i)	
		PropsH = PropsH + h
	end
	
	local SetsH = 20
	
	local full = false
	-- SET PART
	for i = 1, #ItemProperties.ExtraProps.setData do
		CreateWindowFromTemplate("set" .. i, "NewItemPropItemDef", "ArmorProperties")
		if i == 1 then
			if #ItemProperties.ExtraProps.props > 0 then
				WindowAddAnchor("set" .. i, "bottomleft", "prop" .. #ItemProperties.ExtraProps.props, "topleft", 0, SetsH)
			else
				if not WindowGetShowing("ArmorPropertiesElementsTable") then
					if (LabelGetText("ArmorPropertiesItemType") == L"") then
						WindowAddAnchor("set" .. i, "bottomleft", "ArmorPropertiesInnerFrame", "topleft", 20, SetsH)
						itemTypeH = 0
						DPSH = 0
						ElmentsTableH = 0
					else
						WindowAddAnchor("set" .. i, "bottomleft", "ArmorPropertiesItemType", "topleft", 5, SetsH)
						DPSH = 0
						ElmentsTableH = 0
					end
				else
					WindowAddAnchor("set" .. i, "bottomleft", "ArmorPropertiesElementsTable", "topleft", 0, SetsH)
				end
			end
		else
			WindowAddAnchor("set" .. i, "bottomleft", "set" .. i - 1, "topleft", 0, 0)
		end
		
		if (i < 3) then
			WindowSetShowing("set" .. i .. "Dot", false)
		end
		
		LabelSetTextColor("set" .. i .. "Prop", EnhancePack.SET_COLOR.r, EnhancePack.SET_COLOR.g, EnhancePack.SET_COLOR.b)
		if (not full) then
			WindowSetFontAlpha( "set" .. i .. "Prop", 0.5 )
		end
		
		local prop = ItemProperties.ExtraProps.setData[i]

		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("set" .. i .. "Prop", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end

		local sp = wstring.gsub(wstring.lower(GetStringFromTid(1072376)), L"~1_val~", L"") -- Part of an Armor Set (~1_val~ pieces)
		if SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU then
			sp = wstring.sub(sp, 1, wstring.find(sp, L"[(]") -1)
		end
		local sp2 = wstring.gsub(wstring.lower(GetStringFromTid(1073491)), L"~1_val~", L"") -- Part of a Weapon/Armor Set (~1_val~ pieces)
		if SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU then
			sp2 = wstring.sub(sp2, 1, wstring.find(sp2, L"[(]") -1)
		end
		local sp3 = wstring.gsub(wstring.lower(GetStringFromTid(1080240)), L"~1_val~", L"") -- Part of a Jewelry Set (~1_val~ pieces)
		if SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU then
			sp3 = wstring.sub(sp3, 1, wstring.find(sp3, L"[(]") -1)
		end
		if (wstring.find(wstring.lower(prop.original), sp) or wstring.find(wstring.lower(prop.original), sp2) or wstring.find(wstring.lower(prop.original), sp3)) then
			LabelSetTextColor("set" .. i .. "Prop", EnhancePack.SET_COLOR.r, EnhancePack.SET_COLOR.g, EnhancePack.SET_COLOR.b)
			WindowSetFontAlpha( "set" .. i .. "Prop", 1 )
		end
		
		local st = wstring.gsub(wstring.lower(GetStringFromTid(1072378)), L"<br>", L"") -- Only when full set is present:
		if (wstring.find(wstring.lower(prop.original), st)) then
			full = false
			LabelSetTextColor("set" .. i .. "Prop", EnhancePack.ALERT_COLOR.r, EnhancePack.ALERT_COLOR.g, EnhancePack.ALERT_COLOR.b)
			WindowSetFontAlpha( "set" .. i .. "Prop", 1 )
		end
		
		st = wstring.lower(GetStringFromTid(1072377)) -- Full Armor Set Present
		sp =  wstring.lower(GetStringFromTid(1073492)) -- Full Weapon/Armor Set Present
		sp2 =  wstring.lower(GetStringFromTid(1080241)) -- Full Jewelry Set Present
		if (wstring.find(wstring.lower(prop.original), st) or wstring.find(wstring.lower(prop.original), sp) or wstring.find(wstring.lower(prop.original), sp2)) then
			full = true
			LabelSetTextColor("set" .. i .. "Prop", 0, 255, 0)
			WindowSetFontAlpha( "set" .. i .. "Prop", 1 )
		end
		
		
		
		LabelSetText("set" .. i .. "Prop", FormatProperly(prop.original))
		local w, h = WindowGetDimensions("set" .. i)	
		SetsH = SetsH + h
	end
	
	
	if (ItemProperties.ExtraProps.strReq  > 0) then
		if (ItemProperties.ExtraProps.strReq > WindowData.PlayerStatus.Strength) then
			LabelSetTextColor("ArmorPropertiesSTRReq", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesSTRReq", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("ArmorPropertiesSTRReq", FormatProperly(ReplaceTokens(FormatProperly(GetStringFromTid(1061170)), {towstring(ItemProperties.ExtraProps.strReq)})))
		if (ItemProperties.ExtraProps.content) then
			WindowClearAnchors("ArmorPropertiesSKLReq")
			WindowAddAnchor("ArmorPropertiesSKLReq", "bottomright", "ArmorPropertiesSTRReq", "topright", 0, 0)
			WindowClearAnchors("ArmorPropertiesRACEReq")
			WindowAddAnchor("ArmorPropertiesRACEReq", "bottomright", "ArmorPropertiesSTRReq", "topright", 0, 0)
		else
			WindowClearAnchors("ArmorPropertiesRACEReq")
			WindowAddAnchor("ArmorPropertiesRACEReq", "bottomleft", "ArmorPropertiesSTRReq", "topleft", 0, 0)
		end
	else
		if (ItemProperties.ExtraProps.content) then
			WindowClearAnchors("ArmorPropertiesSKLReq")
			local w, h = WindowGetDimensions("ArmorPropertiesSKLReq")	
			local dist = (300 - w) +95
			WindowAddAnchor("ArmorPropertiesSKLReq", "topright", "ArmorPropertiesBottomDockspot", "topright", w + dist, 0)
			WindowClearAnchors("ArmorPropertiesRACEReq")
			WindowAddAnchor("ArmorPropertiesRACEReq", "bottomright", "ArmorPropertiesSTRReq", "topright", 0, 0)
		else
			WindowClearAnchors("ArmorPropertiesRACEReq")
			WindowAddAnchor("ArmorPropertiesRACEReq", "topright", "ArmorPropertiesBottomDockspot", "topleft", 95, 0)
		end
	end
	
	local LineH = 2
	
	if WindowData.PlayerStatus["Race"] ~= ItemProperties.ExtraProps.raceReq then
		LabelSetTextColor("ArmorPropertiesRACEReq", EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
	end

	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		LabelSetFont("ArmorPropertiesRACEReq", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont("ArmorPropertiesSKLReq", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	if (ItemProperties.ExtraProps.content) then
		LabelSetText("ArmorPropertiesSKLReq", ItemProperties.ExtraProps.content)
	end
	
	if ItemProperties.ExtraProps.raceReq == ItemPropertiesEvaluator.RACE_GARGOYLE then
		LabelSetText("ArmorPropertiesRACEReq", FormatProperly(GetStringFromTid(1111709))) -- gargoyles only
	elseif (ItemProperties.ExtraProps.raceReq == ItemPropertiesEvaluator.RACE_ELF) then
		LabelSetText("ArmorPropertiesRACEReq", FormatProperly(GetStringFromTid(1075086))) -- elves only
	else
		if (ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1027945)
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1027942) 
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1011209) 
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1027939)
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1027943)
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1011406)
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1023643)
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1032120)
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1041281)
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1045126)
			and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1011189)
			) 
			and 
			(ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_JEWEL 
			or ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_ARMOR 
			or ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_SHIELD 
			or ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_HAT
			or ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_WEARABLE
			) then
			if WindowData.PlayerStatus["Race"] == 1 or  WindowData.PlayerStatus["Race"] == 2 then
				LabelSetTextColor("ArmorPropertiesRACEReq", 255, 255, 255)
			end
			LabelSetText("ArmorPropertiesRACEReq", UI.GetCliloc(SystemData.Settings.Language.type, 5071)) 
		else
			WindowClearAnchors("ArmorPropertiesLine")
			if (ItemProperties.ExtraProps.strReq  > 0) then				
				WindowAddAnchor("ArmorPropertiesLine", "bottomright", "ArmorPropertiesSTRReq", "topright", -15, 10)
			elseif (ItemProperties.ExtraProps.content) then
				WindowAddAnchor("ArmorPropertiesLine", "bottomright", "ArmorPropertiesSKLReq", "topright", -15, 10)
			else
				WindowAddAnchor("ArmorPropertiesLine", "topright", "ArmorPropertiesBottomDockspot", "topleft", -15, 0)
				
			end
		end
	end
	
	local col = {r=255,g=255,b=255}
	

	if LabelGetText("ArmorPropertiesRACEReq") == L"" then
		WindowClearAnchors("ArmorPropertiesUsesVal")
		if (ItemProperties.ExtraProps.content) then
			WindowAddAnchor("ArmorPropertiesUsesVal", "bottomright", "ArmorPropertiesSKLReq", "topright", 0, 15)
		elseif (ItemProperties.ExtraProps.strReq  > 0) then				
			WindowAddAnchor("ArmorPropertiesUsesVal", "bottomright", "ArmorPropertiesSTRReq", "topright", 0, 15)
		else
			WindowAddAnchor("ArmorPropertiesUsesVal", "bottomright", "ArmorPropertiesLine", "topright", 0, 5)
		end
		
	end
	
	local InfoH = 102
	
	if (tonumber(ItemProperties.ExtraProps.uses)) then
		if ( tonumber(ItemProperties.ExtraProps.uses) < 10 ) then
			col = EnhancePack.DANGER_COLOR
		elseif (  tonumber(ItemProperties.ExtraProps.uses) <= 20) then
			col = EnhancePack.ALERT_COLOR
		end
		LabelSetTextColor("ArmorPropertiesUsesVal", col.r, col.g, col.b)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesUsesLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("ArmorPropertiesUsesVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
			
		LabelSetText("ArmorPropertiesUsesVal", ItemProperties.ExtraProps.uses)
		LabelSetText("ArmorPropertiesUsesLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5054))
	elseif tonumber(ItemProperties.ExtraProps.poisonCharge) then
		if ( ItemProperties.ExtraProps.poisonCharge < 4 ) then
			col = EnhancePack.DANGER_COLOR
		elseif ( ItemProperties.ExtraProps.poisonCharge <= 8 ) then
			col = EnhancePack.ALERT_COLOR
		end
		LabelSetTextColor("ArmorPropertiesUsesVal", col.r, col.g, col.b)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesUsesLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
			
		WindowSetDimensions("ArmorPropertiesUsesLabel", 200, 20)
		LabelSetText("ArmorPropertiesUsesVal", L"" .. ItemProperties.ExtraProps.poisonCharge)
		LabelSetText("ArmorPropertiesUsesLabel", FormatProperly(ItemProperties.ExtraProps.poison))
	elseif ItemProperties.ExtraProps.ammo then
		if ( ItemProperties.ExtraProps.ammo < ItemProperties.ExtraProps.ammoMax * 0.1 ) then
			col = EnhancePack.DANGER_COLOR
		elseif ( ItemProperties.ExtraProps.ammo <= ItemProperties.ExtraProps.ammoMax * 0.2 ) then
			col = EnhancePack.ALERT_COLOR
		end
		LabelSetTextColor("ArmorPropertiesUsesVal", col.r, col.g, col.b)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesUsesLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
			
		if ItemProperties.ExtraProps.ammoType == "ARCANE" then
			LabelSetText("ArmorPropertiesUsesVal", ItemProperties.ExtraProps.ammo .. L"/" .. ItemProperties.ExtraProps.ammoMax)
			LabelSetText("ArmorPropertiesUsesLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5067))
		else
			LabelSetText("ArmorPropertiesUsesVal", ItemProperties.ExtraProps.ammo .. L"/" .. ItemProperties.ExtraProps.ammoMax .. L" " .. ItemProperties.ExtraProps.ammoType)
			LabelSetText("ArmorPropertiesUsesLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5060))
		end
	else
		WindowClearAnchors("ArmorPropertiesDurabilityVal")
		InfoH = InfoH - 20
		if LabelGetText("ArmorPropertiesRACEReq") == L"" then
			if (ItemProperties.ExtraProps.content) then
				WindowAddAnchor("ArmorPropertiesDurabilityVal", "bottomright", "ArmorPropertiesSKLReq", "topright", 0, 15)
			elseif (ItemProperties.ExtraProps.strReq  > 0) then	
				WindowAddAnchor("ArmorPropertiesDurabilityVal", "bottomright", "ArmorPropertiesSTRReq", "topright", 0, 15)
			else
				WindowAddAnchor("ArmorPropertiesDurabilityVal", "bottomright", "ArmorPropertiesLine", "topright", 0, 5)
			end
			
		else
			WindowAddAnchor("ArmorPropertiesDurabilityVal", "bottomright", "ArmorPropertiesRACEReq", "topright", 0, 17)
		end
	end
	
	if ItemProperties.ExtraProps.maxDurab > 0 then
		col = {r=255,g=255,b=255}
		if ( ItemProperties.ExtraProps.curDurab < ItemProperties.ExtraProps.maxDurab * 0.2 ) then
			col = EnhancePack.DANGER_COLOR
		elseif ( ItemProperties.ExtraProps.curDurab <= ItemProperties.ExtraProps.maxDurab * 0.4) then
			col = EnhancePack.ALERT_COLOR
		end
		
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesDurabilityLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("ArmorPropertiesDurabilityVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		
		LabelSetTextColor("ArmorPropertiesDurabilityVal", col.r, col.g, col.b)		
		LabelSetText("ArmorPropertiesDurabilityVal", ItemProperties.ExtraProps.curDurab .. L" / " ..  ItemProperties.ExtraProps.maxDurab)
	
	
		
		LabelSetText("ArmorPropertiesDurabilityLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5049))
	else
		InfoH = InfoH - 20
		WindowClearAnchors("ArmorPropertiesWeightVal")
		if (ItemProperties.ExtraProps.uses or ItemProperties.ExtraProps.ammo or ItemProperties.ExtraProps.poisonCharge) then
			WindowAddAnchor("ArmorPropertiesWeightVal", "bottomright", "ArmorPropertiesUsesVal", "topright", 0, 0)
		else
			if LabelGetText("ArmorPropertiesRACEReq") == L"" then
				if (ItemProperties.ExtraProps.content) then
					WindowAddAnchor("ArmorPropertiesWeightVal", "bottomright", "ArmorPropertiesSKLReq", "topright", 0, 15)
				elseif (ItemProperties.ExtraProps.strReq  > 0) then	
					WindowAddAnchor("ArmorPropertiesWeightVal", "bottomright", "ArmorPropertiesSTRReq", "topright", 0, 15)
				else
					WindowAddAnchor("ArmorPropertiesWeightVal", "bottomright", "ArmorPropertiesLine", "topright", 0, 5)
				end
			else
				WindowAddAnchor("ArmorPropertiesWeightVal", "bottomright", "ArmorPropertiesRACEReq", "topright", 0, 17)
			end
		end
		
	end
	
	if ItemProperties.ExtraProps.weight > 0 then
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesWeightVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("ArmorPropertiesWeightLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("ArmorPropertiesWeightVal", ItemProperties.ExtraProps.weight .. L" " .. GetStringFromTid(1044514))
		LabelSetText("ArmorPropertiesWeightLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5050))
	else
		InfoH = 0
	end
	
	if ItemProperties.ExtraProps.intensity and ItemProperties.ExtraProps.intensity > 0 and ItemProperties.ExtraProps.unravelInto and ItemProperties.ExtraProps.unravelInto ~= L"" then
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("ArmorPropertiesImbuingVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("ArmorPropertiesImbuingLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("ArmorPropertiesUnravelVal", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetFont("ArmorPropertiesUnravelLabel", "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText("ArmorPropertiesImbuingVal", L"~" .. ItemProperties.ExtraProps.intensity)
		LabelSetText("ArmorPropertiesImbuingLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5051))
		
		LabelSetText("ArmorPropertiesUnravelVal", ItemProperties.ExtraProps.unravelInto)
		LabelSetText("ArmorPropertiesUnravelLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5052))
	else
		if (LabelGetText("ArmorPropertiesSTRReq") == L"" and LabelGetText("ArmorPropertiesRACEReq") == L"" and LabelGetText("ArmorPropertiesSKLReq") == L"") then
			InfoH = InfoH - 30
		else
			InfoH = InfoH - 40
		end
	end
	
	
	
	-- Marks: Brittle, Imbued, Cannot Be Repaired, Faction Item, Quest Item, Ephemeral, locked down
	-- (MAX 4)
	
	local mark = 0
	local marksH = 20
	
	if (ItemProperties.ExtraProps.lockedDown) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			if LabelGetText("ArmorPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		LabelSetTextColor("Marks" .. mark, EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)	
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetText("Marks" .. mark, FormatProperly(ItemProperties.ExtraProps.lockedDown))
		local w, h = WindowGetDimensions("Marks" .. mark)	
		marksH = marksH + h
	end
	
	if (ItemProperties.ExtraProps.altered) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			if LabelGetText("ArmorPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		LabelSetTextColor("Marks" .. mark, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)	
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1111880)))
		local w, h = WindowGetDimensions("Marks" .. mark)	
		marksH = marksH + h
	end
	
	if (ItemProperties.ExtraProps.factionItem) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			if LabelGetText("ArmorPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		LabelSetTextColor("Marks" .. mark, EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)	
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1041350)))
		local w, h = WindowGetDimensions("Marks" .. mark)	
		marksH = marksH + h
	end
	if (ItemProperties.ExtraProps.questItem) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			if LabelGetText("ArmorPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.ARTIFACT_COLOR.r, EnhancePack.ARTIFACT_COLOR.g, EnhancePack.ARTIFACT_COLOR.b)		
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1072351)))
		local w, h = WindowGetDimensions("Marks" .. mark)	
		marksH = marksH + h
	end
	if (ItemProperties.ExtraProps.ephemeral) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			if LabelGetText("ArmorPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1152714)))
		local w, h = WindowGetDimensions("Marks" .. mark)	
		marksH = marksH + h
	end
	if (ItemProperties.ExtraProps.brittle) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			if LabelGetText("ArmorPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1116209)))
		local w, h = WindowGetDimensions("Marks" .. mark)	
		marksH = marksH + h
	end
	
	if (ItemProperties.ExtraProps.cannotrepair) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			if LabelGetText("ArmorPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.DANGER_COLOR.r, EnhancePack.DANGER_COLOR.g, EnhancePack.DANGER_COLOR.b)
		LabelSetText("Marks" .. mark, FormatProperly(GetStringFromTid(1151782)))
		local w, h = WindowGetDimensions("Marks" .. mark)	
		marksH = marksH + h
	end
	
	if (ItemProperties.ExtraProps.imbued) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			if LabelGetText("ArmorPropertiesLayer") == L"" then
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesInnerFrame", "topright", -10, 5)
			else
				WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
			end
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("Marks" .. mark, UI.GetCliloc(SystemData.Settings.Language.type,5053))
		local w, h = WindowGetDimensions("Marks" .. mark)	
		marksH = marksH + h
	end
	
	if (ItemProperties.ExtraProps.reforged) then
		mark = mark + 1
		CreateWindowFromTemplate("Marks" .. mark, "ItemSpecialPropDef_RightAlign", "ArmorProperties")
		if mark == 1 then
			WindowAddAnchor("Marks" .. mark, "bottomright", "ArmorPropertiesLayer", "topright", 0, 0)
		else
			WindowAddAnchor("Marks" .. mark, "bottomright", "Marks" .. mark - 1, "topright", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Marks" .. mark, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Marks" .. mark, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("Marks" .. mark, FormatProperly(ItemProperties.ExtraProps.reforged))
	end
	ItemProperties.ExtraProps.marks = mark
	
	if SetsH <= 20 then
		SetsH = 0
	end
	
	if PropsH <= 15 and marksH <= 20 then
		PropsH = 0
	end
	
	
	
	
	-- Status: Insured, Blessed, Cursed, Blessed For, owned by, no-trade
	-- (MAX 3)
	
	local status = 0

	if (ItemProperties.ExtraProps.price and ItemProperties.ExtraProps.price ~= L"") then
		
		local lines = BookTemplate.Commalines(WStringToString(ItemProperties.ExtraProps.price))
		
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "ArmorProperties")
		WindowAddAnchor("status" .. status, "bottomleft", "ArmorPropertiesLine", "topleft", -10, 5)
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.TITLE_COLOR.r, EnhancePack.TITLE_COLOR.g, EnhancePack.TITLE_COLOR.b)		
		LabelSetText("status" .. status, towstring(lines[1]))
		
		if towstring(lines[2]) ~= "" then
			status = status + 1
			CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "ArmorProperties")
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
			if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
				LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end	
			LabelSetTextColor("status" .. status, EnhancePack.TITLE_COLOR.r, EnhancePack.TITLE_COLOR.g, EnhancePack.TITLE_COLOR.b)		
			LabelSetText("status" .. status, towstring(lines[2]))
		end
	end
	
	if (ItemProperties.ExtraProps.insured) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "ArmorProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "ArmorPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(GetStringFromTid(1114311)))
	end
	
	if (ItemProperties.ExtraProps.blessed) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "ArmorProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "ArmorPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(GetStringFromTid(1038021)))
	end
	
	if (ItemProperties.ExtraProps.ownedBy) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "ArmorProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "ArmorPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(ItemProperties.ExtraProps.ownedBy))
	end
	
	if (ItemProperties.ExtraProps.blessedFor) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "ArmorProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "ArmorPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(ItemProperties.ExtraProps.blessedFor))
	end
	
	if (ItemProperties.ExtraProps.cursed) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "ArmorProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "ArmorPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(GetStringFromTid(1049643)))
	end
	
	if (ItemProperties.ExtraProps.notrade) then
		status = status + 1
		CreateWindowFromTemplate("status" .. status, "ItemSpecialPropDef_LeftAlign", "ArmorProperties")
		if status == 1 then
			WindowAddAnchor("status" .. status, "bottomleft", "ArmorPropertiesLine", "topleft", -10, 5)
		else
			WindowAddAnchor("status" .. status, "bottomleft", "status" .. status - 1, "topleft", 0, 0)
		end
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("status" .. status, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("status" .. status, EnhancePack.MAGICPROP_COLOR.r, EnhancePack.MAGICPROP_COLOR.g, EnhancePack.MAGICPROP_COLOR.b)
		LabelSetText("status" .. status, FormatProperly(GetStringFromTid(1076255)))
	end

	local statusH = 5 + (20 * (status ))
	ItemProperties.ExtraProps.status = status
	
	
	-- set the bottom dockspot position
	
	
	if ( #ItemProperties.ExtraProps.props > 0 ) then
		if #ItemProperties.ExtraProps.setData > 0 then
			WindowAddAnchor("ArmorPropertiesBottomDockspot", "bottomleft", "set" .. #ItemProperties.ExtraProps.setData .. "Prop", "topleft", 0, 20)	
		else
			WindowAddAnchor("ArmorPropertiesBottomDockspot", "bottomleft", "prop" .. #ItemProperties.ExtraProps.props .. "Prop", "topleft", 0, 20)	
		end
		if (LabelGetText("ArmorPropertiesSTRReq") == L"" and LabelGetText("ArmorPropertiesRACEReq") == L"" and LabelGetText("ArmorPropertiesSKLReq") == L"") then
			LineH = LineH + 20
		else
			LineH = LineH + 11
		end
	else
		if #ItemProperties.ExtraProps.setData > 0 then
			WindowAddAnchor("ArmorPropertiesBottomDockspot", "bottomleft", "set" .. #ItemProperties.ExtraProps.setData .. "Prop", "topleft", 0, 20)	
		else
			if not WindowGetShowing("ArmorPropertiesElementsTable") then
				if (LabelGetText("ArmorPropertiesItemType") == L"") then
					itemTypeH = 0
					DPSH = 0
					ElmentsTableH = 0
				else
					DPSH = 0
					ElmentsTableH = 0
				end
			end

			if WindowGetShowing("ArmorPropertiesElementsTable") then
				WindowAddAnchor("ArmorPropertiesBottomDockspot", "bottomleft", "ArmorPropertiesElementsTable", "topleft", 15, PropsH + propsStartH)
				LineH = LineH + 15
			else
				if (DoesWindowNameExist("Marks" .. mark)) then
					WindowAddAnchor("ArmorPropertiesBottomDockspot", "bottomright", "Marks" .. mark, "topright", -395, propsStartH)
					if (LabelGetText("ArmorPropertiesSKLReq") == L"") then
						LineH = LineH + 25
					else
						LineH = LineH - 3
					end
				elseif (LabelGetText("ArmorPropertiesItemType") ~= L"" and LabelGetText("ArmorPropertiesLayer") == L""  and mark <= 0) then
					if (LabelGetText("ArmorPropertiesSKLReq") ~= L"") then
						LineH = LineH - 23
					end
					if (LabelGetText("ArmorPropertiesSTRReq") == L"" and LabelGetText("ArmorPropertiesRACEReq") == L"" and LabelGetText("ArmorPropertiesSKLReq") == L"") then
						if not (ItemProperties.ExtraProps.uses or ItemProperties.ExtraProps.ammo or ItemProperties.ExtraProps.poisonCharge) then
							if (LabelGetText("ArmorPropertiesItemType") == L"") then
								if statusH > 5 then
									LineH = LineH + 15
								else
									LineH = LineH + 10
								end
							end	
							WindowSetShowing("ArmorPropertiesLine", false)
						end
					end
					WindowAddAnchor("ArmorPropertiesBottomDockspot", "bottomleft", "ArmorPropertiesInnerFrame", "topleft", 40, 5)
				
				elseif (LabelGetText("ArmorPropertiesLayer") ~= L"" or (LabelGetText("ArmorPropertiesItemType") ~= L"") and statusH > 5) then
					WindowAddAnchor("ArmorPropertiesBottomDockspot", "bottomright", "ArmorPropertiesLayer", "topright", -395, propsStartH)
					if (LabelGetText("ArmorPropertiesSKLReq") == L"") then
						LineH = LineH + 15
					else
						LineH = LineH - 3
					end
				else	
					
					if (LabelGetText("ArmorPropertiesSKLReq") ~= L"") then
						LineH = LineH - 23
					end
					if (LabelGetText("ArmorPropertiesSTRReq") == L"" and LabelGetText("ArmorPropertiesRACEReq") == L"" and LabelGetText("ArmorPropertiesSKLReq") == L"") then
						if not (ItemProperties.ExtraProps.uses or ItemProperties.ExtraProps.ammo or ItemProperties.ExtraProps.poisonCharge) then
							if (LabelGetText("ArmorPropertiesItemType") == L"") then
								if statusH > 5 then
									LineH = LineH + 15
								else
									LineH = LineH + 10
								end
							end	
							WindowSetShowing("ArmorPropertiesLine", false)
						end
					end
					WindowAddAnchor("ArmorPropertiesBottomDockspot", "bottomleft", "ArmorPropertiesInnerFrame", "topleft", 40, 5)
				end
				
			end
		end
	end	
	

	
	-- DESCRIPTIONS
	
	local DescH  = 10
	for i = 1, #ItemProperties.ExtraProps.descs do
		CreateWindowFromTemplate("Desc" .. i, "ItemDescriptionDef", "ArmorProperties")
		if i == 1 then
			if ItemProperties.ExtraProps.intensity and ItemProperties.ExtraProps.intensity > 0 and ItemProperties.ExtraProps.unravelInto and ItemProperties.ExtraProps.unravelInto ~= L"" then
				WindowAddAnchor("Desc" .. i, "bottomright", "ArmorPropertiesUnravelVal", "topright", -10, 5)
				InfoH = InfoH + 5
			else
				if InfoH - statusH > 5 then
					WindowAddAnchor("Desc" .. i, "bottomright", "ArmorPropertiesWeightVal", "topright", -10, 5)
				else
					WindowAddAnchor("Desc" .. i, "bottomright", "ArmorPropertiesWeightVal", "topright", -10, statusH - 15)
				end
			end			
		else
			WindowAddAnchor("Desc" .. i, "bottomleft", "Desc" .. i - 1, "topleft", 0, 8)
			DescH = DescH + 8
		end
		
		local prop = ItemProperties.ExtraProps.descs[i]
		if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
			LabelSetFont("Desc" .. i, "UO_DefaultText_ASIA_18", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end	
		LabelSetTextColor("Desc" .. i, prop.color.r, prop.color.g, prop.color.b)
		LabelSetText("Desc" .. i, prop.original)
		local w, h = WindowGetDimensions("Desc" .. i)	
		DescH = DescH + h
	end

	if InfoH < statusH then
		InfoH = statusH
	end

	-- RESIZING WINDOW
	local nc, ArmorNameBlockH = WindowGetDimensions("ArmorPropertiesInnerFrame")
	
	if (ItemProperties.ExtraProps.uses or ItemProperties.ExtraProps.ammo or ItemProperties.ExtraProps.poisonCharge)  then
		
		WindowSetShowing("ArmorPropertiesLine", true)
		if ( #ItemProperties.ExtraProps.props <= 0 and not ItemProperties.ExtraProps.content and not ItemProperties.ExtraProps.lockedDown ) then
			WindowSetShowing("ArmorPropertiesLine", false)
		elseif ItemProperties.ExtraProps.weight <= 0 then
			InfoH = InfoH + 20
		end
	end
	
	if #ItemProperties.ExtraProps.descs == 0 then
		DescH = 0
		if InfoH <= 20 and #ItemProperties.ExtraProps.descs == 0 then
			InfoH = 0
			WindowSetShowing("ArmorPropertiesLine", false)
		end
	end
	
	
	local BottomMargin = 10
	local RequirementsH = 0
	if LabelGetText("ArmorPropertiesRACEReq") ~= L"" then
		if RequirementsH == 0 then
			RequirementsH = RequirementsH + 20
		end
		local w, h = WindowGetDimensions("ArmorPropertiesRACEReq")
		RequirementsH = RequirementsH + h
	end
	if LabelGetText("ArmorPropertiesSTRReq") ~= L"" then
		if RequirementsH == 0 then
			RequirementsH = RequirementsH + 20
		end
		local w, h = WindowGetDimensions("ArmorPropertiesRACEReq")
		RequirementsH = RequirementsH + h
	end	
	if LabelGetText("ArmorPropertiesSKLReq") ~= L"" then
		if RequirementsH == 0 then
			RequirementsH = RequirementsH + 20
		end
		local w, h = WindowGetDimensions("ArmorPropertiesRACEReq")
		RequirementsH = RequirementsH + h
	end	

	y = ArmorNameBlockH + itemTypeH + DPSH + ElmentsTableH + PropsH + SetsH + RequirementsH + LineH + InfoH + DescH + BottomMargin
	
	local width, nc = WindowGetDimensions("ArmorProperties")
	
	WindowSetDimensions("ArmorProperties", width, y)
	
	WindowForceProcessAnchors("ArmorProperties")
	
	
	if not WindowGetShowing("ItemProperties") then

		-- SHOWS WINDOW
		WindowSetDimensions("ItemProperties", width, y)
		
		local scaleFactor = 1/InterfaceCore.scale	
		
		if not EnhancePack.PropsSlot then
			windowOffset = 16
			
			mouseX = SystemData.MousePosition.x
			propWindowX = mouseX - windowOffset - (width / scaleFactor)
			if propWindowX < 0 then
				propWindowX = mouseX + windowOffset
			end
				
			mouseY = SystemData.MousePosition.y
			propWindowY = mouseY - windowOffset - (y / scaleFactor)
			if propWindowY < 0 then
				propWindowY = mouseY + windowOffset
			end

			WindowSetOffsetFromParent("ItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)
		else
			local props = "Hotbar"..EnhancePack.PropsSlot.HotbarID.."Button"..EnhancePack.PropsSlot.SlotID
			windowOffset = WindowGetDimensions(props) / 2
			local x, y = WindowGetScreenPosition (props)

			x = (x + windowOffset) - (width / scaleFactor)
			y = (y + windowOffset) - (y / scaleFactor)
			
			WindowSetOffsetFromParent("ItemProperties", x*scaleFactor, y*scaleFactor)
		end
		WindowSetShowing("ItemPropertiesWindowBackground", false)
		WindowSetShowing("ItemPropertiesFrame", false)
		WindowSetShowing("ItemProperties", true)
	end
	EnhancePack.ItmPrpShowing = true
end


function ItemProperties.PopulateWindow(labelText,labelColors,labelFont)
	ItemProperties.ClearWindow()
--[[
	if (WindowData.ItemProperties.CurrentHover ~= 0) then
		local item = WindowData.ObjectInfo[WindowData.ItemProperties.CurrentHover]
		if (ItemProperties.PDollItemData) then
			item = ItemProperties.PDollItemData
		end
		if item then
			Debug.Print(item.objectType)
		end
	end
--]]

	if (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM) then
		if (EnhancePack.ToggleNewLayout and #labelText > 1) then --and not ItemProperties.CurrentItemData.itemLoc) then
			if (ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_WEAPON) then
				ItemProperties.ShowWeaponProps()
				return
			elseif (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM and not EnhancePack.CurrentOnIsMobile) then
				ItemProperties.ShowArmorProps()
				return
			end
		end
	end
	
	if #labelText == 1 then
		labelColors[1] = EnhancePack.TITLE_COLOR
	end
	
	local propWindowWidth = 100
	local propWindowHeight = 4
	
	local numLabels = #labelText
	
	local lblhgt = 0
	for i = 1, numLabels do
		labelName = "ItemPropertiesItemLabel"..i
		if i == 1 then
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			WindowAddAnchor(labelName, "top", "ItemProperties", "top", 0, 5)
			
			if (numLabels > 1) then
				CreateWindowFromTemplate("ItemPropertiesItemLabelspace", "ItemPropItemDef", "ItemProperties")
				WindowAddAnchor("ItemPropertiesItemLabelspace", "bottom", labelName, "top", 0, -12)
				LabelSetText("ItemPropertiesItemLabelspace", L" ")
			end
			LabelSetFont(labelName, ItemProperties.GetFont("bold"), WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		else
			if not labelFont[i] then
				labelFont[i] = ItemProperties.GetFont("normal")
			end
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			LabelSetFont(labelName, labelFont[i], WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText(labelName, labelText[i])
		
		LabelSetTextColor(labelName, labelColors[i].r, labelColors[i].g, labelColors[i].b)
		w, h = LabelGetTextDimensions(labelName)
		lblhgt = h + 5.2
		
		if ( i == 1) then
			lblhgt = lblhgt + 5
		else
			WindowClearAnchors( labelName )
			local anchor = "ItemPropertiesItemLabel"..i-1
			if (i==2) then
				anchor = "ItemPropertiesItemLabelspace"
			end
			if ( labelFont[i-1] == ItemProperties.GetFont("small")) then
				lblhgt = h + 7
				
				WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 7)
			elseif ( labelFont[i-1] == "font_verdana_bold") then
				lblhgt = h + 2
				WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 2)
			else
				lblhgt = h + 5
				WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 5)
			end
		end
		propWindowWidth = math.max(propWindowWidth, w)
		propWindowHeight = propWindowHeight + lblhgt -- Allow for spacing
		WindowSetShowing(labelName, true)
	end
	propWindowWidth = propWindowWidth + 12
	if ( numLabels > 1 ) then
		propWindowHeight = propWindowHeight + 8 
	else
		propWindowHeight = propWindowHeight + 3
	end
	WindowSetDimensions("ItemProperties", propWindowWidth, propWindowHeight)
	
	
	scaleFactor = 1/InterfaceCore.scale	
		
	if not EnhancePack.PropsSlot then
		windowOffset = 16
		
		mouseX = SystemData.MousePosition.x
		propWindowX = mouseX - windowOffset - (propWindowWidth / scaleFactor)
		if propWindowX < 0 then
			propWindowX = mouseX + windowOffset
		end
			
		mouseY = SystemData.MousePosition.y
		propWindowY = mouseY - windowOffset - (propWindowHeight / scaleFactor)
		if propWindowY < 0 then
			propWindowY = mouseY + windowOffset
		end

		WindowSetOffsetFromParent("ItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)
	else
		local props = "Hotbar"..EnhancePack.PropsSlot.HotbarID.."Button"..EnhancePack.PropsSlot.SlotID
		windowOffset = WindowGetDimensions(props) / 2
		local x, y = WindowGetScreenPosition (props)

		x = (x + windowOffset) - (propWindowWidth / scaleFactor)
		y = (y + windowOffset) - (propWindowHeight / scaleFactor)
		
		WindowSetOffsetFromParent("ItemProperties", x*scaleFactor, y*scaleFactor)
	end
	WindowSetShowing("ItemPropertiesWindowBackground", true)
	WindowSetShowing("ItemPropertiesFrame", true)
	WindowSetShowing("ItemProperties", true)
	EnhancePack.ItmPrpShowing = true
	
end
function ItemProperties.ItemTypeFinalizer(props, itemKind, range, medable)
	local wfind = wstring.find

	local imbued = false
	local exceptional = false
	local speed
	local ssi = 0
	local dmg
	local dinc = 0
	for i = 1, #props do
		if props[i] == "" or props[i] == L"" then
			table.remove(props, i)
		end	
		
	end
	local isWeapon = false
	
	for i = 1, #props do
		local lprop = wstring.lower(props[i])
		if (type(lprop) == "string") then
            continue
        end
        -- ITEM FIX
        local di = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
		if (wfind(lprop,di) and not wfind(lprop, L"%%") and itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON) then
			itemKind = ItemPropertiesEvaluator.TYPE_WEAPON
		end
		
		if (wfind(lprop, wstring.lower(wstring.gsub(GetStringFromTid(1061169), ItemPropertiesEvaluator.escape2, L"")))) then
			range = wstring.gsub(lprop, wstring.lower(wstring.gsub(GetStringFromTid(1061169), ItemPropertiesEvaluator.escape2, L"")), L"")
		end
		
		if (wfind(lprop,GetStringFromTid(1060437))) then
			itemKind = ItemPropertiesEvaluator.TYPE_ARMOR
		end
		
		if (wfind(lprop,GetStringFromTid(1060482)) and itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON and itemKind ~= ItemPropertiesEvaluator.TYPE_SKIP and itemKind ~= ItemPropertiesEvaluator.TYPE_WEARABLE) then
			itemKind = ItemPropertiesEvaluator.TYPE_SHIELD
		end 
		
		if lprop == wstring.lower(GetStringFromTid(1080418)) then -- "(imbued)"
			imbued = true
		end
		
		if wstring.lower(lprop) == GetStringFromTid(1060636) then -- L"exceptional"
			exceptional = true
		end
		if wstring.lower(lprop) == GetStringFromTid(1060437)  then -- L"mage armor"
			medable = true
		end 
		
		m_start, m_end = wfind(lprop, wstring.gsub(GetStringFromTid(1061167), ItemPropertiesEvaluator.escape2, L""))
		if m_start and not wfind(lprop, L"%%") then
			speed = wstring.sub(lprop, m_end+1)
			isWeapon = true
		end
		local ssa = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
		if (wstring.find(wstring.lower(lprop),ssa) and wfind(wstring.lower(lprop), L"%%")) then
			m_start, m_end = wfind(wstring.lower(lprop),ssa)
			lprop = L"swing speed increase " .. wstring.sub(lprop, m_end+1)
		end
		m_start, m_end = wfind(lprop, L"swing speed increase")
		if m_start then
			lprop = wstring.gsub(lprop, L"%%", L"")
			ssi = tonumber(tostring(wstring.sub(lprop, m_end+2))) or 0
		end
		
		m_start, m_end = wfind(lprop, wstring.gsub(GetStringFromTid(1061168), ItemPropertiesEvaluator.escape3, L""))
		if m_start and not wfind(lprop, L"%%") then
			local wd = wstring.gsub(GetStringFromTid(1061168), ItemPropertiesEvaluator.escape3, L"")
			lprop = wstring.gsub(lprop, wd, L"")
			dmg = ItemProperties.SeparaMin(tostring(lprop))
		end
		
		local sdi = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
		local din = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
		if (wfind(lprop,din) and wfind(lprop, L"%%")) and not wfind(lprop, sdi) then
			di = wstring.gsub(lprop, L"%%", L"")
			di = wstring.gsub(di, din, L"")
			dinc = tonumber(tostring(di))
		end
		 
		if ( wfind(lprop, GetStringFromTid(502006)) ) then -- "(tame)"
			itemKind = ItemPropertiesEvaluator.TYPE_PET
		end
		
		if ( wfind(lprop, GetStringFromTid(1049608))  ) then -- "(bonded)"
			itemKind = ItemPropertiesEvaluator.TYPE_PET
		end
	end
	if (not isWeapon and itemKind == ItemPropertiesEvaluator.TYPE_WEAPON) then
		itemKind = ItemPropertiesEvaluator.TYPE_SKIP
	end
	if (isWeapon and itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON) then
		itemKind = ItemPropertiesEvaluator.TYPE_WEAPON
	end
	return itemKind, range, medable, imbued, exceptional, speed, ssi, dmg, dinc
end

function ItemProperties.GetIntensity(lprop, value, ranged, itemKind, itemTypeName, speed, ssi, raceItem)
	local v = ItemPropertiesEvaluator.Mods[lprop]
	if not v then
		return
	end
	if (v.func and v.func=="LEECH_RANGE") then
		local range
		range = (speed * 2500) / (100 + ssi)
		if ranged then 
			range = range / 2 
		end
		local wgt = 0
		local perc = math.min(math.floor(value / range * 100),100)
		if (v.weight and perc > 0 ) then
			wgt = math.ceil(v.weight *perc)
		end
		return perc , math.floor(range), wgt
	else
		local possibleRange
		if itemKind == ItemPropertiesEvaluator.TYPE_JEWEL and v.jewelrange ~= nil then
			possibleRange = v.jewelrange
		elseif ranged and v.bowrange ~= nil then
			possibleRange = v.bowrange
		else 
			possibleRange = v.range
		end	

		if ( lprop == GetStringFromTid(1062755) ) then
			possibleRange = -21
			if (value == -29) then
				perc = 0
			elseif (value == -21) then
				perc = 100
			else
				perc = (30+value) * 10
			end
			if (v.weight and (perc > 0 or (lprop == L"luck"))) then
				wgt = math.ceil(v.weight *perc)
			end
			return perc, possibleRange, wgt
		end
				
		if (itemKind == ItemPropertiesEvaluator.TYPE_ARMOR) then
			local armor = ItemPropertiesEvaluator.ArmorNames[itemTypeName]
			if (raceItem == 3) then
				armor = ItemPropertiesEvaluator.GargArmorNames[itemTypeName]
			end
			
			if armor then
				local physical = L"physical resist"
				local fire = L"fire resist"
				local cold = L"cold resist"
				local poison = L"poison resist"
				local energy = L"energy resist"

				if (v.en == physical or v.en == fire or v.en ==  cold or v.en == poison or v.en == energy) and armor[v.en] then
					value = value - armor[v.en]
					local wgt = 0
					local perc = math.floor((value / possibleRange) * 100)
					wgt = math.ceil(v.weight *perc)
					return perc, possibleRange + armor[v.en], wgt, armor[v.en]
				end
			end
		end
		
		if (itemKind == ItemPropertiesEvaluator.TYPE_SHIELD) then
			local armor = ItemPropertiesEvaluator.ShieldNames[itemTypeName]
			
			if armor then
				local physical = L"physical resist"
				local fire = L"fire resist"
				local cold = L"cold resist"
				local poison = L"poison resist"
				local energy = L"energy resist"

				if (v.en == physical or v.en == fire or v.en ==  cold or v.en == poison or v.en == energy) and armor[v.en] then
					value = value - armor[v.en]
					local wgt = 0
					local perc = math.floor((value / possibleRange) * 100)
					wgt = math.ceil(v.weight *perc)
					return perc, possibleRange + armor[v.en], wgt, armor[v.en]
				end
			end
		end

		if possibleRange ~= "" then
			local wgt = 0
			local perc = math.floor((value / possibleRange) * 100)
			if (v.weight and (perc > 0 or (lprop == L"luck"))) then
				wgt = math.ceil(v.weight *perc)
			end
			return perc, possibleRange, wgt
		else
			
			local wgt = 0
			local perc = 100
			if (v.weight and (perc > 0 or (lprop == L"luck"))) then
				wgt = math.ceil(v.weight *perc)
			end
			return 100, possibleRange, wgt
		end
	end
	
end

function ItemProperties.PropsExpander(props, itemKind, itemTypeName, ranged, speed, ssi, raceItem, damage, damInc, colors)
	-- all the name in the array are the index in itemproperties.mods
	-- Special names: STRREQ, WEIGHT, MISC, ITEMNAME, CONTENT, ENGRAVE, SPECIALBLUE, SMALL
	local expProps = {}
	
	local arti = false
	local sets = false
	poffable = true

	local factionItem = false
	local questItem = false
	local ephemeral = false
	local totalResist = 0
	
	local lockedDown
	
	local DPSChange = 0
	
	local uses
		
	local wfind = wstring.find
	if (props[1] and wstring.lower(props[1]) == GetStringFromTid(1098104)) then -- Sign

		if (props[2] and wstring.lower(props[2]) == wstring.lower(GetStringFromTid(1038021))) then -- Blessed

			if (props[4] and wstring.lower(props[4]) == GetStringFromTid(501643)) then -- Locked Down

				local message = L""
				for j = 5, #props do
					if (wfind(props[j], L"%[") ) then
						local text = wstring.gsub(props[j], L"%[", L"")
						text = wstring.gsub(text, L"%]", L"")
						if (message ~= L"") then
							message = message .. L"\n" .. text
						else
							message = text
						end
					end
				end

				props = {}
				table.insert(props, message)
			end
		end
	end
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
		local summBall = wstring.sub(wstring.lower(GetStringFromTid(1054131)), 1, wfind(wstring.lower(GetStringFromTid(1054131)), L":") - 1)
		if (wfind(wstring.lower(props[1]), summBall)) then
			local org = wstring.lower(props[1])
			local substr = wstring.gsub(org, summBall, L"")
			props[1] = FormatProperly(summBall)
			substr = wstring.gsub(substr, L"[[]", L"\n")
			substr = wstring.gsub(substr, L"[]]", L"")
			substr = BookTemplate.Commalines(WStringToString(substr))
			
			substr[2] = string.sub(substr[2], 1, -3)
			table.insert(props, towstring(substr[2]))
			table.insert(props, towstring(substr[3]))
		end 
	end
	
	local SetStart = false
	for i = 1, #props do
		local col
		if not colors or type(colors[i]) ~= "table" or colors[i] == ItemProperties.BODY_COLOR  then
			col = EnhancePack.BODY_COLOR
		else
			col = colors[i]
		end
		
		if i == 1 then	
			col = EnhancePack.PLAIN_COLOR 
			local p = Shopkeeper.stripFirstNumber(props[i])	
			local l = wstring.len(props[i]) - wstring.len(p)
			if (l > 0) then
				local txt = wstring.sub(props[i], 0, l)
				txt= wstring.gsub(txt, L"%,", L"")
				if (tonumber(txt) and tonumber(txt) > 0) then
					props[i] = WindowUtils.AddCommasToNumber(txt) .. L" " .. p
				end
			end
			if (IsArtifact(props[i], id, props)) then
				col = EnhancePack.ARTIFACT_COLOR 
				arti = true
			end
			
			if (IsReplica(props[i])) then
				col = EnhancePack.ARTIFACT_COLOR 
			end
			
			if (IsSet(props[i], id, props)) then
				col = EnhancePack.SET_COLOR 
				sets = true
			end
		
			expProps[1] = {original=props[i], name=L"ITEMNAME", value=0, color=col, font=ItemProperties.GetFont("normal")}
			continue
		end
			
		local lprop = wstring.lower(props[i])
		
		
		local yes = wstring.lower(GetStringFromTid(1116031)) -- Yes
		local no = wstring.lower(GetStringFromTid(1116032)) -- No
		local none = wstring.lower(GetStringFromTid(1116033)) --  : None
		local clean = wstring.lower(GetStringFromTid(1116025)) -- Cleaned: ~1_VALUE~
		clean = wstring.gsub(clean, L"~1_value~", L"")
		if (wfind(lprop,clean)) then
			local val = wstring.gsub(lprop, clean, L"")
			if val == no then
				col = EnhancePack.DANGER_COLOR
			else
				col = EnhancePack.ESSENCE_COLOR
			end
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		local charged = wstring.lower(GetStringFromTid(1116026)) -- Charged: ~1_VALUE~
		charged = wstring.gsub(charged, L"~1_value~", L"")
		if (wfind(lprop,charged)) then
			local val = wstring.gsub(lprop, charged, L"")
			if val == no then
				col = EnhancePack.DANGER_COLOR
			else
				col = EnhancePack.ESSENCE_COLOR
			end
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		local ammos = wstring.lower(GetStringFromTid(1116027)) -- Ammo: ~1_VALUE~
		ammos = wstring.gsub(ammos, L"~1_value~", L"")
		if (wfind(lprop,ammos)) then
			
			local val = wstring.gsub(lprop, ammos, L"")
			if val == none then
				col = EnhancePack.DANGER_COLOR
			else
				col = EnhancePack.ESSENCE_COLOR
			end
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		local primed = wstring.lower(GetStringFromTid(1116028)) -- Primed: ~1_VALUE~
		primed = wstring.gsub(primed, L"~1_value~", L"")
		if (wfind(lprop,primed)) then
			local val = wstring.gsub(lprop, primed, L"")
			if val == no then
				col = EnhancePack.DANGER_COLOR
			else
				col = EnhancePack.ESSENCE_COLOR
			end
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		local ammos = wstring.lower(GetStringFromTid(1116027)) -- Ammo: ~1_VALUE~
		ammos = wstring.gsub(ammos, L"~1_value~", L"")
		if (wfind(lprop,ammos)) then
			
			local val = wstring.gsub(lprop, ammos, L"")
			if val == none then
				col = EnhancePack.DANGER_COLOR
			else
				col = EnhancePack.ESSENCE_COLOR
			end
			
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end

		local state = wstring.lower(GetStringFromTid(1116580)) -- State: Pristine
		if (wfind(lprop,state)) then
			col = EnhancePack.ESSENCE_COLOR
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		state = wstring.lower(GetStringFromTid(1116581)) -- State: Slightly Damaged
		if (wfind(lprop,state)) then
			col = {r=248,g=287, b=5}
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		state = wstring.lower(GetStringFromTid(1116582)) -- State: Moderately Damaged
		if (wfind(lprop,state)) then
			col = EnhancePack.ALERT_COLOR
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		state = wstring.lower(GetStringFromTid(1116583)) -- State: Heavily Damaged
		if (wfind(lprop,state)) then
			col = EnhancePack.DANGER_COLOR
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		state = wstring.lower(GetStringFromTid(1116584)) -- State: Extremely Damaged
		if (wfind(lprop,state)) then
			col = EnhancePack.DANGER_COLOR
			expProps[i] = {original=props[i], name=L"CANNON", value=val, color=col, font=fnt }
			continue
		end
		
		local mining = wstring.gsub(wstring.lower(GetStringFromTid(1062005)), L"+~1_val~", L"") -- mining bonus +~1_val~
		if (wfind(lprop,mining)) then
			uses = wstring.gsub(lprop, mining, L"")
			expProps[i] = {original=props[i], name=L"MINING", value=val, color=col, font=fnt }
			continue
		end
		
		mining = wstring.gsub(wstring.lower(GetStringFromTid(1078828)), L"+~1_val~", L"") -- mining +~1_val~
		if (wfind(lprop,mining)) then
			uses = wstring.gsub(lprop, mining, L"")
			expProps[i] = {original=props[i], name=L"MINING", value=val, color=col, font=fnt }
			continue
		end
		
		
		local bd = wstring.sub(wstring.lower(GetStringFromTid(1151553)), 1, wfind(wstring.lower(GetStringFromTid(1151553)), L"<br>") -1) -- Activate: Bard Mastery Bonus x2 <br> (Effect: 1 min. Cooldown: 30 min.)
		if (wfind(lprop,bd)) then
			expProps[i] = {original=props[i], name=L"DESC", value=val, color=EnhancePack.SpecialColor, font=fnt }
			continue
		end
		
		local sp = wstring.gsub(wstring.lower(GetStringFromTid(1072376)), L"~1_val~", L"") -- Part of an Armor Set (~1_val~ pieces)
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			sp = wstring.sub(sp, 1, wfind(sp, L"[(]") -1)
		end
		local sp2 = wstring.gsub(wstring.lower(GetStringFromTid(1073491)), L"~1_val~", L"") -- Part of a Weapon/Armor Set (~1_val~ pieces)
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			sp2 = wstring.sub(sp2, 1, wfind(sp2, L"[(]") -1)
		end
		local sp3 = wstring.gsub(wstring.lower(GetStringFromTid(1080240)), L"~1_val~", L"") -- Part of a Jewelry Set (~1_val~ pieces)
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			sp3 = wstring.sub(sp3, 1, wfind(sp3, L"[(]") -1)
		end
		
		if (wfind(lprop, sp) or wfind(lprop, sp2) or wfind(lprop, sp3)) then
			expProps[i] = {original=props[i], name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")}
			table.insert(ItemProperties.ExtraProps.setData, {original=props[i], name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")})
			continue
		end
		
		local st = wstring.gsub(wstring.lower(GetStringFromTid(1072378)), L"<br>", L"") -- Only when full set is present:
		if (wfind(lprop, st) ) then
			col = EnhancePack.ALERT_COLOR
			table.insert(ItemProperties.ExtraProps.setData, {original=FormatProperly(st), name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")}	)
			expProps[i] = {original=FormatProperly(st), name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")}			
			expProps[1] = {original=props[1], name=L"ITEMNAME", value=0, color=EnhancePack.SET_COLOR , font=ItemProperties.GetFont("normal")}
			SetStart = true
			continue
		end
		
		st = wstring.lower(GetStringFromTid(1072377)) -- Full Armor Set Present
		sp =  wstring.lower(GetStringFromTid(1073492)) -- Full Weapon/Armor Set Present
		sp2 =  wstring.lower(GetStringFromTid(1080241)) -- Full Jewelry Set Present
		if (wfind(lprop, st) or wfind(lprop, sp) or wfind(lprop, sp2)) then 
			col = EnhancePack.ALERT_COLOR
			table.insert(ItemProperties.ExtraProps.setData, {original=props[i], name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")})
			expProps[i] = {original=props[i], name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")}
			expProps[1] = {original=props[1], name=L"ITEMNAME", value=0, color=EnhancePack.SET_COLOR , font=ItemProperties.GetFont("normal") }
			SetStart = true
			continue
		end
		
		st = wstring.gsub(wstring.lower(GetStringFromTid(1074325)), L"~1_val~", L"")
		st = wstring.gsub(st, L"%%", L"")
		
		if ( wfind(lprop, L"[(]") or wfind(lprop, st)) and SetStart then
			table.insert(ItemProperties.ExtraProps.setData, {original=props[i], name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")})
			expProps[i] = {original=props[i], name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")}
			continue
		end
		
		if ( wfind(lprop, L"[(]") or wfind(lprop, L"[+]")) and SetStart then
			table.insert(ItemProperties.ExtraProps.setData, {original=props[i], name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")})
			expProps[i] = {original=props[i], name=L"SETDATA", value=0, color=col, font=ItemProperties.GetFont("normal")}
			continue
		end
		
		local found
		for skill=0,59 do -- all skills
			local skillName = L""
			if skill == 58 then
				skillName = L"masonry"
			elseif skill == 59 then
				skillName = L"glassblowing"
			else
				skillName = wstring.lower(WindowData.SkillList[skill].skillName)
			end
			local bonus = wstring.gsub(wstring.lower(GetStringFromTid(1072394)), L"~2_val~%%", L"") -- ~1_NAME~ Bonus: ~2_val~%
			local excBonus = wstring.gsub(wstring.lower(GetStringFromTid(1072395)), L"~2_val~%%", L"") -- ~1_NAME~ Exceptional Bonus: ~2_val~%
			bonus = ReplaceTokens(bonus, {skillName} )
			excBonus = ReplaceTokens(excBonus, {skillName} )

			if wfind(lprop, excBonus) then
				local val = wstring.gsub(lprop, excBonus, L"")
				val = wstring.gsub(val, L"%%", L"")
				
				local rebuild = ReplaceTokens(wstring.lower(GetStringFromTid(1072395)), {skillName, val} )
				
				if lprop == rebuild then				
					local perc = math.floor((val / 30) * 100)
					local wgt = 0
					if (perc > 0)  then
						wgt = math.ceil(1 *perc)
					end
					if EnhancePack.IntensityInfo then
						local gb = math.floor(2.55 * perc)
						if gb > 255 then
							gb = 255
						end
						if perc >= 100 then
							col = EnhancePack.ARTIFACT_COLOR
						else
							local r = 0
							local g = 0
							local b = 0
							if (EnhancePack.EXTRAINFO.r > 0)  then
								r = gb
							end
							if (EnhancePack.EXTRAINFO.g > 0) then
								g = gb
							end
							if (EnhancePack.EXTRAINFO.b > 0) then
								b = gb
							end
							col = {r=r, g=g, b=b}
						end
					end
					if not EnhancePack.ToggleNewLayout and EnhancePack.IntensityInfo then
						expProps[i] = {original=props[i] .. L" {" .. UI.GetCliloc(SystemData.Settings.Language.type, 877) .. L"30}", name=L"TALIBONUS", value=val, intensity=perc, totWeight=wgt, cap=30, color=col, font=fnt }
					else
						expProps[i] = {original=props[i], name=L"TALIBONUS", value=val, intensity=perc, totWeight=wgt, cap=30, color=col, font=fnt }
					end
					
					found = true
					break
				end
			end
			if wfind(lprop, bonus) then
				local val = wstring.gsub(lprop, bonus, L"")
				val = wstring.gsub(val, L"%%", L"")
				local rebuild = ReplaceTokens(wstring.lower(GetStringFromTid(1072394)), {skillName, val} )
				if lprop ~= rebuild then
					continue
				end
				
				local perc = math.floor((val / 30) * 100)
				local wgt = 0
				if (perc > 0)  then
					wgt = math.ceil(1 *perc)
				end
				if EnhancePack.IntensityInfo then
					local gb = math.floor(2.55 * perc)
					if gb > 255 then
						gb = 255
					end
					if perc >= 100 then
						col = EnhancePack.ARTIFACT_COLOR
					else
						local r = 0
						local g = 0
						local b = 0
						if (EnhancePack.EXTRAINFO.r > 0)  then
							r = gb
						end
						if (EnhancePack.EXTRAINFO.g > 0) then
							g = gb
						end
						if (EnhancePack.EXTRAINFO.b > 0) then
							b = gb
						end
						col = {r=r, g=g, b=b}
					end
				end
				if not EnhancePack.ToggleNewLayout and EnhancePack.IntensityInfo then
					expProps[i] = {original=props[i] .. L" {" .. UI.GetCliloc(SystemData.Settings.Language.type, 877) .. L"30}", name=L"TALIBONUS", value=val, intensity=perc, totWeight=wgt, cap=30, color=col, font=fnt }
				else
					expProps[i] = {original=props[i], name=L"TALIBONUS", value=val, intensity=perc, totWeight=wgt, cap=30, color=col, font=fnt }
				end
				found = true
				break
			end
			
		end
		if found then
			
			continue
		end

		local tid = wstring.gsub(wstring.lower(GetStringFromTid(1043305)), L"\"~1_desc~\"", L"") -- Seller's Description: ~1_DESC~
		tid = wstring.gsub(tid, L"<br>", L"")
		if (wfind(lprop,tid)) then
			local prop = wstring.gsub(wstring.lower(props[i]), tid, L"")
			prop = wstring.gsub(prop, L"<br>", L"")
			prop = tid .. L"\n" .. prop
			expProps[i] = {original=prop, name=L"DESC", value=val, color=EnhancePack.SpecialColor, font=fnt }
			continue
		end
		
		
		tid = wstring.lower(wstring.gsub(GetStringFromTid(1154175), L" ~1_COUNT~", L""))
		local cle = wstring.gsub(lprop, tid, L"")
		cle= wstring.gsub(cle, L"%%", L"")
		cle = wstring.gsub(wstring.gsub(lprop, L"%%", L""), cle, L"")
		if (cle == tid  ) then -- Heavy Powder Charges: ~1_COUNT~
			expProps[i] = {original=props[i], name=L"MISC", value=val, color=col, font=fnt }
			continue
		end
		
		local mod = L""
		local val
		for q=1017324, 1017340 do
			local tid = wstring.gsub(wstring.lower(GetStringFromTid(q)), L"~1_val~", L"")
			if (wfind(wstring.lower(props[i]), tid)) then
				mod = L"CHARGES"
				val = wstring.gsub(wstring.lower(props[i]), tid, L"")
				break
			end
		end
		for q=1060487, 1060492 do
			local tid = wstring.gsub(wstring.lower(GetStringFromTid(q)), L"~1_val~", L"")
			if (wfind(wstring.lower(props[i]), tid)) then
				mod = L"CHARGES"
				val = wstring.gsub(wstring.lower(props[i]), tid, L"")
				break
			end
		end
		
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1017347)), L"~1_val~", L"")
		if (wfind(wstring.lower(props[i]), tid)) then
			mod = L"CHARGES"
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
		end
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1017348)), L"~1_val~", L"")
		if (wfind(wstring.lower(props[i]), tid)) then
			mod = L"CHARGES"
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
		end
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1017350)), L"~1_val~", L"")
		if (wfind(wstring.lower(props[i]), tid)) then
			mod = L"CHARGES"
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
		end
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1017371)), L"~1_val~", L"")
		if (wfind(wstring.lower(props[i]), tid)) then
			mod = L"CHARGES"
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
		end

		
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1072853)), L"~1_val~", L"") -- darkglow poison charges: ~1_val~
		if (wfind(wstring.lower(props[i]), tid)) then
			mod = L"POISONCHARGES"
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
		end
		
		
		if mod ~= L"" then
			expProps[i] = {original=props[i], name=mod, value=val, cap=0, color=EnhancePack.MAGICPROP_COLOR, font=ItemProperties.GetFont("normal")}
			continue
		end
		
		if (wfind(lprop,L"a recall rune")) then
			local newtext = wstring.gsub(props[i], L"A Recall Rune For", L"")
			newtext = L"A Recall Rune For:\"" .. newtext .. L"\""
			expProps[i] = {original=newtext, name=L"DESC", value=val, color=col, font=fnt }
			continue
		end
		
		local reforge = wstring.lower(GetStringFromTid(1152281)) -- : Reforged (Minor)
		if (lprop == reforge) then
			ItemProperties.ExtraProps.reforged = lprop
			
			expProps[i] = {original=props[i], name=L"MISC", value=val, color=col, font=fnt }
			continue
		end
		
		reforge = wstring.lower(GetStringFromTid(1152282)) -- : Reforged (Lesser)
		if (lprop == reforge) then
			ItemProperties.ExtraProps.reforged = lprop
			expProps[i] = {original=props[i], name=L"MISC", value=val, color=col, font=fnt }
			continue
		end
		
		reforge = wstring.lower(GetStringFromTid(1152283)) -- : Reforged (Greater)
		if (lprop == reforge) then
			ItemProperties.ExtraProps.reforged = lprop
			expProps[i] = {original=props[i], name=L"MISC", value=val, color=col, font=fnt }
			continue
		end
		
		reforge = wstring.lower(GetStringFromTid(1152284)) -- : Reforged (Major)
		if (lprop == reforge) then
			ItemProperties.ExtraProps.reforged = lprop
			expProps[i] = {original=props[i], name=L"MISC", value=val, color=col, font=fnt }
			continue
		end
		
		reforge = wstring.lower(GetStringFromTid(1152285)) -- : Reforged (Legendary)
		if (lprop == reforge) then
			ItemProperties.ExtraProps.reforged = lprop
			expProps[i] = {original=props[i], name=L"MISC", value=val, color=col, font=fnt }
			continue
		end
		
		local use = wstring.lower(wstring.gsub(GetStringFromTid(1061639), L"~1_NAME~", L"")) -- name: ~1_NAME~
		if (wfind(lprop,use)) then
			ItemProperties.ExtraProps.engraveText = wstring.gsub(wstring.lower(props[i]), use, L"")
			expProps[i] = {original=props[i], name=L"ENGRAVE", value=val, color=EnhancePack.ENGRAVE_COLOR, font=ItemProperties.GetFont("normal") }
			continue
		end
		
		use = wstring.lower(wstring.gsub(GetStringFromTid(1112590), ItemPropertiesEvaluator.escape2, L"")) -- Gorgon Lens Charges: ~1_val~
		if (wfind(lprop,use)) then
			ItemProperties.ExtraProps.uses = wstring.gsub(lprop, use, L"")
			expProps[i] = {original=props[i], name=L"GORGON", value=val, color=col, font=fnt }
			continue
		end
		
		use = wstring.lower(wstring.gsub(GetStringFromTid(1060584), ItemPropertiesEvaluator.escape2, L"")) -- uses remaining: ~1_val~
		if (wfind(lprop,use)) then
			ItemProperties.ExtraProps.uses = wstring.gsub(lprop, use, L"")
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		use = wstring.lower(wstring.gsub(GetStringFromTid(1076207), L"~1_val~", L"")) -- Remaining Charges: ~1_val~
		if (wfind(lprop,use)) then
			ItemProperties.ExtraProps.uses =  wstring.gsub(lprop, use, L"")
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		use = wstring.lower(wstring.gsub(GetStringFromTid(1075217), L"~1_val~", L"")) -- ~1_val~ charges remaining
		if (wfind(lprop,use)) then
			ItemProperties.ExtraProps.uses =  wstring.gsub(lprop, use, L"")
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		use = wstring.lower(GetStringFromTid(1061837)) -- arcane charges: ~1_val~ / ~2_val~
		use = wstring.gsub(use, L"~1_val~ / ~2_val~", L"")
		if (wfind(lprop,use)) then
			
			local clean = wstring.gsub(lprop, use, L"")
			val = wstring.sub(clean, 1,  wfind(clean, L"/") -2)
			cap = wstring.sub(clean, wfind(clean, L"/") +2)
			ItemProperties.ExtraProps.ammo = tonumber(val)
			ItemProperties.ExtraProps.ammoMax = tonumber(cap)
			ItemProperties.ExtraProps.ammoType = "ARCANE"
			expProps[i] = {original=props[i], name=L"ARCANE", value=tonumber(val), cap=tonumber(cap), color=col, font=fnt }
			continue
		end
		

		local found = false
		for q=1062412, 1062416 do
			local tid = wstring.gsub(wstring.lower(GetStringFromTid(q)), L"~1_val~", L"")
			local val = wstring.gsub(wstring.lower(props[i]), tid, L"")
			if (wfind(wstring.lower(props[i]), tid) and tonumber(val) and tonumber(val) > 0) then
				ItemProperties.ExtraProps.poison = tid
				ItemProperties.ExtraProps.poisonCharge = tonumber(val)
				expProps[i] = {original=props[i], name=L"SKIP", value=tonumber(val), color=col, font=fnt }
				found = true
				break
			end
		end
		if found then
			continue
		end
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1072852)), L"~1_val~", L"") -- parasitic poison charges: ~1_val~
		if (wfind(wstring.lower(props[i]), tid)) then
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
			ItemProperties.ExtraProps.poison = tid
			ItemProperties.ExtraProps.poisonCharge = tonumber(val)
			expProps[i] = {original=props[i], name=L"SKIP", value=tonumber(val), color=col, font=fnt }
			continue
		end
		
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1072853)), L"~1_val~", L"") -- darkglow poison charges: ~1_val~
		if (wfind(wstring.lower(props[i]), tid)) then
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
			ItemProperties.ExtraProps.poison = tid
			ItemProperties.ExtraProps.poisonCharge = tonumber(val)
			expProps[i] = {original=props[i], name=L"SKIP", value=tonumber(val), color=col, font=fnt }
			continue
		end
		
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1150101)), L"~1_val~", L"") -- Treasure Maps: ~1_val~
		if (wfind(wstring.lower(props[i]), tid)) then
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
			ItemProperties.ExtraProps.poison = tid
			ItemProperties.ExtraProps.poisonCharge = tonumber(val)
			expProps[i] = {original=props[i], name=L"SKIP", value=tonumber(val), color=col, font=fnt }
			continue
		end
		
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1150102)), L"~1_val~", L"") -- Seeds: ~1_val~
		if (wfind(wstring.lower(props[i]), tid)) then
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
			ItemProperties.ExtraProps.poison = tid
			ItemProperties.ExtraProps.poisonCharge = tonumber(val)
			expProps[i] = {original=props[i], name=L"SKIP", value=tonumber(val), color=col, font=fnt }
			continue
		end
		
		tid = wstring.gsub(wstring.lower(GetStringFromTid(1150103)), L"~1_val~", L"") -- Messages in Bottles: ~1_val~
		if (wfind(wstring.lower(props[i]), tid)) then
			val = wstring.gsub(wstring.lower(props[i]), tid, L"")
			ItemProperties.ExtraProps.poison = tid
			ItemProperties.ExtraProps.poisonCharge = tonumber(val)
			expProps[i] = {original=props[i], name=L"SKIP", value=tonumber(val), color=col, font=fnt }
			continue
		end
		
		use = wstring.lower(wstring.gsub(GetStringFromTid(1060741), ItemPropertiesEvaluator.escape2, L"")) -- Charges: ~1_val~
		if (wfind(lprop,use)) then
			ItemProperties.ExtraProps.uses = towstring(tonumber(tostring(wstring.gsub(lprop, use, L""))))
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		use = wstring.lower(wstring.gsub(GetStringFromTid(1062925), L"~1_COUNT~", L"")) -- Petals:  ~1_COUNT~
		if (wfind(lprop,use)) then
			ItemProperties.ExtraProps.uses = wstring.gsub(lprop, use, L"")
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		local text = wstring.find(wstring.lower(props[i]) ,wstring.lower(wstring.sub(EnhancePack.GetStringFromTid(1061078), 1, - 8))) --  "Artifact Rarity" 
		if text then
			expProps[i] = {original=props[i], name=L"ARTIFACTRARITY", value=0, color=col, font=fnt}
			continue
		end
	

		

		local arrows = wstring.lower(GetStringFromTid(1075265)) -- Ammo: ~1_QUANTITY~/~2_CAPACITY~ arrows
		arrows = wstring.gsub(arrows, L"~1_quantity~", L"")
		arrows = wstring.gsub(arrows, L"~2_capacity~", L"")
		local arrow1 = wstring.sub(arrows, 1,  wfind(arrows, L"/") -1)
		local arrow2 = wstring.sub(arrows, wfind(arrows, L"/") +1)
		if (wfind(lprop,arrow1) and wfind(lprop,arrow2)) then
			
			local clean = wstring.gsub(lprop, arrow1, L"")
			clean = wstring.gsub(clean, arrow2, L"")
			val = wstring.sub(clean, 1,  wfind(clean, L"/") -1)
			cap = wstring.sub(clean, wfind(clean, L"/") +1)

			ItemProperties.ExtraProps.ammo = tonumber(val)
			ItemProperties.ExtraProps.ammoMax = tonumber(cap)
			ItemProperties.ExtraProps.ammoType = FormatProperly(GetStringFromTid(1023905))
			expProps[i] = {original=props[i], name=L"ARROWS", value=tonumber(val), cap=tonumber(cap), color=col, font=fnt }
			continue
		end
		
		local bolts = wstring.lower(GetStringFromTid(1075266)) -- Ammo: ~1_QUANTITY~/~2_CAPACITY~ bolts
		bolts = wstring.gsub(bolts, L"~1_quantity~", L"")
		bolts = wstring.gsub(bolts, L"~2_capacity~", L"")
		local arrow1 = wstring.sub(bolts, 1,  wfind(bolts, L"/") -1)
		local arrow2 = wstring.sub(bolts, wfind(bolts, L"/") +1)
		if (wfind(lprop,arrow1) and wfind(lprop,arrow2)) then
			
			local clean = wstring.gsub(lprop, arrow1, L"")
			clean = wstring.gsub(clean, arrow2, L"")
			val = wstring.sub(clean, 1,  wfind(clean, L"/") -1)
			cap = wstring.sub(clean, wfind(clean, L"/") +1)
			ItemProperties.ExtraProps.ammo = tonumber(val)
			ItemProperties.ExtraProps.ammoMax = tonumber(cap)
			ItemProperties.ExtraProps.ammoType = UI.GetCliloc(SystemData.Settings.Language.type, 5059)
			expProps[i] = {original=props[i], name=L"BOLTS", value=tonumber(val), cap=tonumber(cap), color=col, font=fnt }
			continue
		end
		
		if (lprop == wstring.lower(GetStringFromTid(501643)) or lprop == wstring.lower(GetStringFromTid(501644))) then -- Locked Down, locked down and secure
			ItemProperties.ExtraProps.lockedDown = lprop
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end

		local sdi = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
		if (wfind(lprop,sdi) and wfind(lprop, L"%%")) then
			m_start, m_end = wfind(lprop,sdi)
			local intens, max, wgt = ItemProperties.GetIntensity(L"sdi", tonumber(wstring.sub(lprop, m_end+1)), ranged, itemKind, itemTypeName, speed, ssi, raceItem)
			expProps[i] = {original=props[i], name=L"sdi", value=tonumber(wstring.sub(lprop, m_end+1)), intensity=intens, cap=max, totWeight=wgt, color=col, font=ItemProperties.GetFont("normal") }
			continue
		end
		
		local di = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
		if (wfind(lprop,di) and wfind(lprop, L"%%")) then
			m_start, m_end = wfind(lprop,di)
			local intens, max, wgt = ItemProperties.GetIntensity(L"damage increase", tonumber(wstring.sub(lprop, m_end+1)), ranged, itemKind, itemTypeName, speed, ssi, raceItem)
			expProps[i] = {original=props[i], name=L"damage increase", value=tonumber(wstring.sub(lprop, m_end+1)), en = L"damage chance increase", intensity=intens, cap=max, totWeight=wgt, color=col, font=ItemProperties.GetFont("normal") }
			continue
		end
		
		local sssi = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
		if (wfind(lprop,sssi) and wfind(lprop, L"%%")) then
			m_start, m_end = wfind(lprop,sssi)
			local intens, max, wgt = ItemProperties.GetIntensity(L"swing speed increase", tonumber(wstring.sub(lprop, m_end+1)), ranged, itemKind, itemTypeName, speed, ssi, raceItem)
			expProps[i] = {original=props[i], name=L"swing speed increase", value=tonumber(wstring.sub(lprop, m_end+1)), en = L"swing speed increase", intensity=intens, cap=max, totWeight=wgt, color=col, font=ItemProperties.GetFont("normal") }
			continue
		end

		local FC = wstring.lower(wstring.gsub(GetStringFromTid(1060413), ItemPropertiesEvaluator.escape2, L""))
		local FCR = wstring.lower(wstring.gsub(GetStringFromTid(1060412), ItemPropertiesEvaluator.escape2, L""))
		if (wfind(lprop, FC)  ) then
			if (wfind(lprop, FCR) == nil ) then
				m_start, m_end = wfind(lprop,FC)
				local intens, max, wgt = ItemProperties.GetIntensity(L"faster casting", tonumber(wstring.sub(lprop, m_end+1)), ranged, itemKind, itemTypeName, speed, ssi, raceItem)
				expProps[i] = {original=props[i], name=L"faster casting", value=tonumber(wstring.sub(lprop, m_end+1)), intensity=intens, cap=max, totWeight=wgt, color=col, font=ItemProperties.GetFont("normal") }
				continue
			end
		end
		
		if (lprop == wstring.lower(GetStringFromTid(1112075)) or lprop == wstring.lower(GetStringFromTid(1061172)) or lprop == wstring.lower(GetStringFromTid(1061173)) or lprop == wstring.lower(GetStringFromTid(1061174)) or lprop == wstring.lower(GetStringFromTid(1061175))) and ItemProperties.ExtraProps.skillReq == L"" then -- skill required: throwing, swords, mace, fencing, arcery, ubws
			ItemProperties.ExtraProps.skillReq = props[i]
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		if lprop == wstring.lower(GetStringFromTid(1060400)) then
			ItemProperties.ExtraProps.skillReq = props[i]
		end
		
		local strBonus = wstring.lower(wstring.gsub(GetStringFromTid(1060485), ItemPropertiesEvaluator.escape2, L""))
		if (wfind(lprop, strBonus)  and SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			if (wfind(lprop, L"+") == nil ) then
				m_start, m_end = wfind(lprop,strBonus)
				local val = tonumber(wstring.sub(lprop, m_end+1))
				if tonumber(WindowData.PlayerStatus["Strength"]) < val then
					col = EnhancePack.DANGER_COLOR
				end
				strReq = val
				expProps[i] = {original=props[i], name=L"STRREQ", value=val, color=col, font=ItemProperties.GetFont("normal")}
				continue
			end
		else
			strBonus = wstring.lower(wstring.gsub(GetStringFromTid(1061170), ItemPropertiesEvaluator.escape2, L""))
			if (wfind(lprop, strBonus)) then
				m_start, m_end = wfind(lprop,strBonus)
				local val = tonumber(wstring.sub(lprop, m_end+1))
				if tonumber(WindowData.PlayerStatus["Strength"]) < val then
					col = EnhancePack.DANGER_COLOR
				end
				ItemProperties.ExtraProps.strReq = val
				expProps[i] = {original=props[i], name=L"STRREQ", value=val, color=col, font=ItemProperties.GetFont("normal")}
				continue
			end
		end
		
		
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			text = string.find(WStringToString(props[i]) ,string.sub(WStringToString(EnhancePack.GetStringFromTid(1060410)), 1,10) ) -- "Durability " 
		elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
			text = string.find(WStringToString(props[i]) ,string.sub(WStringToString(GetStringFromTid(1060410)), 1,4) ) -- "Durability " 
				
		elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
			text = wfind(props[i] ,wstring.sub(GetStringFromTid(1060410), 1,4))  -- "Durability "
		end
		
		if ( text ~= nil) then
			local complete 
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
				complete = wstring.sub(props[i], 12)
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
				complete = wstring.sub(props[i], text + 5)
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
				complete = wstring.sub(props[i], text + 4)
			end
			text = string.find(WStringToString(complete) , "/")
			if ( text ~= nil) then

				txt = wstring.sub(complete,1, text )
				local actual = tonumber(txt)
				txt = wstring.sub(complete,text+1)
				local max = tonumber(txt) 
				if ( tonumber(actual) < max * 0.2 ) then
					col = EnhancePack.DANGER_COLOR
				elseif ( tonumber(actual) <= max * 0.4) then
					col = EnhancePack.ALERT_COLOR
				end
				ItemProperties.ExtraProps.curDurab = actual
				ItemProperties.ExtraProps.maxDurab = max
				expProps[i] = {original=props[i], name=L"DURABILITY", value=actual, cap=max, color=col, font=ItemProperties.GetFont("normal")}
				continue

			end
		end
		
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			text = string.find(WStringToString(props[i]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072517)), 1, 9)) -- "Lifespan:"
		elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
			text = wfind(props[i] , wstring.sub(EnhancePack.GetStringFromTid(1072517), 1, 3)) -- "Lifespan:"
		elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
			text = wfind(props[i] , wstring.sub(EnhancePack.GetStringFromTid(1072517), 1, 3)) -- "Lifespan:"
		end
		if ( text ~= nil) then
			expProps[i] = {original=props[i], name=L"LIFESPAN", value=0, cap=0, color=col, font=ItemProperties.GetFont("normal")}
			continue
		end
		
		
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			text = string.find(WStringToString(props[i]) , string.sub(WStringToString(EnhancePack.GetStringFromTid(1072305)), 1, - 16)) -- "Engraved:"
		elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
			text = string.find(WStringToString(props[i]) ,string.sub(WStringToString(GetStringFromTid(1072305)), 1,4) ) -- "Engraved:"
				
		elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
			text = wfind(props[i] ,wstring.sub(GetStringFromTid(1072305), 1,4))  -- "Engraved:"
		end
		local frst = wstring.sub(props[i], 1, 1)
		if frst == L"\"" then
			expProps[i] = {original=props[i], name=L"ENGRAVE", value=txt, color=EnhancePack.ENGRAVE_COLOR, font=ItemProperties.GetFont("normal")}
			ItemProperties.ExtraProps.engraveText = props[i]
			continue
		elseif ( text ~= nil) then
			
			local txt = L""
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
				txt = L'"' .. wstring.sub(props[i], 11) .. L'"'
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
				txt = L'"' .. wstring.sub(props[i], 5) .. L'"'
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
				txt = L'"' ..  wstring.sub(props[i],6) .. L'"'
			end
			expProps[i] = {original=txt, name=L"ENGRAVE", value=txt, color=EnhancePack.ENGRAVE_COLOR, font=ItemProperties.GetFont("normal")}
			ItemProperties.ExtraProps.engraveText = txt
			continue
		end
		
		m_start, m_end = wfind(lprop, wstring.gsub(GetStringFromTid(1061167), ItemPropertiesEvaluator.escape2, L""))
		if m_start and not wfind(lprop, L"%%") then
			local spd = ItemProperties.GetWeaponSpeed(speed, ssi)
			expProps[i] = {original=props[i] .. L" ( " .. spd .. L"s )", name=L"MISC", value=0, color=col, font=ItemProperties.GetFont("normal")}
			continue
		end

		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
			text = string.find(WStringToString(props[i]) , string.sub(WStringToString(GetStringFromTid(1072225)), 1, -13)) -- "Weight:" 
		elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			text = wfind(props[i] , wstring.sub(GetStringFromTid(1072225), 1, -19)) -- "Weight:" 
		else
			text = wfind(props[i] , wstring.sub(GetStringFromTid(1072225), 1, -11)) -- "Weight:" 
		end
		if ( text ~= nil and lprop ~= GetStringFromTid(1149699) and itemKind ~= ItemPropertiesEvaluator.TYPE_PET) then
			
			local num 
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
				num = wstring.sub(lprop, 8, -7)
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
				num = wstring.sub(lprop, 4)
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
				num = wstring.sub(lprop, 3, -2)
			end
			
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
				props[i] = StringToWString(string.sub(WStringToString(EnhancePack.GetStringFromTid(1072225)), 1, -19)) .. L" " .. WindowUtils.AddCommasToNumber(num) .. L" " .. StringToWString(string.sub(WStringToString(EnhancePack.GetStringFromTid(1072225)), -6))
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
				props[i] = wstring.sub(props[i], 1, 4) .. L" " .. WindowUtils.AddCommasToNumber(num) 
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
				props[i] = wstring.sub(props[i], 1, 1) .. L" " .. WindowUtils.AddCommasToNumber(num) 
			end
			local w = WindowData.PlayerStatus.Weight + tonumber(num)
			local mw = WindowData.PlayerStatus.MaxWeight		
			if (w >= mw) then
				col = EnhancePack.DANGER_COLOR					
			end
			ItemProperties.ExtraProps.weight = tonumber(num)
			expProps[i] = {original=props[i], name=L"WEIGHT", value=tonumber(num), color=col, font=ItemProperties.GetFont("normal")}
			continue
		elseif(itemKind == ItemPropertiesEvaluator.TYPE_PET) then
			local num 
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
				num = wstring.sub(lprop, 8, -7)
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
				num = wstring.sub(lprop, 4)
			elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
				num = wstring.sub(lprop, 3, -2)
			end
			num = tonumber(num)
			if num and num > 0 then
				num = num - 13
				props[i] = L"Weight: " .. WindowUtils.AddCommasToNumber(num) .. L"/" .. WindowUtils.AddCommasToNumber(1600).. L" Stones"
				col = EnhancePack.BODY_COLOR 
				if (num >= 1500) then 
					col = EnhancePack.DANGER_COLOR
				elseif (num > 557) then -- (570 real)
					col =  EnhancePack.ALERT_COLOR
				end	
				weight = tonumber(num)
				expProps[i] = {original=props[i], name=L"WEIGHT", value=tonumber(num), color=col, font=ItemProperties.GetFont("normal")}
				continue
			end
		end
		
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
			local cap
			if ( text ~= nil) then
				local actual =  wstring.sub(txt, 2,  text - 1)
				actual = WindowUtils.AddCommasToNumber(actual)
				local max =  wstring.sub(txt, text+1, wstring.len(txt))
				max = WindowUtils.AddCommasToNumber(max)
				props[i] = base .. actual .. L"/" .. max .. L" " .. final
				val = tonumber(actual)
				cap = tonumber(max)
			else
				props[i] = base .. WindowUtils.AddCommasToNumber(txt) .. L" " .. final
				val = tonumber(txt)
			end
			expProps[i] = {original=props[i], name=L"CONTENT", value=val, cap=cap, color=col, font=ItemProperties.GetFont("normal")}
			continue
		end
		
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN and not wfind(lprop,GetStringFromTid(1062755)) ) then
			lprop = wstring.gsub(lprop, L"%-", L"")
		end
		
		lprop = wstring.gsub(lprop, L"%[" , L"")
		lprop = wstring.gsub(lprop, L"%]" , L"")
		
		if ItemProperties.RedMods[wstring.lower(props[i])] then
			col = EnhancePack.DANGER_COLOR
		end
				
		if (lprop == wstring.lower(GetStringFromTid(1116296))) then -- * Requires the "High Seas" booster
			expProps[i] = {original=props[i], name=L"EXPREQ", value=val, color=EnhancePack.ALERT_COLOR, font=fnt }
			continue
		end
		
		if (lprop == wstring.lower(GetStringFromTid(1094732))) then -- * Requires the "Stygian Abyss" expansion
			expProps[i] = {original=props[i], name=L"EXPREQ", value=val, color=EnhancePack.ALERT_COLOR, font=fnt }
			continue
		end
		
		if (lprop == wstring.lower(GetStringFromTid(1151520))) then -- lost item (Return to gain Honesty)
			expProps[i] = {original=props[i], name=L"LOSTITEM", value=val, color=EnhancePack.ALERT_COLOR, font=fnt }
			continue
		end
		
		if lprop == wstring.lower(GetStringFromTid(1075086)) then -- "Elves Only"
			ItemProperties.ExtraProps.raceReq = 2
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		if (lprop == wstring.lower(GetStringFromTid(1111709))) then -- "Gargoyle Only"
			ItemProperties.ExtraProps.raceReq = 3
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		if (lprop == wstring.lower(GetStringFromTid(1061682)) or lprop == wstring.lower(GetStringFromTid(1114311))) then -- insured
			ItemProperties.ExtraProps.insured = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		if (lprop == wstring.lower(GetStringFromTid(1038021))) then -- blessed
			ItemProperties.ExtraProps.blessed = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
			
		
		if (lprop == wstring.lower(GetStringFromTid(1049643))) then -- cursed
			ItemProperties.ExtraProps.cursed = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		if (lprop == wstring.lower(GetStringFromTid(1076255 ))) then -- no-trade
			ItemProperties.ExtraProps.notrade = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		--[[
			1116496 : Deliver to Floating Emporium
			1116497 : Deliver to Britain
			1116498 : Deliver to Trinsic
			1116499 : Deliver to Moon Glow
			1116500 : Deliver to Skara Brae
			1116501 : Deliver to Vesper
			1116502 : Deliver to Jhelom
			1116503 : Deliver to Papua
		--]]
		local fnd = false
		for k = 1116496, 1116503 do
			local tid = wstring.lower(GetStringFromTid(k))
			if lprop == tid then
				ItemProperties.ExtraProps.engraveText = GetStringFromTid(k)
				fnd = true
				break
			end
		end
		if fnd then
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		local sr = wstring.gsub(wstring.lower(GetStringFromTid(1060450)), L"~1_val~", "") -- self repair ~1_val~
		if (wfind(lprop, sr)) then 
			expProps[i] = {original=props[i], name=L"SELFREPAIR", value=val, color=col, font=fnt }
			continue
		end
		
		local blessFor = wstring.gsub(wstring.lower(GetStringFromTid(1062203)), L"~1_name~", "") -- blessed for

		if ItemProperties.BlueMods[wstring.lower(props[i])] or wfind(lprop, blessFor) then
			col = {r=147,g=147,b=220}
			ItemProperties.ExtraProps.blessedFor = props[i]
			expProps[i] = {original=props[i], name=L"BLESSEDFOR", value=val, color=col, font=fnt }
			continue
		end
		
		blessFor = wstring.gsub(wstring.lower(GetStringFromTid(1072304)), L"~1_name~", "") -- Owned by ~1_name~
		if (wfind(lprop, blessFor)) then
			ItemProperties.ExtraProps.ownedBy = props[i]
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		if (wfind(props[i], blessFor)) then
			ItemProperties.ExtraProps.blessedFor = props[i]
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		
		if (lprop == wstring.lower(GetStringFromTid(1061171))) then -- two handed
			ItemProperties.ExtraProps.twoHanded = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		
		if lprop == wstring.lower(GetStringFromTid(1080418)) then -- "(imbued)"
			col= EnhancePack.SpecialColor
			poffable = false
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		if lprop == wstring.lower(GetStringFromTid(1116209)) then -- "Brittle"
			poffable = false
			ItemProperties.ExtraProps.brittle = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		if lprop == wstring.lower(GetStringFromTid(1151782)) then -- "Cannot Be Repaired"
			poffable = false
			ItemProperties.ExtraProps.cannotrepair = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		if lprop == wstring.lower(GetStringFromTid(1111880)) then -- "altered"
			ItemProperties.ExtraProps.altered = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		if lprop == wstring.lower(GetStringFromTid(1041350)) then -- "faction item"
			ItemProperties.ExtraProps.factionItem = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		if lprop == wstring.lower(GetStringFromTid(1072351)) then -- "quest item"
			ItemProperties.ExtraProps.questItem = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		if lprop == wstring.lower(GetStringFromTid(1152714)) then -- "ephemeral"
			ItemProperties.ExtraProps.ephemeral = true
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
				
		if ( wfind(props[i] , GetStringFromTid(1075086)) and WindowData.PlayerStatus["Race"] ~= 2 ) then
			col = EnhancePack.DANGER_COLOR
		end
		if ( wfind(props[i] , GetStringFromTid(1111709)) and WindowData.PlayerStatus["Race"] ~= 3 ) then
			col = EnhancePack.DANGER_COLOR
		end
		
		local fnt = ItemProperties.GetFont("normal")
		if (wfind(props[i], wstring.sub(GetStringFromTid(1076217), 4) )) then -- "Year Veteran Reward" 
			fnt = ItemProperties.GetFont("small")
		end
		
		if (props[i] == GetStringFromTid(1018303) and itemKind ~= ItemPropertiesEvaluator.TYPE_BOD) then -- "exceptional" 
			fnt = ItemProperties.GetFont("small")
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end

		local cb = wstring.lower(wstring.gsub(GetStringFromTid(1050043),L" ~1_NAME~", L""))
		if (wfind(wstring.lower(props[i]), cb)) then  --  "Crafted By "
			fnt = ItemProperties.GetFont("small")
			ItemProperties.ExtraProps.craftedBy = props[i]
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		text = wfind(wstring.lower(props[i]) ,wstring.lower(wstring.gsub(wstring.sub(GetStringFromTid(1072378), 1, -1), L"<br>", L""))) -- "Full Set"
		text = text or wfind(wstring.lower(props[i]) ,wstring.lower(wstring.sub(GetStringFromTid(1080241), 1, -1)))
		text = text or wfind(wstring.lower(props[i]) ,wstring.lower(wstring.sub(GetStringFromTid(1072377), 1, -1)))
		text = text or wfind(wstring.lower(props[i]) ,wstring.lower(wstring.sub(GetStringFromTid(1073492), 1, -1)))
		if ( text ~= nil ) then
			col = EnhancePack.ALERT_COLOR
		end
		
		-- DAMAGE
		if ( wfind(props[i] ,wstring.sub(EnhancePack.GetStringFromTid(1060403), 1, - 9) ) and not wfind(wstring.lower(props[i]), wstring.gsub(GetStringFromTid(1060442), ItemPropertiesEvaluator.escape, L""))) then
			ItemProperties.ExtraProps.physD = tostring(wstring.gsub(props[i], wstring.sub(EnhancePack.GetStringFromTid(1060403), 1, - 9),L""))
			ItemProperties.ExtraProps.physD = string.gsub(ItemProperties.ExtraProps.physD, "%%", "")
			col = EnhancePack.PHYSICAL
		end
		if ( wfind(props[i] ,wstring.sub(EnhancePack.GetStringFromTid(1060405), 1, - 9) ) ) then
			ItemProperties.ExtraProps.fireD = tostring(wstring.gsub(props[i], wstring.sub(EnhancePack.GetStringFromTid(1060405), 1, - 9),L""))
			ItemProperties.ExtraProps.fireD = string.gsub(ItemProperties.ExtraProps.fireD, "%%", "")
			col = EnhancePack.FIRE
		end
		if ( wfind(props[i] ,wstring.sub(EnhancePack.GetStringFromTid(1060404), 1, - 9) ) ) then
			ItemProperties.ExtraProps.coldD = tostring(wstring.gsub(props[i], wstring.sub(EnhancePack.GetStringFromTid(1060404), 1, - 9),L""))
			ItemProperties.ExtraProps.coldD = string.gsub(ItemProperties.ExtraProps.coldD, "%%", "")
			col = EnhancePack.COLD
		end
		if ( wfind(props[i] ,wstring.sub(EnhancePack.GetStringFromTid(1060406), 1, - 9) ) ) then
			ItemProperties.ExtraProps.poisD = tostring(wstring.gsub(props[i], wstring.sub(EnhancePack.GetStringFromTid(1060406), 1, - 9),L""))
			ItemProperties.ExtraProps.poisD = string.gsub(ItemProperties.ExtraProps.poisD, "%%", "")
			col = EnhancePack.POISON
		end
		if ( wfind(props[i] ,wstring.sub(EnhancePack.GetStringFromTid(1060407), 1, - 9) ) ) then
			ItemProperties.ExtraProps.enerD = tostring(wstring.gsub(props[i], wstring.sub(EnhancePack.GetStringFromTid(1060407), 1, - 9),L""))
			ItemProperties.ExtraProps.enerD = string.gsub(ItemProperties.ExtraProps.enerD , "%%", "")
			col = EnhancePack.ENERGY
		end
		local price = wstring.gsub(GetStringFromTid(1043304), L" ~1_COST~", L"")
		if wstring.find(wstring.lower(props[i]) , wstring.lower(price)) then
			local val = tostring(wstring.gsub(wstring.lower(props[i]), wstring.lower(price .. L" "), L""))
			val = string.gsub(val, ",", "")
			val = tonumber(val)
			if val then
				local cost = math.floor(val/500) * 3
				cost = WindowUtils.AddCommasToNumber(cost)
				props[i] = props[i] .. L"\n" .. UI.GetCliloc(SystemData.Settings.Language.type, 984)  .. cost .. L" " .. UI.GetCliloc(SystemData.Settings.Language.type, 985)
			end
			ItemProperties.ExtraProps.price = props[i]
			expProps[i] = {original=props[i], name=L"SKIP", value=val, color=col, font=fnt }
			continue
		end
		
		
		local found = false
		for mod, v in pairs(ItemPropertiesEvaluator.Mods) do
			mod = wstring.gsub(mod, L"%[" , L"")
			mod = wstring.gsub(mod, L"%]" , L"")
			mod = wstring.lower(mod)

			m_start, m_end = wfind(lprop, mod)
			if m_start then
				if (v.en == L"cursed" and lprop ~= mod) then
					continue
				end
				if(lprop == wstring.lower(GetStringFromTid(1116172))) then
					continue
				end
				
				if (wfind(lprop, L"+") and v.en==L"focused") then
					continue
				end
				
				local val = tonumber(wstring.sub(lprop, m_end+1))
				-- RESIST 
				
				if ( wfind(lprop ,wstring.gsub(GetStringFromTid(1060448), ItemPropertiesEvaluator.escape, L"") ) ) then
					local ref = wstring.gsub(GetStringFromTid(1153735), L"~1_val~%%", L"") -- physical resist ~1_val~% / ~2_symb~~3_val~% Max
					ref = wstring.gsub(ref, L"~2_symb~~3_val~%%", L"")
					ref = wstring.trim(ref)
					ref = wstring.lower(ref)
					ref = wstring.sub(ref, wfind(ref, L"/")+2)
					if (wfind(lprop, L"+") and not wfind(lprop, ref)) then
						table.insert(ItemProperties.ExtraProps.setData, {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low })
						expProps[i] = {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low }
						found = true
						break
					end
					col = EnhancePack.PHYSICAL
					ItemProperties.ExtraProps.physR = val
					if (ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON) then
						table.insert(ItemProperties.ExtraProps.resists, props[i])
					end
					totalResist = totalResist + val
					local intens, max, wgt, low = ItemProperties.GetIntensity(wstring.gsub(GetStringFromTid(1060448), ItemPropertiesEvaluator.escape, L""), val, ranged, itemKind, itemTypeName, speed, ssi, raceItem)
					expProps[i] = {original=props[i], name=v.en, value=val, intensity=intens, cap=max, totWeight=wgt, color=col, font=fnt, min=low }
					if wfind(lprop, ref) then
						local m = wstring.sub(lprop, wfind(lprop, L"/") + 2, -4)
						m = wstring.trim(wstring.gsub(m, L"%%", L""))
						ItemProperties.ExtraProps.maxresists.physical = {original=ReplaceTokens(UI.GetCliloc(SystemData.Settings.Language.type, 7018), {towstring(m)}), name="maxRes", value=tonumber(m) }
					end
					found = true
					break
				end
				if ( wfind(lprop ,wstring.gsub(GetStringFromTid(1060447), ItemPropertiesEvaluator.escape, L"")) ) then
					local ref = wstring.gsub(GetStringFromTid(1153737), L"~1_val~%%", L"") -- fire resist ~1_val~% / ~2_symb~~3_val~% Max
					ref = wstring.gsub(ref, L"~2_symb~~3_val~%%", L"")
					ref = wstring.trim(ref)
					ref = wstring.lower(ref)
					ref = wstring.sub(ref, wfind(ref, L"/")+2)
					if (wfind(lprop, L"+") and not wfind(lprop, ref)) then
						table.insert(ItemProperties.ExtraProps.setData, {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low })
						expProps[i] = {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low }
						found = true
						break
					end
					col = EnhancePack.FIRE
					ItemProperties.ExtraProps.fireR = val
					if (ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON) then
						table.insert(ItemProperties.ExtraProps.resists, props[i])
					end
					totalResist = totalResist + val
					local intens, max, wgt, low = ItemProperties.GetIntensity(wstring.gsub(GetStringFromTid(1060447), ItemPropertiesEvaluator.escape, L""), val, ranged, itemKind, itemTypeName, speed, ssi, raceItem)
					expProps[i] = {original=props[i], name=v.en, value=val, intensity=intens, cap=max, totWeight=wgt, color=col, font=fnt, min=low }
					if wfind(lprop, ref) then
						local m = wstring.sub(lprop, wfind(lprop, L"/") + 2, -4)
						m = wstring.trim(wstring.gsub(m, L"%%", L""))
						ItemProperties.ExtraProps.maxresists.fire = {original=ReplaceTokens(GetStringFromTid(1153742), {towstring(m)}), name="maxRes", value=tonumber(m) }
						
					end
					found = true
					break
				end
				if ( wfind(lprop ,wstring.gsub(GetStringFromTid(1060445), ItemPropertiesEvaluator.escape, L"") ) ) then
					local ref = wstring.gsub(GetStringFromTid(1153739), L"~1_val~%%", L"") -- cold resist ~1_val~% / ~2_symb~~3_val~% Max
					ref = wstring.gsub(ref, L"~2_symb~~3_val~%%", L"")
					ref = wstring.trim(ref)
					ref = wstring.lower(ref)
					ref = wstring.sub(ref, wfind(ref, L"/")+2)
					if (wfind(lprop, L"+") and not wfind(lprop, ref)) then
						table.insert(ItemProperties.ExtraProps.setData, {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low })
						expProps[i] = {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low }
						found = true
						break
					end
					col = EnhancePack.COLD
					ItemProperties.ExtraProps.coldR = val
					if (ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON) then
						table.insert(ItemProperties.ExtraProps.resists, props[i])
					end
					totalResist = totalResist + val
					local intens, max, wgt, low = ItemProperties.GetIntensity(wstring.gsub(GetStringFromTid(1060445), ItemPropertiesEvaluator.escape, L""), val, ranged, itemKind, itemTypeName, speed, ssi, raceItem)
					expProps[i] = {original=props[i], name=v.en, value=val, intensity=intens, cap=max, totWeight=wgt, color=col, font=fnt, min=low }
					if wfind(lprop, ref) then
						local m = wstring.sub(lprop, wfind(lprop, L"/") + 2, -4)
						m = wstring.trim(wstring.gsub(m, L"%%", L""))
						ItemProperties.ExtraProps.maxresists.cold = {original=ReplaceTokens(GetStringFromTid(1153744), {towstring(m)}), name="maxRes", value=tonumber(m) }
					end
					found = true
					break
				end
				if ( wfind(lprop ,wstring.gsub(GetStringFromTid(1060449), ItemPropertiesEvaluator.escape, L"") ) ) then
					local ref = wstring.gsub(GetStringFromTid(1153736), L"~1_val~%%", L"") -- poison resist ~1_val~% / ~2_symb~~3_val~% Max
					ref = wstring.gsub(ref, L"~2_symb~~3_val~%%", L"")
					ref = wstring.trim(ref)
					ref = wstring.lower(ref)
					ref = wstring.sub(ref, wfind(ref, L"/")+2)
					if (wfind(lprop, L"+") and not wfind(lprop, ref)) then
						table.insert(ItemProperties.ExtraProps.setData, {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low })
						expProps[i] = {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low }
						found = true
						break
					end
					col = EnhancePack.POISON
					ItemProperties.ExtraProps.poisR = val
					if (ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON) then
						table.insert(ItemProperties.ExtraProps.resists, props[i])
					end
					totalResist = totalResist + val
					local intens, max, wgt, low = ItemProperties.GetIntensity(wstring.gsub(GetStringFromTid(1060449), ItemPropertiesEvaluator.escape, L""), val, ranged, itemKind, itemTypeName, speed, ssi, raceItem)
					expProps[i] = {original=props[i], name=v.en, value=val, intensity=intens, cap=max, totWeight=wgt, color=col, font=fnt, min=low }
					if wfind(lprop, ref) then
						local m = wstring.sub(lprop, wfind(lprop, L"/") + 2, -4)
						m = wstring.trim(wstring.gsub(m, L"%%", L""))
						ItemProperties.ExtraProps.maxresists.poison = {original=ReplaceTokens(GetStringFromTid(1153741), {towstring(m)}), name="maxRes", value=tonumber(m) }
					end
					found = true
					break
				end
				if ( wfind(lprop ,wstring.gsub(GetStringFromTid(1060446), ItemPropertiesEvaluator.escape, L"") ) ) then
					local ref = wstring.gsub(GetStringFromTid(1153738), L"~1_val~%%", L"") -- energy resist ~1_val~% / ~2_symb~~3_val~% Max
					ref = wstring.gsub(ref, L"~2_symb~~3_val~%%", L"")
					ref = wstring.trim(ref)
					ref = wstring.lower(ref)
					ref = wstring.sub(ref, wfind(ref, L"/")+2)
					if (wfind(lprop, L"+") and not wfind(lprop, ref)) then
						table.insert(ItemProperties.ExtraProps.setData,{original=props[i], name=L"SETDATA", color=col, font=fnt, min=low })
						expProps[i] = {original=props[i], name=L"SETDATA", color=col, font=fnt, min=low }
						found = true
						break
					end
					col = EnhancePack.ENERGY
					ItemProperties.ExtraProps.enerR = val
					if (ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON) then
						table.insert(ItemProperties.ExtraProps.resists, props[i])
					end
					totalResist = totalResist + val
					local intens, max, wgt, low = ItemProperties.GetIntensity(wstring.gsub(GetStringFromTid(1060446), ItemPropertiesEvaluator.escape, L""), val, ranged, itemKind, itemTypeName, speed, ssi, raceItem)
					expProps[i] = {original=props[i], name=v.en, value=val, intensity=intens, cap=max, totWeight=wgt, color=col, font=fnt, min=low }
					if wfind(lprop, ref) then
						local m = wstring.sub(lprop, wfind(lprop, L"/") + 2, -4)
						m = wstring.trim(wstring.gsub(m, L"%%", L""))
						ItemProperties.ExtraProps.maxresists.energy = {original=ReplaceTokens(GetStringFromTid(1153743), {towstring(m)}), name="maxRes", value=tonumber(m) }

					end
					found = true
					break
				end
				


				if v.en == L"weapon damage" then
					local fnd = wfind(lprop, L"%%")
					if (not fnd) then
						mod = L"MISC"
						max = damage[2]
						local spd = ItemProperties.GetWeaponSpeed(speed, ssi)
						local dps = ItemProperties.GetDPS(damage, speed, ssi)
						local dpsChar = ItemProperties.GetCharacterDPS(damage, speed, ssi, damInc)
						ItemProperties.ExtraProps.DPSChange = math.floor((dpsChar - WindowData.PlayerStatus["DPS"]) * 100) / 100
						ItemProperties.ExtraProps.dps = dps 
						props[i] = props[i] .. L" (DPS: " .. dps .. L")"
						ItemProperties.ExtraProps.dps = dps
					end
				end
				local intens, max, wgt, low = ItemProperties.GetIntensity(mod, val, ranged, itemKind, itemTypeName, speed, ssi, raceItem)
				if (v.type == ItemPropertiesEvaluator.TYPE_SKIP) then
					mod = L"MISC"
					intens = 0
				end
				if (v.type == ItemPropertiesEvaluator.TYPE_SKILL) then
					mod = L"SKILL"
					intens = 0
				end
				local en = v.en

				if v.en == L"hit point regeneration" then
					en = L"hit point regen"
				elseif v.en == L"mana regeneration" then
					en = L"mana regen"			
				end
				expProps[i] = {original=props[i], name=mod, en=en , value=val, intensity=intens, cap=max, totWeight=wgt, color=col, font=fnt, min=low }
				found = true
				break
			end
		end
		if not found then
			expProps[i] = {original=props[i], name=L"MISC", value=0, color=col, font=fnt}
		end
	end
	
	return expProps, arti, sets, poffable, totalResist
end

function ItemProperties.IdentifyItemRace(props)
	local race = ItemPropertiesEvaluator.RACE_HUMAN
	if not props then
		return race
	end
	for i= 1, #props do	
		if props[i] == GetStringFromTid(1075086) then -- "Elves Only"
			return ItemPropertiesEvaluator.RACE_ELF
		end
		if (props[i] == GetStringFromTid(1111709)) then -- "Gargoyle Only"
			return ItemPropertiesEvaluator.RACE_GARGOYLE
		end
	end
	return race
end

function ItemProperties.IdentifyItem(prop, race)
	if not prop then
		return
	end
	local materialKind, materialName, itemKind, itemOrgName
	local medable = false
	local ranged = false
	
	local objectType
	local item 
	if WindowData.ItemProperties.CurrentHover ~= 0 then
		item = WindowData.ObjectInfo[WindowData.ItemProperties.CurrentHover]
	
		if (ItemProperties.PDollItemData) then
			objectType = ItemProperties.PDollItemData.objectType
		elseif (item) then
			objectType = item.objectType
		end
	end
	
	prop = wstring.lower(prop)
	
	local wfind = wstring.find
	
	materialName = L"plain"
	for type, value in pairs(ItemPropertiesEvaluator.MaterialNames) do
		if wfind(prop, type) then
			materialName = value
			break
		end
	end
	
	if wfind(prop, GetStringFromTid(1030899)) then --  L"soulstone"
		itemKind = ItemPropertiesEvaluator.TYPE_SKIP
		itemOrgName = GetStringFromTid(1030899)
		return materialKind, materialName, itemKind, itemOrgName, medable, ranged
	end
	
	if prop == GetStringFromTid(1045151) then --  L"a bulk order deed"
		itemKind = ItemPropertiesEvaluator.TYPE_BOD
		itemOrgName = GetStringFromTid(1045151)
		return materialKind, materialName, itemKind, itemOrgName, medable, ranged
	end
	
	if (prop == wstring.lower(GetStringFromTid(1094934)) ) then -- alacrity
		itemKind = ItemPropertiesEvaluator.TYPE_SKIP
		itemOrgName = GetStringFromTid(1094934)
		return materialKind, materialName, itemKind, itemOrgName, medable, ranged
	end
	
	if (prop == wstring.lower(GetStringFromTid(1154175)) ) then -- transcendence
		itemKind = ItemPropertiesEvaluator.TYPE_SKIP
		itemOrgName = GetStringFromTid(1078604)
		return materialKind, materialName, itemKind, itemOrgName, medable, ranged
	end
	
	if not itemKind then
		for name,v in pairs(ItemPropertiesEvaluator.Wearables) do
			local types = EnhancePack.Commalines(tostring(v.objectType))
			
			if objectType and types then
				for i = 1, #types do
					if ( tonumber(types[i]) == objectType) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_WEARABLE
						break
					end
				end
				if itemKind then
					break
				end
			elseif prop == wstring.lower(name) then
				itemOrgName = name
				itemKind = ItemPropertiesEvaluator.TYPE_WEARABLE
				break
			end
		end
	end
	
	if not itemKind then
		for k,v in pairs(ItemPropertiesEvaluator.IgnoreNames) do

			v = wstring.lower(v)
			local senderText = prop

			senderText = wstring.lower(senderText)
			if wfind(senderText, v) then
				itemKind = ItemPropertiesEvaluator.TYPE_SKIP
				itemOrgName = v
				return materialKind, materialName, itemKind, itemOrgName, medable, ranged
			end
		end
	end
	
	if not itemKind then
		for name,v in pairs(ItemPropertiesEvaluator.ShieldNames) do
			local types = EnhancePack.Commalines(tostring(v.objectType))
			if objectType and types then
				for i = 1, #types do
					if ( tonumber(types[i]) == objectType) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_SHIELD
						materialKind = v.m
						break
					end
				end
				if itemKind then
					break
				end
			elseif wfind(prop, wstring.lower(name)) then
				itemOrgName = name
				itemKind = ItemPropertiesEvaluator.TYPE_SHIELD
				materialKind = v.m
				break
			end
		end
	end
	
	if not itemKind then
		for name,v in pairs(ItemPropertiesEvaluator.HatNames) do
			local types = EnhancePack.Commalines(tostring(v.objectType))
			if objectType and types then
				for i = 1, #types do
					if ( tonumber(types[i]) == objectType) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_HAT
						materialKind = v.m
						medable = true
						break
					end
				end
				if itemKind then
					break
				end
			elseif wfind(prop, wstring.lower(name)) then
				itemOrgName = name
				itemKind = ItemPropertiesEvaluator.TYPE_HAT
				medable = true
				materialKind = v.m
				break
			end
		end
	end
	
	if not itemKind then
		for name,v in pairs(ItemPropertiesEvaluator.JewelryNames) do
			local types = EnhancePack.Commalines(tostring(v.objectType))
			if objectType and types then
				for i = 1, #types do
					if ( tonumber(types[i]) == objectType) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_JEWEL
						materialKind = v.m
						break
					end
				end
				if itemKind then
					break
				end
			elseif wfind(prop, wstring.lower(name)) then
				itemOrgName = name
				itemKind = ItemPropertiesEvaluator.TYPE_JEWEL
				break
			end
		end
	end
	
	if not itemKind and objectType then
		if (race == ItemPropertiesEvaluator.RACE_GARGOYLE) then
			for name,v in pairs(ItemPropertiesEvaluator.GargArmorNames) do
				local types = EnhancePack.Commalines(tostring(v.objectType))
				
				if types then
					for i = 1, #types do
						if ( tonumber(types[i]) == objectType) then
							itemOrgName = name
							itemKind = ItemPropertiesEvaluator.TYPE_ARMOR
							materialKind = v.m
							break
						end
					end
					if itemKind then
						break
					end
				end	
			end
			for name,v in pairs(ItemPropertiesEvaluator.GargMArmorNames) do
				if wfind(prop, wstring.lower(name)) then
					medable = true
					break
				end
			end
		else
			for name,v in pairs(ItemPropertiesEvaluator.ArmorNames) do
				local types = EnhancePack.Commalines(tostring(v.objectType))
				if types then
					for i = 1, #types do
						if ( tonumber(types[i]) == objectType) then
							itemOrgName = name
							itemKind = ItemPropertiesEvaluator.TYPE_ARMOR
							materialKind = v.m
							break
						end
					end
					if itemKind then
						break
					end
				end	
			end
			for name,v in pairs(ItemPropertiesEvaluator.MArmorNames) do
				if wfind(prop, wstring.lower(name)) then
					medable = true
					break
				end
			end
		end
	end
	
	if not itemKind then
		if (race == ItemPropertiesEvaluator.RACE_GARGOYLE) then
			for name,v in pairs(ItemPropertiesEvaluator.GargMArmorNames) do
				
				if wfind(prop, wstring.lower(name)) then
					itemOrgName = name
					itemKind = ItemPropertiesEvaluator.TYPE_ARMOR
					medable = true
					materialKind = v.m
					break
				end
			end
			if not itemKind then
				for name,v in pairs(ItemPropertiesEvaluator.GargNMArmorNames) do
					
					if wfind(prop, wstring.lower(name)) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_ARMOR
						medable = false
						materialKind = v.m
						break
					end
				end
			end
		else
			for name,v in pairs(ItemPropertiesEvaluator.MArmorNames) do
				
				if wfind(prop, wstring.lower(name)) then
					itemOrgName = name
					itemKind = ItemPropertiesEvaluator.TYPE_ARMOR
					medable = true
					materialKind = v.m
					break
				end
			end
			if not itemKind then
				for name,v in pairs(ItemPropertiesEvaluator.NMArmorNames) do
					
					if wfind(prop, wstring.lower(name)) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_ARMOR
						medable = false
						itemOrgName = name
						materialKind = v.m
						break
					end
				end
			end
			if not itemKind then
				for name,v in pairs(ItemPropertiesEvaluator.DragonArmorNames) do
					
					if wfind(prop, wstring.lower(name)) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_ARMOR
						medable = false
						materialKind = v.m	
						break
					end
				end
			end
		end
	end 
	
	if not itemKind then
		for name,v in pairs(ItemPropertiesEvaluator.WeaponNames) do
			
			name = wstring.lower(name)
			local m_start, m_end = wfind(prop, wstring.lower(name))
			local types = EnhancePack.Commalines(tostring(v.objectType))
			if objectType and types then
				for i = 1, #types do
					if ( tonumber(types[i]) == objectType) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_WEAPON
						materialKind = v.m
						ranged = v.isBow
						break
					end
				end
				if itemKind then
					break
				end
			elseif (prop == wstring.lower(name)) then
				itemOrgName = name
				itemKind = ItemPropertiesEvaluator.TYPE_WEAPON
				medable = false
				materialKind = v.m	
				ranged = v.isBow
				break
			elseif m_start then
				local found = false
				for name2,v2 in pairs(ItemPropertiesEvaluator.WeaponNames) do
					name2 = wstring.gsub(name2, L"%[" , L"")
					name2 = wstring.gsub(name2, L"%]" , L"")
					name2 = wstring.lower(name2)
					m_start, m_end = wfind(prop, wstring.lower(name2))
					if (m_start and name2 ~= name and wstring.len(name2) >= wstring.len(name)) then
						itemOrgName = name
						itemKind = ItemPropertiesEvaluator.TYPE_WEAPON
						medable = false
						materialKind = v.m	
						ranged = v.isBow
						found = true
						break
					end
				end
				
				if not found then
					itemOrgName = name
					itemKind = ItemPropertiesEvaluator.TYPE_WEAPON
					medable = false
					materialKind = v.m	
					ranged = v.isBow
					break
				end

			end
		end
	end
	if (itemOrgName) then
		itemOrgName = wstring.gsub(itemOrgName, L"[$]", L"")
	end
	if not itemKind then
		itemKind = ItemPropertiesEvaluator.TYPE_SKIP
	end

	if materialKind == "m" then
		materialKind = ItemPropertiesEvaluator.MATERIAL_METAL
	elseif materialKind == "l" then
		materialKind = ItemPropertiesEvaluator.MATERIAL_LEATHER
	elseif materialKind == "s" then
		materialKind = ItemPropertiesEvaluator.MATERIAL_SCALES
	elseif materialKind == "w" then
		materialKind = ItemPropertiesEvaluator.MATERIAL_WOOD
	end
	return materialKind, materialName, itemKind, itemOrgName, medable, ranged
end

function ItemProperties.GetFishInfo(props)
	local p = Shopkeeper.stripFirstNumber(props[1].original)
	
	if (IsFish(p)) then
		local col = EnhancePack.BODY_COLOR
		local FishKind = L""
		if ( EnhancePack.CrabLobster[p] ~= nil ) then
			local fnd = wstring.find(wstring.lower(p) , wstring.lower(UI.GetCliloc(SystemData.Settings.Language.type, 510)))
			if (fnd ~= nil) then
				FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 510)
			else
				FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 511)
			end
		elseif (EnhancePack.ShoreFish[p] ~= nil) then
			FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 512)
			local hueR,hueG,hueB = HueRGBAValue(391)
			col = {r= hueR, g= hueG, b= hueB}
		elseif ( EnhancePack.DeepwaterFish[p] ~= nil ) then
			FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 513)
			col= EnhancePack.SpecialColor
		elseif(EnhancePack.DungeonFish[p] ~= nil) then
			FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 514)
			col = EnhancePack.ARTIFACT_COLOR 
		elseif(EnhancePack.RareCrabLobster[p] ~= nil) then
			FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 515)
			col = EnhancePack.SET_COLOR
		elseif( EnhancePack.RareFish[p] ~= nil) then
			FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 516)
			col = EnhancePack.SET_COLOR
		end
		local data = {original=FishKind, name=L"DESC", value=0, intensity=0, cap=0, totWeight=0, color=col, font=ItemProperties.GetFont("small") }
		table.insert(props, 2, data)
		
	end
	return props
end
ItemProperties.PrintedCrateInfo = true
function ItemProperties.GetCrateFishInfo(props)
	if wstring.lower(props[1].original) == GetStringFromTid(1022473) then
		local points = 0
		for i = 1, #props do
			local lprop = props[i].original
			local text = wstring.find(lprop , L"[:]")
			if (text) then
				local fish =  wstring.sub(lprop, 0,  text - 1)
				if (IsFish(fish) ) then
					local FishKind = L""
					if (EnhancePack.ShoreFish[fish] ~= nil) then
						FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 512)
					elseif ( EnhancePack.DeepwaterFish[fish] ~= nil ) then
						FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 513)
					elseif(EnhancePack.DungeonFish[fish] ~= nil) then
						FishKind = UI.GetCliloc(SystemData.Settings.Language.type, 514)
					end
					local actpt = GetFishPoints(fish)
					text = wstring.find(lprop , L"[/]")
					local qta = wstring.sub(lprop, text+1, wstring.len(lprop))
					local qtanow = wstring.sub(lprop, text-2, text)
					if (FishKind ~= L"") then
						props[i].original = fish .. L" (" .. FishKind .. L"): " .. qtanow .. qta
					end
					if ItemProperties.PrintedCrateInfo then
						if (#props < 4) then
							EnhancePack.ChatPrint(L" --" ..UI.GetCliloc(SystemData.Settings.Language.type, 517) .. L"-- ", SystemData.ChatLogFilters.SYSTEM ) 
						end
						if (FishKind ~= L"") then
							EnhancePack.ChatPrint(L"> " .. fish .. L" (" .. FishKind .. L"): " .. L" " .. tonumber(qtanow).. L"/" .. tonumber(qta), SystemData.ChatLogFilters.SYSTEM )
						else
							EnhancePack.ChatPrint(L"> " .. fish  .. L" " .. tonumber(qtanow).. L"/" .. tonumber(qta), SystemData.ChatLogFilters.SYSTEM )
						end
					end
					props[i].cap = tonumber(qta)
					props[i].value = tonumber(qtanow)
					props[i].name = L"FISH"
					points = points + (qta * actpt)
				end
				if ( wstring.find(lprop , GetStringFromTid(1072379)) and ItemProperties.PrintedCrateInfo) then
					EnhancePack.ChatPrint(L"> " .. txt, SystemData.ChatLogFilters.SYSTEM )
				end
			end
		end
		if (points > 0) then
			if ItemProperties.PrintedCrateInfo then
				EnhancePack.ChatPrint(L"> Points: " .. math.floor(points), SystemData.ChatLogFilters.SYSTEM )
				EnhancePack.ChatPrint(L" ---------------------- ", SystemData.ChatLogFilters.SYSTEM )
			end
			local data = {original=L"Points: " .. math.floor(points), name=L"SPECIALBLUE", value=0, intensity=0, cap=0, totWeight=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
			table.insert(props, 2, data)
		end
		ItemProperties.PrintedCrateInfo = false
	end	
	return props		
end

function ItemProperties.NotorietyText(props)
	if ContainerWindow.ItemMouseOverId ~= 0 then
		return props
	end
	if ( (WindowData.ItemProperties.CustomColorTitle.NotorietyEnable) and ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM  ) then
		EnhancePack.CurrentOnIsMobile = true
		local col = NameColor.TextColors[WindowData.ItemProperties.CustomColorTitle.NotorietyIndex+1]
		props[1].color = col
		local data = {original=EnhancePack.Notoriety[WindowData.ItemProperties.CustomColorTitle.NotorietyIndex+1], name=L"NOTORIETY", value=0, color=col, font=ItemProperties.GetFont("small")}
		table.insert(props, 2, data) 
		if (wstring.find(wstring.sub(props[1].original,3), L" The ")) then
			props[1].original = wstring.gsub(props[1].original, L" The ", L"<BR>The ", 1)
		end
	end
	
	if (MobileHealthBar.mouseOverId ~= 0) then
		local text = UI.GetCliloc(SystemData.Settings.Language.type, 789)
		if(MobileHealthBar.Handled[MobileHealthBar.mouseOverId]) then
			if (not MobileHealthBar.CloseStyle) then
				text = UI.GetCliloc(SystemData.Settings.Language.type, 788)
			else
				text = UI.GetCliloc(SystemData.Settings.Language.type, 799)
			end
		end
		local data = {original=text, name=L"SMALL", value=0, color=EnhancePack.BODY_COLOR, font=ItemProperties.GetFont("small") }
		table.insert(props, data ) 
	end
	return props
end

function ItemProperties.ExtraInfo(props, medable, totalResist)

	if ( EnhancePack.ToggleExtraInfo and props[1]) then
		local value = L""
		local p = props[1].original
		p =Shopkeeper.stripFirstNumber(p)
		if wstring.lower(p) == GetStringFromTid(1024199) or wstring.lower(p) == GetStringFromTid(1027154) or wstring.lower(p) == GetStringFromTid(1027127) then -- cut leather or ingots or board
			if props[3] then
				p = props[3].original
			end
		end
		
		if (ItemsInfo.Descriptions[p]) then
			local val = wstring.gsub(ItemsInfo.Descriptions[p],L"<VALUE>", value)
			local data = {original=val, name=L"DESC", value=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
			table.insert(props, data ) 
		elseif (ItemsInfo.Descriptions[wstring.lower(p)]) then
			local val = wstring.gsub(ItemsInfo.Descriptions[wstring.lower(p)],L"<VALUE>", value)
			local data = {original=val, name=L"DESC", value=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
			table.insert(props, data )
		end
		
		local bonus = wstring.lower(wstring.gsub(GetStringFromTid(1072394), L"~1_NAME~", L""))
		bonus = wstring.gsub(bonus, L"~2_val~%%", L"")
		local exc = wstring.lower(wstring.gsub(GetStringFromTid(1072395), L"~1_NAME~", L""))
		exc = wstring.gsub(exc, L"~2_val~%%", L"")
		local skill = L""
		local engr
		local idx = 0
		for i = 1, #props do
			if (props[i].name==L"ENGRAVE" and i > 2) then
				engr = props[i]
				ItemProperties.ExtraProps.engraveText = engr.original
				idx = i
				break
			end
		end
		if (engr) then
			table.remove(props, idx)
			table.insert(props, 2, engr)
		end
		for i = 2, #props do
			
			local prop = wstring.lower(props[i].original)
			if not prop or prop == "" or prop == L"" then
				continue
			end
			if (wstring.find(prop, bonus ) and not wstring.find(prop, exc )) then
				if (skill == L"") then
					skill = wstring.sub(prop, 1, wstring.find(prop, bonus )-1)
				end
				
				bonus = tonumber(wstring.sub(prop, -3))
				
			end
			if (wstring.find(prop, exc )) then
				if (skill == L"") then
					skill = wstring.sub(prop, 1, wstring.find(prop, exc )-1)
				end
				exc = tonumber(wstring.sub(prop, -3))
				
			end
		end
		local taliValue = EnhancePack.CheckTalismanSkill(bonus, exc, skill)
		if (taliValue) then
			local data = {original=taliValue, name=L"SMALL", value=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
			table.insert(props, 2, data )
		end
		
		if medable then
			local data = {original=UI.GetCliloc(SystemData.Settings.Language.type, 518), name=L"SMALL", value=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
			table.insert(props, 2, data )
		end
		if (totalResist > 0) then
			local text = UI.GetCliloc(SystemData.Settings.Language.type, 523) .. totalResist
			local data = {original=text, name=L"SMALL", value=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
			table.insert(props, data )
		end
		
		if	(ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_JEWEL 
			and ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_ARMOR 
			and ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_SHIELD 
			and ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_HAT
			and ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_WEARABLE
			and ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON
			) then
			
			local defl = wstring.lower(ReplaceTokens(GetStringFromTid(1154124), {GetStringFromTid(1154122)})) -- Bonus Type: Deflecting
			local rein = wstring.lower(ReplaceTokens(GetStringFromTid(1154124), {GetStringFromTid(1154123)})) -- Bonus Type: Reinforced
					
			local lprop = wstring.lower(p)
			if	wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153941))) -- of Defense
			or	wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153944))) -- of Protection
			or	wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153945))) -- of Hardening
			or	wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153946))) -- of Fortification
			or	wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153947))) -- of Invulnerability
			then
				
				for i = 1, #props do
					local pr = wstring.lower(props[i].original)
					
					if pr == defl then
						local val = ""
						if wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153941))) then -- of Defense
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7034)
						elseif wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153944))) then -- of Protection
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7033)
						elseif wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153945))) then -- of Hardening
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7032)
						elseif wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153946))) then -- of Fortification
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7031)
						elseif wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153947))) then -- of Invulnerability
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7030)
						end
						if val ~= "" then
							local data = {original=val, name=L"DESC", value=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
							table.insert(props, data )
						end
						break
						
					elseif pr == rein then
						if wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153941))) then -- of Defense
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7039)
						elseif wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153944))) then -- of Protection
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7038)
						elseif wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153945))) then -- of Hardening
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7037)
						elseif wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153946))) then -- of Fortification
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7036)
						elseif wstring.find(lprop, wstring.lower(CraftingTool.GetStringFromTid(1153947))) then -- of Invulnerability
							val = UI.GetCliloc(SystemData.Settings.Language.type, 7035)
						end
						if val ~= "" then
							local data = {original=val, name=L"DESC", value=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
							table.insert(props, data )
						end
						break
					end
				end
			end
		end
	end
	return props
end
function ItemProperties.CalcUnravel(props, itemKind, material, imbued, artifact, set)
	local relic = false
	local worth = L""
	
	if itemKind ~= ItemPropertiesEvaluator.TYPE_PET 
		and itemKind ~= ItemPropertiesEvaluator.TYPE_BOD 
		and itemKind ~= ItemPropertiesEvaluator.TYPE_SKIP 
		and itemKind ~= ItemPropertiesEvaluator.TYPE_WEARABLE
		and set == false
		and EnhancePack.CurrentOnIsMobile == false
		then
		--Debug.Print(props[1].original .. L" " .. itemKind)
		worth = GetStringFromTid(1031697) --  L"Residue"
		
		local totalIntens = 0
		local totalprop = 0
		local currDura = 0
		for i = 1, #props do
			
			if (props[i].name==L"DURABILITY") then
				currDura = props[i].value
			end
			if not props[i].intensity or props[i].name ==L"MISC" then
				continue
			end
			if (props[i].intensity and (props[i].intensity >0 or props[i].name == L"luck")) then
				totalIntens = totalIntens + props[i].intensity
				totalprop = totalprop +1

			end
		end
		
		if totalIntens <= 0 then
			return props, false
		end

		if totalIntens > 0 then
			if (totalprop > 5) then
				totalIntens = math.floor(totalIntens / totalprop) * 5
			end
			local mt = material

			if (mt ~= L"plain" or not artifact) then
				local mats = ItemPropertiesEvaluator.MaterialBonus[mt]
				
				if mats ~= nil then
					totalIntens = math.floor(totalIntens * mats)
				end

			end

			if EnhancePack.UnravelChar == 2 then -- gargoyle
				totalIntens = totalIntens + 20
			end


			if EnhancePack.UnravelForge == 3 then -- queen forge
				totalIntens = totalIntens + 30
			elseif EnhancePack.UnravelForge == 2 then -- ter mur forge
				totalIntens = totalIntens + 10
			end

			local correct = 1
			if imbued then
				correct = 0.8
				if (currDura < 50) then
					local cr = 0.02 * (50-currDura)
					correct = correct - cr
				end
			end
			
			totalIntens = totalIntens * correct

			if (totalIntens > 0) then
				local col = ItemPropertiesEvaluator.LOW_INTENSITY
				
				if not artifact and not set then
					props[1].color = EnhancePack.RESIDUE_COLOR
				end
				
				if totalIntens>=ItemProperties.RelicIntensity  then
					worth =	GetStringFromTid(1031699) -- L"Relic!" 
					col = ItemPropertiesEvaluator.HIGH_INTENSITY
					if not artifact and not set then
						props[1].color = EnhancePack.RELIC_COLOR
					end
					relic = true
				elseif totalIntens > ItemProperties.EssenceIntensity then
					worth = GetStringFromTid(1031698) -- L"Essence"
					col = ItemPropertiesEvaluator.MED_INTENSITY
					if not artifact and not set then
						props[1].color = EnhancePack.ESSENCE_COLOR
					end
				end
				
				local data = {original=L"(" .. worth .. L")", name=L"SMALL", value=0, color=col, font=ItemProperties.GetFont("small") }
				table.insert(props, 2, data )
			end
		end
	end
	return props, relic, worth
end

function ItemProperties.GetLayer(itemKind, itemTypeName, twoHanded)
	if (itemKind == ItemPropertiesEvaluator.TYPE_WEAPON) then
		if (twoHanded) then
			return UI.GetCliloc(SystemData.Settings.Language.type, 5044)
		else
			return UI.GetCliloc(SystemData.Settings.Language.type, 5043)
		end
	elseif( itemKind == ItemPropertiesEvaluator.TYPE_JEWEL) then
		if (ItemPropertiesEvaluator.Rings[itemTypeName .. L"$"]) then
			return UI.GetCliloc(SystemData.Settings.Language.type, 5057) 
		elseif(ItemPropertiesEvaluator.Bracelets[itemTypeName]) then
			return UI.GetCliloc(SystemData.Settings.Language.type, 5056)
		end
	elseif( itemKind == ItemPropertiesEvaluator.TYPE_SHIELD) then
		return GetStringFromTid(1079906) -- left hand
	elseif( itemKind == ItemPropertiesEvaluator.TYPE_HAT) then
		return GetStringFromTid(1079897) -- head armor
	elseif( itemKind == ItemPropertiesEvaluator.TYPE_ARMOR) then
		if (ItemPropertiesEvaluator.ArmorNames[itemTypeName]) then
			if (ItemPropertiesEvaluator.ArmorNames[itemTypeName].layer) then
				return GetStringFromTid(ItemPropertiesEvaluator.ArmorNames[itemTypeName].layer)
			end
		end
		if (ItemPropertiesEvaluator.GargArmorNames[itemTypeName]) then
			if (ItemPropertiesEvaluator.GargArmorNames[itemTypeName].layer) then
				return GetStringFromTid(ItemPropertiesEvaluator.GargArmorNames[itemTypeName].layer)
			end
		end
	else
		if (ItemPropertiesEvaluator.Wearables[itemTypeName]) then
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 1079914) then -- robe
				return UI.GetCliloc(SystemData.Settings.Language.type, 5061) 
			end
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 1079912) then -- sash
				return UI.GetCliloc(SystemData.Settings.Language.type, 5062) 
			end
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 1079910) then -- shirt
				return UI.GetCliloc(SystemData.Settings.Language.type, 5063) 
			end
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 1079913) then -- cloak
				return UI.GetCliloc(SystemData.Settings.Language.type, 5064) 
			end
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 1079915) then -- pants
				return UI.GetCliloc(SystemData.Settings.Language.type, 5065) 
			end
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 1079908) then -- talisman
				return UI.GetCliloc(SystemData.Settings.Language.type, 5068) 
			end
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 1079903) then -- earrings
				return UI.GetCliloc(SystemData.Settings.Language.type, 5069) 
			end
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 1) then -- spellbook
				return UI.GetCliloc(SystemData.Settings.Language.type, 5043)
			end
			if (ItemPropertiesEvaluator.Wearables[itemTypeName].layer == 2) then -- fishing pole
				return UI.GetCliloc(SystemData.Settings.Language.type, 5044)
			end
			return GetStringFromTid(ItemPropertiesEvaluator.Wearables[itemTypeName].layer)
		end
	end
	return L""
end



function ItemProperties.GetSpecial(props, itemTypeName)
	local fullSpecials = L""
	local special1
	local special2
	
	if (WindowData.ItemProperties.CurrentHover ~= 0) then
		local item = WindowData.ObjectInfo[WindowData.ItemProperties.CurrentHover]
		if (ItemProperties.PDollItemData) then
			item = ItemProperties.PDollItemData
		end
		if item then
			for key, value in pairs(WindowData.WeaponAbilityDataCSV) do
				if value.objectId == item.objectType then
					special1 = value.primaryId  + CharacterAbilities.WEAPONABILITY_OFFSET
					local icon, serverId, tid, desctid, weapons = GetAbilityData(special1)
					fullSpecials = GetStringFromTid(tid)
					
					special2 = value.secondaryId  + CharacterAbilities.WEAPONABILITY_OFFSET
					icon, serverId, tid, desctid, weapons = GetAbilityData(special2)
					fullSpecials = fullSpecials .. L" | " .. GetStringFromTid(tid)
					
					local data = {original=fullSpecials, name=L"SMALL", value=0, color=EnhancePack.BODY_COLOR, font=ItemProperties.GetFont("small") }
					table.insert(props, 2, data )
					
					return props, special1, special2
				end
			end
		end
	end
	
	
	for i=1, CharacterAbilities.WEAPONABILITY_MAX do
		local abilityId = i + CharacterAbilities.WEAPONABILITY_OFFSET
		local icon, serverId, tid, desctid, weapons = GetAbilityData(abilityId)
		weapons = string.gsub(weapons,"<BR>","\n")
		weapons = BookTemplate.Commalines(weapons)

		for j = 1, #weapons do
            if itemTypeName and wstring.lower(itemTypeName) == wstring.lower(StringToWString(weapons[j])) then
				if wstring.find(fullSpecials, L"|") then
					fullSpecials = L""
				end
				if fullSpecials == L"" then
	                fullSpecials = GetStringFromTid(tid)
	                special1 = i + CharacterAbilities.WEAPONABILITY_OFFSET
                else
					fullSpecials = fullSpecials .. L" | " .. GetStringFromTid(tid)
					special2 = i + CharacterAbilities.WEAPONABILITY_OFFSET
                end
            end
        end
	end
	if fullSpecials ~= L"" then
		local data = {original=fullSpecials, name=L"SMALL", value=0, color=EnhancePack.BODY_COLOR, font=ItemProperties.GetFont("small") }
		table.insert(props, 2, data )
	end
	return props, special1, special2
end

function ItemProperties.GetIntensitiesInfo(props, poffable, arti, itemTypeName, itemKind)
	local totalIntens = 0
	local totalprop = 0
	local maxdura = 0
	local swappable = false
	local PofCharges = 0
	if itemKind == ItemPropertiesEvaluator.TYPE_SKIP or (itemKind == ItemPropertiesEvaluator.TYPE_WEARABLE and ItemProperties.ExtraProps.itemTypeName ~= GetStringFromTid(1032120)) then
		return props, totalIntens, swappable, PofCharges
	end
	for i = 1, #props do
		if (props[i].name==L"DURABILITY") then
			maxdura = props[i].cap
		end
		
		if not props[i].intensity or props[i].name ==L"MISC" then
			continue
		end
		if EnhancePack.IntensityInfo then
			gb = math.floor(2.55 * props[i].intensity)
			if gb > 255 then
				gb = 255
			end
			
			if not EnhancePack.ToggleNewLayout then
				if props[i].cap and type(props[i].cap) == "number" and props[i].totWeight and props[i].totWeight >= 0 then
					if props[i].min then
						props[i].original = props[i].original .. L" {" .. UI.GetCliloc(SystemData.Settings.Language.type, 876) .. props[i].min .. L" - " .. props[i].cap .. L"}"
					else
						props[i].original = props[i].original .. L" {" .. UI.GetCliloc(SystemData.Settings.Language.type, 877) .. props[i].cap .. L"}"
					end
				end
			end
			if props[i].intensity > 50 and props[i].totWeight >= 0 then 
				if props[i].intensity >= 100 then
					props[i].color = EnhancePack.ARTIFACT_COLOR
				else
					local r = 0
					local g = 0
					local b = 0
					if (EnhancePack.EXTRAINFO.r > 0)  then
						r = gb
					end
					if (EnhancePack.EXTRAINFO.g > 0) then
						g = gb
					end
					if (EnhancePack.EXTRAINFO.b > 0) then
						b = gb
					end
					props[i].color = {r=r, g=g, b=b}
				end
			else
				local physical = L"physical resist"
				local fire = L"fire resist"
				local cold = L"cold resist"
				local poison = L"poison resist"
				local energy = L"energy resist"
				
				if (props[i].name ~= physical and props[i].name ~= fire and props[i].name ~=  cold and props[i].name ~= poison and props[i].name ~= energy) then
					props[i].color = EnhancePack.MAGICPROP_COLOR
				end
			end 
		end
		if (props[i].totWeight and (props[i].totWeight > 0 or props[i].name == L"luck")) then
			totalIntens = totalIntens + props[i].totWeight
			totalprop = totalprop +1
		end
		
		
	end

	local col = EnhancePack.SpecialColor
	if (totalIntens > 0 and not arti) then

		totalIntens = math.floor(totalIntens)
		local data = {original=UI.GetCliloc(SystemData.Settings.Language.type, 878), name=L"SMALL", value=0, color=col, font=ItemProperties.GetFont("small") }
		table.insert(props, data )
		
		if (itemTypeName) then
			local data = {original=UI.GetCliloc(SystemData.Settings.Language.type, 887) .. WindowUtils.Decapitalizing(itemTypeName), name=L"SMALL", value=0, color=col, font=ItemProperties.GetFont("small") }
			table.insert(props, data )
		end
		
		data = {original=UI.GetCliloc(SystemData.Settings.Language.type, 879) .. totalIntens, name=L"SMALL", value=0, color=col, font=ItemProperties.GetFont("small") }
		table.insert(props, data )
			
		if (totalprop < ItemProperties.MAX_Imbuing_Mods) then
			
			data = {original=UI.GetCliloc(SystemData.Settings.Language.type, 880) .. totalprop .. L"/" .. ItemProperties.MAX_Imbuing_Mods, name=L"SMALL", value=0, color=col, font=ItemProperties.GetFont("small") }
			table.insert(props, data )
		else
			data = {original=UI.GetCliloc(SystemData.Settings.Language.type, 881), name=L"DESC", value=0, color=col, font=ItemProperties.GetFont("small") }
			table.insert(props, data )
			swappable = true
		end
		if (poffable and maxdura > 0) then
			if maxdura < 255 then
				PofCharges = math.ceil((255 - maxdura) / 10)
				local jars = math.ceil(PofCharges/10)
				if (PofCharges > 0) then
					local text = UI.GetCliloc(SystemData.Settings.Language.type, 519).. L" " .. PofCharges .. L" (" .. jars .. L" " .. UI.GetCliloc(SystemData.Settings.Language.type, 520) .. L")"
					data = {original=text, name=L"DESC", value=0, color=col, font=ItemProperties.GetFont("small") }
					table.insert(props, data )
				else
					PofCharges = 0
				end
			end
		elseif(not poffable) then
			data = {original=UI.GetCliloc(SystemData.Settings.Language.type, 524), name=L"DESC", value=0, color=EnhancePack.ALERT_COLOR, font=ItemProperties.GetFont("small") }
			table.insert(props, data )
		end
	end
	return props, totalIntens, swappable, PofCharges
end
function ItemProperties.CalcBODValue(p)

	
	local quantity, quality, material, lbodtype, skill, value
	
	local propLen = table.getn(p)
	--Debug.Print(p)
	local points = {
	[L"10"] = 10; [L"15"] = 25; [L"20"] = 50; 
	[L"normal_smith"] = 0; [L"normal_tailor"] = 0; [L"exceptional_smith"] = 200; [L"exceptional_tailor"] = 100;
	
	
	
	[GetStringFromTid(1025989)] = 0;   -- L"cloth"
	[GetStringFromTid(1049353)] = 0;   -- L"normal leather"
	[GetStringFromTid(1049354)] = 50;  -- L"spined leather"
	[GetStringFromTid(1049355)] = 100; -- L"horned leather"
	[GetStringFromTid(1049356)] = 150; -- L"barbed leather"
	
	[L"small"] = 0; [L"4piece"] = 300; [L"5piece"] = 400; [L"6piece"] = 500; [L"polearm"] = 200;
	[L"ringmail"] = 200; [L"chainmail"] = 300; [L"6pieceweapon"] = 300; [L"fencing"] = 350; [L"platemail"] = 400;
	}

	
	material = p[5].original
	

	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		material = wstring.lower(material)
		points[wstring.lower(GetStringFromTid(1027152))] = 0;   -- L"iron ingots"
		points[wstring.lower(GetStringFromTid(1045142))] = 200; -- All items must be made with dull copper ingots.
		points[wstring.lower(GetStringFromTid(1045143))] = 250; -- All items must be made with shadow iron ingots.
		points[wstring.lower(GetStringFromTid(1045144))] = 300; -- All items must be made with copper ingots.
		points[wstring.lower(GetStringFromTid(1045145))] = 350; -- All items must be made with bronze ingots.
		points[wstring.lower(GetStringFromTid(1045146))] = 400; -- All items must be made with gold ingots.
		points[wstring.lower(GetStringFromTid(1045147))] = 450; -- All items must be made with agapite ingots.
		points[wstring.lower(GetStringFromTid(1045148))] = 500; -- All items must be made with verite ingots.
		points[wstring.lower(GetStringFromTid(1045149))] = 550; -- All items must be made with valorite ingots.
		quantity = wstring.gsub(wstring.lower(p[7].original),wstring.lower(GetStringFromTid(1045138)) .. L" ",L"")  --L"Amount To Make: "
	else
		
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
			points[GetStringFromTid(1027152)] = 0;   -- L"iron ingots"
			points[GetStringFromTid(1045142)] = 200; -- All items must be made with dull copper ingots.
			points[GetStringFromTid(1045143)] = 250; -- All items must be made with shadow iron ingots.
			points[GetStringFromTid(1045144)] = 300; -- All items must be made with copper ingots.
			points[GetStringFromTid(1045145)] = 350; -- All items must be made with bronze ingots.
			points[GetStringFromTid(1045146)] = 400; -- All items must be made with gold ingots.
			points[GetStringFromTid(1045147)] = 450; -- All items must be made with agapite ingots.
			points[GetStringFromTid(1045148)] = 500; -- All items must be made with verite ingots.
			points[GetStringFromTid(1045149)] = 550; -- All items must be made with valorite ingots.
			quantity = wstring.gsub(p[7].original,GetStringFromTid(1045138),L"")  --L"Amount To Make: "
		else
			material = wstring.lower(material)
			points[wstring.lower(GetStringFromTid(1027152))] = 0;   -- L"iron ingots"
			points[wstring.lower(GetStringFromTid(1045142))] = 200; -- All items must be made with dull copper ingots.
			points[wstring.lower(GetStringFromTid(1045143))] = 250; -- All items must be made with shadow iron ingots.
			points[wstring.lower(GetStringFromTid(1045144))] = 300; -- All items must be made with copper ingots.
			points[wstring.lower(GetStringFromTid(1045145))] = 350; -- All items must be made with bronze ingots.
			points[wstring.lower(GetStringFromTid(1045146))] = 400; -- All items must be made with gold ingots.
			points[wstring.lower(GetStringFromTid(1045147))] = 450; -- All items must be made with agapite ingots.
			points[wstring.lower(GetStringFromTid(1045148))] = 500; -- All items must be made with verite ingots.
			points[wstring.lower(GetStringFromTid(1045149))] = 550; -- All items must be made with valorite ingots.
			quantity = wstring.gsub(p[7].original,GetStringFromTid(1045138) .. L" ",L"")  --L"Amount To Make: "
		end
	end

	if points[material] > 150 or material == GetStringFromTid(1027152) then -- L"iron ingots"
		skill = L"smith"
	else
		skill = L"tailor"
	end 

	if (wstring.lower(p[6].original) == GetStringFromTid(1060636)) then
		quality = wstring.lower(L"exceptional_" .. skill)
	else
		quality = wstring.lower(L"normal_" .. skill)
	end
	
	lbodtype = L"small"
	local prop = wstring.lower(wstring.sub(p[8].original,1,  - 3))

	if propLen > 8 then -- large BOD, check bonus

		if skill == L"tailor" then
			lbodtype = (propLen - 7) .. L"piece"
		elseif wstring.find(prop,GetStringFromTid(1025139)) then
			lbodtype = L"platemail"
		elseif wstring.find(prop,GetStringFromTid(1025099)) then
			lbodtype = L"ringmail"
		elseif wstring.find(prop,GetStringFromTid(1025051)) then
			lbodtype = L"chainmail"
		elseif wstring.find(prop,GetStringFromTid(1015068)) then
			lbodtype = L"polearm"
		elseif wstring.find(prop,GetStringFromTid(1015050)) then
			lbodtype = L"fencing"			
		else
			lbodtype = L"6pieceweapon"			
		end
	end

	value = points[quality] + points[quantity] + points[material] + points[lbodtype]

	local worthLarge = 0
	local worthLarge2 = 0
	if (lbodtype == L"small") then
		local cleanProp = wstring.sub(prop, 1, wstring.find(prop, L":") - 1)
		local smallLargeType = ItemPropertiesEvaluator.SmallToLarge[cleanProp]

		

		if (smallLargeType and smallLargeType ~= L"") then
			if (type(smallLargeType) ~="table") then
				worthLarge = points[quality] + points[quantity] + points[material] + points[smallLargeType]
			else
				worthLarge = points[quality] + points[quantity] + points[material] + points[smallLargeType[1]]
				worthLarge2 = points[quality] + points[quantity] + points[material] + points[smallLargeType[2]]
			end
		end
	end
	local worth = value
	local bodSkill = skill
	
	local rw = ItemProperties.CalcReward(worth, skill)
	
	local largeRW = nil
	local largeRW2 = nil
	if (worthLarge > 0) then
		largeRW = ItemProperties.CalcLargeReward(ItemProperties.CalcReward(worthLarge, skill), skill)
	end
	if (worthLarge2 > 0) then
		largeRW2 = ItemProperties.CalcLargeReward(ItemProperties.CalcReward(worthLarge2, skill), skill)
	end
	
	local skillName 
	if (skill == L"tailor") then
		skillName = GetStringFromTid(1042381)
	else
		skillName = GetStringFromTid(1043066)
	end
	local text = UI.GetCliloc(SystemData.Settings.Language.type, 882)
	if GenericGump.OverPropsWin then
		text = L""
	end
	
	if type(rw) == "wstring" then
		local itemName = WindowUtils.Decapitalizing(wstring.gsub(rw, L"~1_type~" , skillName))
		text =text .. L"\n"..itemName	
		if (largeRW and not ItemPropertiesEvaluator.LargeBod ) then
			text = text .. L"\n\n--------------\n\n" .. UI.GetCliloc(SystemData.Settings.Language.type, 847) .. L":\n"..largeRW[1]
			if (largeRW2) then
				text = text .. L"\n\n--------------\n"..largeRW2[1]
			end
		else
			if (lbodtype == L"small" ) then
				text = text .. L"\n\n" ..  UI.GetCliloc(SystemData.Settings.Language.type, 848)
			end
		end

	else
		local rwdes = 0
		for k,v in pairs(rw) do
			local itemName = WindowUtils.Decapitalizing(wstring.gsub(k, L"~1_type~" , skillName))

			text = text .. L"\n"..itemName..L": "..v..L"%"
			rwdes = rwdes + (ItemPropertiesEvaluator.BodRewards[k].des * 100 / v)
		end
		if (largeRW) then
			text = text .. L"\n\n--------------\n\n" .. UI.GetCliloc(SystemData.Settings.Language.type, 847) .. L":\n"..largeRW[1]
			if (largeRW2) then
				text = text .. L"\n\n--------------\n"..largeRW2[1]
			end
		else
			if (lbodtype == L"small" ) then
				text = text .. L"\n\n" ..  UI.GetCliloc(SystemData.Settings.Language.type, 848)
			end
		end
	end
	if worth < 100 then
		p[1].color=ItemPropertiesEvaluator.LOW_INTENSITY
	else
		p[1].color=ItemPropertiesEvaluator.MED_INTENSITY
	end
	GenericGump.OverPropsDesc = text.. L"\n"
	GenericGump.BodColor = p[1].color
	local data = {original=text, name=L"DESC", value=0, color=EnhancePack.SpecialColor, font=ItemProperties.GetFont("small") }
	table.insert(p, data )
	return p
end

function ItemProperties.CalcReward(w, skill)
	local rw
	if skill == L"tailor" then
		if w < 50 then rw = GetStringFromTid(1044286) .. L" 1"
		elseif w < 100 then rw = GetStringFromTid(1044286) .. L" 2"
		elseif w < 150 then rw = GetStringFromTid(1044286) .. L" 3"
		elseif w < 200 then rw = {[GetStringFromTid(1044286) .. L" 4"] = 90; [GetStringFromTid(1015289)] = 10;}
		elseif w < 300 then rw = {[GetStringFromTid(1044286) .. L" 4"] = 80; [GetStringFromTid(1015289)] = 20;}
		elseif w < 350 then rw = GetStringFromTid(1024201)
		elseif w < 400 then rw = wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061118))
		elseif w < 450 then rw = {[GetStringFromTid(1049639)] = 40; [GetStringFromTid(1023754)] = 60;} 
		elseif w < 500 then rw = GetStringFromTid(1022729)
		elseif w < 550 then rw = GetStringFromTid(1049640)
		elseif w < 575 then rw = GetStringFromTid(1041008)
		elseif w < 600 then rw = GetStringFromTid(1049641)
		elseif w < 650 then rw = wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061117))
		elseif w < 700 then rw = GetStringFromTid(1049642)
		else rw = wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061116))
		end
	else
		if w < 25 then rw = GetStringFromTid(1045125) -- L"shovel"
		
		elseif w < 50 then rw = GetStringFromTid(1045126) -- L"pickaxe"		
		
		elseif w < 200 then rw = {[GetStringFromTid(1045126)] = 45; [GetStringFromTid(1045125)] = 45; [GetStringFromTid(1045122)] = 10}  -- L"gloves+1"
		
		elseif w < 400 then rw = {[GetStringFromTid(1049065)] = 45; [GetStringFromTid(1017411)] = 45; [GetStringFromTid(1045123)] = 10} -- L"prospector"  -- L"gargoyle" -- L"gloves+3"
		
		elseif w < 450 then rw = {[GetStringFromTid(1049065)] = 40; [GetStringFromTid(1017411)] = 40; [GetStringFromTid(1049082)] = 20} 
		
		elseif w < 500 then rw = {[GetStringFromTid(1045124)] = 10; [GetStringFromTid(1049082)] = 90}
		
		elseif w < 550 then rw = GetStringFromTid(1049020)
		
		elseif w < 600 then rw = {[GetStringFromTid(1049020)] = 60; [GetStringFromTid(1049021)] = 40}
		
		elseif w < 625 then rw = GetStringFromTid(1049021)
		
		elseif w < 650 then rw = {[GetStringFromTid(1049639)] = 60; [GetStringFromTid(1049021)] = 30; [GetStringFromTid(1024015)] = 10}
		
		elseif w < 675 then rw = GetStringFromTid(1049022)
		
		elseif w < 700 then rw = {[GetStringFromTid(1049640)] = 60; [GetStringFromTid(1049022)] = 30; [GetStringFromTid(1024015)] = 10}
		
		elseif w < 750 then rw = GetStringFromTid(1049023)
		
		elseif w < 800 then rw = GetStringFromTid(1049028)
		
		elseif w < 850 then rw = GetStringFromTid(1049641)
		
		elseif w < 900 then rw = GetStringFromTid(1049029)
		
		elseif w < 950 then rw = GetStringFromTid(1049642)
		
		elseif w < 1000 then rw = GetStringFromTid(1049024)
		
		elseif w < 1050 then rw = GetStringFromTid(1049030)
		
		elseif w < 1100 then rw = GetStringFromTid(1049025)
		
		elseif w < 1150 then rw = GetStringFromTid(1049031)
		
		elseif w < 1200 then rw = GetStringFromTid(1049026)
		
		else rw = GetStringFromTid(1049027)
		end
	end
	return rw
end

function ItemProperties.CalcLargeReward(rw, skill)
	if not rw then
		return
	end
	local skillName 
	if (skill == L"tailor") then
		skillName = GetStringFromTid(1042381)
	else
		skillName = GetStringFromTid(1043066)
	end

	if type(rw) == "wstring" then
		local itemName = L"\n" .. WindowUtils.Decapitalizing(wstring.gsub(rw, L"~1_type~" , skillName))
		return {itemName, ItemPropertiesEvaluator.BodRewards[rw].des}
	else
		local rwdes = 0
		local items = L""
		for k,v in pairs(rw) do
			local itemName = WindowUtils.Decapitalizing(wstring.gsub(k, L"~1_type~" , skillName))

			items = items .. L"\n"..itemName..L": "..v..L"%"
			rwdes = rwdes + (ItemPropertiesEvaluator.BodRewards[k].des * 100 / v)
		end
		return {items, rwdes}
	end
end

function ItemProperties.IsMedable(props)
	for i = 1, #props do
		if props[i] == "" or props[i] == L"" then
			table.remove(props, i)
		end	
	end
	local raceItem = ItemProperties.IdentifyItemRace(props)
		
	local materialKind, materialName, itemKind, itemTypeName, medable, ranged = ItemProperties.IdentifyItem(props[1], raceItem)	
	local itemKind, range, medable, imbued, exceptional, speed, ssi = ItemProperties.ItemTypeFinalizer(props, itemKind, range, medable)

	if (itemKind == ItemPropertiesEvaluator.TYPE_SKIP or itemKind == ItemPropertiesEvaluator.TYPE_WEARABLE) then
		return true
	end
	return medable
end

function ItemProperties.GetCharacterSpeed(speed, ssi)
	
	if not ItemPropertiesEvaluator.PaperdollSlotOver then
		ssi = ssi + tonumber(WindowData.PlayerStatus["SwingSpeedIncrease"]) - EnhancePack.CurrentWeaponSSI
	else
		ssi = tonumber(WindowData.PlayerStatus["SwingSpeedIncrease"])
	end

	
	if ssi > 60 then
		ssi = 60
	end

	local stamTicks = math.floor(WindowData.PlayerStatus.MaxStamina / 30)
	
	local actualspeed = math.max(1.25, math.floor((speed * 4 - stamTicks) * (100 / (100 + ssi)))/4)
	return actualspeed
end

function ItemProperties.GetCharacterDPS(damage, speed, ssi, damInc)

	local speed = ItemProperties.GetCharacterSpeed(speed, ssi)
	
	if not ItemPropertiesEvaluator.PaperdollSlotOver then
		damInc = damInc + tonumber(WindowData.PlayerStatus["DamageChanceIncrease"]) - EnhancePack.CurrentWeaponDI
	else
		damInc = tonumber(WindowData.PlayerStatus["DamageChanceIncrease"])
	end
	
	local tactBonus = 0
	local tactics = WindowData.SkillDynamicData[27].TempSkillValue
	
	if WindowData.PlayerStatus["Race"] == 1 and tactics < 200 then
		tactics = 200
	end
	
	if tactics < 1000 then
		tactBonus = tactics / 16
	else
		tactBonus = (tactics / 16) + 6.25
	end
	
	local anatomy = WindowData.SkillDynamicData[1].TempSkillValue
	if WindowData.PlayerStatus["Race"] == 1 and anatomy < 200 then
		anatomy = 200
	end
	
	local anatBonus = 0
	if (anatomy > 0) then
		anatBonus = (anatomy / 20) + 5
	end
	
	local strBonus = WindowData.PlayerStatus.Strength*0.3
	if WindowData.PlayerStatus.Strength >= 100 then 
		strBonus = strBonus + 5 
	end
	
	if damInc > 100 then
		damInc = 100
	end
	
	local bonus = tactBonus + anatBonus + damInc + strBonus
	bonus = (bonus / 100)

	local mindmg = math.floor(damage[1] + (damage[1] * bonus))

	local maxdmg = math.floor(damage[2] + (damage[2] * bonus))

	local avgdmg = (mindmg+maxdmg)/2
	
	return avgdmg/speed
end

function ItemProperties.GetWeaponSpeed(speed, ssi)
	
	local stamTicks = 0
	
	local actualspeed = math.max(1.25, math.floor((speed * 4 - stamTicks) * (100 / (100 + ssi)))/4)
	return actualspeed
end

function ItemProperties.GetDPS(damage, speed, ssi)
	
	speed = speed - ( speed * (ssi / 100))
	local mindmg = damage[1]
	local maxdmg = damage[2]
	local avgdmg = (mindmg+maxdmg)/2
	
	return wstring.format(L"%.2f",avgdmg/speed)
end


function ItemProperties.ResetExtraProps()
	for key, value in pairs(ItemProperties.ExtraProps) do
		ItemProperties.ExtraProps[key] = nil
	end
	ItemProperties.ExtraProps = nil
	
	ItemProperties.ExtraProps = {}
	ItemProperties.ExtraProps.props = {}
	ItemProperties.ExtraProps.descs = {}
	ItemProperties.ExtraProps.resists = {}
	ItemProperties.ExtraProps.maxresists = {}
	ItemProperties.ExtraProps.setData = {}
	
	ItemProperties.ExtraProps.physD = 0
	ItemProperties.ExtraProps.fireD = 0
	ItemProperties.ExtraProps.coldD = 0
	ItemProperties.ExtraProps.poisD = 0
	ItemProperties.ExtraProps.enerD = 0
	
	ItemProperties.ExtraProps.physR = 0
	ItemProperties.ExtraProps.fireR = 0
	ItemProperties.ExtraProps.coldR = 0
	ItemProperties.ExtraProps.poisR = 0
	ItemProperties.ExtraProps.enerR = 0
	
	ItemProperties.ExtraProps.skillReq = L""
	ItemProperties.ExtraProps.strReq = 0
	ItemProperties.ExtraProps.maxDurab = 0
	ItemProperties.ExtraProps.curDurab = 0
	
	ItemProperties.ExtraProps.weight = 0
	ItemProperties.ExtraProps.craftedBy = L""
	
	ItemProperties.ExtraProps.layer = L""
	ItemProperties.ExtraProps.reforged = nil

end

function ItemProperties.ItemParsing(props, relicOnly)

	if not props then
		return
	end

	if props[2] == false then
		relicOnly = props[2]
		colors = props[3]
		props = props[1]
	end
	
	local labelText = {}
	local labelColors = {}
	local labelFont = {}
		
	ItemProperties.ResetExtraProps()
	
	for i = 1, #props do
		if props[i] == "" or props[i] == L"" then
			table.remove(props, i)
			table.remove(colors, i)
		end	
	end
	props = ItemProperties.InsertHiddenProperties(props)
	local raceItem = ItemProperties.IdentifyItemRace(props)

	local materialKind, materialName, itemKind, itemTypeName, medable, ranged = ItemProperties.IdentifyItem(props[1], raceItem)

	local itemKind, range, medable, imbued, exceptional, speed, ssi, damage, di = ItemProperties.ItemTypeFinalizer(props, itemKind, range, medable)
	local props, arti, set, poffable, totalResist = ItemProperties.PropsExpander(props, itemKind, itemTypeName, range, speed, ssi, raceItem, damage, di, colors)
	
	
	
	local intProps, intensity, swappable, PofCharges = ItemProperties.GetIntensitiesInfo(props, poffable, arti, itemTypeName, itemKind)
	local unravelInto = L""
	props, relic, unravelInto = ItemProperties.CalcUnravel(props, itemKind, materialName, imbued, arti, set)
	
	ItemProperties.ExtraProps.layer = ItemProperties.GetLayer(itemKind, itemTypeName, twoHanded)
	
	
	
	ItemProperties.ExtraProps.materialKind = materialKind
	ItemProperties.ExtraProps.materialName = materialName
	ItemProperties.ExtraProps.itemKind = itemKind
	ItemProperties.ExtraProps.itemTypeName = itemTypeName
	ItemProperties.ExtraProps.itemName = props[1].original
	ItemProperties.ExtraProps.medable = medable
	ItemProperties.ExtraProps.ranged = ranged
	ItemProperties.ExtraProps.range = range
	ItemProperties.ExtraProps.imbued = imbued
	ItemProperties.ExtraProps.exceptional = exceptional
	ItemProperties.ExtraProps.speed = speed
	ItemProperties.ExtraProps.ssi = ssi
	ItemProperties.ExtraProps.damage = damage
	ItemProperties.ExtraProps.di = di
	ItemProperties.ExtraProps.arti = arti
	ItemProperties.ExtraProps.set = set
	ItemProperties.ExtraProps.poffable = poffable
	ItemProperties.ExtraProps.swappable = swappable
	ItemProperties.ExtraProps.PofCharges = PofCharges
	ItemProperties.ExtraProps.totalResist = totalResist
	
	ItemProperties.ExtraProps.intensity = intensity
	ItemProperties.ExtraProps.unravelInto = unravelInto
	
	
	if itemKind == ItemPropertiesEvaluator.TYPE_BOD then
		props = ItemProperties.CalcBODValue(props)
	else
		if relicOnly then
			return unravelInto--relic
		else
			if (itemKind == ItemPropertiesEvaluator.TYPE_SKIP) then
				props = ItemProperties.GetCrateFishInfo(props)
				props = ItemProperties.GetFishInfo(props)
			end
			props = ItemProperties.NotorietyText(props)
			props = ItemProperties.ExtraInfo(props, medable, totalResist)
			
			
			if (ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_WEAPON) then
				props, special1, special2 = ItemProperties.GetSpecial(props, itemTypeName)
				ItemProperties.ExtraProps.special1 = special1
				ItemProperties.ExtraProps.special2 = special2
			end
			if(EnhancePack.IntensityInfo and itemKind ~= ItemPropertiesEvaluator.TYPE_SKIP and itemKind ~= ItemPropertiesEvaluator.TYPE_WEARABLE and not set and not EnhancePack.CurrentOnIsMobile) then
				props = intProps
			end
		end
	end
	
	
	for i = 1, #props do
		if EnhancePack.ToggleNewLayout and i > 1 then --  and not ItemProperties.CurrentItemData.itemLoc
			if  props[i].name == L"SPECIALBLUE" then
				props[i].cap = nil
			end
			if (ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_JEWEL or 
				ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_ARMOR or
				ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_SHIELD or
				ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_HAT or
				ItemProperties.ExtraProps.itemKind == ItemPropertiesEvaluator.TYPE_WEAPON 
				) then
				if props[i].name ~= L"BOLTS" and props[i].name ~= L"ARROWS" and props[i].name ~= L"SETDATA" and props[i].name ~= L"SKIP" and props[i].name ~= L"MISC" and props[i].name ~= L"STRREQ" and props[i].name ~= L"SMALL" and props[i].name ~= L"WEIGHT" and props[i].name ~= L"DURABILITY" and props[i].name ~= L"ENGRAVE"  then
					if (props[i].name ~= L"DESC") then
						if wstring.find(props[i].name, L"resist") and ItemProperties.ExtraProps.itemKind ~= ItemPropertiesEvaluator.TYPE_WEAPON and not wstring.find(props[i].name, L"resisting") then
							table.insert(ItemProperties.ExtraProps.resists, props[i])
						else
							if props[i].name ~= L"use best weapon skill" then
								table.insert(ItemProperties.ExtraProps.props, props[i])
							else
								ItemProperties.ExtraProps.skillReq = props[i].original
							end
						end
					
					else
						local fixed = wstring.gsub(props[i].original, L"<BR>", L"\n")
						local substr = BookTemplate.Commalines(WStringToString(fixed ))
						for k = 1, #substr do
							if substr[k] ~= "" then
								local data = {original = towstring(substr[k]), color=props[i].color, desc=L"DESC"}
								table.insert(ItemProperties.ExtraProps.descs, data)
							end
						end
					end
				end
			elseif (props[i].name ~= L"BOLTS" and props[i].name ~= L"ARROWS" and props[i].name ~= L"SETDATA" and props[i].name ~= L"SKIP" and props[i].name ~= L"WEIGHT" and props[i].name ~= L"SMALL" and props[i].name ~= L"DURABILITY" and props[i].name ~= L"SKIP" and props[i].name ~= L"STRREQ" and props[i].name ~= L"ENGRAVE") then
				if (props[i].name == L"CONTENT") then
					ItemProperties.ExtraProps.content = props[i].original
					if not ItemProperties.ExtraProps.itemTypeName or ItemProperties.ExtraProps.itemTypeName == L"" then
						ItemProperties.ExtraProps.itemTypeName = UI.GetCliloc(SystemData.Settings.Language.type, 5058)
					end
				
				elseif (props[i].name ~= L"DESC") then
					if (wstring.find(props[i].name, L"MISC")) then
						props[i].cap = ""
					end
					table.insert(ItemProperties.ExtraProps.props, props[i])
				else
					local fixed = wstring.gsub(props[i].original, L"<BR>", L"\n")
					local substr = BookTemplate.Commalines(WStringToString(fixed ))
					for k = 1, #substr do
						if substr[k] ~= "" then
							local data = {original = towstring(substr[k]), color=props[i].color, desc=L"DESC"}
							table.insert(ItemProperties.ExtraProps.descs, data)
						end
					end
				end
				
			end
		end
		table.insert(labelText, props[i].original)
		table.insert(labelColors, props[i].color)
		table.insert(labelFont, props[i].font)
	end
	
	--Debug.Print(props)
	--Debug.Print("------")
	return labelText, labelColors, labelFont
end

function ItemProperties.InsertHiddenProperties(props)

	if not props or not props[1] then
		return
	end
	local lprop = wstring.lower(props[1])
	
	if (lprop == wstring.lower(GetStringFromTid(1049028))) then  -- ancient hammer +10
		table.insert(props, 3, FormatProperly(GetStringFromTid(1042354)) .. L" +10")
	end
	if (lprop == wstring.lower(GetStringFromTid(1049029))) then  -- ancient hammer +15
		table.insert(props, 3, FormatProperly(GetStringFromTid(1042354)) .. L" +15")
	end
	if (lprop == wstring.lower(GetStringFromTid(1049030))) then  -- ancient hammer +30
		table.insert(props, 3, FormatProperly(GetStringFromTid(1042354)) .. L" +30")
	end
	if (lprop == wstring.lower(GetStringFromTid(1049031))) then  -- ancient hammer +60
		table.insert(props, 3, FormatProperly(GetStringFromTid(1042354)) .. L" +60")
	end
	
	return props
end


function ItemProperties.ActionParsing()
	local labelText = {}
	local labelColors = {}
	local labelFont = {}
	
	-- first get its location if it has one and set the subindex to 0 by default
	local itemLoc = ItemProperties.CurrentItemData.itemLoc
	if( itemLoc ~= nil and itemLoc.subIndex == nil ) then
		itemLoc.subIndex = 0
	end
	local id = WindowData.ItemProperties.CurrentHover
	local i = 0

	if( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_SKILL ) then
		local skillId = id - 1
		
		-- translate the server id into a row into the ability csv
		local abilityId = CSVUtilities.getRowIdWithColumnValue(WindowData.SkillsCSV, "ServerId", skillId)

		labelText[1] = GetStringFromTid(WindowData.SkillsCSV[abilityId].NameTid)
		labelColors[1] = EnhancePack.TITLE_COLOR
		labelFont[1] = ItemProperties.GetFont("bold")

		local detailTid = WindowData.SkillsCSV[abilityId].DescriptionTid
		if( detailTid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
			labelText[2] = GetStringFromTid(detailTid)
			labelColors[2] = EnhancePack.BODY_COLOR 	
			labelFont[2] = ItemProperties.GetFont("normal")
		end
	elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_SPELL ) then
	
		local icon, serverId, tid, desctid = GetAbilityData(id)

		if( desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
			if( tid ~= nil ) then
				i = i + 1
				labelText[i] = GetStringFromTid(tid)
				labelColors[i] = EnhancePack.TITLE_COLOR	
				labelFont[i] = ItemProperties.GetFont("bold")	
			end				
			i = i + 1
			labelText[i] = GetStringFromTid(desctid)
			labelColors[i] = EnhancePack.BODY_COLOR 	
			labelFont[i] = ItemProperties.GetFont("normal")
		elseif( tid ~= nil ) then
			i = i + 1
			labelText[i] = GetStringFromTid(tid)
			labelColors[i] = EnhancePack.TITLE_COLOR	
			labelFont[i] = ItemProperties.GetFont("bold")	
		end		
		
		if(ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"") then
			i = i + 1
			labelText[i] = WindowUtils.translateMarkup(ItemProperties.CurrentItemData.body)
			labelColors[i] = EnhancePack.BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")	
		end
	elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE ) then
		local nameTid = ItemProperties.VirtueData[id].nameTid
		local detailTid = ItemProperties.VirtueData[id].detailTid

		if( nameTid ~= nil and nameTid ~= 0 ) then
			i = i +1
			labelText[i] = GetStringFromTid(nameTid)	
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
		end
		if( detailTid ~= nil and detailTid ~= 0 ) then
			i = i +1
			labelText[i] = GetStringFromTid(detailTid)
			labelColors[i] = EnhancePack.BODY_COLOR 	
			labelFont[i] = ItemProperties.GetFont("normal")
		end
	elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY ) then
		if( EquipmentData.CurrentWeaponAbilities[id] ~= nil and EquipmentData.CurrentWeaponAbilities[id] ~= 0 ) then
			local abilityId = EquipmentData.CurrentWeaponAbilities[id] + EquipmentData.WEAPONABILITY_ABILITYOFFSET
			local icon, serverId, tid, desctid = GetAbilityData(abilityId)

			-- Always show the ability name
			if( tid ~= nil ) then
				i = i +1
				labelText[i] = GetStringFromTid(tid)
				labelColors[i] = EnhancePack.TITLE_COLOR
				labelFont[i] = ItemProperties.GetFont("bold")
			end

			if( desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
				i = i +1
				labelText[i] = GetStringFromTid(desctid)	
				labelColors[i] = EnhancePack.BODY_COLOR 	
				labelFont[i] = ItemProperties.GetFont("normal")		
			end
		end
	elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_RACIAL_ABILITY ) then

		local iconId = UserActionGetIconId(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
		local icon, serverId, tid, desctid = GetAbilityData(iconId)
		if( desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
			if( tid ~= nil ) then
				i = i + 1
				labelText[i] = GetStringFromTid(tid)
				labelColors[i] = EnhancePack.TITLE_COLOR	
				labelFont[i] = ItemProperties.GetFont("bold")	
			end				
			i = i + 1
			labelText[i] = GetStringFromTid(desctid)
			labelColors[i] = EnhancePack.BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")		
		elseif( tid ~= nil ) then
			i = i + 1
			labelText[i] = GetStringFromTid(tid)
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")			
		end		
		
		if(ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"") then
			i = i + 1
			labelText[i] = WindowUtils.translateMarkup(ItemProperties.CurrentItemData.body)
			labelColors[i] = EnhancePack.BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")	
		end
	elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then
		RegisterWindowData(WindowData.ObjectTypeQuantity.Type, ItemProperties.CurrentItemData.itemId)
		item = WindowData.ObjectTypeQuantity[ItemProperties.CurrentItemData.itemId]
		if( item ~= nil ) then
			if( item.name ~= nil and item.name ~= L"" ) then
				local itemName = Shopkeeper.stripFirstNumber(item.name)
			    labelText[1] = item.quantity..L" "..itemName
			    labelColors[1] = EnhancePack.TITLE_COLOR	
			    labelFont[i] = ItemProperties.GetFont("bold")	
			end
		end
		
		UnregisterWindowData(WindowData.ObjectTypeQuantity.Type, ItemProperties.CurrentItemData.itemId)
	elseif(ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
		if id ~= 99999 and id ~= 99998 and id ~= 99997 and id ~= 55555 and id ~= 20 then
			tid = WindowData.PlayerStatsDataCSV[id].tid
			detailTid = WindowData.PlayerStatsDataCSV[id].detailTid
		
		else
			if id == 99999 then
				tid = 3010073 -- karma
			elseif id == 55555 then
				tid = 3010072 -- fame
			end
			detailTid = 0
		end
		
		-- Always show the ability name
		if( tid ~= nil and id ~= 20  ) then
			i = i + 1
			labelText[i] = GetStringFromTid(tid)
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
		elseif id == 20 then
			i = i + 1
			labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 5045)
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
		elseif id == 99998 then
			i = i + 1
			labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 986)
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
		elseif id == 99997 then
			i = i + 1
			labelText[i] = GetStringFromTid(1060503) -- tithing
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
		else
			i = i + 1
			labelText[i] = WindowData.PlayerStatsDataCSV[id].nameWString
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
		end
		if( detailTid ~= nil and detailTid ~= 0 and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG and id ~= 20  ) then
			i = i + 1
			labelText[i] = GetStringFromTid(detailTid)
			labelColors[i] = EnhancePack.BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")
		elseif id == 20 then
			i = i + 1
			labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 5070)
			labelColors[i] = EnhancePack.BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")
		elseif (id >= 1019 and id <= 1027) then
			labelText[i] = WindowData.PlayerStatsDataCSV[id].nameWString
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
			i = i + 1
			local button = WindowData.PlayerStatus[tostring(WindowData.PlayerStatsDataCSV[id].name) .. "Button"]
			if button then
				labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 5020)
				labelColors[i] = EnhancePack.BODY_COLOR 
				labelFont[i] = ItemProperties.GetFont("normal")
			end
		elseif (id == 1058 and WindowData.PlayerStatus["CitizenTitles"] ~= nil) then
			labelText[i] = WindowData.PlayerStatsDataCSV[id].nameWString
			labelColors[i] = EnhancePack.TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
			i = i + 1
			labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 5021)
			labelColors[i] = EnhancePack.BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")
		elseif (WindowData.PlayerStatsDataCSV[id] and WindowData.PlayerStatsDataCSV[id].detailWString) then
			i = i + 1
			if (WindowData.PlayerStatsDataCSV[id].detailWString == L"GET") then
				if (id == 1013) then
					labelText[i] = EnhancePack.GargQueenLVL
				elseif (id == 1014) then
					labelText[i] = EnhancePack.OphiLVL
				elseif (id == 1015) then
					labelText[i] = EnhancePack.BaneChosenLVL
				elseif (id == 1016) then
					labelText[i] = EnhancePack.MeerLVL
				elseif (id == 1017) then
					labelText[i] = EnhancePack.JukaLVL
				end
			else
				labelText[i] = WindowData.PlayerStatsDataCSV[id].detailWString
			end
			
			labelFont[i] = ItemProperties.GetFont("normal")
			labelColors[i] = EnhancePack.BODY_COLOR 
		elseif id == 99999 then
			i = i + 1
			labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 923)
			labelFont[i] = ItemProperties.GetFont("normal")
			labelColors[i] = EnhancePack.BODY_COLOR 
		elseif id == 55555 then
			i = i + 1
			labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 924)
			labelFont[i] = ItemProperties.GetFont("normal")
			labelColors[i] = EnhancePack.BODY_COLOR 
		elseif id == 99998 then
			i = i + 1
			labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 987)
			labelFont[i] = ItemProperties.GetFont("normal")
			labelColors[i] = EnhancePack.BODY_COLOR 
		elseif id == 99997 then
			i = i + 1
			labelText[i] = UI.GetCliloc(SystemData.Settings.Language.type, 988)
			labelFont[i] = ItemProperties.GetFont("normal")
			labelColors[i] = EnhancePack.BODY_COLOR 
		end
	else
		local actionData = ActionsWindow.GetActionDataForType(ItemProperties.CurrentItemData.actionType)
		local i = 0
		if( actionData ~= nil ) then
			if( actionData.nameTid ~= nil and actionData.nameTid ~= 0 ) then
				i = i + 1
				labelText[i] = GetStringFromTid(actionData.nameTid)
				labelColors[i] = EnhancePack.TITLE_COLOR	
				labelFont[i] = ItemProperties.GetFont("bold")
			end
			if( actionData.detailTid ~= nil and actionData.detailTid ~= 0 and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
				i = i + 1
				labelText[i] = GetStringFromTid(actionData.detailTid)
				labelColors[i] = EnhancePack.BODY_COLOR 	
				labelFont[i] = ItemProperties.GetFont("normal")	
			end						
		end
		-- add aditional information if the action has a hotbar location
		if( itemLoc ~= nil ) then
			if( UserActionIsSpeechType(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex) ) then
				local speechText = UserActionSpeechGetText(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
				if( speechText ~= L"" ) then
					i = i + 1
					labelText[i] = speechText
					labelColors[i] = EnhancePack.BODY_COLOR 
					labelFont[i] = ItemProperties.GetFont("normal")	
				end
			elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_DELAY ) then
				local delay = UserActionDelayGetDelay(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
				i = i + 1
				labelText[i] = wstring.format(L"%.3f",delay)
				labelColors[i] = EnhancePack.BODY_COLOR 
				labelFont[i] = ItemProperties.GetFont("normal")	
			elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_MACRO ) then
				local macroName = UserActionMacroGetName(itemLoc.hotbarId, itemLoc.itemIndex)
				if( macroName ~= L"" ) then
					i = i + 1
					labelText[i] = macroName
					labelColors[i] = EnhancePack.BODY_COLOR 
					labelFont[i] = ItemProperties.GetFont("normal")	
				end
			end
		end
	end
	labelFont[1] = ItemProperties.GetFont("bold")
	return labelText, labelColors, labelFont
end


function ItemProperties.WStringParsing()
	local labelText = {}
	local labelColors = {}
	local labelFont = {}
	local i = 0
	
	if( ItemProperties.CurrentItemData.title ~= nil and ItemProperties.CurrentItemData.title ~= L"" ) then
		i = i + 1
		labelText[i] = ItemProperties.CurrentItemData.title
		labelColors[i] = EnhancePack.TITLE_COLOR
		labelFont[i] = ItemProperties.GetFont("bold")
	end

	if( ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"" ) then
		i = i + 1
		labelText[i] = ItemProperties.CurrentItemData.body
		labelColors[i] = EnhancePack.BODY_COLOR
		labelFont[i] = ItemProperties.GetFont("normal")
	end
	return labelText, labelColors, labelFont
end
function ItemProperties.GetFont(style)
	if style == "normal" then
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			return  "font_verdana"
		else
			return "UO_DefaultText"
		end
	elseif style == "bold" then
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			return  "font_verdana_bold"
		else
			return "UO_DefaultText"
		end
	elseif style == "small" then
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			return  "font_verdana_italic_small_15"
		else
			return "UO_DefaultText"
		end
	end
end



-- Values in itemdata table
--   windowName - name of base window that contains hover
--   itemId     - unique id of item
--   itemType   - WindowData.ItemProperties
--	 binding    - (default L"") shown on last line
--   detail     - (default SHORT) ItemProperties.DETAIL_SHORT
--				  ItemProperties.DETAIL_LONG 
--   actionType - (default NONE) SystemData.UserAction
--	title		- Used for item properties that have the title wstring (default L"")
--	body		- Outputs the body of your text given a wstring, goes below the title (default L"")	
function ItemProperties.SetActiveItem(itemData)
	ItemProperties.ClearMouseOverItem()
	EnhancePack.ItmPrpShowing = nil
	if( itemData == nil ) then
		itemData = {}
	end
	
	-- USE_ITEM actions are the same information as item
	if( itemData.actionType == SystemData.UserAction.TYPE_USE_ITEM ) then
		itemData.itemType = WindowData.ItemProperties.TYPE_ITEM
	end
	
	--Debug.Print("ItemProperties.SetActiveItem: id="..tostring(itemData.itemId).." type="..tostring(itemData.itemType).." action="..tostring(itemData.actionType))
--	RegisterWindowData(WindowData.ItemProperties.Type, itemData.itemId)
	WindowData.ItemProperties.CurrentHover = itemData.itemId
	WindowData.ItemProperties.CurrentType = itemData.itemType
	ItemProperties.CurrentItemData = itemData
	ItemProperties.PDollItemData = itemData.data
	--BroadcastEvent(SystemData.Events.UPDATE_ITEM_PROPERTIES)
end


function ItemProperties.ClearMouseOverItem()
	--Debug.Print("ItemProperties.ClearMouseOverItem")
	WindowData.ItemProperties.CurrentHover = 0
	WindowData.ItemProperties.CurrentType = WindowData.ItemProperties.TYPE_NONE
	WindowData.ItemProperties.CustomColorTitle.NotorietyEnable = false
	WindowData.ItemProperties.CustomColorTitle.NotorietyIndex = 0
	WindowData.ItemProperties.CustomColorBody.LabelIndex = 0
	WindowData.ItemProperties.CustomColorBody.Color = {r=0, g=0, b=0}
	WindowData.ItemProperties[0] = {}
	ItemProperties.CurrentItemData = {}
	EnhancePack.CurrentOnIsMobile = nil
	ContainerWindow.ItemMouseOverId = 0 
	ItemPropertiesEvaluator.PaperdollSlotOver = false	
	ItemProperties.PrintedCrateInfo = true
end

function ItemProperties.GetCurrentWindow()
    local windowName = nil
    if( ItemProperties.CurrentItemData ~= nil ) then
        windowName = ItemProperties.CurrentItemData.windowName
    end
    
    return windowName
end

function ItemProperties.OnPlayerBackpackMouseover()
	local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	
	if backpackId ~= 0 then
		local itemData = {
			windowName = dialog,
			itemId = backpackId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}
		ItemProperties.SetActiveItem(itemData)
	end
end

function ItemProperties.LayerToSlot( layer )

	for SlotNum=1, 19 do
		local slotTitle = L""
		if ( ((WindowData.MobileStatus[WindowData.PlayerStatus.PlayerId] and WindowData.MobileStatus[WindowData.PlayerStatus.PlayerId].Race == PaperdollWindow.GARGOYLE) and ((PaperdollWindow.PAPERDOLLSLOTID.TALONS == SlotNum) or ( PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR == SlotNum) or (PaperdollWindow.PAPERDOLLSLOTID.KILT == SlotNum))) ) then											
				slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTidTwo)			
		else				
			if (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079914) then -- robe
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5061) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079912) then -- sash
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5062) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079910) then -- shirt
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5063) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079913) then -- cloak
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5064) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079915) then -- pants
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5065) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079908) then -- talisman
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5068) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079903) then -- earrings
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5069) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079901) then -- rings
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5057) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079905) then -- bracelet
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5056) 
				
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079900) then -- 1 hand
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5043) 
			elseif (PaperdollWindow.BlankSlot[SlotNum].SlotNameTid == 1079906) then -- 2 hand
				slotTitle = UI.GetCliloc(SystemData.Settings.Language.type, 5044) 
			
			else
				slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTid )					
			end
				
		end
			
		if slotTitle == layer then
			if slotTitle == UI.GetCliloc(SystemData.Settings.Language.type, 5043) or slotTitle == UI.GetCliloc(SystemData.Settings.Language.type, 5044) then
				if (EnhancePack.CurrentWeapon2Hand) then
					SlotNum = 10 
				else
					SlotNum = 4
				end
			end
			return SlotNum
		end
	end
end

function ItemProperties.GetEquippedResistances( SlotNum )
	--local objectId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][SlotNum].slotId
	local res = {
		[L"physical resist"] = 0;
		[L"fire resist"] = 0;
		[L"cold resist"] = 0;
		[L"poison resist"] = 0;
		[L"energy resist"] = 0;
		
		[L"damage chance increase"] = 0;
		[L"lower reagent cost"] = 0;
		[L"lower mana cost"] = 0;
		[L"swing speed increase"] = 0;
		[L"hit chance increase"] = 0;
		[L"defense chance increase"] = 0;
		[L"mana regen"] = 0;
		[L"hit point regen"] = 0;
		[L"hit point increase"] = 0;
		[L"mana increase"] = 0;
		[L"stamina increase"] = 0;
	}
	
	if not WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][SlotNum] then
		return res
	end
	local props = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][SlotNum].props
	
	if not props then
		return res
	end
	for i=1, #props do
		for name, v in pairs(ItemPropertiesEvaluator.Mods) do
			local physical = L"physical resist"
			local fire = L"fire resist"
			local cold = L"cold resist"
			local poison = L"poison resist"
			local energy = L"energy resist"

			if (v.en == physical or v.en == fire or v.en ==  cold or v.en == poison or v.en == energy
				or v.en == L"damage increase" 
				or v.en == L"lower reagent cost"  
				or v.en == L"lower mana cost"  
				or v.en == L"swing speed increase"  
				or v.en == L"hit chance increase"  
				or v.en == L"defense chance increase"  
				or v.en == L"mana regeneration"  
				or v.en == L"hit point regeneration"
				or v.en == L"hit point increase"
				or v.en == L"mana increase"
				or v.en == L"stamina increase"
			) then
			
				local lprop = wstring.lower(props[i])
				if wstring.find(lprop, name) then
					lprop = wstring.gsub(lprop, name, L"")
					lprop = wstring.gsub(lprop, L"%%", L"")
					if v.en == L"hit point regeneration" then
						res[L"hit point regen"] = tonumber(lprop) 
					elseif v.en == L"mana regeneration" then
						res[L"mana regen"] = tonumber(lprop) 
					elseif v.en == L"damage increase" then
						res[L"damage chance increase"] = tonumber(lprop) 
					else
						res[v.en] = tonumber(lprop) 
					end
					continue
				end		
			end
		end
	end
	return res
end

function ItemProperties.GetObjectProperties( objectId, number )
	
	local data
	local properties
	local property = {}
	if (objectId == 0) then
		return
	end

	if WindowData.ItemProperties[objectId] then
		data = WindowData.ItemProperties[objectId]
	else
		RegisterWindowData(WindowData.ItemProperties.Type, objectId)
		if WindowData.ItemProperties[objectId] then
			data = WindowData.ItemProperties[objectId]
		end
		WindowData.ItemProperties[objectId] = nil
		UnregisterWindowData(WindowData.ItemProperties.Type, objectId)
	end
	if data then
		properties = data.PropertiesList
		if ( number ) and ( type( number ) == "number" ) then
			property[1] =  towstring( WindowUtils.translateMarkup(properties[number]) )
			return property[1]
		elseif ( number ) and ( number == "last" ) then
			property[1] =  towstring( WindowUtils.translateMarkup(properties[#properties]) )
			return property[1]
		else
			for i = 1, #properties do
				local value = towstring( WindowUtils.translateMarkup(properties[i]) )
				table.insert( property, value )
			end	
			return property
		end
	else
		return nil
	end	
end

function ItemProperties.GetActiveProperties()
	
	local playerId = WindowData.PlayerStatus.PlayerId
	local paperdollWindowName = "PaperdollWindow"..playerId 	
	local numTotalItemProps = CSVUtilities.getNumRows(WindowData.PlayerItemPropCSV)
	
	if(WindowData.Paperdoll[playerId] == nil ) then			
		return
	end	

	-- Show available item properties	
	PropertyTable = {}
	for index = 1, WindowData.Paperdoll[playerId].numSlots do
		if (WindowData.Paperdoll[playerId][index].slotId ~= 0) then
			local objectId = WindowData.Paperdoll[playerId][index].slotId
			RegisterWindowData(WindowData.ObjectInfo.Type, objectId)			
			local props = ItemProperties.GetObjectProperties(objectId)						
			if not props then
				continue
			end			
			local propLen = #props			
			for i = 1, propLen do				
				local currentTID = 0				
				for propIndex = 1, numTotalItemProps do
					currentTID = WindowData.PlayerItemPropCSV[propIndex].TID
					if (currentTID ~= 0) then
						local text = nil
						local currentTIDText = wstring.lower(GetStringFromTid(currentTID))
						local exactMatch = WindowData.PlayerItemPropCSV[propIndex].MatchExact
						currentTIDText = PropertiesInfo.RemoveAfterSymbol(currentTIDText,"~")																			
						local cleanProp = PropertiesInfo.RemoveAfterSymbol(props[i],"%d")						
						if(exactMatch ~= 0) then 																				
							if(wstring.find(wstring.lower(props[i]),currentTIDText) == 1)then								
								text = currentTIDText
							end												
						else						
							text = wstring.find(wstring.lower(props[i]),currentTIDText)
						end
						if ( text ~= nil ) then					
							-- Append to active List								
							PropertyTable[propIndex] = propIndex							
							break
						end
					end
				end					
			end
			UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
		end		
	end
	return PropertyTable
end

function ItemProperties.SeparaMin(str)
  local t = {}
  local function helper(line) table.insert(t, tonumber(line)) return "" end
  helper((str:gsub("(.-)[-]", helper)))
  return t
end