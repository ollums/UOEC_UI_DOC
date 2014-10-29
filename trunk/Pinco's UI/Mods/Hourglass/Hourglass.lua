Hourglass = {}

Hourglass.UpHeight = 255
Hourglass.UpWidth = 191

Hourglass.DownHeight = 270
Hourglass.DownWidth = 199

Hourglass.ConnectedBuffId = 0

Hourglass.TimeBeforeRotate = 60 -- Seconds before restart sand
Hourglass.TimePassed = 0
Hourglass.Timer = 0 

Hourglass.TimerStarted = false 
Hourglass.BuffTimerStarted = false 

Hourglass.HourglassVisible = false

function Hourglass.Initialize()
	local scale = 0.3
	local w = 362
	local h = 682
	--WindowSetDimensions("Hourglass", w, h)
	SnapUtils.SnappableWindows["Hourglass"] = true
	DynamicImageSetTextureDimensions( "HourglassBackground", w, h )
	WindowSetDimensions("HourglassBackground", w * scale,h * scale)
	
	Hourglass.UpWidth = Hourglass.UpWidth * scale
	Hourglass.UpHeight = Hourglass.UpHeight * scale
	
	
	WindowSetDimensions("upTap", 191 * scale, 255 * scale)
	
	Hourglass.DownHeight = Hourglass.DownHeight * scale
	Hourglass.DownWidth = Hourglass.DownWidth * scale
	
	
	WindowSetDimensions("downTap", 255 * scale, 306 * scale)
	--WindowSetDimensions("TextBackground", w * scale, 30)
	
	
	local x, y = WindowGetDimensions( "HourglassBackground" )

	WindowSetTintColor( "upClose", 193, 171, 125 )
	WindowSetTintColor( "downClose", 193, 171, 125 )
	
	local texture = 100
	local xSize, ySize
	local scaleX = 0.85
	texture, xSize, ySize = RequestGumpArt( texture )
	local textureSize = xSize
		
	if (textureSize < ySize) then
		textureSize = ySize
	end
	
	WindowSetDimensions(  "HourglassTextBackground", xSize * scaleX, ySize * scaleX )
	DynamicImageSetTexture( "HourglassTextBackground", texture, 0, 0 )
	DynamicImageSetTextureScale( "HourglassTextBackground", scaleX )
	LabelSetText("HourglassTimeLabel", UI.GetCliloc(SystemData.Settings.Language.type, 257))
	LabelSetText("HourglassTimeElapsedLabel", L"00 : 00 : 00")
	WindowSetDimensions("Hourglass", (x * scale) + ( (xSize * scaleX) - (x * scale) ), (y * scale)	+ ((ySize * scaleX ) * 2) + 50 )
	
	WindowSetDimensions("upClose", Hourglass.UpWidth, 0)
	WindowSetDimensions("downClose", Hourglass.DownWidth , Hourglass.DownHeight )

	--WindowSetShowing("upTap", false)
	--WindowSetShowing("downTap", false)
	
	WindowUtils.RestoreWindowPosition("Hourglass")
	Hourglass.HourglassVisible = CustomSettings.LoadBoolean( "HourglassVisible", false )
	if ( Hourglass.HourglassVisible ) then
		WindowSetShowing("Hourglass", true)
	else
		WindowSetShowing("Hourglass", false)
	end
	
	Hourglass.TimerStarted = CustomSettings.LoadBoolean( "HourglassTimerStarted", false )
	if ( Hourglass.TimerStarted ) then
		Hourglass.Timer = CustomSettings.LoadNumber( "HourglassTimer", 0 )
		Hourglass.TimePassed = CustomSettings.LoadNumber( "HourglassTimePassed", 0 )
	end
	EnhancePack.LoadScale( "Hourglass" )
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont("HourglassTimeLabel",  "font_verdana_bold_shadow_med", 12)
	else
		LabelSetFont("HourglassTimeLabel",  "UO_DefaultText", 12)
	end
end

function Hourglass.Toggle()
	if ( Hourglass.HourglassVisible ) then
		Hourglass.Close()
	else
		Hourglass.HourglassVisible = true
		WindowSetShowing("Hourglass", true)
		CustomSettings.SaveBoolean( "HourglassVisible", true )
	end
	ButtonSetPressedFlag( "SettingsPincoHourglassButton", Hourglass.HourglassVisible )
end

function Hourglass.RedButton_Tooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 258))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function Hourglass.GreenButton_Tooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 259))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function Hourglass.OnMouseDrag()
	SnapUtils.StartWindowSnap("Hourglass")
end

function Hourglass.Shutdown()
	WindowUtils.SaveWindowPosition("Hourglass")
	SnapUtils.SnappableWindows["Hourglass"] = nil
	
end

function Hourglass.Close()
	WindowSetShowing("Hourglass", false)
	Hourglass.HourglassVisible = false
	CustomSettings.SaveBoolean( "HourglassVisible", false )
	Hourglass.TimerStarted = false
	Hourglass.BuffTimerStarted = false
	Hourglass.TimePassed = 0
	Hourglass.Timer  = 0
	Hourglass.TimeBeforeRotate = 60
	WindowSetDimensions("upClose", Hourglass.UpWidth, Hourglass.UpWidth )
	WindowSetDimensions("downClose", Hourglass.DownWidth , 0 )
	LabelSetText("HourglassTimeLabel", UI.GetCliloc(SystemData.Settings.Language.type, 257))
	LabelSetText("HourglassTimeElapsedLabel", StringToWString(Hourglass.SecondsToClock(tostring(Hourglass.Timer))))
	ButtonSetPressedFlag( "SettingsPincoHourglassButton", Hourglass.HourglassVisible )
end

function Hourglass.GreenButton_OnLButtonUp()
	if ( not Hourglass.BuffTimerStarted ) then
		LabelSetText("HourglassTimeLabel", UI.GetCliloc(SystemData.Settings.Language.type, 257))
		WindowSetDimensions("upClose", Hourglass.UpWidth, Hourglass.UpHeight )
		WindowSetDimensions("downClose", Hourglass.DownWidth , 0 )
		Hourglass.TimeBeforeRotate = 60
		Hourglass.TimerStarted = true
		Hourglass.TimePassed = 0
		Hourglass.Timer  = 0
		LabelSetText("HourglassTimeElapsedLabel", StringToWString(Hourglass.SecondsToClock(tostring(Hourglass.Timer))))
		CustomSettings.SaveBoolean( "HourglassTimerStarted", true )
	end
end

function Hourglass.RedButton_OnLButtonUp()
	Hourglass.BuffTimerStarted = false
	Hourglass.TimerStarted = false
	Hourglass.TimePassed = 0
	Hourglass.Timer  = 0
	CustomSettings.SaveBoolean( "HourglassTimerStarted", false )
	WindowSetDimensions("upClose", Hourglass.UpWidth, 0 )
	WindowSetDimensions("downClose", Hourglass.DownWidth , Hourglass.DownHeight )

end

function Hourglass.Drops()
	
	if ( Hourglass.HourglassVisible ) then
		if (Hourglass.BuffTimerStarted) then
			local data = BuffDebuff.BuffData[Hourglass.ConnectedBuffId]
			Hourglass.Timer = Hourglass.Timer + 1
			Hourglass.TimePassed = Hourglass.TimePassed + 1
			if (Hourglass.TimePassed >= Hourglass.TimeBeforeRotate or data == nil) then
				WindowSetDimensions("upClose", Hourglass.UpWidth, 0 )
				WindowSetDimensions("downClose", Hourglass.DownWidth , Hourglass.DownHeight )
				Hourglass.TimePassed = 0
				Hourglass.ConnectedBuffId = 0
				Hourglass.BuffTimerStarted = false
				LabelSetText("HourglassTimeElapsedLabel", StringToWString(Hourglass.SecondsToClock(tostring(0))))
				
			else
				local TimeSlice =  math.ceil((Hourglass.UpHeight * Hourglass.TimePassed) / Hourglass.TimeBeforeRotate)
				if ( TimeSlice < 0 ) then
					TimeSlice = 0
				end
				
				--Debug.Print("UP: " .. tostring(Hourglass.UpHeight - TimeSlice ) .. " DOWN: " .. tostring( TimeSlice ))
				
				WindowSetDimensions("upClose", Hourglass.UpWidth, Hourglass.UpHeight - TimeSlice )
				
				if ( TimeSlice > Hourglass.DownHeight ) then
					TimeSlice = Hourglass.DownHeight
				end
				WindowSetDimensions("downClose", Hourglass.DownWidth , TimeSlice )
				LabelSetText("HourglassTimeElapsedLabel", StringToWString(Hourglass.SecondsToClock(tostring(Hourglass.TimeBeforeRotate - Hourglass.TimePassed))))
			end
			
		end
		if (Hourglass.TimerStarted ) then
			Hourglass.Timer = Hourglass.Timer + 1
			
			CustomSettings.SaveNumber("HourglassTimer", Hourglass.Timer)
			CustomSettings.SaveNumber("HourglassTimePassed", Hourglass.TimePassed)
			
			Hourglass.TimePassed = Hourglass.TimePassed + 1
			if (Hourglass.TimePassed > Hourglass.TimeBeforeRotate) then
				Hourglass.TimePassed = 0
			end
			LabelSetText("HourglassTimeElapsedLabel", StringToWString(Hourglass.SecondsToClock(tostring(Hourglass.Timer))))
			local TimeSlice =  math.ceil((Hourglass.UpHeight * Hourglass.TimePassed) / Hourglass.TimeBeforeRotate)
			if ( TimeSlice < 0 ) then
				TimeSlice = 0
			end
			
			--Debug.Print("UP: " .. tostring(Hourglass.UpHeight - TimeSlice ) .. " DOWN: " .. tostring( TimeSlice ))
			
			WindowSetDimensions("upClose", Hourglass.UpWidth, Hourglass.UpHeight - TimeSlice )
			
			if ( TimeSlice > Hourglass.DownHeight ) then
				TimeSlice = Hourglass.DownHeight
			end
			WindowSetDimensions("downClose", Hourglass.DownWidth , TimeSlice )
		end
	end

end


function Hourglass.SecondsToClock(sSeconds, extended)
	local nSeconds = tonumber(sSeconds)
	if nSeconds == 0 then
		--return nil;
		if (not extended) then
			return "00 : 00: 00";
		else
			return "0 seconds.";
		end
	else
		nHours = string.format("%02.f", math.floor(nSeconds/3600));
		nMins = string.format("%02.f", math.floor(nSeconds/60 - (nHours*60)));
		nSecs = string.format("%02.f", math.floor(nSeconds - nHours*3600 - nMins *60));
		if (not extended) then
			nHours = string.format("%02.f", math.floor(nSeconds/3600));
			nMins = string.format("%02.f", math.floor(nSeconds/60 - (nHours*60)));
			nSecs = string.format("%02.f", math.floor(nSeconds - nHours*3600 - nMins *60));
			return nHours.." : "..nMins.." : "..nSecs
		else
			nHours =  math.floor(nSeconds/3600)
			nMins =  math.floor(nSeconds/60 - (nHours*60))
			nSecs =  math.floor(nSeconds - nHours*3600 - nMins *60)
			local final = ""
			if math.floor(nSeconds/3600) > 0 then
				local Hs = ""
				if  math.floor(nSeconds/3600) > 1 then
					Hs = "s"
				end
				final = nHours .. " hour" .. Hs
				if  math.floor(nSeconds/60 - (nHours*60)) > 0 then
					Hs = ""
					if  math.floor(nSeconds/60 - (nHours*60)) > 1 then
						Hs = "s"
					end
					final = final .. ", " .. nMins .. " minute" .. Hs
					if math.floor(nSeconds - nHours*3600 - nMins *60) > 0 then
						Hs = ""
						if  math.floor(nSeconds - nHours*3600 - nMins *60) > 1 then
							Hs = "s"
						end
						final = final .. ", " .. nSecs .. " second" .. Hs
					end
				elseif math.floor(nSeconds - nHours*3600 - nMins *60) > 0 then
					Hs = ""
					if  math.floor(nSeconds - nHours*3600 - nMins *60) > 1 then
						Hs = "s"
					end
					final = final .. ", 0 minute, " .. nSecs .. " second" .. Hs
				end
			elseif  math.floor(nSeconds/60 - (nHours*60)) > 0 then
				Hs = ""
				if  math.floor(nSeconds/60 - (nHours*60)) > 1 then
					Hs = "s"
				end
				final = nMins .. " minute" .. Hs
				if math.floor(nSeconds - nHours*3600 - nMins *60) > 0 then
					Hs = ""
					if  math.floor(nSeconds - nHours*3600 - nMins *60) > 1 then
						Hs = "s"
					end
					final = final .. ", " .. nSecs .. " second" .. Hs
				end
			elseif math.floor(nSeconds - nHours*3600 - nMins *60) > 0 then
				Hs = ""
				if  math.floor(nSeconds - nHours*3600 - nMins *60) > 1 then
					Hs = "s"
				end
				final = nSecs .. " second" .. Hs
			end
			return final
		end
	end
end
