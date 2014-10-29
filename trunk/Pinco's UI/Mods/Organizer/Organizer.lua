----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

OrganizerWindow = {}

OrganizerWindow.VisibleItems = 0
OrganizerWindow.Combo = {}
OrganizerWindow.ComboCustomName = {}

-- OnInitialize Handler
function OrganizerWindow.Initialize()
	WindowUtils.RestoreWindowPosition("OrganizerWindow", true)
	
	WindowUtils.SetWindowTitle("OrganizerWindow", UI.GetCliloc(SystemData.Settings.Language.type, 611))
    WindowSetShowing("OrganizerWindow", false)
   
   
	LabelSetText("OrganizerWindowAgentLabel", UI.GetCliloc(SystemData.Settings.Language.type, 601))
	LabelSetText("OrganizerWindowDefaultLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5037))
	LabelSetText("OrganizerWindowPlusButtonLabel", L"+")
	LabelSetText("OrganizerWindowMinusButtonLabel", L"-")
	LabelSetText("OrganizerWindowRenameButtonLabel", GetStringFromTid(1111680))
	--LabelSetTextAlign("OrganizerWindowDefContButtonLabel", "center")
	--WindowSetDimensions("OrganizerWindowDefContButtonLabel", 200, 20)
	WindowSetShowing("OrganizerWindowCloseContainer", false)
	ButtonSetText("OrganizerWindowAddTypeButton", UI.GetCliloc(SystemData.Settings.Language.type, 602))
	ButtonSetText("OrganizerWindowAddIDButton", UI.GetCliloc(SystemData.Settings.Language.type, 603))
    
	OrganizerWindow.UpdateCombo()
	ScrollWindowUpdateScrollRect( "OrganizerContentWindow" )
	ButtonSetDisabledFlag( "OrganizerWindowAddIDButton", true )
	ButtonSetDisabledFlag( "OrganizerWindowAddTypeButton", true )
	
	WindowSetShowing("OrganizerWindowDefaultLabel", false)
	WindowSetShowing("OrganizerWindowDefaultButton", false)
end

function OrganizerWindow.UpdateCombo()
	ComboBoxClearMenuItems( "OrganizerWindowAgentCombo" )
	local j = 0
	OrganizerWindow.Combo = {}
	WindowSetShowing("OrganizerWindowDefaultLabel", false)
	WindowSetShowing("OrganizerWindowDefaultButton", false)
	for i=1, Organizer.Organizers do
		local name = L"Organizer " .. i
		if (Organizer.Organizers_Desc[i] ~= L"") then
			name = Organizer.Organizers_Desc[i] .. L" (" .. name .. L")"
		end
		ComboBoxAddMenuItem( "OrganizerWindowAgentCombo", name )
		j = j + 1
		OrganizerWindow.Combo[j] = L"Organizer " .. i
		OrganizerWindow.ComboCustomName[j] = Organizer.Organizers_Desc[j]
	end
	  
	for i=1, Organizer.Undresses do
		local name = L"Undress " .. i
		if (Organizer.Undresses_Desc[i] ~= L"") then
			name = Organizer.Undresses_Desc[i].. L" (" .. name .. L")"
		end
		ComboBoxAddMenuItem( "OrganizerWindowAgentCombo", name )
		j = j + 1
		OrganizerWindow.Combo[j] = L"Undress " .. i
		OrganizerWindow.ComboCustomName[j] = Organizer.Undresses_Desc[j]
	end
	   
	for i=1, Organizer.Restocks do
		local name = L"Restock " .. i
		if (Organizer.Restocks_Desc[i] ~= L"") then
			name = Organizer.Restocks_Desc[i].. L" (" .. name .. L")"
		end
		ComboBoxAddMenuItem( "OrganizerWindowAgentCombo", name )
		j = j + 1
		OrganizerWindow.Combo[j] = L"Restock " .. i
		OrganizerWindow.ComboCustomName[j] = Organizer.Restocks_Desc[j]
	end
	  
	for i=1, Organizer.Buys do
		local name = L"Buy " .. i
		if (Organizer.Buys_Desc[i] ~= L"") then
			name = Organizer.Buys_Desc[i].. L" (" .. name .. L")"
		end
		ComboBoxAddMenuItem( "OrganizerWindowAgentCombo", name )
		j = j + 1
		OrganizerWindow.Combo[j] = L"Buy " .. i
		OrganizerWindow.ComboCustomName[j] = Organizer.Buys_Desc[j]
	end
	   
	for i=1, Organizer.Sells do
		local name = L"Sell " .. i
		if (Organizer.Sells_Desc[i] ~= L"") then
			name = Organizer.Sells_Desc[i].. L" (" .. name .. L")"
		end
		ComboBoxAddMenuItem( "OrganizerWindowAgentCombo", name )
		j = j + 1
		OrganizerWindow.Combo[j] = L"Sell " .. i
		OrganizerWindow.ComboCustomName[j] = Organizer.Sells_Desc[j]
	end
	
	if not EnhancePack.ScavengeAll then
		for i=1, Organizer.Scavengers do
			local name = L"Scavenger " .. i
			if (Organizer.Scavengers_Desc[i] ~= L"") then
				name = Organizer.Scavengers_Desc[i].. L" (" .. name .. L")"
			end
			ComboBoxAddMenuItem( "OrganizerWindowAgentCombo", name )
			j = j + 1
			OrganizerWindow.Combo[j] = L"Scavenger " .. i
			OrganizerWindow.ComboCustomName[j] = Organizer.Scavengers_Desc[j]
		end
	end
	
	ButtonSetDisabledFlag( "OrganizerWindowAddIDButton", true )
	ButtonSetDisabledFlag( "OrganizerWindowAddTypeButton", true )
	WindowSetShowing("OrganizerWindowDefContButton", false)
end

function OrganizerWindow.AgentPlus()
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 596),0,"MoreOrganizer",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 597),0,"MoreUndress",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 598),0,"MoreRestock",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 599),0,"MoreBuy",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 600),0,"MoreSell",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5035),0,"MoreScavenger",2,false)
	
	ContextMenu.ActivateLuaContextMenu(OrganizerWindow.ContextMenuCallback)
end

function OrganizerWindow.EditAmount(j, amount)
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	local fnd = wstring.find(text, L" ")
	local i = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	if j and amount then
		if (type(tonumber(amount)) == "number") then
			amount = tonumber(amount)
			if wstring.find(text, L"Restock") then
				Organizer.Restock[i][j].qta = amount
				CustomSettings.SaveNumber( "Restock" .. i .. "it" .. j .. "Qta" , amount )
			elseif wstring.find(text, L"Buy") then
				Organizer.Buy[i][j].qta = amount
				CustomSettings.SaveNumber( "Buy" .. i .. "it" .. j .. "Qta" , amount )
			elseif wstring.find(text, L"Sell") then
				Organizer.Sell[i][j].qta = amount
				CustomSettings.SaveNumber( "Sell" .. i .. "it" .. j .. "Qta" , amount )
			end
			WindowSetShowing("OrganizerWindowDefaultLabel", false)
			WindowSetShowing("OrganizerWindowDefaultButton", false)
			OrganizerWindow.UpdateList()
		end
	end
end

function OrganizerWindow.ContextMenuCallback( returnCode, param )
	if ( returnCode=="MoreOrganizer" ) then
		Organizer.Organizers = Organizer.Organizers + 1
		Organizer.Organizer[Organizer.Organizers] = {}
		local i = Organizer.Organizers
		Organizer.Organizers_Items[i] = 0
		Organizer.Organizers_Desc[i] = L""
		Organizer.Organizers_Cont[i] = 0
		Organizer.Organizers_CloseCont[i] = false
		CustomSettings.SaveBoolean( "OrganizerOrganizers_CloseCont" .. i  , Organizer.Organizers_CloseCont[i] )
		CustomSettings.SaveNumber( "OrganizerOrganizers_Cont" .. i  , Organizer.Organizers_Cont[i] )
		CustomSettings.SaveNumber( "OrganizerOrganizers_Items" .. i  , Organizer.Organizers_Items[i] )
		CustomSettings.SaveWString( "OrganizerOrganizers_Desc" .. i  , Organizer.Organizers_Desc[i] )
		CustomSettings.SaveNumber( "OrganizerOrganizers" , Organizer.Organizers )
	elseif ( returnCode=="MoreUndress" ) then
		Organizer.Undresses = Organizer.Undresses + 1
		Organizer.Undress[Organizer.Undresses] = {}
		local i = Organizer.Undresses
		Organizer.Undresses_Items[i] = 0
		Organizer.Undresses_Desc[i] = L""
		Organizer.Undresses_Cont[i] = 0
		CustomSettings.SaveNumber( "OrganizerUndresses_Cont" ..i  , Organizer.Undresses_Cont[i] )
		CustomSettings.SaveNumber( "OrganizerUndresses_Items" .. i  , Organizer.Undresses_Items[i] )
		CustomSettings.SaveWString( "OrganizerUndresses_Desc" .. i  , Organizer.Undresses_Desc[i] )
		CustomSettings.SaveNumber( "OrganizerUndresses" , Organizer.Undresses )
	elseif ( returnCode=="MoreRestock" ) then
		Organizer.Restocks = Organizer.Restocks + 1
		Organizer.Restock[Organizer.Restocks] = {}
		local i = Organizer.Restocks
		Organizer.Restocks_Items[i] = 0
		Organizer.Restocks_Desc[i] = L""
		Organizer.Restocks_Cont[i] = 0
		CustomSettings.SaveNumber( "OrganizerRestocks_Cont" .. i  , Organizer.Restocks_Cont[i] )
		CustomSettings.SaveNumber( "OrganizerRestocks_Items" .. i  , Organizer.Restocks_Items[i] )
		CustomSettings.SaveWString( "OrganizerRestocks_Desc" .. i  , Organizer.Restocks_Desc[i] )
		CustomSettings.SaveNumber( "OrganizerRestocks" , Organizer.Restocks )
	elseif ( returnCode=="MoreBuy" ) then
		Organizer.Buys = Organizer.Buys + 1
		Organizer.Buy[Organizer.Buys] = {}
		local i = Organizer.Buys
		Organizer.Buys_Items[i] = 0
		Organizer.Buys_Desc[i] = L""
		CustomSettings.SaveNumber( "OrganizerBuys_Items" .. i  , Organizer.Buys_Items[i] )
		CustomSettings.SaveWString( "OrganizerBuys_Desc" .. i  , Organizer.Buys_Desc[i] )
		CustomSettings.SaveNumber( "OrganizerBuys" , Organizer.Buys )
	elseif ( returnCode=="MoreSell" ) then
		Organizer.Sells = Organizer.Sells + 1
		Organizer.Sell[Organizer.Sells] = {}
		local i = Organizer.Sells
		Organizer.Sells_Items[i] = 0
		Organizer.Sells_Desc[i] = L""
		CustomSettings.SaveNumber( "OrganizerSells_Items" .. i  , Organizer.Sells_Items[i] )
		CustomSettings.SaveWString( "OrganizerSells_Desc" .. i  , Organizer.Sells_Desc[i] )
		CustomSettings.SaveNumber( "OrganizerSells" , Organizer.Sells )
	elseif ( returnCode=="MoreScavenger" ) then
		Organizer.Scavengers = Organizer.Scavengers + 1
		Organizer.Scavenger[Organizer.Scavengers] = {}
		local i = Organizer.Scavengers
		Organizer.Scavengers_Items[i] = 0
		Organizer.Scavengers_Desc[i] = L""
		Organizer.Scavengers_Cont[i] = 0
		CustomSettings.SaveNumber( "OrganizerScavengers_Cont" .. i  , Organizer.Scavengers_Cont[i] )
		CustomSettings.SaveNumber( "OrganizerScavengers_Items" .. i  , Organizer.Scavengers_Items[i] )
		CustomSettings.SaveWString( "OrganizerScavengers_Desc" .. i  , Organizer.Scavengers_Desc[i] )
		CustomSettings.SaveNumber( "OrganizerScavengers" , Organizer.Scavengers )
	end
	if ( returnCode== "Edit" ) then
		local num = WindowGetId(param)
		local rdata = {title=GetStringFromTid(1077826), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 595), callfunction=OrganizerWindow.EditAmount, id=num}
		RenameWindow.Create(rdata)
	elseif ( returnCode== "Delete"  ) then
		OrganizerWindow.ExeRemoveItem(param)
		-- local this = param
		-- local okayButton = { textTid=1013076, callback=function()OrganizerWindow.ExeRemoveItem(this)end }
		-- local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL}
		-- local DestroyConfirmWindow = 
		-- 			{
		-- 				windowName = "RemoveItem",
		-- 				title = L"Remove?",
		-- 				body = L"Remove selected item?",
		-- 				buttons = { okayButton, cancelButton }
		-- 			}
		-- UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
	else
		OrganizerWindow.UpdateCombo()
	end
	OrganizerWindow.UpdateList()
	
end

function OrganizerWindow.AddRemDefCont()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	local fnd = wstring.find(text, L" ")
	local index = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	local rem = false
	if wstring.find(text, L"Organizer") then
		if (Organizer.Organizers_Cont[index] > 0) then
			rem = true
		end
	elseif wstring.find(text, L"Undress") then
		if (Organizer.Undresses_Cont[index] > 0) then
			rem = true
		end
	elseif wstring.find(text, L"Restock") then
		if (Organizer.Restocks_Cont[index] > 0) then
			rem = true
		end
	elseif wstring.find(text, L"Scavenger") then
		if (Organizer.Scavengers_Cont[index] > 0) then
			rem = true
		end
	end
	if not rem then
		RequestTargetInfo()
		EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 584), 1152, true)
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "OrganizerWindow.AddDefCont")
	else
		if wstring.find(text, L"Organizer") then
			Organizer.Organizers_Cont[index] = 0
			CustomSettings.SaveNumber( "OrganizerOrganizers_Cont" .. index  , Organizer.Organizers_Cont[index] )
		elseif wstring.find(text, L"Undress") then
			Organizer.Undresses_Cont[index] = 0
			CustomSettings.SaveNumber( "OrganizerUndresses_Cont" ..index  , Organizer.Undresses_Cont[index] )
		elseif wstring.find(text, L"Restock") then
			Organizer.Restocks_Cont[index]  = 0
			CustomSettings.SaveNumber( "OrganizerRestocks_Cont" .. index  , Organizer.Restocks_Cont[index] )
		elseif wstring.find(text, L"Scavenger") then
			Organizer.Scavengers_Cont[index]  = 0
			CustomSettings.SaveNumber( "OrganizerScavengers_Cont" .. index  , Organizer.Scavengers_Cont[index] )
		end
		LabelSetText("OrganizerWindowDefContButtonLabel", UI.GetCliloc(SystemData.Settings.Language.type, 624))
	end
end

function OrganizerWindow.AddDefCont()
	local bag = SystemData.RequestInfo.ObjectId
	if (bag ~= nil and bag ~= 0) then
		local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
		local fnd = wstring.find(text, L" ")
		local index = tonumber(WStringToString(wstring.sub(text, fnd+1)))

		if wstring.find(text, L"Organizer") then
			Organizer.Organizers_Cont[index] = bag
			CustomSettings.SaveNumber( "OrganizerOrganizers_Cont" .. index  , Organizer.Organizers_Cont[index] )
		elseif wstring.find(text, L"Undress") then
			Organizer.Undresses_Cont[index] = bag
			CustomSettings.SaveNumber( "OrganizerUndresses_Cont" ..index  , Organizer.Undresses_Cont[index] )
		elseif wstring.find(text, L"Restock") then
			Organizer.Restocks_Cont[index]  = bag
			CustomSettings.SaveNumber( "OrganizerRestocks_Cont" .. index  , Organizer.Restocks_Cont[index] )
		elseif wstring.find(text, L"Scavenger") then
			Organizer.Scavengers_Cont[index]  = bag
			CustomSettings.SaveNumber( "OrganizerScavengers_Cont" .. index  , Organizer.Scavengers_Cont[index] )
		end
		LabelSetText("OrganizerWindowDefContButtonLabel", UI.GetCliloc(SystemData.Settings.Language.type, 625))
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
end


function OrganizerWindow.AgentRename()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	if text == "OrganizerWindowAgentCombo" or text == nil  then
		return
	end
	local rdata = {title=GetStringFromTid(1111680), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 623), callfunction=OrganizerWindow.renameAgent}
	RenameWindow.Create(rdata)
end

function OrganizerWindow.renameAgent(id, name)
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	local fnd = wstring.find(text, L" ")
	local index = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	if wstring.find(text, L"Organizer") then
		Organizer.Organizers_Desc[index] = name
		CustomSettings.SaveWString( "OrganizerOrganizers_Desc" .. index , Organizer.Organizers_Desc[index] )
	elseif wstring.find(text, L"Undress") then
		Organizer.Undresses_Desc[index] = name
		CustomSettings.SaveWString( "OrganizerUndresses_Desc" .. index , Organizer.Undresses_Desc[index] )
	elseif wstring.find(text, L"Restock") then
		Organizer.Restocks_Desc[index] = name	
		CustomSettings.SaveWString( "OrganizerRestocks_Desc" .. index , Organizer.Restocks_Desc[index] )
	elseif wstring.find(text, L"Buy") then
		Organizer.Buys_Desc[index] = name	
		CustomSettings.SaveWString( "OrganizerBuys_Desc" .. index , Organizer.Buys_Desc[index] )
	elseif wstring.find(text, L"Sell") then
		Organizer.Sells_Desc[index] = name	
		CustomSettings.SaveWString( "OrganizerSells_Desc" .. index , Organizer.Sells_Desc[index] )
	elseif wstring.find(text, L"Scavenger") then
		Organizer.Scavengers_Desc[index] = name	
		CustomSettings.SaveWString( "OrganizerScavengers_Desc" .. index , Organizer.Scavengers_Desc[index] )
	end
	OrganizerWindow.UpdateCombo()
	OrganizerWindow.UpdateList()
end

function OrganizerWindow.AgentMinus()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	if text == "OrganizerWindowAgentCombo" or text == nil  then
		return
	end
	local okayButton = { textTid=1011036, callback=function()OrganizerWindow.removeAgent()end }
    local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL}
	local DestroyConfirmWindow = 
				{
				    windowName = "RemoveAgent",
					title =  UI.GetCliloc(SystemData.Settings.Language.type, 618),
					body =  UI.GetCliloc(SystemData.Settings.Language.type, 619),
					buttons = { okayButton, cancelButton }
				}
	UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
end

function OrganizerWindow.removeAgent()
	
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	local fnd = wstring.find(text, L" ")
	local index = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	if wstring.find(text, L"Organizer") then
		for i=1,  Organizer.Organizers do	
			if (Organizer.Organizers_Items[i]) then
				for k=1,  Organizer.Organizers_Items[i] do
					CustomSettings.DeleteStringSetting( "Organizer" .. i .. "it" .. k .. "Name"  )
					CustomSettings.DeleteSetting( "Organizer" .. i .. "it" .. k .. "Type"  )
					CustomSettings.DeleteSetting( "Organizer" .. i .. "it" .. k .. "Hue"  )
					CustomSettings.DeleteSetting( "Organizer" .. i .. "it" .. k .. "Id"  )
				end
				CustomSettings.DeleteSetting( "OrganizerOrganizers_Items" .. i  )
				CustomSettings.DeleteSetting( "OrganizerOrganizers_Desc" .. i  )
				CustomSettings.DeleteSetting( "OrganizerOrganizers_Cont" .. i  )
				CustomSettings.DeleteSetting( "OrganizerOrganizers_CloseCont" .. i  )
			end
		end

		Organizer.ActiveOrganizer = 1

		CustomSettings.SaveNumber( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )
		table.remove(Organizer.Organizer,index)
		table.remove(Organizer.Organizers_Items,index)
		table.remove(Organizer.Organizers_Desc,index)
		Organizer.Organizers = Organizer.Organizers - 1
		if (Organizer.Organizers <= 0) then
			Organizer.Organizers = 1
			Organizer.Organizers_Items[1] =   0 
			Organizer.Organizers_Desc[1] =  L"" 
			Organizer.Organizers_Cont[1] =   0 
			Organizer.Organizers_CloseCont[1] = false 
		end
		CustomSettings.SaveNumber( "OrganizerOrganizers" , Organizer.Organizers )
		for i=1,  Organizer.Organizers do	
			if (Organizer.Organizers_Items[i]) then
				for k=1,  Organizer.Organizers_Items[i] do
					if (Organizer.Organizer[i][k]) then
						local item = Organizer.Organizer[i][k]
						CustomSettings.SaveString( "Organizer" .. i .. "it" .. k .. "Name" , item.name )
						CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. k .. "Type" , item.type )
						CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. k .. "Hue" , item.hue )
						CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. k .. "Id" , item.id )
					end
				end
				CustomSettings.SaveNumber( "OrganizerOrganizers_Items" .. i  , Organizer.Organizers_Items[i] )
				CustomSettings.SaveWString( "OrganizerOrganizers_Desc" .. i  , Organizer.Organizers_Desc[i] )
				CustomSettings.SaveNumber( "OrganizerOrganizers_Cont" .. i  , Organizer.Organizers_Cont[i] )
				CustomSettings.SaveBoolean( "OrganizerOrganizers_CloseCont" .. i  , Organizer.Organizers_CloseCont[i] )
			end
		end
	elseif wstring.find(text, L"Undress") then
		for i=1,  Organizer.Undresses do	
			if (Organizer.Undresses_Items[i]) then
				for k=1,  Organizer.Undresses_Items[i] do
					CustomSettings.DeleteStringSetting( "Undress" .. i .. "it" .. k .. "Name"  )
					CustomSettings.DeleteSetting( "Undress" .. i .. "it" .. k .. "Type"  )
					CustomSettings.DeleteSetting( "Undress" .. i .. "it" .. k .. "Hue"  )
					CustomSettings.DeleteSetting( "Undress" .. i .. "it" .. k .. "Id"  )
				end
				CustomSettings.DeleteSetting( "OrganizerUndresses_Items" .. i  )
				CustomSettings.DeleteSetting( "OrganizerUndresses_Desc" .. i  )
				CustomSettings.DeleteSetting( "OrganizerUndresses_Cont" .. i  )
			end
		end
		

		Organizer.ActiveUndress = 1
		
		CustomSettings.SaveNumber( "OrganizerActiveUndress" , Organizer.ActiveUndress )
		table.remove(Organizer.Undress,index)
		table.remove(Organizer.Undresses_Items,index)
		table.remove(Organizer.Undresses_Desc,index)
		Organizer.Undresses = Organizer.Undresses - 1
		if (Organizer.Undresses <= 0) then
			Organizer.Undresses = 1
			Organizer.Undresses_Items[1] =  0 
			Organizer.Undresses_Desc[1] =  L"" 
			Organizer.Undresses_Cont[1] =  0 
		end
		CustomSettings.SaveNumber( "OrganizerUndresses" , Organizer.Undresses )
		for i=1,  Organizer.Undresses do	
			if (Organizer.Undresses_Items[i]) then
				for k=1,  Organizer.Undresses_Items[i] do
					if (Organizer.Undress[i][k]) then
					local item = Organizer.Undress[i][k]
						CustomSettings.SaveString( "Undress" .. i .. "it" .. k .. "Name" , item.name )
						CustomSettings.SaveNumber( "Undress" .. i .. "it" .. k .. "Type" , item.type )
						CustomSettings.SaveNumber( "Undress" .. i .. "it" .. k .. "Hue" , item.hue )
						CustomSettings.SaveNumber( "Undress" .. i .. "it" .. k .. "Id" , item.id )
					end
				end
				CustomSettings.SaveNumber( "OrganizerUndresses_Items" .. i  , Organizer.Undresses_Items[i] )
				CustomSettings.SaveWString( "OrganizerUndresses_Desc" .. i  , Organizer.Undresses_Items[i] )
				CustomSettings.SaveNumber( "OrganizerUndresses_Cont" .. i  , Organizer.Undresses_Cont[i] )
			end
		end
	elseif wstring.find(text, L"Restock") then
		for i=1,  Organizer.Restocks do	
			if (Organizer.Restocks_Items[i]) then
				for k=1,  Organizer.Restocks_Items[i] do
					CustomSettings.DeleteStringSetting( "Restock" .. i .. "it" .. k .. "Name"  )
					CustomSettings.DeleteSetting( "Restock" .. i .. "it" .. k .. "Type"  )
					CustomSettings.DeleteSetting( "Restock" .. i .. "it" .. k .. "Hue"  )
					CustomSettings.DeleteSetting( "Restock" .. i .. "it" .. k .. "Qta" )
				end
				CustomSettings.DeleteSetting( "OrganizerRestocks_Items" .. i  )
				CustomSettings.DeleteSetting( "OrganizerRestocks_Desc" .. i  )
				CustomSettings.DeleteSetting( "OrganizerRestocks_Cont" .. i  )
			end
		end
		

		Organizer.ActiveRestock = 1

		CustomSettings.SaveNumber( "OrganizerActiveRestock" , Organizer.ActiveRestock )
		table.remove(Organizer.Restock,index)
		table.remove(Organizer.Restocks_Items,index)
		table.remove(Organizer.Restocks_Desc,index)
		Organizer.Restocks = Organizer.Restocks - 1
		if (Organizer.Restocks <= 0) then
			Organizer.Restocks = 1
			Organizer.Restocks_Items[1] =   0 
			Organizer.Restocks_Desc[1] =   L"" 
			Organizer.Restocks_Cont[1] =  0 
		end
		CustomSettings.SaveNumber( "OrganizerRestocks" , Organizer.Restocks )
		for i=1,  Organizer.Restocks do	
			if (Organizer.Restocks_Items[i]) then
				for k=1,  Organizer.Restocks_Items[i] do
					if (Organizer.Restock[i][k]) then
						local item = Organizer.Restock[i][k]
						CustomSettings.SaveString( "Restock" .. i .. "it" .. k .. "Name" , item.name )
						CustomSettings.SaveNumber( "Restock" .. i .. "it" .. k .. "Type" , item.type )
						CustomSettings.SaveNumber( "Restock" .. i .. "it" .. k .. "Hue" , item.hue )
						CustomSettings.SaveNumber( "Restock" .. i .. "it" .. k .. "Qta" , item.qta )
					end
				end
				CustomSettings.SaveNumber( "OrganizerRestocks_Items" .. i  , Organizer.Restocks_Items[i] )
				CustomSettings.SaveWString( "OrganizerRestocks_Desc" .. i  , Organizer.Restocks_Desc[i] )
				CustomSettings.SaveNumber( "OrganizerRestocks_Cont" .. i  , Organizer.Restocks_Cont[i] )
			end
		end
	elseif wstring.find(text, L"Buy") then
		for i=1,  Organizer.Buys do	
			if (Organizer.Buys_Items[i]) then
				for k=1,  Organizer.Buys_Items[i] do
					CustomSettings.DeleteStringSetting( "Buy" .. i .. "it" .. k .. "Name"  )
					CustomSettings.DeleteSetting( "Buy" .. i .. "it" .. k .. "Type"  )
					CustomSettings.DeleteSetting( "Buy" .. i .. "it" .. k .. "Hue"  )
					CustomSettings.DeleteSetting( "Buy" .. i .. "it" .. k .. "Qta"  )
				end
				CustomSettings.DeleteSetting( "OrganizerBuys_Items" .. i  )
				CustomSettings.DeleteSetting( "OrganizerBuys_Desc" .. i  )
			end
		end
	
		
		Organizer.ActiveBuy = 1
		CustomSettings.SaveNumber( "OrganizerActiveBuy" , Organizer.ActiveBuy )
		table.remove(Organizer.Buy,index)
		table.remove(Organizer.Buys_Items,index)
		table.remove(Organizer.Buys_Desc,index)
		Organizer.Buys = Organizer.Buys - 1
		if (Organizer.Buys <= 0) then
			Organizer.Buys = 1
			Organizer.Buys_Items[1] = 0 
			Organizer.Buys_Desc[1] =  L""
		end
		CustomSettings.SaveNumber( "OrganizerBuys" , Organizer.Buys )
		for i=1,  Organizer.Buys do	
			if (Organizer.Buys_Items[i]) then
				for k=1,  Organizer.Buys_Items[i] do
					if (Organizer.Buy[i][k]) then
						local item = Organizer.Buy[i][k]
						CustomSettings.SaveString( "Buy" .. i .. "it" .. k .. "Name" , item.name )
						CustomSettings.SaveNumber( "Buy" .. i .. "it" .. k .. "Type" , item.type )
						CustomSettings.SaveNumber( "Buy" .. i .. "it" .. k .. "Hue" , item.hue )
						CustomSettings.SaveNumber( "Buy" .. i .. "it" .. k .. "Qta" , item.qta )
					end
				end
				CustomSettings.SaveNumber( "OrganizerBuys_Items" .. i  , Organizer.Buys_Items[i] )
				CustomSettings.SaveWString( "OrganizerBuys_Desc" .. i  , Organizer.Buys_Desc[i] )
			end
		end
	elseif wstring.find(text, L"Sell") then
		for i=1,  Organizer.Sells do	
			if (Organizer.Sells_Items[i]) then
				for k=1,  Organizer.Sells_Items[i] do
					CustomSettings.DeleteStringSetting( "Sell" .. i .. "it" .. k .. "Name"  )
					CustomSettings.DeleteSetting( "Sell" .. i .. "it" .. k .. "Type"  )
					CustomSettings.DeleteSetting( "Sell" .. i .. "it" .. k .. "Hue"  )
					CustomSettings.DeleteSetting( "Sell" .. i .. "it" .. k .. "Qta"  )
				end
				CustomSettings.DeleteSetting( "OrganizerSells_Items" .. i  )
				CustomSettings.DeleteSetting( "OrganizerSells_Desc" .. i  )
			end
		end
		
		
		Organizer.ActiveSell = 1

		CustomSettings.SaveNumber( "OrganizerActiveSell" , Organizer.ActiveSell )
		table.remove(Organizer.Sell,index)
		table.remove(Organizer.Sells_Items,index)
		table.remove(Organizer.Sells_Desc,index)
		Organizer.Sells = Organizer.Sells - 1
		if (Organizer.Sells <= 0) then
			Organizer.Sells = 1
			Organizer.Sells_Items[1] =  0 
			Organizer.Sells_Desc[1] =  L""
		end
		CustomSettings.SaveNumber( "OrganizerSells" , Organizer.Sells )
		for i=1,  Organizer.Sells do	
			if (Organizer.Sells_Items[i]) then
				for k=1,  Organizer.Sells_Items[i] do
					if (Organizer.Sell[i][k]) then
						local item = Organizer.Sell[i][k]
						CustomSettings.SaveString( "Sell" .. i .. "it" .. k .. "Name" , item.name )
						CustomSettings.SaveNumber( "Sell" .. i .. "it" .. k .. "Type" , item.type )
						CustomSettings.SaveNumber( "Sell" .. i .. "it" .. k .. "Hue" , item.hue )
						CustomSettings.SaveNumber( "Sell" .. i .. "it" .. k .. "Qta" , item.qta )
					end
				end
				CustomSettings.SaveNumber( "OrganizerSells_Items" .. i  , Organizer.Sells_Items[i] )
				CustomSettings.SaveWString( "OrganizerSells_Desc" .. i  , Organizer.Sells_Desc[i] )
			end
		end
		
	elseif wstring.find(text, L"Scavenger") then
		for i=1,  Organizer.Scavengers do	
			if (Organizer.Scavengers_Items[i]) then
				for k=1,  Organizer.Scavengers_Items[i] do
					CustomSettings.DeleteStringSetting( "Scavenger" .. i .. "it" .. k .. "Name"  )
					CustomSettings.DeleteSetting( "Scavenger" .. i .. "it" .. k .. "Type"  )
					CustomSettings.DeleteSetting( "Scavenger" .. i .. "it" .. k .. "Hue"  )
					CustomSettings.DeleteSetting( "Scavenger" .. i .. "it" .. k .. "Qta" )
				end
				CustomSettings.DeleteSetting( "OrganizerScavengers_Items" .. i  )
				CustomSettings.DeleteSetting( "OrganizerScavengers_Desc" .. i  )
				CustomSettings.DeleteSetting( "OrganizerScavengers_Cont" .. i  )
			end
		end
		

		Organizer.ActiveScavenger = 1

		CustomSettings.SaveNumber( "OrganizerActiveScavenger" , Organizer.ActiveScavenger )
		table.remove(Organizer.Scavenger,index)
		table.remove(Organizer.Scavengers_Items,index)
		table.remove(Organizer.Scavengers_Desc,index)
		Organizer.Scavengers = Organizer.Scavengers - 1
		if (Organizer.Scavengers <= 0) then
			Organizer.Scavengers = 1
			Organizer.Scavengers_Items[1] =   0 
			Organizer.Scavengers_Desc[1] =   L"" 
			Organizer.Scavengers_Cont[1] =  0 
		end
		CustomSettings.SaveNumber( "OrganizerScavengers" , Organizer.Scavengers )
		for i=1,  Organizer.Scavengers do	
			if (Organizer.Scavengers_Items[i]) then
				for k=1,  Organizer.Scavengers_Items[i] do
					if (Organizer.Scavenger[i][k]) then
						local item = Organizer.Scavenger[i][k]
						CustomSettings.SaveString( "Scavenger" .. i .. "it" .. k .. "Name" , item.name )
						CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. k .. "Type" , item.type )
						CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. k .. "Hue" , item.hue )
						CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. k .. "Qta" , item.qta )
					end
				end
				CustomSettings.SaveNumber( "OrganizerScavengers_Items" .. i  , Organizer.Scavengers_Items[i] )
				CustomSettings.SaveWString( "OrganizerScavengers_Desc" .. i  , Organizer.Scavengers_Desc[i] )
				CustomSettings.SaveNumber( "OrganizerScavengers_Cont" .. i  , Organizer.Scavengers_Cont[i] )
			end
		end
	end
	OrganizerWindow.ClearList()
	OrganizerWindow.UpdateCombo()
end


function OrganizerWindow.OnAddTypeButton()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	if text == "OrganizerWindowAgentCombo" or text == nil  or ButtonGetDisabledFlag( "OrganizerWindowAddTypeButton" ) then
		return
	end
	RequestTargetInfo()
	EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 589), 1152, true)
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "OrganizerWindow.AddTypeRequestTargetInfoReceived")
end

function OrganizerWindow.AddTypeRequestTargetInfoReceived(obj, qta)
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	local objectId = SystemData.RequestInfo.ObjectId 
	if (objectId == 0 or objectId == nil) then
		return
	end
	
	if (wstring.find(text, L"Restock") or wstring.find(text, L"Buy") or wstring.find(text, L"Sell")) and not obj then
		local rdata = {title=GetStringFromTid(1077826), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 595), callfunction=OrganizerWindow.AddTypeRequestTargetInfoReceived, id=SystemData.RequestInfo.ObjectId}
		RenameWindow.Create(rdata)
		return
	end
	
	if (obj and type(tonumber(qta)) ~= "number") then
		return
	elseif( qta) then
		qta = tonumber(qta)
	end
	
	local fnd = wstring.find(text, L" ")
	local i = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	
	
	if obj then
		objectId = obj
	end
	local itemData = WindowData.ObjectInfo[objectId]
	if not itemData then
		return
	end
	if wstring.find(text, L"Organizer") then
		if not Organizer.Organizers_Items[i] then
			Organizer.Organizers_Items[i] = 0
		end
		Organizer.Organizers_Items[i] = Organizer.Organizers_Items[i] + 1
		CustomSettings.SaveNumber( "OrganizerOrganizers_Items" .. i  , Organizer.Organizers_Items[i] )
		local j = Organizer.Organizers_Items[i]
		
		if not Organizer.Organizer[i] then
			Organizer.Organizer[i] = {}
		end
		if not Organizer.Organizer[i][j] then
			Organizer.Organizer[i][j] = {}
		end
		
		
		local item = {name="", type=0, hue=0, id=0}
		
		item.name = WStringToString(Shopkeeper.stripFirstNumber(itemData.name))
		item.type = itemData.objectType
		item.hue = itemData.hueId
		item.id = 0
		Organizer.Organizer[i][j] = item
		
		CustomSettings.SaveString( "Organizer" .. i .. "it" .. j .. "Name" , item.name )
		CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. j .. "Type" , item.type )
		CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. j .. "Hue" , item.hue )
		CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. j .. "Id" , item.id )
	elseif wstring.find(text, L"Undress") then
		-- NOT AVAILABLE
	elseif wstring.find(text, L"Restock") then
		if not Organizer.Restocks_Items[i] then
			Organizer.Restocks_Items[i] = 0
		end
		Organizer.Restocks_Items[i] = Organizer.Restocks_Items[i] + 1
		CustomSettings.SaveNumber( "OrganizerRestocks_Items" .. i  , Organizer.Restocks_Items[i] )
		local j = Organizer.Restocks_Items[i]
		
		if not Organizer.Restock[i] then
			Organizer.Restock[i] = {}
		end
		if not Organizer.Restock[i][j] then
			Organizer.Restock[i][j] = {}
		end
		
		
		local item = {name="", type=0, hue=0, qta=0}
		
		item.name = WStringToString(Shopkeeper.stripFirstNumber(itemData.name))
		item.type = itemData.objectType
		item.hue = itemData.hueId
		item.qta = qta
		Organizer.Restock[i][j] = item
		CustomSettings.SaveString( "Restock" .. i .. "it" .. j .. "Name" , item.name )
		CustomSettings.SaveNumber( "Restock" .. i .. "it" .. j .. "Type" , item.type )
		CustomSettings.SaveNumber( "Restock" .. i .. "it" .. j .. "Hue" , item.hue )
		CustomSettings.SaveNumber( "Restock" .. i .. "it" .. j .. "Qta" , item.qta )
	elseif wstring.find(text, L"Buy") then
		if not Organizer.Buys_Items[i] then
			Organizer.Buys_Items[i] = 0
		end
		Organizer.Buys_Items[i] = Organizer.Buys_Items[i] + 1
		CustomSettings.SaveNumber( "OrganizerBuys_Items" .. i  , Organizer.Buys_Items[i] )
		local j = Organizer.Buys_Items[i]
		
		if not Organizer.Buy[i] then
			Organizer.Buy[i] = {}
		end
		if not Organizer.Buy[i][j] then
			Organizer.Buy[i][j] = {}
		end
		
		
		local item = {name="", type=0, hue=0, qta=0}
		
		item.name = WStringToString(Shopkeeper.stripFirstNumber(itemData.name))
		item.type = itemData.objectType
		item.hue = itemData.hueId
		item.qta = qta
		Organizer.Buy[i][j] = item
		CustomSettings.SaveString( "Buy" .. i .. "it" .. j .. "Name" , item.name )
		CustomSettings.SaveNumber( "Buy" .. i .. "it" .. j .. "Type" , item.type )
		CustomSettings.SaveNumber( "Buy" .. i .. "it" .. j .. "Hue" , item.hue )
		CustomSettings.SaveNumber( "Buy" .. i .. "it" .. j .. "Qta" , item.qta )
	elseif wstring.find(text, L"Sell") then
		if not Organizer.Sells_Items[i] then
			Organizer.Sells_Items[i] = 0
		end
		Organizer.Sells_Items[i] = Organizer.Sells_Items[i] + 1
		CustomSettings.SaveNumber( "OrganizerSells_Items" .. i  , Organizer.Sells_Items[i] )
		local j = Organizer.Sells_Items[i]
		
		if not Organizer.Sell[i] then
			Organizer.Sell[i] = {}
		end
		if not Organizer.Sell[i][j] then
			Organizer.Sell[i][j] = {}
		end
		
		
		local item = {name="", type=0, hue=0, qta=0}
		
		item.name = WStringToString(Shopkeeper.stripFirstNumber(itemData.name))
		item.type = itemData.objectType
		item.hue = itemData.hueId
		item.qta = qta
		Organizer.Sell[i][j] = item
		CustomSettings.SaveString( "Sell" .. i .. "it" .. j .. "Name" , item.name )
		CustomSettings.SaveNumber( "Sell" .. i .. "it" .. j .. "Type" , item.type )
		CustomSettings.SaveNumber( "Sell" .. i .. "it" .. j .. "Hue" , item.hue )
		CustomSettings.SaveNumber( "Sell" .. i .. "it" .. j .. "Qta" , item.qta )
	elseif wstring.find(text, L"Scavenger") then
		if not Organizer.Scavengers_Items[i] then
			Organizer.Scavengers_Items[i] = 0
		end
		Organizer.Scavengers_Items[i] = Organizer.Scavengers_Items[i] + 1
		CustomSettings.SaveNumber( "OrganizerScavengers_Items" .. i  , Organizer.Scavengers_Items[i] )
		local j = Organizer.Scavengers_Items[i]
		
		if not Organizer.Scavenger[i] then
			Organizer.Scavenger[i] = {}
		end
		if not Organizer.Scavenger[i][j] then
			Organizer.Scavenger[i][j] = {}
		end
		
		
		local item = {name="", type=0, hue=0, qta=0}
		
		item.name = WStringToString(Shopkeeper.stripFirstNumber(itemData.name))
		item.type = itemData.objectType
		item.hue = itemData.hueId
		item.qta = qta
		Organizer.Scavenger[i][j] = item
		CustomSettings.SaveString( "Scavenger" .. i .. "it" .. j .. "Name" , item.name )
		CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. j .. "Type" , item.type )
		CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. j .. "Hue" , item.hue )
		CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. j .. "Qta" , item.qta )
	end
	OrganizerWindow.UpdateList()
	
end

function OrganizerWindow.OnAddIDButton()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	if text == "OrganizerWindowAgentCombo" or text == nil  or ButtonGetDisabledFlag( "OrganizerWindowAddIDButton" ) then
		return
	end
	RequestTargetInfo()
	EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 590), 1152, true)
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "OrganizerWindow.AddIDRequestTargetInfoReceived")
end

function OrganizerWindow.AddIDRequestTargetInfoReceived()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	local fnd = wstring.find(text, L" ")
	local i = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	
	local objectId = SystemData.RequestInfo.ObjectId
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	local itemData = WindowData.ObjectInfo[objectId]
	if not itemData then
		return
	end
	if wstring.find(text, L"Organizer") then
		if not Organizer.Organizers_Items[i] then
			Organizer.Organizers_Items[i] = 0
		end
		Organizer.Organizers_Items[i] = Organizer.Organizers_Items[i] + 1
		CustomSettings.SaveNumber( "OrganizerOrganizers_Items" .. i  , Organizer.Organizers_Items[i] )
		local j = Organizer.Organizers_Items[i]
		
		if not Organizer.Organizer[i] then
			Organizer.Organizer[i] = {}
		end
		if not Organizer.Organizer[i][j] then
			Organizer.Organizer[i][j] = {}
		end
		
		
		local item = {name="", type=0, hue=0, id=0}
		
		item.name = WStringToString(Shopkeeper.stripFirstNumber(itemData.name))
		item.type = 0
		item.hue = 0
		item.id = objectId
		Organizer.Organizer[i][j] = item
		
		CustomSettings.SaveString( "Organizer" .. i .. "it" .. j .. "Name" , item.name )
		CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. j .. "Type" , item.type )
		CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. j .. "Hue" , item.hue )
		CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. j .. "Id" , item.id )
	elseif wstring.find(text, L"Undress") then
		if not Organizer.Undresses_Items[i] then
			Organizer.Undresses_Items[i] = 0
		end
		Organizer.Undresses_Items[i] = Organizer.Undresses_Items[i] + 1
		CustomSettings.SaveNumber( "OrganizerUndresses_Items" .. i  , Organizer.Undresses_Items[i] )
		local j = Organizer.Undresses_Items[i]
		
		if not Organizer.Undress[i] then
			Organizer.Undress[i] = {}
		end
		if not Organizer.Undress[i][j] then
			Organizer.Undress[i][j] = {}
		end
		
		
		local item = {name="", type=0, hue=0, id=0}
		
		item.name = WStringToString(Shopkeeper.stripFirstNumber(itemData.name))
		item.type = 0
		item.hue = 0
		item.id = objectId
		Organizer.Undress[i][j] = item
		
		CustomSettings.SaveString( "Undress" .. i .. "it" .. j .. "Name" , item.name )
		CustomSettings.SaveNumber( "Undress" .. i .. "it" .. j .. "Type" , item.type )
		CustomSettings.SaveNumber( "Undress" .. i .. "it" .. j .. "Hue" , item.hue )
		CustomSettings.SaveNumber( "Undress" .. i .. "it" .. j .. "Id" , item.id )
	elseif wstring.find(text, L"Restock") then
		-- NOT AVAILABLE
	elseif wstring.find(text, L"Buy") then
		-- NOT AVAILABLE
	elseif wstring.find(text, L"Sell") then
		-- NOT AVAILABLE
	elseif wstring.find(text, L"Scavenger") then
		-- NOT AVAILABLE
	end
	OrganizerWindow.UpdateList()
	
end

function OrganizerWindow.AutoClose()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	local fnd = wstring.find(text, L" ")
	local i = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	
	Organizer.Organizers_CloseCont[i] = ButtonGetPressedFlag( "OrganizerWindowCloseContainerButton" )
	CustomSettings.SaveBoolean( "OrganizerOrganizers_CloseCont" .. i  , Organizer.Organizers_CloseCont[i] )
end

function OrganizerWindow.OnSelChanged()

	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	if text == "OrganizerWindowAgentCombo" or text == nil  then
		WindowSetShowing("OrganizerWindowDefaultLabel", false)
		WindowSetShowing("OrganizerWindowDefaultButton", false)
		return
	end
	if text == L"" then
		WindowSetShowing("OrganizerWindowDefaultLabel", false)
		WindowSetShowing("OrganizerWindowDefaultButton", false)
	end
	local fnd = wstring.find(text, L" ")
	local index = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	LabelSetText("OrganizerWindowDefContButtonLabel", UI.GetCliloc(SystemData.Settings.Language.type, 624))
	LabelSetText("OrganizerWindowCloseContainerLabel", UI.GetCliloc(SystemData.Settings.Language.type, 651))
	ButtonSetCheckButtonFlag( "OrganizerWindowCloseContainerButton", true )
	ButtonSetPressedFlag( "OrganizerWindowCloseContainerButton", Organizer.Organizers_CloseCont[index] )
	ButtonSetDisabledFlag( "OrganizerWindowCloseContainerButton", true )
	LabelSetTextColor("OrganizerWindowCloseContainerLabel", 127,127,127)
	WindowSetShowing("OrganizerWindowDefContButton", true)
	if wstring.find(text, L"Organizer") then
		if (Organizer.Organizers_Cont[index] > 0) then
			LabelSetText("OrganizerWindowDefContButtonLabel", UI.GetCliloc(SystemData.Settings.Language.type, 625))
		end
		WindowSetShowing("OrganizerWindowDefaultLabel", Organizer.ActiveOrganizer == index)
		WindowSetShowing("OrganizerWindowDefaultButton", Organizer.ActiveOrganizer ~= index)
		WindowSetShowing("OrganizerWindowCloseContainer", true)
		ButtonSetDisabledFlag( "OrganizerWindowCloseContainerButton", false )
		LabelSetTextColor("OrganizerWindowCloseContainerLabel", 255,255,255)
	elseif wstring.find(text, L"Undress") then
		if (Organizer.Undresses_Cont[index] > 0) then
			LabelSetText("OrganizerWindowDefContButtonLabel", UI.GetCliloc(SystemData.Settings.Language.type, 625))
		end
		WindowSetShowing("OrganizerWindowDefaultLabel", Organizer.ActiveUndress == index)
		WindowSetShowing("OrganizerWindowDefaultButton", Organizer.ActiveUndress ~= index)
	elseif wstring.find(text, L"Restock") then
		if (Organizer.Restocks_Cont[index] > 0) then
			LabelSetText("OrganizerWindowDefContButtonLabel", UI.GetCliloc(SystemData.Settings.Language.type, 625))
		end
		WindowSetShowing("OrganizerWindowDefaultLabel", Organizer.ActiveRestock == index)
		WindowSetShowing("OrganizerWindowDefaultButton", Organizer.ActiveRestock ~= index)
	elseif wstring.find(text, L"Scavenger") then
		if (Organizer.Scavengers_Cont[index] > 0) then
			LabelSetText("OrganizerWindowDefContButtonLabel", UI.GetCliloc(SystemData.Settings.Language.type, 625))
		end
		WindowSetShowing("OrganizerWindowDefaultLabel", Organizer.ActiveScavenger == index)
		WindowSetShowing("OrganizerWindowDefaultButton", Organizer.ActiveScavenger ~= index)
	elseif wstring.find(text, L"Sell") then

		WindowSetShowing("OrganizerWindowDefaultLabel", Organizer.ActiveSell == index)
		WindowSetShowing("OrganizerWindowDefaultButton", Organizer.ActiveSell ~= index)
	elseif wstring.find(text, L"Buy") then

		WindowSetShowing("OrganizerWindowDefaultLabel", Organizer.ActiveBuy == index)
		WindowSetShowing("OrganizerWindowDefaultButton", Organizer.ActiveBuy ~= index)
	else
		WindowSetShowing("OrganizerWindowCloseContainer", false)
		WindowSetShowing("OrganizerWindowDefContButton", false)
		WindowSetShowing("OrganizerWindowDefaultLabel", false)
		WindowSetShowing("OrganizerWindowDefaultButton", false)
	end
	
	
	if wstring.find(text, L"Undress") then
		ButtonSetDisabledFlag( "OrganizerWindowAddTypeButton", true )
	else
		ButtonSetDisabledFlag( "OrganizerWindowAddTypeButton", false )
	end
	if wstring.find(text, L"Buy") or wstring.find(text, L"Sell") or wstring.find(text, L"Restock") or wstring.find(text, L"Scavenger") then
		ButtonSetDisabledFlag( "OrganizerWindowAddIDButton", true )
	else
		ButtonSetDisabledFlag( "OrganizerWindowAddIDButton", false )
	end
	OrganizerWindow.UpdateList()
end

function OrganizerWindow.UpdateList()
	OrganizerWindow.ClearList()
	
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	if text == "OrganizerWindowAgentCombo" or text == nil then
		return
	end
	if text == L"" then
		WindowSetShowing("OrganizerWindowDefaultLabel", false)
		WindowSetShowing("OrganizerWindowDefaultButton", false)
	end
	local fnd = wstring.find(text, L" ")
	local i = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	if wstring.find(text, L"Organizer") then
		local last = 0
		if (Organizer.Organizers_Items[i] and Organizer.Organizers_Items[i] > 0) then
			if not Organizer.Organizer[i] then
				return
			end
			for j=1,  Organizer.Organizers_Items[i] do
				if (Organizer.Organizer[i][j]) then
					local item = Organizer.Organizer[i][j]
					CreateWindowFromTemplate( "Item" .. j, "OrgRowTemplate", "OrganizerContent" )
					WindowSetDimensions("Item" .. j, 680, 25)
					WindowSetId("Item"..j, j)
					WindowSetShowing("Item" .. j, true)
					if (item.type == 0) then
						LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - ID: " .. item.id))
					else
						LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue))
					end
					WindowClearAnchors("Item" .. j)
					if (j <= 1) then
						WindowAddAnchor("Item" .. j, "topleft", "OrganizerContent", "topleft", 10, 20)
					else
						WindowAddAnchor("Item" .. j, "bottomleft", "Item" .. j-1, "topleft", 0, 5)
					end
					last = j
				end
			end
		end
		if last > 0 then
			local ySize = 20 + (30 * last)
			WindowSetDimensions("OrganizerContent",695, ySize)
		end
		OrganizerWindow.VisibleItems = last
		ScrollWindowUpdateScrollRect( "OrganizerContentWindow" )
	elseif wstring.find(text, L"Undress") then
		local last = 0
		if (Organizer.Undresses_Items[i] and Organizer.Undresses_Items[i] > 0) then
			if not Organizer.Undress[i] then
				return
			end
			for j=1,  Organizer.Undresses_Items[i] do
				if (Organizer.Undress[i][j]) then
					local item = Organizer.Undress[i][j]
					CreateWindowFromTemplate( "Item" .. j, "OrgRowTemplate", "OrganizerContent" )
					WindowSetDimensions("Item" .. j, 680, 25)
					WindowSetId("Item"..j, j)
					WindowSetShowing("Item" .. j, true)
					if (item.type == 0) then
						LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - ID: " .. item.id))
					else
						LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue))
					end
					WindowClearAnchors("Item" .. j)
					if (j <= 1) then
						WindowAddAnchor("Item" .. j, "topleft", "OrganizerContent", "topleft", 10, 20)
					else
						WindowAddAnchor("Item" .. j, "bottomleft", "Item" .. j-1, "topleft", 0, 5)
					end
					last = j
				end
			end
		end
		if last > 0 then
			local ySize = 20 + (30 * last)
			WindowSetDimensions("OrganizerContent",695, ySize)
		end
		OrganizerWindow.VisibleItems = last
		ScrollWindowUpdateScrollRect( "OrganizerContentWindow" )
	elseif wstring.find(text, L"Restock") then
		local last = 0
		if (Organizer.Restocks_Items[i] and Organizer.Restocks_Items[i] > 0) then
			if not Organizer.Restock[i] then
				return
			end
			for j=1,  Organizer.Restocks_Items[i] do
				if (Organizer.Restock[i][j]) then
					local item = Organizer.Restock[i][j]
					CreateWindowFromTemplate( "Item" .. j, "OrgRowTemplate", "OrganizerContent" )
					WindowSetDimensions("Item" .. j, 680, 25)
					WindowSetId("Item"..j, j)
					WindowSetShowing("Item" .. j, true)
					if (item.type == 0) then
						LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - ID: " .. item.id))
					else
						if (item.qta) then
							LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue .. ", Amount: " .. item.qta))
						else
							LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue))
						end
					end
					WindowClearAnchors("Item" .. j)
					if (j <= 1) then
						WindowAddAnchor("Item" .. j, "topleft", "OrganizerContent", "topleft", 10, 20)
					else
						WindowAddAnchor("Item" .. j, "bottomleft", "Item" .. j-1, "topleft", 0, 5)
					end
					last = j
				end
			end
		end
		if last > 0 then
			local ySize = 20 + (30 * last)
			WindowSetDimensions("OrganizerContent",695, ySize)
		end
		OrganizerWindow.VisibleItems = last
		ScrollWindowUpdateScrollRect( "OrganizerContentWindow" )
	elseif wstring.find(text, L"Buy") then
		local last = 0
		if (Organizer.Buys_Items[i] and Organizer.Buys_Items[i] > 0) then
			if not Organizer.Buy[i] then
				return
			end
			for j=1,  Organizer.Buys_Items[i] do
				if (Organizer.Buy[i][j]) then
					local item = Organizer.Buy[i][j]
					CreateWindowFromTemplate( "Item" .. j, "OrgRowTemplate", "OrganizerContent" )
					WindowSetDimensions("Item" .. j, 680, 25)
					WindowSetId("Item"..j, j)
					WindowSetShowing("Item" .. j, true)
					if (item.type == 0) then
						LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - ID: " .. item.id))
					else
						if (item.qta) then
							LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue .. ", Amount: " .. item.qta))
						else
							LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue))
						end
					end
					WindowClearAnchors("Item" .. j)
					if (j <= 1) then
						WindowAddAnchor("Item" .. j, "topleft", "OrganizerContent", "topleft", 10, 20)
					else
						WindowAddAnchor("Item" .. j, "bottomleft", "Item" .. j-1, "topleft", 0, 5)
					end
					last = j
				end
			end
		end
		if last > 0 then
			local ySize = 20 + (30 * last)
			WindowSetDimensions("OrganizerContent",695, ySize)
		end
		OrganizerWindow.VisibleItems = last
		ScrollWindowUpdateScrollRect( "OrganizerContentWindow" )
	elseif wstring.find(text, L"Sell") then
		local last = 0
		if (Organizer.Sells_Items[i] and Organizer.Sells_Items[i] > 0) then
			if not Organizer.Sell[i] then
				return
			end
			for j=1,  Organizer.Sells_Items[i] do
				if (Organizer.Sell[i][j]) then
					local item = Organizer.Sell[i][j]
					CreateWindowFromTemplate( "Item" .. j, "OrgRowTemplate", "OrganizerContent" )
					WindowSetDimensions("Item" .. j, 680, 25)
					WindowSetId("Item"..j, j)
					WindowSetShowing("Item" .. j, true)
					if (item.type == 0) then
						LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - ID: " .. item.id))
					else
						if (item.qta) then
							LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue .. ", Amount: " .. item.qta))
						else
							LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue))
						end
					end
					WindowClearAnchors("Item" .. j)
					if (j <= 1) then
						WindowAddAnchor("Item" .. j, "topleft", "OrganizerContent", "topleft", 10, 20)
					else
						WindowAddAnchor("Item" .. j, "bottomleft", "Item" .. j-1, "topleft", 0, 5)
					end
					last = j
				end
			end
		end
		if last > 0 then
			local ySize = 20 + (30 * last)
			WindowSetDimensions("OrganizerContent",695, ySize)
		end
		OrganizerWindow.VisibleItems = last
		ScrollWindowUpdateScrollRect( "OrganizerContentWindow" )
		
	elseif wstring.find(text, L"Scavenger") then
		local last = 0
		if (Organizer.Scavengers_Items[i] and Organizer.Scavengers_Items[i] > 0) then
			if not Organizer.Scavenger[i] then
				return
			end
			for j=1,  Organizer.Scavengers_Items[i] do
				if (Organizer.Scavenger[i][j]) then
					local item = Organizer.Scavenger[i][j]
					CreateWindowFromTemplate( "Item" .. j, "OrgRowTemplate", "OrganizerContent" )
					WindowSetDimensions("Item" .. j, 680, 25)
					WindowSetId("Item"..j, j)
					WindowSetShowing("Item" .. j, true)
					if (item.type == 0) then
						LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - ID: " .. item.id))
					else
						if (item.qta) then
							LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue .. ", Amount: " .. item.qta))
						else
							LabelSetText("Item" .. j .. "Label", StringToWString(item.name .. " - Type: " .. item.type .. ", Hue: " .. item.hue))
						end
					end
					WindowClearAnchors("Item" .. j)
					if (j <= 1) then
						WindowAddAnchor("Item" .. j, "topleft", "OrganizerContent", "topleft", 10, 20)
					else
						WindowAddAnchor("Item" .. j, "bottomleft", "Item" .. j-1, "topleft", 0, 5)
					end
					last = j
				end
			end
		end
		if last > 0 then
			local ySize = 20 + (30 * last)
			WindowSetDimensions("OrganizerContent",695, ySize)
		end
		OrganizerWindow.VisibleItems = last
		ScrollWindowUpdateScrollRect( "OrganizerContentWindow" )
	end
end

function OrganizerWindow.RemoveItem()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	local this = SystemData.ActiveWindow.name
	if text == "OrganizerWindowAgentCombo" or text == nil  then
		return
	end
	if wstring.find(text, L"Restock") or wstring.find(text, L"Buy") or wstring.find(text, L"Sell") then
		local param = this
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 604),0,"Edit",param,false)
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 605),0,"Delete",param,false)
		
		ContextMenu.ActivateLuaContextMenu(OrganizerWindow.ContextMenuCallback)
	else
		local okayButton = { textTid=1011036, callback=function()OrganizerWindow.ExeRemoveItem(this)end }
		local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL}
		local DestroyConfirmWindow = 
					{
						windowName = "RemoveItem",
						title =  UI.GetCliloc(SystemData.Settings.Language.type, 618),
					body =  UI.GetCliloc(SystemData.Settings.Language.type, 620),
						buttons = { okayButton, cancelButton }
					}
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
	end
end

function OrganizerWindow.ExeRemoveItem(windowName)
	local this = windowName
	local j = WindowGetId(this)
	
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	if text == "OrganizerWindowAgentCombo" or text == nil  then
		return
	end
	
	
	local fnd = wstring.find(text, L" ")
	local i = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	
	if wstring.find(text, L"Organizer") then
		for k=1,  Organizer.Organizers_Items[i] do
			CustomSettings.DeleteStringSetting( "Organizer" .. i .. "it" .. k .. "Name"  )
			CustomSettings.DeleteSetting( "Organizer" .. i .. "it" .. k .. "Type"  )
			CustomSettings.DeleteSetting( "Organizer" .. i .. "it" .. k .. "Hue"  )
			CustomSettings.DeleteSetting( "Organizer" .. i .. "it" .. k .. "Id"  )
		end
		table.remove(Organizer.Organizer[i],j)
		
		Organizer.Organizers_Items[i] = Organizer.Organizers_Items[i] -1
		CustomSettings.SaveNumber( "OrganizerOrganizers_Items" .. i  , Organizer.Organizers_Items[i] )
		
		for k=1,  Organizer.Organizers_Items[i] do
			item = Organizer.Organizer[i][k]
			
			CustomSettings.SaveString( "Organizer" .. i .. "it" .. k .. "Name" , item.name )
			CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. k .. "Type" , item.type )
			CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. k .. "Hue" , item.hue )
			CustomSettings.SaveNumber( "Organizer" .. i .. "it" .. k .. "Id" , item.id )
		end
	elseif wstring.find(text, L"Undress") then
		for k=1,  Organizer.Undresses_Items[i] do
			CustomSettings.DeleteStringSetting( "Undress" .. i .. "it" .. k .. "Name"  )
			CustomSettings.DeleteSetting( "Undress" .. i .. "it" .. k .. "Type"  )
			CustomSettings.DeleteSetting( "Undress" .. i .. "it" .. k .. "Hue"  )
			CustomSettings.DeleteSetting( "Undress" .. i .. "it" .. k .. "Id"  )
		end
		table.remove(Organizer.Undress[i],j)
		
		Organizer.Undresses_Items[i] = Organizer.Undresses_Items[i] -1
		CustomSettings.SaveNumber( "OrganizerUndresses_Items" .. i  , Organizer.Undresses_Items[i] )
		
		for k=1,  Organizer.Undresses_Items[i] do
			item = Organizer.Undress[i][k]
			
			CustomSettings.SaveString( "Undress" .. i .. "it" .. k .. "Name" , item.name )
			CustomSettings.SaveNumber( "Undress" .. i .. "it" .. k .. "Type" , item.type )
			CustomSettings.SaveNumber( "Undress" .. i .. "it" .. k .. "Hue" , item.hue )
			CustomSettings.SaveNumber( "Undress" .. i .. "it" .. k .. "Id" , item.id )
		end
	elseif wstring.find(text, L"Restock") then
		for k=1,  Organizer.Restocks_Items[i] do
			CustomSettings.DeleteStringSetting( "Restock" .. i .. "it" .. k .. "Name"  )
			CustomSettings.DeleteSetting( "Restock" .. i .. "it" .. k .. "Type"  )
			CustomSettings.DeleteSetting( "Restock" .. i .. "it" .. k .. "Hue"  )
			CustomSettings.DeleteSetting( "Restock" .. i .. "it" .. k .. "Qta"  )
		end
		table.remove(Organizer.Restock[i],j)
		
		Organizer.Restocks_Items[i] = Organizer.Restocks_Items[i] -1
		CustomSettings.SaveNumber( "OrganizerRestocks_Items" .. i  , Organizer.Restocks_Items[i] )
		
		for k=1,  Organizer.Restocks_Items[i] do
			item = Organizer.Restock[i][k]
			
			CustomSettings.SaveString( "Restock" .. i .. "it" .. k .. "Name" , item.name )
			CustomSettings.SaveNumber( "Restock" .. i .. "it" .. k .. "Type" , item.type )
			CustomSettings.SaveNumber( "Restock" .. i .. "it" .. k .. "Hue" , item.hue )
			CustomSettings.SaveNumber( "Restock" .. i .. "it" .. k .. "Qta" , item.qta )
		end
	elseif wstring.find(text, L"Buy") then
		for k=1,  Organizer.Buys_Items[i] do
			CustomSettings.DeleteStringSetting( "Buy" .. i .. "it" .. k .. "Name"  )
			CustomSettings.DeleteSetting( "Buy" .. i .. "it" .. k .. "Type"  )
			CustomSettings.DeleteSetting( "Buy" .. i .. "it" .. k .. "Hue"  )
			CustomSettings.DeleteSetting( "Buy" .. i .. "it" .. k .. "Qta"  )
		end
		table.remove(Organizer.Buy[i],j)
		
		Organizer.Buys_Items[i] = Organizer.Buys_Items[i] -1
		CustomSettings.SaveNumber( "OrganizerBuys_Items" .. i  , Organizer.Buys_Items[i] )
		
		for k=1,  Organizer.Buys_Items[i] do
			item = Organizer.Buy[i][k]
			
			CustomSettings.SaveString( "Buy" .. i .. "it" .. k .. "Name" , item.name )
			CustomSettings.SaveNumber( "Buy" .. i .. "it" .. k .. "Type" , item.type )
			CustomSettings.SaveNumber( "Buy" .. i .. "it" .. k .. "Hue" , item.hue )
			CustomSettings.SaveNumber( "Buy" .. i .. "it" .. k .. "Qta" , item.qta )
		end
	elseif wstring.find(text, L"Sell") then
		for k=1,  Organizer.Sells_Items[i] do
			CustomSettings.DeleteStringSetting( "Sell" .. i .. "it" .. k .. "Name"  )
			CustomSettings.DeleteSetting( "Sell" .. i .. "it" .. k .. "Type"  )
			CustomSettings.DeleteSetting( "Sell" .. i .. "it" .. k .. "Hue"  )
			CustomSettings.DeleteSetting( "Sell" .. i .. "it" .. k .. "Qta"  )
		end
		table.remove(Organizer.Sell[i],j)
		
		Organizer.Sells_Items[i] = Organizer.Sells_Items[i] -1
		CustomSettings.SaveNumber( "OrganizerSells_Items" .. i  , Organizer.Sells_Items[i] )
		
		for k=1,  Organizer.Sells_Items[i] do
			item = Organizer.Sell[i][k]
			
			CustomSettings.SaveString( "Sell" .. i .. "it" .. k .. "Name" , item.name )
			CustomSettings.SaveNumber( "Sell" .. i .. "it" .. k .. "Type" , item.type )
			CustomSettings.SaveNumber( "Sell" .. i .. "it" .. k .. "Hue" , item.hue )
			CustomSettings.SaveNumber( "Sell" .. i .. "it" .. k .. "Qta" , item.qta )
		end
		
	elseif wstring.find(text, L"Scavenger") then
		for k=1,  Organizer.Scavengers_Items[i] do
			CustomSettings.DeleteStringSetting( "Scavenger" .. i .. "it" .. k .. "Name"  )
			CustomSettings.DeleteSetting( "Scavenger" .. i .. "it" .. k .. "Type"  )
			CustomSettings.DeleteSetting( "Scavenger" .. i .. "it" .. k .. "Hue"  )
			CustomSettings.DeleteSetting( "Scavenger" .. i .. "it" .. k .. "Qta"  )
		end
		table.remove(Organizer.Scavenger[i],j)
		
		Organizer.Scavengers_Items[i] = Organizer.Scavengers_Items[i] -1
		CustomSettings.SaveNumber( "OrganizerScavengers_Items" .. i  , Organizer.Scavengers_Items[i] )
		
		for k=1,  Organizer.Scavengers_Items[i] do
			item = Organizer.Scavenger[i][k]
			
			CustomSettings.SaveString( "Scavenger" .. i .. "it" .. k .. "Name" , item.name )
			CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. k .. "Type" , item.type )
			CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. k .. "Hue" , item.hue )
			CustomSettings.SaveNumber( "Scavenger" .. i .. "it" .. k .. "Qta" , item.qta )
		end
	end
	
	
	WindowSetShowing("OrganizerWindowDefaultLabel", false)
	WindowSetShowing("OrganizerWindowDefaultButton", false)

	OrganizerWindow.UpdateList()
	
end

function OrganizerWindow.ClearList()
	for j=1, OrganizerWindow.VisibleItems do
		if (DoesWindowNameExist("Item" .. j)) then
			DestroyWindow("Item" .. j)
		end
	end
	
end

function OrganizerWindow.Shutdown()
	WindowUtils.SaveWindowPosition("OrganizerWindow")
	WindowSetShowing("OrganizerWindow", false)   
end

function OrganizerWindow.PlusItemMouseOver()
	local this = SystemData.ActiveWindow.name
	LabelSetTextColor(this.."Label",0,255,0)
end

function OrganizerWindow.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	LabelSetTextColor(this.."Label",255,0,0)
end

function OrganizerWindow.ClearMouseOverItem()
	local this = SystemData.ActiveWindow.name
	LabelSetTextColor(this.."Label",255,255,255)
end


function OrganizerWindow.DefaultButtonMouseOver()

	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 5036))

	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )

end

function OrganizerWindow.SetDefault()
	local text = OrganizerWindow.Combo[ComboBoxGetSelectedMenuItem( "OrganizerWindowAgentCombo" )]
	if text == "OrganizerWindowAgentCombo" or text == nil  then
		return
	end
	local fnd = wstring.find(text, L" ")
	local index = tonumber(WStringToString(wstring.sub(text, fnd+1)))
	
	
	if wstring.find(text, L"Organizer") then
		Organizer.ActiveOrganizer = index
		CustomSettings.SaveNumber( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )
		
	elseif wstring.find(text, L"Undress") then
		Organizer.ActiveUndress = index
		CustomSettings.SaveNumber( "OrganizerActiveUndress" , Organizer.ActiveUndress )
	elseif wstring.find(text, L"Restock") then
		Organizer.ActiveRestock = index
		CustomSettings.SaveNumber( "OrganizerActiveRestock" , Organizer.ActiveRestock )
	
	elseif wstring.find(text, L"Sell") then
		Organizer.ActiveSell = index
		CustomSettings.SaveNumber( "OrganizerActiveSell" , Organizer.ActiveSell )

	elseif wstring.find(text, L"Scavenger") then
		Organizer.ActiveScavenger = index
		CustomSettings.SaveNumber( "OrganizerActiveScavenger" , Organizer.ActiveScavenger )
	end
	
	WindowSetShowing("OrganizerWindowDefaultLabel", true)
	WindowSetShowing("OrganizerWindowDefaultButton", false)
end