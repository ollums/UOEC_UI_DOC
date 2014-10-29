----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

AdvancedBuff = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

AdvancedBuff.WindowNameGood = "AdvancedBuffGood"
AdvancedBuff.WindowNameEvil = "AdvancedBuffEvil"

AdvancedBuff.GoodLocked = false
AdvancedBuff.EvilLocked = false

-- direzioni:
-- ___|  == 1
-- |___  == 2

-- |
-- |_  == 3

--  |
-- _| == 4

--  ___  
-- |     == 5

-- ___  
--    | == 6

--  _
-- |
-- |  == 7

-- _
--  |
--  |  == 8


AdvancedBuff.GoodDirection = 1
AdvancedBuff.EvilDirection = 2

AdvancedBuff.ReverseOrderGood = {}
AdvancedBuff.ReverseOrderEvil = {}
AdvancedBuff.TableOrderGood = {}
AdvancedBuff.TableOrderEvil = {}

AdvancedBuff.PrevIconsGood = 0
AdvancedBuff.PrevIconsEvil = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function AdvancedBuff.Initialize()
	CreateWindowFromTemplate(AdvancedBuff.WindowNameGood, "AdvancedBuff", "Root")
	if (WindowGetAnchorCount(AdvancedBuff.WindowNameGood) > 0) then
		WindowClearAnchors(AdvancedBuff.WindowNameGood)
	end
	WindowSetOffsetFromParent(AdvancedBuff.WindowNameGood, 451 , 125)
    WindowUtils.RestoreWindowPosition(AdvancedBuff.WindowNameGood)
    --SnapUtils.SnappableWindows[AdvancedBuff.WindowNameGood] = true
    EnhancePack.LoadScale( AdvancedBuff.WindowNameGood )

		
					
	CreateWindowFromTemplate(AdvancedBuff.WindowNameEvil, "AdvancedBuff", "Root")
	if (WindowGetAnchorCount(AdvancedBuff.WindowNameEvil) > 0) then
		WindowClearAnchors(AdvancedBuff.WindowNameEvil)
	end
	WindowSetOffsetFromParent(AdvancedBuff.WindowNameEvil, 585 , 125)
	WindowUtils.RestoreWindowPosition(AdvancedBuff.WindowNameEvil)
   -- SnapUtils.SnappableWindows[AdvancedBuff.WindowNameEvil] = true
    EnhancePack.LoadScale( AdvancedBuff.WindowNameEvil )
    
    AdvancedBuff.GoodLocked = CustomSettings.LoadBoolean( "AdvancedBuffGoodLocked",false )
    AdvancedBuff.EvilLocked = CustomSettings.LoadBoolean( "AdvancedBuffEvilLocked",false )
    
    WindowSetMovable(AdvancedBuff.WindowNameGood, AdvancedBuff.GoodLocked)
    WindowSetMovable(AdvancedBuff.WindowNameEvil, AdvancedBuff.EvilLocked)
    
    AdvancedBuff.GoodDirection = CustomSettings.LoadNumber( "AdvancedBuffGoodDirection", AdvancedBuff.GoodDirection )
    AdvancedBuff.EvilDirection = CustomSettings.LoadNumber( "AdvancedBuffEvilDirection", AdvancedBuff.EvilDirection )
    
    
    
    AdvancedBuff.UpdateDirections()
end

function AdvancedBuff.Shutdown()
	

	if (AdvancedBuff.GoodDirection == 1 or AdvancedBuff.GoodDirection == 3) then
		local endIcons = table.getn(AdvancedBuff.TableOrderGood)
		if (endIcons > 0) then
			for i=1, endIcons do
				BuffDebuff.HandleBuffRemoved(AdvancedBuff.TableOrderGood[i])
			end
		end
	end
	
	if (AdvancedBuff.EvilDirection == 4 or AdvancedBuff.EvilDirection == 6) then
		local endIcons = table.getn(AdvancedBuff.TableOrderEvil)
		if (endIcons > 0) then
			for i=1, endIcons do
				BuffDebuff.HandleBuffRemoved(AdvancedBuff.TableOrderEvil[i])
			end
		end
	end
	
    WindowUtils.SaveWindowPosition(AdvancedBuff.WindowNameGood)
   -- SnapUtils.SnappableWindows[AdvancedBuff.WindowNameGood] = nil
	WindowUtils.SaveWindowPosition(AdvancedBuff.WindowNameEvil)
   -- SnapUtils.SnappableWindows[AdvancedBuff.WindowNameEvil] = nil
end


function AdvancedBuff.UpdateDirections()
	-- GOOD
	if (AdvancedBuff.GoodDirection == 1) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameGood .. "Image", "AdvancedBuffDockspot", 3, 0 )
		WindowSetDimensions(AdvancedBuff.WindowNameGood, 106,71)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameGood .. "Image", 97, 52)
		WindowSetDimensions(AdvancedBuff.WindowNameGood .. "Image", 97, 52)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","topright", AdvancedBuff.WindowNameGood, "topright", 0, 10)
		
		--WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","bottomright", AdvancedBuff.WindowNameGood, "bottomright", -6, 16)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Context","bottomright", AdvancedBuff.WindowNameGood, "bottomright", -3, -11)
		WindowSetTintColor(AdvancedBuff.WindowNameGood .. "Image", 170,254,141)
	elseif (AdvancedBuff.GoodDirection == 3) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameGood .. "Image", "AdvancedBuffDockspot", 107, 1 )
		WindowSetDimensions(AdvancedBuff.WindowNameGood, 71,106)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameGood .. "Image", 52, 97)
		WindowSetDimensions(AdvancedBuff.WindowNameGood .. "Image", 52, 97)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","bottomleft", AdvancedBuff.WindowNameGood, "bottomleft", 0, 0)
		--WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","bottomright", AdvancedBuff.WindowNameGood, "bottomright", 6, -6)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Context","bottomleft", AdvancedBuff.WindowNameGood, "bottomleft", 3, -2)
		WindowSetTintColor(AdvancedBuff.WindowNameGood .. "Image", 170,254,141)
	elseif (AdvancedBuff.GoodDirection == 5) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameGood .. "Image", "AdvancedBuffDockspot", 121, 112 )
		WindowSetDimensions(AdvancedBuff.WindowNameGood, 106,71)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameGood .. "Image", 97, 52)
		WindowSetDimensions(AdvancedBuff.WindowNameGood .. "Image", 97, 52)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","topleft", AdvancedBuff.WindowNameGood, "topleft", 0, 0)
		--WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","bottomright", AdvancedBuff.WindowNameGood, "bottomright", 6, 6)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Context","topleft", AdvancedBuff.WindowNameGood, "topleft", 2, 3)
		WindowSetTintColor(AdvancedBuff.WindowNameGood .. "Image", 170,254,141)
	elseif (AdvancedBuff.GoodDirection == 8) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameGood .. "Image", "AdvancedBuffDockspot", 55, 121 )
		WindowSetDimensions(AdvancedBuff.WindowNameGood, 71,106)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameGood .. "Image", 52, 97)
		WindowSetDimensions(AdvancedBuff.WindowNameGood .. "Image", 52, 97)
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","topright", AdvancedBuff.WindowNameGood, "topright", 0, 0)
		--WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Image","bottomright", AdvancedBuff.WindowNameGood, "bottomright", -6, 6)-
		WindowClearAnchors(AdvancedBuff.WindowNameGood .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameGood .. "Context","topright", AdvancedBuff.WindowNameGood, "topright", -2, 2)
		WindowSetTintColor(AdvancedBuff.WindowNameGood .. "Image", 170,254,141)
	end
	AdvancedBuff.HandleReAnchorBuffGood(1)
	-- EVIL
	if (AdvancedBuff.EvilDirection == 2) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameEvil .. "Image", "AdvancedBuffDockspot", 1, 56 )
		WindowSetDimensions(AdvancedBuff.WindowNameEvil, 106,71)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameEvil .. "Image", 97, 52)
		WindowSetDimensions(AdvancedBuff.WindowNameEvil .. "Image", 97, 52)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","topleft", AdvancedBuff.WindowNameEvil, "topleft", 0, 10)
		--WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","bottomright", AdvancedBuff.WindowNameEvil, "bottomright", 6, -6)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Context","bottomleft", AdvancedBuff.WindowNameEvil, "bottomleft", 2, -11)
		WindowSetTintColor(AdvancedBuff.WindowNameEvil .. "Image", 255,149,152)
	elseif (AdvancedBuff.EvilDirection == 4) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameEvil .. "Image", "AdvancedBuffDockspot", 162, 1 )
		WindowSetDimensions(AdvancedBuff.WindowNameEvil, 71,106)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameEvil .. "Image", 52, 97)
		WindowSetDimensions(AdvancedBuff.WindowNameEvil .. "Image", 52, 97)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","bottomright", AdvancedBuff.WindowNameEvil, "bottomright", 0, 0)
		--WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","bottomright", AdvancedBuff.WindowNameEvil, "bottomright", -6, -6)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Context","bottomright", AdvancedBuff.WindowNameEvil, "bottomright", -3, -2)
		WindowSetTintColor(AdvancedBuff.WindowNameEvil .. "Image", 255,149,152)
	elseif (AdvancedBuff.EvilDirection == 6) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameEvil .. "Image", "AdvancedBuffDockspot", 116, 166 )
		WindowSetDimensions(AdvancedBuff.WindowNameEvil, 106,71)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameEvil .. "Image", 97, 52)
		WindowSetDimensions(AdvancedBuff.WindowNameEvil .. "Image", 97, 52)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","topright", AdvancedBuff.WindowNameEvil, "topright", 0, 0)
		--WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","bottomright", AdvancedBuff.WindowNameEvil, "bottomright", -6, 6)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Context","topright", AdvancedBuff.WindowNameEvil, "topright", -2, 3)
		WindowSetTintColor(AdvancedBuff.WindowNameEvil .. "Image", 255,149,152)
	elseif (AdvancedBuff.EvilDirection == 7) then
		DynamicImageSetTexture(AdvancedBuff.WindowNameEvil .. "Image", "AdvancedBuffDockspot", 0, 121 )
		WindowSetDimensions(AdvancedBuff.WindowNameEvil, 71,106)
		DynamicImageSetTextureDimensions(AdvancedBuff.WindowNameEvil .. "Image", 52, 97)
		WindowSetDimensions(AdvancedBuff.WindowNameEvil .. "Image", 52, 97)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Image")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","topleft", AdvancedBuff.WindowNameEvil, "topleft", 0, 0)
		--WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Image","bottomright", AdvancedBuff.WindowNameEvil, "bottomright", 6, 6)
		WindowClearAnchors(AdvancedBuff.WindowNameEvil .. "Context")
		WindowAddAnchor(AdvancedBuff.WindowNameEvil .. "Context","topleft", AdvancedBuff.WindowNameEvil, "topleft", 3, 3)
		WindowSetTintColor(AdvancedBuff.WindowNameEvil .. "Image", 255,149,152)
	end
	AdvancedBuff.HandleReAnchorBuffEvil(1)
end

function AdvancedBuff.Context()
	if ( SystemData.ActiveWindow.name == AdvancedBuff.WindowNameGood .. "Context") then
		if (AdvancedBuff.GoodLocked) then
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 289),0,"unlockGood",2,false)
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 687),1,"rotateGood",2,false)
		else
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 290),0,"lockGood",2,false)
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 687),0,"rotateGood",2,false)
		end
		
	else
		if (AdvancedBuff.EvilLocked) then
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 289),0,"unlockEvil",2,false)
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 687),1,"rotateEvil",2,false)
		else
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 290),0,"lockEvil",2,false)
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 687),0,"rotateEvil",2,false)
		end
		
	end
		
	ContextMenu.ActivateLuaContextMenu(AdvancedBuff.ContextMenuCallback)
end

function AdvancedBuff.ContextMenuCallback( returnCode, param )	
	if (string.find(returnCode, "Good")) then
		if (string.find(returnCode, "unlock")) then
			AdvancedBuff.GoodLocked = false
			CustomSettings.SaveBoolean( "AdvancedBuffGoodLocked", AdvancedBuff.GoodLocked  )
			WindowSetMovable(AdvancedBuff.WindowNameGood, AdvancedBuff.GoodLocked)
		elseif (string.find(returnCode, "rotate")) then -- 1,3,5,8
			if (AdvancedBuff.GoodDirection == 1) then
				AdvancedBuff.GoodDirection = 3
			elseif (AdvancedBuff.GoodDirection == 3) then
				AdvancedBuff.GoodDirection = 5
			elseif (AdvancedBuff.GoodDirection == 5) then
				AdvancedBuff.GoodDirection = 8
			elseif (AdvancedBuff.GoodDirection == 8) then
				AdvancedBuff.GoodDirection = 1
			end
			CustomSettings.SaveNumber( "AdvancedBuffGoodDirection", AdvancedBuff.GoodDirection )
			AdvancedBuff.UpdateDirections()
		elseif (string.find(returnCode, "lock")) then
			AdvancedBuff.GoodLocked = true
			CustomSettings.SaveBoolean( "AdvancedBuffGoodLocked", AdvancedBuff.GoodLocked  )
			WindowSetMovable(AdvancedBuff.WindowNameGood, AdvancedBuff.GoodLocked)
		end
	else
		if (string.find(returnCode, "unlock")) then
			AdvancedBuff.EvilLocked = false
			CustomSettings.SaveBoolean( "AdvancedBuffEvilLocked", AdvancedBuff.EvilLocked )
			WindowSetMovable(AdvancedBuff.WindowNameEvil, AdvancedBuff.EvilLocked)
		elseif (string.find(returnCode, "rotate")) then -- 2,4,6,7
			if (AdvancedBuff.EvilDirection == 2) then
				AdvancedBuff.EvilDirection = 4
			elseif (AdvancedBuff.EvilDirection == 4) then
				AdvancedBuff.EvilDirection = 6
			elseif (AdvancedBuff.EvilDirection == 6) then
				AdvancedBuff.EvilDirection = 7
			elseif (AdvancedBuff.EvilDirection == 7) then
				AdvancedBuff.EvilDirection = 2
			end
			CustomSettings.SaveNumber( "AdvancedBuffEvilDirection", AdvancedBuff.EvilDirection )
			AdvancedBuff.UpdateDirections()
		elseif (string.find(returnCode, "lock")) then
			AdvancedBuff.EvilLocked = true
			CustomSettings.SaveBoolean( "AdvancedBuffEvilLocked", AdvancedBuff.EvilLocked )
			WindowSetMovable(AdvancedBuff.WindowNameEvil, AdvancedBuff.EvilLocked)
		end
	end
end

function AdvancedBuff.ContextToolsTooltip()
	if ( SystemData.ActiveWindow.name == AdvancedBuff.WindowNameGood .. "Context") then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 685))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, UI.GetCliloc(SystemData.Settings.Language.type, 686))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function AdvancedBuff.OnLButtonDown()
	if (SystemData.ActiveWindow.name == AdvancedBuff.WindowNameGood) then
		if (not AdvancedBuff.GoodLocked ) then
			--SnapUtils.StartWindowSnap(AdvancedBuff.WindowNameGood)
			WindowSetMoving(AdvancedBuff.WindowNameGood,true)
		else
			WindowSetMoving(AdvancedBuff.WindowNameGood,false)
		end
	elseif (SystemData.ActiveWindow.name == AdvancedBuff.WindowNameEvil) then
		if (not AdvancedBuff.EvilLocked ) then
			--SnapUtils.StartWindowSnap(AdvancedBuff.WindowNameEvil)
			WindowSetMoving(AdvancedBuff.WindowNameEvil,true)
		else
			WindowSetMoving(AdvancedBuff.WindowNameEvil,false)
		end
	end
end

function AdvancedBuff.HandleReAnchorBuffGood(position)
	local endIcons = table.getn(AdvancedBuff.TableOrderGood)
	if (endIcons > 0) then
		if (AdvancedBuff.GoodDirection == 1) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderGood[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderGood[AdvancedBuff.TableOrderGood[i]] = i

				if i == 1 then
					
					WindowAddAnchor(iconName, "topright", AdvancedBuff.WindowNameGood, "topright", -20, 5)
				else
					WindowAddAnchor(iconName, "topleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderGood[i-1] , "topright", -5, 0)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "top", iconName, "bottom", 0, -2)
				LabelSetTextAlign(iconName.."TimerLabel", "center")
			end
			local width = 20 + BuffDebuff.IconSize * endIcons
			if width < 106 then
				width = 106
			end

			WindowSetDimensions(AdvancedBuff.WindowNameGood, width, 71 )
			local x, y = WindowGetOffsetFromParent(AdvancedBuff.WindowNameGood)
	      
			if (endIcons >= 2) then
				
				if endIcons > AdvancedBuff.PrevIconsGood and endIcons > 2 then
					if (WindowGetAnchorCount(AdvancedBuff.WindowNameGood) > 0) then
						WindowClearAnchors(AdvancedBuff.WindowNameGood)
					end
					WindowSetOffsetFromParent(AdvancedBuff.WindowNameGood, x -42 , y)	
				elseif endIcons < AdvancedBuff.PrevIconsGood  and endIcons >= 2 then
					if (WindowGetAnchorCount(AdvancedBuff.WindowNameGood) > 0) then
						WindowClearAnchors(AdvancedBuff.WindowNameGood)
					end
					WindowSetOffsetFromParent(AdvancedBuff.WindowNameGood, x +42 , y)
				end
			end
			AdvancedBuff.PrevIconsGood = endIcons
			
		elseif (AdvancedBuff.GoodDirection == 3) then
		
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderGood[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderGood[AdvancedBuff.TableOrderGood[i]] = i

				if i == 1 then
					
					WindowAddAnchor(iconName, "bottomleft", AdvancedBuff.WindowNameGood, "bottomleft", 18, -18)
				else
					WindowAddAnchor(iconName, "topleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderGood[i-1] , "bottomleft",0 , -5)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "right", iconName, "left", 2, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "left")
			end
			local height = 20 + BuffDebuff.IconSize * endIcons
			if height < 106 then
				height = 106
			end

			WindowSetDimensions(AdvancedBuff.WindowNameGood, 71, height )
			local x, y = WindowGetOffsetFromParent(AdvancedBuff.WindowNameGood)
	      
			if (endIcons >= 2) then
				
				if endIcons > AdvancedBuff.PrevIconsGood and endIcons > 2 then
					if (WindowGetAnchorCount(AdvancedBuff.WindowNameGood) > 0) then
						WindowClearAnchors(AdvancedBuff.WindowNameGood)
					end
					WindowSetOffsetFromParent(AdvancedBuff.WindowNameGood, x , y -42)	
				elseif endIcons < AdvancedBuff.PrevIconsGood  and endIcons >= 2 then
					if (WindowGetAnchorCount(AdvancedBuff.WindowNameGood) > 0) then
						WindowClearAnchors(AdvancedBuff.WindowNameGood)
					end
					WindowSetOffsetFromParent(AdvancedBuff.WindowNameGood, x , y +42)
				end
			end
			AdvancedBuff.PrevIconsGood = endIcons
			
		elseif (AdvancedBuff.GoodDirection == 5) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderGood[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderGood[AdvancedBuff.TableOrderGood[i]] = i

				if i == 1 then
					WindowAddAnchor(iconName, "topleft", AdvancedBuff.WindowNameGood, "topleft", 20, 20)
				else
					WindowAddAnchor(iconName, "topright", "BuffDebuffIcon" ..AdvancedBuff.TableOrderGood[i-1] , "topleft", 5, 0)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "bottom", iconName, "top", 0, 2)
				LabelSetTextAlign(iconName.."TimerLabel", "center")
			end
			
			
			local width = 20 + BuffDebuff.IconSize * endIcons
			if width < 106 then
				width = 106
			end

			WindowSetDimensions(AdvancedBuff.WindowNameGood, width, 71 )
		
		elseif (AdvancedBuff.GoodDirection == 8) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderGood[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderGood[AdvancedBuff.TableOrderGood[i]] = i

				if i == 1 then
					
					WindowAddAnchor(iconName, "topright", AdvancedBuff.WindowNameGood, "topright", -20, 20)
				else
					WindowAddAnchor(iconName, "bottomleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderGood[i-1] , "topleft",0 , 5)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "left", iconName, "right", -2, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "right")
			end
			local height = 20 + BuffDebuff.IconSize * endIcons
			if height < 106 then
				height = 106
			end

			WindowSetDimensions(AdvancedBuff.WindowNameGood, 71, height )
		end
	end
end

function AdvancedBuff.HandleReAnchorBuffEvil(position)
	local endIcons = table.getn(AdvancedBuff.TableOrderEvil)
	if (endIcons > 0) then
		if (AdvancedBuff.EvilDirection == 2) then
			
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderEvil[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderEvil[AdvancedBuff.TableOrderEvil[i]] = i

				if i == 1 then
					WindowAddAnchor(iconName, "topleft", AdvancedBuff.WindowNameEvil, "topleft", 20, 5)
				else
					WindowAddAnchor(iconName, "topright", "BuffDebuffIcon" ..AdvancedBuff.TableOrderEvil[i-1] , "topleft", 5, 0)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "top", iconName, "bottom", 0, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "center")
			end
			
			
			local width = 20 + BuffDebuff.IconSize * endIcons
			if width < 106 then
				width = 106
			end

			WindowSetDimensions(AdvancedBuff.WindowNameEvil, width, 71 )
			
			
		elseif (AdvancedBuff.EvilDirection == 4) then
		
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderEvil[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderEvil[AdvancedBuff.TableOrderEvil[i]] = i

				if i == 1 then
					
					WindowAddAnchor(iconName, "bottomright", AdvancedBuff.WindowNameEvil, "bottomright", -18, -18)
				else
					WindowAddAnchor(iconName, "topleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderEvil[i-1] , "bottomleft",0 , -5)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "left", iconName, "right", -2, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "right")
			end
			local height = 20 + BuffDebuff.IconSize * endIcons
			if height < 106 then
				height = 106
			end

			WindowSetDimensions(AdvancedBuff.WindowNameEvil, 71, height )
			local x, y = WindowGetOffsetFromParent(AdvancedBuff.WindowNameEvil)
	      
			if (endIcons >= 2) then
				
				if endIcons > AdvancedBuff.PrevIconsEvil and endIcons > 2 then
					if (WindowGetAnchorCount(AdvancedBuff.WindowNameEvil) > 0) then
						WindowClearAnchors(AdvancedBuff.WindowNameEvil)
					end
					WindowSetOffsetFromParent(AdvancedBuff.WindowNameEvil, x , y -42)	
				elseif endIcons < AdvancedBuff.PrevIconsEvil  and endIcons >= 2 then
					if (WindowGetAnchorCount(AdvancedBuff.WindowNameEvil) > 0) then
						WindowClearAnchors(AdvancedBuff.WindowNameEvil)
					end
					WindowSetOffsetFromParent(AdvancedBuff.WindowNameEvil, x , y +42)
				end
			end
			AdvancedBuff.PrevIconsEvil = endIcons
			
		elseif (AdvancedBuff.EvilDirection == 6) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderEvil[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderEvil[AdvancedBuff.TableOrderEvil[i]] = i

				if i == 1 then
					
					WindowAddAnchor(iconName, "topright", AdvancedBuff.WindowNameEvil, "topright", -20, 20)
				else
					WindowAddAnchor(iconName, "topleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderEvil[i-1] , "topright", -5, 0)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "bottom", iconName, "top", 0, 2)
				LabelSetTextAlign(iconName.."TimerLabel", "center")
			end
			local width = 20 + BuffDebuff.IconSize * endIcons
			if width < 106 then
				width = 106
			end

			WindowSetDimensions(AdvancedBuff.WindowNameEvil, width, 71 )
			local x, y = WindowGetOffsetFromParent(AdvancedBuff.WindowNameEvil)
	      
			if (endIcons >= 2) then
				
				if endIcons > AdvancedBuff.PrevIconsEvil and endIcons > 2 then
					if (WindowGetAnchorCount(AdvancedBuff.WindowNameEvil) > 0) then
						WindowClearAnchors(AdvancedBuff.WindowNameEvil)
					end
					WindowSetOffsetFromParent(AdvancedBuff.WindowNameEvil, x -42 , y)	
				elseif endIcons < AdvancedBuff.PrevIconsEvil  and endIcons >= 2 then
					if (WindowGetAnchorCount(AdvancedBuff.WindowNameEvil) > 0) then
						WindowClearAnchors(AdvancedBuff.WindowNameEvil)
					end
					WindowSetOffsetFromParent(AdvancedBuff.WindowNameEvil, x +42 , y)
				end
			end
			AdvancedBuff.PrevIconsEvil = endIcons
		elseif (AdvancedBuff.EvilDirection == 7) then
			for i=position, endIcons do
				iconName = "BuffDebuffIcon"..AdvancedBuff.TableOrderEvil[i]
				WindowClearAnchors(iconName)
				AdvancedBuff.ReverseOrderEvil[AdvancedBuff.TableOrderEvil[i]] = i

				if i == 1 then
					
					WindowAddAnchor(iconName, "topright", AdvancedBuff.WindowNameEvil, "topright", -12, 18)
				else
					WindowAddAnchor(iconName, "bottomleft", "BuffDebuffIcon" ..AdvancedBuff.TableOrderEvil[i-1] , "topleft",0 , 5)
				end
				WindowClearAnchors(iconName.."TimerLabel")
				WindowAddAnchor(iconName.."TimerLabel", "right", iconName, "left", 2, 0)
				LabelSetTextAlign(iconName.."TimerLabel", "left")
			end
			local height = 20 + BuffDebuff.IconSize * endIcons
			if height < 106 then
				height = 106
			end

			WindowSetDimensions(AdvancedBuff.WindowNameEvil, 71, height )
		end
	end
end