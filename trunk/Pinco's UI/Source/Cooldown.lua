----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Cooldown = {}

 
----------------------------------------------------------------
-- Cooldown Functions
----------------------------------------------------------------

function Cooldown.Initialize()
	local sc = WindowGetScale(WindowGetParent(SystemData.ActiveWindow.name))
	WindowSetScale(SystemData.ActiveWindow.name, sc)
end