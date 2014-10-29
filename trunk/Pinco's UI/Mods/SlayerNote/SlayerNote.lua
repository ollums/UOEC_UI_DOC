----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SlayerNote = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

SlayerNote.WindowName = "SlayerNote"
SlayerNote.LabelName = SlayerNote.WindowName .. "Label"
SlayerNote.Image = SlayerNote.WindowName .. "Image"
SlayerNote.Locked = false
SlayerNote.Note = L"" 

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function SlayerNote.Initialize()
    WindowUtils.RestoreWindowPosition(SlayerNote.WindowName)
    SnapUtils.SnappableWindows["SlayerNote"] = true
    WindowSetTintColor(SlayerNote.Image, 255,255,204)
    WindowSetAlpha( SlayerNote.WindowName, 1.0 )
    SlayerNote.Note = CustomSettings.LoadWString( "SlayerNoteNote", L"" )
    LabelSetText( SlayerNote.LabelName, SlayerNote.Note )
	SlayerNote.Locked = CustomSettings.LoadBoolean( "SlayerNoteLocked", false )
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(SlayerNote.LabelName,  "font_verdana_bold_shadow_med", 12)
	else
		LabelSetFont(SlayerNote.LabelName,  "UO_DefaultText", 12)
	end
	WindowSetShowing(SlayerNote.WindowName, EnhancePack.NoteWindow)
end

function SlayerNote.Shutdown()
    WindowUtils.SaveWindowPosition(SlayerNote.WindowName)
    SnapUtils.SnappableWindows["SlayerNote"] = nil
end

function SlayerNote.OnLButtonDown()
	if (not SlayerNote.Locked ) then
		SnapUtils.StartLittleWindowSnap(SlayerNote.WindowName)
		WindowSetMoving(SlayerNote.WindowName,true)
	else
		WindowSetMoving(SlayerNote.WindowName,false)
	end
end

function SlayerNote.OnRButtonDown()
	if ( SlayerNote.Locked ) then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 289),0,"unlock",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 290),0,"lock",2,false)
	end

	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 332),0,"reset",2,false)

	ContextMenu.ActivateLuaContextMenu(SlayerNote.ContextMenuCallback)
end
	
function SlayerNote.MouseOver()
	if (SlayerNote.Note ~= L"") then
		Tooltips.CreateTextOnlyTooltip(SlayerNote.WindowName, UI.GetCliloc(SystemData.Settings.Language.type, 656))
	else
		Tooltips.CreateTextOnlyTooltip(SlayerNote.WindowName, UI.GetCliloc(SystemData.Settings.Language.type, 657))
	end
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function SlayerNote.SetNote(text)
	CustomSettings.SaveWString( "SlayerNoteNote", text )
	SlayerNote.Note = text
	LabelSetText( SlayerNote.LabelName, SlayerNote.Note )
end

function SlayerNote.ContextMenuCallback( returnCode, param )	
	if ( returnCode=="reset" ) then
		SlayerNote.SetNote(L"")
	elseif ( returnCode=="unlock" ) then
		SlayerNote.Locked = false
		CustomSettings.SaveBoolean( "SlayerNoteLocked", SlayerNote.Locked  )
	elseif ( returnCode=="lock" ) then
		SlayerNote.Locked = true
		CustomSettings.SaveBoolean( "SlayerNoteLocked", SlayerNote.Locked  )
	end
end