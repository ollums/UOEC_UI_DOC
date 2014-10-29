----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

FontSelector = {}

local function Font( iname, iid, idefault, ishownName )
    local newChannel = 
    {
        fontName         = iname,
        id           = iid,
        isDefault    = idefault,
        shownName    = ishownName,
    };

    return newChannel;
end

FontSelector.Selection = ""

FontSelector.RunicFontItem = ""

 FontSelector.Fonts = {}
    --                               name of font     id  default  name to be shown
    FontSelector.Fonts[1] = Font( "UO_Overhead_Chat", 1, false, "Default" )
	FontSelector.Fonts[2] = Font( "avatar", 1, false, "Avatar" )
	FontSelector.Fonts[3] = Font( "avatar_bold", 1, false, "Avatar Bold" )
	FontSelector.Fonts[4] = Font( "chiller", 1, false, "Chiller" )
	FontSelector.Fonts[5] = Font( "comics", 1, false, "Comic Sans" )
	FontSelector.Fonts[6] = Font( "comics_bold", 1, false, "Comic Sans Bold" )
	FontSelector.Fonts[7] = Font( "diablo", 1, false, "Diablo" )
	FontSelector.Fonts[8] = Font( "gothic", 1, false, "Gothic Ultra Trendy" )
	FontSelector.Fonts[9] = Font( "handwriting", 1, false, "Handwriting" )
	FontSelector.Fonts[10] = Font( "magic_school", 1, false, "Magic School" )
	FontSelector.Fonts[11] = Font( "magic", 1, false, "Magic The Gathering" )
	FontSelector.Fonts[12] = Font( "runic", 1, false, "Runes" )
	FontSelector.Fonts[13] = Font( "gargrunic", 1, false, "Gargish Runes" )
	FontSelector.Fonts[14] = Font( "samurai", 1, false, "Samurai" )
	FontSelector.Fonts[15] = Font( "times", 1, false, "Times New Roman" )
	FontSelector.Fonts[16]= Font( "times_bold", 1, false, "Times New Roman Bold" )
	FontSelector.Fonts[17]= Font( "UO", 1, false, "Ultima Online Classic" )
	FontSelector.Fonts[18] = Font( "font_verdana_shadow_med2", 1, false, "Verdana" )
	FontSelector.Fonts[19] = Font( "font_verdana_bold_shadow_med2", 1, false, "Verdana Bold" )
	FontSelector.Fonts[20] = Font( "font_verdana_italic_shadow_med2", 1, false, "Verdana Italic" )
	
	FontSelector.Fonts[21] = Font( "murder", 1, false, "You Murder" )
	FontSelector.Fonts[22] = Font( "UO_NeueText", 1, false, "Neue Text" )
	FontSelector.Fonts[23] = Font( "UO_DefaultText", 1, false, "Myriad" )
	


-- OnInitialize Handler
function FontSelector.Initialize()

    
    --WindowSetScale("FontSelector", 1.28)
    Interface.DestroyWindowOnClose["FontSelector"] = true
    
    
    local size = #FontSelector.Fonts
    for idx=1, size do

		local itemWindow = "FontSelectorItem"..idx
		if DoesWindowNameExist( itemWindow) then
			DestroyWindow(itemWindow)
		end
		CreateWindowFromTemplate (itemWindow, "FontRowTemplate", "FontSelector")
		LabelSetFont( itemWindow.."Label", FontSelector.Fonts[idx].fontName, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
		LabelSetText( itemWindow.."Label", StringToWString(FontSelector.Fonts[idx].shownName) )
		local x, y = WindowGetDimensions(itemWindow.."Label")
		if (FontSelector.Fonts[idx].fontName == "gothic") then
			y = y - 20
		end
		
		if (FontSelector.Fonts[idx].fontName == "magic_school") then
			y = y + 10
		end
		WindowSetDimensions(itemWindow, x, y)
		WindowSetId(itemWindow, idx)
		WindowClearAnchors(itemWindow)
		
		WindowSetShowing(itemWindow.."Check", false)
		
		local attachIndex = idx -1
		if (FontSelector.Fonts[idx].fontName == "runic" ) then
			FontSelector.RunicFontItem = itemWindow
		end
		
		if (FontSelector.Fonts[idx].fontName == "gargrunic" ) then

				attachIndex = idx - 2

		end
		
	    	    
	    if (attachIndex<=0) then
			attachIndex = 1
	    end
	    
		if( idx == 1 ) then
			WindowAddAnchor( itemWindow, "topleft", "FontSelector", "topleft", 20, 40 )
		else
			WindowAddAnchor( itemWindow, "bottomleft", "FontSelectorItem"..attachIndex, "topleft", 0, 7 )			
		end
    
   end
   
end

function FontSelector.OnShown()
	local selectedIdx = 1
    if (FontSelector.Selection == "chat") then
		selectedIdx = OverheadText.FontIndex 
	elseif (FontSelector.Selection == "names") then
		selectedIdx = OverheadText.NameFontIndex
	elseif (FontSelector.Selection == "spells") then
		selectedIdx = OverheadText.SpellsFontIndex 
	elseif (FontSelector.Selection == "damage") then
		selectedIdx = OverheadText.DamageFontIndex
	elseif (string.find(FontSelector.Selection, "journal")) then
		local id = string.gsub(FontSelector.Selection, "journal", "")
		id = tonumber(id)
		selectedIdx = NewChatWindow.ChannelsFonts[ id ]
	end

	local size = #FontSelector.Fonts
    for idx=1, size do
		local itemWindow = "FontSelectorItem"..idx
		if (selectedIdx == idx) then
			WindowSetShowing(itemWindow.."Check", true)
			WindowClearAnchors(itemWindow.."Check")
			WindowForceProcessAnchors(itemWindow.."Check")
			WindowAddAnchor( itemWindow.."Check", "left", itemWindow.."Label", "center", -17, 0 )
		else
			WindowSetShowing(itemWindow.."Check", false)
		end
	end	
end

function FontSelector.Shutdown()
    DestroyWindow("FontSelector")
end

function FontSelector.SetFontToSelection()

	if (FontSelector.Selection == "chat") then
		OverheadText.FontIndex = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("OverheadTextFontIndex", OverheadText.FontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "names") then
		OverheadText.NameFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("OverheadTextNameFontIndex", OverheadText.NameFontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "spells") then
		OverheadText.SpellsFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("OverheadTextSpellsFontIndex", OverheadText.SpellsFontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "damage") then
		OverheadText.DamageFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("OverheadTextDamageFontIndex", OverheadText.DamageFontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (string.find(FontSelector.Selection, "journal")) then
		local id = string.gsub(FontSelector.Selection, "journal", "")
		id = tonumber(id)
		NewChatWindow.ChannelsFonts[ id ] = WindowGetId(SystemData.ActiveWindow.name)
		CustomSettings.SaveNumber("ChannelsFonts" .. id, NewChatWindow.ChannelsFonts[ id ])
		NewChatWindow.ClearAll()
		NewChatWindow.UpdateLog()
		WindowSetShowing("FontSelector", false)
	end
end

function FontSelector.CloseFontWindow()
	WindowSetShowing("FontSelector", false)
end

function FontSelector.ItemMouseOver()
	local fontIndex = WindowGetId(SystemData.ActiveWindow.name)
	local itemWindow = "FontSelectorItem"..fontIndex
	
	LabelSetTextColor(itemWindow.."Label",243,227,49)
end

function FontSelector.ClearMouseOverItem()
	local fontIndex = WindowGetId(SystemData.ActiveWindow.name)
	local itemWindow = "FontSelectorItem"..fontIndex
	
	LabelSetTextColor(itemWindow.."Label",255,255,255)
end