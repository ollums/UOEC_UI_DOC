AnimalLore = {}



AnimalLore.Ratings = {}
AnimalLore.MinTaming = 0

AnimalLore.Highlight = {
["Strength"] = true,
["Dexterity"] = true,
["Stamina"] = true,
["Intelligence"] = true,
["Mana"] = true,
["Hits"] = true,

["PhysRes"] = true,
["FireRes"] = true,
["ColdRes"] = true,
["PoisRes"] = true,
["EnergyRes"] = true,

["Wrestling"] = true,
["Magery"] = true,
["Tactics"] = true,
["EvalInt"] = true,
["Anatomy"] = true,
["Meditation"] = true,
["ResSpell"] = true,
["PoisHeal"] = true,

}
AnimalLore.AnimalLog = false

function AnimalLore.Stat_Tooltip()
	local windowName = SystemData.ActiveWindow.name
	local stat = string.gsub(windowName, "SquareIcon", "")
	stat = string.gsub(stat, "AnimalLore", "")
	if (EnhancePack.AnimalLore[stat .. "Cur"]) then
		local sts ={
		["Hits"] = GetStringFromTid(1061149),
		["Stamina"] = GetStringFromTid(1061150),
		["Mana"] = GetStringFromTid(1061151),
		}
		Tooltips.CreateTextOnlyTooltip(windowName, sts[stat] .. L": " .. EnhancePack.AnimalLore[stat .. "Cur"])
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end	
end

function AnimalLore.Initialized()
	
	for key, value in pairs(AnimalLore.Highlight) do
		--Debug.Print(key)
		AnimalLore.Highlight[key] = CustomSettings.LoadBoolean( "AnimalLore" .. key , value )
	end
	AnimalLore.AnimalLog = CustomSettings.LoadBoolean( "AnimalLoreAnimalLog" , AnimalLore.AnimalLog )
end

function AnimalLore.Shutdown()
	WindowUtils.SaveWindowPosition("AnimalLore")
	DestroyWindow( "AnimalLore" )
end

function AnimalLore.Menu()
	
	local subMenu = {
			{ str = L"-5% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap5",pressed=EnhancePack.AnimalLoreCrapPerc == 5 },
			{ str = L"-10% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap10",pressed=EnhancePack.AnimalLoreCrapPerc == 10 },
			{ str = L"-15% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap15",pressed=EnhancePack.AnimalLoreCrapPerc == 15 },
			{ str = L"-20% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap20",pressed=EnhancePack.AnimalLoreCrapPerc == 20 },
			{ str = L"-25% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap25",pressed=EnhancePack.AnimalLoreCrapPerc == 25 },
			{ str = L"-30% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap30",pressed=EnhancePack.AnimalLoreCrapPerc == 30 },
			{ str = L"-35% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap35",pressed=EnhancePack.AnimalLoreCrapPerc == 35 },
			{ str = L"-40% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap40",pressed=EnhancePack.AnimalLoreCrapPerc == 40 },
			{ str = L"-45% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap45",pressed=EnhancePack.AnimalLoreCrapPerc == 45 },
			{ str = L"-50% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap50",pressed=EnhancePack.AnimalLoreCrapPerc == 50 },
			{ str = L"-55% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap55",pressed=EnhancePack.AnimalLoreCrapPerc == 55 },
			{ str = L"-60% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap60",pressed=EnhancePack.AnimalLoreCrapPerc == 60 },
			{ str = L"-65% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap65",pressed=EnhancePack.AnimalLoreCrapPerc == 65 },
			{ str = L"-70% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap70",pressed=EnhancePack.AnimalLoreCrapPerc == 70 },
			{ str = L"-75% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap75",pressed=EnhancePack.AnimalLoreCrapPerc == 75 },
			{ str = L"-80% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap80",pressed=EnhancePack.AnimalLoreCrapPerc == 80 },
			{ str = L"-85% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap85",pressed=EnhancePack.AnimalLoreCrapPerc == 85 },
			{ str = L"-90% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap90",pressed=EnhancePack.AnimalLoreCrapPerc == 90 },
			{ str = L"-95% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap95",pressed=EnhancePack.AnimalLoreCrapPerc == 95 },
			{ str = L"-100% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Crap100",pressed=EnhancePack.AnimalLoreCrapPerc == 100 },
			}

	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 633),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = L"-5% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad5",pressed=EnhancePack.AnimalLoreBadPerc == 5 },
			{ str = L"-10% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad10",pressed=EnhancePack.AnimalLoreBadPerc == 10 },
			{ str = L"-15% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad15",pressed=EnhancePack.AnimalLoreBadPerc == 15 },
			{ str = L"-20% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad20",pressed=EnhancePack.AnimalLoreBadPerc == 20 },
			{ str = L"-25% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad25",pressed=EnhancePack.AnimalLoreBadPerc == 25 },
			{ str = L"-30% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad30",pressed=EnhancePack.AnimalLoreBadPerc == 30 },
			{ str = L"-35% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad35",pressed=EnhancePack.AnimalLoreBadPerc == 35 },
			{ str = L"-40% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad40",pressed=EnhancePack.AnimalLoreBadPerc == 40 },
			{ str = L"-45% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad45",pressed=EnhancePack.AnimalLoreBadPerc == 45 },
			{ str = L"-50% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad50",pressed=EnhancePack.AnimalLoreBadPerc == 50 },
			{ str = L"-55% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad55",pressed=EnhancePack.AnimalLoreBadPerc == 55 },
			{ str = L"-60% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad60",pressed=EnhancePack.AnimalLoreBadPerc == 60 },
			{ str = L"-65% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad65",pressed=EnhancePack.AnimalLoreBadPerc == 65 },
			{ str = L"-70% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad70",pressed=EnhancePack.AnimalLoreBadPerc == 70 },
			{ str = L"-75% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad75",pressed=EnhancePack.AnimalLoreBadPerc == 75 },
			{ str = L"-80% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad80",pressed=EnhancePack.AnimalLoreBadPerc == 80 },
			{ str = L"-85% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad85",pressed=EnhancePack.AnimalLoreBadPerc == 85 },
			{ str = L"-90% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad90",pressed=EnhancePack.AnimalLoreBadPerc == 90 },
			{ str = L"-95% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad95",pressed=EnhancePack.AnimalLoreBadPerc == 95 },
			{ str = L"-100% ".. UI.GetCliloc(SystemData.Settings.Language.type, 632),flags=0,returnCode="Bad100",pressed=EnhancePack.AnimalLoreBadPerc == 100 },
			}
			
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 634),0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = GetStringFromTid(1061146),flags=0,returnCode="Strength",pressed=AnimalLore.Highlight["Strength"] },
			{ str = GetStringFromTid(1061147),flags=0,returnCode="Dexterity",pressed=AnimalLore.Highlight["Dexterity"] },
			{ str = GetStringFromTid(1061150),flags=0,returnCode="Stamina",pressed=AnimalLore.Highlight["Stamina"] },
			{ str = GetStringFromTid(1061148),flags=0,returnCode="Intelligence",pressed=AnimalLore.Highlight["Intelligence"] },
			{ str = GetStringFromTid(1061151),flags=0,returnCode="Mana",pressed=AnimalLore.Highlight["Mana"] },
			{ str = GetStringFromTid(1061149),flags=0,returnCode="Hits",pressed=AnimalLore.Highlight["Hits"] },
			{ str = GetStringFromTid(1061646),flags=0,returnCode="PhysRes",pressed=AnimalLore.Highlight["PhysRes"] },
			{ str = GetStringFromTid(1061647),flags=0,returnCode="FireRes",pressed=AnimalLore.Highlight["FireRes"] },
			{ str = GetStringFromTid(1061648),flags=0,returnCode="ColdRes",pressed=AnimalLore.Highlight["ColdRes"] },
			{ str = GetStringFromTid(1061649),flags=0,returnCode="PoisRes",pressed=AnimalLore.Highlight["PoisRes"] },
			{ str = GetStringFromTid(1061650),flags=0,returnCode="EnergyRes",pressed=AnimalLore.Highlight["EnergyRes"] },
			{ str = WindowUtils.Decapitalizing(GetStringFromTid(1042390)), flags=0,returnCode="Wrestling",pressed=AnimalLore.Highlight["Wrestling"] },
			{ str = WindowUtils.Decapitalizing(GetStringFromTid(1042372)),flags=0,returnCode="Magery",pressed=AnimalLore.Highlight["Magery"] },
			{ str = WindowUtils.Decapitalizing(GetStringFromTid(1042374)),flags=0,returnCode="Tactics",pressed=AnimalLore.Highlight["Tactics"] },
			{ str = WindowUtils.Decapitalizing(GetStringFromTid(1042363)),flags=0,returnCode="EvalInt",pressed=AnimalLore.Highlight["EvalInt"] },
			{ str = WindowUtils.Decapitalizing(GetStringFromTid(1042348)),flags=0,returnCode="Anatomy",pressed=AnimalLore.Highlight["Anatomy"] },
			{ str = WindowUtils.Decapitalizing(GetStringFromTid(1042393)),flags=0,returnCode="Meditation",pressed=AnimalLore.Highlight["Meditation"] },
			{ str = WindowUtils.Decapitalizing(GetStringFromTid(1049471)),flags=0,returnCode="ResSpell",pressed=AnimalLore.Highlight["ResSpell"] },
			{ str = WindowUtils.Decapitalizing(GetStringFromTid(1042364) .. L" / " .. GetStringFromTid(1042377)),flags=0,returnCode="PoisHeal",pressed=AnimalLore.Highlight["PoisHeal"] },
			}
			
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 650),0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"" ,0,"null",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 7030) ,0,"toggleLog",2,AnimalLore.AnimalLog)

	ContextMenu.ActivateLuaContextMenu(AnimalLore.ContextMenuCallback)
end

function AnimalLore.ContextMenuCallback(returnCode, param )
	if string.find(returnCode, "Bad") then
		local perc = tonumber(string.sub(returnCode, string.find(returnCode, "Bad")+3))
		EnhancePack.AnimalLoreBadPerc = perc
		CustomSettings.SaveNumber( "EnhancePackAnimalLoreBadPerc" , EnhancePack.AnimalLoreBadPerc )
		AnimalLore.LoadMainPage()
	elseif string.find(returnCode, "Crap") then
		local perc = tonumber(string.sub(returnCode, string.find(returnCode, "Crap")+4))
		EnhancePack.AnimalLoreCrapPerc = perc
		CustomSettings.SaveNumber( "EnhancePackAnimalLoreCrapPerc" , EnhancePack.AnimalLoreCrapPerc )
		AnimalLore.LoadMainPage()
	elseif returnCode == "toggleLog" then
		AnimalLore.AnimalLog = not AnimalLore.AnimalLog
		CustomSettings.SaveBoolean( "AnimalLoreAnimalLog", AnimalLore.AnimalLog) 
	else
		AnimalLore.Highlight[returnCode] = not AnimalLore.Highlight[returnCode]
		CustomSettings.SaveBoolean( "AnimalLore" .. returnCode, AnimalLore.Highlight[returnCode] )
		AnimalLore.LoadMainPage()
	end
	
end

function AnimalLore.MenuTooltip()
	local windowName = SystemData.ActiveWindow.name
	local text = GetStringFromTid(1015326)
	Tooltips.CreateTextOnlyTooltip(windowName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )	
end

AnimalLore.Tamed = false

function AnimalLore.NameCheck()
	if (GetStringFromTid(1061643) ~= EnhancePack.AnimalLore["Loyalty"]) then
		AnimalLore.Tamed = true
	else
		AnimalLore.Tamed = false
	end
	WindowSetShowing("AnimalLorePetKindComboComboBox", AnimalLore.Tamed)
	WindowSetShowing("AnimalLorePetKindComboLabel", AnimalLore.Tamed)
		-- Debug.Print("Wild")
		local name = WStringToString(WindowUtils.Decapitalizing(wstring.upper(EnhancePack.AnimalLore["Name"])))
		
		if (AnimalLore.SetSelection) then
			local j = ComboBoxGetSelectedMenuItem( "AnimalLorePetKindComboComboBox" )
			name = WStringToString(CreaturesDB.AnimalLoreTamables[j])
		end
		--Debug.Print("!" .. name .. "!")
		name = string.gsub(name, "An ", "")
		name = string.gsub(name, "A ", "")
		
		text = string.find(name , "Paragon")
		if ( text ~= nil ) then
			name = string.gsub(name, "Paragon", "")
			name = string.gsub(name, "[(]", "")
			name = string.gsub(name, "[)]", "")
		end
		
		text = string.find(name , "[(]Changeling[)]")
		if ( text ~= nil ) then
			name = "Changeling"
		end
		
		text = string.find(name , "Guardian")
		if ( text ~= nil ) then
			name = string.gsub(name, "Guardian", "")
			name = string.gsub(name, "[(]", "")
			name = string.gsub(name, "[)]", "")
		end
		
		text = string.find(name , "Renowned")
		if ( text ~= nil ) then
			name = string.sub(name,1, text - 2)
			name = name .. "renowned"
		end
		
		text = string.find(name , "CoM")
		if ( text ~= nil ) then
			name = string.sub(name,1, text - 2)
		end
		
		text = string.find(name , "TB")
		if ( text ~= nil ) then
			name = string.sub(name,1, text - 2)
		end
		
		text = string.find(name , "SL")
		if ( text ~= nil ) then
			name = string.sub(name,1, text - 2)
		end
		
		text = string.find(name , "Min")
		if ( text ~= nil and string.len(string.sub(name,1, text - 2)) > 0 ) then
			name = string.sub(name,1, text - 2)
		end
		
		name = string.gsub(name, "^%s*(.-)%s*$", "%1")
		name = string.lower(name)
		--Debug.Print("!" .. name .. "!")
		name = CreaturesDB.NameToType(name)
		--Debug.Print("!" .. name .. "!")

		if (not AnimalLore.SetSelection) then
			local found = false
			for i = 1, table.getn(CreaturesDB.AnimalLoreTamables) do
				if (CreaturesDB.AnimalLoreTamables[i] and WStringToString(CreaturesDB.AnimalLoreTamables[i])  == name) then
					ComboBoxSetSelectedMenuItem( "AnimalLorePetKindComboComboBox", i )
					found = true
				end
			end
			AnimalLore.Tamable = found
		else
			AnimalLore.Tamable = true
		end
		
		if (CreaturesDB[name] ~= nil and AnimalLore.Tamable) then
			AnimalLore.MinTaming = 	CreaturesDB[name].tamable
			
			
			if (EnhancePack.AnimalLore["Hits"] ~= L"---") then
				EnhancePack.AnimalLore["Hits"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["HitsOrg"])
				
				EnhancePack.AnimalLoreMins["Hits"] = {}
				EnhancePack.AnimalLoreMins["Hits"].min = tonumber(wstring.sub(CreaturesDB[name].hits, 1, wstring.find(CreaturesDB[name].hits, L" - "))) 
				EnhancePack.AnimalLoreMins["Hits"].max = tonumber(wstring.sub(CreaturesDB[name].hits, wstring.find(CreaturesDB[name].hits, L" - ")+3))
				if (AnimalLore.Tamed) then
					if (CreaturesDB[name].halfstat) then
						EnhancePack.AnimalLoreMins["Hits"].max = math.ceil(EnhancePack.AnimalLoreMins["Hits"].max / 2)
						EnhancePack.AnimalLoreMins["Hits"].min = math.ceil(EnhancePack.AnimalLoreMins["Hits"].min / 2)
					end
				end
				EnhancePack.AnimalLore["Hits"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["HitsCur"]) .. L"/" .. EnhancePack.AnimalLore["HitsOrg"] .. L" (" .. WindowUtils.AddCommasToNumber(EnhancePack.AnimalLoreMins["Hits"].max) .. L")"
			end
			if (EnhancePack.AnimalLore["Stamina"] ~= L"---") then
				EnhancePack.AnimalLore["Stamina"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["StaminaOrg"])
				
				EnhancePack.AnimalLoreMins["Stamina"] = {}
				EnhancePack.AnimalLoreMins["Stamina"].min = tonumber(wstring.sub(CreaturesDB[name].stamina, 1, wstring.find(CreaturesDB[name].stamina, L" - "))) 
				EnhancePack.AnimalLoreMins["Stamina"].max = tonumber(wstring.sub(CreaturesDB[name].stamina, wstring.find(CreaturesDB[name].stamina, L" - ")+3))
				if (AnimalLore.Tamed) then
					if (CreaturesDB[name].halfstat) then
						EnhancePack.AnimalLoreMins["Stamina"].max = math.ceil(EnhancePack.AnimalLoreMins["Stamina"].max / 2)
						EnhancePack.AnimalLoreMins["Stamina"].min = math.ceil(EnhancePack.AnimalLoreMins["Stamina"].min / 2)
					end
					if (EnhancePack.AnimalLoreMins["Stamina"].max < 125) then
						EnhancePack.AnimalLoreMins["Stamina"].max = 125
					end
				end
				EnhancePack.AnimalLore["Stamina"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["StaminaCur"]) .. L"/" ..EnhancePack.AnimalLore["StaminaOrg"] ..L" (" .. WindowUtils.AddCommasToNumber(EnhancePack.AnimalLoreMins["Stamina"].max) .. L")"
			end
			if (EnhancePack.AnimalLore["Mana"] ~= L"---") then
				EnhancePack.AnimalLore["Mana"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["ManaOrg"])
				
				EnhancePack.AnimalLoreMins["Mana"] = {}
				EnhancePack.AnimalLoreMins["Mana"].min = tonumber(wstring.sub(CreaturesDB[name].mana, 1, wstring.find(CreaturesDB[name].mana, L" - "))) 
				EnhancePack.AnimalLoreMins["Mana"].max = tonumber(wstring.sub(CreaturesDB[name].mana, wstring.find(CreaturesDB[name].mana, L" - ")+3))
				--if (AnimalLore.Tamed) then
				--	if (CreaturesDB[name].halfstat) then
				--		EnhancePack.AnimalLoreMins["Mana"].max = math.ceil(EnhancePack.AnimalLoreMins["Mana"].max / 2)
				--		EnhancePack.AnimalLoreMins["Mana"].min = math.ceil(EnhancePack.AnimalLoreMins["Mana"].min / 2)
				--	end
				--	if (EnhancePack.AnimalLoreMins["Mana"].max < 125) then
				--		EnhancePack.AnimalLoreMins["Mana"].max = 125
				--	end			
				--end
				EnhancePack.AnimalLore["Mana"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["ManaCur"]) .. L"/" ..EnhancePack.AnimalLore["ManaOrg"] ..L" (" .. WindowUtils.AddCommasToNumber(EnhancePack.AnimalLoreMins["Mana"].max) .. L")"
			end
			if (EnhancePack.AnimalLore["Strength"] ~= L"---") then
				EnhancePack.AnimalLore["Strength"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["StrengthOrg"])
				
				EnhancePack.AnimalLoreMins["Strength"] = {}
				EnhancePack.AnimalLoreMins["Strength"].min = tonumber(wstring.sub(CreaturesDB[name].str, 1, wstring.find(CreaturesDB[name].str, L" - "))) 
				EnhancePack.AnimalLoreMins["Strength"].max = tonumber(wstring.sub(CreaturesDB[name].str, wstring.find(CreaturesDB[name].str, L" - ")+3))
				if (AnimalLore.Tamed) then
					if (CreaturesDB[name].halfstat) then
						EnhancePack.AnimalLoreMins["Strength"].max = math.ceil(EnhancePack.AnimalLoreMins["Strength"].max / 2)
						EnhancePack.AnimalLoreMins["Strength"].min = math.ceil(EnhancePack.AnimalLoreMins["Strength"].min / 2)
					end
					if (EnhancePack.AnimalLoreMins["Strength"].max < 125) then
						EnhancePack.AnimalLoreMins["Strength"].max = 125
					end
				end
				EnhancePack.AnimalLore["Strength"] = EnhancePack.AnimalLore["StrengthOrg"] ..L" (" .. WindowUtils.AddCommasToNumber(EnhancePack.AnimalLoreMins["Strength"].max) .. L")"
			end
			if (EnhancePack.AnimalLore["Dexterity"] ~= L"---") then
				EnhancePack.AnimalLore["Dexterity"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["DexterityOrg"])
				
				EnhancePack.AnimalLoreMins["Dexterity"] = {}
				EnhancePack.AnimalLoreMins["Dexterity"].min = tonumber(wstring.sub(CreaturesDB[name].dex, 1, wstring.find(CreaturesDB[name].dex, L" - "))) 
				EnhancePack.AnimalLoreMins["Dexterity"].max = tonumber(wstring.sub(CreaturesDB[name].dex, wstring.find(CreaturesDB[name].dex, L" - ")+3))
				if (AnimalLore.Tamed) then
					if (CreaturesDB[name].halfstat) then
						EnhancePack.AnimalLoreMins["Dexterity"].max = math.ceil(EnhancePack.AnimalLoreMins["Dexterity"].max / 2)
						EnhancePack.AnimalLoreMins["Dexterity"].min = math.ceil(EnhancePack.AnimalLoreMins["Dexterity"].min / 2)
					end
					if (EnhancePack.AnimalLoreMins["Dexterity"].max < 125) then
						EnhancePack.AnimalLoreMins["Dexterity"].max = 125
					end
				end
				EnhancePack.AnimalLore["Dexterity"] = EnhancePack.AnimalLore["DexterityOrg"] ..L" (" .. WindowUtils.AddCommasToNumber(EnhancePack.AnimalLoreMins["Dexterity"].max) .. L")"
			end
			if (EnhancePack.AnimalLore["Intelligence"] ~= L"---") then
				EnhancePack.AnimalLore["Intelligence"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["IntelligenceOrg"])
				
				EnhancePack.AnimalLoreMins["Intelligence"] = {}
				EnhancePack.AnimalLoreMins["Intelligence"].min = tonumber(wstring.sub(CreaturesDB[name].int, 1, wstring.find(CreaturesDB[name].int, L" - "))) 
				EnhancePack.AnimalLoreMins["Intelligence"].max = tonumber(wstring.sub(CreaturesDB[name].int, wstring.find(CreaturesDB[name].int, L" - ")+3))
			--	if (AnimalLore.Tamed) then
			--		if (CreaturesDB[name].halfstat) then
			--			EnhancePack.AnimalLoreMins["Intelligence"].max = math.ceil(EnhancePack.AnimalLoreMins["Intelligence"].max / 2)
			--			EnhancePack.AnimalLoreMins["Intelligence"].min = math.ceil(EnhancePack.AnimalLoreMins["Intelligence"].min / 2)
			--		end
			--		if (EnhancePack.AnimalLoreMins["Intelligence"].max < 125) then
			--			EnhancePack.AnimalLoreMins["Intelligence"].max = 125
			--		end
			--	end
				EnhancePack.AnimalLore["Intelligence"] = EnhancePack.AnimalLore["IntelligenceOrg"] ..L" (" .. WindowUtils.AddCommasToNumber(EnhancePack.AnimalLoreMins["Intelligence"].max) .. L")"
			end
			
			EnhancePack.AnimalLoreMins["Wrestling"] = {}
			EnhancePack.AnimalLoreMins["Wrestling"].min = 0
			EnhancePack.AnimalLoreMins["Wrestling"].max = 0
			if (EnhancePack.AnimalLore["Wrestling"] ~= L"---" and EnhancePack.AnimalLore["Wrestling"] ~= L"0.0") then
				
				EnhancePack.AnimalLoreMins["Wrestling"].min = tonumber(wstring.sub(CreaturesDB[name].wrestling, 1, wstring.find(CreaturesDB[name].wrestling, L" - "))) 
				EnhancePack.AnimalLoreMins["Wrestling"].max = tonumber(wstring.sub(CreaturesDB[name].wrestling, wstring.find(CreaturesDB[name].wrestling, L" - ")+3))
				if (AnimalLore.Tamed) then
					EnhancePack.AnimalLoreMins["Wrestling"].max = EnhancePack.AnimalLoreMins["Wrestling"].max * 0.9
					if (EnhancePack.AnimalLoreMins["Wrestling"].max < 100) then
						EnhancePack.AnimalLoreMins["Wrestling"].max = 100
					end
				end
				EnhancePack.AnimalLore["Wrestling"] = EnhancePack.AnimalLore["WrestlingOrg"] ..L" (" .. EnhancePack.AnimalLoreMins["Wrestling"].max .. L")"
			end
			EnhancePack.AnimalLoreMins["Tactics"] = {}
			EnhancePack.AnimalLoreMins["Tactics"].min = 0
			EnhancePack.AnimalLoreMins["Tactics"].max = 0
			if (EnhancePack.AnimalLore["Tactics"] ~= L"---" and EnhancePack.AnimalLore["Tactics"] ~= L"0.0") then
				
				EnhancePack.AnimalLoreMins["Tactics"].min = tonumber(wstring.sub(CreaturesDB[name].tactics, 1, wstring.find(CreaturesDB[name].tactics, L" - "))) 
				EnhancePack.AnimalLoreMins["Tactics"].max = tonumber(wstring.sub(CreaturesDB[name].tactics, wstring.find(CreaturesDB[name].tactics, L" - ")+3))
				if (AnimalLore.Tamed) then
					EnhancePack.AnimalLoreMins["Tactics"].max = EnhancePack.AnimalLoreMins["Tactics"].max * 0.9
					if (EnhancePack.AnimalLoreMins["Tactics"].max < 100) then
						EnhancePack.AnimalLoreMins["Tactics"].max = 100
					end
				end
				EnhancePack.AnimalLore["Tactics"] = EnhancePack.AnimalLore["TacticsOrg"] ..L" (" .. EnhancePack.AnimalLoreMins["Tactics"].max  .. L")"
			end
			EnhancePack.AnimalLoreMins["ResSpell"] = {}
			EnhancePack.AnimalLoreMins["ResSpell"].min = 0
			EnhancePack.AnimalLoreMins["ResSpell"].max = 0
			if (EnhancePack.AnimalLore["ResSpell"] ~= L"---" and EnhancePack.AnimalLore["ResSpell"] ~= L"0.0") then
				
				EnhancePack.AnimalLoreMins["ResSpell"].min = tonumber(wstring.sub(CreaturesDB[name].resspell, 1, wstring.find(CreaturesDB[name].resspell, L" - "))) 
				EnhancePack.AnimalLoreMins["ResSpell"].max = tonumber(wstring.sub(CreaturesDB[name].resspell, wstring.find(CreaturesDB[name].resspell, L" - ")+3))
				if (AnimalLore.Tamed) then
					EnhancePack.AnimalLoreMins["ResSpell"].max = EnhancePack.AnimalLoreMins["ResSpell"].max * 0.9
					if (EnhancePack.AnimalLoreMins["ResSpell"].max < 100) then
						EnhancePack.AnimalLoreMins["ResSpell"].max = 100
					end
				end
				EnhancePack.AnimalLore["ResSpell"] = EnhancePack.AnimalLore["ResSpellOrg"] ..L" (" .. EnhancePack.AnimalLoreMins["ResSpell"].max .. L")"
			end
			EnhancePack.AnimalLoreMins["Anatomy"] = {}
			EnhancePack.AnimalLoreMins["Anatomy"].min = 0
			EnhancePack.AnimalLoreMins["Anatomy"].max = 0
			if (EnhancePack.AnimalLore["Anatomy"] ~= L"---" and EnhancePack.AnimalLore["Anatomy"] ~= L"0.0") then
				
				EnhancePack.AnimalLoreMins["Anatomy"].min = tonumber(wstring.sub(CreaturesDB[name].anatomy, 1, wstring.find(CreaturesDB[name].anatomy, L" - "))) 
				EnhancePack.AnimalLoreMins["Anatomy"].max = tonumber(wstring.sub(CreaturesDB[name].anatomy, wstring.find(CreaturesDB[name].anatomy, L" - ")+3))
				if (AnimalLore.Tamed) then
					EnhancePack.AnimalLoreMins["Anatomy"].max = EnhancePack.AnimalLoreMins["Anatomy"].max * 0.9
					if (EnhancePack.AnimalLoreMins["Anatomy"].max < 100) then
						EnhancePack.AnimalLoreMins["Anatomy"].max = 100
					end
				end
				EnhancePack.AnimalLore["Anatomy"] = EnhancePack.AnimalLore["AnatomyOrg"] ..L" (" .. EnhancePack.AnimalLoreMins["Anatomy"].max .. L")"
			end
			EnhancePack.AnimalLoreMins["PoisHeal"] = {}
			EnhancePack.AnimalLoreMins["PoisHeal"].min = 0
			EnhancePack.AnimalLoreMins["PoisHeal"].max = 0
			if (EnhancePack.AnimalLore["PoisHeal"] ~= L"---" and EnhancePack.AnimalLore["PoisHeal"] ~= L"0.0") then
				if (EnhancePack.AnimalLore["HasHealing"]) then
					EnhancePack.AnimalLoreMins["PoisHeal"].min = tonumber(wstring.sub(CreaturesDB[name].healing, 1, wstring.find(CreaturesDB[name].healing, L" - "))) 
					EnhancePack.AnimalLoreMins["PoisHeal"].max = tonumber(wstring.sub(CreaturesDB[name].healing, wstring.find(CreaturesDB[name].healing, L" - ")+3))
				else
					EnhancePack.AnimalLoreMins["PoisHeal"].min = tonumber(wstring.sub(CreaturesDB[name].poisoning, 1, wstring.find(CreaturesDB[name].poisoning, L" - "))) 
					EnhancePack.AnimalLoreMins["PoisHeal"].max = tonumber(wstring.sub(CreaturesDB[name].poisoning, wstring.find(CreaturesDB[name].poisoning, L" - ")+3))
				end
				if (AnimalLore.Tamed) then
					EnhancePack.AnimalLoreMins["PoisHeal"].max = EnhancePack.AnimalLoreMins["PoisHeal"].max * 0.9
					if (EnhancePack.AnimalLoreMins["PoisHeal"].max < 100) then
						EnhancePack.AnimalLoreMins["PoisHeal"].max = 100
					end
				end
				EnhancePack.AnimalLore["PoisHeal"] = EnhancePack.AnimalLore["PoisHealOrg"] ..L" (" .. EnhancePack.AnimalLoreMins["PoisHeal"].max .. L")"
			end
			EnhancePack.AnimalLoreMins["Magery"] = {}
			EnhancePack.AnimalLoreMins["Magery"].min = 0
			EnhancePack.AnimalLoreMins["Magery"].max = 0
			if (EnhancePack.AnimalLore["Magery"] ~= L"---" and EnhancePack.AnimalLore["Magery"] ~= L"0.0") then
				
				EnhancePack.AnimalLoreMins["Magery"].min = tonumber(wstring.sub(CreaturesDB[name].magery, 1, wstring.find(CreaturesDB[name].magery, L" - "))) 
				EnhancePack.AnimalLoreMins["Magery"].max = tonumber(wstring.sub(CreaturesDB[name].magery, wstring.find(CreaturesDB[name].magery, L" - ")+3))
				if (AnimalLore.Tamed) then
					EnhancePack.AnimalLoreMins["Magery"].max = EnhancePack.AnimalLoreMins["Magery"].max * 0.9
					if (EnhancePack.AnimalLoreMins["Magery"].max < 100) then
						EnhancePack.AnimalLoreMins["Magery"].max = 100
					end
				end
				EnhancePack.AnimalLore["Magery"] = EnhancePack.AnimalLore["MageryOrg"] ..L" (" .. EnhancePack.AnimalLoreMins["Magery"].max  .. L")"
			end
			EnhancePack.AnimalLoreMins["EvalInt"] = {}
			EnhancePack.AnimalLoreMins["EvalInt"].min = 0
			EnhancePack.AnimalLoreMins["EvalInt"].max = 0
			if (EnhancePack.AnimalLore["EvalInt"] ~= L"---" and EnhancePack.AnimalLore["EvalInt"] ~= L"0.0") then

				EnhancePack.AnimalLoreMins["EvalInt"].min = tonumber(wstring.sub(CreaturesDB[name].evalint, 1, wstring.find(CreaturesDB[name].evalint, L" - "))) 
				EnhancePack.AnimalLoreMins["EvalInt"].max = tonumber(wstring.sub(CreaturesDB[name].evalint, wstring.find(CreaturesDB[name].evalint, L" - ")+3))
				if (AnimalLore.Tamed) then
					EnhancePack.AnimalLoreMins["EvalInt"].max = EnhancePack.AnimalLoreMins["EvalInt"].max * 0.9
					if (EnhancePack.AnimalLoreMins["EvalInt"].max < 100) then
						EnhancePack.AnimalLoreMins["EvalInt"].max = 100
					end
				end
				EnhancePack.AnimalLore["EvalInt"] = EnhancePack.AnimalLore["EvalIntOrg"] ..L" (" .. EnhancePack.AnimalLoreMins["EvalInt"].max .. L")"
			end
			EnhancePack.AnimalLoreMins["Meditation"] = {}
			EnhancePack.AnimalLoreMins["Meditation"].min = 0
			EnhancePack.AnimalLoreMins["Meditation"].max = 0
			if (EnhancePack.AnimalLore["Meditation"] ~= L"---" and EnhancePack.AnimalLore["Meditation"] ~= L"0.0") then
				
				EnhancePack.AnimalLoreMins["Meditation"].min = tonumber(wstring.sub(CreaturesDB[name].meditation, 1, wstring.find(CreaturesDB[name].meditation, L" - "))) 
				EnhancePack.AnimalLoreMins["Meditation"].max = tonumber(wstring.sub(CreaturesDB[name].meditation, wstring.find(CreaturesDB[name].meditation, L" - ")+3))
				if (AnimalLore.Tamed) then
					EnhancePack.AnimalLoreMins["Meditation"].max = EnhancePack.AnimalLoreMins["Meditation"].max * 0.9
					if (EnhancePack.AnimalLoreMins["Meditation"].max < 100) then
						EnhancePack.AnimalLoreMins["Meditation"].max = 100
					end
				end
				EnhancePack.AnimalLore["Meditation"] = EnhancePack.AnimalLore["MeditationOrg"] ..L" (" .. EnhancePack.AnimalLoreMins["Meditation"].max .. L")"
			end
			
			-- RESISTANCES
			local max = tonumber(wstring.sub(CreaturesDB[name].physical, wstring.find(CreaturesDB[name].physical, L" - ")+3)) + tonumber(wstring.sub(CreaturesDB[name].fire, wstring.find(CreaturesDB[name].fire, L" - ")+3)) + tonumber(wstring.sub(CreaturesDB[name].cold, wstring.find(CreaturesDB[name].cold, L" - ")+3)) + tonumber(wstring.sub(CreaturesDB[name].poison, wstring.find(CreaturesDB[name].poison, L" - ")+3))+ tonumber(wstring.sub(CreaturesDB[name].energy, wstring.find(CreaturesDB[name].energy, L" - ")+3))
			local min = tonumber(wstring.sub(CreaturesDB[name].physical, 1, wstring.find(CreaturesDB[name].physical, L" - "))) + tonumber(wstring.sub(CreaturesDB[name].fire, 1, wstring.find(CreaturesDB[name].physical, L" - "))) + tonumber(wstring.sub(CreaturesDB[name].cold, 1, wstring.find(CreaturesDB[name].physical, L" - "))) + tonumber(wstring.sub(CreaturesDB[name].poison, 1, wstring.find(CreaturesDB[name].physical, L" - ")))+ tonumber(wstring.sub(CreaturesDB[name].energy, 1, wstring.find(CreaturesDB[name].physical, L" - ")))
			local current = tonumber(EnhancePack.AnimalLore["PhysResOrg"]) + tonumber(EnhancePack.AnimalLore["FireResOrg"]) + tonumber(EnhancePack.AnimalLore["ColdResOrg"]) + tonumber(EnhancePack.AnimalLore["PoisResOrg"]) + tonumber(EnhancePack.AnimalLore["EnergyResOrg"])
			EnhancePack.AnimalLore["PhysRes"] = EnhancePack.AnimalLore["PhysResOrg"] .. L" (" .. wstring.sub(CreaturesDB[name].physical, wstring.find(CreaturesDB[name].physical, L" - ")+3) .. L")"
			EnhancePack.AnimalLoreMins["PhysRes"] = {}
			EnhancePack.AnimalLoreMins["PhysRes"].min = tonumber(wstring.sub(CreaturesDB[name].physical, 1, wstring.find(CreaturesDB[name].physical, L" - "))) 
			EnhancePack.AnimalLoreMins["PhysRes"].max = tonumber(wstring.sub(CreaturesDB[name].physical, wstring.find(CreaturesDB[name].physical, L" - ")+3))
			
			EnhancePack.AnimalLore["FireRes"] = EnhancePack.AnimalLore["FireResOrg"] .. L" (" .. wstring.sub(CreaturesDB[name].fire, wstring.find(CreaturesDB[name].fire, L" - ")+3) .. L")"
			EnhancePack.AnimalLoreMins["FireRes"] = {}
			EnhancePack.AnimalLoreMins["FireRes"].min = tonumber(wstring.sub(CreaturesDB[name].fire, 1, wstring.find(CreaturesDB[name].fire, L" - "))) 
			EnhancePack.AnimalLoreMins["FireRes"].max = tonumber(wstring.sub(CreaturesDB[name].fire, wstring.find(CreaturesDB[name].fire, L" - ")+3))
			
			EnhancePack.AnimalLore["ColdRes"] = EnhancePack.AnimalLore["ColdResOrg"] .. L" (" .. wstring.sub(CreaturesDB[name].cold, wstring.find(CreaturesDB[name].cold, L" - ")+3) .. L")"
			EnhancePack.AnimalLoreMins["ColdRes"] = {}
			EnhancePack.AnimalLoreMins["ColdRes"].min = tonumber(wstring.sub(CreaturesDB[name].cold, 1, wstring.find(CreaturesDB[name].cold, L" - "))) 
			EnhancePack.AnimalLoreMins["ColdRes"].max = tonumber(wstring.sub(CreaturesDB[name].cold, wstring.find(CreaturesDB[name].cold, L" - ")+3))
			
			EnhancePack.AnimalLore["PoisRes"] = EnhancePack.AnimalLore["PoisResOrg"] .. L" (" .. wstring.sub(CreaturesDB[name].poison, wstring.find(CreaturesDB[name].poison, L" - ")+3) .. L")"
			EnhancePack.AnimalLoreMins["PoisRes"] = {}
			EnhancePack.AnimalLoreMins["PoisRes"].min = tonumber(wstring.sub(CreaturesDB[name].poison, 1, wstring.find(CreaturesDB[name].poison, L" - "))) 
			EnhancePack.AnimalLoreMins["PoisRes"].max = tonumber(wstring.sub(CreaturesDB[name].poison, wstring.find(CreaturesDB[name].poison, L" - ")+3))
			
			EnhancePack.AnimalLore["EnergyRes"] = EnhancePack.AnimalLore["EnergyResOrg"] .. L" (" .. wstring.sub(CreaturesDB[name].energy, wstring.find(CreaturesDB[name].energy, L" - ")+3) .. L")"
			EnhancePack.AnimalLoreMins["EnergyRes"] = {}
			EnhancePack.AnimalLoreMins["EnergyRes"].min = tonumber(wstring.sub(CreaturesDB[name].energy, 1, wstring.find(CreaturesDB[name].energy, L" - "))) 
			EnhancePack.AnimalLoreMins["EnergyRes"].max = tonumber(wstring.sub(CreaturesDB[name].energy, wstring.find(CreaturesDB[name].energy, L" - ")+3))
			
			
			
			local rate = 0
			if (((tonumber(EnhancePack.AnimalLore["HitsOrg"]) - EnhancePack.AnimalLoreMins["Hits"].min) <= 0) or (EnhancePack.AnimalLoreMins["Hits"].max - EnhancePack.AnimalLoreMins["Hits"].min <= 0)) then
				if tonumber(EnhancePack.AnimalLore["HitsOrg"]) == EnhancePack.AnimalLoreMins["Hits"].max and EnhancePack.AnimalLoreMins["Hits"].min == EnhancePack.AnimalLoreMins["Hits"].max then
					rate = 25	
				end
			else
				rate = math.floor(((tonumber(EnhancePack.AnimalLore["HitsOrg"]) - EnhancePack.AnimalLoreMins["Hits"].min) / ((EnhancePack.AnimalLoreMins["Hits"].max - EnhancePack.AnimalLoreMins["Hits"].min) / 2.5)) * 10)
			end
			if (rate > 25) then
				rate = 25
			end
			AnimalLore.Ratings["Hits"] = rate
			
			
			rate = 0
			local curStat = ((EnhancePack.AnimalLore["StrengthOrg"] - EnhancePack.AnimalLoreMins["Strength"].min) + (EnhancePack.AnimalLore["DexterityOrg"] - EnhancePack.AnimalLoreMins["Dexterity"].min) + (EnhancePack.AnimalLore["IntelligenceOrg"] - EnhancePack.AnimalLoreMins["Intelligence"].min))
			if curStat <= 0 then 
				curStat = 0
			end
			
			local maxstat = ((EnhancePack.AnimalLoreMins["Strength"].max - EnhancePack.AnimalLoreMins["Strength"].min) + (EnhancePack.AnimalLoreMins["Dexterity"].max - EnhancePack.AnimalLoreMins["Dexterity"].min) + (EnhancePack.AnimalLoreMins["Intelligence"].max - EnhancePack.AnimalLoreMins["Intelligence"].min))

			if curStat <= 0 then
				rate = 0
			elseif (maxstat <= 0) then
				rate = 5
			else
				rate = math.floor((curStat / (maxstat / 0.5)) * 10)
			end
			if (rate > 5) then
				rate = 5
			end

			AnimalLore.Ratings["Stats"] = rate
			
			if (DoesWindowNameExist("AnimalLoreHitsAttributeName")) then
				LabelSetText("AnimalLoreStatSectionCaption", WindowUtils.GetStringFromTid(1114262) ..L" (" .. AnimalLore.Ratings["Stats"] .. L"% / 5%)\n".. WindowUtils.GetStringFromTid(1061149) ..L" (" .. AnimalLore.Ratings["Hits"] .. L"% / 25%)")

				
			end
			
			local rate13_1 = 0
			local rate13_2 = 0
			local rate13_3 = 0
			local rate13_4 = 0
			local rate13_5 = 0
			if EnhancePack.AnimalLoreMins["PhysRes"].min == EnhancePack.AnimalLoreMins["PhysRes"].max and tonumber(EnhancePack.AnimalLore["PhysResOrg"]) == EnhancePack.AnimalLoreMins["PhysRes"].max then
				rate13_1 = 13
			elseif EnhancePack.AnimalLoreMins["PhysRes"].max > 0 then
				rate13_1 = ((tonumber(EnhancePack.AnimalLore["PhysResOrg"]) - EnhancePack.AnimalLoreMins["PhysRes"].min) / ((EnhancePack.AnimalLoreMins["PhysRes"].max - EnhancePack.AnimalLoreMins["PhysRes"].min) / 1.3)) * 10
			end

			if EnhancePack.AnimalLoreMins["FireRes"].min == EnhancePack.AnimalLoreMins["FireRes"].max and tonumber(EnhancePack.AnimalLore["FireResOrg"]) == EnhancePack.AnimalLoreMins["FireRes"].max then
				rate13_2 = 13
			elseif EnhancePack.AnimalLoreMins["FireRes"].max > 0 then
				rate13_2 = ((tonumber(EnhancePack.AnimalLore["FireResOrg"]) - EnhancePack.AnimalLoreMins["FireRes"].min) / ((EnhancePack.AnimalLoreMins["FireRes"].max - EnhancePack.AnimalLoreMins["FireRes"].min) / 1.3)) * 10
			end

			if EnhancePack.AnimalLoreMins["ColdRes"].min == EnhancePack.AnimalLoreMins["ColdRes"].max and tonumber(EnhancePack.AnimalLore["ColdResOrg"]) == EnhancePack.AnimalLoreMins["ColdRes"].max then
				rate13_3 = 13
			elseif EnhancePack.AnimalLoreMins["ColdRes"].max > 0 then
				rate13_3 = ((tonumber(EnhancePack.AnimalLore["ColdResOrg"]) - EnhancePack.AnimalLoreMins["ColdRes"].min) / ((EnhancePack.AnimalLoreMins["ColdRes"].max - EnhancePack.AnimalLoreMins["ColdRes"].min) / 1.3)) * 10
			
			end

			if EnhancePack.AnimalLoreMins["PoisRes"].min == EnhancePack.AnimalLoreMins["PoisRes"].max and tonumber(EnhancePack.AnimalLore["PoisResOrg"]) == EnhancePack.AnimalLoreMins["PoisRes"].max then
				rate13_4 = 13
			elseif EnhancePack.AnimalLoreMins["PoisRes"].max > 0 then
				rate13_4 = ((tonumber(EnhancePack.AnimalLore["PoisResOrg"]) - EnhancePack.AnimalLoreMins["PoisRes"].min) / ((EnhancePack.AnimalLoreMins["PoisRes"].max - EnhancePack.AnimalLoreMins["PoisRes"].min) / 1.3)) * 10
			
			
			end

			if EnhancePack.AnimalLoreMins["EnergyRes"].min == EnhancePack.AnimalLoreMins["EnergyRes"].max and tonumber(EnhancePack.AnimalLore["EnergyResOrg"]) == EnhancePack.AnimalLoreMins["EnergyRes"].max then
				rate13_5 = 13
			elseif EnhancePack.AnimalLoreMins["EnergyRes"].max > 0 then
				rate13_5 = ((tonumber(EnhancePack.AnimalLore["EnergyResOrg"]) - EnhancePack.AnimalLoreMins["EnergyRes"].min) / ((EnhancePack.AnimalLoreMins["EnergyRes"].max - EnhancePack.AnimalLoreMins["EnergyRes"].min) / 1.3)) * 10

			end
        
			rate = math.floor(rate13_1 + rate13_2 + rate13_3 + rate13_4 + rate13_5)

			if (rate > 65) then
				rate = 65
			end
			
			AnimalLore.Ratings["Res"] = rate
			
			if (DoesWindowNameExist("AnimalLoreResistsTableCaption")) then
				LabelSetText("AnimalLoreResistsTableCaption", WindowUtils.GetStringFromTid(1061645) ..L" (" .. AnimalLore.Ratings["Res"] .. L"% / 65%)")
			end

			rate13_1 = 0
			rate13_2 = 0
			rate13_3 = 0
			rate13_4 = 0
			rate13_5 = 0
			rate13_6 = 0
			rate13_7 = 0
			rate13_8 = 0
			
			if (EnhancePack.AnimalLoreMins["Wrestling"].max == EnhancePack.AnimalLoreMins["Wrestling"].min) then
				rate13_1 = 0.625
				
			elseif(EnhancePack.AnimalLoreMins["Wrestling"] and EnhancePack.AnimalLoreMins["Wrestling"].max > 0) then
				rate13_1 = (tonumber(EnhancePack.AnimalLore["WrestlingOrg"])  / (EnhancePack.AnimalLoreMins["Wrestling"].max  / 0.0625)) * 10
			
			end
			
			
			if (EnhancePack.AnimalLoreMins["Tactics"].max == EnhancePack.AnimalLoreMins["Tactics"].min) then
				rate13_2 = 0.625
			elseif(EnhancePack.AnimalLoreMins["Tactics"] and EnhancePack.AnimalLoreMins["Tactics"].max > 0) then
				rate13_2 = (tonumber(EnhancePack.AnimalLore["TacticsOrg"]) / (EnhancePack.AnimalLoreMins["Tactics"].max  / 0.0625)) * 10
			
			end
			
			if (EnhancePack.AnimalLoreMins["ResSpell"].max == EnhancePack.AnimalLoreMins["ResSpell"].min) then
				rate13_3 = 0.625
			elseif(EnhancePack.AnimalLoreMins["ResSpell"] and EnhancePack.AnimalLoreMins["ResSpell"].max > 0) then
				rate13_3 = (tonumber(EnhancePack.AnimalLore["ResSpellOrg"])  / (EnhancePack.AnimalLoreMins["ResSpell"].max / 0.0625)) * 10
			
				
			end
			
			if (EnhancePack.AnimalLoreMins["Anatomy"].max == EnhancePack.AnimalLoreMins["Anatomy"].min) then
				rate13_4 = 0.625
			elseif(EnhancePack.AnimalLoreMins["Anatomy"] and EnhancePack.AnimalLoreMins["Anatomy"].max > 0) then
				rate13_4 = (tonumber(EnhancePack.AnimalLore["AnatomyOrg"])  / (EnhancePack.AnimalLoreMins["Anatomy"].max  / 0.0625)) * 10
			
				
			end
			
			if (EnhancePack.AnimalLoreMins["PoisHeal"].max == EnhancePack.AnimalLoreMins["PoisHeal"].min) then
				rate13_5 = 0.625
			elseif(EnhancePack.AnimalLoreMins["PoisHeal"] and EnhancePack.AnimalLoreMins["PoisHeal"].max > 0) then
				rate13_5 = (tonumber(EnhancePack.AnimalLore["PoisHealOrg"]) / (EnhancePack.AnimalLoreMins["PoisHeal"].max  / 0.0625)) * 10
			
				
			end
			
			if (EnhancePack.AnimalLoreMins["Magery"].max == EnhancePack.AnimalLoreMins["Magery"].min) then
				rate13_6 = 0.625
			elseif(EnhancePack.AnimalLoreMins["Magery"] and EnhancePack.AnimalLoreMins["Magery"].max > 0) then
				rate13_6 = (tonumber(EnhancePack.AnimalLore["MageryOrg"]) / (EnhancePack.AnimalLoreMins["Magery"].max  / 0.0625)) * 10
			
				
			end
			
			if (EnhancePack.AnimalLoreMins["EvalInt"].max == EnhancePack.AnimalLoreMins["EvalInt"].min) then
				rate13_7 = 0.625
			elseif(EnhancePack.AnimalLoreMins["EvalInt"] and EnhancePack.AnimalLoreMins["EvalInt"].max > 0) then
				rate13_7 = (tonumber(EnhancePack.AnimalLore["EvalIntOrg"]) / (EnhancePack.AnimalLoreMins["EvalInt"].max / 0.0625)) * 10
			
				
			end
			
			if (EnhancePack.AnimalLoreMins["Meditation"].max == EnhancePack.AnimalLoreMins["Meditation"].min) then
				rate13_8 = 0.625
			elseif(EnhancePack.AnimalLoreMins["Meditation"] and EnhancePack.AnimalLoreMins["Meditation"].max > 0) then
				rate13_8 = (tonumber(EnhancePack.AnimalLore["MeditationOrg"]) / (EnhancePack.AnimalLoreMins["Meditation"].max / 0.0625)) * 10
			
			end
			
			rate = math.floor(rate13_1 + rate13_2 + rate13_3 + rate13_4 + rate13_5 + rate13_6 +rate13_7 + rate13_8)
			
			if (rate > 5) then
				rate = 5
			end
			
			AnimalLore.Ratings["Skills"] = rate
			
			if (DoesWindowNameExist("AnimalLoreSkillsSectionCaption")) then
				LabelSetText("AnimalLoreSkillsSectionCaption", WindowUtils.GetStringFromTid(3000084) ..L" (" .. AnimalLore.Ratings["Skills"] .. L"% / 5%)")
			end

			EnhancePack.AnimalLore["CurrMax"] = current .. L" / " .. max
			EnhancePack.AnimalLore["Diff"] = current - max
			--Debug.Print(current - max)
			rate =  5 * ((AnimalLore.Ratings["Hits"] + AnimalLore.Ratings["Stats"] + AnimalLore.Ratings["Res"] + AnimalLore.Ratings["Skills"]) / 100)
			rate = math.floor(rate * 10)
			rate = tonumber(string.sub(rate, 1, -2) .. "." ..  string.sub(rate, -1))
			EnhancePack.AnimalLore["Rating"] =  rate .. L" (" .. math.floor((AnimalLore.Ratings["Hits"] + AnimalLore.Ratings["Stats"] + AnimalLore.Ratings["Res"] + AnimalLore.Ratings["Skills"])) .. L"%)"
			
			if( EnhancePack.Clock.h < 10) then
				clockhstr = "0"..tostring(EnhancePack.Clock.h)
			else
				clockhstr = tostring(EnhancePack.Clock.h)
			end
			if( EnhancePack.Clock.m < 10) then
				clockmstr = "0"..tostring(EnhancePack.Clock.m)
			else
				clockmstr = tostring(EnhancePack.Clock.m)
			end
			if( EnhancePack.Clock.s < 10) then
				clocksstr = "0"..tostring(EnhancePack.Clock.s)
			else
				clocksstr = tostring(EnhancePack.Clock.s)
			end
			local clockstring = clockhstr.."."..clockmstr.."."..clocksstr
		
			if AnimalLore.AnimalLog then
				TextLogCreate( "AnimalLore", 1 )
				local path = "logs/" .."[" .. clockstring .. "] " ..  name .. ".txt"
				TextLogSetIncrementalSaving( "AnimalLore", true, path )
				TextLogSetEnabled( "AnimalLore", true )
				local data =  L"\r\n---------------------\r\n"
				data =  data .. StringToWString(string.upper(name)) .. L"\r\n"
				data = data .. L"---------STATS-------\r\n"
				data = data .. L"hits: " .. EnhancePack.AnimalLore["Hits"] .. L"\r\n"
				data = data .. L"stamina: " .. EnhancePack.AnimalLore["Stamina"] .. L"\r\n"
				data = data .. L"mana: " .. EnhancePack.AnimalLore["Mana"] .. L"\r\n"
				data = data .. L"strength: " .. EnhancePack.AnimalLore["Strength"] .. L"\r\n"
				data = data .. L"dexterity: " .. EnhancePack.AnimalLore["Dexterity"] .. L"\r\n"
				data = data .. L"intelligence: " .. EnhancePack.AnimalLore["Intelligence"] .. L"\r\n"
				data = data .. L"barding difficulty: " .. EnhancePack.AnimalLore["Bdiff"] .. L"\r\n"
				data = data .. L"-----RESISTANCES-----\r\n"
				data = data .. L"physical: " .. EnhancePack.AnimalLore["PhysRes"] .. L"\r\n"
				data = data .. L"fire: " .. EnhancePack.AnimalLore["FireRes"] .. L"\r\n"
				data = data .. L"cold: " .. EnhancePack.AnimalLore["ColdRes"] .. L"\r\n"
				data = data .. L"poison: " .. EnhancePack.AnimalLore["PoisRes"] .. L"\r\n"
				data = data .. L"energy: " .. EnhancePack.AnimalLore["EnergyRes"] .. L"\r\n"
				data = data .. L"-------SKILLS--------\r\n"
				data = data .. L"wrestling: " .. EnhancePack.AnimalLore["Wrestling"] .. L"\r\n"
				data = data .. L"tactics: " .. EnhancePack.AnimalLore["Tactics"] .. L"\r\n"
				data = data .. L"resisting spells: " .. EnhancePack.AnimalLore["ResSpell"] .. L"\r\n"
				data = data .. L"anatomy: " .. EnhancePack.AnimalLore["Anatomy"] .. L"\r\n"
				data = data .. L"poisoning/healing: " .. EnhancePack.AnimalLore["PoisHeal"] .. L"\r\n"
				data = data .. L"magery: " .. EnhancePack.AnimalLore["Magery"] .. L"\r\n"
				data = data .. L"evaluating intelligence: " .. EnhancePack.AnimalLore["EvalInt"] .. L"\r\n"
				data = data .. L"meditation: " .. EnhancePack.AnimalLore["Meditation"] .. L"\r\n"
				data = data .. L"-------RATINGS-------\r\n"
				data = data .. L"resistances: " .. math.floor(AnimalLore.Ratings["Res"]) .. L"% / 65%\r\n"
				data = data .. L"hits: " .. math.floor(AnimalLore.Ratings["Hits"]) .. L"% / 25%\r\n"
				data = data .. L"stats: " .. math.floor(AnimalLore.Ratings["Stats"]) .. L"% / 5%\r\n"
				data = data .. L"skills: " .. math.floor(AnimalLore.Ratings["Skills"]) .. L"% / 5%\r\n"
				TextLogAddEntry( "AnimalLore", 1,  data )
				TextLogSetEnabled("AnimalLore", false)
				TextLogDestroy("AnimalLore")
			end
		else
			local current = tonumber(EnhancePack.AnimalLore["PhysResOrg"]) + tonumber(EnhancePack.AnimalLore["FireResOrg"]) + tonumber(EnhancePack.AnimalLore["ColdResOrg"]) + tonumber(EnhancePack.AnimalLore["PoisResOrg"]) + tonumber(EnhancePack.AnimalLore["EnergyResOrg"])
			EnhancePack.AnimalLore["CurrMax"] = current
			EnhancePack.AnimalLore["Rating"] = L"Unknow"
			
			local hits = tonumber(EnhancePack.AnimalLore["HitsCur"])
			if hits then
				EnhancePack.AnimalLore["Hits"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["HitsCur"]) .. L"/" ..WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["HitsOrg"])
			else
				EnhancePack.AnimalLore["Hits"] = EnhancePack.AnimalLore["HitsOrg"]
			end
			
			local stamina = tonumber(EnhancePack.AnimalLore["StaminaCur"])
			if stamina then
				EnhancePack.AnimalLore["Stamina"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["StaminaCur"]) .. L"/" ..WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["StaminaOrg"])
			else
				EnhancePack.AnimalLore["Stamina"] = EnhancePack.AnimalLore["StaminaOrg"]
			end
			
			local mana = tonumber(EnhancePack.AnimalLore["ManaCur"])
			if mana  then
				EnhancePack.AnimalLore["Mana"] = WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["ManaCur"]) .. L"/" ..WindowUtils.AddCommasToNumber(EnhancePack.AnimalLore["ManaOrg"])
			else
				EnhancePack.AnimalLore["Mana"] = EnhancePack.AnimalLore["ManaOrg"]
			end
		end
	--else
	--	local current = tonumber(EnhancePack.AnimalLore["PhysResOrg"]) + tonumber(EnhancePack.AnimalLore["FireResOrg"]) + tonumber(EnhancePack.AnimalLore["ColdResOrg"]) + tonumber(EnhancePack.AnimalLore["PoisResOrg"]) + tonumber(EnhancePack.AnimalLore["EnergyResOrg"])
	--	EnhancePack.AnimalLore["CurrMax"] = current
	--	EnhancePack.AnimalLore["Rating"] = L"Unknow"
	--end
end

AnimalLore.SetSelection = false
AnimalLore.Tamable = false

function AnimalLore.SelChanged()
	AnimalLore.SetSelection = true
	AnimalLore.LoadMainPage()
end

function AnimalLore.LoadMainPage()
	local windowName = "AnimalLore" 
	
	
	
	
	
	if (not DoesWindowNameExist(windowName)) then
		CreateWindowFromTemplate(windowName, windowName, "Root")
		
		WindowSetDimensions(windowName, 650, 840)
	else
		WindowUtils.SaveWindowPosition("AnimalLore")
	end
	WindowUtils.RestoreWindowPosition("AnimalLore")
	
	LabelSetText(windowName.."PetKindComboLabel", L"Pet Kind")
	
	
	if (not AnimalLore.SetSelection) then
		ComboBoxClearMenuItems( windowName.."PetKindComboComboBox" )
		for i = 1, table.getn(CreaturesDB.AnimalLoreTamables) do
			if (CreaturesDB.AnimalLoreTamables[i] ) then
				ComboBoxAddMenuItem( windowName.."PetKindComboComboBox", WindowUtils.Decapitalizing(CreaturesDB.AnimalLoreTamables[i]) )
			end
		end

	end
	
	AnimalLore.NameCheck()

	ButtonSetTexture("AnimalLoreMenu", InterfaceCore.ButtonStates.STATE_NORMAL, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL.x, UI.DownArrow.STATE_NORMAL.y)
	ButtonSetTexture("AnimalLoreMenu",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL_HIGHLITE.x, UI.DownArrow.STATE_NORMAL_HIGHLITE.y)
	ButtonSetTexture("AnimalLoreMenu", InterfaceCore.ButtonStates.STATE_PRESSED, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED.x, UI.DownArrow.STATE_PRESSED.y) -- 248
	ButtonSetTexture("AnimalLoreMenu", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED_HIGHLITE.x, UI.DownArrow.STATE_PRESSED_HIGHLITE.y) -- 248
	
	
	local label = windowName.."Chrome_UO_TitleBar_WindowTitle"
	LabelSetText(label, L"")
	LabelSetText(label, EnhancePack.AnimalLore["Name"])
	
	WindowSetScale(windowName, 0.8)
	EnhancePack.LoadScale( windowName )
		
	
	
	local sc = WindowGetScale(windowName)
	
	
--	***** DISPLAY STATS *****
	strAttribute = windowName.. "StatSectionCaption"
	if (not DoesWindowNameExist(strAttribute)) then
		CreateWindowFromTemplate(strAttribute, "TableCaptionTemplate", windowName)
		WindowAddAnchor(strAttribute, "topleft", windowName, "topleft", 60, 70)
	end
	
	local sc = WindowGetScale(windowName)
	WindowSetScale(strAttribute, sc)
	
	LabelSetText(strAttribute, WindowUtils.GetStringFromTid(1114262))
	
	strAttribute = windowName.."Strength"
	AnimalLore.AddAttributeToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1061146), EnhancePack.AnimalLore["Strength"], 0, 751, 40, 110)
	
	strAttribute = windowName.."Hits"
	AnimalLore.AddAttributeToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1061149), EnhancePack.AnimalLore["Hits"], 0, 742, 320, 110)
	
	strAttribute = windowName.."Dexterity"
	AnimalLore.AddAttributeToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1061147), EnhancePack.AnimalLore["Dexterity"], 0, 738, 40, 145)
	
	strAttribute = windowName.."Stamina"
	AnimalLore.AddAttributeToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1061150), EnhancePack.AnimalLore["Stamina"], 0, 750, 320, 145)
	
	strAttribute = windowName.."Intelligence"
	AnimalLore.AddAttributeToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1061148), EnhancePack.AnimalLore["Intelligence"], 0, 744, 40, 180)
	
	strAttribute = windowName.."Mana"
	AnimalLore.AddAttributeToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1061151), EnhancePack.AnimalLore["Mana"], 0, 746, 320, 180)
		
-- ***** DISPLAY RESISTANCES *****

	if (AnimalLore.Tamable) then
		local resistWindow = windowName.. "Resists"
		if (DoesWindowNameExist(resistWindow)) then
			DestroyWindow(resistWindow)
		end
		
		CreateWindowFromTemplate(resistWindow, "ResistGridTemplate", windowName)
		WindowAddAnchor(resistWindow, "topleft", windowName, "topleft", 60, 225)
		
		
		WindowSetScale(resistWindow, sc)
		
		LabelSetText(resistWindow.."TableCaption", WindowUtils.GetStringFromTid(1061645))

		strAttribute = resistWindow.."PhysRes"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061646), EnhancePack.AnimalLore["PhysRes"], 0)
		
		strAttribute = resistWindow.."FireRes"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061647), EnhancePack.AnimalLore["FireRes"], 0)
		
		strAttribute = resistWindow.."ColdRes"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061648), EnhancePack.AnimalLore["ColdRes"], 0)
		
		strAttribute = resistWindow.."PoisRes"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061649), EnhancePack.AnimalLore["PoisRes"], 0)
		
		strAttribute = resistWindow.."EnergyRes"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061650), EnhancePack.AnimalLore["EnergyRes"], 0)

		LabelSetText(resistWindow .. "TotalValue", L"" .. EnhancePack.AnimalLore["CurrMax"])
		if (EnhancePack.AnimalLore["Diff"]) then
			LabelSetText(resistWindow .. "TotalHeader", GetStringFromTid(3000087) .. L" (" .. EnhancePack.AnimalLore["Diff"] .. L")")
			if (tonumber(EnhancePack.AnimalLore["Diff"]) >= -5) then
				LabelSetTextColor(resistWindow.."TotalValue", 0, 255, 0)
			elseif (tonumber(EnhancePack.AnimalLore["Diff"]) >= -10) then
				LabelSetTextColor(resistWindow.."TotalValue", 255, 201, 14)
			elseif (tonumber(EnhancePack.AnimalLore["Diff"]) <= -15) then
				LabelSetTextColor(resistWindow.."TotalValue", 255, 0, 0)
			else
				LabelSetTextColor(resistWindow.."TotalValue", 255, 255, 255)
			end
	--		Debug.Print(L" (" .. EnhancePack.AnimalLore["Diff"] .. L")")
		else
			LabelSetText(resistWindow .. "TotalHeader", L"Total")
		end
	else
		local resistWindow = windowName.. "Resists"
		if (DoesWindowNameExist(resistWindow)) then
			DestroyWindow(resistWindow)
		end
		
		CreateWindowFromTemplate(resistWindow, "DamageGridTemplate", windowName)
		WindowAddAnchor(resistWindow, "topleft", windowName, "topleft", 100, 225)

		WindowSetScale(resistWindow, sc)
		
		LabelSetText(resistWindow.."TableCaption", WindowUtils.GetStringFromTid(1061645))

		strAttribute = resistWindow.."Phys"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061646), EnhancePack.AnimalLore["PhysRes"], 0)
		
		strAttribute = resistWindow.."Fire"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061647), EnhancePack.AnimalLore["FireRes"], 0)
		
		strAttribute = resistWindow.."Cold"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061648), EnhancePack.AnimalLore["ColdRes"], 0)
		
		strAttribute = resistWindow.."Poison"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061649), EnhancePack.AnimalLore["PoisRes"], 0)
		
		strAttribute = resistWindow.."Energy"
		AnimalLore.FormatResistData(strAttribute, WindowUtils.GetStringFromTid(1061650), EnhancePack.AnimalLore["EnergyRes"], 0)
	end
-- ***** DAMAGE TYPE *****
	local dmgTypeWindow = windowName.. "DmgType"
	if (not DoesWindowNameExist(dmgTypeWindow)) then
		CreateWindowFromTemplate(dmgTypeWindow, "DamageGridTemplate", windowName)
		WindowAddAnchor(dmgTypeWindow, "topleft", windowName, "topleft", 100, 325)
	end
	
	

	local sc = WindowGetScale(windowName)
	WindowSetScale(dmgTypeWindow, sc)
	
	LabelSetText(dmgTypeWindow.."TableCaption", WindowUtils.GetStringFromTid(1017319))

	strAttribute = dmgTypeWindow.."Phys"
	LabelSetText(strAttribute.."Header", WindowUtils.GetStringFromTid(1061646))
	LabelSetText(strAttribute.."Value", EnhancePack.AnimalLore["PhysDam"])
	
	strAttribute = dmgTypeWindow.."Fire"
	LabelSetText(strAttribute.."Header", WindowUtils.GetStringFromTid(1061647))
	LabelSetText(strAttribute.."Value", EnhancePack.AnimalLore["FireDam"])
	
	strAttribute = dmgTypeWindow.."Cold"
	LabelSetText(strAttribute.."Header", WindowUtils.GetStringFromTid(1061648))
	LabelSetText(strAttribute.."Value", EnhancePack.AnimalLore["ColdDam"])
	
	strAttribute = dmgTypeWindow.."Poison"
	LabelSetText(strAttribute.."Header", WindowUtils.GetStringFromTid(1061649))
	LabelSetText(strAttribute.."Value", EnhancePack.AnimalLore["PoisDam"])
	
	strAttribute = dmgTypeWindow.."Energy"
	LabelSetText(strAttribute.."Header", WindowUtils.GetStringFromTid(1061650))
	LabelSetText(strAttribute.."Value", EnhancePack.AnimalLore["EnerDam"])

		
-- ***** DISPLAY SKILLS *****
	strAttribute = windowName.. "SkillsSectionCaption"
	if (not DoesWindowNameExist(strAttribute)) then
		CreateWindowFromTemplate(strAttribute, "TableCaptionTemplate", windowName)
		WindowAddAnchor(strAttribute, "topleft", windowName, "topleft", 80, 410)
	end
	
	
	
	
	local sc = WindowGetScale(windowName)
	WindowSetScale(strAttribute, sc)
	
	LabelSetText(strAttribute, WindowUtils.GetStringFromTid(3000084))
	
	strAttribute = windowName.."SkillsDivider"
	if (not DoesWindowNameExist(strAttribute)) then
		CreateWindowFromTemplate(strAttribute, "HRDef", windowName)
		WindowAddAnchor(strAttribute, "topleft", windowName, "topleft", 34, 430)
		WindowSetScale(strAttribute, sc)
	end
	
	strAttribute = windowName.."Wrestling"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1042390), EnhancePack.AnimalLore["Wrestling"], 40, 450)
	
	strAttribute = windowName.."Magery"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1042372), EnhancePack.AnimalLore["Magery"], 325, 450)
	
	strAttribute = windowName.."Tactics"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1042374), EnhancePack.AnimalLore["Tactics"], 40, 475)
	
	strAttribute = windowName.."EvalInt"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1042363), EnhancePack.AnimalLore["EvalInt"], 325, 475)
	
	strAttribute = windowName.."Anatomy"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1042348), EnhancePack.AnimalLore["Anatomy"], 40, 500)
	
	strAttribute = windowName.."Meditation"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1042393), EnhancePack.AnimalLore["Meditation"], 325, 500)
	
	strAttribute = windowName.."ResSpell"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1049471), EnhancePack.AnimalLore["ResSpell"], 40, 525)
	
	strAttribute = windowName.."PoisHeal"
	if (EnhancePack.AnimalLore["HasHealing"]) then
		AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1042364), EnhancePack.AnimalLore["PoisHeal"], 325, 525)
	else
		AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1042377), EnhancePack.AnimalLore["PoisHeal"], 325, 525)
	end

	
	strAttribute = windowName.."LoyaltyDivider"
	if (not DoesWindowNameExist(strAttribute)) then
		CreateWindowFromTemplate(strAttribute, "HRDef", windowName)
		WindowAddAnchor(strAttribute, "topleft", windowName, "topleft", 34, 555)
		WindowSetScale(strAttribute, sc)
	end
	
	strAttribute = windowName.."Loyalty"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1049594), EnhancePack.AnimalLore["Loyalty"], 190, 580)

	strAttribute = windowName.."BaseDmg"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1076750), EnhancePack.AnimalLore["BaseDamage"], 190, 610)

	local strAttribute = windowName.."BardDiff" 
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1070793), EnhancePack.AnimalLore["Bdiff"], 190, 640)

	strAttribute = windowName.."PrefFoods"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1049563), EnhancePack.AnimalLore["Food"], 190, 670)
	
	strAttribute = windowName.."PackInstinct"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, WindowUtils.GetStringFromTid(1049569), EnhancePack.AnimalLore["Packs"], 190, 700)
	
	strAttribute = windowName.."PetRating"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, UI.GetCliloc(SystemData.Settings.Language.type, 635), EnhancePack.AnimalLore["Rating"], 190, 730)
	WindowSetShowing(strAttribute, AnimalLore.Tamable)
	
	strAttribute = windowName.."PetTaming"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, UI.GetCliloc(SystemData.Settings.Language.type, 636), L"" .. AnimalLore.MinTaming, 190, 760)
	WindowSetShowing(strAttribute, AnimalLore.Tamable)
	
	local serverId = WindowData.SkillsCSV[3].ServerId
	local anil =  WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	
	serverId = WindowData.SkillsCSV[4].ServerId
	local tam = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	
	if ( WindowData.PlayerStatus["Race"] == 1 ) then
		if (anil < 20) then
			anil = 20
		end
		if (tam < 20) then
			tam = 20
		end
	end
	
	local tam1, lore1, skillbonus, mod1, mod2
    tam1 = tam - AnimalLore.MinTaming
    lore1 = anil - AnimalLore.MinTaming
    if tam1 >= 0 then 
		mod1 = 6
	end
    if tam1 < 0 then 
		mod1 = 28
	end
    if lore1 >= 0 then 
		mod2 = 6
	end
    if lore1 < 0 then 
		mod2 = 14
	end

    tam1 = mod1 * tam1
    lore1 = mod2 * lore1
    skillbonus = (tam1 + lore1) / 2

    local chanceControl = 70 + skillbonus

    if chanceControl < 0 then 
		chanceControl = 0
	end
    if chanceControl > 99 then 
		chanceControl = 99
	end
        
    strAttribute = windowName.."ControlChance"
	AnimalLore.AddLabelGroupToForm(windowName, strAttribute, UI.GetCliloc(SystemData.Settings.Language.type, 637), L"" .. chanceControl .. L"%", 190, 790)
	WindowSetShowing(strAttribute, AnimalLore.Tamable)
		AnimalLore.NameCheck()
		
	WindowSetShowing(windowName, true)
	WindowUtils.RestoreWindowPosition("AnimalLore")
	AnimalLore.SetSelection = false
end


function AnimalLore.SetMiniIconStats(iconWindow, iconId)
	local texture, x, y = GetIconData( iconId )
	
	--Start position of the texture, need to be offset by x and y to get the stat icon image
	x = 4  
	y = 3
	WindowSetDimensions(iconWindow.."SquareIcon", 27, 27)
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 1 )
end


-- This Method replaces the "---" strings with empty strings :: Used to format damage type values
function AnimalLore.DropBlanks(wstrStat)
	if wstrStat == L"---" then 	
		return L"" 
	else
		return wstrStat	
	end
end



function AnimalLore.AddAttributeToForm(windowName, strAttribute, wstrLabel, wstrValue, intThreshold, intIconID, intAnchorX, intAnchorY)
	if (not DoesWindowNameExist(strAttribute)) then
		CreateWindowFromTemplate(strAttribute, "AttributeTemplate", windowName)
		WindowAddAnchor(strAttribute, "topleft", windowName, "topleft", intAnchorX, intAnchorY)
	end
	local attr = string.gsub(strAttribute, windowName, "")
	if (AnimalLore.Tamable and EnhancePack.AnimalLoreMins[attr] and EnhancePack.AnimalLore[attr] and EnhancePack.AnimalLore[attr] ~= L"---") then
		local range = EnhancePack.AnimalLoreMins[attr].max - EnhancePack.AnimalLoreMins[attr].min
		local percCrap = range * (EnhancePack.AnimalLoreCrapPerc / 100)
		local percBad = range * (EnhancePack.AnimalLoreBadPerc / 100)
		local valueCrap = EnhancePack.AnimalLoreMins[attr].min + (range - percCrap)
		local valueBad = EnhancePack.AnimalLoreMins[attr].min + (range - percBad)
		if (tonumber(EnhancePack.AnimalLore[attr]) > 0) then
			if range == 0 or not AnimalLore.Highlight[attr] then
				LabelSetTextColor(strAttribute.."AttributeValue", 255, 255, 255)
			elseif tonumber(EnhancePack.AnimalLore[attr]) <= valueCrap then
				LabelSetTextColor(strAttribute.."AttributeValue", 255, 0, 0)
			elseif tonumber(EnhancePack.AnimalLore[attr]) <= valueBad then
				LabelSetTextColor(strAttribute.."AttributeValue", 255, 201, 14)
			else
				LabelSetTextColor(strAttribute.."AttributeValue", 255, 255, 255)
			end
		else
			LabelSetTextColor(strAttribute.."AttributeValue", 255, 255, 255)
		end
	else
		LabelSetTextColor(strAttribute.."AttributeValue", 255, 255, 255)
	end
	
	local sc = WindowGetScale("AnimalLore")
	WindowSetScale(strAttribute, sc)
	LabelSetText(strAttribute.."AttributeName", wstrLabel)
	LabelSetText(strAttribute.."AttributeValue", wstrValue)
	LabelSetText(strAttribute.."AttributeValue", wstrValue)
	
	AnimalLore.SetMiniIconStats(strAttribute, intIconID)


end

-- Draws a label and a data field to the form.  This method does exactly what add attribute does except it does not include any images
function AnimalLore.AddLabelGroupToForm(windowName, strAttribute, wstrLabel, wstrValue, intAnchorX, intAnchorY)
	if (not DoesWindowNameExist(strAttribute)) then
		CreateWindowFromTemplate(strAttribute, "LabeledDataTemplate", windowName)
		WindowAddAnchor(strAttribute, "topleft", windowName, "topleft", intAnchorX, intAnchorY)
	end
	local attr = string.gsub(strAttribute, windowName, "")
	if ( AnimalLore.Tamable  and EnhancePack.AnimalLoreMins[attr] and EnhancePack.AnimalLore[attr] and EnhancePack.AnimalLore[attr] ~= L"---") then
		if (EnhancePack.AnimalLoreMins[attr]) then
			local range = EnhancePack.AnimalLoreMins[attr].max - EnhancePack.AnimalLoreMins[attr].min
			local percCrap = range * (EnhancePack.AnimalLoreCrapPerc / 100)
			local percBad = range * (EnhancePack.AnimalLoreBadPerc / 100)
			local valueCrap = EnhancePack.AnimalLoreMins[attr].min + (range - percCrap)
			local valueBad = EnhancePack.AnimalLoreMins[attr].min + (range - percBad)
			if range == 0 or not AnimalLore.Highlight[attr] then
				LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
			elseif (tonumber(EnhancePack.AnimalLore[attr]) > 0) then
				if tonumber(EnhancePack.AnimalLore[attr]) <= valueCrap then
					LabelSetTextColor(strAttribute.."Value", 255, 0, 0)
				elseif tonumber(EnhancePack.AnimalLore[attr]) <= valueBad then
					LabelSetTextColor(strAttribute.."Value", 255, 201, 14)
				else
					LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
				end
			else
				LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
			end
		else
			LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
		end
	else
		LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
	end
	local sc = WindowGetScale("AnimalLore")
	WindowSetScale(strAttribute, sc)
	LabelSetText(strAttribute.."Label", wstrLabel)
	LabelSetText(strAttribute.."Value", wstrValue)
end

-- Sets properties on xml elements that handle displaying resistances & handling hilighted states
function AnimalLore.FormatResistData(strAttribute, wstrLabel, wstrValue, intThreshold)
	if (wstrValue == L"---") or (wstrValue == nil) then 	
		LabelSetText(strAttribute.."Header", wstrLabel)
		LabelSetText(strAttribute.."Value", L"---")
	else
		local attr = string.gsub(strAttribute, "AnimalLoreResists", "")
		if (AnimalLore.Tamable and EnhancePack.AnimalLoreMins[attr] and EnhancePack.AnimalLore[attr] and EnhancePack.AnimalLore[attr] ~= L"---") then
			local range = EnhancePack.AnimalLoreMins[attr].max - EnhancePack.AnimalLoreMins[attr].min

			local percCrap = range * (EnhancePack.AnimalLoreCrapPerc / 100)
			local percBad = range * (EnhancePack.AnimalLoreBadPerc / 100)
			local valueCrap = EnhancePack.AnimalLoreMins[attr].min + (range - percCrap)
			local valueBad = EnhancePack.AnimalLoreMins[attr].min + (range - percBad)
			if range == 0 or not AnimalLore.Highlight[attr] then
				LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
			elseif (tonumber(EnhancePack.AnimalLore[attr]) > 0) then
				if tonumber(EnhancePack.AnimalLore[attr]) <= valueCrap then
					LabelSetTextColor(strAttribute.."Value", 255, 0, 0)
				elseif tonumber(EnhancePack.AnimalLore[attr]) <= valueBad then
					LabelSetTextColor(strAttribute.."Value", 255, 201, 14)
				else
					LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
				end
			else
				LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
			end
		else
			LabelSetTextColor(strAttribute.."Value", 255, 255, 255)
		end
		
		local strTemp = WStringToString(wstrValue)
	
		strTemp = string.gsub(strTemp, "%%", "")
		
		wstrValue = StringToWString(strTemp)
		LabelSetText(strAttribute.."Header", wstrLabel)
		LabelSetText(strAttribute.."Value", wstrValue)

	end
end



