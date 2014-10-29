----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

NewChatOptionsWindow = {}

NewChatOptionsWindow.HasTitle = false

NewChatOptionsWindow.TID = { Accept=1013076,CustomColor=1111675,Red=1018351,Green=1079391,Blue=1111676,
                          TextColorHelp=1111677,TextColors=1111678,}

NewChatOptionsWindow.channelListData = {}
NewChatOptionsWindow.channelListOrder = {}

NewChatOptionsWindow.SelectedMessageTypeIndex = 0
NewChatOptionsWindow.SelectedMessageTypeWindowIndex = 0

NewChatOptionsWindow.channelListCurrentStatus = {}
local wndIndex = 0
local channelChanging = false
local function InitChatOptionListData()
    NewChatOptionsWindow.channelListData = {}
    local channelIndex = 0
    for channel, channelData in pairs(ChatSettings.Channels) do
        if (channelData ~= nil and channelData.name ~= nil) then
            channelIndex = channelIndex + 1
            NewChatOptionsWindow.channelListData[channelIndex] = {
                    channelName = channelData.name,
                    color = ChatSettings.ChannelColors[channel],
                    logName = channelData.logName,
                    channelID = channelData.id,
                }
            
            NewChatOptionsWindow.channelListCurrentStatus[channelIndex] = {
                hasChanged = false,
            }
            
        end
    end
     local hueR,hueG,hueB = HueRGBAValue(SystemData.Settings.Interface.SpeechHue)
    NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SpeechHueIndex] = {
                    channelName = L"Your Speech",
                    color = {r=hueR,g=hueG,b=hueB},
                    logName = nil,
                    channelID = nil,
    }
    NewChatOptionsWindow.channelListCurrentStatus[NewChatOptionsWindow.SpeechHueIndex] = {
        hasChanged = false,
    }  
    
    local channelData = ChatSettings.Channels[SystemData.ChatLogFilters.GM]
    NewChatOptionsWindow.channelListData[13] = {
                    channelName = channelData.name,
                    color = ChatSettings.ChannelColors[SystemData.ChatLogFilters.GM],
                    logName = channelData.logName,
                    channelID = SystemData.ChatLogFilters.GM,
                }
            
            NewChatOptionsWindow.channelListCurrentStatus[13] = {
                hasChanged = false,
            }
            
    
                 
end

local function CompareColors( colorTable1, colorTable2 )
    if (colorTable1 == nil or colorTable2 == nil)
    then
        return
    end
    if (colorTable1.r == colorTable2.r and colorTable1.g == colorTable2.g and colorTable1.b == colorTable2.b)
    then
        return true
    else
        return false
    end
end

local function FilterChannelList()

    NewChatOptionsWindow.channelListOrder = {}
    wndIndex = ChatWindow.activeWindow
    local r,g,b
    local dataIndex = 0
    for idx, info in ipairs (ChatSettings.Channels) do
       dataIndex = dataIndex + 1
                table.insert(NewChatOptionsWindow.channelListOrder, dataIndex)
                NewChatOptionsWindow.channelListData[dataIndex].color.r = ChatSettings.ChannelColors[info.id].r
                NewChatOptionsWindow.channelListData[dataIndex].color.g = ChatSettings.ChannelColors[info.id].g
                NewChatOptionsWindow.channelListData[dataIndex].color.b = ChatSettings.ChannelColors[info.id].b
                
                if (idx < ChatFiltersWindowList.numVisibleRows)
                then
                    -- Only fill the table with the number of labels actually visible
                    labelName = "NewChatOptionsWindowListRow"..idx.."ChannelName"
                    LabelSetTextColor(labelName, 
                              NewChatOptionsWindow.channelListData[dataIndex].color.r, 
                              NewChatOptionsWindow.channelListData[dataIndex].color.g,
                              NewChatOptionsWindow.channelListData[dataIndex].color.b)
                end
                

    end
         -- do the special case for your speech
    table.insert(NewChatOptionsWindow.channelListOrder, NewChatOptionsWindow.SpeechHueIndex)
    labelName = "NewChatOptionsWindowListRow"..NewChatOptionsWindow.SpeechHueIndex.."ChannelName"
    local hueR,hueG,hueB = HueRGBAValue(SystemData.Settings.Interface.SpeechHue)
    LabelSetTextColor(labelName, 
              hueR, 
              hueG,
              hueB) 
              

    local info =ChatSettings.Channels[SystemData.ChatLogFilters.GM]
    table.insert(NewChatOptionsWindow.channelListOrder, 13)
    NewChatOptionsWindow.channelListData[13].color.r = ChatSettings.ChannelColors[info.id].r
    NewChatOptionsWindow.channelListData[13].color.g = ChatSettings.ChannelColors[info.id].g
    NewChatOptionsWindow.channelListData[13].color.b = ChatSettings.ChannelColors[info.id].b

    -- Only fill the table with the number of labels actually visible
    labelName = "NewChatOptionsWindowListRow13ChannelName"
    LabelSetTextColor(labelName, 
		NewChatOptionsWindow.channelListData[13].color.r, 
		NewChatOptionsWindow.channelListData[13].color.g,
		NewChatOptionsWindow.channelListData[13].color.b)

    
      
end

local function ResetChannelList()
    -- Filter, Sort, and Update
    InitChatOptionListData()
    FilterChannelList()
    ListBoxSetDisplayOrder( "NewChatOptionsWindowList", NewChatOptionsWindow.channelListOrder )
    
    -- Reset variables
    NewChatOptionsWindow.SelectedMessageTypeIndex = 0
    NewChatOptionsWindow.SelectedMessageTypeWindowIndex = 0
end

-- OnInitialize Handler
function NewChatOptionsWindow.Initialize()
    LabelSetText( "NewChatOptionsWindowCustomColorText", GetStringFromTid(NewChatOptionsWindow.TID.CustomColor) )
    LabelSetText( "NewChatOptionsWindowCustomColorRedText", GetStringFromTid(NewChatOptionsWindow.TID.Red) )
    LabelSetText( "NewChatOptionsWindowCustomColorGreenText", GetStringFromTid(NewChatOptionsWindow.TID.Green) )
    LabelSetText( "NewChatOptionsWindowCustomColorBlueText", GetStringFromTid(NewChatOptionsWindow.TID.Blue) )
    LabelSetText( "NewChatOptionsWindowHelpHeaderText", GetStringFromTid(NewChatOptionsWindow.TID.TextColorHelp) )
    ButtonSetText( "NewChatOptionsWindowAcceptButton", GetStringFromTid(NewChatOptionsWindow.TID.Accept) ) 
    WindowSetShowing("NewChatOptionsWindowColorSelectionRing", false)
    WindowSetShowing("NewChatOptionsWindowChannelSelection", false)
    ColorPickerCreateWithColorTable("NewChatOptionsWindowColorPicker", ChatSettings.Colors, 4, 10, 10)
    NewChatOptionsWindow.SelectedMessageTypeIndex = 0
    NewChatOptionsWindow.SelectedMessageTypeWindowIndex = 0
    
    NewChatOptionsWindow.SpeechHueIndex = 12
    
    if (not NewChatOptionsWindow.HasTitle) then
		WindowUtils.SetWindowTitle("NewChatOptionsWindow", GetStringFromTid(NewChatOptionsWindow.TID.TextColors) )
		NewChatOptionsWindow.HasTitle = true
	end
	
    WindowSetShowing( "NewChatOptionsWindow", false )
end

function NewChatOptionsWindow.Shutdown()
	WindowSetShowing( "NewChatOptionsWindow", false )
end

function NewChatOptionsWindow.Hide()
    WindowSetShowing("NewChatOptionsWindowColorSelectionRing", false)
    WindowSetShowing("NewChatOptionsWindowChannelSelection", false)
    WindowSetShowing( "NewChatOptionsWindow", false )
  
end
function NewChatOptionsWindow.ClearSelectionImage()
    WindowSetShowing("NewChatOptionsWindowChannelSelection", false)
end
function NewChatOptionsWindow.OnShown()
    ResetChannelList()
    NewChatOptionsWindow.UpdateChatOptionRow()
    
end

function NewChatOptionsWindow.OnHidden()
end

-- Callback from the <List> that updates a single row.
function NewChatOptionsWindow.UpdateChatOptionRow()
    if (NewChatOptionsWindowList.PopulatorIndices ~= nil) then
        local active = false
        local labelName
        local tab = ChatWindow.GetMenuTab()
        for rowIndex, dataIndex in ipairs(NewChatOptionsWindowList.PopulatorIndices) do
			local r = 0
			local g = 0
			local b = 0
			labelName = "NewChatOptionsWindowListRow"..rowIndex.."ChannelName"
			if( rowIndex == NewChatOptionsWindow.SpeechHueIndex ) then
				r,g,b = HueRGBAValue(SystemData.Settings.Interface.SpeechHue)
			elseif (NewChatOptionsWindow.channelListData[dataIndex].channelID) then
				r =	ChatSettings.ChannelColors[NewChatOptionsWindow.channelListData[dataIndex].channelID].r
				g =	ChatSettings.ChannelColors[NewChatOptionsWindow.channelListData[dataIndex].channelID].g
				b =	ChatSettings.ChannelColors[NewChatOptionsWindow.channelListData[dataIndex].channelID].b
			end

			LabelSetTextColor(labelName, 
				  r, 
				  g,
				  b)
        end
    end
end

function NewChatOptionsWindow.OnLButtonUpChannelLabel()

    local windowIndex = WindowGetId (SystemData.ActiveWindow.name)
    local windowParent = WindowGetParent (SystemData.ActiveWindow.name)
    local dataIndex = ListBoxGetDataIndex (WindowGetParent (windowParent), windowIndex)

    local targetRowWindow = "NewChatOptionsWindowListRow"..windowIndex
    
    if (NewChatOptionsWindow.SelectedMessageTypeWindowIndex ~= windowIndex) then
        NewChatOptionsWindow.SelectedMessageTypeWindowIndex = windowIndex
        NewChatOptionsWindow.SelectedMessageTypeIndex = dataIndex
        WindowSetShowing("NewChatOptionsWindowChannelSelection", true)
        WindowClearAnchors("NewChatOptionsWindowChannelSelection")
        WindowAddAnchor( "NewChatOptionsWindowChannelSelection", "topleft", "NewChatOptionsWindowListRow"..windowIndex, "topleft", -5, 2 )
        WindowAddAnchor( "NewChatOptionsWindowChannelSelection", "bottomright", "NewChatOptionsWindowListRow"..windowIndex, "bottomright", -20, 0 )
    end
    
    local x, y = ColorPickerGetCoordinatesForColor("NewChatOptionsWindowColorPicker", NewChatOptionsWindow.channelListData[dataIndex].color.r,
                                                                                   NewChatOptionsWindow.channelListData[dataIndex].color.g,
                                                                                   NewChatOptionsWindow.channelListData[dataIndex].color.b)
    
    if (x ~= nil and y ~= nil)
    then
        WindowSetShowing("NewChatOptionsWindowColorSelectionRing", true)
        WindowClearAnchors("NewChatOptionsWindowColorSelectionRing")
        WindowAddAnchor( "NewChatOptionsWindowColorSelectionRing", "topleft", "NewChatOptionsWindowColorPicker", "topleft", x-5, y-5 ) 
    else
        WindowSetShowing("NewChatOptionsWindowColorSelectionRing", false)
    end
    
    -- Set the sliders
    local color = NewChatOptionsWindow.channelListData[dataIndex].color
    channelChanging = true
    local colorRatio = color.r / 255
    SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorRedSlider", colorRatio )
    colorRatio = color.g / 255
    SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorGreenSlider", colorRatio )
    colorRatio = color.b / 255
    SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorBlueSlider", colorRatio )
    -- We've completed the slider updates, it is now safe for the user to make their custom color.
    channelChanging = false
    
    WindowSetTintColor("NewChatOptionsWindowCustomColorSwatch", NewChatOptionsWindow.channelListData[dataIndex].color.r,
                                                       NewChatOptionsWindow.channelListData[dataIndex].color.g,
                                                       NewChatOptionsWindow.channelListData[dataIndex].color.b)
    
    
    
end

function NewChatOptionsWindow.OnLButtonUpColorPicker( flags, x, y )
    if (NewChatOptionsWindow.SelectedMessageTypeIndex == nil or NewChatOptionsWindow.SelectedMessageTypeIndex == 0)
    then
        -- No chosen filter, please exit
        return true
    end
    local color = ColorPickerGetColorAtPoint( "NewChatOptionsWindowColorPicker", x, y )
    local dataIndex = NewChatOptionsWindow.SelectedMessageTypeIndex
    local currentColor = NewChatOptionsWindow.channelListData[dataIndex].color
    local colorRatio = 0
    -- We have a valid color
    if (color ~= nil)
    then
        LabelSetTextColor("NewChatOptionsWindowListRow"..NewChatOptionsWindow.SelectedMessageTypeWindowIndex.."ChannelName", 
                          color.r, 
                          color.g,
                          color.b)
        -- Set the sliders
        colorRatio = color.r / 255
        SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorRedSlider", colorRatio )
        colorRatio = color.g / 255
        SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorGreenSlider", colorRatio )
        colorRatio = color.b / 255
        SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorBlueSlider", colorRatio )
        
        WindowSetTintColor("NewChatOptionsWindowCustomColorSwatch", color.r,
                                                   color.g,
                                                   color.b)
        -- Update the position of the color ring
        WindowSetShowing("NewChatOptionsWindowColorSelectionRing", true)
        WindowClearAnchors("NewChatOptionsWindowColorSelectionRing")
        WindowAddAnchor( "NewChatOptionsWindowColorSelectionRing", "topleft", "NewChatOptionsWindowColorPicker", "topleft", color.x-5, color.y-5 )
        
        -- Update the color, and the save flag
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.r = color.r
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.g = color.g
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.b = color.b
        NewChatOptionsWindow.channelListCurrentStatus[NewChatOptionsWindow.SelectedMessageTypeIndex].hasChanged = true
    end
end

function NewChatOptionsWindow.OnSetCustomColor()
    
    if (NewChatOptionsWindow.SelectedMessageTypeIndex == nil or NewChatOptionsWindow.SelectedMessageTypeIndex == 0)
    then
        -- No channel picked
        return
    end
    local colorRatio = 0
    local color = {
        r = 0,
        b = 0,
        g = 0,
    }
    colorRatio = SliderBarGetCurrentPosition("NewChatOptionsWindowCustomColorRedSlider")
    color.r = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("NewChatOptionsWindowCustomColorGreenSlider")
    color.g = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("NewChatOptionsWindowCustomColorBlueSlider")
    color.b = colorRatio * 255
    
    -- Update the color swatch
    WindowSetTintColor("NewChatOptionsWindowCustomColorSwatch", color.r,
                                                       color.g,
                                                       color.b)
                                                       
    if (channelChanging == false)
    then
        LabelSetTextColor("NewChatOptionsWindowListRow"..NewChatOptionsWindow.SelectedMessageTypeWindowIndex.."ChannelName", 
                                  color.r, 
                                  color.g,
                                  color.b)
        -- Update the color, and the save flag
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.r = color.r
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.g = color.g
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.b = color.b
        NewChatOptionsWindow.channelListCurrentStatus[NewChatOptionsWindow.SelectedMessageTypeIndex].hasChanged = true
    end
end

function NewChatOptionsWindow.SetAllColorChanges()
    for idx=1, #NewChatOptionsWindow.channelListCurrentStatus do
        if (NewChatOptionsWindow.channelListCurrentStatus[idx].hasChanged == true)
        then
            -- Set the new color, and Reset the flag
            NewChatOptionsWindow.SetChannelColor(idx)
            NewChatOptionsWindow.channelListCurrentStatus[idx].hasChanged = false
        end
    end
    -- Update the channel Selection window with the new colors
    ChatWindow.UpdateAllChannelColors()
    -- Hide all components
    WindowSetShowing("NewChatOptionsWindowColorSelectionRing", false)
    WindowSetShowing("NewChatOptionsWindowChannelSelection", false)
    WindowSetShowing("NewChatOptionsWindow", false)
    NewChatWindow.ClearAll()
	NewChatWindow.UpdateLog()
end

function NewChatOptionsWindow.SetChannelColor( channelIndex )
    local newColor = NewChatOptionsWindow.channelListData[ channelIndex ].color
	if( channelIndex == NewChatOptionsWindow.SpeechHueIndex ) then
		SystemData.Settings.Interface.SpeechHue = GetHueFromRGB(newColor.r, newColor.g, newColor.b)
		-- push the new values to c++
		UserSettingsChanged()
	else
		local channelId = NewChatOptionsWindow.channelListData[ channelIndex ].channelID
		ChatSettings.ChannelColors[ channelId ] = newColor
		-- Loop through all the tabs and change the chat channel color for it.
		for idxW, wnd in pairs(ChatWindow.Windows) do
			for idxT, tab in pairs(wnd.Tabs) do
				LogDisplaySetFilterColor(tab.tabWindow,
										 NewChatOptionsWindow.channelListData[channelIndex].logName,
										 channelId, 
										 newColor.r, newColor.g, newColor.b ) 
			end
		end
	end
end
