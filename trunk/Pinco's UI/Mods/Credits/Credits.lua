----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CreditsWindow = {}

-- OnInitialize Handler
function CreditsWindow.Initialize()

	
	WindowUtils.SetWindowTitle("CreditsWindow", UI.GetCliloc(SystemData.Settings.Language.type, 765))
    WindowSetShowing("CreditsWindow", false)
   
   
	
	ScrollWindowUpdateScrollRect( "CreditsContentWindow" )
	local text = LoadTextFile("./UserInterface/"..SystemData.Settings.Interface.customUiName.."/credits.txt")
	LabelSetText("CreditsWindowText1", text)
	AnimatedImageStartAnimation( "AnimLogo", 1, true, false, 0.0 ) 
end


function CreditsWindow.Shutdown()
	WindowSetShowing("CreditsWindow", false)   

	if (EnhancePack.CurrentAreaMusic) then
		PlaySound(1, EnhancePack.CurrentAreaMusic, 2)
	else	
		PlaySound(1, "", 1)
	end
							
end

local i = 0
function CreditsWindow.OnUpdate(timepassed)

	local dontCare, maxOffset = WindowGetDimensions("CreditsContentWindowScrollChild")
	i = i + 0.5
	ScrollWindowSetOffset("CreditsContentWindow", i )
	if i >= maxOffset then
		i = 0
	end
	
end

function CreditsWindow.OnShown()
	i = 0
	EnhancePack.DisableAreaMusic = true
	PlaySound(1, "credits.mp3", 2)
	WindowSetShowing("MainMenuWindow",false)
end

function CreditsWindow.Close()
	EnhancePack.DisableAreaMusic = false
	 if (EnhancePack.CurrentAreaMusic) then
		PlaySound(1, EnhancePack.CurrentAreaMusic, 2)
	else	
		PlaySound(1, "WildSong" .. math.random(EnhancePack.WildSongs) .. ".mp3", 2)
	end
end