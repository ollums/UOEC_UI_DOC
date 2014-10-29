
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MobilesOnScreen = {}
MobilesOnScreen.IsInTable = {}
MobilesOnScreen.MobilesSort = {}
MobilesOnScreen.MobilesSortReverse = {}
MobilesOnScreen.NeedsUpdate = false

MobilesOnScreen.DeltaClean = 0

MobilesOnScreen.STRFilter = ""

MobilesOnScreen.DistanceSort = false

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
MobilesOnScreen.Mobiles = {}

MobilesOnScreen.BarsY = 55
MobilesOnScreen.BarScale = 1 
MobilesOnScreen.windowOffset = 0

MobilesOnScreen.Hidden = false
MobilesOnScreen.Filter = {}
MobilesOnScreen.Filter[1] = UI.GetCliloc(SystemData.Settings.Language.type, 337)
MobilesOnScreen.Filter[2] = UI.GetCliloc(SystemData.Settings.Language.type, 338)
MobilesOnScreen.Filter[3] =  UI.GetCliloc(SystemData.Settings.Language.type, 339)
MobilesOnScreen.Filter[4] =  UI.GetCliloc(SystemData.Settings.Language.type, 340)
MobilesOnScreen.Filter[5] = UI.GetCliloc(SystemData.Settings.Language.type, 341)
MobilesOnScreen.Filter[6] = UI.GetCliloc(SystemData.Settings.Language.type, 342)
MobilesOnScreen.Filter[7] = UI.GetCliloc(SystemData.Settings.Language.type, 343)
MobilesOnScreen.Filter[8] = UI.GetCliloc(SystemData.Settings.Language.type, 344)
MobilesOnScreen.Filter[9] = UI.GetCliloc(SystemData.Settings.Language.type, 345)
MobilesOnScreen.Filter[10] = UI.GetCliloc(SystemData.Settings.Language.type, 346)
MobilesOnScreen.SavedFilter = {}

MobilesOnScreen.PetUpdateTime = 0
MobilesOnScreen.PetUpdateFreq = 1
MobilesOnScreen.ReversePet = {}

MobilesOnScreen.YellowEnabled = false
MobilesOnScreen.GreyEnabled = false
MobilesOnScreen.BlueEnabled = false
MobilesOnScreen.RedEnabled = false
MobilesOnScreen.GreenEnabled = false
MobilesOnScreen.OrangeEnabled = false

MobilesOnScreen.UnsortedLimit = 10
MobilesOnScreen.YellowLimit = 10
MobilesOnScreen.GreyLimit = 10
MobilesOnScreen.BlueLimit = 10
MobilesOnScreen.RedLimit = 10
MobilesOnScreen.GreenLimit = 10
MobilesOnScreen.OrangeLimit = 10

MobilesOnScreen.UnsortedWindows = 0
MobilesOnScreen.YellowWindows = 0
MobilesOnScreen.GreyWindows = 0
MobilesOnScreen.BlueWindows = 0
MobilesOnScreen.RedWindows = 0
MobilesOnScreen.GreenWindows = 0
MobilesOnScreen.OrangeWindows = 0

MobilesOnScreen.UnSorted = {}

MobilesOnScreen.MobilesYellow = {}
MobilesOnScreen.MobilesGrey = {}
MobilesOnScreen.MobilesBlue = {}
MobilesOnScreen.MobilesRed = {}
MobilesOnScreen.MobilesGreen = {}
MobilesOnScreen.MobilesOrange = {}

MobilesOnScreen.MobilesOrange = {}

MobilesOnScreen.Dockspotlocked = false

MobilesOnScreen.AnchorUpdateRequest = false
MobilesOnScreen.delta = 0

MobilesOnScreen.UpdateLimit = 0.25

MobilesOnScreen.FarmNames = {
["a dog"] = true, ["a hind"] = true, ["a boar"] = true, ["a cat"] = true, ["a bull"] = true, ["a chicken"] = true, ["a cow"] = true, ["a goat"] = true, ["a jack rabbit"] = true, 
["a pig"] = true, ["a rabbit"] = true, ["a sheep"] = true, ["a black bear"] = true, ["a brown bear"] = true, ["a cougar"] = true, ["an eagle"] = true, ["a gorilla"] = true, ["a great hart"] = true, ["a grey wolf"] = true, 
["a grizzly bear"] = true, ["a horse"] = true, ["a llama"] = true, ["a mountain goat"] = true, ["a panther"] = true, ["a timber wolf"] = true,
["a crane"] = true, ["a gaman"] = true, ["a tropical bird"] = true, ["a crow"] = true, ["a bird"] = true, ["a magpie"] = true, ["a raven"] = true, ["a squirrel"] = true, ["a ferret"] = true, ["a tern"] = true, ["a swift"] = true, ["a wren"] = true,
["a swallow"] = true, ["a warbler"] = true, ["a nuthatch"] = true, ["a chickadee"] = true, ["a thrush"] = true, ["a nightingale"] = true, ["a starling"] = true, ["a skylark"] = true, ["a finch"] = true, ["a crossbill"] = true, ["a canary"] = true,
["a sparrow"] = true, ["a towhee"] = true, ["a shrike"] = true, ["a woodpecker"] = true, ["a kingfisher"] = true, ["a plover"] = true, ["a lapwing"] = true, ["a hawk"] = true, ["a dove"] = true, ["a cuckoo"] = true, ["a skittering hopper"] = true }

MobilesOnScreen.Summons = { ["a revenant"] = true, ["an energy vortex"] = true, ["a blade spirit"] = true, ["a rising colossus"] = true, ["a nature's fury"] = true
}

MobilesOnScreen.CloseLeft = true

----------------------------------------------------------------
-- MobilesOnScreen Functions
----------------------------------------------------------------
function MobilesOnScreen.Initialize()

	local windowName = "MobilesOnScreenWindow"
	SnapUtils.SnappableWindows[windowName] = true
	local titleName = windowName.."ShowViewName"
	local hideTitleName = windowName.."HideViewName"
	
	LabelSetText(titleName, GetStringFromTid(1075672) )
	LabelSetText(hideTitleName, GetStringFromTid(1075672) )
	
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(titleName,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		LabelSetFont(hideTitleName,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	MobilesOnScreen.CloseLeft = CustomSettings.LoadBoolean( "MobilesOnScreenCloseLeft", MobilesOnScreen.CloseLeft)
	WindowClearAnchors("MobilesOnScreenWindowHideView")
	if (MobilesOnScreen.CloseLeft) then
		WindowAddAnchor("MobilesOnScreenWindowHideView", "topleft", "MobilesOnScreenWindow", "topleft", 0, 0 )
	else
		WindowAddAnchor("MobilesOnScreenWindowHideView", "topright", "MobilesOnScreenWindow", "topright", 0, 0 )
	end
	
	WindowUtils.RestoreWindowPosition(windowName, false)
	WindowSetTintColor(windowName .. "ShowViewTitleBar", 0,0,0)
	WindowSetAlpha(windowName .. "ShowViewFrame", 0.5)
	WindowSetScale(windowName, SystemData.Settings.Interface.customUiScale * 0.80)

	MobilesOnScreen.DistanceSort = CustomSettings.LoadBoolean( "MobilesOnScreenDistanceSort" , MobilesOnScreen.DistanceSort )

	MobilesOnScreen.ButtonRotation()
	
	
	--WindowRegisterEventHandler( "MobilesOnScreenWindow", WindowData.MobileName.Event, "MobilesOnScreen.HandleUpdateNameEvent")
	--WindowRegisterEventHandler( "MobilesOnScreenWindow", WindowData.MobileStatus.Event, "MobilesOnScreen.HandleUpdateStatusEvent")
	--WindowRegisterEventHandler( "MobilesOnScreenWindow", WindowData.HealthBarColor.Event, "MobilesOnScreen.HandleTintHealthBarEvent")
	--WindowRegisterEventHandler( "MobilesOnScreenWindow", SystemData.Events.USER_SETTINGS_CHANGED, "MobilesOnScreen.ReloadSettings")
	
	-- MoS Filter Window
	
	MobilesOnScreen.UnsortedLimit = CustomSettings.LoadNumber("UnsortedLimit", 10 )
	MobilesOnScreen.YellowLimit = CustomSettings.LoadNumber("YellowLimit", 10 )
	MobilesOnScreen.GreyLimit = CustomSettings.LoadNumber("GreyLimit", 10 )
	MobilesOnScreen.BlueLimit = CustomSettings.LoadNumber("BlueLimit", 10 )
	MobilesOnScreen.RedLimit = CustomSettings.LoadNumber("RedLimit", 10 )
	MobilesOnScreen.GreenLimit = CustomSettings.LoadNumber("GreenLimit", 10 )
	MobilesOnScreen.OrangeLimit = CustomSettings.LoadNumber("OrangeLimit", 10 )
	
	MobilesOnScreen.UpdateLimit = CustomSettings.LoadNumber("MobilesOnScreenUpdateLimit", MobilesOnScreen.UpdateLimit )
	MobilesOnScreen.windowOffset = CustomSettings.LoadNumber("MobilesOnScreenOffset", MobilesOnScreen.windowOffset )
	
	CreateWindowFromTemplate( "MobilesOnScreenOptionsWindowSubSectionFilters", "SubSectionLabelTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( "MobilesOnScreenOptionsWindowSubSectionFilters", "topleft", "MobilesOnScreenOptionsWindow", "topleft", 35, 12 )
	LabelSetText( "MobilesOnScreenOptionsWindowSubSectionFiltersLabel", GetStringFromTid( SettingsWindow.TID.Filter ) )

	for i = 2, table.getn(MobilesOnScreen.Filter) do
		local templatename = "FilterCheckButton_"..i
		CreateWindowFromTemplate( templatename, "Settings_LabelCheckButton", "MobilesOnScreenOptionsWindow" )
		ButtonSetCheckButtonFlag( templatename .. "Button", true )
		LabelSetText(templatename.."Label", MobilesOnScreen.Filter[i])
		if (i == 10) then
			LabelSetTextColor(templatename.."Label", NameColor.TextColors[NameColor.Notoriety.MURDERER].r, NameColor.TextColors[NameColor.Notoriety.MURDERER].g, NameColor.TextColors[NameColor.Notoriety.MURDERER].b)
		end
		if i < 9 then
			NameColor.UpdateLabelNameColor(templatename.."Label", i)
		end
		
		if (i == 2) then
			WindowAddAnchor(templatename, "topleft", "MobilesOnScreenOptionsWindowSubSectionFilters", "topleft", 0, 32)
		else
			WindowAddAnchor(templatename, "bottomleft", "FilterCheckButton_"..i-1, "topleft", 0, 12)
		end
	end
	
	CreateWindowFromTemplate( "MobilesOnScreenOptionsWindowSubSectionLimits", "SubSectionLabelTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( "MobilesOnScreenOptionsWindowSubSectionLimits", "topleft", "MobilesOnScreenOptionsWindow", "topleft", 35, 480 )
	LabelSetText( "MobilesOnScreenOptionsWindowSubSectionLimitsLabel", UI.GetCliloc(SystemData.Settings.Language.type, 832) )
	
	local templatename = "FilterCheckButton_"..table.getn(MobilesOnScreen.Filter)
	local barName =	"UnsortedLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "MobilesOnScreenOptionsWindowSubSectionLimits", "topleft", 0, 50 )
	LabelSetText( barName .. "Text", UI.GetCliloc(SystemData.Settings.Language.type, 348))
	WindowSetId(barName .. "Text", 1129)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.UnsortedLimit / 50)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.UnsortedLimit)
	
	barName =	"YellowLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "UnsortedLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text", UI.GetCliloc(SystemData.Settings.Language.type, 349))
	WindowSetId(barName .. "Text", 1129)
	local c = NameColor.TextColors[NameColor.Notoriety.INVULNERABLE]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.YellowLimit / 50)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.YellowLimit)
	
	barName =	"GreyLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "YellowLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text", UI.GetCliloc(SystemData.Settings.Language.type, 350))
	WindowSetId(barName .. "Text", 1129)
	local c = NameColor.TextColors[NameColor.Notoriety.CRIMINAL]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.GreyLimit / 50)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.GreyLimit)
	
	barName =	"BlueLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "GreyLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text", UI.GetCliloc(SystemData.Settings.Language.type, 351))
	WindowSetId(barName .. "Text", 1129)
	local c = NameColor.TextColors[NameColor.Notoriety.INNOCENT]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.BlueLimit / 50)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.BlueLimit)
	
	barName =	"RedLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "BlueLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text",UI.GetCliloc(SystemData.Settings.Language.type, 352) )
	WindowSetId(barName .. "Text", 1129)
	local c = NameColor.TextColors[NameColor.Notoriety.MURDERER]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.RedLimit / 50)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.RedLimit)
	
	barName =	"GreenLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "RedLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text",UI.GetCliloc(SystemData.Settings.Language.type, 353) )
	WindowSetId(barName .. "Text", 1129)
	local c = NameColor.TextColors[NameColor.Notoriety.FRIEND]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.GreenLimit / 50)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.GreenLimit)
	
	barName =	"OrangeLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "GreenLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text", UI.GetCliloc(SystemData.Settings.Language.type, 354))
	WindowSetId(barName .. "Text", 1129)
	local c = NameColor.TextColors[NameColor.Notoriety.ENEMY]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.OrangeLimit / 50)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.OrangeLimit)
	
	CreateWindowFromTemplate( "MobilesOnScreenOptionsWindowSubSectionOthers", "SubSectionLabelTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( "MobilesOnScreenOptionsWindowSubSectionOthers", "topleft", "MobilesOnScreenOptionsWindow", "topleft", 35, 900 )
	LabelSetText( "MobilesOnScreenOptionsWindowSubSectionOthersLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1567) )
	
	barName =	"UpdateLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "MobilesOnScreenOptionsWindowSubSectionOthers", "topleft", 0, 50 )
	LabelSetText( barName .. "Text",UI.GetCliloc(SystemData.Settings.Language.type, 355) )
	LabelSetTextColor(barName .. "Text", 255, 255, 255)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.UpdateLimit )
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.UpdateLimit)
	
	barName =	"windowOffset"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "UpdateLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text",UI.GetCliloc(SystemData.Settings.Language.type, 356) )
	LabelSetTextColor(barName .. "Text", 255, 255, 255)
	WindowSetId(barName .. "Text", 1130)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.windowOffset / 50 )
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.windowOffset)
	
	
	local listOffset = ScrollWindowGetOffset("SettingsMobilesOnScreen")
	ScrollWindowUpdateScrollRect( "SettingsMobilesOnScreen" )   	
		local maxOffset = VerticalScrollbarGetMaxScrollPosition("SettingsMobilesOnScreen".."Scrollbar")
		if( listOffset > maxOffset ) then
		    listOffset = maxOffset
		end
		ScrollWindowSetOffset("SettingsMobilesOnScreen",listOffset)
	
	MobilesOnScreen.ReloadFilterSettings()
	
		
	

	MobilesOnScreen.ReloadSettings()
	
	windowName ="YellowDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.INVULNERABLE]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , UI.GetCliloc(SystemData.Settings.Language.type, 357) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.YellowEnabled = CustomSettings.LoadBoolean( "MobilesOnScreenYellowEnabled", false)
	if (MobilesOnScreen.YellowEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="GreyDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.CRIMINAL]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , UI.GetCliloc(SystemData.Settings.Language.type, 358) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.GreyEnabled = CustomSettings.LoadBoolean( "MobilesOnScreenGreyEnabled", false)
	if (MobilesOnScreen.GreyEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="BlueDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.INNOCENT]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , UI.GetCliloc(SystemData.Settings.Language.type, 359) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.BlueEnabled = CustomSettings.LoadBoolean( "MobilesOnScreenBlueEnabled", false)
	if (MobilesOnScreen.BlueEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="RedDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.MURDERER]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , UI.GetCliloc(SystemData.Settings.Language.type, 360))		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.RedEnabled = CustomSettings.LoadBoolean( "MobilesOnScreenRedEnabled", false)
	if (MobilesOnScreen.RedEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="GreenDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.FRIEND]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" ,UI.GetCliloc(SystemData.Settings.Language.type, 361) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.GreenEnabled = CustomSettings.LoadBoolean( "MobilesOnScreenGreenEnabled", false)
	if (MobilesOnScreen.GreenEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="OrangeDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.ENEMY]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , UI.GetCliloc(SystemData.Settings.Language.type, 362) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	MobilesOnScreen.OrangeEnabled = CustomSettings.LoadBoolean( "MobilesOnScreenOrangeEnabled", false)
	SnapUtils.SnappableWindows[windowName] = true
	if (MobilesOnScreen.OrangeEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	WindowUtils.RestoreWindowPosition("YellowDockspot", false)
	WindowUtils.RestoreWindowPosition("GreyDockspot", false)
	WindowUtils.RestoreWindowPosition("BlueDockspot", false)
	WindowUtils.RestoreWindowPosition("RedDockspot", false)
	WindowUtils.RestoreWindowPosition("GreenDockspot", false)
	WindowUtils.RestoreWindowPosition("OrangeDockspot", false)
	
	WindowSetScale("YellowDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("GreyDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("BlueDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("RedDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("GreenDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("OrangeDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	PetWindow.UpdatePet()
end

function MobilesOnScreen.GetVisible(ignoreMain)
	if (ignoreMain == nil) then
		ignoreMain = false
	end
	if (DoesWindowNameExist("YellowDockspot") and WindowGetShowing("YellowDockspot")) then
		return true
	end
	
	if (DoesWindowNameExist("GreyDockspot") and WindowGetShowing("GreyDockspot")) then
		return true
	end
	if (DoesWindowNameExist("BlueDockspot") and WindowGetShowing("BlueDockspot")) then
		return true
	end
	if (DoesWindowNameExist("RedDockspot") and WindowGetShowing("RedDockspot")) then
		return true
	end
	if (DoesWindowNameExist("GreenDockspot") and WindowGetShowing("GreenDockspot")) then
		return true
	end
	if (DoesWindowNameExist("OrangeDockspot") and WindowGetShowing("OrangeDockspot")) then
		return true
	end
	
	if (not MobilesOnScreen.Hidden and not ignoreMain) then
		return true
	end
	return false
end

function MobilesOnScreen.OnMouseDrag()
	if ( not MobilesOnScreen.locked) then
		SnapUtils.StartWindowSnap("MobilesOnScreenWindow")
	end
end
function MobilesOnScreen.Shutdown()

	MobilesOnScreen.SaveFilterSettings()
	WindowUtils.SaveWindowPosition("MobilesOnScreenWindow")
	WindowUtils.SaveWindowPosition("MobilesOnScreenOptionsWindow")	
	SnapUtils.SnappableWindows["MobilesOnScreenWindow"] = nil
	
	WindowUtils.SaveWindowPosition("YellowDockspot")
	WindowUtils.SaveWindowPosition("GreyDockspot")
	WindowUtils.SaveWindowPosition("BlueDockspot")
	WindowUtils.SaveWindowPosition("RedDockspot")
	WindowUtils.SaveWindowPosition("GreenDockspot")
	WindowUtils.SaveWindowPosition("OrangeDockspot")
end

function MobilesOnScreen.OnSlide( curPos )
	local bar = SystemData.ActiveWindow.name
	local barName = string.gsub(SystemData.ActiveWindow.name, "SliderBar", "")
	local barVal = 0
	if (barName == "UpdateLimit") then
		barVal =  tonumber(string.sub(tostring(SliderBarGetCurrentPosition(bar )),1, 4))
		LabelSetText(barName .. "Val", L"" .. barVal .. L"s")
	else
		barVal = math.floor( 50 * SliderBarGetCurrentPosition(bar ) )
		LabelSetText(barName .. "Val", L"" .. barVal)
	end
	
	
	if (barName == "UnsortedLimit") then
		MobilesOnScreen.UnsortedLimit = barVal
	elseif (barName == "YellowLimit") then
		MobilesOnScreen.YellowLimit = barVal
	elseif (barName == "GreyLimit") then
		MobilesOnScreen.GreyLimit = barVal
	elseif (barName == "BlueLimit") then
		MobilesOnScreen.BlueLimit = barVal
	elseif (barName == "RedLimit") then
		MobilesOnScreen.RedLimit = barVal
	elseif (barName == "GreenLimit") then
		MobilesOnScreen.GreenLimit = barVal
	elseif (barName == "OrangeLimit") then
		MobilesOnScreen.OrangeLimit = barVal
	elseif (barName == "UpdateLimit") then
		MobilesOnScreen.UpdateLimit = barVal
	elseif (barName == "windowOffset") then
		MobilesOnScreen.windowOffset = barVal
	end
	
end

function MobilesOnScreen.ReloadFilterSettings()
	--Reloads the Filter Settings and sets them in the Window
	-- None must be negative in order to work with the other filters
	MobilesOnScreen.SavedFilter[1] = false
	for i = 2, table.getn(MobilesOnScreen.Filter) do
		MobilesOnScreen.SavedFilter[i] = CustomSettings.LoadBoolean( "MoSFilter"..i, true )
		ButtonSetPressedFlag("FilterCheckButton_"..i.."Button", MobilesOnScreen.SavedFilter[i]) 
	end
end

function MobilesOnScreen.UpdateFilterSettings()
	for i = 2, table.getn(MobilesOnScreen.Filter) do
		ButtonSetPressedFlag("FilterCheckButton_"..i.."Button", MobilesOnScreen.SavedFilter[i]) 
	end
	SliderBarSetCurrentPosition("UnsortedLimitSliderBar",  MobilesOnScreen.UnsortedLimit / 50 )
	LabelSetText("UnsortedLimitVal", L"" .. MobilesOnScreen.UnsortedLimit )
	SliderBarSetCurrentPosition("YellowLimitSliderBar",  MobilesOnScreen.YellowLimit / 50 )
	LabelSetText("YellowLimitVal", L"" .. MobilesOnScreen.YellowLimit )
	SliderBarSetCurrentPosition("GreyLimitSliderBar",  MobilesOnScreen.GreyLimit / 50 )
	LabelSetText("GreyLimitVal", L"" .. MobilesOnScreen.GreyLimit )
	SliderBarSetCurrentPosition("BlueLimitSliderBar",  MobilesOnScreen.BlueLimit / 50 )
	LabelSetText("BlueLimitVal", L"" .. MobilesOnScreen.BlueLimit )
	SliderBarSetCurrentPosition("RedLimitSliderBar",  MobilesOnScreen.RedLimit / 50 )
	LabelSetText("RedLimitVal", L"" .. MobilesOnScreen.RedLimit )
	SliderBarSetCurrentPosition("GreenLimitSliderBar",  MobilesOnScreen.GreenLimit / 50 )
	LabelSetText("GreenLimitVal", L"" .. MobilesOnScreen.GreenLimit )
	SliderBarSetCurrentPosition("OrangeLimitSliderBar",  MobilesOnScreen.OrangeLimit / 50 )
	LabelSetText("OrangeLimitVal", L"" .. MobilesOnScreen.OrangeLimit )
	SliderBarSetCurrentPosition("UpdateLimitSliderBar",  MobilesOnScreen.UpdateLimit )
	LabelSetText("UpdateLimitVal", L"" .. MobilesOnScreen.UpdateLimit .. L"s")
	SliderBarSetCurrentPosition("windowOffsetSliderBar",  MobilesOnScreen.windowOffset / 50 )
	LabelSetText("windowOffsetVal", L"" .. MobilesOnScreen.windowOffset )

end

function MobilesOnScreen.SaveFilterSettings()
	for i = 2, table.getn(MobilesOnScreen.Filter) do
		MobilesOnScreen.SavedFilter[i] = ButtonGetPressedFlag("FilterCheckButton_"..i.."Button") 
		CustomSettings.SaveBoolean( "MoSFilter"..i, MobilesOnScreen.SavedFilter[i] )
	end
	
	if ( WindowGetShowing("BlueDockspot") and MobilesOnScreen.SavedFilter[2] == false) then
		WindowSetShowing("BlueDockspot", false)
		MobilesOnScreen.BlueEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenBlueEnabled", MobilesOnScreen.BlueEnabled  )
	end
	if (WindowGetShowing("GreenDockspot") and MobilesOnScreen.SavedFilter[3] == false) then
		WindowSetShowing("GreenDockspot", false)
		MobilesOnScreen.GreenEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenGreenEnabled", MobilesOnScreen.GreenEnabled  )
	end
	if (WindowGetShowing("GreyDockspot") and MobilesOnScreen.SavedFilter[4] == false and MobilesOnScreen.SavedFilter[5] == false) then
		WindowSetShowing("GreyDockspot", false)
		MobilesOnScreen.GreyEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenGreyEnabled", MobilesOnScreen.GreyEnabled  )
	end
	if (WindowGetShowing("OrangeDockspot") and MobilesOnScreen.SavedFilter[6] == false) then
		WindowSetShowing("OrangeDockspot", false)
		MobilesOnScreen.OrangeEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenOrangeEnabled", MobilesOnScreen.OrangeEnabled  )
	end
	if (WindowGetShowing("RedDockspot") and MobilesOnScreen.SavedFilter[7] == false) then
		WindowSetShowing("RedDockspot", false)
		MobilesOnScreen.RedEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenRedEnabled", MobilesOnScreen.RedEnabled  )
	end
	if (WindowGetShowing("YellowDockspot") and MobilesOnScreen.SavedFilter[8] == false) then
		WindowSetShowing("YellowDockspot", false)
		MobilesOnScreen.YellowEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenYellowEnabled", MobilesOnScreen.YellowEnabled  )
	end
	

	MobilesOnScreen.UnsortedLimit = math.floor( 50 * SliderBarGetCurrentPosition("UnsortedLimitSliderBar" ) )

	MobilesOnScreen.YellowLimit = math.floor( 50 * SliderBarGetCurrentPosition("YellowLimitSliderBar" ) )

	MobilesOnScreen.GreyLimit = math.floor( 50 * SliderBarGetCurrentPosition("GreyLimitSliderBar" ) )

	MobilesOnScreen.BlueLimit = math.floor( 50 * SliderBarGetCurrentPosition("BlueLimitSliderBar" ) )

	MobilesOnScreen.RedLimit = math.floor( 50 * SliderBarGetCurrentPosition("RedLimitSliderBar" ) )

	MobilesOnScreen.GreenLimit = math.floor( 50 * SliderBarGetCurrentPosition("GreenLimitSliderBar" ) )

	MobilesOnScreen.OrangeLimit = math.floor( 50 * SliderBarGetCurrentPosition("OrangeLimitSliderBar" ) )

	MobilesOnScreen.UpdateLimit = tonumber(string.sub(tostring(SliderBarGetCurrentPosition("UpdateLimitSliderBar" )),1, 4))

	MobilesOnScreen.windowOffset = math.floor( 50 * SliderBarGetCurrentPosition("windowOffsetSliderBar" ) )


	CustomSettings.SaveNumber("UnsortedLimit", MobilesOnScreen.UnsortedLimit )
	CustomSettings.SaveNumber("YellowLimit", MobilesOnScreen.YellowLimit )
	CustomSettings.SaveNumber("GreyLimit", MobilesOnScreen.GreyLimit )
	CustomSettings.SaveNumber("BlueLimit", MobilesOnScreen.BlueLimit )
	CustomSettings.SaveNumber("RedLimit", MobilesOnScreen.RedLimit )
	CustomSettings.SaveNumber("GreenLimit", MobilesOnScreen.GreenLimit )
	CustomSettings.SaveNumber("OrangeLimit", MobilesOnScreen.OrangeLimit )
	CustomSettings.SaveNumber("MobilesOnScreenUpdateLimit", MobilesOnScreen.UpdateLimit )
	CustomSettings.SaveNumber("MobilesOnScreenOffset", MobilesOnScreen.windowOffset )
	
	MobileHealthBar.Forced = true
	for mob, value in pairs(MobileHealthBar.hasWindow) do
		if (MobilesOnScreen.IsPet(mob)) then
			continue
		end
		if (MobileHealthBar.hasWindow[mob]) then
			continue
		end
		if (not MobileHealthBar.Handled[mob]) then
			if (MobilesOnScreen.UnSorted[mob] or MobilesOnScreen.MobilesYellow[mob] or 	MobilesOnScreen.MobilesGrey[mob] or	MobilesOnScreen.MobilesBlue[mob] or	MobilesOnScreen.MobilesRed[mob] or	MobilesOnScreen.MobilesGreen[mob] or	MobilesOnScreen.MobilesOrange[mob] ) then
				
				MobileHealthBar.CloseWindowByMobileId(mob)
				MobileHealthBar.Handled[mob] = false
			end
		end
	end
	MobileHealthBar.Forced = nil
	MobilesOnScreen.UnsortedWindows = 0
	MobilesOnScreen.YellowWindows = 0
	MobilesOnScreen.GreyWindows = 0
	MobilesOnScreen.BlueWindows = 0
	MobilesOnScreen.RedWindows = 0
	MobilesOnScreen.GreenWindows = 0
	MobilesOnScreen.OrangeWindows = 0
	MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.OnFilterOkayButton()
	WindowSetShowing("MobilesOnScreenOptionsWindow", false)
end

function MobilesOnScreen.OnFilterHidden()
	MobilesOnScreen.SaveFilterSettings()
	-- Clears the whole MoS table
	MobilesOnScreen.Refilter()
end


function MobilesOnScreen.Refilter()
		MobilesOnScreen.Clear()

		MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.Sort()
	
	for mobileId, value in pairs(MobileHealthBar.hasWindow) do
		if not MobileHealthBar.hasWindow[mobileId] then
			continue
		end
		if (MobilesOnScreen.IsPet(mobileId)) then
			continue
		end
		MobilesOnScreen.AddHealthbar(mobileId)
	end
			
	MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.Clear()
	for nn, mob in pairs(MobilesOnScreen.MobilesSort) do
		if (MobilesOnScreen.IsPet(mob)) then
			continue
		end
		local windowName = "MobileHealthBar_"..mob
		if (not MobileHealthBar.Handled[mob] and DoesWindowExist(windowName)) then
			MobileHealthBar.CloseWindowByMobileId(mob)
		end
	end
	
	MobileHealthBar.Forced = nil
	MobilesOnScreen.UnsortedWindows = 0
	MobilesOnScreen.YellowWindows = 0
	MobilesOnScreen.GreyWindows = 0
	MobilesOnScreen.BlueWindows = 0
	MobilesOnScreen.RedWindows = 0
	MobilesOnScreen.GreenWindows = 0
	MobilesOnScreen.OrangeWindows = 0
	
	MobilesOnScreen.UnSorted = {}
	MobilesOnScreen.MobilesYellow = {}
	MobilesOnScreen.MobilesGrey = {}
	MobilesOnScreen.MobilesBlue = {}
	MobilesOnScreen.MobilesRed = {}
	MobilesOnScreen.MobilesGreen = {}
	MobilesOnScreen.MobilesOrange = {}

	MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.ShowPetToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 364))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	WindowSetAlpha(SystemData.ActiveWindow.name,1)
end

function MobilesOnScreen.ShowPetToolTipEnd()
	WindowSetAlpha(SystemData.ActiveWindow.name,0.5)
end

function MobilesOnScreen.HidePetToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 365))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	WindowSetAlpha(SystemData.ActiveWindow.name,1)
end


function MobilesOnScreen.HidePetToolTipEnd()
	WindowSetAlpha(SystemData.ActiveWindow.name,0.5)
end


function MobilesOnScreen.IsPet(mobileId)
		if (MobilesOnScreen.ReversePet[mobileId]  ~= nil or (WindowData.MobileStatus[mobileId] and WindowData.MobileStatus[mobileId].MyPet)) then
			return true
		end
		return false
end



function MobilesOnScreen.IsFarm(name)
	if (name == nil or name == L"") then
		return false
	end
	local convName = string.gsub(WStringToString(name), "^%s*(.-)%s*$", "%1")
	convName = string.lower(convName)
	if (MobilesOnScreen.FarmNames[convName]) then
		return true
	end
	return false
end

function MobilesOnScreen.IsSummon(name)
	if (name == nil or name == L"") then
		return false
	end
	local convName = ""
	if (type(name) == "wstring") then
		convName =string.gsub(WStringToString(name), "^%s*(.-)%s*$", "%1")
	else
		convName =string.gsub(name, "^%s*(.-)%s*$", "%1")
	end
	convName = string.lower(convName)
	
	if (MobilesOnScreen.Summons[convName]) then
		return true
	end
	return false
end

function MobilesOnScreen.AddHealthbar(mobileId)
	local data = WindowData.MobileName[mobileId]
	if (data) then
		local passa = true
		if (not MobilesOnScreen.SavedFilter[9] and MobilesOnScreen.IsFarm(data.MobName))  or wstring.find(data.MobName, L"A Mannequin") then
				passa = false
		end
		if (not MobilesOnScreen.SavedFilter[10] and MobilesOnScreen.IsSummon(data.MobName)) then
					passa = false
		end
		if (not MobilesOnScreen.IsPet(mobileId) and MobilesOnScreen.GetVisible() and not MobileHealthBar.windowDisabled[mobileId]  and IsMobile(mobileId) and passa) then
			
			
			local noto = data.Notoriety+1
			if (not MobilesOnScreen.SavedFilter[noto]) then
				return false
			end
			
			local added = false
			if (( noto == NameColor.Notoriety.NONE or noto == NameColor.Notoriety.CANATTACK or noto == NameColor.Notoriety.CRIMINAL) and DoesWindowNameExist("GreyDockspot") and WindowGetShowing("GreyDockspot")) then
				if (table.getn(MobilesOnScreen.MobilesGrey) < MobilesOnScreen.GreyLimit) then
					table.insert(MobilesOnScreen.MobilesGrey,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.INNOCENT and DoesWindowNameExist("BlueDockspot") and WindowGetShowing("BlueDockspot")) then
				if ( table.getn(MobilesOnScreen.MobilesBlue) < MobilesOnScreen.BlueLimit) then
					table.insert(MobilesOnScreen.MobilesBlue,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.FRIEND  and DoesWindowNameExist("GreenDockspot") and WindowGetShowing("GreenDockspot")) then
				if (table.getn(MobilesOnScreen.MobilesGreen) < MobilesOnScreen.GreenLimit) then
					table.insert(MobilesOnScreen.MobilesGreen,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.ENEMY and DoesWindowNameExist("OrangeDockspot") and WindowGetShowing("OrangeDockspot")) then
				if (table.getn(MobilesOnScreen.MobilesOrange) < MobilesOnScreen.OrangeLimit) then
					table.insert(MobilesOnScreen.MobilesOrange,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.MURDERER and DoesWindowNameExist("RedDockspot") and WindowGetShowing("RedDockspot")) then
				if ( table.getn(MobilesOnScreen.MobilesRed) < MobilesOnScreen.RedLimit) then
					table.insert(MobilesOnScreen.MobilesRed,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.INVULNERABLE and DoesWindowNameExist("YellowDockspot") and WindowGetShowing("YellowDockspot")) then
				if (table.getn(MobilesOnScreen.MobilesYellow) < MobilesOnScreen.YellowLimit) then
					table.insert(MobilesOnScreen.MobilesYellow,mobileId)
					added = true
				end
			elseif ( not MobilesOnScreen.Hidden and MobilesOnScreen.SavedFilter[noto] and table.getn(MobilesOnScreen.UnSorted) < MobilesOnScreen.UnsortedLimit) then
				table.insert(MobilesOnScreen.UnSorted,mobileId)
				added = true
			end
			return added
		end
	end
	return false
end


function MobilesOnScreen.RemoveHealthBar(mobileId, notClose, xtract)
	

		EnhancePack.HealthbarCloseWindowByMobileId(mobileId)

end

function MobilesOnScreen.SlowUpdate(timePassed)
	MobilesOnScreen.delta = MobilesOnScreen.delta + timePassed
	
	if (MobilesOnScreen.delta > MobilesOnScreen.UpdateLimit or MobilesOnScreen.AnchorUpdateRequest) then
		
		MobilesOnScreen.UpdateAnchors()
	end
end

function MobilesOnScreen.HandleAnchors()	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.UnsortedWindows = 0
	
	
	
	for i=1, table.getn(MobilesOnScreen.UnSorted) do
		local mob = MobilesOnScreen.UnSorted[i]

		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] or not WindowGetShowing(windowName)) then
			continue
		end

		if (i <= MobilesOnScreen.UnsortedLimit+1) then
			bars = bars + 1
			MobilesOnScreen.UnsortedWindows = MobilesOnScreen.UnsortedWindows + 1
			-- anchor management
			local parent = "MobilesOnScreenWindow"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.UnSorted[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				
				WindowAddAnchor(windowName, "bottomleft", showName .. "TitleBar", "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			
			unsortedPrev = mob
		end
	end

	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.YellowWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesYellow) do
		local mob = MobilesOnScreen.MobilesYellow[i]
		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] or not WindowGetShowing(windowName)) then
			continue
		end

		if (i <= MobilesOnScreen.YellowLimit+1) then
			bars = bars + 1
			MobilesOnScreen.YellowWindows = MobilesOnScreen.YellowWindows + 1
			-- anchor management
			local parent = "YellowDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesYellow[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end

	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.GreyWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesGrey) do
		local mob = MobilesOnScreen.MobilesGrey[i]
		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] or not WindowGetShowing(windowName)) then
			continue
		end

		if (i <= MobilesOnScreen.GreyLimit+1) then
			bars = bars + 1
			MobilesOnScreen.GreyWindows = MobilesOnScreen.GreyWindows + 1
			-- anchor management
			local parent = "GreyDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesGrey[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.BlueWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesBlue) do
		local mob = MobilesOnScreen.MobilesBlue[i]

		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] or not WindowGetShowing(windowName)) then
			continue
		end
		
		if (i <= MobilesOnScreen.BlueLimit+1) then
			bars = bars + 1
			MobilesOnScreen.BlueWindows = MobilesOnScreen.BlueWindows + 1
			-- anchor management
			local parent = "BlueDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesBlue[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.RedWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesRed) do
		local mob = MobilesOnScreen.MobilesRed[i]

		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] or not WindowGetShowing(windowName)) then
			continue
		end
		
		if (i <= MobilesOnScreen.RedLimit+1) then
			bars = bars + 1
			MobilesOnScreen.RedWindows = MobilesOnScreen.RedWindows + 1
			-- anchor management
			local parent = "RedDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesRed[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.GreenWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesGreen) do
		local mob = MobilesOnScreen.MobilesGreen[i]

		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] or not WindowGetShowing(windowName)) then
			continue
		end
		
		if (i <= MobilesOnScreen.GreenLimit+1) then
			bars = bars + 1
			MobilesOnScreen.GreenWindows = MobilesOnScreen.GreenWindows + 1
			-- anchor management
			local parent = "GreenDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesGreen[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.OrangeWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesOrange) do
		local mob = MobilesOnScreen.MobilesOrange[i]
		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] or not WindowGetShowing(windowName)) then
			continue
		end
		i = i +1
		
		if (i <= MobilesOnScreen.OrangeLimit+1) then
			bars = bars + 1
			MobilesOnScreen.OrangeWindows = MobilesOnScreen.OrangeWindows + 1
			-- anchor management
			local parent = "OrangeDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesOrange[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
end

function MobilesOnScreen.SortByDistance()

	local pos = 1
	while pos < #MobilesOnScreen.MobilesSort do
		if (pos == 1 or GetDistanceFromPlayer(MobilesOnScreen.MobilesSort[pos]) >= GetDistanceFromPlayer(MobilesOnScreen.MobilesSort[pos-1])) then
			pos = pos + 1
		else
			local swap = MobilesOnScreen.MobilesSort[pos]
			MobilesOnScreen.MobilesSort[pos] = MobilesOnScreen.MobilesSort[pos-1]
			MobilesOnScreen.MobilesSort[pos-1] = swap
			pos = pos - 1
		end
	end
	EnhancePack.CloseAllHealthbars()
end


function MobilesOnScreen.UpdateAnchors()
	if (EnhancePack.TimeSinceLogin < 1) then
		return
	end
	if (MobilesOnScreen.delta < MobilesOnScreen.UpdateLimit) then
		MobilesOnScreen.AnchorUpdateRequest = true
		return
	end
	MobilesOnScreen.delta = 0
	MobilesOnScreen.AnchorUpdateRequest = false
	
	MobilesOnScreen.UnSorted = {}
	MobilesOnScreen.MobilesYellow = {}
	MobilesOnScreen.MobilesGrey = {}
	MobilesOnScreen.MobilesBlue = {}
	MobilesOnScreen.MobilesRed = {}
	MobilesOnScreen.MobilesGreen = {}
	MobilesOnScreen.MobilesOrange = {}
	
	
	if (MobilesOnScreen.DistanceSort) then
		MobilesOnScreen.SortByDistance()
	end

	
	for i, mobileId in pairsByKeys(MobilesOnScreen.MobilesSort) do
		-- ignoring: extracted bars, pets, not mobiles, disabled healthbars
		if (not mobileId or MobileHealthBar.Handled[mobileId] or MobilesOnScreen.IsPet(mobileId)) then
			if not DoesWindowNameExist("MobileHealthBar_"..mobileId) then
				UnregisterWindowData(WindowData.MobileName.Type, mobileId)
			end
			continue
		end
		
		if ( not IsMobile(mobileId) or MobileHealthBar.windowDisabled[mobileId]) then
			MobilesOnScreen.RemoveHealthBar(mobileId)
			continue
		end
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
		local data = WindowData.MobileName[mobileId]
		if (not data) then -- missing data
			MobilesOnScreen.RemoveHealthBar(mobileId)
			continue
		end
		-- and not wstring.find(wstring.lower(data.MobName), wstring.lower(MobilesOnScreen.STRFilter))
		if (MobilesOnScreen.STRFilter ~= "" ) then -- filter
			local found = false
			for cf in wstring.gmatch(MobilesOnScreen.STRFilter, L"[^|]+") do
				if (wstring.find(wstring.lower(data.MobName), wstring.lower(cf))) then
					found = true
				end
			end
			if (not found ) then
				MobilesOnScreen.RemoveHealthBar(mobileId)
				continue
			end
		end
		
		local windowName = "MobileHealthBar_"..mobileId
		
		local isVisible = GetDistanceFromPlayer(mobileId) < 22
				
		if (not isVisible) then
			if (DoesWindowNameExist(windowName)) then
				MobilesOnScreen.RemoveHealthBar(mobileId)
			end
			continue
		end
		local noto = data.Notoriety+1
		-- let's check if the filters allow this mobile
		
		local added = MobilesOnScreen.AddHealthbar(mobileId)
		if (added and not DoesWindowNameExist(windowName)) then
			MobileHealthBar.Forced = true
			EnhancePack.CreateHealthBar(mobileId)
			MobileHealthBar.Forced = nil
		elseif (not added) then
			MobilesOnScreen.RemoveHealthBar(mobileId)
		end
		
	end
	
	MobilesOnScreen.HandleAnchors()
	
end
	
		

function MobilesOnScreen.Dockspot_OnLButtonUp()
	WindowSetMoving(WindowUtils.GetActiveDialog(),false)
end

function MobilesOnScreen.Dockspot_OnLButtonDown()
	if (not MobilesOnScreen.Dockspotlocked) then
		WindowSetMoving(WindowUtils.GetActiveDialog(),true)
		SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
	end
end

function MobilesOnScreen.HidePet()
	local windowName = "MobilesOnScreenWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	WindowSetAlpha(hideName .. "ShowButton",0.5)
	WindowSetAlpha(hideName .. "ShowButtonR",0.5)
	
	WindowSetShowing(showName, false)
	WindowSetShowing(hideName, true)
	
	SnapUtils.SnappableWindows[showName] = nil
	
	MobilesOnScreen.Hidden = true
	CustomSettings.SaveBoolean( "MobilesOnScreenWindowVisible", false )
	
	if (not MobilesOnScreen.GetVisible()) then
		MobilesOnScreen.Clear()
	else
		for mob, value in pairs(MobileHealthBar.Handled) do
			if (MobilesOnScreen.IsPet(mob)) then
				continue
			end
			if (MobilesOnScreen.UnSorted[mob] and not MobileHealthBar.Handled[mob]) then
				MobileHealthBar.CloseWindowByMobileId(mob)
				MobilesOnScreen.UnSorted[mob] = nil
				MobilesOnScreen.UnsortedWindows = MobilesOnScreen.UnsortedWindows -1
			end
		end
		MobilesOnScreen.UpdateAnchors()
	end
end

function MobilesOnScreen.ShowPet()
	local windowName = "MobilesOnScreenWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	
	WindowSetAlpha(showName .. "HideButton",0.5)
	WindowSetAlpha(showName .. "HideButtonR",0.5)
	
	WindowSetShowing(showName, true)
	WindowSetShowing(hideName, false)
	
	SnapUtils.SnappableWindows[showName] = true
	
	MobilesOnScreen.Hidden = false
	CustomSettings.SaveBoolean( "MobilesOnScreenWindowVisible", true )
	MobilesOnScreen.UpdateAnchors()
end




function MobilesOnScreen.HideAll()
	local windowName = "MobilesOnScreenWindow"
	WindowSetShowing(windowName, false)
end

function MobilesOnScreen.ShowWindow()
	local windowName = "MobilesOnScreenWindow"
	WindowSetShowing(windowName, true)
end



function MobilesOnScreen.Lock()
	local windowname = WindowGetId(WindowUtils.GetActiveDialog())
	if(MobilesOnScreen.locked) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 289),0,"Lock",1,false)
	else
	   ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 290),0,"Lock",1,false)
	end
	
	if(MobilesOnScreen.DistanceSort) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5029),0,"ToggleSortDistance",1,false)
	else
	   ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5028),0,"ToggleSortDistance",1,false)
	end
	
	local enabled = 0
	if (not MobilesOnScreen.GetVisible(true)) then
		enabled = 1
	end

	if(MobilesOnScreen.Dockspotlocked) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 367),enabled,"Lockdockspot",1,false)
	else
	   ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 368),enabled,"Lockdockspot",1,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[8] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.YellowEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 369),enabled,"yellowDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 370),enabled,"yellowDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[4] == false and MobilesOnScreen.SavedFilter[5] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.GreyEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 371),enabled,"greyDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 372),enabled,"greyDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[2] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.BlueEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 373),enabled,"blueDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 374),enabled,"blueDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[7] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.RedEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 375),enabled,"redDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 376),enabled,"redDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[3] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.GreenEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 377),enabled,"greenDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 378),enabled,"greenDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[6] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.OrangeEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 379),enabled,"orangeDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 380),enabled,"orangeDockspotOff",2,false)
	end
	
	
	if (MobilesOnScreen.CloseLeft) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 291),0,"closeRight",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 293),0,"closeLeft",2,false)
	end

	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"nil",2, false)
    
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 381),0,"reset",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 382),0,"clear",2,false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"nil",2, false)
	
	if (MobilesOnScreen.STRFilter == "") then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 844),0,"setfilter",2, false)
    else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5027),0,"addfilter",2, false)
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 845),0,"removefilter",2, false)
    end
	ContextMenu.ActivateLuaContextMenu(MobilesOnScreen.ContextMenuCallback)
end

function MobilesOnScreen.ButtonRotation()
	local showName = "MobilesOnScreenWindowShowView"
	local hideName = "MobilesOnScreenWindowHideView"
		
	if MobilesOnScreen.CloseLeft then
		WindowSetShowing(showName .. "HideButtonR", false)
		WindowSetShowing(showName .. "HideButton", true)
		WindowSetShowing(hideName .. "ShowButtonR", false)
		WindowSetShowing(hideName .. "ShowButton", true)
		WindowClearAnchors(hideName .. "Name")
		WindowAddAnchor(hideName .. "Name", "bottomleft", hideName, "topleft", 10, -20)
	else
		WindowSetShowing(showName .. "HideButtonR", true)
		WindowSetShowing(showName .. "HideButton", false)
		WindowSetShowing(hideName .. "ShowButtonR", true)
		WindowSetShowing(hideName .. "ShowButton", false)
		WindowClearAnchors(hideName .. "Name")

		WindowAddAnchor(hideName .. "Name", "bottomright", hideName, "topright", 0, -20)
	end
end

function MobilesOnScreen.SetFilter(j, newval)
	
	if j == 2 then
		MobilesOnScreen.STRFilter = newval
	elseif j == 3 then
		MobilesOnScreen.STRFilter = MobilesOnScreen.STRFilter .. L"|" .. newval
	end
end

function MobilesOnScreen.ContextMenuCallback( returnCode, param )
	local windowName = "MobilesOnScreenWindow"
	if ( returnCode=="Lock" ) then
		MobilesOnScreen.locked = not MobilesOnScreen.locked
		CustomSettings.SaveBoolean( "LockMobilesOnScreen", MobilesOnScreen.locked )
		WindowSetMovable(windowName, not MobilesOnScreen.locked )
	end
	if ( returnCode=="Lockdockspot" ) then
		MobilesOnScreen.Dockspotlocked = not MobilesOnScreen.Dockspotlocked
		CustomSettings.SaveBoolean( "DockspotlockedMobilesOnScreen", MobilesOnScreen.Dockspotlocked )
		WindowSetMovable(windowName, not MobilesOnScreen.Dockspotlocked )
	end
	if ( returnCode=="reset" ) then
		WindowClearAnchors(windowName)
		WindowAddAnchor(windowName,"topleft","Root","topleft",0,100)
	end
	
	if (returnCode == "setfilter") then
		local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,844), subtitle=UI.GetCliloc(SystemData.Settings.Language.type ,846), callfunction=MobilesOnScreen.SetFilter, id=2}
		RenameWindow.Create(rdata)
	elseif (returnCode == "addfilter") then
		local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,844), subtitle=UI.GetCliloc(SystemData.Settings.Language.type ,846), callfunction=MobilesOnScreen.SetFilter, id=3}
		RenameWindow.Create(rdata)
	elseif (returnCode == "removefilter") then
		MobilesOnScreen.STRFilter = ""
	end
	
	if ( returnCode=="ToggleSortDistance" ) then
		MobilesOnScreen.DistanceSort = not MobilesOnScreen.DistanceSort
		CustomSettings.SaveBoolean( "MobilesOnScreenDistanceSort", MobilesOnScreen.DistanceSort  )
	end
	
	if ( returnCode=="closeRight" ) then
		MobilesOnScreen.CloseLeft = false
		CustomSettings.SaveBoolean( "MobilesOnScreenCloseLeft", MobilesOnScreen.CloseLeft  )
		WindowClearAnchors("MobilesOnScreenWindowHideView")
		WindowAddAnchor("MobilesOnScreenWindowHideView", "topright", "MobilesOnScreenWindow", "topright", 0, 0 )
		MobilesOnScreen.ButtonRotation()
	elseif ( returnCode=="closeLeft" ) then
		MobilesOnScreen.CloseLeft = true 
		CustomSettings.SaveBoolean( "MobilesOnScreenCloseLeft", MobilesOnScreen.CloseLeft  )
		WindowClearAnchors("MobilesOnScreenWindowHideView")
		WindowAddAnchor("MobilesOnScreenWindowHideView", "topleft", "MobilesOnScreenWindow", "topleft", 0, 0 )
		MobilesOnScreen.ButtonRotation()
	end
	
	if ( returnCode=="yellowDockspotOn" ) then
		MobilesOnScreen.YellowEnabled = true
		CustomSettings.SaveBoolean( "MobilesOnScreenYellowEnabled", MobilesOnScreen.YellowEnabled  )
		WindowSetShowing("YellowDockspot", MobilesOnScreen.YellowEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="yellowDockspotOff" ) then
		MobilesOnScreen.YellowEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenYellowEnabled", MobilesOnScreen.YellowEnabled  )
		WindowSetShowing("YellowDockspot", MobilesOnScreen.YellowEnabled)
		MobilesOnScreen.Sort()
	end
	
	
	if ( returnCode=="greyDockspotOn" ) then
		MobilesOnScreen.GreyEnabled = true
		CustomSettings.SaveBoolean( "MobilesOnScreenGreyEnabled", MobilesOnScreen.GreyEnabled  )
		WindowSetShowing("GreyDockspot", MobilesOnScreen.GreyEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="greyDockspotOff" ) then
		MobilesOnScreen.GreyEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenGreyEnabled", MobilesOnScreen.GreyEnabled  )
		WindowSetShowing("GreyDockspot", MobilesOnScreen.GreyEnabled)
		MobilesOnScreen.Sort()
	end
	
	
	if ( returnCode=="blueDockspotOn" ) then
		MobilesOnScreen.BlueEnabled = true
		CustomSettings.SaveBoolean( "MobilesOnScreenBlueEnabled", MobilesOnScreen.BlueEnabled  )
		WindowSetShowing("BlueDockspot", MobilesOnScreen.BlueEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="blueDockspotOff" ) then
		MobilesOnScreen.BlueEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenBlueEnabled", MobilesOnScreen.BlueEnabled  )
		WindowSetShowing("BlueDockspot", MobilesOnScreen.BlueEnabled)
		MobilesOnScreen.Sort()
	end
	
	if ( returnCode=="redDockspotOn" ) then
		MobilesOnScreen.RedEnabled = true
		CustomSettings.SaveBoolean( "MobilesOnScreenRedEnabled", MobilesOnScreen.RedEnabled  )
		WindowSetShowing("RedDockspot", MobilesOnScreen.RedEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="redDockspotOff" ) then
		MobilesOnScreen.RedEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenRedEnabled", MobilesOnScreen.RedEnabled  )
		WindowSetShowing("RedDockspot", MobilesOnScreen.RedEnabled)
		MobilesOnScreen.Sort()
	end
	
	
	if ( returnCode=="greenDockspotOn" ) then
		MobilesOnScreen.GreenEnabled = true
		CustomSettings.SaveBoolean( "MobilesOnScreenGreenEnabled", MobilesOnScreen.GreenEnabled  )
		WindowSetShowing("GreenDockspot", MobilesOnScreen.GreenEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="greenDockspotOff" ) then
		MobilesOnScreen.GreenEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenGreenEnabled", MobilesOnScreen.GreenEnabled  )
		WindowSetShowing("GreenDockspot", MobilesOnScreen.GreenEnabled)
		MobilesOnScreen.Sort()
	end
	
	if ( returnCode=="orangeDockspotOn" ) then
		MobilesOnScreen.OrangeEnabled = true
		CustomSettings.SaveBoolean( "MobilesOnScreenOrangeEnabled", MobilesOnScreen.OrangeEnabled  )
		WindowSetShowing("OrangeDockspot", MobilesOnScreen.OrangeEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="orangeDockspotOff" ) then
		MobilesOnScreen.OrangeEnabled = false
		CustomSettings.SaveBoolean( "MobilesOnScreenOrangeEnabled", MobilesOnScreen.OrangeEnabled  )
		WindowSetShowing("OrangeDockspot", MobilesOnScreen.OrangeEnabled)
		MobilesOnScreen.Sort()
	end
	
	if ( returnCode=="clear" ) then

		MobilesOnScreen.Clear()
	end
end

function MobilesOnScreen.ReloadSettings()
	MobilesOnScreen.locked = CustomSettings.LoadBoolean( "LockMobilesOnScreen", false )
	MobilesOnScreen.Dockspotlocked = CustomSettings.LoadBoolean( "DockspotlockedMobilesOnScreen", false )
	WindowSetMovable("MobilesOnScreenWindow", not MobilesOnScreen.locked)
	local visible = CustomSettings.LoadBoolean( "MobilesOnScreenWindowVisible", false )
	
	if (visible) then
		MobilesOnScreen.ShowPet()
	else
		MobilesOnScreen.HidePet()
	end
end