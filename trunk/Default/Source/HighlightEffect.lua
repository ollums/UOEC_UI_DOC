
HighlightEffect = {}
HighlightEffectManager = { knownWindows = {} }

function HighlightEffect.Initialize()
	local NewWindow = HighlightEffect:new()
	NewWindow.windowName = SystemData.ActiveWindow.name
	NewWindow:Init()
end


function HighlightEffect:new( NewWindow )
	NewWindow = NewWindow or {}
	setmetatable( NewWindow, self )
	self.__index = self

	return NewWindow
end


function HighlightEffect:Init()

	self.timer = 0.0
	self.animStarted = false
	
	HighlightEffectManager.knownWindows[self.windowName] = self
    RegisterWindowData(WindowData.HighlightEffect.Type, 0)
end



function HighlightEffect.Update( timePassed )
	
	local self = HighlightEffectManager.knownWindows[WindowUtils.GetActiveDialog()]
	
	local startHighlight = WindowData.HighlightEffect.startHighlight
	if(startHighlight) then
		--Set it back to false so next time we will not have it started again.
		WindowData.HighlightEffect.startHighlight = false
		self.timer = WindowData.HighlightEffect.highlightTime
		local offsetX = 0
		local offsetY = 0
		if(WindowData.HighlightEffect.windowToHighlight == "StatusWindow") then
			offsetX = -95
		end
		if(WindowData.HighlightEffect.windowToHighlight == "Hotbar1") then
			offsetX = -168
			offsetY = -4
		end
		
		WindowClearAnchors(self.windowName)
		WindowAddAnchor(self.windowName,"center",WindowData.HighlightEffect.windowToHighlight,"center", offsetX, offsetY)	
	end
			
	--We have a strange bug that displays the highlight at the upper-left corner. I don't know what is the cause.
	--And this is a random bug that is hard to track down. So I am doing this hard coded logic to always turn off
	--highlighting when the position is at the upper-left corner.
	local anchorPosX, anchorPosY = WindowGetScreenPosition(self.windowName)
	if(anchorPosX < 5 and anchorPosY < 5) then
		self.timer = 0
	end

	if (self.timer - timePassed > 0) then
		if (not self.animStarted) then 
			AnimatedImageStartAnimation( self.windowName.."GlowAnim", 1, true, false, 0.0 )        
			self.animStarted = true
		end
		self.timer = self.timer - timePassed
	else
		AnimatedImageStopAnimation(self.windowName.."GlowAnim")
		self.animStarted = false
		HighlightEffect.OnCloseWindow()
	end
end	

-- OnClose handler
function HighlightEffect.OnCloseWindow()
	local self = HighlightEffectManager.knownWindows[WindowUtils.GetActiveDialog()]
	DestroyWindow( self.windowName )
end

-- OnShutdownHandler
function HighlightEffect.OnShutdown()
    UnregisterWindowData(WindowData.HighlightEffect.Type,0)
	HighlightEffectManager.knownWindows[WindowUtils.GetActiveDialog()] = nil
end
