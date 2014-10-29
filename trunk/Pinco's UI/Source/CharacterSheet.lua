
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CharacterSheet = {}
CharacterSheet.lastStr = 0 
CharacterSheet.lastDex = 0
CharacterSheet.lastInt = 0
CharacterSheet.StatsSize = 91
CharacterSheet.Stats = { "Health",
                         "Stamina",
                         "Mana",
                         "Strength",
                         "Dexterity",
                         "Intelligence",
                         "StatCap",
                         "Luck",
                         "Weight",
                         "Gold",
                         "Followers",
                         "PhysicalResist",
                         "FireResist",
                         "ColdResist",
                         "PoisonResist",
                         "EnergyResist",
                         "Damage",
                         "HitChanceIncrease",
                         "SwingSpeedIncrease",
                         "DamageChanceIncrease",
                         "LowerReagentCost",
                         "HitPointRegen",
                         "StamRegen",
                         "ManaRegen",
                         "ReflectPhysicalDamage",
                         "EnhancePotions",
                         "DefenseChanceIncrease",
                         "SpellDamageIncrease",
                         "FasterCastRecovery",
                         "FasterCasting",
                         "LowerManaCost",
                         "CastingFocus",
                         "SoulCharge",
                         "DamageEater",
                         "KineticEater",
                         "FireEater",
                         "ColdEater",
                         "PoisonEater",
                         "EnergyEater",
                         "KineticResonance",
                         "FireResonance",
                         "ColdResonance",
                         "PoisonResonance",
                         "EnergyResonance",
                         "GargoyleQueen",
                         "Ophidian",
                         "BaneChosen",
                         "Meer",
                         "Juka",
                         "Shame",
                         "Despise",
                         "Void",
                         "Britain",
						 "Jhelom",
						 "Minoc",
						 "Moonglow",
						 "NewMagincia",
						 "SkaraBrae",
						 "Trinsic",
						 "Vesper",
					 	 "Yew",
					 	 "Citizenship",
					 	 "Medable",
					 	 "HitLowerAttack",
					 	 "HitLowerDefense",
					 	 "SplinteringWeapon",
					 	 "SpellChannelingW",
					 	 "SpellChannelingS",
					 	 "Balanced",
					 	 "BloodDrinker",
					 	 "BattleLust",
					 	 "ReactiveParalyze",
					 	 "NightSight",
					 	 "HitPhysicalArea",
					 	 "HitFireArea",
					 	 "HitColdArea",
					 	 "HitPoisonArea",
					 	 "HitEnergyArea",
					 	 "HitFireball",
					 	 "HitMagicArrow",
					 	 "HitLightning",
					 	 "HitHarm",
					 	 "HitDispel",
					 	 "HitCurse",
					 	 "Velocity",
					 	 "HitLifeLeech",
					 	 "HitManaLeech",
					 	 "HitStaminaLeech",
					 	 "HitLifeDrain",
					 	 "HitManaDrain",
					 	 "HitFatigue",
                         }
CharacterSheet.Caps = { 
						["IncreaseHitPoints"] = 25,
                        
                        ["Strength"] = 150,
                        ["Dexterity"] = 150,
                        ["Intelligence"] = 150,
                        ["StatCap"] = 255,
                        ["PhysicalResist"] = 70,
                        ["FireResist"] = 70,
                        ["ColdResist"] = 70,
                        ["PoisonResist"] = 70,
                        ["EnergyResist"] = 70,
                        ["DamageChanceIncrease"] = 100,
                        ["HitChanceIncrease"] = 45,
                        ["SwingSpeedIncrease"] = 60,
                        ["LowerReagentCost"] = 100,
                        ["HitPointRegen"] = 18,
						["ManaRegen"] = 30,
                        ["ReflectPhysicalDamage"] = 105,
                        ["EnhancePotions"] = 50,
                        ["DefenseChanceIncrease"] = 45,
                        ["FasterCastRecovery"] = 6,
                        ["FasterCasting"] = 4,
                        ["LowerManaCost"] = 40,
                        ["CastingFocus"] = 12,
                        ["DamageEater"] = 18,
                        ["KineticEater"] = 30,
                        ["FireEater"] = 30,
                        ["ColdEater"] = 30,
                        ["PoisonEater"] = 30,
                        ["EnergyEater"] = 30,}
CharacterSheet.CapsBonus = { 
                        ["Strength"] = 0,
                        ["Dexterity"] = 0,
                        ["Intelligence"] = 0,
                        ["StatCap"] = 0,
                        ["PhysicalResist"] = 0,
                        ["FireResist"] = 0,
                        ["ColdResist"] = 0,
                        ["PoisonResist"] = 0,
                        ["EnergyResist"] = 0,
                        ["DamageChanceIncrease"] = 0,
                        ["HitChanceIncrease"] = 0,
                        ["SwingSpeedIncrease"] = 0,
                        ["LowerReagentCost"] = 0,
                        ["HitPointRegen"] = 0,
						["ManaRegen"] = 0,
                        ["ReflectPhysicalDamage"] = 0,
                        ["EnhancePotions"] = 0,
                        ["DefenseChanceIncrease"] = 0,
                        ["FasterCastRecovery"] = 0,
                        ["FasterCasting"] = 0,
                        ["LowerManaCost"] = 0,
                        ["CastingFocus"] = 0,
                        ["DamageEater"] = 0,
                        ["KineticEater"] = 0,
                        ["FireEater"] = 0,
                        ["ColdEater"] = 0,
                        ["PoisonEater"] = 0,
                        ["EnergyEater"] = 0,}
                         -- The last 9 of these are treated special, and have been hardcoded into a function below
                         -- The TID numbers for these aren't used.
                         -- These are supposed to be commnted out.
--    					IncreaseStr = 1079401,
--						IncreaseDex = 1079402,
--						IncreaseInt = 1079403,
--						IncreaseHitPoints = 1079404,
--						IncreaseStam = 1079405,
--						IncreaseMana = 1079406,
--						IncreaseHitPointsMax = 1079407,
--						IncreaseStamMax = 1079408,
--						IncreaseManaMax = 1079409 }

function CharacterSheet.InitGroups()
	CharacterSheet.Groups = {}
	CharacterSheet.Groups[1] = { h=690, index={1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14} } -- Standard
	CharacterSheet.Groups[2] = { h=690, nameString=L"Resistances",	nameTid=1061645, index={15, 16, 17, 18, 19} }		-- Resists
	CharacterSheet.Groups[3] = { h=890, nameString=L"Attack",		nameTid=1011533, index={20, 21, 22, 23, 1029, 1030, 1031, 1050, 1032, 1034, 1035, 1036} }			-- Attacks
	CharacterSheet.Groups[4] = { h=780, nameString=L"Defense",		nameTid=1017320, index={25, 26, 27, 28, 30, 1001, 1033, 1037} }		-- Defensive
	CharacterSheet.Groups[5] = { h=810, nameString=L"Magic",		nameTid=1078593, index={24, 29, 31, 32, 33, 34, 1000, 1028, 1038} }	-- Spells
CharacterSheet.Groups[6] = { h=870, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 940), index={1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049} }
CharacterSheet.Groups[7] = { h=720, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 941), index={1051,1052,1053,1054,1055,1056} }
	CharacterSheet.Groups[8] = { h=720, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 791), index={1002, 1003, 1004, 1005, 1006, 1007} }
	CharacterSheet.Groups[9] = { h=690, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 792), index={1008,1009, 1010, 1011, 1012} }
	CharacterSheet.Groups[10] = { h=690, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 850), index={1013, 1014, 1015, 1016, 1017} }
	CharacterSheet.Groups[11] = { h=840, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 862), index={1019,1020,1021,1022,1023,1024,1025,1026,1027, 1058} }
	CharacterSheet.Groups[12] = { h=630, nameString=GetStringFromTid(1151673), index={1018, 1059, 1057} }

	CharacterSheet.CurrentGroup = 2
end

CharacterSheet.TID = {CharacterSheet = 1077437}                            
-- objectId		name	iconId		hasdivider		tid		warningiconid		detailtid
CharacterSheet.Separators = { Health = " / ",
                                 Stamina = " / ",
                                 Mana = " / ",
                                 Weight = " / ",
                                 Damage = "-",
                                 Followers = " / ",
                                 PhysicalResist = " / ",
								 FireResist = " / ",
								 ColdResist = " / ",
								 PoisonResist = " / ",
								 EnergyResist = " / ",
								 DefenseChanceIncrease = " / "}

CharacterSheet.Attributes = { Strength = 0, Dexterity = 1, Intelligence = 2 }

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function CharacterSheet.RegisterExtraMods()
	WindowData.PlayerStatsDataCSV[1000] = {name=L"CastingFocus", iconId=870106, hasDivider = false, tid=1116535, detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 790)}
	WindowData.PlayerStatus["CastingFocus"] = 0
	WindowData.PlayerStatsDataCSV[1001] = {name=L"SoulCharge", iconId=870107, hasDivider = false, tid=1116536, detailTid=1113636}
	WindowData.PlayerStatus["SoulCharge"] = 0
	
	WindowData.PlayerStatsDataCSV[1002] = {name=L"DamageEater", iconId=870108, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113598), L" ~1_Val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 793)}
	WindowData.PlayerStatus["DamageEater"] = 0
	WindowData.PlayerStatsDataCSV[1003] = {name=L"KineticEater", iconId=870109, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113597), L" ~1_Val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 794)}
	WindowData.PlayerStatus["KineticEater"] = 0
	WindowData.PlayerStatsDataCSV[1004] = {name=L"FireEater", iconId=870110, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113593), L" ~1_Val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 795)}
	WindowData.PlayerStatus["FireEater"] = 0
	WindowData.PlayerStatsDataCSV[1005] = {name=L"ColdEater", iconId=870111, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113594), L" ~1_Val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 796)}
	WindowData.PlayerStatus["ColdEater"] = 0
	WindowData.PlayerStatsDataCSV[1006] = {name=L"PoisonEater", iconId=870112, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113595), L" ~1_Val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 797)}
	WindowData.PlayerStatus["PoisonEater"] = 0
	WindowData.PlayerStatsDataCSV[1007] = {name=L"EnergyEater", iconId=870113, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113596), L" ~1_Val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 798)}
	WindowData.PlayerStatus["EnergyEater"] = 0
	
	WindowData.PlayerStatsDataCSV[1008] = {name=L"KineticResonance", iconId=870114, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113695), L" ~1_val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 800)}
	WindowData.PlayerStatus["KineticResonance"] = 0
	WindowData.PlayerStatsDataCSV[1009] = {name=L"FireResonance", iconId=870115, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113691), L" ~1_val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 801)}
	WindowData.PlayerStatus["FireResonance"] = 0
	WindowData.PlayerStatsDataCSV[1010] = {name=L"ColdResonance", iconId=870116, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113692), L" ~1_val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 802)}
	WindowData.PlayerStatus["ColdResonance"] = 0
	WindowData.PlayerStatsDataCSV[1011] = {name=L"PoisonResonance", iconId=870117, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113693), L" ~1_val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 803)}
	WindowData.PlayerStatus["PoisonResonance"] = 0
	WindowData.PlayerStatsDataCSV[1012] = {name=L"EnergyResonance", iconId=870118, hasDivider = false, nameWString = wstring.gsub(GetStringFromTid(1113694), L" ~1_val~%%", L""), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 804)}
	WindowData.PlayerStatus["EnergyResonance"] = 0
	
	WindowData.PlayerStatsDataCSV[1013] = {name=L"GargoyleQueen", hasDivider = false, nameWString = GetStringFromTid(1095163), detailWString=L"GET"}
	WindowData.PlayerStatus["GargoyleQueen"] = 0
	WindowData.PlayerStatsDataCSV[1014] = {name=L"Ophidian", hasDivider = false, nameWString = GetStringFromTid(1115733), detailWString=L"GET"}
	WindowData.PlayerStatus["Ophidian"] = 0
	WindowData.PlayerStatsDataCSV[1015] = {name=L"BaneChosen", hasDivider = false, nameWString = GetStringFromTid(1115734), detailWString=L"GET"}
	WindowData.PlayerStatus["BaneChosen"] = 0
	WindowData.PlayerStatsDataCSV[1016] = {name=L"Meer", hasDivider = false, nameWString = GetStringFromTid(1116245), detailWString=L"GET"}
	WindowData.PlayerStatus["Meer"] = 0
	WindowData.PlayerStatsDataCSV[1017] = {name=L"Juka", hasDivider = false, nameWString = GetStringFromTid(1079796), detailWString=L"GET"}
	WindowData.PlayerStatus["Juka"] = 0
	
	local shame = wstring.gsub(GetStringFromTid(1151672), L"~1_AMT~", L"")
	WindowData.PlayerStatsDataCSV[1018] = {name=L"Shame", hasDivider = false, nameWString = wstring.gsub(shame, L":", L"")}
	WindowData.PlayerStatus["Shame"] = 0
	
	WindowData.PlayerStatsDataCSV[1019] = {name=L"Britain", hasDivider = false, nameWString = GetStringFromTid(1011028) }
	WindowData.PlayerStatus["Britain"] = "Unknown"
	WindowData.PlayerStatsDataCSV[1020] = {name=L"Jhelom", hasDivider = false, nameWString = GetStringFromTid(1011343) }
	WindowData.PlayerStatus["Jhelom"] = "Unknown"
	WindowData.PlayerStatsDataCSV[1021] = {name=L"Minoc", hasDivider = false, nameWString = GetStringFromTid(1011031) }
	WindowData.PlayerStatus["Minoc"] = "Unknown"
	WindowData.PlayerStatsDataCSV[1022] = {name=L"Moonglow", hasDivider = false, nameWString = GetStringFromTid(1011344) }
	WindowData.PlayerStatus["Moonglow"] = "Unknown"
	WindowData.PlayerStatsDataCSV[1023] = {name=L"NewMagincia", hasDivider = false, nameWString = GetStringFromTid(1011345) }
	WindowData.PlayerStatus["NewMagincia"] = "Unknown"
	WindowData.PlayerStatsDataCSV[1024] = {name=L"SkaraBrae", hasDivider = false, nameWString = GetStringFromTid(1011347) }
	WindowData.PlayerStatus["SkaraBrae"] = "Unknown"
	WindowData.PlayerStatsDataCSV[1025] = {name=L"Trinsic", hasDivider = false, nameWString = GetStringFromTid(1012008) }
	WindowData.PlayerStatus["Trinsic"] = "Unknown"
	WindowData.PlayerStatsDataCSV[1026] = {name=L"Vesper", hasDivider = false, nameWString = GetStringFromTid(1011030) }
	WindowData.PlayerStatus["Vesper"] = "Unknown"
	WindowData.PlayerStatsDataCSV[1027] = {name=L"Yew", hasDivider = false, nameWString = GetStringFromTid(1011032) }
	WindowData.PlayerStatus["Yew"] = "Unknown"


	WindowData.PlayerStatsDataCSV[1028] = {name=L"Medable", iconId=870156, hasDivider = false, nameWString = UI.GetCliloc(SystemData.Settings.Language.type, 925), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 928)}
	WindowData.PlayerStatus["Medable"] = UI.GetCliloc(SystemData.Settings.Language.type, 926)
	
	WindowData.PlayerStatsDataCSV[1029] = {name=L"HitLowerAttack", iconId=870146, hasDivider = false, tid=1079699, detailTid=1111965}
	WindowData.PlayerStatus["HitLowerAttack"] = 0
	
	WindowData.PlayerStatsDataCSV[1030] = {name=L"HitLowerDefense", iconId=870147, hasDivider = false, tid=1079700, detailTid=1111966}
	WindowData.PlayerStatus["HitLowerDefense"] = 0
	
	WindowData.PlayerStatsDataCSV[1031] = {name=L"SplinteringWeapon", iconId=870148, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 929), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 930)}
	WindowData.PlayerStatus["SplinteringWeapon"] = 0
	
	WindowData.PlayerStatsDataCSV[1032] = {name=L"SpellChannelingW", iconId=870153, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 931), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 933)}
	WindowData.PlayerStatus["SpellChannelingW"] = 0
	
	WindowData.PlayerStatsDataCSV[1033] = {name=L"SpellChannelingS", iconId=870154, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 932), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 933)}
	WindowData.PlayerStatus["SpellChannelingS"] = 0
	
	WindowData.PlayerStatsDataCSV[1034] = {name=L"Balanced", iconId=870152, hasDivider = false, tid=1072792, detailTid=1112047}
	WindowData.PlayerStatus["Balanced"] = UI.GetCliloc(SystemData.Settings.Language.type, 927)
	
	WindowData.PlayerStatsDataCSV[1035] = {name=L"BloodDrinker", iconId=870150, hasDivider = false, tid=1113591, detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 934)}
	WindowData.PlayerStatus["BloodDrinker"] = UI.GetCliloc(SystemData.Settings.Language.type, 927)
	
	WindowData.PlayerStatsDataCSV[1036] = {name=L"BattleLust", iconId=870151, hasDivider = false, tid=1113710, detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 935)}
	WindowData.PlayerStatus["BattleLust"] = UI.GetCliloc(SystemData.Settings.Language.type, 927)
	
	WindowData.PlayerStatsDataCSV[1037] = {name=L"ReactiveParalyze", iconId=870155, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 937), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 936)}
	WindowData.PlayerStatus["ReactiveParalyze"] = UI.GetCliloc(SystemData.Settings.Language.type, 927)
	
	WindowData.PlayerStatsDataCSV[1038] = {name=L"NightSight", iconId=870157, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 938), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 939)}
	WindowData.PlayerStatus["NightSight"] = UI.GetCliloc(SystemData.Settings.Language.type, 927)
	
	
	WindowData.PlayerStatsDataCSV[1039] = {name=L"HitPhysicalArea", iconId=870158, hasDivider = false, tid=1079696, detailTid=1111956}
	WindowData.PlayerStatus["HitPhysicalArea"] = 0
	
	WindowData.PlayerStatsDataCSV[1040] = {name=L"HitFireArea", iconId=870159, hasDivider = false, tid=1079695, detailTid=1111955}
	WindowData.PlayerStatus["HitFireArea"] = 0
	
	WindowData.PlayerStatsDataCSV[1041] = {name=L"HitColdArea", iconId=870160, hasDivider = false, tid=1079693, detailTid=1111953}
	WindowData.PlayerStatus["HitColdArea"] = 0
	
	WindowData.PlayerStatsDataCSV[1042] = {name=L"HitPoisonArea", iconId=870161, hasDivider = false, tid=1079697, detailTid=1111957}
	WindowData.PlayerStatus["HitPoisonArea"] = 0
	
	WindowData.PlayerStatsDataCSV[1043] = {name=L"HitEnergyArea", iconId=870162, hasDivider = false, tid=1079694, detailTid=1111954}
	WindowData.PlayerStatus["HitEnergyArea"] = 0
	
	WindowData.PlayerStatsDataCSV[1044] = {name=L"HitFireball", iconId=870163, hasDivider = false, tid=1079703, detailTid=1111960}
	WindowData.PlayerStatus["HitFireball"] = 0
	
	WindowData.PlayerStatsDataCSV[1045] = {name=L"HitMagicArrow", iconId=870165, hasDivider = false, tid=1079706, detailTid=1111963}
	WindowData.PlayerStatus["HitMagicArrow"] = 0
	
	WindowData.PlayerStatsDataCSV[1046] = {name=L"HitLightning", iconId=870164, hasDivider = false, tid=1079705, detailTid=1111962}
	WindowData.PlayerStatus["HitLightning"] = 0
	
	WindowData.PlayerStatsDataCSV[1047] = {name=L"HitHarm", iconId=870166, hasDivider = false, tid=1079704, detailTid=1111961}
	WindowData.PlayerStatus["HitHarm"] = 0
	
	WindowData.PlayerStatsDataCSV[1048] = {name=L"HitDispel", iconId=870167, hasDivider = false, tid=1079702, detailTid=1111959}
	WindowData.PlayerStatus["HitDispel"] = 0
	
	WindowData.PlayerStatsDataCSV[1049] = {name=L"HitCurse", iconId=870168, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 942), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 943)}
	WindowData.PlayerStatus["HitCurse"] = 0
	
	WindowData.PlayerStatsDataCSV[1050] = {name=L"Velocity", iconId=870149, hasDivider = false, tid=1080416, detailTid=1112048}
	WindowData.PlayerStatus["Velocity"] = 0
	
	WindowData.PlayerStatsDataCSV[1051] = {name=L"HitLifeLeech", iconId=870169, hasDivider = false, tid=1079698, detailTid=1111964}
	WindowData.PlayerStatus["HitLifeLeech"] = 0
	
	WindowData.PlayerStatsDataCSV[1052] = {name=L"HitManaLeech", iconId=870170, hasDivider = false, tid=1079701, detailTid=1111967}
	WindowData.PlayerStatus["HitManaLeech"] = 0
	
	WindowData.PlayerStatsDataCSV[1053] = {name=L"HitStaminaLeech", iconId=870171, hasDivider = false, tid=1079707, detailTid=1111992}
	WindowData.PlayerStatus["HitStaminaLeech"] = 0
	
	WindowData.PlayerStatsDataCSV[1054] = {name=L"HitLifeDrain", iconId=870172, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 692), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 944)}
	WindowData.PlayerStatus["HitLifeDrain"] = 0
	
	WindowData.PlayerStatsDataCSV[1055] = {name=L"HitManaDrain", iconId=870173, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 945), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 946)}
	WindowData.PlayerStatus["HitManaDrain"] = 0
	
	WindowData.PlayerStatsDataCSV[1056] = {name=L"HitFatigue", iconId=870174, hasDivider = false, nameWString=UI.GetCliloc(SystemData.Settings.Language.type, 947), detailWString=UI.GetCliloc(SystemData.Settings.Language.type, 948)}
	WindowData.PlayerStatus["HitFatigue"] = 0
	
	WindowData.PlayerStatsDataCSV[1057] = {name=L"Void", hasDivider = false, nameWString = UI.GetCliloc(SystemData.Settings.Language.type, 5018)}
	WindowData.PlayerStatus["Void"] = 0
	
	WindowData.PlayerStatsDataCSV[1058] = {name=L"Citizenship", hasDivider = false, nameWString = UI.GetCliloc(SystemData.Settings.Language.type, 5019) }
	WindowData.PlayerStatus["Citizenship"] = "No City"
	
	local despise = wstring.gsub(GetStringFromTid(1153429), L"~1_AMT~", L"")
	WindowData.PlayerStatsDataCSV[1059] = {name=L"Despise", hasDivider = false, nameWString = wstring.gsub(despise, L":", L"")}
	WindowData.PlayerStatus["Despise"] = 0
end


function CharacterSheet.Initialize()
	CharacterSheet.InitGroups()
	CharacterSheet.RegisterExtraMods()
	RegisterWindowData(WindowData.PlayerStatus.Type, 0)
	WindowRegisterEventHandler( "CharacterSheet", WindowData.PlayerStatus.Event, "CharacterSheet.UpdateStatus")
	
	WindowUtils.SetWindowTitle("CharacterSheet", GetStringFromTid(CharacterSheet.TID.CharacterSheet) )	
	WindowSetDimensions( "CharacterSheet" , 400, 830)
	
	-- Make all label/value components
	local prev = ""
	local xoffset = 0
	local yoffset = 5
	local groupItr, group, itemItr, index, stat, i
	for groupItr, group in pairs(CharacterSheet.Groups) do
		for itemItr, i in pairs(group.index) do	
			stat = WStringToString(WindowData.PlayerStatsDataCSV[i].name)

			if stat == "HR" then
				ruleName = prev.."Rule"
				CreateWindowFromTemplate(ruleName, "CharacterSheetHRDef", prev)
				WindowAddAnchor(ruleName, "bottomleft", prev, "topleft", 2, 2)
				
				xoffset = -2
				yoffset = 2
				prev = ruleName
				continue
			end

			local entry = "CharacterSheet"..stat
			CreateWindowFromTemplate(entry, "AttributeTemplate", "CharacterSheet")
			if groupItr == 11 then
				WindowSetDimensions(entry .. "AttributeValue", 140, 20)
			end
			--Set windowId for the each id
			WindowSetId(entry, i)
			
			local iconId = WindowData.PlayerStatsDataCSV[i].iconId
			if (iconId) then
				CharacterSheet.SetMiniIconStats(entry, iconId)
			end
			
			if prev == "" then
				if (groupItr == 1) then
					WindowAddAnchor(entry, "topleft", "CharacterSheet", "topleft", 20, 50)
				else
					WindowAddAnchor(entry, "topleft", "CharacterSheet", "topleft", 10, 50)
				end
			else
				WindowAddAnchor(entry, "bottomleft", prev, "topleft", xoffset, yoffset)
				xoffset = 0
				yoffset = 5
			end

			local labelName = entry.."AttributeName"
			if stat == "Damage" then
				LabelSetText(labelName, UI.GetCliloc(SystemData.Settings.Language.type, 5045))
			elseif (WindowData.PlayerStatsDataCSV[i].nameWString) then
				LabelSetText(labelName, WindowData.PlayerStatsDataCSV[i].nameWString)
			else
				local tid = WindowData.PlayerStatsDataCSV[i].tid
				LabelSetText(labelName, GetStringFromTid(tid))
			end
			
			local lockName = entry.."LockButton"
			WindowSetId(lockName, i)

			prev = entry
			if (i == 12) then
				entry = "CharacterSheetBankGold"
				CreateWindowFromTemplate(entry, "AttributeTemplate", "CharacterSheet")				
				
				if prev == "" then
					WindowAddAnchor(entry, "topleft", "CharacterSheet", "topleft", 20, 50)
				else
					WindowAddAnchor(entry, "bottomleft", prev, "topleft", xoffset, yoffset)
					xoffset = 0
					yoffset = 5
				end
				WindowSetId("CharacterSheetBankGold", 99998)

				local labelName = entry.."AttributeName"
				
				LabelSetText(labelName, L"Bank Gold")
				CharacterSheet.SetMiniIconStats(entry, WindowData.PlayerStatsDataCSV[12].iconId)
				

				prev = entry
				
				entry = "CharacterSheetTithe"
				CreateWindowFromTemplate(entry, "AttributeTemplate", "CharacterSheet")				
				
				if prev == "" then
					WindowAddAnchor(entry, "topleft", "CharacterSheet", "topleft", 20, 50)
				else
					WindowAddAnchor(entry, "bottomleft", prev, "topleft", xoffset, yoffset)
					xoffset = 0
					yoffset = 5
				end
				WindowSetId("CharacterSheetTithe", 99997)

				local labelName = entry.."AttributeName"
				
				LabelSetText(labelName, L"Tithing Points")
				CharacterSheet.SetMiniIconStats(entry, WindowData.PlayerStatsDataCSV[Spellbook.tithId].iconId)
				

				prev = entry
			end
			if (i == 13) then
				entry = "CharacterSheetKarma"
				CreateWindowFromTemplate(entry, "AttributeTemplate", "CharacterSheet")				
				
				if prev == "" then
					WindowAddAnchor(entry, "topleft", "CharacterSheet", "topleft", 20, 50)
				else
					WindowAddAnchor(entry, "bottomleft", prev, "topleft", xoffset, yoffset)
					xoffset = 0
					yoffset = 5
				end
				WindowSetId("CharacterSheetKarma", 99999)

				local labelName = entry.."AttributeName"
				
				LabelSetText(labelName, L"Karma")
				

				prev = entry
				
				entry = "CharacterSheetFame"
				CreateWindowFromTemplate(entry, "AttributeTemplate", "CharacterSheet")
				
				
				if prev == "" then
					WindowAddAnchor(entry, "topleft", "CharacterSheet", "topleft", 10, 50)
				else
					WindowAddAnchor(entry, "bottomleft", prev, "topleft", xoffset, yoffset)
					xoffset = 0
					yoffset = 5
				end

				local labelName = entry.."AttributeName"
				
				LabelSetText(labelName, L"Fame")
				WindowSetId("CharacterSheetFame", 55555)
				
			end
			
			prev = entry
		end
		if groupItr == 1 then -- Various layout fixes / cleanup after te first group is set
			WindowAddAnchor( "CharacterSheetTopArrows", "bottom", "CharacterSheetFameRule", "top", 0, 0 )
			WindowSetDimensions( "CharacterSheetHealthExtra" , 110, 20)
			WindowClearAnchors( "CharacterSheetHealthExtra" )
			WindowAddAnchor( "CharacterSheetHealthExtra", "left", "CharacterSheetHealthAttributeValue", "right", -5, 0 )
			WindowSetDimensions( "CharacterSheetStaminaExtra" , 110, 20)
			WindowClearAnchors( "CharacterSheetStaminaExtra" )
			WindowAddAnchor( "CharacterSheetStaminaExtra", "left", "CharacterSheetStaminaAttributeValue", "right", -5, 0 )
			WindowSetDimensions( "CharacterSheetManaExtra" , 110, 20)
			WindowClearAnchors( "CharacterSheetManaExtra" )
			WindowAddAnchor( "CharacterSheetManaExtra", "left", "CharacterSheetManaAttributeValue", "right", -5, 0 )
		end
--		Debug.Print( L""..xoffset..L" "..yoffset )
		
		xoffset = -5
		yoffset = 3
		
		prev = "CharacterSheetTopArrows"
	end
	
	CharacterSheet.UpdateSpecialStats()	
	CharacterSheet.HideAllButFirstGroups()
	CharacterSheet.ShowActiveAndFirstGroups()
	CharacterSheet.SetGroupLabel()	
	CharacterSheet.UpdateStatus()
	if (CharacterSheet.Groups[CharacterSheet.CurrentGroup].h) then
		WindowSetDimensions( "CharacterSheet" , 400, CharacterSheet.Groups[CharacterSheet.CurrentGroup].h)
	end
	WindowUtils.RestoreWindowPosition("CharacterSheet")
end


function CharacterSheet.ContextG()
	for i=2, table.getn(CharacterSheet.Groups) do
		local name = ""
		if (CharacterSheet.Groups[i].nameTid) then
			name = GetStringFromTid(CharacterSheet.Groups[i].nameTid)
		else
			name = CharacterSheet.Groups[i].nameString
		end
		ContextMenu.CreateLuaContextMenuItemWithString(name,0,i,2,CharacterSheet.CurrentGroup== i)
	end
	ContextMenu.ActivateLuaContextMenu(CharacterSheet.ContextMenuCallback)
end

function CharacterSheet.ContextMenuCallback( returnCode, param )
	CharacterSheet.CurrentGroup=returnCode
	CustomSettings.SaveNumber( "CharacterSheetGroup" , CharacterSheet.CurrentGroup )
	CharacterSheet.ValidateGroup()
	CharacterSheet.SetGroupLabel()
	CharacterSheet.HideAllButFirstGroups()
	CharacterSheet.ShowActiveAndFirstGroups()
	if (CharacterSheet.Groups[CharacterSheet.CurrentGroup].h) then
		WindowSetDimensions( "CharacterSheet" , 400, CharacterSheet.Groups[CharacterSheet.CurrentGroup].h)
	end
end

function CharacterSheet.UpdateIcons()
	for groupItr, group in pairs(CharacterSheet.Groups) do
		for itemItr, i in pairs(group.index) do	
			stat = WStringToString(WindowData.PlayerStatsDataCSV[i].name)

			if stat == "HR" then
				continue
			end

			local entry = "CharacterSheet"..stat
			
			local iconId = WindowData.PlayerStatsDataCSV[i].iconId
			
			if (iconId) then
				CharacterSheet.SetMiniIconStats(entry, iconId)
			end
		end
	end
	CharacterSheet.SetMiniIconStats("CharacterSheetBankGold", WindowData.PlayerStatsDataCSV[12].iconId)
	CharacterSheet.SetMiniIconStats("CharacterSheetTithe", WindowData.PlayerStatsDataCSV[Spellbook.tithId].iconId)
end

function CharacterSheet.Shutdown()
	UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
	
	WindowUtils.SaveWindowPosition("CharacterSheet")
end

function CharacterSheet.SetMiniIconStats(iconWindow, iconId)
	local texture, x, y = GetIconData( iconId )
	--Start position of the texture, need to be offset by x and y to get the stat icon image
	x = 4  
	y = 3
	WindowSetDimensions(iconWindow.."SquareIcon", 27, 27)
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )
	DynamicImageSetTexture(iconWindow.."SquareIconBG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", x, y)	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 1 )
			
end

function CharacterSheet.Update()
end

function CharacterSheet.OnShown()
    if( WindowData.PlayerStatus ~= nil and WindowData.PlayerStatus.PlayerId ~= nil ) then
        local paperdollWindow = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
        if( DoesWindowNameExist(paperdollWindow) ) then
            ButtonSetPressedFlag(paperdollWindow.."ToggleCharacterSheet",true)
        end
    end
    WindowSetShowing(WindowData.PlayerStatus["LoyaltyRating"], false)
end

function CharacterSheet.OnHidden()
    if( WindowData.PlayerStatus ~= nil and WindowData.PlayerStatus.PlayerId ~= nil ) then
        local paperdollWindow = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
        if( DoesWindowNameExist(paperdollWindow) ) then
            ButtonSetPressedFlag(paperdollWindow.."ToggleCharacterSheet",false)
        end
    end
    if WindowData.PlayerStatus["LoyaltyRating"] ~= nil  then
		DestroyWindow(WindowData.PlayerStatus["LoyaltyRating"])
		WindowData.PlayerStatus["LoyaltyRating"] = nil
	end
end

function CharacterSheet.UpdateStatus()
    local value = nil
    if ( WindowData.PlayerStatus["Race"] == 3 ) then -- garg
		CharacterSheet.Caps["HitChanceIncrease"] = 50
	elseif ( WindowData.PlayerStatus["Race"] == 2 ) then -- elf
			CharacterSheet.Caps["EnergyResist"] = 75
	elseif ( WindowData.PlayerStatus["Race"] == 1 ) then -- human
	end
			
	if (EnhancePack) then
		LabelSetText("CharacterSheetKarmaAttributeValue", WindowUtils.AddCommasToNumber(EnhancePack.Karma))
		LabelSetText("CharacterSheetFameAttributeValue", WindowUtils.AddCommasToNumber(EnhancePack.Fame))
		RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BANK)
		if WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK] then
			local bank = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK].objectId
			local total = EnhancePack.SumChecks(bank)
			LabelSetText("CharacterSheetBankGoldAttributeValue", WindowUtils.AddCommasToNumber(total))
		else
			LabelSetText("CharacterSheetBankGoldAttributeValue", L"" .. 0)
		end
		UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BANK)
	end
	
	LabelSetText("CharacterSheetTitheAttributeValue", WindowUtils.AddCommasToNumber(tostring(WindowData.PlayerStatus.TithingPoints)))
	
	for i = 1, CharacterSheet.StatsSize do
		local k = CharacterSheet.Stats[i]
		if (EnhancePack and NewChatWindow) then
			if (k == "Strength" and WindowData.PlayerStatus[k] ~= CharacterSheet.lastStr) then
				if (CharacterSheet.lastStr == 0) then
					CharacterSheet.lastStr = WindowData.PlayerStatus[k]
				else
					local sign = L""
					local col = {r=6,g=206,b=41}
					if (WindowData.PlayerStatus[k] < CharacterSheet.lastStr) then
						local sign = L"-"
						col = EnhancePack.DANGER_COLOR
					end
					local change = WindowData.PlayerStatus[k] - CharacterSheet.lastStr
					CharacterSheet.lastStr = WindowData.PlayerStatus[k]
					
					-- 3000272 Your strength has changed by ~1changeamount~.  It is now ~2newvalue~.
					local text = ReplaceTokens(GetStringFromTid(3000272), {sign .. change, L""..CharacterSheet.lastStr})
					if (EnhancePack.UseNewChat) then
						local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = col, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", EnhancePack.Clock.h) .. ":" .. string.format("%02.f", EnhancePack.Clock.m) .. ":" .. string.format("%02.f", EnhancePack.Clock.s))}
						table.insert(NewChatWindow.Messages, logVal)
						NewChatWindow.UpdateLog()
					else
						PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
					end
				end
			end
			if ( k == "Dexterity" and WindowData.PlayerStatus[k] ~= CharacterSheet.lastDex) then
				if (CharacterSheet.lastDex == 0) then
					CharacterSheet.lastDex = WindowData.PlayerStatus[k]
				else
					local col = {r=6,g=206,b=41}
					local sign = L""
					if (WindowData.PlayerStatus[k] < CharacterSheet.lastDex) then
						local sign = L"-"
						col = EnhancePack.DANGER_COLOR
					end
					local change = WindowData.PlayerStatus[k] - CharacterSheet.lastDex
					CharacterSheet.lastDex = WindowData.PlayerStatus[k]
					
					-- 3000273 Your dexterity has changed by ~1changeamount~.  It is now ~2newvalue~.
					local text = ReplaceTokens(GetStringFromTid(3000273), {sign .. change, L""..CharacterSheet.lastDex})
					if (EnhancePack.UseNewChat) then
						local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = col, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", EnhancePack.Clock.h) .. ":" .. string.format("%02.f", EnhancePack.Clock.m) .. ":" .. string.format("%02.f", EnhancePack.Clock.s))}
						table.insert(NewChatWindow.Messages, logVal)
						NewChatWindow.UpdateLog()
					else
						PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
					end
				end
			end
			if ( k == "Intelligence" and WindowData.PlayerStatus[k] ~= CharacterSheet.lastInt) then
				if (CharacterSheet.lastInt == 0) then
					CharacterSheet.lastInt = WindowData.PlayerStatus[k]
				else
					local sign = L""
					local col = {r=6,g=206,b=41}
					if (WindowData.PlayerStatus[k] < CharacterSheet.lastInt) then
						local sign = L"-"
						col = EnhancePack.DANGER_COLOR
					end
					local change = WindowData.PlayerStatus[k] - CharacterSheet.lastInt
					CharacterSheet.lastInt = WindowData.PlayerStatus[k]
					
					-- 3000274 Your intelligence has changed by ~1changeamount~.  It is now ~2newvalue~.
					local text = ReplaceTokens(GetStringFromTid(3000274), {sign .. change, L""..CharacterSheet.lastInt})
					if (EnhancePack.UseNewChat) then
						local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = col, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = StringToWString(string.format("%02.f", EnhancePack.Clock.h) .. ":" .. string.format("%02.f", EnhancePack.Clock.m) .. ":" .. string.format("%02.f", EnhancePack.Clock.s))}
						table.insert(NewChatWindow.Messages, logVal)
						NewChatWindow.UpdateLog()
					else
						PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
					end
				end
			end
		end
		if CharacterSheet.Separators[k] then
			local sep = CharacterSheet.Separators[k]
			-- hack for health,mana,stamina
			local curVar = k
			if( k == "Health" or k == "Stamina" or k == "Mana" ) then
				curVar = "Current"..k
			end
		        
		    if EnhancePack and k == "Damage" then
				local mindmg = WindowData.PlayerStatus[curVar]
				local maxdmg = WindowData.PlayerStatus["Max"..k]
				local avgdmg = (mindmg + maxdmg) / 2
				local speed = EnhancePack.CurrentWeaponSpeed
				if not EnhancePack or EnhancePack.CurrentWeaponSpeed == 0 then
					speed = 1.25
				end
				 value = wstring.format(L"%.2f",math.floor((avgdmg/speed)*100) / 100)
				 WindowData.PlayerStatus["DPS"] = avgdmg/speed
			else
				value = StringToWString(tostring(WindowData.PlayerStatus[curVar])..sep..tostring(WindowData.PlayerStatus["Max"..k]))
			end
			--Debug.Print( L"Value is "..value..L" and k is "..StringToWString(k) )
		
			
		else
			
			local cap = nil
			if (CharacterSheet.Caps[k]) then
				cap = CharacterSheet.Caps[k] + CharacterSheet.CapsBonus[k]
			end
			
			if (cap == nil) then
				local id = WindowGetId("CharacterSheet"..k)
				
				local extraText = L""
				if (EnhancePack) then
					if (id == 1013) then
						extraText = EnhancePack.GargQueenLVL
					elseif (id == 1014) then
						extraText = EnhancePack.OphiLVL
					elseif (id == 1015) then
						extraText = EnhancePack.BaneChosenLVL
					elseif (id == 1016) then
						extraText = EnhancePack.MeerLVL
					elseif (id == 1017) then
						extraText = EnhancePack.JukaLVL
					end
				end
				if (extraText ~= L"") then
					local labelName = "CharacterSheet"..k.."AttributeName"
					LabelSetText(labelName, WindowData.PlayerStatsDataCSV[id].nameWString .. L" ("  .. extraText .. L")" )
				end
				if (tonumber(WindowData.PlayerStatus[k]) and type(WindowData.PlayerStatus[k]) ~= "wstring" ) then
					value = StringToWString(tostring(WindowUtils.AddCommasToNumber(WindowData.PlayerStatus[k])))
				else
					value = WindowData.PlayerStatus[k]
					if type(value) ~= "wstring" then
						value = StringToWString(tostring(value))
					end
				end
			else
				value = StringToWString(tostring(WindowData.PlayerStatus[k]) .. " / " .. cap)
			end
			
		end
		LabelSetText("CharacterSheet"..k.."AttributeValue", value)
		CharacterSheet.SetStatLock(k)
	end
	CharacterSheet.UpdateSpecialStats()
end

function CharacterSheet.SetStatLock(stat)
	local button = "CharacterSheet"..stat.."LockButton"

	-- If the stat isn't Str, Dex or Int, hide the stat lock
	if not CharacterSheet.Attributes[stat] then
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0 , 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "", 0 , 0)
		WindowSetDimensions( button, 0, 0 )
		return
	end

	local val = WindowData.PlayerStatus.StatLock[CharacterSheet.Attributes[stat]]
	--Debug.Print("Update StatLock["..WStringToString(CharacterSheet.Attributes[stat]).."]="..tostring(val))
	if val == 0 then
	    WindowSetDimensions(button, UI.UpArrow.DIMENSIONS.x, UI.UpArrow.DIMENSIONS.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, UI.UpArrow.texture, UI.UpArrow.STATE_NORMAL.x, UI.UpArrow.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.UpArrow.texture, UI.UpArrow.STATE_NORMAL_HIGHLITE.x , UI.UpArrow.STATE_NORMAL_HIGHLITE.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, UI.UpArrow.texture, UI.UpArrow.STATE_PRESSED.x, UI.UpArrow.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.UpArrow.texture, UI.UpArrow.STATE_PRESSED_HIGHLITE.x , UI.UpArrow.STATE_PRESSED_HIGHLITE.y)
	elseif val == 1 then
	    WindowSetDimensions(button, UI.DownArrow.DIMENSIONS.x, UI.DownArrow.DIMENSIONS.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL.x, UI.DownArrow.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_NORMAL_HIGHLITE.x , UI.DownArrow.STATE_NORMAL_HIGHLITE.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED.x, UI.DownArrow.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.DownArrow.texture, UI.DownArrow.STATE_PRESSED_HIGHLITE.x , UI.DownArrow.STATE_PRESSED_HIGHLITE.y)		
	elseif val == 2 then
	    WindowSetDimensions(button, UI.Lock.DIMENSIONS.x, UI.Lock.DIMENSIONS.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, UI.Lock.texture, UI.Lock.STATE_NORMAL.x, UI.Lock.STATE_NORMAL.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_NORMAL_HIGHLITE.x, UI.Lock.STATE_NORMAL_HIGHLITE.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, UI.Lock.texture, UI.Lock.STATE_PRESSED.x, UI.Lock.STATE_PRESSED.y)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, UI.Lock.texture, UI.Lock.STATE_PRESSED_HIGHLITE.x, UI.Lock.STATE_PRESSED_HIGHLITE.y)
	end
end

function CharacterSheet.ClickStatLock()
	--Debug.Dump('StatLock', WindowData.PlayerStatus.StatLock) 
	local this = SystemData.ActiveWindow.name
	local id = WindowGetId(this) - 1
	--Debug.Print("Button id is "..id)

	-- only pay attention to buttons 4-6 which are the stat lock buttons
	if (id >= 4) and (id <= 6) then
		-- CJT: originally the stat locks were buttons 1-3
		id = id - 4
		local lock = WindowData.PlayerStatus.StatLock[id]

		lock = lock + 1
		if lock > 2 then 
			lock = 0
		end

		--Debug.Print("setting statlock "..id.." to "..lock)
		WindowData.PlayerStatus.StatLock[id] = lock
		--Debug.Dump('StatLock', WindowData.PlayerStatus.StatLock) 
		UpdateStatLock(id)
		
		CharacterSheet.UpdateStatus()
	end
end

function CharacterSheet.StatLButtonDown()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(parent)
	if id == 99997 then
		local id = Spellbook.tithId
		local iconId = WindowData.PlayerStatsDataCSV[id].iconId	
		DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_PLAYER_STATS,id,iconId)
	elseif (id >= 1019 and id <= 1027) then
		local button = WindowData.PlayerStatus[tostring(WindowData.PlayerStatsDataCSV[id].name) .. "Button"]
		if button then
			GenericGumpOnClicked(WindowGetId(button), button)
			WindowSetShowing("CharacterSheet", false)
			EnhancePack.AfterLoyalty = true
		end
	elseif (id == 1058 and WindowData.PlayerStatus["CitizenTitles"] ~= nil) then
		local button = WindowData.PlayerStatus["CitizenTitles"]
		GenericGumpOnClicked(WindowGetId(button), button)
		WindowSetShowing("CharacterSheet", false)
		EnhancePack.AfterLoyalty = true
	elseif (WindowData.PlayerStatsDataCSV[id]) then
		local iconId = WindowData.PlayerStatsDataCSV[id].iconId
		if (iconId) then
			DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_PLAYER_STATS,id,iconId)
		end
	end
end

function CharacterSheet.StatRButtonDown()
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(parent)
	if (id == 1058 and WindowData.PlayerStatus["CitizenTitles"] ~= nil) then
		local button = WindowData.PlayerStatus["RenounceCitizenship"]
		GenericGumpOnClicked(WindowGetId(button), button)
		WindowSetShowing("CharacterSheet", false)
		GenericGump.GGumpsLabel = {}
		EnhancePack.Renouncing = true
		EnhancePack.AfterLoyalty = true
	end
end

function CharacterSheet.UpdateSpecialStats() -- This deals with the "Increase..." things
	local str = L""
	str = CharacterSheet.StrDexIntBonus( "IncreaseStr" )
	LabelSetText( "CharacterSheetStrengthExtra", str )
	str = CharacterSheet.StrDexIntBonus( "IncreaseDex" )
	LabelSetText( "CharacterSheetDexterityExtra", str )
	str = CharacterSheet.StrDexIntBonus( "IncreaseInt" )
	LabelSetText( "CharacterSheetIntelligenceExtra", str )
	str = CharacterSheet.HealthStaminaManaBonus( "IncreaseHitPoints" )
	LabelSetText( "CharacterSheetHealthExtra", str )
	str = CharacterSheet.HealthStaminaManaBonus( "IncreaseStam" )
	LabelSetText( "CharacterSheetStaminaExtra", str )
	str = CharacterSheet.HealthStaminaManaBonus( "IncreaseMana" )
	LabelSetText( "CharacterSheetManaExtra", str )
end

function CharacterSheet.HealthStaminaManaBonus( which )
	local heal = L""
	local val, max
	if WindowData and WindowData.PlayerStatus and WindowData.PlayerStatus[which] and WindowData.PlayerStatus[which.."Max"] then
		val = WindowData.PlayerStatus[which .. "Max"]
		max = CharacterSheet.Caps[which] --WindowData.PlayerStatus[which.."Max"]
		if not max then
			max = 0
		end
		if max > 0 then
			heal = L"/+"..StringToWString(tostring(max))..L")"
		elseif max < 0 then
			heal = L"/"..StringToWString(tostring(max))..L")"
		end
		if heal == L"" then
			if val > 0 then
				heal = L"(+"..StringToWString(tostring(val))..L")"
			elseif val < 0 then
				heal = L"("..StringToWString(tostring(val))..L")"
			end
		else
			if val > 0 then
				heal = L"(+"..StringToWString(tostring(val))..heal				
			elseif val < 0 then
				heal = L"("..StringToWString(tostring(val))..heal
			else
				heal = L""
			end
		end
	end
	return heal
end

function CharacterSheet.StrDexIntBonus( which )
	local str = L""
	local val 
	if WindowData and WindowData.PlayerStatus and WindowData.PlayerStatus[which] then
		val = WindowData.PlayerStatus[which]
		if val > 0 then
			str = L"(+"..StringToWString(tostring(val))..L")" 
		elseif val < 0 then
			str = L"("..StringToWString(tostring(val))..L")"
		end
	end
	return str
end

-- Remaining functions deal with groups
-- "Action" names are remnants from code copied from ActionsWindow
function CharacterSheet.HideAllButFirstGroups()
	local groupItr, group, itemItr, actionIndex
	for groupItr, group in pairs(CharacterSheet.Groups) do
		if groupItr ~= 1 then
			for itemItr, actionIndex in pairs(group.index) do
				WindowSetShowing( "CharacterSheet"..WStringToString(WindowData.PlayerStatsDataCSV[actionIndex].name), false )
			end	
		end
	end
end
function CharacterSheet.ShowActiveAndFirstGroups()
	local itemItr, actionIndex
	for itemItr, actionIndex in pairs(CharacterSheet.Groups[CharacterSheet.CurrentGroup].index) do
		WindowSetShowing( "CharacterSheet"..WStringToString(WindowData.PlayerStatsDataCSV[actionIndex].name), true )
	end
end
function CharacterSheet.LeftArrowPressed()
	CharacterSheet.CurrentGroup = CharacterSheet.CurrentGroup - 1
	CustomSettings.SaveNumber( "CharacterSheetGroup" , CharacterSheet.CurrentGroup )
	CharacterSheet.ValidateGroup()
	CharacterSheet.SetGroupLabel()
	CharacterSheet.HideAllButFirstGroups()
	CharacterSheet.ShowActiveAndFirstGroups()
	if (CharacterSheet.Groups[CharacterSheet.CurrentGroup].h) then
		WindowSetDimensions( "CharacterSheet" , 400, CharacterSheet.Groups[CharacterSheet.CurrentGroup].h)
	end
end
function CharacterSheet.RightArrowPressed()
	CharacterSheet.CurrentGroup = CharacterSheet.CurrentGroup + 1
	CustomSettings.SaveNumber( "CharacterSheetGroup" , CharacterSheet.CurrentGroup )
	CharacterSheet.ValidateGroup()
	CharacterSheet.SetGroupLabel()
	CharacterSheet.HideAllButFirstGroups()
	CharacterSheet.ShowActiveAndFirstGroups()
	if (CharacterSheet.Groups[CharacterSheet.CurrentGroup].h) then
		WindowSetDimensions( "CharacterSheet" , 400, CharacterSheet.Groups[CharacterSheet.CurrentGroup].h)
	end
end
function CharacterSheet.SetGroupLabel()
	if CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameTid
	and CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameTid ~= 0
	then
		LabelSetText( "CharacterSheetTopArrowsText", GetStringFromTid( CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameTid ) )
	else
		if CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameString
		then
			LabelSetText( "CharacterSheetTopArrowsText", CharacterSheet.Groups[CharacterSheet.CurrentGroup].nameString )
		else
			LabelSetText( "CharacterSheetTopArrowsText", L""..CharacterSheet.CurrentGroup )
		end
	end
end
function CharacterSheet.ValidateGroup()
	if ( not CharacterSheet.CurrentGroup ) or ( CharacterSheet.CurrentGroup > #CharacterSheet.Groups ) then
		CharacterSheet.CurrentGroup = 2
	end
	if ( CharacterSheet.CurrentGroup < 2 ) then
		CharacterSheet.CurrentGroup = #CharacterSheet.Groups
	end
end

function CharacterSheet.StatMouseOver()	
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(parent)
	
	local itemData = { windowName = "CharacterSheet",
						itemId = id,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_PLAYER_STATS,
						detail = ItemProperties.DETAIL_LONG }

	ItemProperties.SetActiveItem(itemData)
end

function CharacterSheet.LockMouseOver()
	local text = GetStringFromTid(1112102)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end