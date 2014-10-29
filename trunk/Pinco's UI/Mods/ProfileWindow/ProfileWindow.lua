----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ProfileWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

ProfileWindow.WindowName = "ProfileWindow"
ProfileWindow.ProfileLoaded = false
ProfileWindow.ProfileId = 0

ProfileWindow.delta = 0
ProfileWindow.Retries = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ProfileWindow.Initialize()
	WindowSetDimensions(ProfileWindow.WindowName, 400,500)
	WindowSetDimensions(ProfileWindow.WindowName .. "Top", 433,43)
	WindowSetDimensions(ProfileWindow.WindowName .. "Bottom", 433,18)
	WindowSetShowing(ProfileWindow.WindowName, false)
	WindowUtils.RestoreWindowPosition(ProfileWindow.WindowName)
	ProfileWindow.ProfileLoaded = false
	ProfileWindow.ProfileId = 0
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		TextEditBoxSetFont(ProfileWindow.WindowName.."ProfileEditScrollWChildText",  "font_verdana")
		LabelSetFont(ProfileWindow.WindowName.."ProfileViewScrollChildText",  "font_verdana", 12)
	else
		TextEditBoxSetFont(ProfileWindow.WindowName.."ProfileEditScrollWChildText",  "UO_DefaultText")
		LabelSetFont(ProfileWindow.WindowName.."ProfileViewScrollChildText",  "UO_DefaultText", 12)
	end
end

function ProfileWindow.Shutdown()
    WindowUtils.SaveWindowPosition(ProfileWindow.WindowName)
    SnapUtils.SnappableWindows["ProfileWindow"] = nil
end

function ProfileWindow.Update(timepass)
	ProfileWindow.delta = ProfileWindow.delta + timepass
	if (ProfileWindow.delta > 0.5) then
		ProfileWindow.delta = 0
		
		if (ProfileWindow.ProfileId ~= 0 and ProfileWindow.ProfileLoaded == false) then
			if (ProfileWindow.ProfileId == WindowData.CharProfile.Id) then
				PaperdollWindow.UpdateCharProfile(ProfileWindow.ProfileId)
			else
				
				ProfileWindow.Retries = ProfileWindow.Retries + 1
				if (ProfileWindow.Retries < 20) then
					SystemData.ActiveObject.Id = ProfileWindow.ProfileId
					BroadcastEvent(SystemData.Events.REQUEST_OPEN_CHAR_PROFILE)
				else
					ProfileWindow.ProfileLoaded = true
					ProfileWindow.Retries = 0
				end
			end
		end
	end
end
function ProfileWindow.TextChange()
	local x,y = WindowGetDimensions(ProfileWindow.WindowName.."ProfileEditScrollWChildText")
	y = y + 100
	WindowSetDimensions(ProfileWindow.WindowName.."ProfileEditScrollWChild", x, y)
	
	--ScrollWindowSetOffset( ProfileWindow.WindowName.."ProfileEditScrollW", y )
	ScrollWindowUpdateScrollRect( ProfileWindow.WindowName.."ProfileEditScrollW" )
end

function ProfileWindow.Close()
	local playerId = WindowData.PlayerStatus.PlayerId
	if (ProfileWindow.ProfileId == playerId) then

		local infoText = TextEditBoxGetText(ProfileWindow.WindowName.."ProfileEditScrollWChildText")
		UpdateCharProfile(ProfileWindow.ProfileId,infoText)
		WindowData.CharProfile.Info = infoText
	end
	TextEditBoxSetText(ProfileWindow.WindowName.."ProfileEditScrollWChildText",L"")
	LabelSetText(ProfileWindow.WindowName.."ProfileViewScrollChildText",L"")
	WindowUtils.SaveWindowPosition(ProfileWindow.WindowName)
	local windowName = "PaperdollWindow"..ProfileWindow.ProfileId
	if (ProfileWindow.ProfileId ~= 0) then
		ButtonSetPressedFlag( windowName.."ToggleProfile",false)
	end
	
	WindowSetShowing("ProfileWindow", false)
	ProfileWindow.ProfileLoaded = false
	ProfileWindow.ProfileId = 0
end