----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Moongate = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Moongate.WindowName = "Moongate"

Moongate.GumpName = ""
Moongate.FirstAttr = 0
Moongate.Siege = false
Moongate.Red = false
Moongate.Locations = {}

Moongate.LastGate = "Moonglow-trammel"
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function Moongate.Initialize()
	WindowSetDimensions(Moongate.WindowName, 600,540)
	SnapUtils.SnappableWindows[Moongate.WindowName] = true
	WindowUtils.RestoreWindowPosition(Moongate.WindowName,true)
	WindowUtils.SetWindowTitle(Moongate.WindowName,GetStringFromTid(1023948))  -- Moongate
	WindowSetDimensions(Moongate.WindowName,  600,540)
	
	LabelSetText( Moongate.WindowName .. "TrammelLabel", GetStringFromTid(1012000) ) -- L"Trammel"
	WindowSetId( Moongate.WindowName .. "TrammelLabel", 1012000 )
	ButtonSetCheckButtonFlag( Moongate.WindowName .. "TrammelButton", true )
	
	LabelSetText( Moongate.WindowName .. "FeluccaLabel", GetStringFromTid(1012001) ) -- L"Felucca"
	WindowSetId( Moongate.WindowName .. "FeluccaLabel", 1012001 )
	ButtonSetCheckButtonFlag( Moongate.WindowName .. "FeluccaButton", true )
	
	LabelSetText( Moongate.WindowName .. "IlshenarLabel", GetStringFromTid(1012002) ) -- L"Ilshenar"
	WindowSetId( Moongate.WindowName .. "IlshenarLabel", 1012002 )
	ButtonSetCheckButtonFlag( Moongate.WindowName .. "IlshenarButton", true )
	
	LabelSetText( Moongate.WindowName .. "MalasLabel", GetStringFromTid(1060643) ) -- L"Malas"
	WindowSetId( Moongate.WindowName .. "MalasLabel", 1060643 )
	ButtonSetCheckButtonFlag( Moongate.WindowName .. "MalasButton", true )
	
	LabelSetText( Moongate.WindowName .. "TokunoLabel", GetStringFromTid(1063258) ) -- L"Tokuno Islands"
	WindowSetId( Moongate.WindowName .. "TokunoLabel", 1063258 )
	ButtonSetCheckButtonFlag( Moongate.WindowName .. "TokunoButton", true )
	
	LabelSetText( Moongate.WindowName .. "TerMurLabel", GetStringFromTid(1112178) ) -- L"Ter Mur"
	WindowSetId( Moongate.WindowName .. "TerMurLabel", 1112178 )
	ButtonSetCheckButtonFlag( Moongate.WindowName .. "TerMurButton", true )

	
	LabelSetText( Moongate.WindowName .. "DestLabel", GetStringFromTid(1012011) ) -- L"Destination"
	WindowSetId( Moongate.WindowName .. "DestLabel", 1012011 )
	
	ButtonSetText(Moongate.WindowName .. "Go", GetStringFromTid(3010006)) -- L"GO!"
	ButtonSetText(Moongate.WindowName .. "GoDefault", UI.GetCliloc(SystemData.Settings.Language.type, 5032)) -- Default Location
	ButtonSetText(Moongate.WindowName .. "SetDefault", WindowUtils.Decapitalizing(GetStringFromTid(1011300))) -- L"Set default!"
	
	
	WindowSetShowing("MoongateTrammelWindow", false)
	WindowSetShowing("MoongateFeluccaWindow", false)
	WindowSetShowing("MoongateIlshenarWindow", false)
	WindowSetShowing("MoongateMalasWindow", false)
	WindowSetShowing("MoongateTokunoWindow", false)
	WindowSetShowing("MoongateTerMurWindow", false)
	
	
	Moongate.LastGate = "Moonglow-trammel"
end

function Moongate.ResetID()
	local trammel = 0
	local felucca = 0
	
	for key, value in pairs(Moongate.Locations) do
		if value and not tonumber(value) then
			if (value.trammel) then
				trammel = trammel +1
			end
			if (value.felucca) then
				felucca = felucca +1
			end
		end
	end

	if Moongate.Locations["Bucca"] then
		felucca = felucca + 1
	end
	
	if Moongate.Locations["Haven"] then
		trammel = trammel + 1
	end
	
	local ilshenar = 0
	
	if Moongate.Locations["Compassion"] then
		ilshenar = ilshenar + 1
	elseif Moongate.Locations["Honesty"] then
		ilshenar = ilshenar + 1
	elseif Moongate.Locations["Honor"] then
		ilshenar = ilshenar + 1
	elseif Moongate.Locations["Humilty"] then
		ilshenar = ilshenar + 1
	elseif Moongate.Locations["Justice"] then
		ilshenar = ilshenar + 1
	elseif Moongate.Locations["Sacrifice"] then
		ilshenar = ilshenar + 1
	elseif Moongate.Locations["Spirituality"] then
		ilshenar = ilshenar + 1
	elseif Moongate.Locations["Valor"] then
		ilshenar = ilshenar + 1
	elseif Moongate.Locations["Chaos"] then
		ilshenar = ilshenar + 1
	end
	
	local malas = 0
	
	if Moongate.Locations["Luna"] then
		malas = malas + 1
	elseif Moongate.Locations["Umbra"] then
		malas = malas + 1
	end
	
	local tokuno = 0
	
	if Moongate.Locations["Isamu"] then
		tokuno = tokuno + 1
	elseif Moongate.Locations["Makoto"] then
		tokuno = tokuno + 1
	elseif Moongate.Locations["Homare"] then
		tokuno = tokuno + 1
	end
	
	local termur = 0
	
	if Moongate.Locations["RoyalCity"] then
		termur = termur + 1
	end
	
	local childWindow = "MoongateTrammelWindowScrollChild"
	local city = ""
	
	if trammel > 0 then
		city = "Moonglow"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012003) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].trammel))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Britain"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012004) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].trammel))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Jhelom"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012005) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].trammel))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Yew"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012006) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].trammel))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Minoc"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012007) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].trammel))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Trinsic"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012008) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].trammel))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "SkaraBrae"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012009) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].trammel))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Magincia"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012010) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].trammel))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Haven"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1113577) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		WindowSetShowing("MoongateTrammel", true)
	else
		WindowSetShowing("MoongateTrammel", false)
	end
	
	
	childWindow = "MoongateFeluccaWindowScrollChild"
	if felucca > 0 then
		city = "Moonglow"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012003) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].felucca))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Britain"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012004) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].felucca))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Jhelom"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012005) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].felucca))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Yew"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012006) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].felucca))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Minoc"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012007) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].felucca))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Trinsic"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012008) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].felucca))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "SkaraBrae"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012009) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].felucca))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Magincia"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1012010) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city].felucca))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Bucca"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1019001) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		WindowSetShowing("MoongateFelucca", true)
	else
		WindowSetShowing("MoongateFelucca", false)
	end
	
	
	
	childWindow = "MoongateIlshenarWindowScrollChild"
	if ilshenar > 0 then
		city = "Compassion"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1051002) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Honesty"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1051007) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Honor"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1051005) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Humilty"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1051000) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Justice"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1051006) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Sacrifice"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1051001) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Spirituality"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1051003) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Valor"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1051004) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Chaos"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1025347) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		WindowSetShowing("MoongateIlshenar", true)
	else
		WindowSetShowing("MoongateIlshenar", false)
	end
	
	childWindow = "MoongateMalasWindowScrollChild"
	if malas > 0 then
		city = "Luna"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1060641) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Umbra"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1060642) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		WindowSetShowing("MoongateMalas", true)
	else
		WindowSetShowing("MoongateMalas", false)
	end
	
	childWindow = "MoongateTokunoWindowScrollChild"
	if tokuno > 0 then
		city = "Isamu"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1063412) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Makoto"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1063413) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		
		city = "Homare"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1063414) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		WindowSetShowing("MoongateTokuno", true)
	else
		WindowSetShowing("MoongateTokuno", false)
	end
	
	
	childWindow = "MoongateTerMurWindowScrollChild"
	
	
	if termur > 0 then
		city = "RoyalCity"
		LabelSetText( childWindow .. city .. "Label", GetStringFromTid(1112571) )
		if Moongate.Locations[city] then
			WindowSetId(childWindow .. city .. "Label", tonumber(Moongate.Locations[city]))
			ButtonSetCheckButtonFlag( childWindow .. city .. "Button", true )
			WindowSetShowing(childWindow .. city, true)
		else
			WindowSetShowing(childWindow .. city, false)
		end
		WindowSetShowing("MoongateTerMur", true)
	else
		WindowSetShowing("MoongateTerMur", false)
	end
end

function Moongate.OnUpdate(timePassed)
	if not DoesWindowNameExist(Moongate.GumpName) then
		WindowSetShowing(Moongate.WindowName, false)
	else
		if not EnhancePack.DEBUGMODE then
			WindowSetShowing(Moongate.GumpName, false)
		end
	end
		
end

function Moongate.OnHidden()
	WindowUtils.SaveWindowPosition(Moongate.WindowName)
	DestroyWindow(Moongate.GumpName)
end

function Moongate.Shutdown()

	SnapUtils.SnappableWindows[Moongate.WindowName] = nil
	WindowUtils.SaveWindowPosition(Moongate.WindowName)
	WindowSetShowing(Moongate.WindowName,false)
	if DoesWindowNameExist(Moongate.GumpName) then
		DestroyWindow(Moongate.GumpName)
	end
	DestroyWindow(Moongate.WindowName)
	
end

function Moongate.SetDefault()
	if (Moongate.LastGate ~= "Moonglow-trammel") then
		CustomSettings.SaveString( "MoongateLastGate" , Moongate.LastGate )
		EnhancePack.ChatPrint(GetStringFromTid(502417), SystemData.ChatLogFilters.SYSTEM ) -- New default location set.
	else
		EnhancePack.ChatPrint(UI.GetCliloc(SystemData.Settings.Language.type, 5033), SystemData.ChatLogFilters.SYSTEM ) -- New default location set.
	end
end

function Moongate.GODefault()
	if not WindowGetShowing(Moongate.WindowName) then
		EnhancePack.ChatPrint(UI.GetCliloc(SystemData.Settings.Language.type, 5040), SystemData.ChatLogFilters.SYSTEM )
		return
	end
	
	local buttonId = CustomSettings.LoadString( "MoongateLastGate", "Moonglow-trammel" )
	
	if (string.find(buttonId, "-trammel")) then
		buttonId= Moongate.Locations[string.gsub(buttonId, "-trammel", "")].trammel
	elseif (string.find(buttonId, "-felucca")) then
		buttonId= Moongate.Locations[string.gsub(buttonId, "-felucca", "")].felucca
	else
		buttonId= Moongate.Locations[buttonId]
	end
	
	if (buttonId ~= -1) then
		Moongate.ClearAllChecks()
		gumpId = WindowGetId("GenericGumpItem" .. buttonId)
		windowName = "GenericGumpItem" .. buttonId
		ButtonSetPressedFlag(windowName, true)
		Moongate.GO()
	else
		EnhancePack.ChatPrint(UI.GetCliloc(SystemData.Settings.Language.type, 5034), SystemData.ChatLogFilters.SYSTEM ) -- New default location set.
	end
end

function Moongate.OnShown()
	WindowUtils.RestoreWindowPosition(Moongate.WindowName,true)
	Moongate.LastGate = "Moonglow-trammel"
	
	if (Moongate.Siege) then
		WindowSetShowing(Moongate.WindowName .. "Trammel", false)
		if (Moongate.Red) then
			WindowSetShowing(Moongate.WindowName .. "Ilshenar", false)
			WindowSetShowing(Moongate.WindowName .. "Malas", false)	
			WindowSetShowing(Moongate.WindowName .. "Tokuno", false)	
			WindowSetShowing(Moongate.WindowName .. "TerMur", false)	
		end
	else
		WindowSetShowing(Moongate.WindowName .. "Trammel", true)
		WindowSetShowing(Moongate.WindowName .. "Ilshenar", true)
		WindowSetShowing(Moongate.WindowName .. "Malas", true)	
		WindowSetShowing(Moongate.WindowName .. "Tokuno", true)	
		WindowSetShowing(Moongate.WindowName .. "TerMur", true)
	end
	
	Moongate.ClearAllChecks()

	if (WindowData.PlayerLocation.facet == 0) then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", true)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", false)
		
		Moongate.ResetID()
		
		return
	end
	
	if (WindowData.PlayerLocation.facet == 1) then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		
		WindowSetShowing("MoongateTrammelWindow", true)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", false)
		
		Moongate.ResetID()
		
		return
	end
	
	if (WindowData.PlayerLocation.facet == 2) then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", true)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", false)
		
		Moongate.ResetID()
		
		return
	end
	
	if (WindowData.PlayerLocation.facet == 3) then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", true)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", false)
	
		Moongate.ResetID()
		
		return
	end
	
	if (WindowData.PlayerLocation.facet == 4) then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", true)
		WindowSetShowing("MoongateTerMurWindow", false)
		
		Moongate.ResetID()
		
		return
	end
	
	if (WindowData.PlayerLocation.facet == 5) then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", true )
		
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", true)
		
		Moongate.ResetID()
		
		return
	end
end


function Moongate.ClearAllChecks()
	for key, value in pairs(Moongate.Locations) do
		if value and tonumber(value) then
			local gumpId = WindowGetId("GenericGumpItem" ..  tonumber(value))
			local windowName = "GenericGumpItem" ..  tonumber(value)
			ButtonSetPressedFlag(windowName, false)
		else
			if (value.trammel) then
				local gumpId = WindowGetId("GenericGumpItem" ..  tonumber(value.trammel))
				local windowName = "GenericGumpItem" ..  tonumber(value.trammel)
				ButtonSetPressedFlag(windowName, false)
			end
			if value.felucca then
				local gumpId = WindowGetId("GenericGumpItem" .. tonumber(value.felucca))
				local windowName = "GenericGumpItem" ..  tonumber(value.felucca)
				ButtonSetPressedFlag(windowName, false)
			end
		end
	end
	
	
	local childWindow = "MoongateFeluccaWindowScrollChild"

	ButtonSetPressedFlag( childWindow .. "MoonglowButton",  false )
	ButtonSetPressedFlag( childWindow .. "BritainButton",  false )
	ButtonSetPressedFlag( childWindow .. "JhelomButton",  false )
	ButtonSetPressedFlag( childWindow .. "YewButton",  false )
	ButtonSetPressedFlag( childWindow .. "MinocButton",  false )
	ButtonSetPressedFlag( childWindow .. "TrinsicButton",  false )
	ButtonSetPressedFlag( childWindow .. "SkaraBraeButton",  false )
	ButtonSetPressedFlag( childWindow .. "MaginciaButton",  false )
	ButtonSetPressedFlag( childWindow .. "BuccaButton",  false )
	
	childWindow = "MoongateTrammelWindowScrollChild"

	ButtonSetPressedFlag( childWindow .. "MoonglowButton", false )
	ButtonSetPressedFlag( childWindow .. "BritainButton", false ) 
	ButtonSetPressedFlag( childWindow .. "JhelomButton", false )
	ButtonSetPressedFlag( childWindow .. "YewButton", false )
	ButtonSetPressedFlag( childWindow .. "MinocButton", false )
	ButtonSetPressedFlag( childWindow .. "TrinsicButton", false )
	ButtonSetPressedFlag( childWindow .. "SkaraBraeButton", false )
	ButtonSetPressedFlag( childWindow .. "MaginciaButton", false )
	ButtonSetPressedFlag( childWindow .. "HavenButton", false )
	
	childWindow = "MoongateIlshenarWindowScrollChild"
		
	ButtonSetPressedFlag( childWindow .. "CompassionButton", false )
	ButtonSetPressedFlag( childWindow .. "HonestyButton", false )
	ButtonSetPressedFlag( childWindow .. "HonorButton", false ) 
	ButtonSetPressedFlag( childWindow .. "HumiltyButton", false ) 
	ButtonSetPressedFlag( childWindow .. "JusticeButton", false )
	ButtonSetPressedFlag( childWindow .. "SacrificeButton", false )
	ButtonSetPressedFlag( childWindow .. "SpiritualityButton", false )
	ButtonSetPressedFlag( childWindow .. "ValorButton", false )
	ButtonSetPressedFlag( childWindow .. "ChaosButton", false )
	
	childWindow = "MoongateMalasWindowScrollChild"
	
	ButtonSetPressedFlag( childWindow .. "LunaButton", false )
	ButtonSetPressedFlag( childWindow .. "UmbraButton", false )
	
	childWindow = "MoongateTokunoWindowScrollChild"
	
	ButtonSetPressedFlag( childWindow .. "IsamuButton", false )
	ButtonSetPressedFlag( childWindow .. "MakotoButton", false )
	ButtonSetPressedFlag( childWindow .. "HomareButton", false ) 
	
	childWindow = "MoongateTerMurWindowScrollChild"
	
	ButtonSetPressedFlag( childWindow .. "RoyalCityButton", false )
end



function Moongate.CheckLocation()
	Moongate.ClearAllChecks()

	local wn = string.gsub(SystemData.ActiveWindow.name, "Button", "")
	wn = string.gsub(wn, "Label", "")
	local buttonId = WindowGetId( wn .. "Label" )

	gumpId = WindowGetId("GenericGumpItem" ..  buttonId)
	windowName = "GenericGumpItem" ..  buttonId
	ButtonSetPressedFlag(windowName, true)
	
	for key, value in pairs(Moongate.Locations) do
		if tonumber(value) then
			if value == buttonId then
				Moongate.LastGate = key
				break
			end
		else
			if (value.trammel == buttonId) then
				Moongate.LastGate = key .. "-trammel"
				break
			elseif (value.felucca == buttonId) then
				Moongate.LastGate = key .. "-felucca"
				break
			end
		end
	end
	

	if string.find(wn, "Trammel") then
		local childWindow = "MoongateTrammelWindowScrollChild"
		local currCity = string.gsub(wn, childWindow, "" )

		ButtonSetPressedFlag( childWindow .. "MoonglowButton", currCity == "Moonglow" )
		ButtonSetPressedFlag( childWindow .. "BritainButton", currCity == "Britain" ) 
		ButtonSetPressedFlag( childWindow .. "JhelomButton", currCity == "Jhelom" )
		ButtonSetPressedFlag( childWindow .. "YewButton", currCity == "Yew" )
		ButtonSetPressedFlag( childWindow .. "MinocButton", currCity == "Minoc" )
		ButtonSetPressedFlag( childWindow .. "TrinsicButton", currCity == "Trinsic" )
		ButtonSetPressedFlag( childWindow .. "SkaraBraeButton", currCity == "SkaraBrae" )
		ButtonSetPressedFlag( childWindow .. "MaginciaButton", currCity == "Magincia" )
		ButtonSetPressedFlag( childWindow .. "HavenButton", currCity == "Haven" )
		
		
	elseif string.find(wn, "Felucca") then	
		local childWindow = "MoongateFeluccaWindowScrollChild"
		local currCity = string.gsub(wn, childWindow, "" )

		ButtonSetPressedFlag( childWindow .. "MoonglowButton", currCity == "Moonglow" )
		ButtonSetPressedFlag( childWindow .. "BritainButton", currCity == "Britain" )
		ButtonSetPressedFlag( childWindow .. "JhelomButton", currCity == "Jhelom" ) 
		ButtonSetPressedFlag( childWindow .. "YewButton", currCity == "Yew" ) 
		ButtonSetPressedFlag( childWindow .. "MinocButton", currCity == "Minoc"  )
		ButtonSetPressedFlag( childWindow .. "TrinsicButton", currCity == "Trinsic"  )
		ButtonSetPressedFlag( childWindow .. "SkaraBraeButton", currCity == "SkaraBrae" )
		ButtonSetPressedFlag( childWindow .. "MaginciaButton", currCity == "Magincia" )
		ButtonSetPressedFlag( childWindow .. "BuccaButton", currCity == "Bucca" )
		
	elseif string.find(wn, "Ilshenar") then
		local childWindow = "MoongateIlshenarWindowScrollChild"
		local currCity = string.gsub(wn, childWindow, "" )

		ButtonSetPressedFlag( childWindow .. "CompassionButton", currCity == "Compassion" )
		ButtonSetPressedFlag( childWindow .. "HonestyButton", currCity == "Honesty" )
		ButtonSetPressedFlag( childWindow .. "HonorButton", currCity == "Honor" ) 
		ButtonSetPressedFlag( childWindow .. "HumiltyButton", currCity == "Humilty" ) 
		ButtonSetPressedFlag( childWindow .. "JusticeButton", currCity == "Justice"  )
		ButtonSetPressedFlag( childWindow .. "SacrificeButton", currCity == "Sacrifice"  )
		ButtonSetPressedFlag( childWindow .. "SpiritualityButton", currCity == "Spirituality" )
		ButtonSetPressedFlag( childWindow .. "ValorButton", currCity == "Valor" )
		ButtonSetPressedFlag( childWindow .. "ChaosButton", currCity == "Chaos" )
	elseif string.find(wn, "Malas") then
		local childWindow = "MoongateMalasWindowScrollChild"
		local currCity = string.gsub(wn, childWindow, "" )

		ButtonSetPressedFlag( childWindow .. "LunaButton", currCity == "Luna" )
		ButtonSetPressedFlag( childWindow .. "UmbraButton", currCity == "Umbra" )
	elseif string.find(wn, "Tokuno") then
		local childWindow = "MoongateTokunoWindowScrollChild"
		local currCity = string.gsub(wn, childWindow, "" )

		ButtonSetPressedFlag( childWindow .. "IsamuButton", currCity == "Isamu" )
		ButtonSetPressedFlag( childWindow .. "MakotoButton", currCity == "Makoto" )
		ButtonSetPressedFlag( childWindow .. "HomareButton", currCity == "Homare" )
	elseif string.find(wn, "TerMur") then
		local childWindow = "MoongateTerMurWindowScrollChild"
		local currCity = string.gsub(wn, childWindow, "" )

		ButtonSetPressedFlag( childWindow .. "RoyalCityButton", currCity == "RoyalCity" )
	end
end

function Moongate.ChangeMap()
	Moongate.LastGate = "Moonglow-trammel"
	local win = string.gsub(SystemData.ActiveWindow.name , "Button", "")
	win = string.gsub(win , "Label", "")
	
	if (win  ==  Moongate.WindowName .. "Trammel") then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		WindowSetShowing("MoongateTrammelWindow", true)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", false)
	elseif (win  ==  Moongate.WindowName .. "Felucca") then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", true)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", false)
	elseif (win  ==  Moongate.WindowName .. "Ilshenar") then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", true)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", false)
	elseif (win  ==  Moongate.WindowName .. "Malas") then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", true)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", false)
	elseif (win  ==  Moongate.WindowName .. "Tokuno") then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", true )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", false )
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", true)
		WindowSetShowing("MoongateTerMurWindow", false)
	elseif (win  ==  Moongate.WindowName .. "TerMur") then
		ButtonSetPressedFlag( Moongate.WindowName .. "TrammelButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "FeluccaButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "IlshenarButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "MalasButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TokunoButton", false )
		ButtonSetPressedFlag( Moongate.WindowName .. "TerMurButton", true )
		WindowSetShowing("MoongateTrammelWindow", false)
		WindowSetShowing("MoongateFeluccaWindow", false)
		WindowSetShowing("MoongateIlshenarWindow", false)
		WindowSetShowing("MoongateMalasWindow", false)
		WindowSetShowing("MoongateTokunoWindow", false)
		WindowSetShowing("MoongateTerMurWindow", true)
	end
	
	Moongate.ClearAllChecks()

end



function Moongate.GO()
	local id = -3
	if Moongate.Siege then
		if Moongate.Red then
			id = id + 29
		else
			id = id + 21
		end
	end
	gumpId = WindowGetId("GenericGumpItem" .. Moongate.FirstAttr+ id)
	windowName = "GenericGumpItem" ..  Moongate.FirstAttr+ id
	GenericGumpOnClicked(gumpId, windowName)
	
	Moongate.Toggle()
end



function Moongate.Toggle()

	local state = WindowGetShowing(Moongate.WindowName)
	WindowSetShowing(Moongate.WindowName, not state)
end