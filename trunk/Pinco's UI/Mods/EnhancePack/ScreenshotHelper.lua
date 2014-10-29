----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ScreenshotHelper = {}
ScreenshotHelper.ScaleOverride = -1

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------




function ScreenshotHelper.Initialize()
	--CreateWindow( "ScreenshotHelper", false )
end

function ScreenshotHelper.Shutdown()

end

function ScreenshotHelper.OnRClick()
	WindowClearAnchors("ScreenshotHelperIcon")
	DynamicImageSetTexture( "ScreenshotHelperIcon", "", 0, 0 )
	WindowSetShowing("ScreenshotHelper", false )
end

function ScreenshotHelper.Show()
		WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
		if (IsMobile(WindowData.CurrentTarget.TargetId)) then
			

			--if( WindowData.CurrentTarget.HasPaperdoll ) then
				if (DoesWindowNameExist("PaperdollWindow"..WindowData.CurrentTarget.TargetId)) then
					
					local textureData = SystemData.PaperdollTexture[WindowData.CurrentTarget.TargetId]
					if textureData ~= nil then
						local paperdollTextureName = "paperdoll_texture"..WindowData.CurrentTarget.TargetId
						local scale = 1
						if ( ScreenshotHelper.ScaleOverride >= 0 ) then
							scale = ScreenshotHelper.ScaleOverride 
						end
						
						local x,y= textureData.Width, textureData.Height
						
						
						DynamicImageSetTexture( "ScreenshotHelperIcon", paperdollTextureName, 0, 0 )
						if (x > 350) then
							x = 350
						end
						if (y > 550) then
							y = 550
						end
						
	        
	        
						WindowSetDimensions("ScreenshotHelper",  x, y)
						DynamicImageSetTextureDimensions( "ScreenshotHelperIcon", x, y )
						WindowSetScale("ScreenshotHelper", scale)
						--DynamicImageSetTextureScale( "ScreenshotHelperIcon", scale)
						WindowClearAnchors("ScreenshotHelperIcon")
						WindowAddAnchor("ScreenshotHelperIcon", "topleft", "ScreenshotHelperBackground","topleft",0,0)
						WindowAddAnchor("ScreenshotHelperIcon", "bottomright", "ScreenshotHelperBackground","bottomright",0,0)

						--DynamicImageSetTextureScale( "ScreenshotHelperIcon", scale)
						WindowSetShowing("ScreenshotHelper", true)
						WindowSetShowing("ScreenshotHelperIcon", true)
					end		
				else
					ChatWindow.Print(UI.GetCliloc(SystemData.Settings.Language.type, 413), SystemData.ChatLogFilters.SYSTEM )
				end
			--else
				--ChatWindow.Print(L"To make a screenshot of this mobile you have to open its paperdoll!", SystemData.ChatLogFilters.SYSTEM )
			--end
			
		else
			local itemData = WindowData.ObjectInfo[WindowData.CurrentTarget.TargetId]
			
			EquipmentData.UpdateItemIcon("ScreenshotHelperIcon", itemData)
			--WindowAddAnchor("ScreenshotHelperIcon", "topleft", "ScreenshotHelperBackground", "topleft", 10, 10)
			local scale = 1 -- SystemData.FreeformInventory.Scale --SystemData.Settings.Interface.customUiScale
			if ( ScreenshotHelper.ScaleOverride >= 0 ) then
				scale = ScreenshotHelper.ScaleOverride 
			end
	        
			--if (itemData.newHeight > 40) then
			--	scale = 2.5
			--end
			--for key,value in pairs(itemData) do	
			--	Debug.Print(key..": "..tostring(value))
			--end
			WindowClearAnchors("ScreenshotHelperIcon")
			WindowAddAnchor("ScreenshotHelperIcon", "center", "ScreenshotHelperBackground","center",0,0)
						
			--Debug.Print("" .. itemData.newHeight)
			WindowSetDimensions("ScreenshotHelper", ( itemData.newWidth * scale ) + 20, ( itemData.newHeight * scale ) + 20 )
			WindowSetDimensions("ScreenshotHelperIcon", itemData.newWidth * scale, itemData.newHeight * scale)
			--DynamicImageSetTextureScale( "ScreenshotHelperIcon", scale)
			WindowSetShowing("ScreenshotHelper", true)
			WindowSetShowing("ScreenshotHelperIcon", true)
			--Debug.Print(SystemData.Settings.Interface.customUiScale)
       end
       --WindowSetShowing("TargetWindow", false)

	--DynamicImageSetTextureScale( "Icon", 1.0 )
	
end




