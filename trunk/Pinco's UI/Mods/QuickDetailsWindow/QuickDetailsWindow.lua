----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

QuickDetailsWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
QuickDetailsWindow.Locked = false
QuickDetailsWindow.CurPlayerId = 0

QuickDetailsWindow.DetailLabelsCreated = false
QuickDetailsWindow.DetailLabels = { 
    {
        name="Tithing",
        tid=1060503,
        ctid="TithingPointsShort",
        getValue=function() return WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.TithingPoints))) end,
    },
    {
        name="Gold",
        tid=1061156,
        getValue=function() return WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.Gold))) end,
    },
    {
        name="Luck",
        tid=1061153,
        getValue=function() return WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.Luck))) end,
    },
    {
        name="Weight",
        tid=1061154,
        getValue=function() return WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.Weight)))..L"/"..WindowUtils.AddCommasToNumber(StringToWString(tostring(WindowData.PlayerStatus.MaxWeight))) end,
    },
    {
        name="Followers",
        tid=1078830,
        getValue=function() return StringToWString(tostring(WindowData.PlayerStatus.Followers).."/"..tostring(WindowData.PlayerStatus.MaxFollowers)) end,
    },
    {
        name="Lock",
        --tid=1078097,
        text = UI.GetCliloc(SystemData.Settings.Language.type, 290),
        getValue=function() QuickDetailsWindow.Locked=not QuickDetailsWindow.Locked; end,
    },
}


function QuickDetailsWindow.AddLabel( name, ctid, getValue, tid )
    if ctid ~= nil and name ~= "Lock" then
        table.insert( QuickDetailsWindow.DetailLabels, { name=name, ctid=ctid, getValue=getValue } )
    else
        table.insert( QuickDetailsWindow.DetailLabels, { name=name, tid=tid, getValue=getValue } )
    end
end

QuickDetailsWindow.DetailLabelsFontSetting = "QuickDetailLabelsFont"
QuickDetailsWindow.DetailLabelsLabelColorSetting = "QuickDetailLabelsLabelColor"
QuickDetailsWindow.DetailLabelsValueColorSetting = "QuickDetailLabelsValueColor"




----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function QuickDetailsWindow.Initialize()
	WindowSetShowing("QuickDetailsWindow", EnhancePack.EnableQuickDetail)
	WindowUtils.RestoreWindowPosition("QuickDetailsWindow")
	SnapUtils.SnappableWindows["QuickDetailsWindow"] = true
	QuickDetailsWindow.UpdateLabels()
	
	EnhancePack.LoadScale( "QuickDetailsWindow" )
	QuickDetailsWindow.Locked = CustomSettings.LoadBoolean( "QuickDetailsWindowLocked" , QuickDetailsWindow.Locked )
	
end

function QuickDetailsWindow.update(timepassed)
	if (WindowGetShowing("QuickDetailsWindow")) then
		QuickDetailsWindow.UpdateLabels()
	end
end

function QuickDetailsWindow.Shutdown()
	WindowUtils.SaveWindowPosition("QuickDetailsWindow")
	SnapUtils.SnappableWindows["QuickDetailsWindow"] = nil
end

function QuickDetailsWindow.Tooltip()
	Tooltips.CreateTextOnlyTooltip("QuickDetailsWindowDetailsTextRoot", UI.GetCliloc(SystemData.Settings.Language.type, 575))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function QuickDetailsWindow.Move()
	if (not QuickDetailsWindow.Locked ) then
		SnapUtils.StartWindowSnap("QuickDetailsWindow")
		WindowSetMoving("QuickDetailsWindow",true)
	else
		WindowSetMoving("QuickDetailsWindow",false)
	end
end

function QuickDetailsWindow.UpdateLabels()
    local basename = "QuickDetailsWindow"
    if not QuickDetailsWindow.DetailLabelsCreated then
        for i,v in ipairs( QuickDetailsWindow.DetailLabels ) do
			if (v.text ~= UI.GetCliloc(SystemData.Settings.Language.type, 290)) then
				local name = basename..v.name
				CreateWindowFromTemplate(name, "StatusDetailsTemplate", basename)
				local postfix = L":  "
				if v.noPostfix then
					postfix = L" "
				end
				if v.tid ~= nil then
					v.text = GetStringFromTid(v.tid)
				end
				if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN and CustomSettings.LoadBoolean( "QuickDetailsWindowDetails_Tithing", false  )) then
					WindowSetDimensions(name .. "Label", 280, 18)
				else
					WindowSetDimensions(name .. "Label", 120, 18)
				end
				LabelSetText( name.."Label", v.text..postfix )
				LabelSetText( name.."Value", L"???" )
				WindowClearAnchors( name.."Value" )
				WindowAddAnchor( name.."Value", "topright", name.."Label", "topleft", 0, 0 )
            end
        end
        QuickDetailsWindow.DetailLabelsCreated = true
        QuickDetailsWindow.UpdateLabelFonts()
    end
    local nextAnchor = { relative="QuickDetailsWindowDetailsTextRoot", x=7, y=5 } 
    local noneVisible = true
    for i,v in ipairs( QuickDetailsWindow.DetailLabels ) do
        local name = basename..v.name
        if CustomSettings.LoadBoolean( "QuickDetailsWindowDetails_"..v.name, false  ) and v.name ~= "Lock" then
            noneVisible = false
            
            WindowSetShowing( name, true )
            WindowClearAnchors( name )
            WindowAddAnchor( name, "topleft", nextAnchor.relative, "topleft", nextAnchor.x, nextAnchor.y )
          
			if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN and CustomSettings.LoadBoolean( "QuickDetailsWindowDetails_Tithing", false  )) then
				WindowSetDimensions(name .. "Label", 280, 18)
			else
				WindowSetDimensions(name .. "Label", 120, 18)
			end
			WindowClearAnchors( name.."Value" )
			WindowAddAnchor( name.."Value", "topright", name.."Label", "topleft", 0, 0 )
            nextAnchor = { relative=name, x=0, y=18 }
            LabelSetText( name.."Value", v.getValue() )
            if (v.name == "Weight") then
				local overweight = WindowData.PlayerStatus.Weight > WindowData.PlayerStatus.MaxWeight - 10
				if overweight then
					LabelSetTextColor(name.."Value", 255, 0, 0)
				else
					LabelSetTextColor(name.."Value", 255, 255, 255)
				end
            end
        elseif (v.name ~= "Lock") then
            WindowSetShowing( name, false )
        end
    end
end

function QuickDetailsWindow.UpdateLabelFonts()
    if QuickDetailsWindow.DetailLabelsCreated then
        local basename = "QuickDetailsWindow"
        local fontSetting = "font_verdana_italic_small"
        if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			fontSetting = "UO_DefaultText"
		end
        local labelColor = CustomSettings.LoadColor( QuickDetailsWindow.DetailLabelsLabelColorSetting, { r=186, g=186, b=132 }  )
        local valueColor = CustomSettings.LoadColor( QuickDetailsWindow.DetailLabelsValueColorSetting, { r=255, g=255, b=255 }  )
        for i,v in ipairs( QuickDetailsWindow.DetailLabels ) do
			if v.name ~= "Lock" then
				local name = basename..v.name
				if fontSetting ~= nil then
					LabelSetFont(name.."Label", fontSetting, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
					LabelSetFont(name.."Value", fontSetting, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
				end
				LabelSetTextColor(name.."Label", labelColor.r, labelColor.g, labelColor.b)
				LabelSetTextColor(name.."Value", valueColor.r, valueColor.g, valueColor.b)
			end
        end
    end
end



function QuickDetailsWindow.ShowDetailsContextMenu()
    for i,v in ipairs( QuickDetailsWindow.DetailLabels ) do
        local visible = CustomSettings.LoadBoolean( "QuickDetailsWindowDetails_"..v.name, false )
        if v.tid ~= nil then
            v.text = GetStringFromTid(v.tid)
        end
        local str = v.text
        if v.noPostfix then
            str = wstring.sub( str, 0, wstring.len(str)-2 )
        end
        ContextMenu.CreateLuaContextMenuItemWithString( str, 0, i, not visible, visible )
    end
    ContextMenu.ActivateLuaContextMenu(QuickDetailsWindow.ShowDetailsContextMenuCallback)
end

function QuickDetailsWindow.ShowDetailsContextMenuCallback( returnCode, param )
    if param ~= nil then
        CustomSettings.SaveBoolean( "QuickDetailsWindowDetails_"..QuickDetailsWindow.DetailLabels[returnCode].name, param  )
        QuickDetailsWindow.UpdateLabels()
        if (QuickDetailsWindow.DetailLabels[returnCode].name == "Lock") then
			QuickDetailsWindow.Locked=not QuickDetailsWindow.Locked
			CustomSettings.SaveBoolean( "QuickDetailsWindowLocked" , QuickDetailsWindow.Locked )
        end
    end
end

