DiabloHealth = {}
DiabloHealth.HPWidth = 0
DiabloHealth.HPHeight = 0
DiabloHealth.LastHPHeight = 0

function DiabloHealth.Initialize()
	CreateWindowFromTemplate("DiabloBottomBorderBG", "DiabloBottomBorder", "Root")
	WindowClearAnchors("DiabloBottomBorderBG")
	WindowAddAnchor("DiabloBottomBorderBG", "bottomLeft", "Root", "bottomLeft", 0, 0)
	CreateWindow("DiabloHealth", true)
	CreateWindow("DiabloMana", true)
	CreateWindow("DiabloStamina", true)
	
	WindowClearAnchors("DiabloStamina")
	WindowAddAnchor("DiabloStamina", "bottom", "Root", "bottom", 0, 2)
	
	CreateWindowFromTemplate("DiabloAlwaysRunrBT", "DiabloAlwaysRun", "Root")
	WindowClearAnchors("DiabloAlwaysRunrBT")
	WindowAddAnchor("DiabloAlwaysRunrBT", "left", "DiabloStamina", "right", -5, 0)
	
	
	
    local width,height = WindowGetDimensions( "DiabloHealthFill" )
    DiabloHealth.HPHeight = height
    DiabloHealth.HPWidth = width
    DiabloHealth.LastHPHeight = -1
    
    width,height = WindowGetDimensions( "DiabloManaFill" )
    DiabloHealth.MPHeight = height
    DiabloHealth.MPWidth = width 
    DiabloHealth.LastMPHeight = -1
    
    DiabloHealth.OriginalUpdateStatus = StatusWindow.UpdateStatus
    StatusWindow.UpdateStatus = DiabloHealth.UpdateStatus
    DiabloHealth.UpdateStatus()
    
    
    local texture = 1250
	local xSize, ySize
	local scaleX = 0.5
	texture, xSize, ySize = RequestGumpArt( texture )
	local textureSize = xSize
		
	if (textureSize < ySize) then
		textureSize = ySize
	end
	
	
	
	WindowSetDimensions(  "DiabloHealthTextBackground", xSize * scaleX, ySize * scaleX )
	DynamicImageSetTexture( "DiabloHealthTextBackground", texture, 0, 0 )
	--DynamicImageSetRotation( "DiabloHealthTextBackground", 90 )
	DynamicImageSetTextureScale( "DiabloHealthTextBackground", scaleX )
	--WindowSetTintColor( "DiabloHealthTextBackground", 128, 128, 128 )
	
	
	
	texture = 1250
	scaleX = 0.5
	texture, xSize, ySize = RequestGumpArt( texture )
	textureSize = xSize
		
	if (textureSize < ySize) then
		textureSize = ySize
	end
	
	
	WindowSetDimensions(  "DiabloManaTextBackground", xSize * scaleX, ySize * scaleX )
	DynamicImageSetTexture( "DiabloManaTextBackground", texture, 0, 0 )
	--DynamicImageSetRotation( "DiabloManaTextBackground", 90 )
	DynamicImageSetTextureScale( "DiabloManaTextBackground", scaleX )
	--WindowSetTintColor( "DiabloManaTextBackground", 128, 128, 128 )
	SnapUtils.SnappableWindows["DiabloMana"] = true
	SnapUtils.SnappableWindows["DiabloHealth"] = true
    DiabloHealth.CheckToggle()
end

function DiabloHealth.CheckToggle(oldvalue)
	if (EnhancePack.DiabloHealthEnable == oldvalue) then
		return
	end
	WindowSetShowing("DiabloBottomBorderBG", EnhancePack.DiabloHealthEnable)
	WindowSetShowing("DiabloHealth", EnhancePack.DiabloHealthEnable)
    WindowSetShowing("DiabloMana", EnhancePack.DiabloHealthEnable)
    WindowSetShowing("DiabloStamina", EnhancePack.DiabloHealthEnable)
    WindowSetShowing("DiabloAlwaysRunrBT", EnhancePack.DiabloHealthEnable)
    
    
    
   
	WindowSetShowing("DiabloManaTextBackground", EnhancePack.DiabloHealthNumbersEnable)
	WindowSetShowing("DiabloHealthTextBackground", EnhancePack.DiabloHealthNumbersEnable)
	WindowSetShowing("DiabloHealthLabel", EnhancePack.DiabloHealthNumbersEnable)
	WindowSetShowing("DiabloManaLabel", EnhancePack.DiabloHealthNumbersEnable)
	WindowSetShowing("DiabloStaminaLabel", EnhancePack.DiabloHealthNumbersEnable)
	
	if (EnhancePack.DiabloHealthEnable) then
		WindowSetShowing("StatusWindow", false)
		WindowSetShowing("DiabloStatusWindow", true)
		--WindowClearAnchors(DangerBar.WindowName)
		--WindowAddAnchor(DangerBar.WindowName, "left", "DiabloStatusWindow", "right",0, 0)
		--WindowSetParent(DangerBar.WindowName, "Root")
		--EnhancePack.LoadScale( DangerBar.WindowName )
		--WindowUtils.RestoreWindowPosition(DangerBar.WindowName)
		WindowClearAnchors("WarButton")
		WindowAddAnchor("WarButton", "right", "DiabloStatusWindow", "left", 5, 0)
		
	else
		WindowSetShowing("StatusWindow", true)
		WindowSetShowing("DiabloStatusWindow",false )
		--WindowClearAnchors(DangerBar.WindowName)
		--WindowAddAnchor(DangerBar.WindowName, "bottom", "StatusWindowStaminaBar", "center", 6, 25)
		--WindowSetParent(DangerBar.WindowName, "StatusWindow")
		WindowClearAnchors("WarButton")
		WindowAddAnchor("WarButton", "topright", "StatusWindow", "topright", 55, 5)
		EnhancePack.LoadScale( "StatusWindow" )
	end
  
end

function DiabloHealth.UpdateStatus()
    DiabloHealth.SetHealth( WindowData.PlayerStatus.CurrentHealth, WindowData.PlayerStatus.MaxHealth )
    DiabloHealth.SetMana( WindowData.PlayerStatus.CurrentMana, WindowData.PlayerStatus.MaxMana )
    HealthBarColor.UpdateHealthBarColor("DiabloHealthFill", WindowData.PlayerStatus.VisualStateId)
    if (DoesWindowNameExist("BleedAnim")) then
		HealthBarColor.UpdateHealthBarColor("BleedAnim", WindowData.PlayerStatus.VisualStateId)
	end
	
	if (DoesWindowNameExist("MeditAnim")) then
		WindowSetTintColor( "MeditAnim", 0, 0, 255 )
	end
    
    DiabloHealth.OriginalUpdateStatus()
    -- Why set and reset the dimensions? No clue. Window tinting doesn't seem to want to work if I don't do this.
    WindowSetDimensions( "DiabloHealthFill", DiabloHealth.HPWidth, DiabloHealth.LastHPHeight+1 )
    WindowSetDimensions( "DiabloHealthFill", DiabloHealth.HPWidth, DiabloHealth.LastHPHeight )
    
    WindowSetTintColor( "DiabloManaFill", 0, 0, 255 )
    WindowSetDimensions( "DiabloManaFill", DiabloHealth.HPWidth, DiabloHealth.LastMPHeight )
    WindowSetDimensions( "DiabloManaFill", DiabloHealth.HPWidth, DiabloHealth.LastMPHeight+1 )
    local perc = (WindowData.PlayerStatus.CurrentHealth/WindowData.PlayerStatus.MaxHealth)*100
	perc = math.floor(perc)
	local gb = math.floor(2.55 * perc)
	LabelSetTextColor("DiabloHealthLabel", 255, gb, gb)
    LabelSetText("DiabloHealthLabel", L"" .. WindowData.PlayerStatus.CurrentHealth )
     
    perc = (WindowData.PlayerStatus.CurrentMana/WindowData.PlayerStatus.MaxMana)*100
	perc = math.floor(perc)
	local gb = math.floor(2.55 * perc)
	LabelSetTextColor("DiabloManaLabel", 255, gb, gb)
    LabelSetText("DiabloManaLabel", L"" .. WindowData.PlayerStatus.CurrentMana )
    
    
    perc = (WindowData.PlayerStatus.CurrentStamina/WindowData.PlayerStatus.MaxStamina)*100
	perc = math.floor(perc)
	local gb = math.floor(2.55 * perc)
	LabelSetTextColor("DiabloStaminaLabel", 255, gb, gb)
    LabelSetText("DiabloStaminaLabel", L"" .. WindowData.PlayerStatus.CurrentStamina )
    
    WindowSetTintColor("DiabloStaminaBar", 255, gb, 0)
    StatusBarSetMaximumValue( "DiabloStaminaBar", WindowData.PlayerStatus.MaxStamina )	
	StatusBarSetCurrentValue( "DiabloStaminaBar", WindowData.PlayerStatus.CurrentStamina )
	
	ButtonSetPressedFlag( "DiabloAlwaysRunrBT", SystemData.Settings.GameOptions.alwaysRun )
end

function DiabloHealth.RunButton_OnMouseOver ()
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = 1234,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title = GetStringFromTid(1113150),
						body = GetStringFromTid(1115296)}
						
	ItemProperties.SetActiveItem(itemData)
	PartyHealthBar.mouseOverId = StatusWindow.CurPlayerId
end

function DiabloHealth.RunButton_OnLButtonUp()
	SystemData.Settings.GameOptions.alwaysRun = not SystemData.Settings.GameOptions.alwaysRun
	UserSettingsChanged()
	ButtonSetPressedFlag( "DiabloAlwaysRunrBT", SystemData.Settings.GameOptions.alwaysRun )
end

function DiabloHealth.SetHealth( current, maximum )
    local height = math.ceil( ( DiabloHealth.HPHeight * current ) / maximum )
    if height ~= DiabloHealth.LastHPHeight then
        DiabloHealth.LastHPHeight = height
        WindowSetDimensions( "DiabloHealthFill", DiabloHealth.HPWidth, height )
       
    end
end

function DiabloHealth.SetMana( current, maximum )
    local height = math.ceil( ( DiabloHealth.MPHeight * current ) / maximum )
    if height ~= DiabloHealth.LastMPHeight then
        DiabloHealth.LastMPHeight = height
        WindowSetDimensions( "DiabloManaFill", DiabloHealth.MPWidth, height )
    end
end
