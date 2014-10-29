----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SpellSpeed = {}
SpellSpeed.IsSpell = false
SpellSpeed.ActualSpeed = 0
SpellSpeed.UnlaggedSpeed = 0
SpellSpeed.ready =false
SpellSpeed.SpellId = 0
SpellSpeed.casting = false

function SpellSpeed.Stop()
	RequestTargetInfo()
end

function SpellSpeed.Timer(timePassed)
	if ( not SpellSpeed.casting) then
		
		if ( BuffDebuff.ActiveBuffs[10045]) then
			WindowData.BuffDebuffSystem.CurrentBuffId = 10045
			WindowData.BuffDebuff.TimerSeconds = 0
			WindowData.BuffDebuff.HasTimer = false
			WindowData.BuffDebuff.NameVectorSize = 1
			WindowData.BuffDebuff.ToolTipVectorSize = 1
			WindowData.BuffDebuff.IsBeingRemoved = true
			WindowData.BuffDebuff.NameWStringVector = {[1] =  UI.GetCliloc(SystemData.Settings.Language.type, 884)}
			WindowData.BuffDebuff.ToolTipWStringVector = {[1] = UI.GetCliloc(SystemData.Settings.Language.type, 886)}
			BuffDebuff.ShouldCreateNewBuff()				
		end
	end
	if ( SpellSpeed.casting) then
		WindowData.BuffDebuffSystem.CurrentBuffId = 10045
		local time = SpellSpeed.UnlaggedSpeed - SpellSpeed.ActualSpeed
		WindowData.BuffDebuff.TimerSeconds = tonumber(string.format("%3.1f",time))
		WindowData.BuffDebuff.HasTimer = true
		WindowData.BuffDebuff.NameVectorSize = 1
		WindowData.BuffDebuff.ToolTipVectorSize = 1
		WindowData.BuffDebuff.IsBeingRemoved = false 
		local icon, serverId, tid, desctid, reagents, powerword = GetAbilityData(SpellSpeed.SpellId)
		WindowData.BuffDebuff.NameWStringVector = {[1] = UI.GetCliloc(SystemData.Settings.Language.type, 884)}
		WindowData.BuffDebuff.ToolTipWStringVector = {[1] = UI.GetCliloc(SystemData.Settings.Language.type, 885) .. GetStringFromTid(tid)}
		BuffDebuff.ShouldCreateNewBuff()
	end
	if (SpellSpeed.IsSpell) then

				if (SpellSpeed.casting and SpellSpeed.ActualSpeed > SpellSpeed.UnlaggedSpeed ) then
					SpellSpeed.casting = false
					EnhancePack.ChatPrint(UI.GetCliloc(SystemData.Settings.Language.type, 873) .. SpellSpeed.UnlaggedSpeed .. L"s", SystemData.ChatLogFilters.SYSTEM ) 
					SpellSpeed.ready =true
				end
		SpellSpeed.ActualSpeed = SpellSpeed.ActualSpeed + timePassed
		
		if (SpellSpeed.ActualSpeed > SpellSpeed.UnlaggedSpeed * 5) then
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
			return
		end
		if (EnhancePack.CheckFizzle) then
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
			return
		end

		if( (WindowData.Cursor ~= nil and WindowData.Cursor.target == true)) then
			EnhancePack.ChatPrint(UI.GetCliloc(SystemData.Settings.Language.type, 330) .. StringToWString(string.sub(tostring(math.floor((SpellSpeed.ActualSpeed - SpellSpeed.UnlaggedSpeed)  * 100) / 100),1,4)) .. L"s", SystemData.ChatLogFilters.SYSTEM ) 
			EnhancePack.ChatPrint(UI.GetCliloc(SystemData.Settings.Language.type, 874) .. StringToWString(string.sub(tostring(math.floor(SpellSpeed.ActualSpeed * 100) / 100),1,4)) .. L"s", SystemData.ChatLogFilters.SYSTEM ) 
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
		end
	end
end