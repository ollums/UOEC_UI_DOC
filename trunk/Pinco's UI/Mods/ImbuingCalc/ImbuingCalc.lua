----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ImbuingCalcWindow = {}

ImbuingCalcWindow.PropertyParse = false
ImbuingCalcWindow.Property = {}
ImbuingCalcWindow.Materials = {}

ImbuingCalcWindow.durability = 0
ImbuingCalcWindow.Mods = {}
ImbuingCalcWindow.totalMods = 0
ImbuingCalcWindow.totalWeight = 0
ImbuingCalcWindow.exc = false
ImbuingCalcWindow.speed = 0
ImbuingCalcWindow.ssi = 0
ImbuingCalcWindow.ranged = false
ImbuingCalcWindow.boomerang = false
ImbuingCalcWindow.twohanded = false

ImbuingCalcWindow.ActualMats = 0

ImbuingCalcWindow.DefaultItem = {
newWidth = 44,
newHeight = 37,
iconName = "00003905_LegacyTileArt",
hueId = 0,
objectType = 3905,
iconScale = 1,
hue = {r=255,g=255,b=255,a=255},
}

ImbuingCalcWindow.LeechScale= {
[L"1.25"] = 31;
[L"1.50"] = 37;
[L"1.75"] = 43;
[L"2"] = 50;
[L"2.25"] = 56;
[L"2.50"] = 62;
[L"2.75"] = 68;
[L"3"] = 75;
[L"3.25"] = 81;
[L"3.50"] = 87;
[L"3.75"] = 93;
[L"4"] = 100;
[L"4.25"] = 100;
[L"4.50"] = 100;
[L"4.75"] = 100;
[L"5"] = 100;
}

ImbuingCalcWindow.TYPE_NONE = 0
ImbuingCalcWindow.TYPE_ARMOR = 1
ImbuingCalcWindow.TYPE_WEAPON = 2
ImbuingCalcWindow.TYPE_JEWEL = 3
ImbuingCalcWindow.TYPE_SHIELD = 4

ImbuingCalcWindow.type = ImbuingCalcWindow.TYPE_NONE 

-- OnInitialize Handler
function ImbuingCalcWindow.Initialize()
	WindowUtils.RestoreWindowPosition("ImbuingCalcWindow", true)
	
	WindowUtils.SetWindowTitle("ImbuingCalcWindow", UI.GetCliloc(SystemData.Settings.Language.type, 638))
    WindowSetShowing("ImbuingCalcWindow", false)
    WindowSetShowing("ImbuingCalcMaterialsWindow", false)
    --DestroyWindow("ImbuingCalcMaterialsWindowChrome_UO_TitleBar")
    DestroyWindow("ImbuingCalcMaterialsWindowChrome_UO_WindowCloseButton")
    LabelSetText("ImbuingCalcWindowSoketLabel", GetStringFromTid(1062214))
    LabelSetText("ImbuingCalcWindowTotalLabel", GetStringFromTid(1113646))
    LabelSetText("ImbuingCalcWindowTotalVal", L"0")
    LabelSetText("ImbuingCalcMaterialsWindowTitle", GetStringFromTid(1044457))
    ButtonSetText("ImbuingCalcWindowAddMod", UI.GetCliloc(SystemData.Settings.Language.type, 644))
    local tot = 0
    ComboBoxClearMenuItems( "ImbuingCalcWindowMods" )
    ImbuingCalcWindow.Mods = {}
    for key, val in pairsByKeys(ItemPropertiesEvaluator.Mods) do
		
		local prop = wstring.lower(key)
		prop = wstring.gsub(prop, L"[+]", L"")
		if (prop == L"faster casting") then
			prop = wstring.lower(wstring.gsub(GetStringFromTid(1060413), ItemPropertiesEvaluator.escape2, L""))
		end
		if (prop == L"damage increase") then
			prop = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
		end
		if (prop == L"sdi") then
			prop = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
		end
		if (prop == L"swing speed increase") then
			prop = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
		end
		if (not val.type) then
			tot = tot + 1
			grp = L""
			if (val.grp) then
				grp = L" (" .. val.grp .. L")"
			end
			
			ImbuingCalcWindow.Mods[tot] = {}
			ImbuingCalcWindow.Mods[tot].raw = prop
			ImbuingCalcWindow.Mods[tot].cantRemove = false
			ImbuingCalcWindow.Mods[tot].cap = val.range	
			ImbuingCalcWindow.Mods[tot].combo = prop .. grp
		end

    end
    	for i = 1, tot do
    		if (ImbuingCalcWindow.Mods[i]) then
    		
				ComboBoxAddMenuItem( "ImbuingCalcWindowMods", WindowUtils.Decapitalizing(ImbuingCalcWindow.Mods[i].combo) )
			end
		end
		WindowSetShowing("ImbuingCalcWindowMods", false)
		ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", true )
   
end

function ImbuingCalcWindow.OnItemRelease()
	local windowName = SystemData.ActiveWindow.name
	local elementIcon = windowName.."Icon"
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local id = SystemData.DragItem.itemId
	    local objectType = SystemData.DragItem.itemType
	    local bSuccess = DragSlotDropObjectToSource()
		if( bSuccess ) then
			ImbuingCalcWindow.ClearAll()
			RegisterWindowData(WindowData.ObjectInfo.Type, id)
			ImbuingCalcWindow.UpdateIcon(id)
			local data = GetObjectProperties(id)
			for i = 0, table.getn(data) do
				ImbuingCalcWindow.Property[i] = {}
				ImbuingCalcWindow.Property[i].raw = data[i]
				ImbuingCalcWindow.Property[i].cantRemove = true
			end
			ImbuingCalcWindow.Parse()
			WindowSetId(windowName, SystemData.DragItem.itemId)
			
		end
	elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
		RequestTargetInfo()
		EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 432), 1152, true)
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ImbuingCalcWindow.TargetItem")
	end
end

function ImbuingCalcWindow.TargetItem()
	local windowName = "ImbuingCalcWindowSoket"
	local elementIcon = windowName.."Icon"
	local id = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	if( not id or id <= 0 ) then
		return
	else
		ImbuingCalcWindow.ClearAll()
		RegisterWindowData(WindowData.ObjectInfo.Type, id)
		ImbuingCalcWindow.UpdateIcon(id)
		local data = GetObjectProperties(id)
		for i = 0, table.getn(data) do
			ImbuingCalcWindow.Property[i] = {}
			ImbuingCalcWindow.Property[i].raw = data[i]
			ImbuingCalcWindow.Property[i].cantRemove = true
		end
		ImbuingCalcWindow.Parse()
		WindowSetId(windowName, id)
		
	end
end

function ImbuingCalcWindow.UpdateIcon(id)
	if id and id ~= 0 then
		local item = WindowData.ObjectInfo[id]
		local elementIcon = "ImbuingCalcWindowSoketIcon"
		if (item) then
			local name, x, y, scale, newWidth, newHeight = RequestTileArt(item.iconId,50,50)
			DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {item.hueId, item.objectType})
			DynamicImageSetTextureDimensions(elementIcon, newWidth, newHeight)
			DynamicImageSetTexture(elementIcon, name, x, y )
			DynamicImageSetTextureScale(elementIcon, scale)
			
			
		end
	end
end

ImbuingCalcWindow.delta = 0
ImbuingCalcWindow.VisibleItems = 0

function ImbuingCalcWindow.Update(timepassed)
	if (ImbuingCalcWindow.PropertyParse) then
		ImbuingCalcWindow.delta = ImbuingCalcWindow.delta + timepassed
		if (ImbuingCalcWindow.delta > 1) then
			if ImbuingCalcWindow.Parse() then
				--Debug.Print("PASSED")
			else
				ImbuingCalcWindow.PropertyParse = false
				ImbuingCalcWindow.Property = {}
				ImbuingCalcWindow.ClearAll()
			end
			ImbuingCalcWindow.delta = 0
		end
	end
	if (WindowGetShowing("ImbuingCalcMaterialsWindow")) then
		local tot = 0
		for key, mat in pairsByKeys(ImbuingCalcWindow.Materials) do
			if mat.total <= 0 then
				continue
			end
			tot = tot + 1
			if (not DoesWindowNameExist("ItemMat" .. tot)) then
				CreateWindowFromTemplate( "ItemMat" .. tot, "ImbRowTemplate", "ImbuingCalcMaterialsContent" )
			end
			
			local text =  key .. ": " .. mat.total
			if mat.current and mat.current > 0 then
				text = text .. " (" .. mat.current .. ")"
				LabelSetTextColor("ItemMat" .. tot.."Label",255,0,0)
			else
				LabelSetTextColor("ItemMat" .. tot.."Label",255,255,255)
			end
			
			LabelSetText("ItemMat" .. tot .. "Label", StringToWString(text))
			WindowClearAnchors("ItemMat" .. tot)
			if (tot <= 1) then
				WindowAddAnchor("ItemMat" .. tot, "topleft", "ImbuingCalcMaterialsContent", "topleft", 10, 40)
			else
				WindowAddAnchor("ItemMat" .. tot, "bottomleft", "ItemMat" .. tot-1, "topleft", 0, 5)
			end
		end	
		ImbuingCalcWindow.ActualMats = tot
	end
	
	ImbuingCalcWindow.UpdateIcon(WindowGetId("ImbuingCalcWindowSoket"))
end

function ImbuingCalcWindow.ShowMatToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 646))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ImbuingCalcWindow.HideMatToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 647))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ImbuingCalcWindow.ShowMat()
	WindowSetShowing("ImbuingCalcMaterialsWindow", true)
	WindowSetShowing("ImbuingCalcWindowShowButton", false)
	WindowClearAnchors("ImbuingCalcMaterialsWindow")
	WindowAddAnchor("ImbuingCalcMaterialsWindow","TopRight", "ImbuingCalcWindow", "TopLeft", 0, 0)
end

function ImbuingCalcWindow.HideMat()
	WindowSetShowing("ImbuingCalcWindowShowButton", true)   
	WindowSetShowing("ImbuingCalcMaterialsWindow", false)
end

function ImbuingCalcWindow.ItemCioMouseOver()
	local this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	if (id > 1) then
		LabelSetTextColor(this.."Label",255,0,0)
		if (not ImbuingCalcWindow.Property[id].ignore and ImbuingCalcWindow.Property[id].materials) then
			local mats = string.split(ImbuingCalcWindow.Property[id].materials, "|")
			local vls = string.split(ImbuingCalcWindow.Property[id].required, "|")
			local tot = 0
			
			if (mats) then
				for i = 1 , table.getn(mats) do
					for key, mat in pairsByKeys(ImbuingCalcWindow.Materials) do
					
						tot = tot + 1
						if (key == mats[i]) then
							if (tonumber(vls[i]) > 0) then
								mat.current = tonumber(vls[i])
							end
						end
						
					end
				end
			end
		end
	end

end

function ImbuingCalcWindow.ClearMouseOverItem()
	local this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	if (id > 1) then
		LabelSetTextColor(this.."Label",255,255,255)
		if (not ImbuingCalcWindow.Property[id].ignore and ImbuingCalcWindow.Property[id].materials) then
			local mats = string.split(ImbuingCalcWindow.Property[id].materials, "|")
			local vls = string.split(ImbuingCalcWindow.Property[id].required, "|")
			local tot = 0
			if (mats) then
				for i = 1 , table.getn(mats) do
					for key, mat in pairsByKeys(ImbuingCalcWindow.Materials) do
					
						tot = tot + 1
						if (key == mats[i]) then
							if (tonumber(vls[i]) > 0) then
								mat.current = 0
							end
						end
						
					end
				end
			end
		end
	end

end

function ImbuingCalcWindow.AddMod()
	if (ComboBoxGetSelectedMenuItem( "ImbuingCalcWindowMods") and ComboBoxGetSelectedMenuItem( "ImbuingCalcWindowMods") > 0) then
		if (ImbuingCalcWindow.Mods[ComboBoxGetSelectedMenuItem( "ImbuingCalcWindowMods")]) then
			local tbl = {raw = ImbuingCalcWindow.Mods[ComboBoxGetSelectedMenuItem( "ImbuingCalcWindowMods")].raw }
			if (ImbuingCalcWindow.Mods[ComboBoxGetSelectedMenuItem( "ImbuingCalcWindowMods")].cap) then
				
				if tonumber(ImbuingCalcWindow.Mods[ComboBoxGetSelectedMenuItem( "ImbuingCalcWindowMods")].cap) then
					local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,643), subtitle=GetStringFromTid(1062300), callfunction=ImbuingCalcWindow.Editvalue, id=2}
					RenameWindow.Create(rdata)
				end
			end
			local mod = tbl
			local ssi = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
			local di = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
			local sdi = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
			if (mod.raw == ssi or mod.raw == di or mod.raw == sdi) then
				mod.raw = mod.raw .. L"%%"
			end
			table.remove(ImbuingCalcWindow.Mods, ComboBoxGetSelectedMenuItem( "ImbuingCalcWindowMods"))
			table.insert(ImbuingCalcWindow.Property, 2, mod)
			ImbuingCalcWindow.Parse()
			
		end
	end
end

function ImbuingCalcWindow.RemoveMod(id)
	local this = SystemData.ActiveWindow.name
	if (not ImbuingCalcWindow.Property[id].cantRemove) then
		table.remove(ImbuingCalcWindow.Property, id)
		 local tot = 0
		ComboBoxClearMenuItems( "ImbuingCalcWindowMods" )
		ImbuingCalcWindow.Mods = {}
		for key, val in pairsByKeys(ItemPropertiesEvaluator.Mods) do
			
			local prop = wstring.lower(key)
			prop = wstring.gsub(prop, L"[+]", L"")
			if (prop == L"faster casting") then
				prop = wstring.lower(wstring.gsub(GetStringFromTid(1060413), ItemPropertiesEvaluator.escape2, L""))
			end
			if (prop == L"damage increase") then
				prop = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
			end
			if (prop == L"sdi") then
				prop = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
			end
			if (prop == L"swing speed increase") then
				prop = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
			end
			if (not val.type) then
				tot = tot + 1
				grp = L""
				if (val.grp) then
					grp = L" (" .. val.grp .. L")"
				end
				
				ImbuingCalcWindow.Mods[tot] = {}
				ImbuingCalcWindow.Mods[tot].raw = prop
				ImbuingCalcWindow.Mods[tot].cantRemove = false
				ImbuingCalcWindow.Mods[tot].cap = val.range	
				ImbuingCalcWindow.Mods[tot].combo = prop .. grp
			end

		end
    	for i = 1, tot do
    		if (ImbuingCalcWindow.Mods[i]) then
	    	
				ComboBoxAddMenuItem( "ImbuingCalcWindowMods", WindowUtils.Decapitalizing(ImbuingCalcWindow.Mods[i].combo) )
			end
		end
		ImbuingCalcWindow.Parse()
	end
end

function ImbuingCalcWindow.Context()
	local this = SystemData.ActiveWindow.name
	local param = WindowGetId(this)
	local cant = 0
	if (not ImbuingCalcWindow.Property[param].cap) then
		cant = 1
	end
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 641),cant,"EditValue",param,false)
	
	local cant = 1
	if (not ImbuingCalcWindow.Property[param].cantRemove) then
		cant = 0
	end
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 642),cant,"Remove",param,false)
	
	cant = false
	if (ImbuingCalcWindow.Property[param].ignore) then
		cant = true
	end
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 648),0,"Ignore",param,cant)
	
	ContextMenu.ActivateLuaContextMenu(ImbuingCalcWindow.ContextMenuCallback)
end

function ImbuingCalcWindow.ContextMenuCallback( returnCode, param )
	if ( returnCode=="EditValue" ) then
		local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,643), subtitle=GetStringFromTid(1062300), callfunction=ImbuingCalcWindow.Editvalue, id=param}
		RenameWindow.Create(rdata)
	elseif ( returnCode=="Remove" ) then
		ImbuingCalcWindow.RemoveMod(param)
	elseif ( returnCode=="Ignore" ) then
		ImbuingCalcWindow.Property[param].ignore = not ImbuingCalcWindow.Property[param].ignore

		ImbuingCalcWindow.Parse()
	end
end
function ImbuingCalcWindow.Editvalue(j, newval)
	newval =tonumber(newval)
	if (ImbuingCalcWindow.Property[j].min and newval ~= 0) then
		if (newval <= tonumber(ImbuingCalcWindow.Property[j].min)) then
			newval = tonumber(ImbuingCalcWindow.Property[j].min)
		end
	end
	if (ImbuingCalcWindow.Property[j].cap) then
		if (newval > tonumber(ImbuingCalcWindow.Property[j].cap)) then
			newval = tonumber( ImbuingCalcWindow.Property[j].cap)
		end
	end
	ImbuingCalcWindow.Property[j].newVal = newval
	
	ImbuingCalcWindow.Parse()
end

function ImbuingCalcWindow.Parse()
	
	local ret = true
	ImbuingCalcWindow.ClearList()
	ImbuingCalcWindow.totalWeight = 0
	ImbuingCalcWindow.exc = false
	if (ImbuingCalcWindow.Property and table.getn(ImbuingCalcWindow.Property) > 0) then
		local name = wstring.lower(ImbuingCalcWindow.Property[1].raw)

		if (IsArtifact(name) or IsSet(name)) then
			--Debug.Print(name .. L" ----> Not Imbueable (artifact/set)")
			ImbuingCalcWindow.ClearAll()
			ret =  false
		else
			for k,v in pairs(ItemPropertiesEvaluator.ArmorNames) do
				local org = k
				k = wstring.gsub(k, L"%[" , L"")
				k = wstring.gsub(k, L"%]" , L"")
				if (wstring.find(name, wstring.lower(k))) then
					--Debug.Print(name .. L" ----> Is Armor")
					
					ImbuingCalcWindow.type = ImbuingCalcWindow.TYPE_ARMOR
					local tot = 1
					
								
					CreateWindowFromTemplate( "Item" .. tot, "ImbRowTemplate", "ImbuingCalcContent" )
					LabelSetText("Item" .. tot .. "Label", GetStringFromTid(1062761))
					LabelSetTextColor("Item" .. tot .. "Label", 217,217,25)
					WindowSetId("Item"..tot, tot)
					WindowAddAnchor("Item" .. tot, "topleft", "ImbuingCalcContent", "topleft", 20, 20)

					LabelSetText("Item" .. tot .. "Val", GetStringFromTid(1062298))
					LabelSetTextColor("Item" .. tot .. "Val", 217,217,25)
					
					LabelSetText("Item" .. tot .. "Cap", GetStringFromTid(1062299))
					LabelSetTextColor("Item" .. tot .. "Cap", 217,217,25)
	
					LabelSetText("Item" .. tot .. "NewVal", GetStringFromTid(1062300))
					LabelSetTextColor("Item" .. tot .. "NewVal", 217,217,25)
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw
						if (wstring.lower(lprop) == wstring.lower(GetStringFromTid(1060636))) then
							ImbuingCalcWindow.exc = true
						end
					end				
					
							
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw
						
						local sdi = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
						if (wstring.find(wstring.lower(lprop),sdi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),sdi)
							lprop = L"sdi " .. wstring.sub(lprop, m_end+1)
						end
						
						local di = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
						if (wstring.find(wstring.lower(lprop),di) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),di)
							lprop = L"damage increase " .. wstring.sub(lprop, m_end+1)
						end
						
						local ssi = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
						if (wstring.find(wstring.lower(lprop),ssi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),ssi)
							lprop = L"swing speed increase " .. wstring.sub(lprop, m_end+1)
						end
						
						if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN and not wstring.find(wstring.lower(lprop),GetStringFromTid(1062755)) ) then
							lprop = wstring.gsub(lprop, L"%-", L"")
						end
						local FC = wstring.lower(wstring.gsub(GetStringFromTid(1060413), ItemPropertiesEvaluator.escape2, L""))
						local FCR = wstring.lower(wstring.gsub(GetStringFromTid(1060412), ItemPropertiesEvaluator.escape2, L""))
						if (wstring.find(wstring.lower(lprop), FC)  ) then
							if (wstring.find(wstring.lower(lprop), FCR) == nil ) then
								m_start, m_end = wstring.find(wstring.lower(lprop),FC)
								lprop = L"faster casting".. wstring.sub(lprop, m_end+1)
							end
						end
						
						local strBonus = wstring.lower(wstring.gsub(GetStringFromTid(1060485), ItemPropertiesEvaluator.escape2, L""))
						if (wstring.find(wstring.lower(lprop), strBonus)  and SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
							if (wstring.find(wstring.lower(lprop), L"+") == nil ) then
								m_start, m_end = wstring.find(wstring.lower(lprop),strBonus)
								lprop = L"strength requirement ".. wstring.sub(lprop, m_end+1)
							end
						end
						
						lprop = wstring.gsub(lprop, L"%[" , L"")
						lprop = wstring.gsub(lprop, L"%]" , L"")
						local value = 0
						local mod = L""
						local cap = 0
						local min = 0
						local weight = 0
						local ignore = false
						local materials = ""
						local matAmount = ""
						for l, m in pairs(ItemPropertiesEvaluator.Mods) do
							l = wstring.gsub(l, L"%[" , L"")
							l = wstring.gsub(l, L"%]" , L"")
							m_start, m_end = wstring.find(wstring.lower(lprop), wstring.lower(l))
							if m_start and m.type ~= ItemPropertiesEvaluator.TYPE_SKIP then
								value = wstring.sub(lprop, m_end+1)
								mod = wstring.gsub(l, L"[+]", L"")
								cap = m.range
								weight = m.weight
								local physical = L"physical resist"
								local fire = L"fire resist"
								local cold = L"cold resist"
								local poison = L"poison resist"
								local energy = L"energy resist"
								
								materials = m.materials
								if m.en == physical or m.en == fire or m.en ==  cold or m.en == poison or m.en == energy then
									cap = cap + v[m.en]
									min = tonumber(v[m.en])
								else
									ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods +1
								end
								if ((m.en == physical or m.en == fire or m.en ==  cold or m.en == poison or m.en == energy)) then
									if (tonumber(value) > 12  or (ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) >0 )) then
										ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods +1
									end
									
								end
								
								
								if (mod == GetStringFromTid(1062755)) then
									min = -30
									cap = -20
								end
			
								if m.en == L"durability" and not wstring.find(lprop, L"%%") then
									ImbuingCalcWindow.durability = wstring.gsub(value, wstring.find(lprop, L" / ")+3)
									mod = L""
									ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods -1
								end
								
								break
							end
						end 
						
						if mod ~= L"" then
							
							tot = tot +1
							ImbuingCalcWindow.Property[tot].mod = mod
							ImbuingCalcWindow.Property[tot].min = min
							ImbuingCalcWindow.Property[tot].value = value
							ImbuingCalcWindow.Property[tot].cap = cap
							ImbuingCalcWindow.Property[tot].weight = weight
							ImbuingCalcWindow.Property[tot].ignore = ImbuingCalcWindow.Property[tot].ignore or ignore
							local mats = nil
							if ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) >0 then
								value = tonumber(ImbuingCalcWindow.Property[tot].newVal)
							end
							local mats = nil
							local mts = ""
							local vls = ""
							if (materials and not ImbuingCalcWindow.Property[tot].ignore ) then
								mats = string.split(materials, "|")
								if (mats) then
									for i = 1 , table.getn(mats) do
										local amt = 0
										if (value == "" or cap == "") then
											value = 100
											cap = 100
										end
										if (tonumber(value) < -1) then
											value = 30 + value
											cap = 30 + cap
										end
										if (i == 1) then
											
											amt= math.floor(value / (cap * 0.2))

											if amt < 1 then
												amt = 1
											end
											if amt > 5 then
												amt = 5
											end
										elseif (i == 2) then
											amt = math.floor(value / (cap * 0.1))
											if amt < 1 then
												amt = 1
											end
											if amt > 10 then
												amt = 10
											end
										elseif (i == 3) then
											local variation = cap - (cap * 0.1)
											amt = math.floor(((value - variation) / (cap * 0.01)))
											amt = amt +1
											if amt < 0 then
												amt = 0
											end
											if amt > 10 then
												amt = 10
											end
										end
										if (tonumber(value) == -1) then
											amt = 0
										end
										if (ImbuingCalcWindow.Materials[mats[i]]) then
											
											ImbuingCalcWindow.Materials[mats[i]].total = ImbuingCalcWindow.Materials[mats[i]].total + amt
										else
											ImbuingCalcWindow.Materials[mats[i]] = {}
											ImbuingCalcWindow.Materials[mats[i]].total = amt
										end
										if i > 1 then
											mts = mts .. "|" .. mats[i] 
											vls = vls .. "|" .. amt
										else
											mts = mats[i] 
											vls =  amt
										end
									end
								end
								ImbuingCalcWindow.Property[tot].materials = mts
								ImbuingCalcWindow.Property[tot].required = vls
							end
							
							
							if not ImbuingCalcWindow.Property[tot].ignore then
								
								if  ImbuingCalcWindow.Property[tot].value and ImbuingCalcWindow.Property[tot].cap and ImbuingCalcWindow.Property[tot].cap ~= "" then
									local wgt = tonumber(ImbuingCalcWindow.Property[tot].weight) --* 100
									local cap = tonumber(ImbuingCalcWindow.Property[tot].cap)  - tonumber(ImbuingCalcWindow.Property[tot].min)
									local v = tonumber(ImbuingCalcWindow.Property[tot].value)  - tonumber(ImbuingCalcWindow.Property[tot].min)
									if (ImbuingCalcWindow.Property[tot].newVal and ImbuingCalcWindow.Property[tot].newVal ~= "" and tonumber(ImbuingCalcWindow.Property[tot].newVal) > 0) then
										v = tonumber(ImbuingCalcWindow.Property[tot].newVal)   - tonumber(ImbuingCalcWindow.Property[tot].min)
									end
									--Debug.Print( (math.floor(( v / cap )* 100) * wgt ))
									ImbuingCalcWindow.totalWeight = ImbuingCalcWindow.totalWeight + math.floor((( v / cap )* 100) * wgt )
								else
									local wgt = ImbuingCalcWindow.Property[tot].weight * 100
									ImbuingCalcWindow.totalWeight = ImbuingCalcWindow.totalWeight + wgt
								end
							end
							
							for z = 1, table.getn(ImbuingCalcWindow.Mods) do
    							if (ImbuingCalcWindow.Mods[z] ) then
    								if (ImbuingCalcWindow.Property[tot].mod == ImbuingCalcWindow.Mods[z].raw) then
										table.remove(ImbuingCalcWindow.Mods, z)
										break
									end
								end
							end
							CreateWindowFromTemplate( "Item" .. tot, "ImbRowTemplate", "ImbuingCalcContent" )
							WindowSetId("Item"..tot, tot)
							WindowSetShowing("Item" .. tot, true)
							
							LabelSetTextAlign("Item" .. tot .. "Val", "center")
							
							LabelSetTextAlign("Item" .. tot .. "Cap", "center")
							
							LabelSetText("Item" .. tot .. "Label", WindowUtils.Decapitalizing(ImbuingCalcWindow.Property[tot].mod))
							if (ImbuingCalcWindow.Property[tot].value and tonumber(ImbuingCalcWindow.Property[tot].value) and tonumber(ImbuingCalcWindow.Property[tot].value) > 0) then
								LabelSetText("Item" .. tot .. "Val", L"" .. tonumber(ImbuingCalcWindow.Property[tot].value))
							end
							
							if (ImbuingCalcWindow.Property[tot].cap and tonumber(ImbuingCalcWindow.Property[tot].cap) and tonumber(ImbuingCalcWindow.Property[tot].cap) > 0) then
								LabelSetText("Item" .. tot .. "Cap", L"" .. tonumber(ImbuingCalcWindow.Property[tot].cap))
							end
							LabelSetText("Item" .. tot .. "Label", WindowUtils.Decapitalizing(mod))

							if (ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) and tonumber(ImbuingCalcWindow.Property[tot].newVal) > 0) then
								LabelSetText("Item" .. tot .. "NewVal", L"" .. tonumber(ImbuingCalcWindow.Property[tot].newVal))
							end
							
							WindowClearAnchors("Item" .. tot)
							if (tot <= 1) then
								WindowAddAnchor("Item" .. tot, "topleft", "ImbuingCalcContent", "topleft", 10, 20)
							else
								WindowAddAnchor("Item" .. tot, "bottomleft", "Item" .. tot-1, "topleft", 0, 5)
							end
						end
					end
					local capWgt = 450
					if ImbuingCalcWindow.exc then
						capWgt = 500
					end
					LabelSetText("ImbuingCalcWindowTotalVal", ImbuingCalcWindow.totalWeight .. L" / " .. capWgt)
					if (ImbuingCalcWindow.totalWeight >= capWgt) then
						LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 0, 0)
					else
						LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 255, 255)
					end
					local PofCharges = math.ceil((255 - ImbuingCalcWindow.durability) / 10)
					local jars = math.ceil(PofCharges/10)
		
					LabelSetText("ImbuingCalcWindowPOFLabel", UI.GetCliloc(SystemData.Settings.Language.type, 519).. L" " .. PofCharges .. L" (" .. jars .. L" " .. UI.GetCliloc(SystemData.Settings.Language.type, 520) .. L")")
					LabelSetTextColor("ImbuingCalcWindowPOFLabel", 255, 0, 0)
					
					last = tot
					if last > 0 then
						local ySize = 20 + (30 * last)
						WindowSetDimensions("ImbuingCalcContent",695, ySize)
					end
					ImbuingCalcWindow.VisibleItems = last
					ScrollWindowUpdateScrollRect( "ImbuingCalcContentWindow" )
					if (ImbuingCalcWindow.totalMods >= 5) then
						WindowSetShowing("ImbuingCalcWindowMods", false)
						ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", true )
					else
						WindowSetShowing("ImbuingCalcWindowMods", true)
						ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", false )
					end
					ComboBoxClearMenuItems( "ImbuingCalcWindowMods" )
					for z = 1, table.getn(ImbuingCalcWindow.Mods) do
    					if (ImbuingCalcWindow.Mods[z]) then
			    		
							ComboBoxAddMenuItem( "ImbuingCalcWindowMods", WindowUtils.Decapitalizing(ImbuingCalcWindow.Mods[z].combo) )
						end
					end
					return true
					
				end
			end
			
			for k,v in pairs(ItemPropertiesEvaluator.ShieldNames) do
				local org = k
				k = wstring.gsub(k, L"%[" , L"")
				k = wstring.gsub(k, L"%]" , L"")
				if (wstring.find(name, wstring.lower(k))) then
					--Debug.Print(name .. L" ----> Is Shield")	
					ImbuingCalcWindow.type = ImbuingCalcWindow.TYPE_SHIELD 
					local tot = 1
					
								
					CreateWindowFromTemplate( "Item" .. tot, "ImbRowTemplate", "ImbuingCalcContent" )
					LabelSetText("Item" .. tot .. "Label", GetStringFromTid(1062761))
					LabelSetTextColor("Item" .. tot .. "Label", 217,217,25)
					WindowSetId("Item"..tot, tot)
					WindowAddAnchor("Item" .. tot, "topleft", "ImbuingCalcContent", "topleft", 20, 20)

					LabelSetText("Item" .. tot .. "Val", GetStringFromTid(1062298))
					LabelSetTextColor("Item" .. tot .. "Val", 217,217,25)
					
					LabelSetText("Item" .. tot .. "Cap", GetStringFromTid(1062299))
					LabelSetTextColor("Item" .. tot .. "Cap", 217,217,25)
	
					LabelSetText("Item" .. tot .. "NewVal", GetStringFromTid(1062300))
					LabelSetTextColor("Item" .. tot .. "NewVal", 217,217,25)
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw
						if (wstring.lower(lprop) == wstring.lower(GetStringFromTid(1060636))) then
							ImbuingCalcWindow.exc = true
						end
					end				
					
							
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw
												
						local sdi = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
						if (wstring.find(wstring.lower(lprop),sdi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),sdi)
							lprop = L"sdi " .. wstring.sub(lprop, m_end+1)
						end
						
						local di = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
						if (wstring.find(wstring.lower(lprop),di) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),di)
							lprop = L"damage increase " .. wstring.sub(lprop, m_end+1)
						end
						
						local ssi = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
						if (wstring.find(wstring.lower(lprop),ssi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),ssi)
							lprop = L"swing speed increase " .. wstring.sub(lprop, m_end+1)
						end
						
						if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN and not wstring.find(wstring.lower(lprop),GetStringFromTid(1062755)) ) then
							lprop = wstring.gsub(lprop, L"%-", L"")
						end
						local FC = wstring.lower(wstring.gsub(GetStringFromTid(1060413), ItemPropertiesEvaluator.escape2, L""))
						local FCR = wstring.lower(wstring.gsub(GetStringFromTid(1060412), ItemPropertiesEvaluator.escape2, L""))
						if (wstring.find(wstring.lower(lprop), FC)  ) then
							if (wstring.find(wstring.lower(lprop), FCR) == nil ) then
								m_start, m_end = wstring.find(wstring.lower(lprop),FC)
								lprop = L"faster casting".. wstring.sub(prlpropop, m_end+1)
							end
						end
						
						local strBonus = wstring.lower(wstring.gsub(GetStringFromTid(1060485), ItemPropertiesEvaluator.escape2, L""))
						if (wstring.find(wstring.lower(lprop), strBonus)  and SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
							if (wstring.find(wstring.lower(lprop), L"+") == nil ) then
								m_start, m_end = wstring.find(wstring.lower(lprop),strBonus)
								lprop = L"strength requirement ".. wstring.sub(lprop, m_end+1)
							end
						end
						
						lprop = wstring.gsub(lprop, L"%[" , L"")
						lprop = wstring.gsub(lprop, L"%]" , L"")
						local value = 0
						local mod = L""
						local cap = 0
						local min = 0
						local weight = 0
						local ignore = false
						local materials = ""
						for l, m in pairs(ItemPropertiesEvaluator.Mods) do
							l = wstring.gsub(l, L"%[" , L"")
							l = wstring.gsub(l, L"%]" , L"")
							m_start, m_end = wstring.find(wstring.lower(lprop), wstring.lower(l))
							local physical = L"physical resist"
							local fire = L"fire resist"
							local cold = L"cold resist"
							local poison = L"poison resist"
							local energy = L"energy resist"
							if m_start and m.type ~= ItemPropertiesEvaluator.TYPE_SKIP and m.en ~= physical and m.en ~= fire and m.en ~= cold and m.en ~= poison and m.en ~= energy then
								value = wstring.sub(lprop, m_end+1)
								mod = wstring.gsub(l, L"[+]", L"")
								cap = m.range
								weight = m.weight
								
								materials = m.materials
		
								if (m.en == physical or m.en == fire or m.en ==  cold or m.en == poison or m.en == energy) and v[m.en] then
									cap = cap + v[m.en]
									min = tonumber(v[m.en])
								else
									ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods +1
								end

								if ((m.en == physical or m.en == fire or m.en ==  cold or m.en == poison or m.en == energy)) then
									if (tonumber(value) > 12 or (ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) >0 )) then
										ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods +1
									end
									
								end
								
								if (mod == GetStringFromTid(1062755)) then
									min = -30
									cap = -20
								end
			
								if m.en == L"durability" and not wstring.find(lprop, L"%%") then
									ImbuingCalcWindow.durability = value
									mod = L""
									ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods -1
								end
								
								
								
								break
							end
						end 
						
						if mod ~= L"" then
							
							tot = tot +1
							ImbuingCalcWindow.Property[tot].mod = mod
							ImbuingCalcWindow.Property[tot].min = min
							ImbuingCalcWindow.Property[tot].value = value
							ImbuingCalcWindow.Property[tot].cap = cap
							ImbuingCalcWindow.Property[tot].weight = weight
							ImbuingCalcWindow.Property[tot].ignore = ImbuingCalcWindow.Property[tot].ignore or ignore
							local mats = nil
							if ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) >0 then
								value = tonumber(ImbuingCalcWindow.Property[tot].newVal)
							end
							local mats = nil
							local mts = ""
							local vls = ""
							if (materials and not ImbuingCalcWindow.Property[tot].ignore ) then
								mats = string.split(materials, "|")
								if (mats) then
									for i = 1 , table.getn(mats) do
										local amt = 0
										if (value == "" or cap == "") then
											value = 100
											cap = 100
										end
										if (tonumber(value) < -1) then
											value = 30 + value
											cap = 30 + cap
										end
										if (i == 1) then
											
											amt= math.floor(value / (cap * 0.2))

											if amt < 1 then
												amt = 1
											end
											if amt > 5 then
												amt = 5
											end
										elseif (i == 2) then
											amt = math.floor(value / (cap * 0.1))
											if amt < 1 then
												amt = 1
											end
											if amt > 10 then
												amt = 10
											end
										elseif (i == 3) then
											local variation = cap - (cap * 0.1)
											amt = math.floor(((value - variation) / (cap * 0.01)))
											amt = amt +1
											if amt < 0 then
												amt = 0
											end
											if amt > 10 then
												amt = 10
											end
										end
										if (tonumber(value) == -1) then
											amt = 0
										end
										if (ImbuingCalcWindow.Materials[mats[i]]) then
											
											ImbuingCalcWindow.Materials[mats[i]].total = ImbuingCalcWindow.Materials[mats[i]].total + amt
										else
											ImbuingCalcWindow.Materials[mats[i]] = {}
											ImbuingCalcWindow.Materials[mats[i]].total = amt
										end
										if i > 1 then
											mts = mts .. "|" .. mats[i] 
											vls = vls .. "|" .. amt
										else
											mts = mats[i] 
											vls =  amt
										end
									end
								end
								ImbuingCalcWindow.Property[tot].materials = mts
								ImbuingCalcWindow.Property[tot].required = vls
							end
							
							
							if not ImbuingCalcWindow.Property[tot].ignore then
								
								if  ImbuingCalcWindow.Property[tot].value and ImbuingCalcWindow.Property[tot].cap and ImbuingCalcWindow.Property[tot].cap ~= "" then
									local wgt = tonumber(ImbuingCalcWindow.Property[tot].weight) --* 100
									local cap = tonumber(ImbuingCalcWindow.Property[tot].cap)  - tonumber(ImbuingCalcWindow.Property[tot].min)
									local v = tonumber(ImbuingCalcWindow.Property[tot].value)  - tonumber(ImbuingCalcWindow.Property[tot].min)
									if (ImbuingCalcWindow.Property[tot].newVal and ImbuingCalcWindow.Property[tot].newVal ~= "" and tonumber(ImbuingCalcWindow.Property[tot].newVal) > 0) then
										v = tonumber(ImbuingCalcWindow.Property[tot].newVal)   - tonumber(ImbuingCalcWindow.Property[tot].min)
									end
									--Debug.Print( (math.floor(( v / cap )* 100) * wgt ))
									ImbuingCalcWindow.totalWeight = ImbuingCalcWindow.totalWeight + math.floor((( v / cap )* 100) * wgt )
								else
									local wgt = ImbuingCalcWindow.Property[tot].weight * 100
									ImbuingCalcWindow.totalWeight = ImbuingCalcWindow.totalWeight + wgt
								end
							end
							
							for z = 1, table.getn(ImbuingCalcWindow.Mods) do
    							if (ImbuingCalcWindow.Mods[z] ) then
    								if (ImbuingCalcWindow.Property[tot].mod == ImbuingCalcWindow.Mods[z].raw) then
										table.remove(ImbuingCalcWindow.Mods, z)
										break
									end
								end
							end
							CreateWindowFromTemplate( "Item" .. tot, "ImbRowTemplate", "ImbuingCalcContent" )
							WindowSetId("Item"..tot, tot)
							WindowSetShowing("Item" .. tot, true)
							
							LabelSetTextAlign("Item" .. tot .. "Val", "center")
							
							LabelSetTextAlign("Item" .. tot .. "Cap", "center")
							
							LabelSetText("Item" .. tot .. "Label", WindowUtils.Decapitalizing(ImbuingCalcWindow.Property[tot].mod))
							if (ImbuingCalcWindow.Property[tot].value and tonumber(ImbuingCalcWindow.Property[tot].value) and tonumber(ImbuingCalcWindow.Property[tot].value) > 0) then
								LabelSetText("Item" .. tot .. "Val", L"" .. tonumber(ImbuingCalcWindow.Property[tot].value))
							end
							
							if (ImbuingCalcWindow.Property[tot].cap and tonumber(ImbuingCalcWindow.Property[tot].cap) and tonumber(ImbuingCalcWindow.Property[tot].cap) > 0) then
								LabelSetText("Item" .. tot .. "Cap", L"" .. tonumber(ImbuingCalcWindow.Property[tot].cap))
							end
							LabelSetText("Item" .. tot .. "Label", WindowUtils.Decapitalizing(mod))

							if (ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) and tonumber(ImbuingCalcWindow.Property[tot].newVal) > 0) then
								LabelSetText("Item" .. tot .. "NewVal", L"" .. tonumber(ImbuingCalcWindow.Property[tot].newVal))
							end
							
							WindowClearAnchors("Item" .. tot)
							if (tot <= 1) then
								WindowAddAnchor("Item" .. tot, "topleft", "ImbuingCalcContent", "topleft", 10, 20)
							else
								WindowAddAnchor("Item" .. tot, "bottomleft", "Item" .. tot-1, "topleft", 0, 5)
							end
						end
					end
					local capWgt = 400
					if ImbuingCalcWindow.exc then
						capWgt = 450
					end
					LabelSetText("ImbuingCalcWindowTotalVal", ImbuingCalcWindow.totalWeight .. L" / " .. capWgt)
					if (ImbuingCalcWindow.totalWeight >= capWgt) then
						LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 0, 0)
					else
						LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 255, 255)
					end
					local PofCharges = math.ceil((255 - ImbuingCalcWindow.durability) / 10)
					local jars = math.ceil(PofCharges/10)
		
					LabelSetText("ImbuingCalcWindowPOFLabel", UI.GetCliloc(SystemData.Settings.Language.type, 519).. L" " .. PofCharges .. L" (" .. jars .. L" " .. UI.GetCliloc(SystemData.Settings.Language.type, 520) .. L")")
					LabelSetTextColor("ImbuingCalcWindowPOFLabel", 255, 0, 0)
					
					last = tot
					if last > 0 then
						local ySize = 20 + (30 * last)
						WindowSetDimensions("ImbuingCalcContent",695, ySize)
					end
					ImbuingCalcWindow.VisibleItems = last
					ScrollWindowUpdateScrollRect( "ImbuingCalcContentWindow" )
					if (ImbuingCalcWindow.totalMods >= 5) then
						WindowSetShowing("ImbuingCalcWindowMods", false)
						ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", true )
					else
						WindowSetShowing("ImbuingCalcWindowMods", true)
						ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", false )
					end
					ComboBoxClearMenuItems( "ImbuingCalcWindowMods" )
					for z = 1, table.getn(ImbuingCalcWindow.Mods) do
    					if (ImbuingCalcWindow.Mods[z]) then
			    		
							ComboBoxAddMenuItem( "ImbuingCalcWindowMods", WindowUtils.Decapitalizing(ImbuingCalcWindow.Mods[z].combo) )
						end
					end
					return true
				end
			end
			ImbuingCalcWindow.twohanded = false
			for k,v in pairs(ItemPropertiesEvaluator.WeaponNames) do
				local org = k
				k = wstring.gsub(k, L"%[" , L"")
				k = wstring.gsub(k, L"%]" , L"")
				if (wstring.find(name, wstring.lower(k))) then
					--Debug.Print(name .. L" ----> Is Weapon")
					ImbuingCalcWindow.type = ImbuingCalcWindow.TYPE_WEAPON
					local tot = 1
					
								
					CreateWindowFromTemplate( "Item" .. tot, "ImbRowTemplate", "ImbuingCalcContent" )
					LabelSetText("Item" .. tot .. "Label", GetStringFromTid(1062761))
					LabelSetTextColor("Item" .. tot .. "Label", 217,217,25)
					WindowSetId("Item"..tot, tot)
					WindowAddAnchor("Item" .. tot, "topleft", "ImbuingCalcContent", "topleft", 20, 20)

					LabelSetText("Item" .. tot .. "Val", GetStringFromTid(1062298))
					LabelSetTextColor("Item" .. tot .. "Val", 217,217,25)
					
					LabelSetText("Item" .. tot .. "Cap", GetStringFromTid(1062299))
					LabelSetTextColor("Item" .. tot .. "Cap", 217,217,25)
	
					LabelSetText("Item" .. tot .. "NewVal", GetStringFromTid(1062300))
					LabelSetTextColor("Item" .. tot .. "NewVal", 217,217,25)
					
					ImbuingCalcWindow.ranged = false
					
										
					if (v.isBow) then		
						ImbuingCalcWindow.ranged = true
						ImbuingCalcWindow.boomerang = v.isBoomerang
					end
								
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw
						local ssi = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
						if (wstring.find(wstring.lower(lprop),ssi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),ssi)
							ImbuingCalcWindow.ssi = tonumber(wstring.sub(lprop, m_end+1))
							if ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) >0 then
								ImbuingCalcWindow.ssi = ImbuingCalcWindow.Property[tot].newVal
							end
						end
						if (wstring.lower(lprop) == wstring.lower(GetStringFromTid(1060636))) then
							ImbuingCalcWindow.exc = true
						end
						
						if (wstring.find(wstring.lower(lprop), wstring.lower(wstring.gsub(GetStringFromTid(1061167), ItemPropertiesEvaluator.escape2, L""))) ) then
							m_start, m_end = wstring.find(wstring.lower(lprop),wstring.lower(wstring.gsub(GetStringFromTid(1061167), ItemPropertiesEvaluator.escape2, L"")))
							ImbuingCalcWindow.speed = tonumber(wstring.sub(lprop, m_end+1))
						end
						if (wstring.lower(lprop) == wstring.lower(GetStringFromTid(1061171))) then -- two handed
							ImbuingCalcWindow.twohanded = true
						end
					end			
					
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw				
						
						local sdi = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
						if (wstring.find(wstring.lower(lprop),sdi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),sdi)
							lprop = L"sdi " .. wstring.sub(lprop, m_end+1)
						end
						
						local di = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
						if (wstring.find(wstring.lower(lprop),di) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),di)
							lprop = L"damage increase " .. wstring.sub(lprop, m_end+1)
						end

						local ssi = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
						if (wstring.find(wstring.lower(lprop),ssi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),ssi)
							lprop = L"swing speed increase " .. wstring.sub(lprop, m_end+1)
							
							
							if ImbuingCalcWindow.Property[j].newVal and tonumber(ImbuingCalcWindow.Property[j].newVal) >0 then
								ImbuingCalcWindow.ssi = ImbuingCalcWindow.Property[j].newVal
							else
								ImbuingCalcWindow.ssi = tonumber(wstring.sub(lprop, m_end+1))
							end
						end
						
					end
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw
						if wstring.lower(lprop) == GetStringFromTid(1060636) then -- L"exceptional"
						elseif wstring.lower(lprop) == GetStringFromTid(1060437)  then -- L"mage armor"
						end
												
						if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN and not wstring.find(wstring.lower(lprop),GetStringFromTid(1062755)) ) then
							lprop = wstring.gsub(lprop, L"%-", L"")
						end
						local FC = wstring.lower(wstring.gsub(GetStringFromTid(1060413), ItemPropertiesEvaluator.escape2, L""))
						local FCR = wstring.lower(wstring.gsub(GetStringFromTid(1060412), ItemPropertiesEvaluator.escape2, L""))
						if (wstring.find(wstring.lower(lprop), FC)  ) then
							if (wstring.find(wstring.lower(lprop), FCR) == nil ) then
								m_start, m_end = wstring.find(wstring.lower(lprop),FC)
								lprop = L"faster casting".. wstring.sub(lprop, m_end+1)
							end
						end
						
						local strBonus = wstring.lower(wstring.gsub(GetStringFromTid(1060485), ItemPropertiesEvaluator.escape2, L""))
						if (wstring.find(wstring.lower(lprop), strBonus)  and SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
							if (wstring.find(wstring.lower(lprop), L"+") == nil ) then
								m_start, m_end = wstring.find(wstring.lower(lprop),strBonus)
								lprop = L"strength requirement ".. wstring.sub(lprop, m_end+1)
							end
						end
						lprop = wstring.gsub(lprop, L"%[" , L"")
						lprop = wstring.gsub(lprop, L"%]" , L"")
						local value = 0
						local mod = L""
						local cap = 0
						local min = 0
						local weight = 0
						local ignore = false
						local materials = ""
						for l, m in pairs(ItemPropertiesEvaluator.Mods) do
							l = wstring.gsub(l, L"%[" , L"")
							l = wstring.gsub(l, L"%]" , L"")
							m_start, m_end = wstring.find(wstring.lower(lprop), wstring.lower(l))
							if m_start and m.type ~= ItemPropertiesEvaluator.TYPE_SKIP then
								value = wstring.sub(lprop, m_end+1)
								mod = wstring.gsub(l, L"[+]", L"")
								if (ImbuingCalcWindow.ranged and m.bowrange) then
									cap = m.bowrange
								else
									cap = m.range
								end
								
								if (l == wstring.gsub(GetStringFromTid(1060422), ItemPropertiesEvaluator.escape, L"") or l == wstring.gsub(GetStringFromTid(1060427), ItemPropertiesEvaluator.escape, L"")) then
									
									local part1 = tonumber(ImbuingCalcWindow.speed) * 4
									local part2 = 100 / (100 + tonumber(ImbuingCalcWindow.ssi))
									local swing = (part1 * part2) / 4 -- <- basic weapon swing speed
									
									local str = tostring(swing)
									
									if (string.find(str, ".")) then
										
										part1 = string.sub(str, 1,string.find(str, "."))

										part2 = string.sub(str, string.find(str, ".")+2, string.find(str, ".")+3)

										if (tonumber(part2) < 25) then
											part2 = 0
										elseif (tonumber(part2) < 50) then
											part2 = 25
										elseif (tonumber(part2) < 75) then
											part2 = 50
										elseif (tonumber(part2) <= 99) then
											part2 = 75
										end
										if (part2 > 0) then
											swing = part1 .. "." .. part2
										else
											swing = part1
										end
									end
									
									cap = ImbuingCalcWindow.LeechScale[StringToWString(swing)]
									
									if(ImbuingCalcWindow.ranged) then
										cap = math.floor(cap/2)
									end

									
								end
								
								if ImbuingCalcWindow.Property[j].newVal and tonumber(ImbuingCalcWindow.Property[j].newVal) > cap then
									ImbuingCalcWindow.Property[j].newVal = cap
								end
								
								if (ImbuingCalcWindow.ranged and m.materials_ranged) then
									materials = m.materials_ranged
								else
									materials = m.materials
								end
								weight = m.weight
								
								
								if (mod == GetStringFromTid(1062755)) then
									min = -29
									cap = -20
									value = string.gsub(WStringToString(wstring.lower(value)), " skill", "")
									
								end
			
								if m.en == L"durability" and not wstring.find(lprop, L"%%") then
									ImbuingCalcWindow.durability = value
									mod = L""
									ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods -1
								end
								
								
								
								break
							end
						end 

						if mod ~= L"" then
							tot = tot +1
							ImbuingCalcWindow.Property[tot].mod = mod
							ImbuingCalcWindow.Property[tot].min = min
							ImbuingCalcWindow.Property[tot].value = value
							ImbuingCalcWindow.Property[tot].cap = cap
							ImbuingCalcWindow.Property[tot].weight = weight
							ImbuingCalcWindow.Property[tot].ignore = ImbuingCalcWindow.Property[tot].ignore or ignore
							local mats = nil
							if ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) >0 then
								value = tonumber(ImbuingCalcWindow.Property[tot].newVal)
							end
							local mats = nil
							local mts = ""
							local vls = ""
							
							if (materials and not ImbuingCalcWindow.Property[tot].ignore ) then
								mats = string.split(materials, "|")
								if (mats) then
									for i = 1 , table.getn(mats) do
										local amt = 0
										if (value == "" or cap == "") then
											value = 100
											cap = 100
										end
										if (tonumber(value) < -1) then
											value = 30 + value
											cap = 30 + cap
										end
										if (tonumber(value) < -1) then
											value = 30 + value
											cap = 30 + cap
										end
										if (i == 1) then
											
											amt= math.floor(value / (cap * 0.2))

											if amt < 1 then
												amt = 1
											end
											if amt > 5 then
												amt = 5
											end
										elseif (i == 2) then
											amt = math.floor(value / (cap * 0.1))
											if amt < 1 then
												amt = 1
											end
											if amt > 10 then
												amt = 10
											end
										elseif (i == 3) then
											local variation = cap - (cap * 0.1)
											amt = math.floor(((value - variation) / (cap * 0.01)))
											amt = amt +1
											if amt < 0 then
												amt = 0
											end
											if amt > 10 then
												amt = 10
											end
										end
										if (tonumber(value) == -1) then
											amt = 0
										end
										if (ImbuingCalcWindow.Materials[mats[i]]) then
											
											ImbuingCalcWindow.Materials[mats[i]].total = ImbuingCalcWindow.Materials[mats[i]].total + amt
										else
											ImbuingCalcWindow.Materials[mats[i]] = {}
											ImbuingCalcWindow.Materials[mats[i]].total = amt
										end
										if i > 1 then
											mts = mts .. "|" .. mats[i] 
											vls = vls .. "|" .. amt
										else
											mts = mats[i] 
											vls =  amt
										end
									end
								end
								ImbuingCalcWindow.Property[tot].materials = mts
								ImbuingCalcWindow.Property[tot].required = vls
							end
							
							
							if not ImbuingCalcWindow.Property[tot].ignore then
								
								if  ImbuingCalcWindow.Property[tot].value and ImbuingCalcWindow.Property[tot].cap and ImbuingCalcWindow.Property[tot].cap ~= "" then
									local wgt = tonumber(ImbuingCalcWindow.Property[tot].weight) --* 100
									local cap = tonumber(ImbuingCalcWindow.Property[tot].cap)  - tonumber(ImbuingCalcWindow.Property[tot].min)
									local v = tonumber(ImbuingCalcWindow.Property[tot].value)  - tonumber(ImbuingCalcWindow.Property[tot].min)
									if (ImbuingCalcWindow.Property[tot].newVal and ImbuingCalcWindow.Property[tot].newVal ~= "" and tonumber(ImbuingCalcWindow.Property[tot].newVal) > 0) then
										v = tonumber(ImbuingCalcWindow.Property[tot].newVal)   - tonumber(ImbuingCalcWindow.Property[tot].min)
									end
									--Debug.Print( (math.floor(( v / cap )* 100) * wgt ))
									ImbuingCalcWindow.totalWeight = ImbuingCalcWindow.totalWeight + math.floor((( v / cap )* 100) * wgt )
								else
									local wgt = ImbuingCalcWindow.Property[tot].weight * 100
									ImbuingCalcWindow.totalWeight = ImbuingCalcWindow.totalWeight + wgt
								end
							end
							
							for z = 1, table.getn(ImbuingCalcWindow.Mods) do
    							if (ImbuingCalcWindow.Mods[z] ) then
    								if (ImbuingCalcWindow.Property[tot].mod == ImbuingCalcWindow.Mods[z].raw) then
										table.remove(ImbuingCalcWindow.Mods, z)
										break
									end
								end
							end
							CreateWindowFromTemplate( "Item" .. tot, "ImbRowTemplate", "ImbuingCalcContent" )
							WindowSetId("Item"..tot, tot)
							WindowSetShowing("Item" .. tot, true)
							
							LabelSetTextAlign("Item" .. tot .. "Val", "center")
							
							LabelSetTextAlign("Item" .. tot .. "Cap", "center")
							
							LabelSetText("Item" .. tot .. "Label", WindowUtils.Decapitalizing(ImbuingCalcWindow.Property[tot].mod))
							if (ImbuingCalcWindow.Property[tot].value and tonumber(ImbuingCalcWindow.Property[tot].value) and tonumber(ImbuingCalcWindow.Property[tot].value) ~= 0) then
								LabelSetText("Item" .. tot .. "Val", L"" .. tonumber(ImbuingCalcWindow.Property[tot].value))
							end
							
							if (ImbuingCalcWindow.Property[tot].cap and tonumber(ImbuingCalcWindow.Property[tot].cap) and tonumber(ImbuingCalcWindow.Property[tot].cap) ~= 0) then
								LabelSetText("Item" .. tot .. "Cap", L"" .. tonumber(ImbuingCalcWindow.Property[tot].cap))
							end
							LabelSetText("Item" .. tot .. "Label", WindowUtils.Decapitalizing(mod))

							if (ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) and tonumber(ImbuingCalcWindow.Property[tot].newVal) ~= 0) then
								LabelSetText("Item" .. tot .. "NewVal", L"" .. tonumber(ImbuingCalcWindow.Property[tot].newVal))
							end
							
							WindowClearAnchors("Item" .. tot)
							if (tot <= 1) then
								WindowAddAnchor("Item" .. tot, "topleft", "ImbuingCalcContent", "topleft", 10, 20)
							else
								WindowAddAnchor("Item" .. tot, "bottomleft", "Item" .. tot-1, "topleft", 0, 5)
							end
						end
					end
					local capWgt = 450
					if ImbuingCalcWindow.exc then
						capWgt = 500
					end
					if ImbuingCalcWindow.twohanded then
						capWgt = 550
						if ImbuingCalcWindow.exc then
							capWgt = 600
						end
					end
					if ImbuingCalcWindow.ranged and not ImbuingCalcWindow.boomerang then
						capWgt = 500
						if ImbuingCalcWindow.exc then
							capWgt = 550
						end
					end
					LabelSetText("ImbuingCalcWindowTotalVal", ImbuingCalcWindow.totalWeight .. L" / " .. capWgt)
					if (ImbuingCalcWindow.totalWeight >= capWgt) then
						LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 0, 0)
					else
						LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 255, 255)
					end
					local PofCharges = math.ceil((255 - ImbuingCalcWindow.durability) / 10)
					local jars = math.ceil(PofCharges/10)
		
					LabelSetText("ImbuingCalcWindowPOFLabel", UI.GetCliloc(SystemData.Settings.Language.type, 519).. L" " .. PofCharges .. L" (" .. jars .. L" " .. UI.GetCliloc(SystemData.Settings.Language.type, 520) .. L")")
					LabelSetTextColor("ImbuingCalcWindowPOFLabel", 255, 0, 0)
					
					last = tot
					if last > 0 then
						local ySize = 20 + (30 * last)
						WindowSetDimensions("ImbuingCalcContent",695, ySize)
					end
					ImbuingCalcWindow.VisibleItems = last
					ScrollWindowUpdateScrollRect( "ImbuingCalcContentWindow" )
					if (ImbuingCalcWindow.totalMods >= 5) then
						WindowSetShowing("ImbuingCalcWindowMods", false)
						ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", true )
					else
						WindowSetShowing("ImbuingCalcWindowMods", true)
						ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", false )
					end
					ComboBoxClearMenuItems( "ImbuingCalcWindowMods" )
					for z = 1, table.getn(ImbuingCalcWindow.Mods) do
    					if (ImbuingCalcWindow.Mods[z]) then
			    		
							ComboBoxAddMenuItem( "ImbuingCalcWindowMods", WindowUtils.Decapitalizing(ImbuingCalcWindow.Mods[z].combo) )
						end
					end
					return true
				end
			end
			
			for k,v in pairs(ItemPropertiesEvaluator.JewelryNames) do
				local org = k
				k = wstring.gsub(k, L"%[" , L"")
				k = wstring.gsub(k, L"%]" , L"")
				if (wstring.find(name, wstring.lower(k))) then
					--Debug.Print(name .. L" ----> Is Jewel")
					ImbuingCalcWindow.type = ImbuingCalcWindow.TYPE_JEWEL
					local tot = 1
					
								
					CreateWindowFromTemplate( "Item" .. tot, "ImbRowTemplate", "ImbuingCalcContent" )
					LabelSetText("Item" .. tot .. "Label", GetStringFromTid(1062761))
					LabelSetTextColor("Item" .. tot .. "Label", 217,217,25)
					WindowSetId("Item"..tot, tot)
					WindowAddAnchor("Item" .. tot, "topleft", "ImbuingCalcContent", "topleft", 20, 20)

					LabelSetText("Item" .. tot .. "Val", GetStringFromTid(1062298))
					LabelSetTextColor("Item" .. tot .. "Val", 217,217,25)
					
					LabelSetText("Item" .. tot .. "Cap", GetStringFromTid(1062299))
					LabelSetTextColor("Item" .. tot .. "Cap", 217,217,25)
	
					LabelSetText("Item" .. tot .. "NewVal", GetStringFromTid(1062300))
					LabelSetTextColor("Item" .. tot .. "NewVal", 217,217,25)
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw
						if (wstring.lower(lprop) == wstring.lower(GetStringFromTid(1060636))) then
							ImbuingCalcWindow.exc = true
						end
					end				
					
							
					for j = 2, table.getn(ImbuingCalcWindow.Property) do
						local lprop = ImbuingCalcWindow.Property[j].raw
						
						local sdi = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
						if (wstring.find(wstring.lower(lprop),sdi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),sdi)
							lprop = L"sdi " .. wstring.sub(lprop, m_end+1)
						end
						
						local di = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
						if (wstring.find(wstring.lower(lprop),di) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),di)
							lprop = L"damage increase " .. wstring.sub(lprop, m_end+1)
						end
						
						local ssi = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
						if (wstring.find(wstring.lower(lprop),ssi) and wstring.find(wstring.lower(lprop), L"%%")) then
							m_start, m_end = wstring.find(wstring.lower(lprop),ssi)
							lprop = L"swing speed increase " .. wstring.sub(lprop, m_end+1)
						end
						
						if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN and not wstring.find(wstring.lower(lprop),GetStringFromTid(1062755)) ) then
							lprop = wstring.gsub(lprop, L"%-", L"")
						end
						local FC = wstring.lower(wstring.gsub(GetStringFromTid(1060413), ItemPropertiesEvaluator.escape2, L""))
						local FCR = wstring.lower(wstring.gsub(GetStringFromTid(1060412), ItemPropertiesEvaluator.escape2, L""))
						if (wstring.find(wstring.lower(lprop), FC)  ) then
							if (wstring.find(wstring.lower(lprop), FCR) == nil ) then
								m_start, m_end = wstring.find(wstring.lower(lprop),FC)
								lprop = L"faster casting".. wstring.sub(lprop, m_end+1)
							end
						end
						
						local strBonus = wstring.lower(wstring.gsub(GetStringFromTid(1060485), ItemPropertiesEvaluator.escape2, L""))
						if (wstring.find(wstring.lower(lprop), strBonus)  and SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
							if (wstring.find(wstring.lower(lprop), L"+") == nil ) then
								m_start, m_end = wstring.find(wstring.lower(lprop),strBonus)
								lprop = L"strength requirement ".. wstring.sub(lprop, m_end+1)
							end
						end
						
						lprop = wstring.gsub(lprop, L"%[" , L"")
						lprop = wstring.gsub(lprop, L"%]" , L"")
						local value = 0
						local mod = L""
						local cap = 0
						local min = 0
						local weight = 0
						local ignore = false
						local materials = ""
						for l, m in pairs(ItemPropertiesEvaluator.Mods) do
							l = wstring.gsub(l, L"%[" , L"")
							l = wstring.gsub(l, L"%]" , L"")
							m_start, m_end = wstring.find(wstring.lower(lprop), wstring.lower(l))
							if m_start and m.type ~= ItemPropertiesEvaluator.TYPE_SKIP then
								value = wstring.sub(lprop, m_end+1)
								mod = wstring.gsub(l, L"[+]", L"")
								cap = m.range
								weight = m.weight
								if (m.jewelrange) then
									cap = m.jewelrange
								end
								
								ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods +1

			
								if m.en == L"durability" and not wstring.find(lprop, L"%%") then
									ImbuingCalcWindow.durability = value
									mod = L""
									ImbuingCalcWindow.totalMods = ImbuingCalcWindow.totalMods -1
								end
								if (m.materials_jewel) then
									materials = m.materials_jewel
								else
									materials = m.materials
								end
								
								break
							end
						end 
						
						if mod ~= L"" then

							tot = tot +1
							ImbuingCalcWindow.Property[tot].mod = mod
							ImbuingCalcWindow.Property[tot].min = min
							ImbuingCalcWindow.Property[tot].value = value
							ImbuingCalcWindow.Property[tot].cap = cap
							ImbuingCalcWindow.Property[tot].weight = weight
							ImbuingCalcWindow.Property[tot].ignore = ImbuingCalcWindow.Property[tot].ignore or ignore
							local mats = nil
							if ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) >0 then
								value = tonumber(ImbuingCalcWindow.Property[tot].newVal)
							end
							local mats = nil
							local mts = ""
							local vls = ""
							if (materials and not ImbuingCalcWindow.Property[tot].ignore ) then
								mats = string.split(materials, "|")
								if (mats) then
									for i = 1 , table.getn(mats) do
										local amt = 0
										if (value == "" or cap == "") then
											value = 100
											cap = 100
										end
										if (tonumber(value) < -1) then
											value = 30 + value
											cap = 30 + cap
										end
										if (i == 1) then
											
											amt= math.floor(value / (cap * 0.2))

											if amt < 1 then
												amt = 1
											end
											if amt > 5 then
												amt = 5
											end
										elseif (i == 2) then
											amt = math.floor(value / (cap * 0.1))
											if amt < 1 then
												amt = 1
											end
											if amt > 10 then
												amt = 10
											end
										elseif (i == 3) then
											local variation = cap - (cap * 0.1)
											amt = math.floor(((value - variation) / (cap * 0.01)))
											amt = amt +1
											if amt < 0 then
												amt = 0
											end
											if amt > 10 then
												amt = 10
											end
										end
										if (tonumber(value) == -1) then
											amt = 0
										end
										if (ImbuingCalcWindow.Materials[mats[i]]) then
											
											ImbuingCalcWindow.Materials[mats[i]].total = ImbuingCalcWindow.Materials[mats[i]].total + amt
										else
											ImbuingCalcWindow.Materials[mats[i]] = {}
											ImbuingCalcWindow.Materials[mats[i]].total = amt
										end
										if i > 1 then
											mts = mts .. "|" .. mats[i] 
											vls = vls .. "|" .. amt
										else
											mts = mats[i] 
											vls =  amt
										end
									end
								end
								ImbuingCalcWindow.Property[tot].materials = mts
								ImbuingCalcWindow.Property[tot].required = vls
							end
							
							
							if not ImbuingCalcWindow.Property[tot].ignore then
								
								if  ImbuingCalcWindow.Property[tot].value and ImbuingCalcWindow.Property[tot].cap and ImbuingCalcWindow.Property[tot].cap ~= "" then
									local wgt = tonumber(ImbuingCalcWindow.Property[tot].weight) --* 100
									local cap = tonumber(ImbuingCalcWindow.Property[tot].cap)  - tonumber(ImbuingCalcWindow.Property[tot].min)
									local v = tonumber(ImbuingCalcWindow.Property[tot].value)  - tonumber(ImbuingCalcWindow.Property[tot].min)
									if (ImbuingCalcWindow.Property[tot].newVal and ImbuingCalcWindow.Property[tot].newVal ~= "" and tonumber(ImbuingCalcWindow.Property[tot].newVal) > 0) then
										v = tonumber(ImbuingCalcWindow.Property[tot].newVal)   - tonumber(ImbuingCalcWindow.Property[tot].min)
									end
									--Debug.Print( (math.floor(( v / cap )* 100) * wgt ))
									ImbuingCalcWindow.totalWeight = ImbuingCalcWindow.totalWeight + math.floor((( v / cap )* 100) * wgt )
								else
									local wgt = ImbuingCalcWindow.Property[tot].weight * 100
									ImbuingCalcWindow.totalWeight = ImbuingCalcWindow.totalWeight + wgt
								end
							end
							
							for z = 1, table.getn(ImbuingCalcWindow.Mods) do
    							if (ImbuingCalcWindow.Mods[z] ) then
    								if (ImbuingCalcWindow.Property[tot].mod == ImbuingCalcWindow.Mods[z].raw) then
										table.remove(ImbuingCalcWindow.Mods, z)
										break
									end
								end
							end
							CreateWindowFromTemplate( "Item" .. tot, "ImbRowTemplate", "ImbuingCalcContent" )
							WindowSetId("Item"..tot, tot)
							WindowSetShowing("Item" .. tot, true)
							
							LabelSetTextAlign("Item" .. tot .. "Val", "center")
							
							LabelSetTextAlign("Item" .. tot .. "Cap", "center")
							
							LabelSetText("Item" .. tot .. "Label", WindowUtils.Decapitalizing(ImbuingCalcWindow.Property[tot].mod))
							if (ImbuingCalcWindow.Property[tot].value and tonumber(ImbuingCalcWindow.Property[tot].value) and tonumber(ImbuingCalcWindow.Property[tot].value) > 0) then
								LabelSetText("Item" .. tot .. "Val", L"" .. tonumber(ImbuingCalcWindow.Property[tot].value))
							end
							
							if (ImbuingCalcWindow.Property[tot].cap and tonumber(ImbuingCalcWindow.Property[tot].cap) and tonumber(ImbuingCalcWindow.Property[tot].cap) > 0) then
								LabelSetText("Item" .. tot .. "Cap", L"" .. tonumber(ImbuingCalcWindow.Property[tot].cap))
							end
							LabelSetText("Item" .. tot .. "Label", WindowUtils.Decapitalizing(mod))

							if (ImbuingCalcWindow.Property[tot].newVal and tonumber(ImbuingCalcWindow.Property[tot].newVal) and tonumber(ImbuingCalcWindow.Property[tot].newVal) > 0) then
								LabelSetText("Item" .. tot .. "NewVal", L"" .. tonumber(ImbuingCalcWindow.Property[tot].newVal))
							end
							
							WindowClearAnchors("Item" .. tot)
							if (tot <= 1) then
								WindowAddAnchor("Item" .. tot, "topleft", "ImbuingCalcContent", "topleft", 10, 20)
							else
								WindowAddAnchor("Item" .. tot, "bottomleft", "Item" .. tot-1, "topleft", 0, 5)
							end
						end
					end
	
					capWgt = 500

					LabelSetText("ImbuingCalcWindowTotalVal", ImbuingCalcWindow.totalWeight .. L" / " .. capWgt)
					if (ImbuingCalcWindow.totalWeight >= capWgt) then
						LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 0, 0)
					else
						LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 255, 255)
					end
										
					last = tot
					if last > 0 then
						local ySize = 20 + (30 * last)
						WindowSetDimensions("ImbuingCalcContent",695, ySize)
					end
					ImbuingCalcWindow.VisibleItems = last
					ScrollWindowUpdateScrollRect( "ImbuingCalcContentWindow" )
					if (ImbuingCalcWindow.totalMods >= 5) then
						WindowSetShowing("ImbuingCalcWindowMods", false)
						ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", true )
					else
						WindowSetShowing("ImbuingCalcWindowMods", true)
						ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", false )
					end
					ComboBoxClearMenuItems( "ImbuingCalcWindowMods" )
					for z = 1, table.getn(ImbuingCalcWindow.Mods) do
    					if (ImbuingCalcWindow.Mods[z]) then
			    		
							ComboBoxAddMenuItem( "ImbuingCalcWindowMods", WindowUtils.Decapitalizing(ImbuingCalcWindow.Mods[z].combo) )
						end
					end
					return true
				end
			end

			--Debug.Print(name .. L" ----> Not Imbueable")
				
			ImbuingCalcWindow.ClearAll()
			return  false

		end
	else
		--Debug.Print("!!!FAILED!!!")
		local okayButton = { textTid=UO_StandardDialog.TID_OKAY }
		local DestroyConfirmWindow = 
				{
				    windowName = "MouseNotOver",
					title = UI.GetCliloc(SystemData.Settings.Language.type, 639),
					body = UI.GetCliloc(SystemData.Settings.Language.type, 640) ,
					buttons = { okayButton }
				}
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
		ret =  false
		ImbuingCalcWindow.ClearAll()
	end
	return ret
end

function ImbuingCalcWindow.ClearList()
	for j=1, ImbuingCalcWindow.VisibleItems do
		if (DoesWindowNameExist("Item" .. j)) then
			DestroyWindow("Item" .. j)
		end
	end
	ImbuingCalcWindow.totalMods = 0
	LabelSetText("ImbuingCalcWindowPOFLabel", L"")
	ImbuingCalcWindow.Materials = {}
	for j= 1, ImbuingCalcWindow.ActualMats do
		if (DoesWindowNameExist("ItemMat" .. j)) then
			DestroyWindow("ItemMat" .. j)
		end
	end
end

function ImbuingCalcWindow.ClearAll()
	local windowName = "ImbuingCalcWindowSoket"
	ImbuingCalcWindow.ClearList()
	DynamicImageSetTexture(windowName .. "Icon", "", 0, 0 )   
	UnregisterWindowData(WindowData.ObjectInfo.Type, WindowGetId(windowName))
	UnregisterWindowData(WindowData.ObjectInfo.Type, WindowGetId("ImbuingCalcWindowSoket"))
	WindowSetId(windowName, 0)
	 local tot = 0
    ComboBoxClearMenuItems( "ImbuingCalcWindowMods" )
    ImbuingCalcWindow.Mods = {}
    ImbuingCalcWindow.Materials = {}
    ImbuingCalcWindow.Property = {}
	ImbuingCalcWindow.durability = 0

	ImbuingCalcWindow.totalMods = 0
	ImbuingCalcWindow.totalWeight = 0
	ImbuingCalcWindow.exc = false
	ImbuingCalcWindow.speed = 0
	ImbuingCalcWindow.ssi = 0
	ImbuingCalcWindow.ranged = false
	ImbuingCalcWindow.boomerang = false
	ImbuingCalcWindow.twohanded = false

	ImbuingCalcWindow.ActualMats = 0
    for key, val in pairsByKeys(ItemPropertiesEvaluator.Mods) do
		
		local prop = wstring.lower(key)
		prop = wstring.gsub(prop, L"[+]", L"")
		if (prop == L"faster casting") then
			prop = wstring.lower(wstring.gsub(GetStringFromTid(1060413), ItemPropertiesEvaluator.escape2, L""))
		end
		if (prop == L"damage increase") then
			prop = wstring.lower(wstring.gsub(GetStringFromTid(1060401), ItemPropertiesEvaluator.escape, L""))
		end
		if (prop == L"sdi") then
			prop = wstring.lower(wstring.gsub(GetStringFromTid(1060483), ItemPropertiesEvaluator.escape0Bis, L""))
		end
		if (prop == L"swing speed increase") then
			prop = wstring.gsub(GetStringFromTid(1060486), ItemPropertiesEvaluator.escape, L"")
		end
		if (not val.type) then
			tot = tot + 1
			grp = L""
			if (val.grp) then
				grp = L" (" .. val.grp .. L")"
			end
			
			ImbuingCalcWindow.Mods[tot] = {}
			ImbuingCalcWindow.Mods[tot].raw = prop
			ImbuingCalcWindow.Mods[tot].cantRemove = false
			ImbuingCalcWindow.Mods[tot].cap = val.range	
			ImbuingCalcWindow.Mods[tot].combo = prop .. grp
		end

    end
    for i = 1, table.getn(ImbuingCalcWindow.Mods) do
    	if (ImbuingCalcWindow.Mods[i]) then
    		
			ComboBoxAddMenuItem( "ImbuingCalcWindowMods", WindowUtils.Decapitalizing(ImbuingCalcWindow.Mods[i].combo) )
		end
	end
	WindowSetShowing("ImbuingCalcWindowMods", false)
	ButtonSetDisabledFlag( "ImbuingCalcWindowAddMod", true )
	LabelSetText("ImbuingCalcWindowTotalVal", L"0")
	LabelSetTextColor("ImbuingCalcWindowTotalVal", 255, 255, 255)
	
end

function ImbuingCalcWindow.ItemMouseOver()
	local id = WindowGetId(SystemData.ActiveWindow.name)
	if (id and id > 0) then
		local itemData = {	windowName = "ImbuingCalcWindowSoketIcon",
							itemId = id,
		    				itemType = WindowData.ItemProperties.TYPE_ITEM,
		    				detail = ItemProperties.DETAIL_LONG }
		ItemProperties.SetActiveItem(itemData)
	end
	
end


function ImbuingCalcWindow.Shutdown()
	if (WindowGetId("ImbuingCalcWindowSoket")) then
		ReleaseTileArt(WindowGetId("ImbuingCalcWindowSoket"))
	end
	WindowUtils.SaveWindowPosition("ImbuingCalcWindow")
	WindowSetShowing("ImbuingCalcWindow", false)   
	WindowSetShowing("ImbuingCalcMaterialsWindow", WindowGetShowing("ImbuingCalcWindow"))
	UnregisterWindowData(WindowData.ObjectInfo.Type, WindowGetId("ImbuingCalcWindowSoket"))
end
