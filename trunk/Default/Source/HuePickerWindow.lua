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
    local id = WindowData.HuePicker.ObjectId
    local windowName = SystemData.ActiveWindow.name
    
    HuePickerWindow[id] = {}
    HuePickerWindow[id].ListType = WindowData.HuePicker.ListType
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
	local sliderName = SystemData.ActiveWindow.name
	local id = WindowGetId(sliderName)
	local windowName = "HuePicker"..id
	
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

function HuePickerWindow.ColorPicked(windowName)
    local huePickerWindow = WindowGetParent(windowName)
    local id = WindowGetId(huePickerWindow)
    local huePicked = ColorPickerWindow.colorSelected[windowName]
    
    HuePickerColorSelected(id,HuePickerWindow[id].ListType,huePicked)
    
    DestroyWindow(huePickerWindow)
end