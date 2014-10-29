----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

HuePickerWindow = {}

HuePickerWindow.NUM_COLORS = 200
HuePickerWindow.COLORS_PER_ROW = 20
HuePickerWindow.SWATCH_SIZE = 15

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function HuePickerWindow.Initialize()
    ButtonSetText("PickColorTarget", L"Pick!")
	LabelSetText("Color2Label", L"(Text) WHITE              " )
    
    LabelSetText("Color3Label", L"(Plant) Bright Yellow" )
    LabelSetText("Color4Label", L"(Plant) Bright Purple" )
    LabelSetText("Color5Label", L"(Plant) Purple" )
    LabelSetText("Color6Label", L"(Plant) Rare Pink" )
    LabelSetText("Color7Label", L"(Plant) Rare Aqua" )
    LabelSetText("Color8Label", L"(Pigments) Fresh Plum" )
    LabelSetText("Color10Label", L"(Pigments) Light Green" )
    LabelSetText("Color11Label", L"(Pigments) Pale Blue" )
    LabelSetText("Color12Label", L"(Pigments) Noble Gold" )
    LabelSetText("Color13Label", L"(Pigments) Pale Orange" )
    LabelSetText("Color14Label", L"(Pigments) Chaos Blue" )
    LabelSetText("Color15Label", L"(Pigments) Berserker Red" )
    LabelSetText("Color16Label", L"(Special) Sigil Purple" )
    LabelSetText("Color17Label", L"(Special) Museum Chaos Shield" )
    LabelSetText("Color18Label", L"(Special) Crimson Red" )

    local id = 0
    local text = string.find(MenuBarWindow.HuePickerWindowRequest, "color")
    
    if (text == nil) then
		LabelSetText("Color2Label", L"(Plant) Bright Green" )
		id = WindowData.HuePicker.ObjectId
    end
	
    local windowName = SystemData.ActiveWindow.name

    Interface.DestroyWindowOnClose[windowName] = true
	
	HuePickerWindow[id] = {}
	if (text == nil) then
		HuePickerWindow[id].ListType = WindowData.HuePicker.ListType
	else
		HuePickerWindow[id].ListType = 0
	end
	HuePickerWindow[id].Brightness = 0

    
    WindowSetId(windowName,id)
    WindowSetId(windowName.."SliderBar", id)
	
        ColorPickerWindow.SetNumColorsPerRow(HuePickerWindow.COLORS_PER_ROW)
    	ColorPickerWindow.SetSwatchSize(HuePickerWindow.SWATCH_SIZE)
    	ColorPickerWindow.SetAfterColorSelectionFunction(HuePickerWindow.ColorPicked)
    	ColorPickerWindow.SetWindowPadding(1,1)
    	ColorPickerWindow.SetFrameEnabled(false)
    	ColorPickerWindow.SetCloseButtonEnabled(false)
    	WindowSetShowing(windowName.."Chrome_UO_WindowCloseButton", false)
   	LabelSetText(windowName.."Name", GetStringFromTid( 3000166 ) )
    
   	HuePickerWindow.UpdateHueTable(windowName.."Picker",id,1)
end

function HuePickerWindow.Shutdown()

end

function HuePickerWindow.OnSlide()
	local sliderName =SystemData.ActiveWindow.name
	local id = WindowGetId(sliderName)
	
	local windowName = "HuePicker"..id
	if (id == 0) then
		windowName = "HuePickerWindow"
	end
	
	local sliderValue = ( SliderBarGetCurrentPosition( sliderName ) / 0.25 ) + 1

	if ( HuePickerWindow[id].Brightness ~= sliderValue ) then
		HuePickerWindow.UpdateHueTable(windowName.."Picker", id, sliderValue)
	end
end

function HuePickerWindow.UpdateHueTable(this,id,newBrightness)

local hueTable = {}

    if( newBrightness ~= HuePickerWindow[id].Brightness ) then
        HuePickerWindow[id].Brightness = newBrightness
    
        for i=1, HuePickerWindow.NUM_COLORS do
            hueTable[i] = ((i-1)*5)+HuePickerWindow[id].Brightness + 1
        end
    end
    
    ColorPickerWindow.SetColorTable(hueTable,this)
    ColorPickerWindow.DrawColorTable(this)	    
end
function HuePickerWindow.PickColorTarget()
	local this = SystemData.ActiveWindow.name
	HuePickerWindow.RequestTargetInfo(this)	
end


function HuePickerWindow.Color2Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	if (id == 0) then
		HuePickerWindow.PickColor(id, 0,huePickerWindow)
	else
		HuePickerWindow.PickColor(id, 671,huePickerWindow)
	end
	
end

function HuePickerWindow.Color3Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 253,huePickerWindow)
end

function HuePickerWindow.Color4Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 316,huePickerWindow)
end

function HuePickerWindow.Color5Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 15,huePickerWindow)
end

function HuePickerWindow.Color6Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 341,huePickerWindow)
end

function HuePickerWindow.Color7Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 391,huePickerWindow)
end

function HuePickerWindow.Color8Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 325,huePickerWindow)
end


function HuePickerWindow.Color10Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 456,huePickerWindow)
end

function HuePickerWindow.Color11Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 591,huePickerWindow)
end

function HuePickerWindow.Color12Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 551,huePickerWindow)
end

function HuePickerWindow.Color13Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 46,huePickerWindow)
end

function HuePickerWindow.Color14Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 5,huePickerWindow)
end

function HuePickerWindow.Color15Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 33,huePickerWindow)
end

function HuePickerWindow.Color16Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 11,huePickerWindow)
end

function HuePickerWindow.Color17Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 250,huePickerWindow)
end

function HuePickerWindow.Color18Up()
	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
	local id = WindowGetId(huePickerWindow)
	HuePickerWindow.PickColor(id, 232, huePickerWindow)
end

function HuePickerWindow.PickColor(id, huePicked, this)
	if (id == 0) then
		if (MenuBarWindow.HuePickerWindowRequest== "colorDefault") then
			EnhancePack.TITLE_COLOR.r,EnhancePack.TITLE_COLOR.g,EnhancePack.TITLE_COLOR.b,EnhancePack.TITLE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackTITLE_COLOR", EnhancePack.TITLE_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorMods") then
			EnhancePack.BODY_COLOR.r,EnhancePack.BODY_COLOR.g,EnhancePack.BODY_COLOR.b,EnhancePack.BODY_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackBODY_COLOR", EnhancePack.BODY_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorEngrave") then
			EnhancePack.ENGRAVE_COLOR.r,EnhancePack.ENGRAVE_COLOR.g,EnhancePack.ENGRAVE_COLOR.b,EnhancePack.ENGRAVE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackENGRAVE_COLOR", EnhancePack.ENGRAVE_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorArti") then
			EnhancePack.ARTIFACT_COLOR.r,EnhancePack.ARTIFACT_COLOR.g,EnhancePack.ARTIFACT_COLOR.b,EnhancePack.ARTIFACT_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackARTIFACT_COLOR", EnhancePack.ARTIFACT_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorSet") then
			EnhancePack.SET_COLOR.r,EnhancePack.SET_COLOR.g,EnhancePack.SET_COLOR.b,EnhancePack.SET_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackSET_COLOR", EnhancePack.SET_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorAlert") then
			EnhancePack.ALERT_COLOR.r,EnhancePack.ALERT_COLOR.g,EnhancePack.ALERT_COLOR.b,EnhancePack.ALERT_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackALERT_COLOR", EnhancePack.ALERT_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorDanger") then
			EnhancePack.DANGER_COLOR.r,EnhancePack.DANGER_COLOR.g,EnhancePack.DANGER_COLOR.b,EnhancePack.DANGER_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackDANGER_COLOR", EnhancePack.DANGER_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPhys") then
			EnhancePack.PHYSICAL.r,EnhancePack.PHYSICAL.g,EnhancePack.PHYSICAL.b,EnhancePack.PHYSICAL.a  = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPHYSICAL", EnhancePack.PHYSICAL)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorFire") then
			EnhancePack.FIRE.r,EnhancePack.FIRE.g,EnhancePack.FIRE.b,EnhancePack.FIRE.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackFIRE", EnhancePack.FIRE)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorCold") then
			EnhancePack.COLD.r,EnhancePack.COLD.g,EnhancePack.COLD.b,EnhancePack.COLD.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackCOLD", EnhancePack.COLD)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPois") then
			EnhancePack.POISON.r,EnhancePack.POISON.g,EnhancePack.POISON.b,EnhancePack.POISON.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPOISON", EnhancePack.POISON)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorEner") then
			EnhancePack.ENERGY.r,EnhancePack.ENERGY.g,EnhancePack.ENERGY.b,EnhancePack.ENERGY.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackENERGY", EnhancePack.ENERGY)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorChaos") then
			EnhancePack.Chaos.r,EnhancePack.Chaos.g,EnhancePack.Chaos.b,EnhancePack.Chaos.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackChaos", EnhancePack.Chaos)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHeal") then
			EnhancePack.Heal.r,EnhancePack.Heal.g,EnhancePack.Heal.b,EnhancePack.Heal.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackHeal", EnhancePack.Heal)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorCurse") then
			EnhancePack.Curse.r,EnhancePack.Curse.g,EnhancePack.Curse.b,EnhancePack.Curse.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackCurse", EnhancePack.Curse)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPara") then
			EnhancePack.Paralyze.r,EnhancePack.Paralyze.g,EnhancePack.Paralyze.b,EnhancePack.Paralyze.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackParalyze", EnhancePack.Paralyze)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorNeutral") then
			EnhancePack.Neutral.r,EnhancePack.Neutral.g,EnhancePack.Neutral.b,EnhancePack.Neutral.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackNeutral", EnhancePack.Neutral)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorNeg") then
			EnhancePack.OverHeadError.r,EnhancePack.OverHeadError.g,EnhancePack.OverHeadError.b,EnhancePack.OverHeadError.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackOverHeadError", EnhancePack.OverHeadError)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPos") then
			EnhancePack.SpecialColor.r,EnhancePack.SpecialColor.g,EnhancePack.SpecialColor.b,EnhancePack.SpecialColor.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackSpecialColor", EnhancePack.SpecialColor)
			
			
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCountdown") then
			HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b,HotbarSystem.CountdownTimer.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemCountdownTimer", HotbarSystem.CountdownTimer)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBPlain") then
			HotbarSystem.Plain.r,HotbarSystem.Plain.g,HotbarSystem.Plain.b,HotbarSystem.Plain.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemPlain", HotbarSystem.Plain)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBControl") then
			HotbarSystem.Control.r,HotbarSystem.Control.g,HotbarSystem.Control.b,HotbarSystem.Control.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControl", HotbarSystem.Control)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBAlt") then
			HotbarSystem.Alt.r,HotbarSystem.Alt.g,HotbarSystem.Alt.b,HotbarSystem.Alt.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemAlt", HotbarSystem.Alt)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBShift") then
			HotbarSystem.Shift.r,HotbarSystem.Shift.g,HotbarSystem.Shift.b,HotbarSystem.Shift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemShift", HotbarSystem.Shift)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCtrlalt") then
			HotbarSystem.ControlAlt.r,HotbarSystem.ControlAlt.g,HotbarSystem.ControlAlt.b,HotbarSystem.ControlAlt.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlAlt", HotbarSystem.ControlAlt)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBAltShift") then
			HotbarSystem.AltShift.r,HotbarSystem.AltShift.g,HotbarSystem.AltShift.b,HotbarSystem.AltShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemAltShift", HotbarSystem.AltShift)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCtrlAltShift") then
			HotbarSystem.ControlAltShift.r,HotbarSystem.ControlAltShift.g,HotbarSystem.ControlAltShift.b,HotbarSystem.ControlAltShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlAltShift", HotbarSystem.ControlAltShift)
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCtrlShift") then
			HotbarSystem.ControlShift.r,HotbarSystem.ControlShift.g,HotbarSystem.ControlShift.b,HotbarSystem.ControlShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlShift", HotbarSystem.ControlShift)
			EnhancePack.UpdateHotbars()
			
		
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCurrent") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_CURRENT", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT])
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBSelf") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_SELF", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF])
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBCursor") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_CURSOR", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR])
			EnhancePack.UpdateHotbars()
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBStored") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_OBJECT_ID", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID])
			EnhancePack.UpdateHotbars()
			
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorHBBorder") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_NONE", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE])
			EnhancePack.UpdateHotbars()
		
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorYou") then
			EnhancePack.YOUGETAMAGE_COLOR.r,EnhancePack.YOUGETAMAGE_COLOR.g,EnhancePack.YOUGETAMAGE_COLOR.b,EnhancePack.YOUGETAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackYOUGETAMAGE_COLOR", EnhancePack.YOUGETAMAGE_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorPet") then
			EnhancePack.PETGETDAMAGE_COLOR.r,EnhancePack.PETGETDAMAGE_COLOR.g,EnhancePack.PETGETDAMAGE_COLOR.b,EnhancePack.PETGETDAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPETGETDAMAGE_COLOR", EnhancePack.PETGETDAMAGE_COLOR)
		elseif (MenuBarWindow.HuePickerWindowRequest== "colorEnemy") then
			EnhancePack.OTHERGETDAMAGE_COLOR.r,EnhancePack.OTHERGETDAMAGE_COLOR.g,EnhancePack.OTHERGETDAMAGE_COLOR.b,EnhancePack.OTHERGETDAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackOTHERGETDAMAGE_COLOR", EnhancePack.OTHERGETDAMAGE_COLOR)
		end
		MenuBarWindow.HuePickerWindowRequest= ""
	else
		HuePickerColorSelected(id,HuePickerWindow[id].ListType,huePicked)
	end
	DestroyWindow(this)
end


function HuePickerWindow.RequestTargetInfo(windowName)
	RequestTargetInfo()
	WindowRegisterEventHandler(windowName, SystemData.Events.TARGET_SEND_ID_CLIENT, "HuePickerWindow.RequestTargetInfoReceived")
end

function HuePickerWindow.RequestTargetInfoReceived()
	local objectId = SystemData.RequestInfo.ObjectId
	--Debug.Print("" .. objectId )

	WindowData.CurrentTarget.TargetId = objectId
	TargetWindow.UpdateObject()
	WindowSetShowing("TargetWindow", false)

	local this = SystemData.ActiveWindow.name
    	local huePickerWindow = WindowGetParent(this)
    if( objectId ~= 0) then 
		local item = WindowData.ObjectInfo[objectId]
		if (item ~= nil) then
			--Debug.Print("" .. item.hueId)
			local id = WindowGetId(huePickerWindow)
			WindowUnregisterEventHandler(windowName, SystemData.Events.TARGET_SEND_ID_CLIENT)
			Debug.Print(item.hueId)
			HuePickerWindow.PickColor(id, item.hueId, huePickerWindow)
			
		end
    end
    	
	

end

function HuePickerWindow.ColorPicked(windowName)
    local huePicked = ColorPickerWindow.colorSelected[windowName]    	
    local huePickerWindow = WindowGetParent(windowName)
    local id = WindowGetId(huePickerWindow)

	HuePickerWindow.PickColor(id,huePicked, huePickerWindow)


    DestroyWindow(huePickerWindow)
end