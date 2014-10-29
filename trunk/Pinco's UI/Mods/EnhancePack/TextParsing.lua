
TextParsing = {}
TextParsing.SpecialColors ={
["You swallow the fish whole!"] = true,
["You extract the message from the bottle."] = true,
["*evades*"] = true,
["You have hidden yourself well."] = true,
["* The poison seems to have no effect. *"] = true,
["* You push the strange green thorn into the ground *"] = true,
["* You eat the orange petal.  You feel more resilient! *"] = true,
["* You already feel resilient! You decide to save the petal for later *"] = true,
["You recover from the shock."] = true,
["* The creature has been beaten into subjugation! *"] = true,
["* You feel yourself resisting the effects of the poison *"] = true,
["*You start to tame the creature.*"] = true,
["*begins taming a creature.*"] = true,
["Your pet looks happier."] = true,
["It seems to accept you as master."] = true,
}
TextParsing.Specials ={
["Select Marked item."] = EnhancePack.Neutral,
["Your gem is now active. You may enter the Experimental Room"] = {r=16,g=184, b=0},
["The next room has been unlocked! Hurry through the door before your gem's state changes again!"] = {r=16,g=184, b=0},
["The next room has been unlocked! Hurry through the door before your gem's state changes again!"] = {r=16,g=184, b=0},
["You finish assembling your key and may now unlock the third puzzle."] = {r=16,g=184, b=0},
["You've solved the puzzle!! An item has been placed in your bag."] = {r=16,g=184, b=0},
[WStringToString(GetStringFromTid(1054054))] = {r=16,g=184, b=0}, -- You have completed your study of this Solen Egg Nest. You put your notes away.
[WStringToString(GetStringFromTid(1054057))] = {r=16,g=184, b=0}, -- You complete your examination of this bizarre Egg Nest. The Naturalist will undoubtedly be quite interested in these notes!
[WStringToString(GetStringFromTid(1113403))] = {r=16,g=184, b=0}, -- Congratulations!! The last room has been unlocked!! Hurry through to claim your reward! 
[WStringToString(GetStringFromTid(1113579))] = {r=16,g=184, b=0}, -- Correct Code Entered. Crystal Lock Disengaged. 

}
TextParsing.OverHeadErrors ={
["More reagents are needed for this spell."] = "fizzle",
["The spell fizzles."] = "fizzle",
["You stepped onto a spike trap!"] = true,
["You stepped onto a blade trap!"] = true,
["You are enveloped by a noxious gas cloud!"] = true,
["You take damage from an exploding mushroom!"] = true,
["OUCH!"] = true,
["* The sound of gas escaping is heard from the chest. *"] = true,
["*rummages through a corpse and takes an item*"] = true,
["*You feel a bit nauseous*"] = true,
["* You feel disoriented and nauseous! *"] = true,
["* You begin to feel pain throughout your body! *"] = true,
["* You feel extremely weak and are in severe pain! *"] = true,
["* You are in extreme pain, and require immediate aid! *"] = true,
["You cannot heal that target in their current state."] = true,
["You feel dizzy from a lack of clear air"] = true,
["You are bleeding profusely"] = true,
["Your equipment is severely damaged."] = true,
["You must wait a few seconds before using another healing potion."] = true,
["I am dead and cannot do that."] = true,
["*looks confused*"] = true,
["I cannot recall from that object."] = true,
["I cannot recall from that object right now."] = true,
["I can't reach that."] = true,
["That location is blocked."] = true,
["You have been revealed!"] = true,
["You can't seem to hide right now."] = true,
["Insufficient mana for this spell."] = true,
["Medusa releases one of the petrified creatures!!"] = true,
["This is already locked down."] = true,
["The fish don't seem to be biting here."] = true,
["You play poorly, and there is no effect."] = true,
["* The creature goes into a frenzied rage! *"] = true,
["A dart imbeds itself in your flesh!"] = true,
["An arrow imbeds itself in your flesh!"] = true,
["*Splashing acid blood scars your weapon!*"] = true,
["* Your body convulses from electric shock *"] = true,
["A toxic vapor envelops thee."] = true,
["Pain lances through thee from a sharp metal blade."] = true,
["Lightning arcs through thy body."] = true,
["Searing heat scorches thy skin."] = true,
["You are still too dazed from being knocked off your mount to ride."] = true,
["You are still too dazed to fly."] = true,
["* The solen's damaged acid sac squirts acid! *"] = true,
["The creature looks at you strangely and shakes its head no."] = true,
["You can't see that."] = true,
["You can't tame that!"] = true,
["That creature cannot be tamed."] = true,
["It's too far away."] = true,
["That animal looks tame already."] = true,
["Someone else is already taming that creature."] = true,
["You seem to anger the beast!"] = true,
["You have no chance of taming this creature."] = true,
["* You feel the effects of your poison resistance wearing off *"] = true,
["* The strength of the poison overcomes your resistance! *"] = true,
["Ah, art thou trying to fool me? Thou hast not so much gold!"] = true,
[GetStringFromTid(1054046)] = true, -- You abandon your study of the Solen Egg Nest without gathering the needed information.
["You fail to neutralize the gem in time and are expelled from the room!!"] = true,
}

function TextParsing.Emotize(string)
	return "* " .. string .. " *"
end

function TextParsing.ColorizeText()
	local senderText = WStringToString(SystemData.Text)
	local emotized = false
	local channel = SystemData.TextChannelID
	if (wstring.len(SystemData.Text) > 1 and wstring.find(wstring.sub(SystemData.Text, 1, 2), L'*') and wstring.find(wstring.sub(SystemData.Text, -1), L'*')) then
		channel = SystemData.ChatLogFilters.EMOTE
		emotized = true
	end
	local default = ChatSettings.ChannelColors[SystemData.TextChannelID]
	local color = {r= default.r, g=default.g, b=default.b}
	if (EnhancePack.SadMode) then
		return color, channel
	end
	if (SystemData.TextColor ~= 0 and not emotized) then
		color = SystemData.TextColor
	end

	if SpellsInfo.SpellsData[senderText] then
		return SpellsInfo.SpellsData[senderText].color, channel
	end
		
	local find = string.find
	 
	if (SystemData.TextChannelID == 16) then
		SystemData.SourceName = GetStringFromTid(3000610)
		color.r,color.g,color.b = HueRGBAValue(1195)
		return color, channel
	end
		
	if (find(senderText , "The creature goes into a frenzied rage!")) then
		senderText = TextParsing.Emotize(string)
		SystemData.Text = StringToWString(senderText)
	end
		
	if TextParsing.OverHeadErrors[senderText] then
		if (TextParsing.OverHeadErrors[senderText] == "fizzle") then
			EnhancePack.CheckFizzle = true
		end
		return EnhancePack.OverHeadError, channel
	end
	
	if TextParsing.SpecialColors[senderText] then
		if (TextParsing.SpecialColors[senderText] == "fizzle") then
			EnhancePack.CheckFizzle = true
		end
		return EnhancePack.SpecialColor, channel
	end
	
	local special = TextParsing.Specials[senderText]
	if special then
		return special, channel
	end
	
	if ( find(senderText , " looks ill.*") 
		or find(senderText , " looks extremely ill. *")
		or find(senderText , " stumbles around in confusion and pain. *")
		or find(senderText , " is wracked with extreme pain. *")
		or find(senderText , " begins to spasm uncontrollably. *")
		or find(senderText , "You are attacking ")
		or find(senderText , " is attacking you!")
		or find(senderText , " is bleeding profusely")
		or find(senderText , " The solen's acid sac is burst open!")
		or find(senderText , " appears to have decided that it is better off without a master!")
		) then
		
		return EnhancePack.OverHeadError, channel
	end
	
	if ( find(senderText , " seems resistant to the poison *")
		or find(senderText , " pushes a strange green thorn into the ground. *")
		or find(senderText , "Bank container has")
		or find(senderText , "Thy current bank balance is:")
		) then
		
		return EnhancePack.SpecialColor, channel
	end
	
	if ( find(senderText , "Into your bank box I have placed a check in the amount of:")
		or find(senderText , "I need to add some ")
		) then
		
		return EnhancePack.POISON, channel
	end
	
	if ( EnhancePack.CurrentSubArea == "Experimental Room") then
	
		-- COLOR ROOM
		if ( senderText == "Warm") then
			color = {r=255, g=255, b=255}
		end
		
		if ( senderText == "Cold") then
			color = {r=188, g=133, b=131}
		end
		
		if ( senderText == "Blazing") then
			color = {r=43, g=131, b=236}
		end
		
		if ( senderText == "Freezing") then
			color = {r=172, g=0, b=41}
		end
		
		if ( senderText == "Lesser Poison") then
			color = {r=187, g=132, b=0}
		end
		
		if ( senderText == "Lesser Cure") then
			color = {r=122, g=210, b=125}
		end
		
		if ( senderText == "Lethal Poison") then
			color = {r=134, g=64, b=11}
		end
		
		if ( senderText == "Greater Cure") then
			color = {r=51, g=101, b=78}
		end
	end
	return color, channel
end

function TextParsing.CenterScreenText()
	local senderText = WStringToString(SystemData.Text)
	
	if ( ( senderText == "The servers are going down shortly." or string.find(senderText, "Servers going down: You have approximately")) and SystemData.SourceName == L"") then 
		EnhancePack.SendCenterScreenTexture("serverdown")
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1074834)) and SystemData.SourceName == L"") then -- Please enter [ to reply to the GM. 
		EnhancePack.SendCenterScreenTexture("gmarrived")
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1062317)) and SystemData.SourceName == L"") then -- "For your valor in combating the fallen beast, a special artifact has been bestowed on you."
		EnhancePack.SendCenterScreenTexture("artifact")
	end

	if ( senderText == WStringToString(GetStringFromTid(502088))  and SystemData.SourceName == L"") then -- "A special gift has been placed in your backpack."
		EnhancePack.SendCenterScreenTexture("artifact")
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1154530))  and SystemData.SourceName == L"") then -- "You notice the crest of Minax on your fallen foe's equipment and decide it may be of some value..."
		EnhancePack.SendCenterScreenTexture("artifact")
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1154554))  and SystemData.SourceName == L"") then -- "You recover an artifact bearing the crest of Minax from the rubble."
		EnhancePack.SendCenterScreenTexture("artifact")
	end
	 
	--[[
	if ( senderText ==  WStringToString(GetStringFromTid(1072068)) or senderText == WStringToString(GetStringFromTid(1072069)) and SystemData.SourceName == L"") then -- "Your enemy's putrid presence envelops you, overwhelming you with nausea." or "A cacophonic sound lambastes you, suppressing your ability to move."
		if (senderText == WStringToString(GetStringFromTid(1072069))) then -- "A cacophonic sound lambastes you, suppressing your ability to move."
			EnhancePack.Cantrun = true
			EnhancePack.CacophonicTime = 29
		else
			EnhancePack.PutridNauseaTime = 29
		end

		EnhancePack.SendCenterScreenTexture("slowed")
	end	
	
	if ( senderText == WStringToString(GetStringFromTid(1112768))  and SystemData.SourceName == L"" ) then -- "You have been turned to stone!!!"
		EnhancePack.SendCenterScreenTexture("stoned")
		EnhancePack.StoneTime = 7
	end	
	
	
	if ( senderText == WStringToString(GetStringFromTid(1113247))  and SystemData.SourceName == L"" ) then -- "You are wrapped in spider webbing and cannot move!"
		EnhancePack.SendCenterScreenTexture("webbed")
		EnhancePack.WebTime = 9
	end	
	
	if ( senderText == WStringToString(GetStringFromTid(1042555))  and SystemData.SourceName == L"" ) then -- "You become entangled in the spider web."
		EnhancePack.SendCenterScreenTexture("webbed")
		EnhancePack.WebTime = 9
	end	
	--]]
	
	--text = string.find(senderText , UI.GetCliloc(SystemData.Settings.Language.type, 479))
	
--	if ( (	senderText == WStringToString(GetStringFromTid(1080339)) or -- "A sense of discomfort passes through you, but it fades quickly"
--			senderText == WStringToString(GetStringFromTid(1080340)) or -- "An unfamiliar fear washes over you, and for a moment you're unable to move" 
--			senderText == WStringToString(GetStringFromTid(1080341)) or --"Panic grips you! You're unable to move, to think, to feel anything but fear!"
--			string.find(string.sub(WStringToString(GetStringFromTid(1080342)),1, string.find(WStringToString(GetStringFromTid(1080342)), "~1_name~") ), senderText) or --"Terror slices into your very being, destroying any chance of resisting ~1_name~ you might have had"
--			string.find(string.sub(WStringToString(GetStringFromTid(1080342)),1, string.find(WStringToString(GetStringFromTid(1080343)), "~1_name~") ), senderText) or --"Everything around you dissolves into darkness as ~1_name~'s burning eyes fill your vision"
--			text  ~= nil )
--	 and SystemData.SourceName == L"" ) then
--		EnhancePack.SendCenterScreenTexture("panic")
--		EnhancePack.FearActive = true
--		--EnhancePack.SendCenterScreenTextRGB(L">>> STONED!!! <<<", 128,128,128)
--	end	

	--[[
	if ( senderText == WStringToString(GetStringFromTid(1080339))  and SystemData.SourceName == L"" ) then -- "A sense of discomfort passes through you, but it fades quickly"
		local serverId = WindowData.SkillsCSV[33].ServerId
		local resSpell = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
		if ( WindowData.PlayerStatus["Race"] == 1 and  resSpell < 20) then
			resSpell = 20
		end
		EnhancePack.FearTime = 11 - (resSpell/13.2) -1
		EnhancePack.SendCenterScreenTexture("panic")
	end
	--]]
	
	if ( senderText == WStringToString(GetStringFromTid(1112600))  and SystemData.SourceName == L"" ) then -- "Your lenses crumble. You are no longer protected from Medusa's gaze!"
		EnhancePack.SendCenterScreenTexture("gorgon")
	end
	
	if ( senderText ==  WStringToString(GetStringFromTid(1075007)) and SystemData.SourceName == L""  ) then -- "Your bone handled machete snaps in half as you force your way through the poisonous undergrowth."
		EnhancePack.SendCenterScreenTexture("machete")
	end
	
	
	if ( senderText == WStringToString(GetStringFromTid(1152527))  and SystemData.SourceName == L"" ) then -- "The battle for the Void Pool is beginning now!"
		EnhancePack.SendCenterScreenTexture("battlebegin")
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1152530))  and SystemData.SourceName == L"" ) then -- "Cora's forces have destroyed the Void Pool walls. The battle is lost!"
		EnhancePack.SendCenterScreenTexture("battlelost")
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1154550))  and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then -- "*A sound roars in the distance...Minax's Beacon is vulnerable to attack!!*"
		EnhancePack.SendCenterScreenTexture("beacon")
	end
	
	if ( senderText ==  WStringToString(GetStringFromTid(1005603)) and SystemData.SourceName == L"" ) then -- "You can move again!"
		if (not BuffDebuff.Timers[10037]) then
			EnhancePack.SendCenterScreenTexture("free")
		end
		EnhancePack.FallingWallsTime = 0
		--EnhancePack.FearTime = 0
		--EnhancePack.StoneTime = 0
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1080016)) and SystemData.SourceName == L""  ) then -- "That container cannot hold more weight."
		EnhancePack.SendCenterScreenTexture("backpackfull")
	end
end

function TextParsing.TimersNbuff()
	local senderText = WStringToString(SystemData.Text)
	
	local clean =  wstring.sub(GetStringFromTid(1151569), wstring.find(GetStringFromTid(1151569),L"~1_ITEMNAME~")+13)  -- The magic of the ~1_ITEMNAME~ enhances your skills, doubling your Mastery Bonus!
	if ( string.find(senderText, WStringToString(clean)) and SystemData.SourceName == L"") then -- "The magic of the ~1_ITEMNAME~ enhances your skills, doubling your Mastery Bonus!"
		EnhancePack.BardMasteryBonusTime = 59
	end
	
	clean =  wstring.sub(GetStringFromTid(1151570), 1, wstring.find(GetStringFromTid(1151570),L"~1_ITEMNAME~"))  -- The magic of the ~1_ITEMNAME~ fades.
	local clean1 =  wstring.sub(GetStringFromTid(1151570), wstring.find(GetStringFromTid(1151570),L"~1_ITEMNAME~")+13)
	if ( string.find(senderText, WStringToString(clean)) and string.find(senderText, WStringToString(clean1)) and SystemData.SourceName == L"") then -- ""
		EnhancePack.BardMasteryBonusTime = 0
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1151532)) and SystemData.SourceName == L"") then -- "You enter a berserk rage!"
		EnhancePack.BerserkRage = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1151535)) and SystemData.SourceName == L"") then -- "Your berserk rage has subsided."
		EnhancePack.BerserkRage = false
	end	
	
	if ( senderText == WStringToString(GetStringFromTid(1071176)) and SystemData.SourceName == L"") then -- "You can't maintain your special form anymore."
		EnhancePack.HorrificActive = false
		CustomSettings.SaveBoolean( "EnhancePackHorrificActive", EnhancePack.HorrificActive  )
		
		EnhancePack.WraithActive = false
		CustomSettings.SaveBoolean( "EnhancePackWraithActive", EnhancePack.WraithActive  )
		
		EnhancePack.LichActive = false
		CustomSettings.SaveBoolean( "EnhancePackLichActive", EnhancePack.LichActive  )
	
		EnhancePack.VampireActive = false
		CustomSettings.SaveBoolean( "EnhancePackVampireActive", EnhancePack.VampireActive  )
		
		EnhancePack.ReaperActive = false
		CustomSettings.SaveBoolean( "EnhancePackReaperActive", EnhancePack.ReaperActive  )
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1072681))  and SystemData.SourceName == L"" ) then -- "The master of this realm has been slain! You may only stay here so long."
		EnhancePack.Cantrun = false
	end	
	
	--if ( senderText == WStringToString(GetStringFromTid(1072065))  and SystemData.SourceName == L"" ) then -- "You gaze upon the dryad's beauty, and forget to continue battling!"
	--	EnhancePack.DryadTime = 20
	--end	
	
	--if ( senderText == WStringToString(GetStringFromTid(1072066))  and SystemData.SourceName == L"" ) then -- "You gaze upon the dryad's beauty and are momentarily distracted."
	--	EnhancePack.DryadTime = 20
	--end	
	
	if ( senderText == WStringToString(GetStringFromTid(1072067))  and SystemData.SourceName == L"" ) then -- "A wave of hopelessness washes over you, suppressing your ability to react in combat."
		EnhancePack.HopelessTime = 59
	end	
	
	if ( senderText == WStringToString(GetStringFromTid(1113248))  and SystemData.SourceName == L"" ) then -- "You escape the spider's web!"
		EnhancePack.WebTime = 0
	end	
	
	if ( senderText == WStringToString(GetStringFromTid(1042532))  and SystemData.SourceName == L"" ) then -- "You free yourself from the web!"
		EnhancePack.WebTime = 0
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1111641))  and SystemData.SourceName == L"" ) then -- "You become entangled in the acid drenched roots."
		EnhancePack.EntangleActive = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1111642))  and SystemData.SourceName == L"" ) then -- "You manage to untangle yourself."
		EnhancePack.EntangleActive = false
	end
	
	
	if ( senderText ==  WStringToString(GetStringFromTid(1111672)) and SystemData.SourceName == L""  ) then -- "The rotworm has infected you with blood disease!!"
		EnhancePack.BloodDiseaseTime = 16
	end
	if ( senderText ==  WStringToString(GetStringFromTid(1111673)) and SystemData.SourceName == L""  ) then -- "You no longer feel sick."
		EnhancePack.BloodDiseaseTime = 0
	end
	
	if ( senderText ==  WStringToString(GetStringFromTid(1074847)) and SystemData.SourceName == L""  ) then -- "The grapes of wrath invigorate you for a short time, allowing you to deal extra damage."
		EnhancePack.GrapeTime = 19
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1152144)) and SystemData.SourceName == L""  ) then -- You suddenly find yourself unable to run.
		EnhancePack.UnableToRun = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1152145)) and SystemData.SourceName == L""  ) then -- You are are free to move again.
		EnhancePack.UnableToRun = false
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1151482)) and SystemData.SourceName == L""  ) then -- "Your mana has been tainted!"
		EnhancePack.ManaTaintTime = 4
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1151483)) and SystemData.SourceName == L""  ) then -- "Your mana is no longer corrupted."
		EnhancePack.ManaTaintTime = 0
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1151485)) and SystemData.SourceName == L""  ) then -- "Your mana is being diverted."
		EnhancePack.ManaDivertTime = 4
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1151486)) and SystemData.SourceName == L""  ) then -- "Your mana is no longer being diverted."
		EnhancePack.ManaDivertTime = 0
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1070839)) and SystemData.SourceName == L""  ) then -- "The creature attacks with stunning force!"
		EnhancePack.StunTime = 4
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1150886)) and SystemData.SourceName == L""  ) then -- "Splashes from the creature encrust your weapon and equipment, slowing your movement."
		EnhancePack.MudTime = 5
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1150887)) and SystemData.SourceName == L""  ) then -- "You are no longer slowed and encrusted."
		EnhancePack.MudTime = 0
	end
	
	if ( senderText ==  WStringToString(GetStringFromTid( 1063225))  and SystemData.SourceName == L""   ) then -- "You have gained in Honor."
		EnhancePack.PerfectionCounterCurrent = 0
	end
	
	if ( senderText ==  WStringToString(GetStringFromTid( 1063160))  and SystemData.SourceName == L""   ) then -- "Target what you wish to honor."
		EnhancePack.WaitHonor = true
	end
	if ( senderText ==  WStringToString(GetStringFromTid( 1115884))  and SystemData.SourceName == L""   ) then -- "You started Honorable Combat!"
		EnhancePack.HonorMobileConfirm(EnhancePack.TempHonor)
	end
	
	
	if ( senderText ==  WStringToString(GetStringFromTid( 1115884))  and SystemData.SourceName == L""   ) then
		EnhancePack.PerfectionCounterCurrent = 0
		local serverId = WindowData.SkillsCSV[9].ServerId
		local skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue
		if ( WindowData.PlayerStatus["Race"] == 1 and  skillLevel < 20) then
			skillLevel = 20
		end
		EnhancePack.PerfectionCounterStep = math.floor(skillLevel / 100)
	end
	
	
	
	if ( senderText == WStringToString(GetStringFromTid( 1063256)) and SystemData.SourceName == L""   ) then -- "You have lost all Perfection in fighting this opponent." 
		EnhancePack.PerfectionCounterCurrent = 0
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1063254)) and SystemData.SourceName == L""   ) then -- "You have Achieved Perfection in inflicting damage to this opponent!"
		EnhancePack.PerfectionCounterCurrent = 100
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1062074))  and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then --"Anh Mi Sah Ko"
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 5
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 500397)) and SystemData.SourceName == L"" ) then --"To whom do you wish to grovel?"
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 11
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 500612)) and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then -- "You play poorly, and there is no effect."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 6
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1010597)) and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then --  "*You start to tame the creature.*" 
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 11
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 502730))  and SystemData.SourceName == L"" ) then --  "You begin to move quietly."
		if (HotbarSystem.SkillDelayTime > 5) then
			HotbarSystem.SkillDelayRestarted = true
			HotbarSystem.SkillDelayTime = 5
		end
	end
	
	
	if ( senderText == WStringToString(GetStringFromTid( 501240))  and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then --  "You have hidden yourself well."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 11
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 501241))  and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then -- "You fail to hide."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 11
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 501596))  and SystemData.SourceName == L"" ) then -- "You play rather poorly, and to no effect."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 8
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1011350)) and SystemData.SourceName == L"" ) then -- "What do you wish to track?"
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 10
	end
	
	if ( (senderText == WStringToString(GetStringFromTid( 500618)) or senderText ==  "That is not a musical instrument.")  and SystemData.SourceName == L"" and EnhancePack.InstrumentCheck ) then -- "That is too far away!"
		HotbarSystem.SkillDelayTime = 9
		EnhancePack.InstrumentCheck = false
		HotbarSystem.SkillDelayRestarted = true
	end
	
	if (EnhancePack.InstrumentCheck) then
		EnhancePack.InstrumentCheck = false
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 500617)) and SystemData.SourceName == L"" ) then -- "What instrument shall you play?"
		EnhancePack.InstrumentCheck = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 502368)) and SystemData.SourceName == L"" ) then -- "Which trap will you attempt to disarm?"
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 10
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 500819)) and SystemData.SourceName == L"" ) then -- "Where will you search?"
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 10
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 502698)) and SystemData.SourceName == L"" ) then -- "Which item will you attempt to steal?"
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 10
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1005584)) and SystemData.SourceName == L"" ) then -- "Both hands must be free to steal."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 10
	end	
	
	if ( senderText == WStringToString(GetStringFromTid( 1049532)) and SystemData.SourceName == L"" ) then -- "You play hypnotic music, calming your target."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 8
		
		if (EnhancePack.BardMastery) then
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end

	end
	
	if ( senderText == WStringToString(GetStringFromTid( 500615)) and SystemData.SourceName == L"" ) then -- "You play your hypnotic music, stopping the battle."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 8
		if (EnhancePack.BardMastery) then
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end

	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1049648)) and SystemData.SourceName == L"" ) then -- "You play hypnotic music, but there is nothing in range for you to calm."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 8
		if (EnhancePack.BardMastery) then
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end

	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1049531))  and SystemData.SourceName == L"" ) then -- "You attempt to calm your target, but fail."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 6
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 501602)) and SystemData.SourceName == L"" ) then -- "Your music succeeds, as you start a fight."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 8
		if (EnhancePack.BardMastery) then
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end

	end
	
	if ( senderText == WStringToString(GetStringFromTid( 501599)) and SystemData.SourceName == L"" ) then -- "Your music fails to incite enough anger."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 6
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1049539)) and SystemData.SourceName == L"" ) then -- "You play jarring music, suppressing your target's strength."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 8
		if (EnhancePack.BardMastery) then
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end

	end
	
	if ( SystemData.SourceName == L"" ) then
		-- "You are at peace." "You cannot focus your concentration." "You are busy doing something else and cannot focus." "You enter a meditative trance."
		if (senderText == WStringToString(GetStringFromTid( 501846))  or senderText == WStringToString(GetStringFromTid( 501848)) or senderText == WStringToString(GetStringFromTid( 501845)) or senderText == WStringToString(GetStringFromTid( 501851))) then
			HotbarSystem.SkillDelayRestarted = true
			HotbarSystem.SkillDelayTime = 10
		end
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 502137)) and SystemData.SourceName == L"" ) then -- "Select the poison you wish to use."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 10
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1049540)) and SystemData.SourceName == L"" ) then -- "You attempt to disrupt your target, but fail."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 6
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1063121)) and SystemData.SourceName == L"" ) then -- "You no longer feel that you could deflect any attack."
		--EnhancePack.EvasionCooldown = 14
		--EnhancePack.EvasionRestart = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1063120)) and SystemData.SourceName == L"" ) then --"You feel that you might be able to deflect any attack!"
		
		--[[
		EnhancePack.EvasionTime = 3
		EnhancePack.EvasionParryBonus = 0
		local serverId = WindowData.SkillsCSV[9].ServerId
		local bushido = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
		if ( WindowData.PlayerStatus["Race"] == 1 and  bushido < 20) then
			bushido = 20
		end
		serverId = WindowData.SkillsCSV[2].ServerId
		local anatomy = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
		if ( WindowData.PlayerStatus["Race"] == 1 and  anatomy < 20) then
			anatomy = 20
		end
		serverId = WindowData.SkillsCSV[51].ServerId
		local tactics = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
		if ( WindowData.PlayerStatus["Race"] == 1 and  tactics < 20) then
			tactics = 20
		end
		if (bushido > 60) then
			EnhancePack.EvasionTime = EnhancePack.EvasionTime  + (bushido - 60) / 20
			EnhancePack.EvasionParryBonus = EnhancePack.EvasionParryBonus + (((bushido - 60) * 0.004 )  + 0.16 )
		end
		
		if (bushido >= 100 and anatomy >= 100 and tactics >= 100) then
			EnhancePack.EvasionTime = EnhancePack.EvasionTime + 1
			EnhancePack.EvasionParryBonus = EnhancePack.EvasionParryBonus + 0.1
		end
		EnhancePack.EvasionParryBonus = EnhancePack.EvasionParryBonus * 100
		
		EnhancePack.CounterTime  = 0
		EnhancePack.ConfidenceTime  = 0
		--]]	
	end
	
	--[[
	if ( senderText == WStringToString(GetStringFromTid( 1063118)) and SystemData.SourceName == L"" ) then -- "You prepare to respond immediately to the next blocked blow." 
		EnhancePack.CounterTime = 30
		if (EnhancePack.EvasionTime > 0) then
			EnhancePack.EvasionCooldown = 14
		end
		EnhancePack.ConfidenceTime  = 0
		EnhancePack.EvasionTime  = 0
	end
	
	if ( senderText ==  WStringToString(GetStringFromTid( 1063115)) and SystemData.SourceName == L"" ) then -- "You exude confidence."
		EnhancePack.ConfidenceTime = 15
		if (EnhancePack.EvasionTime > 0) then
			EnhancePack.EvasionCooldown = 14
		end
		EnhancePack.CounterTime  = 0
		EnhancePack.EvasionTime  = 0
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1070846)) and SystemData.SourceName == L"" ) then -- "The creature magically corrupts your armor!"
		EnhancePack.ArmorCorruptTime = 5
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1070845)) and SystemData.SourceName == L"" ) then -- "The creature continues to corrupt your armor!"
		EnhancePack.ArmorCorruptTime = 5
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1070837)) and SystemData.SourceName == L"" ) then -- "The creature lands another blow in your weakened state."
		EnhancePack.GaspingTime = 5
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1070836)) and SystemData.SourceName == L"" ) then -- "The blow from the creature's claws has made you more susceptible to physical attacks."
		EnhancePack.GaspingTime = 5
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1070825)) and SystemData.SourceName == L"" ) then -- "The creature continues to rage!"
		EnhancePack.TearTime = 5
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1070826)) and SystemData.SourceName == L"" ) then -- "The creature goes into a rage, inflicting heavy damage!"
		EnhancePack.TearTime = 5
	end
	--]]
	
	if ( senderText == WStringToString(GetStringFromTid( 1114817)) and SystemData.SourceName == L"" ) then -- "The Slasher emits a powerful howl, shaking the very walls around you and suppressing your ability to move."
		EnhancePack.FallingWallsTime = 10
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1063235)) and SystemData.SourceName == L"" ) then -- "You embrace your honor"
		EnhancePack.HonorActive = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1063236)) and SystemData.SourceName == L"" ) then -- "You no longer embrace your honor"
		EnhancePack.HonorActive = false
		EnhancePack.SendCenterScreenTexture("honorwearoff")
	end
	
	text = string.find(senderText , UI.GetCliloc(SystemData.Settings.Language.type, 481))
	if ( text ~= nil and SystemData.SourceName == L"") then
		
		local first = text + string.len(UI.GetCliloc(SystemData.Settings.Language.type, 481))
		
		local second = string.find(senderText , UI.GetCliloc(SystemData.Settings.Language.type, 482), first)
		EnhancePack.AttunementCharges = tonumber(string.sub(senderText, first, second))
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1075125)) and SystemData.SourceName == L"" ) then -- "Your attunement fades."
		EnhancePack.AttunementCharges = 0
		EnhancePack.AttunementCooldown = 120
		EnhancePack.AttunementRestart = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1074771)) and SystemData.SourceName == L"" ) then -- "You are no longer under the effects of Ethereal Voyage."
		EnhancePack.EtherealVoyageCooldown = 300
		EnhancePack.EtherealVoyageRestart = true
	end
end

function TextParsing.SpellCasting()
	local senderText = WStringToString(SystemData.Text)
	
	local clean =  wstring.gsub(GetStringFromTid(1080117),L"~1_ABILITY_NAME~", GetStringFromTid(1060514))  -- HOrrific beast
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "Your ~1_ABILITY_NAME~ has been purged."
		EnhancePack.HorrificActive = false
	end
	
	clean =  wstring.gsub(GetStringFromTid(1080117),L"~1_ABILITY_NAME~", GetStringFromTid(1060524))  -- wraith form
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "Your ~1_ABILITY_NAME~ has been purged."
		EnhancePack.WraithActive = false
	end
	
	clean =  wstring.gsub(GetStringFromTid(1080117),L"~1_ABILITY_NAME~", GetStringFromTid(1060515))  -- lich form
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "Your ~1_ABILITY_NAME~ has been purged."
		EnhancePack.LichActive = false
	end
	
	clean =  wstring.gsub(GetStringFromTid(1080117),L"~1_ABILITY_NAME~", GetStringFromTid(1060521))  -- vampiric
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "Your ~1_ABILITY_NAME~ has been purged."
		EnhancePack.VampireActive = false
	end
	
	clean =  wstring.gsub(GetStringFromTid(1080117),L"~1_ABILITY_NAME~", GetStringFromTid(1071034))  -- reaper
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "Your ~1_ABILITY_NAME~ has been purged."
		EnhancePack.ReaperActive = false
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1063218)) and SystemData.SourceName == L"") then -- "You cannot use that ability in this form."
		EnhancePack.CheckFizzle = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid(501078)) and SystemData.SourceName == L"") then -- "You must be holding a weapon."
		EnhancePack.CheckFizzle = true
	end
	
	text = string.find(senderText , UI.GetCliloc(SystemData.Settings.Language.type, 483))
	if ( text ~= nil and SystemData.SourceName == L"") then
		
		local first = string.len(UI.GetCliloc(SystemData.Settings.Language.type, 484))
		
		local second = text
		
		EnhancePack.ReflectionCooldown = tonumber(string.sub(senderText, first, second))
		EnhancePack.ReflectionRestart = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1150066)) and SystemData.SourceName == L"" ) then -- "Your magic reflection pool has been depleted."
		EnhancePack.ReflectionCharges = 0
		EnhancePack.ReflectionCooldown = 30
		EnhancePack.ReflectionRestart = true
	end
	
	if ( senderText  == "An Sanct Gra Char") then
		if (SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
			local FC = tonumber(WindowData.PlayerStatus["FasterCasting"])
			EnhancePack.CastTime = 1 - (FC * 0.25)
			if (EnhancePack.CastTime < 1) then
				EnhancePack.CastTime = 1
			end
			EnhancePack.CurseCasting = true
		end
	end
	
	if ( senderText == "Rel Xen Vas Bal" ) then
		if (SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
			local FC = tonumber(WindowData.PlayerStatus["FasterCasting"])
			EnhancePack.CastTime = 3 -- (FC * 0.25)

			EnhancePack.HorrificCasting = true
		end
	end
	
	if ( senderText == "Rel Xen Corp Ort" ) then
		if (SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
			local FC = tonumber(WindowData.PlayerStatus["FasterCasting"])
			EnhancePack.CastTime = 3 -- (FC * 0.25)

			EnhancePack.LichCasting = true
		end
	end
	
	if ( senderText == "Rel Xen An Sanct" ) then
		if (SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
			local FC = tonumber(WindowData.PlayerStatus["FasterCasting"])
			EnhancePack.CastTime = 3 -- (FC * 0.25)

			EnhancePack.VampireCasting = true
		end
	end
	
	if ( senderText == "Rel Xen Um" ) then
		if (SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
			local FC = tonumber(WindowData.PlayerStatus["FasterCasting"])
			EnhancePack.CastTime = 3 -- (FC * 0.25)

			EnhancePack.WraithCasting = true
		end
	end
	
	if ( senderText == "Tarisstree" ) then
		if (SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
			EnhancePack.CastTime = 3
			EnhancePack.Currentsdi = tonumber(WindowData.PlayerStatus["SpellDamageIncrease"])
			EnhancePack.ReaperCasting = true
		end
	end
end

TextParsing.Fame = {
[WStringToString(GetStringFromTid(1019051))] = true;
[WStringToString(GetStringFromTid(1019052))] = true;
[WStringToString(GetStringFromTid(1019053))] = true;
[WStringToString(GetStringFromTid(1019054))] = true;
[WStringToString(GetStringFromTid(1019055))] = true;
[WStringToString(GetStringFromTid(1019056))] = true;
[WStringToString(GetStringFromTid(1019057))] = true;
[WStringToString(GetStringFromTid(1019058))] = true;
}

TextParsing.Karma = {
[WStringToString(GetStringFromTid(1019059))] = true;
[WStringToString(GetStringFromTid(1019060))] = true;
[WStringToString(GetStringFromTid(1019061))] = true;
[WStringToString(GetStringFromTid(1019062))] = true;
[WStringToString(GetStringFromTid(1019063))] = true;
[WStringToString(GetStringFromTid(1019064))] = true;
[WStringToString(GetStringFromTid(1019065))] = true;
[WStringToString(GetStringFromTid(1019066))] = true;
}

function TextParsing.SpecialTexts()
	local senderText = WStringToString(SystemData.Text)
	
	local clean =  wstring.gsub(GetStringFromTid(1151281),L"~1_VALUE~!", L"")
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "Your Clean Up Britannia point total is now ~1_VALUE~!"
		local num = string.gsub(senderText, WStringToString(clean), "")
		local num = string.gsub(num, "!", "")
		local num = WindowUtils.AddCommasToNumber(num)
		SystemData.Text = wstring.gsub(GetStringFromTid(1151281),L"~1_VALUE~", num)
		SystemData.TextColor = {r=16,g=184, b=0}
	end
	
	-- CHARYBDIS
	clean =  wstring.gsub(GetStringFromTid(1150191),L" ~1_val~", L"")  -- The location you seek is: ~1_val~
	if ( string.find(senderText,WStringToString(clean)) and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then -- "The location you seek is:"
		local coord = string.gsub(senderText, WStringToString(clean), "")
		coord = StringToWString(coord)
		local text2 = wstring.find(coord, L"[,]")
		local first = wstring.sub(coord, 1, text2 - 1)
		first = wstring.gsub(first, L"o ", L".")
		first = wstring.gsub(first, L"'", L"")
						

		local latDir = wstring.sub(first, -1)
		local latVal = wstring.sub(first,1, -2)
			
		local second = wstring.sub(coord, text2 + 3)
		second = wstring.gsub(second, L"o ", L".")
		second = wstring.gsub(second, L"'", L"")
		local longDir = wstring.sub(second, -1)
		local longVal = wstring.sub(second,1, -2)
		local x,y = MapCommon.ConvertToXYMinutes(tonumber(latVal), tonumber(longVal), latDir, longDir, 1, 1)
		UOCreateUserWaypoint( MapCommon.WaypointCustomType, x, y, WindowData.PlayerLocation.facet, L"Charybdis" .. L"_ICON_100010_SCALE_" .. 0.69 )
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1077957)) and SystemData.SourceName == L"") then -- "The intense energy dissipates. You are no longer under the effects of an accelerated skillgain scroll."
		EnhancePack.AlacrityStart = 0
		CustomSettings.SaveNumber( "EnhancePackAlacrityStart", EnhancePack.AlacrityStart )
	end
	if ( senderText == WStringToString(GetStringFromTid(1077956)) and SystemData.SourceName == L"") then -- "You are infused with intense energy. You are under the effects of an accelerated skillgain scroll."
		if (EnhancePack.AlacrityStart <= 0) then
			EnhancePack.AlacrityStart = 900
			CustomSettings.SaveNumber( "EnhancePackAlacrityStart", EnhancePack.AlacrityStart )
		end
	end
	
	local fame = TextParsing.Fame[senderText]
				 
	local karma = TextParsing.Karma[senderText]
	
	local loyalty = wstring.sub(GetStringFromTid(1115920), 1,wstring.find(GetStringFromTid(1115920), L"~1_GROUP~")-1)
	loyalty = WStringToString(loyalty)
	loyalty = string.find(senderText, loyalty) ~= nil
	
	local dungeon = wstring.sub(GetStringFromTid(1151634), wstring.find(GetStringFromTid(1151634), L"~1_AMT~") + 7,wstring.find(GetStringFromTid(1151634), L"~2_NAME~") - 1)
	dungeon = WStringToString(dungeon)
	dungeon = string.find(senderText, dungeon) ~= nil
	
	if ( (dungeon or loyalty or fame or karma) and SystemData.SourceName == L"") then 
		EnhancePack.CheckLoyalty = true
	end
	
	text = string.find(senderText , "This account is")
	text1 = string.find(senderText , "Can not determine this account's age")
	if ( (text or text1) and SystemData.SourceName == L"") then
		EnhancePack.ProfileUpdated = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid(1073480))  and SystemData.SourceName == L"") then -- "Your arcane focus disappears."
		EnhancePack.ArcaneFocusLevel = 0
	end
	
	if ( (senderText == WStringToString(GetStringFromTid(1044276)))) then --Target an item to repair.
		EnhancePack.RepairRequest = true
	end
	if ( (senderText == WStringToString(GetStringFromTid(1094794))) or (senderText == WStringToString(GetStringFromTid(1094730)))) then --Target the item to alter.
		EnhancePack.RepairRequest = true
	end
	if ( (senderText == WStringToString(GetStringFromTid(1044273)))) then --Target an item to recycle.
		EnhancePack.RepairRequest = true
	end
	
	if ( (senderText == WStringToString(GetStringFromTid(1062471)) or senderText == WStringToString(GetStringFromTid(1062472))) and SystemData.SourceName == L"" ) then -- "You quickly gather all of your belongings." or "You gather some of your belongings. The rest remain on the corpse."
		EnhancePack.BodyDecayTime = 0
		EnhancePack.DieClock = 0
		EnhancePack.StunTime = 0
		EnhancePack.BodyDecayTimeOver = false
		CustomSettings.SaveNumber( "EnhancePackBodyDieClock", EnhancePack.DieClock )
		CustomSettings.SaveNumber( "EnhancePackBodyDecayTime", EnhancePack.BodyDecayTime )
	end
	
	if ( senderText ==WStringToString(GetStringFromTid( 501864))  and SystemData.SourceName == L"" ) then -- "You can't dig while riding or flying."
		UserActionUseItem(WindowData.PlayerStatus.PlayerId ,false)
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 500971)) and SystemData.SourceName == L"" ) then -- "You can't fish while riding or flying!"
		EnhancePack.Dismount = true
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1010298)) and SystemData.SourceName == L"" and EnhancePack.TimeSinceLogin >= 5) then -- "Thy spirit hath been weakened!"
		EnhancePack.SkillLoss = true
		EnhancePack.SkillLossTimer = 1200
		CustomSettings.SaveNumber( "EnhancePackSkillLossTimer", EnhancePack.SkillLossTimer )
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1010299)) and SystemData.SourceName == L"" and EnhancePack.TimeSinceLogin >= 5) then -- "Thy spirit hath recovered!"
		EnhancePack.Resurrected = false
		EnhancePack.SkillLossTimer = 0
		EnhancePack.SkillLoss = false
		CustomSettings.SaveNumber( "EnhancePackSkillLossTimer", EnhancePack.SkillLossTimer )
		CustomSettings.SaveBoolean( "EnhancePackResurrected", EnhancePack.Resurrected  )
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1116364))   and not IsMobile(SystemData.TextSourceID) ) then -- "**bob**"
		RegisterWindowData(WindowData.ObjectInfo.Type, SystemData.TextSourceID)
		local item = WindowData.ObjectInfo[SystemData.TextSourceID]

		local texto = string.find(WStringToString(item.name) , "Lobster Trap")
	
		if ( texto ~= nil) then
			EnhancePack.CreateHealthBar(SystemData.TextSourceID, "Trap", UI.GetCliloc(SystemData.Settings.Language.type, 485))
			PlaySound(0, "bob.wav", 0)
		end
		UnregisterWindowData(WindowData.ObjectInfo.Type, SystemData.TextSourceID)
	end
	local text = string.find(senderText , WStringToString(GetStringFromTid(1063142))) -- You are not in a guild!
	if ( text ~= nil and SystemData.SourceName == L"" ) then
		EnhancePack.NotGuilded = true
		EnhancePack.GuildRequestUpdate = "done"
		EnhancePack.NotAlliance = true
	end
	
	local text = string.find(senderText , WStringToString(GetStringFromTid(1071020))) -- You are not in a alliance!
	if ( text ~= nil and SystemData.SourceName == L"" ) then
		EnhancePack.NotAlliance = true
		EnhancePack.NotGuilded = true
		EnhancePack.GuildRequestUpdate = "done"
	end

	local text = string.find(senderText , WStringToString(UI.GetCliloc(SystemData.Settings.Language.type, 1)))
	if ( text ~= nil and SystemData.SourceName == L"" ) then
		WindowData.CharProfile.Age = StringToWString(senderText)
	end

	if ( string.gsub(senderText, "I was killed by  ", "") == "!!" and SystemData.TextChannelID == 9) then
		senderText = "I killed myself !!"
		SystemData.Text = L"I killed myself !!"
	end
	

	text = string.find(string.lower(senderText) , "i wish to rename into ")

	if ( text ~= nil and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		text = string.find(senderText , "into ")
		
		local sub = string.sub(senderText , text + 5)
		EnhancePack.PetName = StringToWString(sub)
		RequestTargetInfo()
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "EnhancePack.RenamePet")
	end
	
	text = string.find(string.lower(senderText) , "i wish to make a screenshot")
	if ( text ~= nil and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		WindowSetTintColor("ScreenshotHelperIcon", 255,255,255)
		if ( senderText == "i wish to make a screenshot" ) then
			RequestTargetInfo()
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "EnhancePack.ScreenRequestTargetInfoReceived")
			DynamicImageSetTexture( "ScreenshotHelperBackground", "hud_image2", 9, 192 )
			DynamicImageSetTextureScale( "ScreenshotHelperBackground", 1000 )
			
		end
		
		if ( string.lower(senderText) == "i wish to make a screenshot - black" ) then
			RequestTargetInfo()
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "EnhancePack.ScreenRequestTargetInfoReceived")
			DynamicImageSetTexture( "ScreenshotHelperBackground", "hud_image", 195, 546 )
			DynamicImageSetTextureScale( "ScreenshotHelperBackground", 1000 )
		end
		
		text = string.find(string.lower(senderText) , " scale ")
		if ( text ~= nil ) then
			
			
			local scale = 1
			
			text = string.find(string.lower(senderText) , " black ")
			if ( text ~= nil ) then
				scale = tonumber(string.sub(senderText, string.len("i wish to make a screenshot - black scale ") ))
				DynamicImageSetTexture( "ScreenshotHelperBackground", "hud_image", 195, 546 )
			else
				scale = tonumber(string.sub(senderText, string.len("i wish to make a screenshot - scale ") ))
				DynamicImageSetTexture( "ScreenshotHelperBackground", "hud_image2", 9, 192 )
			end
			if ( scale < 1 ) then
				scale = 1
			end
			if ( scale > 9 ) then
				scale = 9
			end
		
			ScreenshotHelper.ScaleOverride = scale
			DynamicImageSetTextureScale( "ScreenshotHelperBackground", 1000 )
		
			RequestTargetInfo()

			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "EnhancePack.ScreenRequestTargetInfoReceived")
		end
	end
	
	if ( wstring.lower(SystemData.Text) == wstring.lower(wstring.gsub(GetStringFromTid(1043255), L"~1_NAME~", SystemData.SourceName ))) then -- "is better off without a master"
		MobilesOnScreen.ReversePet[SystemData.TextSourceID] = nil
		MobileHealthBar.CloseWindowByMobileId(SystemData.TextSourceID)
		PetWindow.UpdatePet()
	end
	
	if (string.find(senderText , "Thy current bank balance is:")) then
		local cut = WindowUtils.AddCommasToNumber(wstring.sub(SystemData.Text, 29))
		SystemData.Text = wstring.sub(SystemData.Text, 0,29) .. cut
	end
	

	if ( string.find(senderText , "Into your bank box I have placed a check in the amount of:")) then
		local cut = WindowUtils.AddCommasToNumber(wstring.sub(SystemData.Text,59))
		SystemData.Text = wstring.sub(SystemData.Text, 0,59) .. cut
	end
	
	if (string.lower(senderText) == "give arties" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		EnhancePack.ArteReceived = 1
		CustomSettings.SaveNumber( "EnhancePackArteReceived" , EnhancePack.ArteReceived )
	end
	
	if (string.lower(senderText) == "give resources" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		EnhancePack.ResReceived = 1
		CustomSettings.SaveNumber( "EnhancePackResReceived" , EnhancePack.ResReceived )
	end
	
	if (string.lower(senderText) == "give air" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		EnhancePack.AirReceived = 1
		CustomSettings.SaveNumber( "EnhancePackAirReceived" , EnhancePack.AirReceived )
	end
	
	if (string.lower(senderText) == "give seeds" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		EnhancePack.SeedsReceived = 1
		CustomSettings.SaveNumber( "EnhancePackSeedsReceived" , EnhancePack.SeedsReceived )
	end
	
	if (string.lower(senderText) == "give tokens" and SystemData.TextSourceID == WindowData.PlayerStatus.PlayerId) then
		EnhancePack.TokensReceived = 1
		CustomSettings.SaveNumber( "EnhancePackTokensReceived" , EnhancePack.TokensReceived )
	end
	
	if ( wstring.lower(SystemData.Text) == wstring.lower(GetStringFromTid(1044038 ))) then -- You have worn out your tool!
		CraftingTool.SendWarning(GetStringFromTid(1044038), 10)
	end
	
	
	if ( wstring.lower(SystemData.Text) == wstring.lower(GetStringFromTid(1152112 ))) then -- Target the item to reforge.
		EnhancePack.WaitReforge = true
	elseif EnhancePack.WaitReforge and not(WindowData.Cursor ~= nil and WindowData.Cursor.target == true) then
		EnhancePack.WaitReforge = nil
	end
	
	
end
function TextParsing.IgnoreTextManager()
	local ign = false
	if (not NewChatWindow.ShowSpellsCasting) then
		if (SystemData.Text == GetStringFromTid(502645)) then -- You are already casting a spell.
			ign = true
		end 
		if (SystemData.Text == GetStringFromTid(502644)) then -- You have not yet recovered from casting a spell.
			ign = true
		end
	end
	if (not NewChatWindow.ShowPerfection) then
		if (SystemData.Text == GetStringFromTid(1063255)) then -- You gain in Perfection as you precisely strike your opponent.
			ign = true
		end 
		if (SystemData.Text == GetStringFromTid(1063257)) then -- You have lost some Perfection in fighting this opponent.
			ign = true
		end
	end
	if (not NewChatWindow.ShowMultiple and EnhancePack.LastJournalMSG == SystemData.Text) then
		ign = true
	else
		EnhancePack.LastJournalMSG = SystemData.Text
	end
	if (not NewChatWindow.ShowSpells and IsSpell) then
		ign = true
	end
	return ign
end

function TextParsing.SharingCommands()
	local find = wstring.find
	if (find(SystemData.Text, L"Ally[-]cmd")) then
		if (not EnhancePack.GuildWaypoints) then
			return true
		end
		if (find(SystemData.Text, L"POS")) then
			
			local tilde = find(SystemData.Text, L"~")
			local nam = find(SystemData.Text, L"_Name")
			local und = find(SystemData.Text, L"_xyzMap")
			local mobileName = wstring.sub(SystemData.Text, nam + 6, und - 1)
			local mobileId = tonumber(tostring(wstring.sub(SystemData.Text, tilde + 1, nam - 1)))
			if (mobileId ~= WindowData.PlayerStatus.PlayerId) then
				local pos = wstring.sub(SystemData.Text, und+8)
				local y = tonumber(wstring.sub(pos, find(pos, L",")+1))
				local x = tonumber(wstring.sub(pos, 1, find(pos, L",")-1))
				pos = wstring.sub(pos, find(pos, L",")+1)
				pos = wstring.sub(pos, find(pos, L",")+1)
				local facet = tonumber(wstring.sub(pos, find(pos, L",")+1))
				local z = tonumber(wstring.sub(pos, 1, find(pos, L",")-1))
				if facet == -1 then
					EnhancePack.GuildMembers[mobileId] = nil
				else
					if not EnhancePack.GuildMembers[mobileId] then
						EnhancePack.GuildMembers[mobileId] = {}
					end
					EnhancePack.GuildMembers[mobileId].name = mobileName
					EnhancePack.GuildMembers[mobileId].x = x
					EnhancePack.GuildMembers[mobileId].y = y
					EnhancePack.GuildMembers[mobileId].z = z
					EnhancePack.GuildMembers[mobileId].facet = facet
					EnhancePack.GuildMembers[mobileId].nextCheck = EnhancePack.TimeSinceLogin + 35
				end
			end
			MapCommon.WaypointUpdateRequest = true
			return true
		end
		if (find(SystemData.Text, L"STATUS")) then
			
			if (find(SystemData.Text, L"UPDATE[-]REQUEST") ) then
				RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
				--Ally-cmd:STATUS~<ID>_Name:<name>_HP:<min>-<max>
				if ( SystemData.TextSourceID ~= WindowData.PlayerStatus.PlayerId) then
					if (EnhancePack.AllyShareHP) then
						local text = L"/alliance Ally-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
						SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
					end
					if (EnhancePack.AllySharePos) then
						RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
						--Ally-cmd:STATUS~<ID>_Name:<name>_HP:<min>-<max>

						local text = L"/alliance Ally-cmd:POS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_xyzMap:" .. WindowData.PlayerLocation.x .. L"," .. WindowData.PlayerLocation.y .. L"," .. WindowData.PlayerLocation.z .. L"," .. WindowData.PlayerLocation.facet
						SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
						EnhancePack.GuildSharePosDelta = EnhancePack.TimeSinceLogin + 2
						
						if (not EnhancePack.AllyShareHP) then
							local text = L"/alliance Ally-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. 0 .. L"-" .. 0
							SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
						end
					end
					StatusWindow.GuildNextUpdate = EnhancePack.TimeSinceLogin + 2
				end
				UnregisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
			else
				local tilde = find(SystemData.Text, L"~")
				local und = find(SystemData.Text, L"_Name")
				local mobileId = tonumber(tostring(wstring.sub(SystemData.Text, tilde + 1, und - 1)))
				if (mobileId ~= WindowData.PlayerStatus.PlayerId) then
					local und2 = find(SystemData.Text, L"_HP")
					local mobileName = wstring.sub(SystemData.Text, und + 6, und2 - 1)
					local hp = wstring.sub(SystemData.Text, und2 + 4)
					und = find(hp, L"-")
					
					if(not EnhancePack.GuildMembers[mobileId]) then
						EnhancePack.GuildMembers[mobileId] = {}
					end
					EnhancePack.GuildMembers[mobileId].name = mobileName

					EnhancePack.GuildMembers[mobileId].MaxHealth = tonumber(tostring(wstring.sub(hp, und +1)))
					EnhancePack.GuildMembers[mobileId].CurrentHealth = tonumber(tostring(wstring.sub(hp, 1, und-1)))
				end
			end
			MapCommon.WaypointUpdateRequest = true
			return true
		end
	end

	if (find(SystemData.Text, L"Guild[-]cmd")) then
		if (not EnhancePack.GuildWaypoints) then
			return true
		end
		if (find(SystemData.Text, L"POS")) then
			
			local tilde = find(SystemData.Text, L"~")
			local nam = find(SystemData.Text, L"_Name")
			local und = find(SystemData.Text, L"_xyzMap")
			local mobileName = wstring.sub(SystemData.Text, nam + 6, und - 1)
			local mobileId = tonumber(tostring(wstring.sub(SystemData.Text, tilde + 1, nam - 1)))
			if (mobileId ~= WindowData.PlayerStatus.PlayerId) then
				local pos = wstring.sub(SystemData.Text, und+8)
				local y = tonumber(wstring.sub(pos, find(pos, L",")+1))
				local x = tonumber(wstring.sub(pos, 1, find(pos, L",")-1))
				pos = wstring.sub(pos, find(pos, L",")+1)
				pos = wstring.sub(pos, find(pos, L",")+1)
				local facet = tonumber(wstring.sub(pos, find(pos, L",")+1))
				local z = tonumber(wstring.sub(pos, 1, find(pos, L",")-1))
				if facet == -1 then
					EnhancePack.GuildMembers[mobileId] = nil
				else
					if not EnhancePack.GuildMembers[mobileId] then
						EnhancePack.GuildMembers[mobileId] = {}
					end
					EnhancePack.GuildMembers[mobileId].name = mobileName
					EnhancePack.GuildMembers[mobileId].x = x
					EnhancePack.GuildMembers[mobileId].y = y
					EnhancePack.GuildMembers[mobileId].z = z
					EnhancePack.GuildMembers[mobileId].facet = facet
					EnhancePack.GuildMembers[mobileId].nextCheck = EnhancePack.TimeSinceLogin + 35
				end
			end
			MapCommon.WaypointUpdateRequest = true
			return true
		end
		if (find(SystemData.Text, L"STATUS")) then
			
			if (find(SystemData.Text, L"UPDATE[-]REQUEST") ) then
				RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
				--Guild-cmd:STATUS~<ID>_Name:<name>_HP:<min>-<max>
				if ( SystemData.TextSourceID ~= WindowData.PlayerStatus.PlayerId) then
					if (EnhancePack.GuildShareHP) then
						local text = L"/guild Guild-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
						SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
					end
					if (EnhancePack.GuildSharePos) then
						RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
						--Party-cmd:STATUS~<ID>_Name:<name>_HP:<min>-<max>

						local text = L"/guild Guild-cmd:POS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_xyzMap:" .. WindowData.PlayerLocation.x .. L"," .. WindowData.PlayerLocation.y .. L"," .. WindowData.PlayerLocation.z .. L"," .. WindowData.PlayerLocation.facet
						SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
						if (not EnhancePack.GuildShareHP) then
							local text = L"/guild Guild-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. 0 .. L"-" .. 0
							SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
						end
					end
					StatusWindow.GuildNextUpdate = EnhancePack.TimeSinceLogin + 2
				end
				UnregisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
			else
				local tilde = find(SystemData.Text, L"~")
				local und = find(SystemData.Text, L"_Name")
				local mobileId = tonumber(tostring(wstring.sub(SystemData.Text, tilde + 1, und - 1)))
				if (mobileId ~= WindowData.PlayerStatus.PlayerId) then
					local und2 = find(SystemData.Text, L"_HP")
					local mobileName = wstring.sub(SystemData.Text, und + 6, und2 - 1)
					local hp = wstring.sub(SystemData.Text, und2 + 4)
					und = find(hp, L"-")
					
					if(not EnhancePack.GuildMembers[mobileId]) then
						EnhancePack.GuildMembers[mobileId] = {}
					end
					EnhancePack.GuildMembers[mobileId].name = mobileName

					EnhancePack.GuildMembers[mobileId].MaxHealth = tonumber(tostring(wstring.sub(hp, und +1)))
					EnhancePack.GuildMembers[mobileId].CurrentHealth = tonumber(tostring(wstring.sub(hp, 1, und-1)))
				end
			end
			MapCommon.WaypointUpdateRequest = true
			return true
		end
	end

	if (find(SystemData.Text, L"Party[-]cmd")) then
		if (find(SystemData.Text, L"IGNORE")  and SystemData.TextSourceID ~= WindowData.PlayerStatus.PlayerId) then
			local tilde = find(SystemData.Text, L"~")
			local id = wstring.sub(SystemData.Text, tilde + 1)
			EnhancePack.ignoreIt(id)
			return true
		end
		
		if (find(SystemData.Text, L"STATUS")) then
			if (find(SystemData.Text, L"UPDATE[-]REQUEST")) then
				if (EnhancePack.PartyShareHP and SystemData.TextSourceID ~= WindowData.PlayerStatus.PlayerId) then
					RegisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
					--Party-cmd:STATUS~<ID>_Name:<name>_HP:<min>-<max>
					local text = L"/party Party-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
					SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
					StatusWindow.NextUpdate = EnhancePack.TimeSinceLogin + 2
					UnregisterWindowData(WindowData.MobileName.Type, WindowData.PlayerStatus.PlayerId)
				end
			else
				local tilde = find(SystemData.Text, L"~")
				local und = find(SystemData.Text, L"_Name")
				local mobileId = tonumber(tostring(wstring.sub(SystemData.Text, tilde + 1, und - 1)))
				if (mobileId ~= WindowData.PlayerStatus.PlayerId) then
					local und2 = find(SystemData.Text, L"_HP")
					local mobileName = wstring.sub(SystemData.Text, und + 6, und2 - 1)
					local hp = wstring.sub(SystemData.Text, und2 + 4)
					und = find(hp, L"-")
					
					if(not PartyHealthBar.PartyMembers[mobileId]) then
						PartyHealthBar.PartyMembers[mobileId] = {}
					end
					PartyHealthBar.PartyMembers[mobileId].name = mobileName
					PartyHealthBar.PartyMembers[mobileId].sharing = true
					PartyHealthBar.PartyMembers[mobileId].MaxHealth = tonumber(tostring(wstring.sub(hp, und +1)))
					PartyHealthBar.PartyMembers[mobileId].CurrentHealth = tonumber(tostring(wstring.sub(hp, 1, und-1)))
					
					if (PartyHealthBar.PartyMembers[mobileId].MaxHealth == 0) then
						PartyHealthBar.PartyMembers[mobileId].sharing = false
					end
					
					local memberIndex = HealthBarManager.GetMemberIndex(mobileId)
					local windowName = "PartyHealthBar_"..memberIndex
					LabelSetText(windowName.."Name", PartyHealthBar.PartyMembers[mobileId].name )
				end
			end
			MapCommon.WaypointUpdateRequest = true
			return true
		end
	end
	return false
end

function TextParsing.ForceOverhead()
	local senderText = WStringToString(SystemData.Text)
	
	local clean =  wstring.gsub(GetStringFromTid(1062001),L"~1_WEAPON~", L"")
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "You can no longer wield your ~1_WEAPON~"
		EnhancePack.SendOverheadText(StringToWString(senderText), 33, false)
	end
	clean =  wstring.gsub(GetStringFromTid(1062002),L"~1_ARMOR~", L"")
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "You can no longer wear your ~1_ARMOR~"
		EnhancePack.SendOverheadText(StringToWString(senderText), 33, false)
	end
	clean =  wstring.gsub(GetStringFromTid(1062003),L"~1_SHIELD~", L"")
	if ( string.find(senderText,WStringToString(clean)) and SystemData.SourceName == L"") then -- "You can no longer equip your ~1_SHIELD~"
		EnhancePack.SendOverheadText(StringToWString(senderText), 33, false)
	end
	
	local text = string.find(senderText , UI.GetCliloc(SystemData.Settings.Language.type, 477))
	if ( text ~= nil and SystemData.SourceName == L""  ) then
		local num = tonumber(string.sub(senderText, 34, -11))
		EnhancePack.SendOverheadText(wstring.gsub(UI.GetCliloc(SystemData.Settings.Language.type, 478), L"!NUM!", num), 1270, true)
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1151481)) and SystemData.SourceName == L"" ) then -- "Channeling the corrupted mana has damaged you!"
		EnhancePack.SendOverheadText(GetStringFromTid( 1151481), 33, true)
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1116778)) and SystemData.SourceName == L"" ) then -- "The tainted life force energy damages you as your body tries to absorb it."
		EnhancePack.SendOverheadText(GetStringFromTid( 1116778), 33, true)
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 503170)) and SystemData.SourceName == L"" ) then -- "Uh oh! That doesn't look like a fish!" 
		EnhancePack.SendOverheadText(GetStringFromTid( 503170), 33, true)
		PlaySound(0, "uhoh.wav", 0)
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1153493)) and SystemData.SourceName == L"" ) then -- "Your keen senses detect something hidden in the area..."
		local prefix = "m_"
		if (EnhancePack.Female) then
			prefix = "f_"
		end
		PlaySound(0, prefix .. "huh.wav", 0)
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 500969)) and SystemData.SourceName == L"" ) then --  : You finish applying the bandages.
		PlaySound(0,  "medikit.wav", 0)
	end
	
	text = string.find(senderText , UI.GetCliloc(SystemData.Settings.Language.type, 480))
	if ( text ~= nil and SystemData.SourceName == L""  ) then
		EnhancePack.SendOverheadText(StringToWString(senderText), 33, true)
	end
end

function TextParsing.Taunts()

	if (CustomSounds) then
        for text, sound in pairs(CustomSounds.Sounds) do
            local txt = wstring.find(wstring.lower(SystemData.Text) , wstring.lower(text))
            if ( txt) then
                PlaySound(0, sound, 0)
                break
            end
        end
    end
    
    if ( senderText == WStringToString(GetStringFromTid( 1074776)) and SystemData.SourceName == L"" ) then -- "You are no longer protected with Gift of Life."
		PlaySound(0, "gol_off.wav", 0)
	end
	
	if ( senderText == WStringToString(GetStringFromTid( 1060093)) and SystemData.SourceName == L"" ) then -- "Your weapon has been disarmed!"
		PlaySound(0, "disarm.wav", 0)
	end
	
    -- EMOTES
	local wfind = wstring.find
	if ( SystemData.SourceName ~= L"" ) then
		local prefix = "m_"
		if (EnhancePack.Female) then
			prefix = "f_"
		end
		 
		if ( SystemData.Text == GetStringFromTid(502543) ) then -- aye aye sir
			PlaySound(0,"aye aye sir.mp3", 0)
		end
		
		if ( SystemData.Text == GetStringFromTid(502519) or SystemData.Text == GetStringFromTid(502537) ) then -- yes sir
			PlaySound(0,"yes sir.mp3", 0)
		end
		
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 558)) -- *yell*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "yell.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 534)) -- *yawn*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "yawn.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 552)) -- *yeah*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "yea.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 553)) -- *whistle*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "whistle.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 554)) -- *spit*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "spit.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 555)) -- *snore*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "snore.wav", 0)
		else
			text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 542)) -- *no*
			if ( text ~= nil ) then
				PlaySound(0,prefix .. "no.wav", 0)
			end
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 556)) -- *sniff*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "sniff.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 557)) -- *sneeze*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "sneeze.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 535)) -- *sigh*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "sigh.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 536)) -- shh
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "shush.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 537)) -- *scream*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "scream.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 538)) -- *puke*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "puke.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 539)) -- *oops*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "oops.wav", 0)
		else
			text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 540)) -- *oooh*
			if ( text ~= nil ) then
				PlaySound(0,prefix .. "oooh.wav", 0)
			else
				text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 541)) -- *oh*
				if ( text ~= nil ) then
					PlaySound(0,prefix .. "oh.wav", 0)
				end
			end
		end
		
		
		
		
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 543)) -- *laugh*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "laugh.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 544)) -- *kiss*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "kiss.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 545)) -- *huh*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "huh.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 546)) -- *hic*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "hiccup.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 547)) -- *hey*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "hey.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 548)) -- *growl*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "growl.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 549)) -- *groan*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "groan.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 550)) -- *giggle*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "giggle.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 551)) -- *gasp*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "gasp.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 559)) -- *fart*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "fart.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 560)) -- *cry*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "cry.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 561)) -- *cough laugh*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "coughbs.wav", 0)
		else
			text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 562)) -- *cough*
			if ( text ~= nil ) then
				PlaySound(0,prefix .. "cough.wav", 0)
			end
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 563)) -- *clear throat*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "clear_throat.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 564)) -- *cheer*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "cheer.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 565)) -- *burp*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "burp.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 566)) -- *blownose*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "blownose.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 567)) -- *applaud*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "applaud.wav", 0)
		end
		
		text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 568)) -- *ahha*
		if ( text ~= nil ) then
			PlaySound(0,prefix .. "ahha.wav", 0)
		else
			text = wfind(wstring.lower(SystemData.Text) , UI.GetCliloc(SystemData.Settings.Language.type, 569)) -- *ah*
			if ( text ~= nil ) then
				PlaySound(0,prefix .. "ah.wav", 0)
			end
		end
		
	end
end