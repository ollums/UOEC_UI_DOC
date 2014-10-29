----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Spellbook = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Spellbook.uniqueOrdinals = { L"st", L"nd", L"rd" }
Spellbook.bardMasteries = { GetStringFromTid(1044082), GetStringFromTid(1044069), GetStringFromTid(1044075) }

-- TODO: Obviously, TIDs should be in abilities.csv
Spellbook.baseTid = 1028319

-- Indexed by firstSpellNum, MAX per page is 8
Spellbook.numSpellsPerTab = {}
Spellbook.numSpellsPerTab[1] = 8 -- Magery
Spellbook.numSpellsPerTab[101] = 8 -- Necromancy
Spellbook.numSpellsPerTab[201] = 8 -- Chivalry
Spellbook.numSpellsPerTab[401] = 8 -- Bushido
Spellbook.numSpellsPerTab[501] = 8 -- Ninjitsu
Spellbook.numSpellsPerTab[601] = 8 -- Spellweaving
Spellbook.numSpellsPerTab[678] = 8 -- Mysticism
Spellbook.numSpellsPerTab[701] = 2 -- Bard

Spellbook.MAX_SPELLS_PER_TAB = 8

Spellbook.tithId = 44

Spellbook.OpenSpellbooks ={}

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function Spellbook.Initialize()
	local this = SystemData.ActiveWindow.name
	if (Spellbook.OpenSpellbooks[this]) then
		WindowSetShowing(this, true)
		Spellbook.Init = true
	else
		Spellbook.Init = false
		local id = SystemData.DynamicWindowId
		WindowSetId(this, id)
		WindowUtils.RestoreWindowPosition(this, false)  
		
		Spellbook[id] = {}
		Spellbook[id].activeTab = 1
		Spellbook[id].tabsCreated = false
		Spellbook[id].numTabs = 0
		
		Interface.DestroyWindowOnClose[this] = true
		RegisterWindowData(WindowData.Spellbook.Type, id)
		RegisterWindowData(WindowData.PlayerStatus.Type, 0)
		WindowRegisterEventHandler(this, WindowData.Spellbook.Event, "Spellbook.UpdateSpells")
		WindowRegisterEventHandler(this, WindowData.PlayerStatus.Event, "Spellbook.UpdateTithing")
		Spellbook.OpenSpellbooks[this] = true

		EnhancePack.LoadScale( this )
	end
	
end

function Spellbook.OnShown()
	local this = SystemData.ActiveWindow.name
	WindowAssignFocus(this,true)
end

function Spellbook.OnKeyHide()
	MainMenuWindow.notnow = true
	Spellbook.Hide()
end

function Spellbook.Hide()
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		local this = WindowUtils.GetActiveDialog()
		Spellbook.endStart = true
		Spellbook.delta = 0.5
		Spellbook.AnimWin = this
		WindowStartScaleAnimation(this, Window.AnimationType.SINGLE, WindowGetScale(this), 0, 0.5, false, 0, 1)
	else
		WindowSetShowing(WindowUtils.GetActiveDialog(), false)
	end
end

Spellbook.Init = false
Spellbook.AnimWin = ""
Spellbook.startStart = false
Spellbook.endStart = false 
Spellbook.delta = 0

function Spellbook.OnUpdate(timePassed)
	local this = SystemData.ActiveWindow.name
	if (Spellbook.delta  > 0) then
		Spellbook.delta = Spellbook.delta  - timePassed
	end
	if (Spellbook.endStart and Spellbook.delta <= 0) then
		WindowStopScaleAnimation(Spellbook.AnimWin)
		Spellbook.endStart = false
		WindowSetShowing(Spellbook.AnimWin, false)
		
	end
	

end

function Spellbook.UpdateTithing()
	local this = WindowUtils.GetActiveDialog()
	local id = WindowGetId(this)
	local data = WindowData.Spellbook[id]
	--If it is a paladin/chivarlry spellbook show the updated tithing points
	if (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
		local tithingName = "Spellbook_"..id.."Tithing"
		if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont(tithingName,  "font_verdana_bold", 12)
		else
			LabelSetFont(tithingName,  "UO_DefaultText", 12)
		end
		LabelSetText(tithingName, GetStringFromTid(1078097)..L" "..towstring(WindowUtils.AddCommasToNumber(tostring(WindowData.PlayerStatus.TithingPoints))))
	end
end

function Spellbook.CreateTabs(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		CreateWindowFromTemplate(tabName, "SpellbookTabButton", parent)
		
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent.."TabWindow", "topleft", 2, -22)
		else
			WindowAddAnchor(tabName, "topright", parent.."TabButton"..i-1, "topleft", 4, 0)
		end

		WindowSetShowing(tabName.."TabSelected", false)
	end
end

function Spellbook.CreateTabsLarge(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		CreateWindowFromTemplate(tabName, "SpellbookTabButtonLarge", parent)
		
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent.."TabWindow", "topleft", 2, -22)
		else
			WindowAddAnchor(tabName, "topright", parent.."TabButton"..i-1, "topleft", 4, 0)
		end

		WindowSetShowing(tabName.."TabSelected", false)
	end
end

function Spellbook.UnselectAllTabs(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		WindowSetShowing(tabName.."TabSelected", false)
		ButtonSetDisabledFlag(tabName, false)
	end
end

function Spellbook.SelectTab(parent, tabNum)
	local tabName = parent.."TabButton"..tabNum
	WindowSetShowing(tabName.."TabSelected", true)
	ButtonSetDisabledFlag(tabName, true);
end
	
-- Called when a minimodel event causes a refresh
-- Update the spells on the current page & set the tab text
-- Doing this in Initialize was causing a bunch of "doesn't exist" error messages
function Spellbook.UpdateSpells()

    local this = SystemData.ActiveWindow.name
	local windowId = WindowGetId(this)
	local id = WindowData.UpdateInstanceId
	if (windowId ~= id) then
		Debug.Print("Window Id doesn't match InstanceId: windowId="..tostring(WindowId).."id="..tostring(id))
		return
	end	

	local data = WindowData.Spellbook[id]
	if Spellbook[id].activeTab then
		if not Spellbook[id].tabsCreated then
            local numTabs = 0
            for i = data.firstSpellNum, data.firstSpellNum + 100, Spellbook.numSpellsPerTab[data.firstSpellNum] do
				local icon, serverId, tid = GetAbilityData(i)
				if(tid ~= nil and tid > 0) then
					numTabs = numTabs + 1
				else
					break
				end        
            end
            
            Spellbook[id].numTabs = numTabs
            
            if(data.firstSpellNum == 701) then -- BARD, create longer tabs
				Spellbook.CreateTabsLarge(this, Spellbook[id].numTabs)
            else
				Spellbook.CreateTabs(this, Spellbook[id].numTabs)
			end
			
			Spellbook[id].tabsCreated = true
			local buttonId = 1
			for i = data.firstSpellNum, data.firstSpellNum + Spellbook.numSpellsPerTab[data.firstSpellNum] do
				local icon, serverId, tid = GetAbilityData(i)
				if(tid ~= nil and tid > 0) then
					Spellbook.RegisterSpellIcon(id, buttonId, serverId)
					buttonId = buttonId + 1    
				else
					break
				end        
			end 
		end
			
		local texture = 2200
		WindowSetShowing( this.."Chrome", false )
	
	
        if (data.firstSpellNum == 1) then -- MAGERY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1002106) )
            texture = 2219
        elseif (WindowData.Spellbook[id].firstSpellNum == 101) then -- NECROMANCY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1061677) )
            texture = 11008
        elseif (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1061666) )
            local tithingName = "Spellbook_"..id.."Tithing"
            LabelSetText(tithingName, GetStringFromTid(1078097)..L" "..towstring(WindowUtils.AddCommasToNumber(tostring(WindowData.PlayerStatus.TithingPoints))))
            texture = 11009
        elseif (WindowData.Spellbook[id].firstSpellNum == 401) then -- BUSHIDO
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1070814) )
            texture = 11015
        elseif (WindowData.Spellbook[id].firstSpellNum == 501) then -- NINJITSU
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1070815) )
            texture = 11014
        elseif (WindowData.Spellbook[id].firstSpellNum == 601) then -- SPELLWEAVING
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1031600) )
            texture = 11055
        elseif (WindowData.Spellbook[id].firstSpellNum == 1001) then -- WEAPONS ABILITIES
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1044566) )
            texture = 11010
        elseif (WindowData.Spellbook[id].firstSpellNum == 678) then -- MYSTICISM
            WindowUtils.SetActiveDialogTitle( GetStringFromTid(1031677) )
            texture = 11058
        elseif (WindowData.Spellbook[id].firstSpellNum == 701) then -- BARD
			WindowUtils.SetActiveDialogTitle( GetStringFromTid(1028794) )
			texture = 11049
        end
        
        local xSize, ySize
		local scale = 2.0
		texture, xSize, ySize = RequestGumpArt( texture )
		local textureSize = xSize
		
		if (textureSize < ySize) then
			textureSize = ySize
		end
		
		
		WindowSetDimensions(  this, (xSize * scale), (ySize * scale) + 20 )
		WindowSetDimensions(  this.."LegacyBook", xSize * scale, ySize * scale )
		DynamicImageSetTexture( this.."LegacyBook", texture, 0, 0 )
		DynamicImageSetTextureScale( this.."LegacyBook", scale )
		
		WindowClearAnchors(this.."LegacyBook")
		WindowAddAnchor( this.."LegacyBook", "topleft", this, "topleft", -60, 0)
		WindowSetShowing( this.."LegacyBook", true )
		
		if(WindowData.Spellbook[id].firstSpellNum == 701) then -- BARD uses mastery names for each tab
			for i = 1, Spellbook[id].numTabs do
				local mastery = Spellbook.bardMasteries[i] or L""
				ButtonSetText( this.."TabButton"..i, L""..mastery)
			end
		else
			for i = 1, Spellbook[id].numTabs do
				local ordinal = Spellbook.uniqueOrdinals[i] or L"th"
				ButtonSetText( this.."TabButton"..i, L""..i..ordinal)
			end
		end
        Spellbook.ShowTab(Spellbook[id].activeTab)
	else
		return
	end
end

function Spellbook.ShowTab(tabnum)
        
    local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]    
	--Show Tithing Icon
	if (WindowData.Spellbook[id].firstSpellNum == 201) then -- PALADIN/CHIVALRY
		local iconId = WindowData.PlayerStatsDataCSV[Spellbook.tithId].iconId
		Spellbook.SetMiniIconStats(this,iconId)
		WindowSetShowing(this.."SquareIcon",true)
	else
		WindowSetShowing(this.."SquareIcon",false)
	end
   
    -- Update tabs to highlight the correct one
    Spellbook.UnselectAllTabs(this, Spellbook[id].numTabs)
    Spellbook.SelectTab(this, tabnum)
    Spellbook[id].activeTab = tabnum
    	
	local pageOffset = (tabnum-1)*Spellbook.numSpellsPerTab[data.firstSpellNum]

	for i=1, Spellbook.MAX_SPELLS_PER_TAB do
		local buttonName = "Spellbook_"..id.."TabWindowButton"..i
		local iconName = buttonName.."SquareIcon"
		local labelName = buttonName.."Desc"
		local wordName = buttonName.."WordPower"
		local abilityId = data.firstSpellNum + pageOffset + i - 1
		
		--Debug.Print(L"abilityId: "..data.firstSpellNum..L"+"..pageOffset..L"+"..i..L"-1="..abilityId)
		--Debug.PrintToDebugConsole(L"Spellbook.ShowTab: i =  "..StringToWString(tostring(i))..L" abilityId = "..StringToWString(tostring(abilityId)))
	
		local icon, serverId, tid, desctid, reagents, powerword = GetAbilityData(abilityId)
		if(icon ~= nil and icon ~= 0 and i <= Spellbook.numSpellsPerTab[data.firstSpellNum]) then
			--Debug.PrintToDebugConsole(L"Spellbook.ShowTab: has ability data for icon  "..StringToWString(tostring(icon)))
			local texture, x, y = GetIconData( icon )
			DynamicImageSetTexture( iconName, texture, x, y )
		
			if data.spells[pageOffset+i] == 1 then
				WindowSetAlpha( iconName, 1.0 )
				LabelSetTextColor(labelName, 0, 0, 0)
				LabelSetTextColor(wordName,  0, 94, 0)
				ButtonSetDisabledFlag(buttonName, false)
			else
				WindowSetAlpha( iconName, 0.4 )
				LabelSetTextColor(labelName, 115, 115, 115)
				LabelSetTextColor(wordName, 115, 115, 115)
				ButtonSetDisabledFlag(buttonName, true)
			end
			        
			LabelSetText(labelName, GetStringFromTid(tid))
			if abilityId == 55 then
				powerword = "Flam Kal Des Ylem"
			elseif abilityId == 61 then
				powerword = "Kal Vas Xen Corp"
			elseif abilityId == 62 then
				powerword = "Kal Vas Xen Ylem"
			elseif abilityId == 64 then
				powerword = "Kal Vas Xen An Flam"
			elseif abilityId == 701 then
				powerword = "Uus Por"
			elseif abilityId == 702 then
				powerword = "An Zu"
			elseif abilityId == 703 then
				powerword = "Kal Mani Tym"
			elseif abilityId == 704 then
				powerword = "Uus Jux Sanct"
			elseif abilityId == 705 then
				powerword = "In Jux Hur Rel"
			elseif abilityId == 706 then
				powerword = "Kal Des Mani Tym"
			end
			--Show the power words for the spell
			if(powerword ~= nil) then
				--Debug.Print("Words of Power = "..powerword)
				LabelSetText(wordName, StringToWString(powerword))
			end

			-- show the entry
			WindowSetShowing (buttonName, true)
			WindowSetShowing (labelName, true)
		else
			-- hide the entry
			WindowSetShowing (buttonName, false)
			WindowSetShowing (labelName, false)
		end
	end	
end

-- OnShutdown Handler
function Spellbook.Shutdown()
	ItemProperties.ClearMouseOverItem()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	UnregisterWindowData(WindowData.Spellbook.Type, id)
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
	WindowUtils.SaveWindowPosition(SystemData.ActiveWindow.name, false, "LEGACY_Spellbook_GUMP")
end

-- OnLButtonDown Handler
function Spellbook.SpellLButtonDown()
    local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]
    local page = Spellbook[id].activeTab
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1

    local icon, serverId = GetAbilityData(curSpell)
    
    DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SPELL,serverId,icon)
end

-- OnLButtonUP Handler
function Spellbook.SpellLButtonUp()
	local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]
    local page = Spellbook[id].activeTab
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1

    local icon, serverId = GetAbilityData(curSpell)

    if( serverId ~= nil ) then
		UserActionCastSpell(serverId)
		--UO_DefaultWindow.CloseDialog()
		--WindowSetShowing(this, false)
		Spellbook.Hide()
    end
end

-- OnMouseOver Handler
function Spellbook.SpellMouseOver()
	CharacterSheet.UpdateStatus()
	local this = WindowUtils.GetActiveDialog()
    local id = WindowGetId(this)
    local data = WindowData.Spellbook[id]
    local page = Spellbook[id].activeTab
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local curSpell = (page-1)*Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1

    local icon, serverId, tid, desctid, reagents, powerword, tithingcost, minskill, manacost  = GetAbilityData(curSpell)
    local reagentsStr = L""
    local tithingStr = L""
    local minskillStr = L"<BR>"
    local manacostStr = L""
    
   -- Debug.Print(curSpell)
  
    if(reagents ~= nil and reagents ~= "") then
		  --TID says "Reagents"
		reagentsStr = L"<BR>== "..GetStringFromTid(1002127)..L" ==<BR>"..StringToWString(reagents)
	--Debug.Print("reagents ="..reagents)
    end
    
    if(tithingcost ~= nil and tithingcost > 0) then
		-- Paladin
		if(serverId >= 201 and serverId <= 210) then
			-- TID says "Tithing Cost:"
			tithingStr =  L"<BR>"..GetStringFromTid(1062099)..StringToWString(tostring(tithingcost))
		-- Bard
		elseif(serverId >= 701 and serverId <= 706) then
			-- TID says "Upkeep Cost:"
			tithingStr =  L"<BR>"..GetStringFromTid(1115718)..StringToWString(tostring(tithingcost))
		end
    end
    
    local skillId = 0 
	local skillLevel = 0
	-- 9 bushido
	-- 13 chivalry
	-- 32 magery
	-- 38 necromancy
	-- 39 ninjitsu
	-- 46 spellweaving
	-- 37 mysticism
	
    if (curSpell > 0 and curSpell < 65) then
		minskill = SpellsInfo.GetMinSkill(curSpell) 
		skillId = 32
	elseif (curSpell >= 101 and curSpell <= 200) then -- Necromancy
		minskill = SpellsInfo.GetMinSkill(curSpell) 
		skillId = 38
	elseif (curSpell >= 201 and curSpell <= 300) then -- Chivalry
		skillId = 13
	elseif (curSpell >= 401 and curSpell <= 500) then -- Bushido
		skillId = 9
	elseif (curSpell >= 501 and curSpell <= 600) then	-- Ninjitsu
		skillId = 39
	elseif (curSpell >= 601 and curSpell <= 677) then -- Spellweaving
		skillId = 46
	elseif (curSpell >= 678 and curSpell <= 700) then -- Mysticism
		skillId = 37
	end
	
	
	if (curSpell < 701) then
		local serverId = WindowData.SkillsCSV[skillId].ServerId
		skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	end
	
    if(minskill ~= nil) then
		-- TID says "Min Skill:"
		minskillStr =  minskillStr..L"<BR>"..GetStringFromTid(1062101)..L" "..StringToWString(tostring(minskill))
    end
    
    if ( WindowData.PlayerStatus["Race"] == 1 and skillLevel < 20 ) then
		skillLevel = 20
	end
	local spelldamage = L""
	
	if (skillId > 0) then
		local maxskill = SpellsInfo.GetMaxSkill(minskill, curSpell) 
		minskillStr =  minskillStr..L"<BR>"..L"Max Skill: "..StringToWString(tostring(maxskill))
	    

		local success  = ((skillLevel - minskill) * 100) / SpellsInfo.GetVariation(curSpell) 

        if skillLevel < minskill then
            success = 0
        end
        if skillLevel > minskill + SpellsInfo.GetVariation(curSpell)  then
            success = 100
        end
        
        success = string.format("%1.1f", success)
        
       minskillStr =  minskillStr..L"<BR><BR>"..L"Success Chance: "..StringToWString(tostring(success)) .. L"%<BR>"
       local spellspeed = SpellsInfo.GetSpellSpeed(curSpell)
       
		if (spellspeed) then
			minskillStr =  minskillStr .. L"<BR>Casting Speed: " .. spellspeed .. L"s<BR>"
		end
       spelldamage = SpellsInfo.GetSpellDamage(curSpell) 
    end
    
    if(manacost ~= nil) then
		-- TID says "Mana Cost:"
		local lmcMana = math.floor(manacost - (manacost * (tonumber(WindowData.PlayerStatus["LowerManaCost"]) / 100)))
		manacostStr =  L"<BR>"..GetStringFromTid(1062100)..L" " .. StringToWString(tostring(lmcMana)) .. L" (".. StringToWString(tostring(manacost)) .. L")"
    end
    

    
	local itemData = { windowName = this,
						itemId = curSpell,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SPELL,
						detail = ItemProperties.DETAIL_LONG,
						title = L"",	
						body = reagentsStr..tithingStr..minskillStr.. spelldamage .. manacostStr	}
	ItemProperties.SetActiveItem(itemData)	    
end

-- Tab Handler
function Spellbook.ToggleTab()
    -- Get the number of the tab clicked, which should be the last character of its name
    -- NOTE: Obviously, this won't work if you have more than ten tabs
    tab_clicked = tonumber (string.sub( SystemData.ActiveWindow.name, -1, -1))
	Spellbook.ShowTab(tab_clicked)  
end


function Spellbook.RegisterSpellIcon(spellbookId, buttonId, serverId)
	local buttonName = "Spellbook_"..spellbookId.."TabWindowButton"..buttonId
	HotbarSystem.RegisterSpellIcon(buttonName, serverId)
end

-- OnShutdown Handler
function Spellbook.ShutdownSpellIcon()
	HotbarSystem.UnregisterSpellIcon(SystemData.ActiveWindow.name)
end

function Spellbook.TithLButtonDown()
	local id = Spellbook.tithId
	local iconId = WindowData.PlayerStatsDataCSV[id].iconId	
	DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_PLAYER_STATS,id,iconId)
end

function Spellbook.SetMiniIconStats(iconWindow, iconId)
	local texture, x, y = GetIconData( iconId )	
	--Start position of the texture, need to be offset by x and y to get the stat icon image
	x = 4  
	y = 3
	WindowSetDimensions(iconWindow.."SquareIcon", 20, 20)
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 1 )			
end

function Spellbook.TithMouseOver()
	local buttonName = SystemData.ActiveWindow.name
	local text = GetStringFromTid(1112081)
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end
