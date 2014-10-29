----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SkillsWindow = { }
SkillsWindow.LockAll = false
SkillsWindow.DownAll = false
SkillsWindow.CurrentIndex = -1
SkillsWindow.CurrentTab = 0

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

-- TIDs
-- TODO: Add TIDs for each of the skill groups - TODO - remove all of these, except for TID_SKILLS

TID_SKILLS = 3000084
TID_SKILLINCREASE_TOK = 3000260 --"Your skill in ~1skillname~ has increased by ~2changeamount~.  It is now ~3newvalue~."
TID_SKILLDECREASE_TOK = 3000261 --"Your skill in ~1skillname~ has decreased by ~2changeamount~.  It is now ~3newvalue~."

-- Contents and order for each page. The numbers are the skills
-- as assigned in /Runtime/GameData/skilldata.csv
local tab1 = { 7,  22, 28, 53 }
local tab2 = { 2, 5, 18, 21, 23, 31, 40, 50, 51, 58, 54 }
local tab3 = { 1, 6, 8, 11, 12, 14, 20, 27, 30, 35, 52, 55 }
local tab4 = { 9, 13, 17, 32, 33, 34, 38, 39, 46, 47, 37, 26 }
local tab5 = { 3, 4, 10, 19, 24, 56, 57 }
local tab6 = { 15, 25, 29, 42, 44, 45, 48, 49 }
local tab7 = { 16, 36, 41, 43 }
local tabContents = { tab1, tab2, tab3, tab4, tab5, tab6, tab7 }
local maxskill_index = 57

SkillsWindow.CUSTOM_TAB_NUM = 8
SkillsWindow.ContextReturnCodes = {}
SkillsWindow.ContextReturnCodes.ADD_TO_CUSTOM = 1
SkillsWindow.ContextReturnCodes.REMOVE_CUSTOM = 2
SkillsWindow.TID_ADD_TO_CUSTOM = 1078498
SkillsWindow.TID_REMOVE_CUSTOM = 1078499
SkillsWindow.TID_CUSTOM_HELP = 1078500
SkillsWindow.NUM_SKILLS_PER_TAB = 12

SkillsWindow.SessionGains = {}
SkillsWindow.ROT = {}

-- don't attempt to draw the window when we are first registering for skill data
local updateOff = 0

-- boolean to make sure we have initialized the window 
local SkillsWindowInitialized = 0

-- this gets set equal to WindowData.SkillsWindow[id] 
local data = 0

-- SkillDataMode 0 = real skill value, 1 = skill with mods
SkillsWindow.SkillDataMode = 0

-- SkillCapMode  0 = don't show skill caps, 1 = show skill caps
SkillsWindow.SkillCapMode = 0

-- SkillsTracker  0 = don't show Skills Tracker, 1 = show Skills Tracker
SkillsWindow.SkillsTrackerMode = 0

local oldSkillValues = {}
local hasSkillValues = false

SkillsWindow.Delta = 0
----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function SkillsWindow.Initialize()
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize")

	if SkillsWindowInitialized == 1 then
		--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: already initialized, returning")
		return
	end

	UOBuildTableFromCSV ("data/gamedata/skilldata.csv","SkillsCSV")
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: WindowData.SkillsCSV[1].ID =  "..StringToWString(tostring(WindowData.SkillsCSV[1].ID)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: WindowData.SkillsCSV[1].NameTid =  "..StringToWString(tostring(WindowData.SkillsCSV[1].NameTid)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: WindowData.SkillsCSV[1].ShowIcon =  "..StringToWString(tostring(WindowData.SkillsCSV[1].ShowIcon)))
	
	WindowRegisterEventHandler("SkillsWindow", SystemData.Events.TOGGLE_SKILLS_TRACKER_WINDOW, "SkillsWindow.SkillsTrackerToggleLButtonUp")
	
	this = "SkillsWindow"
	
	tabContents[SkillsWindow.CUSTOM_TAB_NUM] = SystemData.Settings.Interface.CustomSkills
    
    SkillsWindow.SkillCapMode = (SystemData.Settings.Interface.SkillsWindowShowCaps and 1 or 0)
    SkillsWindow.SkillDataMode = (SystemData.Settings.Interface.SkillsWindowShowModified and 1 or 0)
	
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)

	if(WindowData.SkillsWindow ~= nil) then
		data = WindowData.SkillsWindow[id]
	end
	
	-- Register each of the skills
	-- TODO: Register for the skills list first and use that instead of magic numbers
	
	-- CJT - don't attempt to update the window draws while we register for all of the skills
	updateOff = 1
	for i=0,maxskill_index do  
		RegisterWindowData(WindowData.SkillDynamicData.Type, i)
	end
	updateOff = 0
	
	RegisterWindowData(WindowData.SkillList.Type,0)
	
	WindowRegisterEventHandler( this, WindowData.SkillDynamicData.Event, "SkillsWindow.UpdateSkill")
	
	WindowUtils.SetActiveDialogTitle(GetStringFromTid(TID_SKILLS))

	--ButtonSetText( "SkillsWindowTabButton1", L"MISC" )
	ButtonSetText( "SkillsWindowTabButton1", GetStringFromTid(1078117) )  -- "Misc"
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: Misc tab name =  "..GetStringFromTid(1077759))

	ButtonSetText( "SkillsWindowTabButton2",WindowUtils.GetStringFromTid(1077760) ) -- "Combat"
	ButtonSetText( "SkillsWindowTabButton3",UI.GetCliloc(SystemData.Settings.Language.type, 921) ) -- "Trade"
	ButtonSetText( "SkillsWindowTabButton4",WindowUtils.GetStringFromTid(1077762) ) -- "Magic"
	ButtonSetText( "SkillsWindowTabButton5",WindowUtils.GetStringFromTid(1077763) ) -- "Wild"
	--ButtonSetText( "SkillsWindowTabButton6",WindowUtils.GetStringFromTid(1077764) ) -- "Thieving"
	ButtonSetText( "SkillsWindowTabButton6",WindowUtils.GetStringFromTid(1078116) ) -- "Thief"
	ButtonSetText( "SkillsWindowTabButton7",WindowUtils.GetStringFromTid(1077765) ) -- "Bard"
	ButtonSetText( "SkillsWindowTabButton8",WindowUtils.GetStringFromTid(1077766) ) -- "Custom"

	-- Set the active tab to "MISC"
	data = {}
	data.activeTab = 1
	SkillsWindow.CurrentTab = data.activeTab
	data.numTabs = table.getn(tabContents)
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: data.numTabs =  "..StringToWString(tostring(data.numTabs)))

	SkillsWindowInitialized = 1
	
	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	if (showing) then
		--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: calling ShowTab() ")
		SkillsWindow.ShowTab(data.activeTab)
	end	
	
	SkillsWindow.UpdateSkillValueTypeToggleButtonText()	
	SkillsWindow.UpdateSkillCapToggleButtonText()
	SkillsWindow.UpdateSkillsTrackerToggleButtonText()
	
	ButtonSetText( "SkillsWindowSkillsLock", UI.GetCliloc(SystemData.Settings.Language.type, 322) )
	ButtonSetText( "SkillsWindowSkillsDown", UI.GetCliloc(SystemData.Settings.Language.type, 323))
	
	SkillsWindow.UpdateTotalSkillPoints()
	WindowUtils.RestoreWindowPosition("SkillsWindow")
	
	hasSkillValues = false
	
	LabelSetText("SkillsWindowCustomHelp",GetStringFromTid(SkillsWindow.TID_CUSTOM_HELP))
	WindowSetShowing("SkillsWindowCustomHelp", false)
end


function SkillsWindow.UpdateTotalSkillPoints()
	--	Debug.PrintToDebugConsole(L"SkillsWindow.UpdateTotalSkillPoints")
	if (EnhancePack and EnhancePack.ProfileUpdated) then
		--[[
		local tid = L"This account is ~1_VAL~ months" --GetStringFromTid(1080020)
		if (wstring.find(WindowData.CharProfile.Age, L"old")) then
			tid = tid.. L" old"
		end
		if (wstring.find(WindowData.CharProfile.Age, L".")) then
			tid = tid.. L"."
		end
		local final = L" 48 "
		if (wstring.find(WindowData.CharProfile.Age, L"Can not determine this account's age")==nil and WindowData.CharProfile.Age) then
			local val = wstring.sub(tid, 1, wstring.find(tid , L"~1_VAL~") - 1)

			final = wstring.gsub(WindowData.CharProfile.Age, val, L"")

			val = wstring.sub(tid, wstring.find(tid , L"~1_VAL~") + 7)

			final = wstring.gsub(final, val, L"")
		end
		
		local age = string.gsub(WStringToString(final), " ", "")

		age = tonumber(age)

		--local texto = wstring.find(WindowData.CharProfile.Age , L" is ")
		--local age = 0
		--if (texto == nil ) then
		--	age = 4
		--else
		--	age = tonumber(wstring.sub(WindowData.CharProfile.Age, texto + 4, -7))
		--end
		--if (age == nil) then
		--	return
		--end
		local ageBonus = math.floor(age / 12)
		if (ageBonus > 4) then
			ageBonus = 4
		end
		--]]
		local TotalPoints = 720 -- 700 + (ageBonus * 5)
		
		
		local SkillPointsUsed = 0
		for i=0,maxskill_index do
			SkillPointsUsed = SkillPointsUsed + WindowData.SkillDynamicData[i].RealSkillValue
		end
		SkillPointsUsed = SkillPointsUsed / 10

		local SkillPointsUsedStr = string.format("%.0f", SkillPointsUsed) -- truncate off any decimal places
		-- CJT 3/30/07 - don't show what the total possible skill points a player can have
		
		if (SkillsWindow.SkillCapMode == 0) then
			LabelSetText("SkillsWindowTotalSkillPoints", GetStringFromTid(1077767)..StringToWString(SkillPointsUsedStr)) -- "Skill Points Used: "
		else
			LabelSetText("SkillsWindowTotalSkillPoints", GetStringFromTid(1077767)..StringToWString(SkillPointsUsedStr)..L"/"..StringToWString(tostring(TotalPoints))) -- "Skill Points Used: "
		end
	end
end

function SkillsWindow.DoNothing()
	local doNothing = 0
end

function SkillsWindow.ToggleSkillsWindow()
	--Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow")
	
	if SkillsWindowInitialized == 0 then
		-- error
		Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: window not initialized, returning")
		return
	end
	
	ToggleWindowByName( "SkillsWindow", "", SkillsWindow.DoNothing, SkillsWindow.DoNothing, SkillsWindow.DoNothing )

	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	if (showing) then
		--Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: data.activeTab = "..StringToWString(tostring(data.activeTab)))
		--Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: data.numTabs = "..StringToWString(tostring(data.numTabs)))
		--Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: calling UpdateSkill() ")
		SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
		SkillsWindow.UpdateAllSkills()
	end	

end

function SkillsWindow.OnUpdate(timepassed)
	SkillsWindow.Delta = SkillsWindow.Delta + timepassed
	if SkillsWindow.Delta >= 1 then
		SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
		SkillsWindow.Delta = 0
	end
end

-- Makes all the other tabs selectable
function SkillsWindow.EnableAllTabs(parent)
	--Debug.PrintToDebugConsole(L"SkillsWindow.EnableAllTabs "..StringToWString(tostring(data.numTabs)))

	for i = 1, data.numTabs do
		tabName = parent.."TabButton"..i
		WindowSetShowing(tabName.."Tab", true)
		ButtonSetDisabledFlag(tabName, false)
	end
end

-- Makes the current tab the live one, and unselectable
function SkillsWindow.DisableTab(parent, tabNum)
	--Debug.PrintToDebugConsole(L"SkillsWindow.DisableTab ")

	-- TODO -- make sure the tab number passed in is a valid tab
	
	tabName = parent.."TabButton"..tostring(tabNum)

	--Debug.PrintToDebugConsole(L"SkillsWindow.DisableTab: window name =  "..StringToWString(tabName))
	WindowSetShowing(tabName.."TabSelected", true)
	ButtonSetDisabledFlag(tabName, true);
end
	
function SkillsWindow.UpdateAllSkills()

	SkillsWindow.CheckAllSkillsForUpdate()
	SkillsWindow.SaveCurrentSkillValues()

	if updateOff == 1 then
		return
	end
	
	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	if (showing) then
		SkillsWindow.ShowTab(data.activeTab)
		SkillsWindow.UpdateTotalSkillPoints()
	end
end
	
-- Called when a minimodel event causes a refresh
function SkillsWindow.UpdateSkill()

	local skillId = WindowData.UpdateInstanceId
	if SkillsWindow.CheckSkillForUpdate(skillId) then
		SkillsWindow.SaveCurrentSkillValue(skillId)
		
		-- if updateOff is on then don't try and draw the active tab stuff.
		if updateOff == 1 then
			return
		end
		
		WindowName = "SkillsWindow"
		showing = WindowGetShowing(WindowName)
		if (showing) then
			SkillsWindow.ShowTab(data.activeTab)
			SkillsWindow.UpdateTotalSkillPoints()
		end
	end
end

-- Force the active tab to be something
function SkillsWindow.ForceActiveTabSetting (tabnum)
	--Debug.PrintToDebugConsole(L"SkillsWindow.ForceActiveTabSetting tabnum = "..StringToWString(tostring(tabnum)))

	data.activeTab = tabnum
	SkillsWindow.CurrentTab = data.activeTab
end

-- Refresh the current page and fetch the skill data
function SkillsWindow.ShowTab(tabnum)
	--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab ")

	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	if (showing) then
		doNothing = 0
	else
		--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab(): aborting because window ain't open ")
		do return end
	end
	
	local this = "SkillsWindow"

	-- Make sure we always display something    
	if tabnum == nil then
		--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab(): Forcing tabnum = 1 ")
		tabnum = 1
		SkillsWIndow.ForceActiveTabSetting (tabnum)
	end

	-- Update tab buttons to highlight the correct one
	SkillsWindow.EnableAllTabs(this)
	SkillsWindow.DisableTab(this, tabnum)

	-- Hide all tab windows
	for i=1, data.numTabs do
		local tabWindowName = "SkillsWindowTabWindow"..tostring(i)
		WindowSetShowing(tabWindowName, false)
	end

	-- Change the active tab if needed
	if data.activeTab ~= tabnum then
		--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():Changing tabnum from = "..StringToWString(tostring(data.activeTab))..L"to "..StringToWString(tostring(data.tabnum)))
		
		data.activeTab = tabnum
		SkillsWindow.CurrentTab = data.activeTab
	end

	-- show selected tab window
	local tabWindowName = "SkillsWindowTabWindow"..tostring(tabnum)
	WindowSetShowing(tabWindowName, true)
	
	-- Force a refetch of data and a redraw of the tab
	-- Fill out all the information for each skill
	local activeContents = tabContents[tabnum]
	numItemsInTab = table.getn(activeContents)
	--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():numItemsInTab = "..StringToWString(tostring(numItemsInTab)))
	
	for i=1,SkillsWindow.NUM_SKILLS_PER_TAB do
		local base = "SkillsWindowTabWindow"..tostring(tabnum).."Entry"..tostring(i)

		if i <= numItemsInTab then
			local skillId = activeContents[i]

			local serverId = WindowData.SkillsCSV[skillId].ServerId
			
			local iconPath = base .. "IconGraphic"
			local namePath = base .. "Name"
			local titlePath = base .. "Title"
			local valuePath = base .. "Value"
			local ROTPath = base .. "ROT"
			local buttonPath = base .. "SkillStateButton"
			local helpPath = base .. "HelpButton"
			
			-- Fetch the information
			local iconId = WindowData.SkillsCSV[skillId].IconId
			
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():i = "..StringToWString(tostring(i)))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():iconId = "..StringToWString(tostring(iconId )))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():skillId = "..StringToWString(tostring(skillId)))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():i = "..StringToWString(tostring(i)))
			
			local iconTexture, x, y = GetIconData(iconId)
			local displayName = GetStringFromTid(WindowData.SkillsCSV[skillId].NameTid)	
			
			local skillLevel = nil
			if (SkillsWindow.SkillDataMode == 0) then
				skillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue
			else
				skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue
			end
			local skillLevelCap = WindowData.SkillDynamicData[serverId].SkillCap

			if (EnhancePack and EnhancePack.SkillTargetVals[skillId]) then
				skillLevelCap = EnhancePack.SkillTargetVals[skillId]
				
			end

			local skillState = WindowData.SkillDynamicData[serverId].SkillState

			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():skill = "..StringToWString(tostring(skillLevel)))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():cap = "..StringToWString(tostring(skillLevelCap)))

			-- Display the information
			DynamicImageSetTexture(iconPath, iconTexture, x, y)
			DynamicImageSetTexture(iconPath.."BG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
			
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():iconPath = "..StringToWString(iconPath))
			
			local titleString = SkillsWindow.GetSkillTitle (WindowData.SkillDynamicData[serverId].RealSkillValue)
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():titleString = "..titleString)

			LabelSetText(namePath, displayName)
			LabelSetText(titlePath, titleString)
			

			-- Clean up the number so it works as a percentage
			local skillFormatted = SkillsWindow.FormatSkillValue(skillLevel)
			if (SkillsWindow.SkillCapMode == 0) then
				if skillLevel ~= nil then
					LabelSetText(valuePath, skillFormatted..L"%")		
				else
					-- This shouldn't happen unless it misregisters the skills
					LabelSetText(valuePath, L"---.-%")
				end	
			else	
				-- want to show skill caps	
				local capFormatted = SkillsWindow.FormatSkillValue(skillLevelCap)
				if skillLevel ~= nil then
					LabelSetText(valuePath, skillFormatted..L"/"..capFormatted..L"%")		
				else
					-- This shouldn't happen unless it misregisters the skills
					LabelSetText(valuePath, L"---.-/---.-%")
				end
			end
			
			if UserData.Settings.Login.lastShardSelected == 12 or UserData.Settings.Login.lastShardSelected == 18 then --12 SIEGE   18 mugen
				LabelSetText(ROTPath, L"")
				if SkillsWindow.ROT[skillId] then
					local seconds = SkillsWindow.ROT[skillId] - EnhancePack.TimeSinceLogin
									
					if seconds > 0 then
						local min = math.floor(seconds/60)
						if min > 0 then
							local prefix = ""
							if (seconds - (min * 60) > 0) then
								prefix = ">"
							end
							timer = StringToWString(prefix .. tostring(min)	.. "m")
						else
							timer = StringToWString(tostring(seconds)	.. "s")
						end
						
						LabelSetText(ROTPath, L"ROT: " .. timer)
					end
				end
			end
			
			
			-- for the main icon button
			WindowSetId(base.."Icon", i)	-- Make sure the button knows which one it is
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():button name = "..StringToWString(base.."Icon"))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():button id = "..StringToWString(tostring(i)))

			-- for the skill state button and help button
			WindowSetId(buttonPath, i)	-- Make sure the button knows which one it is
			WindowSetId(helpPath, i)
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():button name = "..StringToWString(buttonPath))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():button id = "..StringToWString(tostring(i)))

			SkillsWindow.SetStateButton(buttonPath, skillState)
			
			WindowSetShowing(base, true)
		else
			-- Don't show empty skill entries
			WindowSetShowing(base, false)
		end
		
	end
	
	-- show help text if this is custom tab and its empty
	if( data.activeTab == SkillsWindow.CUSTOM_TAB_NUM and numItemsInTab == 0 ) then
		WindowSetShowing("SkillsWindowCustomHelp", true)
	else
		WindowSetShowing("SkillsWindowCustomHelp", false)
	end
end

-- OnShutdown Handler
function SkillsWindow.Shutdown()
	for i=0,maxskill_index do  
		UnregisterWindowData(WindowData.SkillDynamicData.Type, i)
	end
	
	UnregisterWindowData(WindowData.SkillList.Type,0)
	
	WindowUtils.SaveWindowPosition("SkillsWindow")
	
	UOUnloadCSVTable("SkillsCSV")
end

-- OnLButtonDown Handler
function SkillsWindow.SkillLButtonDown()
    if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
	    -- Player is dragging an icon

	    -- button number is its location on the screen (1 = top of left column, 2 = 2nd in left column, etc with left column done first before starting through the right column)
	    local buttonNum = WindowGetId( SystemData.ActiveWindow.name)

	    local tab = data.activeTab
	    local activeContent = tabContents[tab]
    	
	    -- skillIndex is the line index in the csv file for this skill
	    local skillIndex = activeContent[buttonNum]
	    local skillId = WindowData.SkillsCSV[skillIndex].ServerId
	    local iconId = WindowData.SkillsCSV[skillIndex].IconId
    	
	    --Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): iconId = "..StringToWString(tostring(iconId)))
    	
	    if (WindowData.SkillsCSV[skillIndex].DragIcon == 1) then
		    if( skillId ~= nil ) then			
			    DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SKILL,skillId,iconId)
		    end
	    else
		    --Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): Not allowed to drag index = "..StringToWString(tostring(skillIndex)))
    	
	    end
	end       
end

-- OnLButtonUP Handler
function SkillsWindow.SkillsLockLButtonUp()
	if (not SkillsWindow.LockAll and not SkillsWindow.DownAll) then
		SkillsWindow.CurrentIndex = 1
		SkillsWindow.LockAll = true
	end
end
function SkillsWindow.SkillsDownLButtonUp()
	if (not SkillsWindow.LockAll and not SkillsWindow.DownAll) then
		SkillsWindow.CurrentIndex = 1
		SkillsWindow.DownAll = true
	end
end

function SkillsWindow.SkillLButtonUp()
	-- Player is using a skill by single clicking on an icon

	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp()")
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp(): window name = "..StringToWString(SystemData.ActiveWindow.name))

	local buttonNum = WindowGetId( SystemData.ActiveWindow.name)
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp(): button = "..StringToWString(tostring(buttonNum)))

	-- button number is its location on the screen (1 = top of left column, 2 = 2nd in left column, etc with left column done first before starting through the right column)

	local tab = data.activeTab
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): window name = "..StringToWString(SystemData.ActiveWindow.name))
	local activeContent = tabContents[tab]
	-- skillIndex is the line index in the csv file for this skill
	local skillIndex = activeContent[buttonNum]
	
	local skillId = WindowData.SkillsCSV[skillIndex].ServerId

	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): tab = "..StringToWString(tostring(tab)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): skillIndex = "..StringToWString(tostring(skillIndex)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): skillId = "..StringToWString(tostring(skillId)))
	
	-- if the skill icon is not dragable, then it can't be directly used
	if (WindowData.SkillsCSV[skillIndex].DragIcon == 1) then
		SkillsWindow.UseSkill (skillId)
	else
	    PrintTidToChatWindow(500014,SystemData.ChatLogFilters.SYSTEM)
	end		
end

function SkillsWindow.UseSkill (skillId)
	-- skillId is the server id for the skill
	--Debug.PrintToDebugConsole(L"SkillsWindow.UseSkill(): serverId = "..StringToWString(tostring(skillId)))
	
	UserActionUseSkill(skillId)
	--EnhancePack.OnSkillUsed()
end

-- OnMouseOver Handler
function SkillsWindow.SkillMouseOver()
	local buttonNum = WindowGetId( SystemData.ActiveWindow.name)
	local tab = data.activeTab
	local activeContent = tabContents[tab]
	local skillIndex = activeContent[buttonNum]
	
	-- NOTE: Need to fix this. Id 0 is also a null check, so no tooltip for Alchemy
	local skillId = WindowData.SkillsCSV[skillIndex].ServerId + 1
	local itemData = { windowName = this,
						itemId = skillId,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SKILL,
						detail = ItemProperties.DETAIL_LONG }
	ItemProperties.SetActiveItem(itemData)
end

-- Tab Handler
function SkillsWindow.ToggleTab()
	-- Get the number of the tab clicked, which should be the last character of its name
	-- NOTE: Obviously, this won't work if you have more than ten tabs
	tab_clicked = tonumber (string.sub( SystemData.ActiveWindow.name, -1, -1))
	SkillsWindow.ShowTab(tab_clicked)
	currentTab = tab_clicked  
end

-- Returns the graphic for the skill state button based on the state
function SkillsWindow.SetStateButton(button, val)
	if val == 0 then
	    WindowSetDimensions(button, UI.UpArrow.DIMENSIONS.x, UI.UpArrow.DIMENSIONS.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, UI.UpArrow.texture, UI.UpArrow.STATE_NORMAL.x, UI.UpArrow.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.UpArrow.texture, UI.UpArrow.STATE_NORMAL_HIGHLITE.x , UI.UpArrow.STATE_NORMAL_HIGHLITE.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, UI.UpArrow.texture, UI.UpArrow.STATE_PRESSED.x, UI.UpArrow.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.UpArrow.texture, UI.UpArrow.STATE_PRESSED_HIGHLITE.x , UI.UpArrow.STATE_PRESSED_HIGHLITE.y)
	elseif val == 1 then
	    WindowSetDimensions(button, UI.DownArrow.DIMENSIONS.x, UI.DownArrow.DIMENSIONS.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL.x, UI.DownArrow.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL_HIGHLITE.x , UI.DownArrow.STATE_NORMAL_HIGHLITE.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED.x, UI.DownArrow.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED_HIGHLITE.x , UI.DownArrow.STATE_PRESSED_HIGHLITE.y)		
	elseif val == 2 then
	    WindowSetDimensions(button, UI.Lock.DIMENSIONS.x, UI.Lock.DIMENSIONS.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, UI.Lock.texture, UI.Lock.STATE_NORMAL.x, UI.Lock.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_NORMAL_HIGHLITE.x, UI.Lock.STATE_NORMAL_HIGHLITE.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, UI.Lock.texture, UI.Lock.STATE_PRESSED.x, UI.Lock.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_PRESSED_HIGHLITE.x, UI.Lock.STATE_PRESSED_HIGHLITE.y)
	end
end

-- Cycle through the states of the skill state button (Up, Down, Lock)
function SkillsWindow.CycleLButtonUp(sts)
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():")
	tab = data.activeTab
	buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	

	activeContent = tabContents[tab]
	skillId = activeContent[buttonNum]
	
	local state = WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState
	if (sts > 0) then
		state = sts
	else
		state = state + 1
	
		if ( state > 2) then
			state = 0
		end
	end
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():window name = "..StringToWString(SystemData.ActiveWindow.name))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():tab = "..StringToWString(tostring(tab)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():entry = "..StringToWString(tostring(buttonNum)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():skill id = "..StringToWString(tostring(skillId)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():server id = "..StringToWString(tostring(WindowData.SkillsCSV[skillId].ServerId)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():state = "..StringToWString(tostring(WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState)))
 
	

	-- CJT - why is the WindowData being changed from the LUA side? -- need to verify if server sends a confirmation
	WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = state
	
	buttonPath = "SkillsWindowTabWindow"..tostring(tab).."Entry"..tostring(buttonNum).."SkillStateButton"
	
	SkillsWindow.SetStateButton(buttonPath, state)
	
	-- tell the server that we had a skill state change
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():skill = "..StringToWString(tostring(WindowData.SkillsCSV[skillId].ServerId)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():state = "..StringToWString(tostring(state)))


	ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
	ReturnWindowData.SkillSystem.SkillButtonState = state
	BroadcastEvent (SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
	
end

function SkillsWindow.CycleMouseOver()
	local text = GetStringFromTid(1112103)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

-- Format an integer so it looks like "000.0" 
function SkillsWindow.FormatSkillValue(skillLevel)
	local whole = tostring(skillLevel)
	
	local lastDigit = towstring(string.sub(whole, -1, -1))
	whole = towstring(string.sub(whole, 0, string.len(whole) - 1))
	if whole == L"" then 
		whole = L"0"
	end
	local output = whole..L"."..lastDigit
	
	return output
end

function SkillsWindow.GetSkillTitle (skillLevel)

	local titleString = L""
	
	local level = skillLevel/100
	
	if (level > 2) then
		if ((level >= 3) and (level < 4)) then
			titleString = L"("..GetStringFromTid(1077474)..L")" -- "Neophyte"
		elseif ((level >= 4) and (level < 5)) then
			titleString = L"("..GetStringFromTid(1077475)..L")"-- "Novice"
		elseif ((level >= 5) and (level < 6)) then
			titleString = L"("..GetStringFromTid(1077476)..L")" -- "Apprentice"
		elseif ((level >= 6) and (level < 7)) then
			titleString = L"("..GetStringFromTid(1077477)..L")"  -- "Journeyman"
		elseif ((level >= 7) and (level < 8)) then
			titleString = L"("..GetStringFromTid(1077478)..L")" -- "Expert"
		elseif ((level >= 8) and (level < 9)) then
			titleString = L"("..GetStringFromTid(1077479)..L")" -- "Adept"
		elseif ((level >= 9) and (level < 10)) then
			titleString = L"("..GetStringFromTid(1077480)..L")"  -- "Master"
		elseif (level >= 10) and (level < 11)  then
			titleString = L"("..GetStringFromTid(1079309)..L")" -- "Grandmaster"
		elseif (level >= 11) and (level < 12)  then
			titleString = L"("..GetStringFromTid(1079272)..L")" -- "Elder"
		elseif (level >= 12)   then
			titleString = L"("..GetStringFromTid(1079273)..L")" -- "Legendary"
		end		
	end
	
	--Debug.PrintToDebugConsole(L"SkillsWindow.GetSkillTitle():titleString = "..titleString)

	
	return titleString
end -- function SkillsWindow.GetSkillTitle



function SkillsWindow.SkillValueTypeToggleLButtonUp()
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillValueTypeToggleLButtonUp():  ")

	if (SkillsWindow.SkillDataMode == 0) then
		SkillsWindow.SkillDataMode = 1
	else
		SkillsWindow.SkillDataMode = 0
	end
    
    SystemData.Settings.Interface.SkillsWindowShowModified = (SkillsWindow.SkillDataMode == 1)

	SkillsWindow.UpdateSkillValueTypeToggleButtonText()	
	SkillsWindow.ShowTab(data.activeTab)
	
	if( DoesWindowNameExist("SkillsTrackerWindow") ) then
		SkillsTracker.Update()
	end
end -- SkillsWindowHidden.SkillValueTypeToggleLButtonUp

function SkillsWindow.UpdateSkillValueTypeToggleButtonText()
	if (SkillsWindow.SkillDataMode == 0) then
		ButtonSetText( "SkillsWindowSkillValueTypeToggleButton",WindowUtils.GetStringFromTid(1077768) ) -- "Show Modified"
	else
		ButtonSetText( "SkillsWindowSkillValueTypeToggleButton",WindowUtils.GetStringFromTid(1077769) ) -- "Show Real"
	end
end

function SkillsWindow.SkillCapToggleLButtonUp()
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillValueCapToggleLButtonUp():  ")

	if (SkillsWindow.SkillCapMode == 0) then
		SkillsWindow.SkillCapMode = 1
	else
		SkillsWindow.SkillCapMode = 0
	end
    
    SystemData.Settings.Interface.SkillsWindowShowCaps = (SkillsWindow.SkillCapMode == 1)

	SkillsWindow.UpdateSkillCapToggleButtonText()	
	
	SkillsWindow.ShowTab(data.activeTab)
	
	if( DoesWindowNameExist("SkillsTrackerWindow") ) then
		SkillsTracker.Update()
	end
end -- SkillsWindowHidden.SkillValueCapToggleLButtonUp

function SkillsWindow.UpdateSkillCapToggleButtonText()
	--Debug.PrintToDebugConsole(L"SkillsWindow.UpdateSkillCapToggleButtonText():  SkillCapMode = "..StringToWString(tostring(SkillsWindow.SkillCapMode)))

	if (SkillsWindow.SkillCapMode == 0) then
		ButtonSetText( "SkillsWindowSkillCapToggleButton",WindowUtils.GetStringFromTid(1078113) ) -- "Show Caps"
	else
		ButtonSetText( "SkillsWindowSkillCapToggleButton",WindowUtils.GetStringFromTid(1078114) ) -- "Hide Caps"
	end
	SkillsWindow.UpdateTotalSkillPoints()
end

function SkillsWindow.SkillsTrackerToggleLButtonUp()
	if (SkillsWindow.SkillsTrackerMode == 0) then
		SkillsWindow.SkillsTrackerMode = 1
		CreateWindow("SkillsTrackerWindow", true)
	else
		SkillsWindow.SkillsTrackerMode = 0
		DestroyWindow("SkillsTrackerWindow")
	end
	CustomSettings.SaveBoolean( "ShowTracker" , SkillsWindow.SkillsTrackerMode == 1 )
	SkillsWindow.UpdateSkillsTrackerToggleButtonText()	
end

function SkillsWindow.UpdateSkillsTrackerToggleButtonText()
	if (SkillsWindow.SkillsTrackerMode == 0) then
		ButtonSetText( "SkillsWindowSkillsTrackerToggleButton",WindowUtils.GetStringFromTid(1111937) ) -- "Show Tracker"
	else
		ButtonSetText( "SkillsWindowSkillsTrackerToggleButton",WindowUtils.GetStringFromTid(1111938) ) -- "Hide Tracker"
	end
end



function SkillsWindow.CheckSkillForUpdate(skill)

	if oldSkillValues[skill] ~= nil and WindowData.SkillDynamicData[skill] ~= nil then

		local oldSkillValue = oldSkillValues[skill]
		local newSkillValue = WindowData.SkillDynamicData[skill].RealSkillValue
		local skillId = WindowData.SkillList[skill].CSVId
		local serverId = WindowData.SkillsCSV[skillId].ServerId
		if not SkillsWindow.SessionGains[skill] then
			SkillsWindow.SessionGains[skill] = 0
		end
		if (EnhancePack and EnhancePack.SkillTargetVals[skillId]) then
			if (newSkillValue > EnhancePack.SkillTargetVals[skillId] and WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState ~= 1) then
				WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = 1
				ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
				ReturnWindowData.SkillSystem.SkillButtonState = 2
				BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
				local skillName = WindowData.SkillList[skill].skillName
			end
			
			if (newSkillValue == EnhancePack.SkillTargetVals[skillId] and WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState ~= 2) then
				WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = 2
				ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
				ReturnWindowData.SkillSystem.SkillButtonState = 2
				BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
				local skillName = WindowData.SkillList[skill].skillName
			end
			SkillsWindow.ShowTab(data.activeTab)
		end

		if oldSkillValue > newSkillValue then
			local skillValueDiff = SkillsWindow.FormatSkillValue(oldSkillValue - newSkillValue)..L"%"
			SkillsWindow.SessionGains[skill] = StringToWString(string.format("%3.1f", SkillsWindow.SessionGains[skill] - skillValueDiff) ) .. L"%"
			
			local skillName = WindowData.SkillList[skill].skillName
			local text = ReplaceTokens(GetStringFromTid(TID_SKILLDECREASE_TOK), {skillName, skillValueDiff, SkillsWindow.FormatSkillValue(newSkillValue)..L"%"}) .. L" (" .. SkillsWindow.SessionGains[skill] .. L")"
			if (EnhancePack.UseNewChat) then
				local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = EnhancePack.SpecialColor, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", EnhancePack.Clock.h) .. ":" .. string.format("%02.f", EnhancePack.Clock.m) .. ":" .. string.format("%02.f", EnhancePack.Clock.s))}
				table.insert(NewChatWindow.Messages, logVal)
				NewChatWindow.UpdateLog()
			else
				PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
			end
			
			if WindowGetShowing("CraftingToolWindow") and CraftingTool.SearchOptions["showSkillsAvailable"] then
				CraftingTool.UpdateCombo()
			end
			if skill == 35 then
				TargetWindow.UpdateButtons()
			end
			return 1
		end

		if oldSkillValue < newSkillValue then
			local skillValueDiff = SkillsWindow.FormatSkillValue(newSkillValue - oldSkillValue)..L"%"
			SkillsWindow.SessionGains[skill] = StringToWString(string.format("%3.1f", SkillsWindow.SessionGains[skill] + skillValueDiff)) .. L"%"
			local skillName = WindowData.SkillList[skill].skillName
			local text = ReplaceTokens(GetStringFromTid(TID_SKILLINCREASE_TOK), {skillName, skillValueDiff, SkillsWindow.FormatSkillValue(newSkillValue)..L"%"}) .. L" (" .. SkillsWindow.SessionGains[skill] .. L")"
			
			if UserData.Settings.Login.lastShardSelected == 12 or UserData.Settings.Login.lastShardSelected == 18 then --12 SIEGE   18 mugen
				if newSkillValue < 700 then
					SkillsWindow.ROT[skillId] = nil
				elseif newSkillValue < 800 then
					SkillsWindow.ROT[skillId] = EnhancePack.TimeSinceLogin + 300
				elseif newSkillValue < 900 then
					SkillsWindow.ROT[skillId] = EnhancePack.TimeSinceLogin + 480	
				elseif newSkillValue < 1000 then
					SkillsWindow.ROT[skillId] = EnhancePack.TimeSinceLogin + 720
				elseif newSkillValue < 1200 then
					SkillsWindow.ROT[skillId] = EnhancePack.TimeSinceLogin + 900
				else
					SkillsWindow.ROT[skillId] = nil
				end
			end
			
			if (EnhancePack.UseNewChat) then
				local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = EnhancePack.SpecialColor, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", EnhancePack.Clock.h) .. ":" .. string.format("%02.f", EnhancePack.Clock.m) .. ":" .. string.format("%02.f", EnhancePack.Clock.s))}
				table.insert(NewChatWindow.Messages, logVal)
				NewChatWindow.UpdateLog()
			else
				PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
			end
			
			if WindowGetShowing("CraftingToolWindow") and CraftingTool.SearchOptions["showSkillsAvailable"] then
				CraftingTool.UpdateCombo()
			end
			if skill == 35 then
				TargetWindow.UpdateButtons()
			end
			return 1
		end
	else
			SkillsWindow.SaveCurrentSkillValue(skill)
	end
	return 0
end

function SkillsWindow.CheckAllSkillsForUpdate()
	if hasSkillValues then
		for i, tab in ipairs(tabContents) do
			for i, skill in ipairs(tab) do
				SkillsWindow.CheckSkillForUpdate(WindowData.SkillsCSV[skill].ServerId)
			end
		end
	end
end

function SkillsWindow.SaveCurrentSkillValue(skill)
	oldSkillValues[skill] = WindowData.SkillDynamicData[skill].RealSkillValue
end

function SkillsWindow.SaveCurrentSkillValues()

	hasSkillValues = true
	for i, tab in ipairs(tabContents) do
		for i, skill in ipairs(tab) do
			SkillsWindow.SaveCurrentSkillValue(WindowData.SkillsCSV[skill].ServerId)
		end
	end
end

function SkillsWindow.ContextMenuCallback(returnCode,param)
	if( param ~= nil ) then
		if( returnCode == SkillsWindow.ContextReturnCodes.REMOVE_CUSTOM ) then
			local newTabContents = {}
			local newIndex = 1
			for index, item in pairs(tabContents[SkillsWindow.CUSTOM_TAB_NUM]) do
				if( item ~= param ) then
					newTabContents[newIndex] = item
					newIndex = newIndex + 1
				end
			end
			SystemData.Settings.Interface.CustomSkills = newTabContents
			tabContents[SkillsWindow.CUSTOM_TAB_NUM] = SystemData.Settings.Interface.CustomSkills
			SkillsWindow.ShowTab(SkillsWindow.CUSTOM_TAB_NUM)
			if( DoesWindowNameExist("SkillsTrackerWindow") ) then
				SkillsTracker.Update()
			end
		elseif( returnCode == SkillsWindow.ContextReturnCodes.ADD_TO_CUSTOM ) then
			local found = false
			for index, item in pairs(tabContents[SkillsWindow.CUSTOM_TAB_NUM]) do
				if( item == param ) then
					found = true
				end
			end
			if( found == false ) then
				local nextSlot = table.getn(tabContents[SkillsWindow.CUSTOM_TAB_NUM]) + 1		
				tabContents[SkillsWindow.CUSTOM_TAB_NUM][nextSlot] = param
			end
			if( DoesWindowNameExist("SkillsTrackerWindow") ) then
				SkillsTracker.Update()
			end
		elseif( returnCode == "ClearAutolock" ) then
			EnhancePack.SkillTargetVals[param] = nil
			CustomSettings.DeleteSetting( "EnhancePack.SkillTargetVals_"..param )
			SkillsWindow.ShowTab(data.activeTab)
		elseif( returnCode == "SetAutolock" ) then
		
			local serverId = WindowData.SkillsCSV[param].ServerId
			local max = WindowData.SkillDynamicData[serverId].SkillCap / 10
			local rdata = {title=GetStringFromTid(WindowData.SkillsCSV[param].NameTid), subtitle=UI.GetCliloc(SystemData.Settings.Language.type, 665) .. L"0 - " .. max, callfunction=SkillsWindow.SetAutoLock, min = 0, max = max, id=param}
			RenameWindow.Create(rdata)
		end 
	end
end

function SkillsWindow.SetAutoLock(id, value, max, min)
	if ( tonumber(value)  ~= nil) then
		
		if tonumber(value) < min then
			value = min
		end
		if tonumber(value) > max then
			value = max
		end
		EnhancePack.SkillTargetVals[id] = tonumber(value) * 10
		CustomSettings.SaveNumber("EnhancePack.SkillTargetVals_"..id, tonumber(value) * 10)
		
		
		if (WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].RealSkillValue > tonumber(value) * 10 ) then
			WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].SkillState = 1
			ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[id].ServerId
			ReturnWindowData.SkillSystem.SkillButtonState = 2
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
		end
	
		if (WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].RealSkillValue == tonumber(value) * 10 ) then
			WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].SkillState = 2
			ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[id].ServerId
			ReturnWindowData.SkillSystem.SkillButtonState = 2
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
		end
		
		if (WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].RealSkillValue < tonumber(value) * 10 ) then
			WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].SkillState = 0
			ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[id].ServerId
			ReturnWindowData.SkillSystem.SkillButtonState = 0
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
		end
		SkillsWindow.ShowTab(data.activeTab)
	end
end

function SkillsWindow.SkillRButtonUp()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local param = tabContents[data.activeTab][buttonNum]
	if (EnhancePack.SkillTargetVals[param] and EnhancePack.SkillTargetVals[param] > 0) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 783),0,"ClearAutolock",param,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 782),0,"SetAutolock",param,false)
	end
	
	if( data.activeTab == SkillsWindow.CUSTOM_TAB_NUM ) then
		ContextMenu.CreateLuaContextMenuItem(SkillsWindow.TID_REMOVE_CUSTOM,0,SkillsWindow.ContextReturnCodes.REMOVE_CUSTOM,param)		
	else
		local flags = 0
		-- check to see if we can add it
		if( table.getn(tabContents[SkillsWindow.CUSTOM_TAB_NUM]) == SkillsWindow.NUM_SKILLS_PER_TAB ) then
			flags = ContextMenu.GREYEDOUT
		end
		
		ContextMenu.CreateLuaContextMenuItem(SkillsWindow.TID_ADD_TO_CUSTOM,flags,SkillsWindow.ContextReturnCodes.ADD_TO_CUSTOM,param)		
	end
	
	ContextMenu.ActivateLuaContextMenu(SkillsWindow.ContextMenuCallback)
end

function SkillsWindow.ToggleHelpButton()
	tab = data.activeTab
	buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	activeContent = tabContents[tab]
	skillId = activeContent[buttonNum]
	
	SkillsInfo.DisplayId = skillId
	SkillsInfo.UpdateGump(skillId)
	--Debug.PrintToDebugConsole(L"Ids: "..buttonNum..L", "..skillId)

	WindowSetShowing("SkillsInfo", true)
end

function SkillsWindow.MoreInfoOnMouseOver()
	local btnName = SystemData.ActiveWindow.name
	local text = GetStringFromTid(1115246) -- "More Info"
	
	Tooltips.CreateTextOnlyTooltip(btnName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function SkillsWindow.OnShown()
    ButtonSetPressedFlag("MenuBarWindowToggleSkills",false)
end

function SkillsWindow.OnHidden()
    ButtonSetPressedFlag("MenuBarWindowToggleSkills",false)
end
