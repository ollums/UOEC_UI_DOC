----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DamageWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
DamageWindow.AttachedId = {}
--Used to shift the Y position to the max before it disappears off the screen
DamageWindow.OverheadAlive = -150
DamageWindow.OverheadMove = 1
DamageWindow.FadeStart = -10
DamageWindow.FadeDiff = 0.01
DamageWindow.DefaultAnchorY = 40
DamageWindow.ShiftYAmount = 15
DamageWindow.MaxAnchorYOverlap = 15
DamageWindow.AnchorY = {}
 
----------------------------------------------------------------
-- DamageWindow Functions
----------------------------------------------------------------
function DamageWindow.Initialize()
	WindowRegisterEventHandler("Root", SystemData.Events.DAMAGE_NUMBER_INIT, "DamageWindow.Init")
end

--Creates a new window for the mobile Id and set the label text of the damage amount
function DamageWindow.Init()
	local numWindow = Damage.numWindow
	local windowName = "DamageWindow"..numWindow
	local labelName = windowName.."Text"
	
	CreateWindowFromTemplateShow(windowName, "DamageWindow", "Root", false)
	AttachWindowToWorldObject(Damage.mobileId, windowName)
	
	--Shifts the previous damage numbers up if its too close to the new damage numbers
	--this way the damage numbers would not cover each other up
	DamageWindow.ShiftYWindowUp()
	
	--Set the time pass to 0 
	DamageWindow.AttachedId[numWindow] = Damage.mobileId
	DamageWindow.AnchorY[numWindow] = DamageWindow.DefaultAnchorY
	LabelSetText(labelName, L""..Damage.damageNumber)
	LabelSetTextColor(labelName, Damage.red, Damage.green, Damage.blue)
	
	WindowAddAnchor(labelName, "bottom", windowName, "bottom", 0, DamageWindow.DefaultAnchorY)
end

-- If the previous Damage Number Y anchor too close to the new damage window, increase all the damage numbers y anchors
function DamageWindow.ShiftYWindowUp()
	if DamageWindow.IsOverlap() then
		for i, id in pairs(DamageWindow.AttachedId) do
			DamageWindow.AnchorY[i] = DamageWindow.AnchorY[i] - DamageWindow.ShiftYAmount
			windowName = "DamageWindow"..i
  			labelName = windowName.."Text"
  			WindowClearAnchors(labelName)
  			WindowAddAnchor(labelName, "bottomleft",windowName , "bottomleft", 0, DamageWindow.AnchorY[i])
		end
	end
end

function DamageWindow.IsOverlap()
	for i, id in pairs(DamageWindow.AttachedId) do
		if (DamageWindow.AnchorY[i] >= DamageWindow.MaxAnchorYOverlap ) then
  			return true
  		end
  	end
  	return false
end

--The damage number moves up and slowly disappears off the screen
function DamageWindow.UpdateTime(UpdateInterfaceTime)
	local count = 0
	for i, id in pairs(DamageWindow.AttachedId) do
		DamageWindow.AnchorY[i] = DamageWindow.AnchorY[i] - DamageWindow.OverheadMove
  
		if (DamageWindow.AnchorY[i] < DamageWindow.OverheadAlive) then
			DetachWindowFromWorldObject(id, "DamageWindow"..i)
			DestroyWindow("DamageWindow"..i)
			DamageWindow.AnchorY[i] = 0
			DamageWindow.AttachedId[i] = nil
		else
			local windowName = "DamageWindow"..i
			local labelName = windowName.."Text"
			WindowClearAnchors(labelName)
			WindowAddAnchor(labelName, "bottom", windowName ,"bottom", 0, DamageWindow.AnchorY[i])
		end
		count = count +1
	end

	--If count is zero reset the numWindow to 1
	if( count == 0 ) then
		Damage.numWindow = 0
	end
end


