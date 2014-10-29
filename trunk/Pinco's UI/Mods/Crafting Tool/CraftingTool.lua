
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CraftingTool = {}

CraftingTool.GGLabels = {}

CraftingTool.MaxLastItems = 15
CraftingTool.MaxSearchItems = 100


local skills = { 1, 8, 11, 12, 14, 20, 27, 52, 55  }
local skillsIndex = {
		[WindowData.SkillsCSV[1].NameTid] = 1;
		[WindowData.SkillsCSV[8].NameTid] = 2;
		[WindowData.SkillsCSV[11].NameTid] = 3;
		[WindowData.SkillsCSV[12].NameTid] = 4;
		[WindowData.SkillsCSV[14].NameTid] = 5;
		[WindowData.SkillsCSV[20].NameTid] = 6;
		[WindowData.SkillsCSV[27].NameTid] = 7;
		[WindowData.SkillsCSV[52].NameTid] = 8;
		[WindowData.SkillsCSV[55].NameTid] = 9;
		[1072392] = 10;
		[1072393] = 11;
}

CraftingTool.SkillsIdFromTid = {
	[WindowData.SkillsCSV[1].NameTid] = 1;
	[WindowData.SkillsCSV[8].NameTid] = 8;
	[WindowData.SkillsCSV[11].NameTid] = 11;
	[WindowData.SkillsCSV[12].NameTid] = 12;
	[WindowData.SkillsCSV[14].NameTid] = 14;
	[WindowData.SkillsCSV[20].NameTid] = 20;
	[WindowData.SkillsCSV[27].NameTid] = 27;
	[WindowData.SkillsCSV[52].NameTid] = 52;
	[WindowData.SkillsCSV[55].NameTid] = 55;
	[1072392] = 11;
	[1072393] = 1;
}

CraftingTool.SkillsCategory = 
{
	[1044071] = 
	{
		[1044566] = true,
		[1111809] = true,
		[1062760] = true,
		[1044298] = true,
		[1044291] = true,
		[1044292] = true,
		[1044293] = true,
		[1044294] = true,
		[1044290] = true,
		[1044297] = true,
	},
	[1044094] = 
	{
		[1015256] = true,
		[1111748] = true,
		[1011388] = true,
		[1044457] = true,
		[1011173] = true,
		[1015306] = true,
		[1049149] = true,
		[1015300] = true,
		[1015293] = true,
		[1111747] = true,
	},
	[1044072] = 
	{
		[1044448] = true,
	},
	[1044073] = 
	{
		[1044498] = true,
		[1044495] = true,
		[1080001] = true,
		[1044496] = true,
		[1073108] = true,
		[1044497] = true,
		[1116340] = true,
	},
	[1072392] = 
	{
		[1044501] = true,
		[1044502] = true,
		[1044503] = true,
		[1044290] = true,
		[1111719] = true,
		[1111705] = true,
	},
	[1072393] = 
	{
		[1011173] = true,
		[1111745] = true,
	},
	[1044067] = 
	{
		[1011079] = true,
		[1111704] = true,
		[1011080] = true,
		[1011081] = true,
		[1011082] = true,
		[1011173] = true,
		[1011084] = true,
		[1151626] = true,
		[1116354] = true,
		[1011083] = true,
	},
	[1044060] = 
	{
		[1116349] = true,
		[1116350] = true,
		[1116351] = true,
		[1116353] = true,
		[1116348] = true,
		[1044495] = true,
	},
	[1044068] = 
	{
		[1044566] = true,
		[1044565] = true,
		[1044457] = true,
	},
	[1044083] = 
	{
		[1111694] = true,
		[1111693] = true,
		[1111692] = true,
		[1111691] = true,
		[1111671] = true,
		[1044294] = true,
		[1061677] = true,
	},
	[1044097] = 
	{
		[1073107] = true,
		[1011170] = true,
		[1015318] = true,
		[1044051] = true,
		[1044052] = true,
		[1011173] = true,
		[1011175] = true,
		[1011171] = true,
		[1011172] = true,
	},
}


CraftingTool.Tools = {
		[WindowData.SkillsCSV[1].NameTid] = {3739};
		[WindowData.SkillsCSV[8].NameTid] = {4020, 4021, 4027, 4028, 5091};
		[WindowData.SkillsCSV[11].NameTid] = {4136, 4137, 4138, 4140, 4142, 4144, 4146, 4148, 4324, 4325, 4326, 4327};
		[WindowData.SkillsCSV[12].NameTid] = {4032};
		[WindowData.SkillsCSV[14].NameTid] = {2431, 4158, 4163};
		[WindowData.SkillsCSV[20].NameTid] = {4130};
		[WindowData.SkillsCSV[27].NameTid] = {4031};
		[WindowData.SkillsCSV[52].NameTid] = {3997};
		[WindowData.SkillsCSV[55].NameTid] = {7864, 7865, 7868};
		[1072392] = {4787};
		[1072393] = {3722};
	}
	
CraftingTool.RunicTools = {
		[WindowData.SkillsCSV[8].NameTid] = {1152952, 1049028, 1049029, 1049030, 1049031, 1053108, 1053107, 1053106, 1053105, 1053104, 1053103, 1053102, 1053101};
		[WindowData.SkillsCSV[11].NameTid] = {1152952, 1071428, 1071429, 1071430, 1071432};
		[WindowData.SkillsCSV[20].NameTid] = {1152952, 1071428, 1071429, 1071430, 1071432};
		[WindowData.SkillsCSV[52].NameTid] = {1152952, 1061118, 1061117, 1061116};
		[1072392] = {1152952, 1053108, 1053107, 1053106, 1053105, 1053104, 1053103, 1053102, 1053101};
	}
	
	
CraftingTool.MaterialsIcon = {

		["Default"] = {0,0};
		[WindowData.SkillsCSV[8].NameTid] = {7155, 9908};
		[WindowData.SkillsCSV[11].NameTid] = {7131};
		[WindowData.SkillsCSV[20].NameTid] = {7131};
		[WindowData.SkillsCSV[52].NameTid] = {4199};
		[WindowData.SkillsCSV[55].NameTid] = {7155};
		[1072392] = {6009};
	}
	
CraftingTool.MaterialsGroup = {
		[7155] = {1053109, 1053108, 1053107, 1053106, 1053105, 1053104, 1053103, 1053102, 1053101};
		[9908] = {1053129, 1053130, 1053131, 1053132, 1053133, 1053134};
		[7131] = {1079435, 1071428, 1071429, 1071430, 1071432, 1071431, 1071433};
		[4199] = {1062235, 1061118, 1061117, 1061116};
		[6009] = {1152952, 1053108, 1053107, 1053106, 1053105, 1053104, 1053103, 1053102, 1053101};
	}

CraftingTool.Materials = { -- tid material = hue id
	[1060800] = {minSkill = 0, hue = 0, infoCliloc = 0 }; -- unknown
	-- ancient hammers
	[1049028] = {minSkill = 0, hue = 1154, tid = 1049028, infoCliloc = 0 }; -- normal
	[1049029] = {minSkill = 0, hue = 1154, tid = 1049029, infoCliloc = 0 }; -- normal
	[1049030] = {minSkill = 0, hue = 1154, tid = 1049030, infoCliloc = 0 }; -- normal
	[1049031] = {minSkill = 0, hue = 1154, tid = 1049031, infoCliloc = 0 }; -- normal
	-- ore/granite	
	[1152952] = {minSkill = 0, hue = 0, tid = 1044525, infoCliloc = 0 }; -- normal
	[1053109] = {minSkill = 0, hue = 0, tid = 1044022, infoCliloc = 0 }; -- iron
	[1053108] = {minSkill = 65, hue = 2419, tid = 1044023, infoCliloc = 1053108 }; -- dull copper
	[1053107] = {minSkill = 70, hue = 2406, tid = 1044024, infoCliloc = 1053107 }; -- shadow iron
	[1053106] = {minSkill = 75, hue = 2413, tid = 1044025, infoCliloc = 1053106 }; -- copper
	[1053105] = {minSkill = 80, hue = 2418, tid = 1044026, infoCliloc = 1053105 }; -- bronze
	[1053104] = {minSkill = 85, hue = 2213, tid = 1044027, infoCliloc = 1053104 }; -- golden
	[1053103] = {minSkill = 90, hue = 2425, tid = 1044028, infoCliloc = 1053103 }; -- agapite
	[1053102] = {minSkill = 95, hue = 2207, tid = 1044029, infoCliloc = 1053102 }; -- verite
	[1053101] = {minSkill = 99, hue = 2219, tid = 1044030, infoCliloc = 1053101 }; -- valorite
	-- dragon scales
	[1053129] = {minSkill = 0, hue = 1645, tid = 1060875, infoCliloc = 1053129 }; -- red scales
	[1053130] = {minSkill = 0, hue = 2216, tid = 1060876, infoCliloc = 1053130 }; -- yellow scales
	[1053131] = {minSkill = 0, hue = 1109, tid = 1060877, infoCliloc = 1053131 }; -- black scales
	[1053132] = {minSkill = 0, hue = 2129, tid = 1060878, infoCliloc = 1053132 }; -- green scales
	[1053133] = {minSkill = 0, hue = 2301, tid = 1060879, infoCliloc = 1053133 }; -- white scales
	[1053134] = {minSkill = 0, hue = 2224, tid = 1060880, infoCliloc = 1053134 }; -- blue scales
	-- leather
	[1062235] = {minSkill = 0, hue = 0, tid = 1049150, infoCliloc = 0 }; -- leather
	[1061118] = {minSkill = 65, hue = 2220, tid = 1049151, infoCliloc = 1049354 }; -- spined
	[1061117] = {minSkill = 80, hue = 2117, tid = 1049152, infoCliloc = 1049355 }; -- horned
	[1061116] = {minSkill = 99, hue = 2129, tid = 1049153, infoCliloc = 1049356 }; -- barbed
	-- wood
	[1079435] = {minSkill = 0, hue = 0, tid = 1072643, infoCliloc = 0 }; -- wood
	[1071428] = {minSkill = 65, hue = 2010, tid = 1072644, infoCliloc = 1072533 }; -- Oak
	[1071429] = {minSkill = 80, hue = 1191, tid = 1072645, infoCliloc = 1072534 }; -- Ash
	[1071430] = {minSkill = 95, hue = 1192, tid = 1072646, infoCliloc = 1072535 }; -- Yew
	[1071431] = {minSkill = 100, hue = 1194, tid = 1072648, infoCliloc = 1072538 }; -- Bloodwood
	[1071432] = {minSkill = 100, hue = 1193, tid = 1072647, infoCliloc = 1072536 }; -- Heartwood
	[1071433] = {minSkill = 100, hue = 1151, tid = 1072649, infoCliloc = 1072539 }; -- Frostwood
}

CraftingTool.ButtonStatus = {
											-- alter, repair, enhance, smelt, make last, settings, mark item, quest item, materials1, materials2, searcharea, recipes
		["Default"] = {false, false, false, false, false, true, false, false, false, false, false, true};
		[WindowData.SkillsCSV[1].NameTid] = {false, false, false, false, true, true, false, true, false, false, true};
		[WindowData.SkillsCSV[8].NameTid] = {true, true, true, true, true, true, true, true, true, true, true};
		[WindowData.SkillsCSV[11].NameTid] = {true, true, true, false, true, true, true, true, true, false, true};
		[WindowData.SkillsCSV[12].NameTid] = {false, false, false, false, true, true, false, true, false, false, true};
		[WindowData.SkillsCSV[14].NameTid] = {false, false, false, false, true, true, true, true, false, false, true};
		[WindowData.SkillsCSV[20].NameTid] = {false, true, true, false, true, true, true, true, true, false, true};
		[WindowData.SkillsCSV[27].NameTid] = {false, false, false, false, true, true, true, true, false, false, true};
		[WindowData.SkillsCSV[52].NameTid] = {true, true, true, false, true, true, true, true, true, false, true};
		[WindowData.SkillsCSV[55].NameTid] = {true, true, true, false, true, true, true, true, true, false, true};
		[1072392] = {false, true, true, false, true, true, true, true, true, false, true};
		[1072393] = {false, true, false, false, true, true, true, true, false, false, true};
	}

CraftingTool.SuccessBonus = {											
		[WindowData.SkillsCSV[1].NameTid] = {0,0};
		[WindowData.SkillsCSV[8].NameTid] = {0,0};
		[WindowData.SkillsCSV[11].NameTid] = {0,0};
		[WindowData.SkillsCSV[12].NameTid] = {0,0};
		[WindowData.SkillsCSV[14].NameTid] = {0,0};
		[WindowData.SkillsCSV[20].NameTid] = {0,0};
		[WindowData.SkillsCSV[27].NameTid] = {0,0};
		[WindowData.SkillsCSV[52].NameTid] = {0,0};
		[WindowData.SkillsCSV[55].NameTid] = {0,0};
		[1072392] = {0,0};
		[1072393] = {0,0};
	}
	
CraftingTool.ActiveMaterials = {}
	
CraftingTool.Buttons = {}

CraftingTool.GumpMakeMax = 0

CraftingTool.GumpRequest = ""
CraftingTool.GumpRequestSkill = ""
CraftingTool.GumpRequestMaterial = ""
CraftingTool.GumpRequestMaterialGroupID = 0
CraftingTool.GumpRequestCategory = ""
CraftingTool.GumpRequestCraftItem = ""
CraftingTool.GumpRequestItemInstance = 0
CraftingTool.GumpRecipeCount = {}

CraftingTool.GumpRecipeCurrent = 0

CraftingTool.delta = 0

CraftingTool.WarningEndTime = 0
CraftingTool.WarningActive = false

CraftingTool.OpenedCat = false
CraftingTool.OpenedLast = false
CraftingTool.OpenedRecipe = false
CraftingTool.OpenedSearch = false

CraftingTool.Items = {}


CraftingTool.allSlots = {}
CraftingTool.materialSlots = {}
CraftingTool.mainItemSlots = {}

CraftingTool.Patterns = {}

-- SAVED DATA
local currShard = UserData.Settings.Login.lastShardSelected
local playerID

function CraftingTool.InitializeSettings()
	
	local windowName = "CraftingToolWindow"
	
	if not CraftingTool.CraftContainer then
		CraftingTool.CraftContainer = {}
	end
	if not CraftingTool.CraftContainer[currShard] then
		CraftingTool.CraftContainer[currShard] = {}
	end
	if not CraftingTool.CraftContainer[currShard][playerID] then
		CraftingTool.CraftContainer[currShard][playerID] = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	end
	
	if not CraftingTool.MaterialsContainer then
		CraftingTool.MaterialsContainer = {}
	end
	if not CraftingTool.MaterialsContainer[currShard] then
		CraftingTool.MaterialsContainer[currShard] = {}
	end
	if not CraftingTool.MaterialsContainer[currShard][playerID] then
		CraftingTool.MaterialsContainer[currShard][playerID] = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	end
	
	if not CraftingTool.LastSkill then
		CraftingTool.LastSkill = {}
	end
	if not CraftingTool.LastSkill[currShard]  then
		CraftingTool.LastSkill[currShard]  = {}
	end
	if not CraftingTool.LastSkill[currShard][playerID]  then
		CraftingTool.LastSkill[currShard][playerID] = 0
	end
		
	if not CraftingTool.LoadedToolsID then
		CraftingTool.LoadedToolsID = {}
	end
	if not CraftingTool.LoadedToolsID[currShard] then
		CraftingTool.LoadedToolsID[currShard] = {}
	end

	if not CraftingTool.LoadedToolsID[currShard][playerID] then
		CraftingTool.LoadedToolsID[currShard][playerID] = {
			[WindowData.SkillsCSV[1].NameTid] = {id=0, uses=0, totalUses=0};
			[WindowData.SkillsCSV[8].NameTid] = {id=0, uses=0, totalUses=0};
			[WindowData.SkillsCSV[11].NameTid] = {id=0, uses=0, totalUses=0};
			[WindowData.SkillsCSV[12].NameTid] = {id=0, uses=0, totalUses=0};
			[WindowData.SkillsCSV[14].NameTid] = {id=0, uses=0, totalUses=0};
			[WindowData.SkillsCSV[20].NameTid] = {id=0, uses=0, totalUses=0};
			[WindowData.SkillsCSV[27].NameTid] = {id=0, uses=0, totalUses=0};
			[WindowData.SkillsCSV[52].NameTid] = {id=0, uses=0, totalUses=0};
			[WindowData.SkillsCSV[55].NameTid] = {id=0, uses=0, totalUses=0};
			[1072392] = {id=0, uses=0, totalUses=0};
			[1072393] = {id=0, uses=0, totalUses=0};
		}
	end
	CraftingTool.LoadedTools = CraftingTool.LoadedToolsID[currShard][playerID]
	
	if not CraftingTool.CurrentMaterialsTid then
		CraftingTool.CurrentMaterialsTid = {}
	end
	if not CraftingTool.CurrentMaterialsTid[currShard] then
		CraftingTool.CurrentMaterialsTid[currShard] = {}
	end
	if not CraftingTool.CurrentMaterialsTid[currShard][playerID] then
		CraftingTool.CurrentMaterialsTid[currShard][playerID] = {
			["Default"] = {0, 0};
			[WindowData.SkillsCSV[8].NameTid] = {1060800, 1060800};
			[WindowData.SkillsCSV[11].NameTid] = {1060800};
			[WindowData.SkillsCSV[20].NameTid] = {1060800};
			[WindowData.SkillsCSV[52].NameTid] = {1060800};
			[WindowData.SkillsCSV[55].NameTid] = {1060800};
			[1072392] = {1060800};
		}
	end
	CraftingTool.CurrentMaterials = CraftingTool.CurrentMaterialsTid[currShard][playerID]
	
	if not CraftingTool.CurrentMaterialsColorTid then
		CraftingTool.CurrentMaterialsColorTid = {}
	end
	if not CraftingTool.CurrentMaterialsColorTid[currShard] then
		CraftingTool.CurrentMaterialsColorTid[currShard] = {}
	end
	if not CraftingTool.CurrentMaterialsColorTid[currShard][playerID] then
		CraftingTool.CurrentMaterialsColorTid[currShard][playerID] = {
			["Default"] = {0, 0};
			[WindowData.SkillsCSV[8].NameTid] = {false, false};
			[WindowData.SkillsCSV[11].NameTid] = {false};
			[WindowData.SkillsCSV[20].NameTid] = {false};
			[WindowData.SkillsCSV[52].NameTid] = {false};
			[WindowData.SkillsCSV[55].NameTid] = {false};
			[1072392] = {false};
		}
	end
	CraftingTool.CurrentMaterialsColor = CraftingTool.CurrentMaterialsColorTid[currShard][playerID]
	
	if not CraftingTool.CurrentFlagsState then
		CraftingTool.CurrentFlagsState = {}
	end
	if not CraftingTool.CurrentFlagsState[currShard] then
		CraftingTool.CurrentFlagsState[currShard] = {}
	end
	if not CraftingTool.CurrentFlagsState[currShard][playerID] then
		CraftingTool.CurrentFlagsState[currShard][playerID] = {
												-- mark (0-> mark, 1 -> no, 2 prompt), quest (true/false)
			[WindowData.SkillsCSV[1].NameTid] = {mark=0, quest=false};
			[WindowData.SkillsCSV[8].NameTid] = {mark=0, quest=false};
			[WindowData.SkillsCSV[11].NameTid] = {mark=0, quest=false};
			[WindowData.SkillsCSV[12].NameTid] = {mark=0, quest=false};
			[WindowData.SkillsCSV[14].NameTid] = {mark=0, quest=false};
			[WindowData.SkillsCSV[20].NameTid] = {mark=0, quest=false};
			[WindowData.SkillsCSV[27].NameTid] = {mark=0, quest=false};
			[WindowData.SkillsCSV[52].NameTid] = {mark=0, quest=false};
			[WindowData.SkillsCSV[55].NameTid] = {mark=0, quest=false};
			[1072392] = {mark=0, quest=false};
			[1072393] = {mark=0, quest=false};
		}
	end
	CraftingTool.CurrentFlags = CraftingTool.CurrentFlagsState[currShard][playerID]
	
	if not CraftingTool.CurrentRunic then
		CraftingTool.CurrentRunic = {}
	end
	if not CraftingTool.CurrentRunic[currShard] then
		CraftingTool.CurrentRunic[currShard] = {}
	end
	if not CraftingTool.CurrentRunic[currShard][playerID] then
		CraftingTool.CurrentRunic[currShard][playerID] = {
			[WindowData.SkillsCSV[1].NameTid] = 1152952;
			[WindowData.SkillsCSV[8].NameTid] = 1152952;
			[WindowData.SkillsCSV[11].NameTid] = 1152952;
			[WindowData.SkillsCSV[12].NameTid] = 1152952;
			[WindowData.SkillsCSV[14].NameTid] = 1152952;
			[WindowData.SkillsCSV[20].NameTid] = 1152952;
			[WindowData.SkillsCSV[27].NameTid] = 1152952;
			[WindowData.SkillsCSV[52].NameTid] = 1152952;
			[WindowData.SkillsCSV[55].NameTid] = 1152952;
			[1072392] = 1152952;
			[1072393] = 1152952;
		}
	end
	CraftingTool.Toolkit = CraftingTool.CurrentRunic[currShard][playerID]
	
	if not CraftingTool.SearchSettings then
		CraftingTool.SearchSettings = {}
	end
	if not CraftingTool.SearchSettings[currShard] then
		CraftingTool.SearchSettings[currShard] = {}
	end
	if not CraftingTool.SearchSettings[currShard][playerID] or CraftingTool.SearchSettings[currShard][playerID]["showAllSkills"] == nil then
		CraftingTool.SearchSettings[currShard][playerID] = {
			["showMaterials"] = false;
			["showSubMaterials"] = false;
			["showZeroSuccessItems"] = true;
			["enableSkillSearch"] = true;
			["searchActiveSkillOnly"] = false;
			["showAllSkills"] = true;
			["showSkillsWithTool"] = false;
			["showSkillsAvailable"] = false;
		}
	end	
	
	CraftingTool.SearchOptions = CraftingTool.SearchSettings[currShard][playerID]
	
	CraftingTool.UpdateCombo(true)
		
	if not CraftingTool.LatestItems then
		CraftingTool.LatestItems = {}
	end
	if not CraftingTool.LatestItems[currShard] then
		CraftingTool.LatestItems[currShard] = {}
	end
	if not CraftingTool.LatestItems[currShard][playerID] then
		CraftingTool.LatestItems[currShard][playerID] = {}
	end
	
	CraftingTool.LastItems = CraftingTool.LatestItems[currShard][playerID]
	
	-- ENU CLILOC EXPORT
--[[
	CraftingTool.ENUCliloc = {}
	for i=0, 5000000 do	
		local str = GetStringFromTid(i)
		if ( str == L"MISSING STRING" or str == "" or str == L"") then
			continue
		end
		CraftingTool.ENUCliloc[i] = str

	end
--]]
	
end



------------
CraftingTool.Initialized = false

function CraftingTool.Initialize()
	if (WindowData.PlayerStatus.PlayerId == 0) then
		return
	end
	playerID = WindowData.PlayerStatus.PlayerId	
	
	CraftingTool.ToolsTitles = {}
	for tid =1044001, 1044009 do
		
		local skill
		if tid == 1044001 then
			skill = WindowData.SkillsCSV[1].NameTid
		elseif tid == 1044002 then	
			skill = WindowData.SkillsCSV[8].NameTid
		elseif tid == 1044003 then	
			skill = WindowData.SkillsCSV[14].NameTid
		elseif tid == 1044004 then	
			skill = WindowData.SkillsCSV[11].NameTid
		elseif tid == 1044005 then	
			skill = WindowData.SkillsCSV[52].NameTid
		elseif tid == 1044006 then	
			skill = WindowData.SkillsCSV[20].NameTid
		elseif tid == 1044007 then	
			skill = WindowData.SkillsCSV[55].NameTid
		elseif tid == 1044008 then	
			skill = WindowData.SkillsCSV[12].NameTid
		elseif tid == 1044009 then	
			skill = WindowData.SkillsCSV[27].NameTid
		end
		
		tid = wstring.gsub(GetStringFromTid(tid), L"<CENTER>" , L"") 
		tid = wstring.gsub(tid, L"</CENTER>" , L"") 
		tid = wstring.gsub(tid, L"</center>" , L"") 
		tid = wstring.gsub(tid, L"<center>" , L"") 
		CraftingTool.ToolsTitles[skill] = tid
	end
			
	local tid = 1044500
	tid = wstring.gsub(GetStringFromTid(tid), L"<CENTER>" , L"") 
	tid = wstring.gsub(tid, L"</CENTER>" , L"") 
	tid = wstring.gsub(tid, L"</center>" , L"") 
	tid = wstring.gsub(tid, L"<center>" , L"") 
	CraftingTool.ToolsTitles[1072392] = tid
	
	local tid = 1044622
	tid = wstring.gsub(GetStringFromTid(tid), L"<CENTER>" , L"") 
	tid = wstring.gsub(tid, L"</CENTER>" , L"") 
	tid = wstring.gsub(tid, L"</center>" , L"") 
	tid = wstring.gsub(tid, L"<center>" , L"") 
	CraftingTool.ToolsTitles[1072393] = tid
	
	CraftingTool.InitializeSettings()
	
	CraftingTool.Initialized = true
	 
	
	 
	local windowName = "CraftingToolWindow"
	SnapUtils.SnappableWindows[windowName] = true
	WindowSetDimensions("CraftingToolWindow", 1200, 700)
	WindowUtils.RestoreWindowPosition("CraftingToolWindow")
	WindowSetScale ("CraftingToolWindow", 0.8)
	EnhancePack.LoadScale( windowName )
	
	LabelSetText(windowName .. "SearchText", UI.GetCliloc(SystemData.Settings.Language.type, 818))
	
	--LabelSetText(windowName .. "TitleText", UI.GetCliloc(SystemData.Settings.Language.type, 5105))
	
	LabelSetText(windowName .. "ActiveSkillLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5106))
	
	LabelSetText(windowName .. "WarningLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5113))
	CraftingTool.DisableWarning()
	
	
		
	ComboBoxSetSelectedMenuItem(windowName .. "ActiveSkillCombo", 0)
	
	--WindowSetTintColor(windowName .. "Separator1", 176,106,0)
	
	local btnName = "Alter"
	table.insert(CraftingTool.Buttons, windowName .. btnName)
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(8409,100,100) -- gargoyle
	scale = 1.2
	WindowSetId(windowName .. btnName .. "Icon", 8409)
	DynamicImageSetTextureDimensions(windowName .. btnName .. "Icon", newWidth *scale, newHeight*scale)
	WindowSetDimensions(windowName .. btnName .. "Icon", newWidth*scale, newHeight*scale)
	DynamicImageSetTexture(windowName .. btnName .. "Icon", name, x, y )
	DynamicImageSetTextureScale(windowName .. btnName .. "Icon", scale)
	LabelSetText(windowName .. btnName .. "Label", UI.GetCliloc(SystemData.Settings.Language.type, 5091))
	WindowSetId(windowName .. btnName, 5092)
	
	
	local btnName = "Repair"
	table.insert(CraftingTool.Buttons, windowName .. btnName)
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(4021,100,100) -- sledge hammer
	scale = 1.2
	WindowSetId(windowName .. btnName .. "Icon", 4021)
	DynamicImageSetTextureDimensions(windowName .. btnName .. "Icon", newWidth *scale, newHeight*scale)
	WindowSetDimensions(windowName .. btnName .. "Icon", newWidth*scale, newHeight*scale)
	DynamicImageSetTexture(windowName .. btnName .. "Icon", name, x, y )
	DynamicImageSetTextureScale(windowName .. btnName .. "Icon", scale)
	LabelSetText(windowName .. btnName .. "Label", UI.GetCliloc(SystemData.Settings.Language.type, 5093))
	WindowSetId(windowName .. btnName, 5094)
	
	local btnName = "Enhance"
	table.insert(CraftingTool.Buttons, windowName .. btnName)
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(3570,100,100) -- wand
	scale = 1.2
	WindowSetId(windowName .. btnName .. "Icon", 3570)
	DynamicImageSetTextureDimensions(windowName .. btnName .. "Icon", newWidth *scale, newHeight*scale)
	WindowSetDimensions(windowName .. btnName .. "Icon", newWidth*scale, newHeight*scale)
	DynamicImageSetTexture(windowName .. btnName .. "Icon", name, x, y )
	DynamicImageSetTextureScale(windowName .. btnName .. "Icon", scale)
	LabelSetFont(windowName .. btnName .. "Label", "font_verdana_bold_shadow_med2_11", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetText(windowName .. btnName .. "Label", UI.GetCliloc(SystemData.Settings.Language.type, 5095))
	WindowSetId(windowName .. btnName, 5096)
	
	local btnName = "Smelt"
	table.insert(CraftingTool.Buttons, windowName .. btnName)
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(4017,100,100) -- forge
	scale = 1.1
	WindowSetId(windowName .. btnName .. "Icon", 4017)
	DynamicImageSetTextureDimensions(windowName .. btnName .. "Icon", newWidth *scale, newHeight*scale)
	WindowSetDimensions(windowName .. btnName .. "Icon", newWidth*scale, newHeight*scale)
	DynamicImageSetTexture(windowName .. btnName .. "Icon", name, x, y )
	DynamicImageSetTextureScale(windowName .. btnName .. "Icon", scale)
	LabelSetText(windowName .. btnName .. "Label", UI.GetCliloc(SystemData.Settings.Language.type, 5097))
	WindowSetId(windowName .. btnName, 5098)
	
	local btnName = "MakeLast"
	table.insert(CraftingTool.Buttons, windowName .. btnName)
	LabelSetText(windowName .. btnName .. "Label", UI.GetCliloc(SystemData.Settings.Language.type, 5099))
	WindowSetId(windowName .. btnName, 5100)
	
	local btnName = "Settings"
	table.insert(CraftingTool.Buttons, windowName .. btnName)
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(7867,100,100) -- tools box
	scale = 1.2
	WindowSetId(windowName .. btnName .. "Icon", 7867)
	DynamicImageSetTextureDimensions(windowName .. btnName .. "Icon", newWidth *scale, newHeight*scale)
	WindowSetDimensions(windowName .. btnName .. "Icon", newWidth*scale, newHeight*scale)
	DynamicImageSetTexture(windowName .. btnName .. "Icon", name, x, y )
	DynamicImageSetTextureScale(windowName .. btnName .. "Icon", scale)
	LabelSetFont(windowName .. btnName .. "Label", "font_verdana_bold_shadow_med2_11", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetText(windowName .. btnName .. "Label", UI.GetCliloc(SystemData.Settings.Language.type, 5101))
	WindowSetId(windowName .. btnName, 5102)
	
	
	local btnName = "Latest"
	LabelSetText(windowName .. btnName .. "Label", UI.GetCliloc(SystemData.Settings.Language.type, 5139) .. CraftingTool.MaxLastItems)
	WindowSetId(windowName .. btnName, 5140)
	
	table.insert(CraftingTool.Buttons, "") -- mark item
	table.insert(CraftingTool.Buttons, "") -- quest item
	
	local btnName = "Materials1"
	table.insert(CraftingTool.Buttons, windowName .. btnName)
	WindowSetShowing(windowName .. btnName, false)
	
	local btnName = "Materials2"
	table.insert(CraftingTool.Buttons, windowName .. btnName)
	WindowSetShowing(windowName .. btnName, false)
	
	local btnName = "ActiveSkillRecipeSearch"
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(10289,150,150) -- recipe
	scale = 1.5
	WindowSetId(windowName .. btnName .. "Icon", 10289)
	DynamicImageSetTextureDimensions(windowName .. btnName .. "Icon", newWidth *scale, newHeight*scale)
	WindowSetDimensions(windowName .. btnName .. "Icon", newWidth*scale, newHeight*scale)
	DynamicImageSetTexture(windowName .. btnName .. "Icon", name, x, y )
	DynamicImageSetTextureScale(windowName .. btnName .. "Icon", scale)
	WindowSetId(windowName .. btnName, 7001)
	table.insert(CraftingTool.Buttons, windowName .. btnName)

	
	local btnName = "CancelMake"
	WindowSetId(windowName .. btnName .. "Button", 5122)
	LabelSetText(windowName .. btnName .. "Label", FormatProperly(GetStringFromTid(1112698)))
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .. btnName .. "Label", "UO_DefaultText_ASIA_20", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .. "WarningValue", "UO_DefaultText_ASIA_20", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	for i = 1, #CraftingTool.Buttons do
		if DoesWindowNameExist(CraftingTool.Buttons[i]) then
			CraftingTool.ToggleDisableButton(CraftingTool.Buttons[i], CraftingTool.ButtonStatus["Default"][i])
		end
	end
	WindowSetShowing(windowName .. "DisableSW", false)
	
end

function CraftingTool.Shutdown()
	WindowUtils.SaveWindowPosition("CraftingToolWindow")
	SnapUtils.SnappableWindows["CraftingToolWindow"] = nil
	if( DoesWindowExist("MaterialInfo") ) then
		DestroyWindow("MaterialInfo")
	end
	CraftingTool.Close()
end

function CraftingTool.Close()
	WindowSetShowing("CraftingToolWindow", false)
	CraftingTool.LastSkill[currShard][playerID] = CraftingTool.ComboData.CurrentSelectionTid
	CraftingTool.GGLabels = {}
	if EnhancePack.CraftGump then
		if DoesWindowNameExist(EnhancePack.CraftGump) then
			DestroyWindow(EnhancePack.CraftGump)
		end
	end
	
	EnhancePack.CraftGump = nil
	EnhancePack.CraftSkill = nil
	EnhancePack.MakeLast = nil
	EnhancePack.RepairItem = nil
end

function CraftingTool.Toggle()
	if(WindowGetShowing("CraftingToolWindow")) then
		CraftingTool.Close()
	else
		WindowSetShowing("CraftingToolWindow", true)
		CraftingTool.Restart()
	end
end

function CraftingTool.OnkeyEsc()
	MainMenuWindow.notnow = true
	CraftingTool.ClearAll()
end

function CraftingTool.Show(skill)
	local windowName = "CraftingToolWindow"
	WindowSetShowing(windowName, true)
		
	--local sel = ComboBoxGetSelectedMenuItem( windowName .. "ActiveSkillCombo" )

	if EnhancePack.HighlightLast ~= 0 and not skill then
		for key, value in pairs(CraftingTool.Tools) do
			for j = 1, #CraftingTool.Tools[key] do
				local hue = 0
				
				if CraftingTool.Tools[key][j] == 3722 then
					hue = 2301
				end

				local itemdata = WindowData.ObjectInfo[EnhancePack.HighlightLast]
				if not itemdata then
					RegisterWindowData(WindowData.ObjectInfo.Type, EnhancePack.HighlightLast)
					itemdata = WindowData.ObjectInfo[EnhancePack.HighlightLast]
				end
				itemHue = EnhancePack.Highlight[EnhancePack.HighlightLast].oldHue

				if itemHue ~= hue then
					noHue = true
					continue
				end
				

				if itemdata.objectType == CraftingTool.Tools[key][j] then
					if CraftingTool.ComboTidToIndex(key) then
						CraftingTool.ComboData.CurrentSelection = CraftingTool.ComboTidToIndex(key)
						CraftingTool.ComboData.CurrentSelectionTid = key
						ComboBoxSetSelectedMenuItem(windowName .. "ActiveSkillCombo", CraftingTool.ComboTidToIndex(key))
					else
						CraftingTool.SearchOptions["showAllSkills"] = true
						CraftingTool.SearchOptions["showSkillsWithTool"] = false
						CraftingTool.SearchOptions["showSkillsAvailable"] = false
						CraftingTool.UpdateCombo()
						CraftingTool.ComboData.CurrentSelection = CraftingTool.ComboTidToIndex(key)
						CraftingTool.ComboData.CurrentSelectionTid = key
						ComboBoxSetSelectedMenuItem(windowName .. "ActiveSkillCombo", CraftingTool.ComboTidToIndex(key))
					end

					CraftingTool.ChangeActiveSkill()
					return
				end
			end
		end
		local idx = CraftingTool.ComboTidToIndex(CraftingTool.LastSkill[currShard][playerID])
		CraftingTool.ComboData.CurrentSelection = idx or 1
		ComboBoxSetSelectedMenuItem(windowName .. "ActiveSkillCombo", CraftingTool.ComboData.CurrentSelection)
		CraftingTool.ComboData.CurrentSelectionTid =CraftingTool.ComboToTid()
	elseif skill then
		local idx = CraftingTool.ComboTidToIndex(skill)
		CraftingTool.ComboData.CurrentSelection = idx or 1
		ComboBoxSetSelectedMenuItem(windowName .. "ActiveSkillCombo", CraftingTool.ComboData.CurrentSelection)
		CraftingTool.ComboData.CurrentSelectionTid =CraftingTool.ComboToTid()
	else
		local idx = CraftingTool.ComboTidToIndex(CraftingTool.LastSkill[currShard][playerID])
		CraftingTool.ComboData.CurrentSelection = idx or 1
		ComboBoxSetSelectedMenuItem(windowName .. "ActiveSkillCombo", CraftingTool.ComboData.CurrentSelection)
		CraftingTool.ComboData.CurrentSelectionTid =CraftingTool.ComboToTid()		
	end
	CraftingTool.ChangeActiveSkill()
	CraftingTool.SearchTools(true)
	
end

function CraftingTool.TidToSkill(Stid)
	
	for skill=1,60 do -- all skills
		local skillName = L""
		local tid = 0
		if skill == 59 then
			tid = WindowData.SkillsCSV[11].NameTid
		elseif skill == 60 then
			tid = WindowData.SkillsCSV[1].NameTid
		else
			tid = WindowData.SkillsCSV[skill].NameTid
		end
		if tid == Stid then
			return skill
		end
	end
end

function CraftingTool.GetItemId(tid, objectType)
	for i = 1, #CraftingTool.Craftables do
		if CraftingTool.Craftables[i].tid == tid and CraftingTool.Craftables[i].ObjectType == objectType then
			return i
		end
	end
end

function CraftingTool.AddSubItems(Mainslot, itemIndex, Height, partialHeight)
	local windowName = "CraftingToolWindow"
	local dialog = "CraftingToolSW"
	local parent = dialog.. "ScrollChildCont"
	
	local scale = WindowGetScale(windowName)
	
	local itemData = CraftingTool.Craftables[itemIndex]
	if not Height or partialHeight then
		Height = 0
	end
	local prevH = 0
	local subs = 0
	local prevSubs = 0
	
	local prevline = ""
	for i = 1, #itemData.Materials do
		
		local rnd = math.random(0,10000)
		local line = "CraftingToolsubLine" .. itemIndex .. rnd .. "N"..i
			
		if i == 1 then
			CreateWindowFromTemplate(line, "SubVLine", parent)
			WindowSetScale (line, scale)
			table.insert(CraftingTool.allSlots, line)
			WindowAddAnchor(line, "bottomleft", Mainslot, "topleft", 20, 0)
		else
			if prevSubs > 0 then
				local nline = ""
				local pLine = ""
				rnd = math.random(10001,100000)
				for k = 1, prevSubs+1 do
					
					nline = line .. rnd .. k
					CreateWindowFromTemplate(nline, "SubVLine_Long", parent)
					WindowSetScale (nline, scale)
					table.insert(CraftingTool.allSlots, nline)
					if  k == 1 then
						WindowAddAnchor(nline, "bottomleft", prevline, "topleft", 0, 0)
					else
						WindowAddAnchor(nline, "bottomleft", pLine, "topleft", 0, 0)
					end
					pLine =  nline
				end
				line = nline
			else
				CreateWindowFromTemplate(line, "SubVLine_Long", parent)
				WindowSetScale (line, scale)
				table.insert(CraftingTool.allSlots, line)
				WindowAddAnchor(line, "bottomleft", prevline, "topleft", 0, 0)
			end
			
		end
		CreateWindowFromTemplate(line .. "_h", "SubHLine", parent)
		WindowSetScale (line .. "_h", scale)
		table.insert(CraftingTool.allSlots, line .. "_h")
		WindowAddAnchor(line .. "_h", "bottomright", line, "bottomleft", 0, 0)
		
		prevline = line
		
		local slot = Mainslot .. "sub" .. i
		local prevSlot = Mainslot .. "sub" .. i -1
		local DataArea = slot .. "CraftData"
		
		CreateWindowFromTemplate(slot, "CraftItemTemplate", parent)
		WindowSetScale (slot, scale)
		local w, h = WindowGetDimensions(slot)
		
		Height = Height + h 
		
		table.insert(CraftingTool.allSlots, slot)
		table.insert(CraftingTool.materialSlots, slot)
		if i == 1 then
			WindowAddAnchor(slot, "bottomleft", Mainslot, "topleft", 40, 0)
		else
			WindowAddAnchor(slot, "bottomleft", prevSlot, "topleft", 0, prevH)
		end
		subs = subs +1
		
		if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont(slot .. "Name", "UO_DefaultText_ASIA_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText(slot .. "Name", FormatProperly(CraftingTool.GetStringFromTid(itemData.Materials[i].tid)))
		
		if not CraftingTool.GumpMaterials[itemData.Materials[i].tid] then
			continue
		end
		WindowSetId(slot, itemIndex)
		
		prevH = 0
		if not CraftingTool.ActiveMaterials[itemData.Materials[i].tid] then
			CraftingTool.ActiveMaterials[itemData.Materials[i].tid] = true
		end
			
		if  CraftingTool.GumpMaterials[itemData.Materials[i].tid].craftable then
			local itemId = CraftingTool.GetItemId(itemData.Materials[i].tid, CraftingTool.GumpMaterials[itemData.Materials[i].tid].objectType[1])
			
	
			local data = CraftingTool.Craftables[itemId]

			local skills = GetStringFromTid(data.mainSkill) ..  L" " .. data.minMain .. L"%" 
			if data.secondarySkill ~= "" then
				skills = skills .. L"\n" .. GetStringFromTid(data.secondarySkill) .. L" " .. data.minSecondary .. L"%" 
			end
			if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
				LabelSetFont(DataArea .. "Skills", "UO_DefaultText_ASIA_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end
			LabelSetText(DataArea .."Skills", FormatProperly(skills))
			
			WindowSetId(DataArea .."Skills", data.mainSkill)
			
			LabelSetText(slot .. "MakeLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5125))
			LabelSetTextColor(slot .. "MakeLabel", 0,152,0)
			LabelSetFont(slot .. "MakeNumberLabel", "font_verdana_bold_shadow_med2_12", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetText(slot .. "MakeNumberLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5126))
			LabelSetTextColor(slot .. "MakeNumberLabel", 0,152,254)
			LabelSetText(slot .. "MakeMaxLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5127))
			LabelSetTextColor(slot .. "MakeMaxLabel", 139,100,255)
			
			local success, canDo = CraftingTool.SuccessChance(slot, data)
			if success > 0 or canDo then
				CraftingTool.ToggleDisableMakeButton(slot, true)
			else
				CraftingTool.ToggleDisableMakeButton(slot, false)
			end
			
			if data.ObjectType ~= 0 and not data.DeedItem then
				local name, x, y, scale, newWidth, newHeight = RequestTileArt(data.ObjectType,200,200)
				scale = 1.5
				if newWidth * scale > 75 or newHeight * scale > 75 then
					for j = scale, 0.1, -0.1 do

						if newWidth * j <= 75 and newHeight * j <= 75 then
							scale = j
							break
						end
					end
				end
				DynamicImageSetTextureDimensions(slot .. "Icon", newWidth*scale, newHeight*scale)
				WindowSetDimensions(slot.. "Icon", newWidth*scale, newHeight*scale)
				DynamicImageSetTexture(slot .. "Icon", name, x, y )
				DynamicImageSetTextureScale(slot .. "Icon", scale)			
				DynamicImageSetCustomShader(slot .. "Icon", "UOSpriteUIShader", {data.HueID, data.ObjectType})
				WindowClearAnchors(slot .. "Icon")
				WindowAddAnchor(slot .. "Icon", "topleft", slot, "topleft", (80 - newWidth * scale) / 2, (80 - newHeight * scale) / 2)
			elseif data.DeedItem then
				local iconId = data.tid
				local name, x, y = GetIconData(iconId)
				local newWidth, newHeight = UOGetTextureSize("icon"..iconId)
				local scale = 1.5
				if newWidth * scale > 75 or newHeight * scale > 75 then
					for j = scale, 0.1, -0.1 do

						if newWidth * j <= 75 and newHeight * j <= 75 then
							scale = j
							break
						end
					end
				end
				DynamicImageSetTextureDimensions(slot .. "Icon", newWidth*scale, newHeight*scale)
				WindowSetDimensions(slot.. "Icon", newWidth*scale, newHeight*scale)
				DynamicImageSetTexture(slot .. "Icon", name, x, y )
				DynamicImageSetTextureScale(slot .. "Icon", scale)
				DynamicImageSetCustomShader(slot .. "Icon", "UOSpriteUIShader", {data.HueID, data.ObjectType})
				WindowClearAnchors(slot .. "Icon")
				WindowAddAnchor(slot .. "Icon", "topleft", slot, "topleft", (80 - newWidth * scale) / 2, (80 - newHeight * scale) / 2)
			end
			
			
			
			if #data.Materials > 0  and CraftingTool.SearchOptions["showSubMaterials"] then
				local h, s = CraftingTool.AddSubItems(slot, itemId, Height, true)
				prevH = h
				prevSubs = s
				subs = subs + s
				Height = Height + prevH
			else
				prevSubs = 0
			end
			if #data.Materials > 0 then
				for q = 1, #data.Materials do
					if not CraftingTool.ActiveMaterials[data.Materials[q].tid] then
						CraftingTool.ActiveMaterials[data.Materials[q].tid] = true
					end
				end
			end
		else
			if #CraftingTool.GumpMaterials[itemData.Materials[i].tid].objectType > 0 and CraftingTool.GumpMaterials[itemData.Materials[i].tid].objectType[1] ~= 0 then
				local name, x, y, scale, newWidth, newHeight = RequestTileArt(CraftingTool.GumpMaterials[itemData.Materials[i].tid].objectType[1],200,200)
				scale = 1.5
				if newWidth * scale > 75 or newHeight * scale > 75 then
					for j = scale, 0.1, -0.1 do

						if newWidth * j <= 75 and newHeight * j <= 75 then
							scale = j
							break
						end
					end
				end
				DynamicImageSetTextureDimensions(slot .. "Icon", newWidth*scale, newHeight*scale)
				WindowSetDimensions(slot.. "Icon", newWidth*scale, newHeight*scale)
				DynamicImageSetTexture(slot .. "Icon", name, x, y )
				DynamicImageSetTextureScale(slot .. "Icon", scale)
				
				local data = CraftingTool.Craftables[itemIndex]
				local tid = data.toolSkill
				if CraftingTool.CurrentMaterials[tid] then
					local mat = CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][1]]
					local mat2 = CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][2]]
					
					if CraftingTool.MaterialsIcon[tid][2] == 9908 then
						CraftingTool.GumpMaterials[1029905].hueID[1] = mat2.hue
					else
						CraftingTool.GumpMaterials[1029905].hueID[1] = -1
					end	
					
					if CraftingTool.MaterialsIcon[tid][1] == 7155 then
						CraftingTool.GumpMaterials[1027154].hueID[1] = mat.hue
						
					elseif CraftingTool.MaterialsIcon[tid][1] == 7131 then
						CraftingTool.GumpMaterials[1044041].hueID[1] = mat.hue
						CraftingTool.GumpMaterials[1044041].hueID[2] = mat.hue
						
					elseif CraftingTool.MaterialsIcon[tid][1] == 4199 then
						CraftingTool.GumpMaterials[1044462].hueID[1] = mat.hue
						CraftingTool.GumpMaterials[1044462].hueID[2] = mat.hue
						CraftingTool.GumpMaterials[1044462].hueID[3] = mat.hue
						CraftingTool.GumpMaterials[1044462].hueID[4] = mat.hue
						CraftingTool.GumpMaterials[1044462].hueID[5] = mat.hue
						CraftingTool.GumpMaterials[1044462].hueID[6] = mat.hue
					
					elseif CraftingTool.MaterialsIcon[tid][1] == 6009 then
						CraftingTool.GumpMaterials[1044607].hueID[1] = mat.hue
						
					else
						CraftingTool.GumpMaterials[1027154].hueID[1] = -1
						CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
						CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
						CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
						CraftingTool.GumpMaterials[1044462].hueID[2] = -1
						CraftingTool.GumpMaterials[1044462].hueID[3] = -1
						CraftingTool.GumpMaterials[1044462].hueID[4] = -1
						CraftingTool.GumpMaterials[1044462].hueID[5] = -1
						CraftingTool.GumpMaterials[1044462].hueID[6] = -1
						CraftingTool.GumpMaterials[1044607].hueID[1] = -1
					end
				else
					CraftingTool.GumpMaterials[1027154].hueID[1] = -1
					CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
					CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
					CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
					CraftingTool.GumpMaterials[1044462].hueID[2] = -1
					CraftingTool.GumpMaterials[1044462].hueID[3] = -1
					CraftingTool.GumpMaterials[1044462].hueID[4] = -1
					CraftingTool.GumpMaterials[1044462].hueID[5] = -1
					CraftingTool.GumpMaterials[1044462].hueID[6] = -1
					CraftingTool.GumpMaterials[1044607].hueID[1] = -1
				end
				
				local hue = CraftingTool.GumpMaterials[itemData.Materials[i].tid].hueID[1]
				if hue == -1 then
					hue = 0
				end				
				
				DynamicImageSetCustomShader(slot .. "Icon", "UOSpriteUIShader", {hue, CraftingTool.GumpMaterials[itemData.Materials[i].tid].objectType[1]})
				WindowClearAnchors(slot .. "Icon")
				WindowAddAnchor(slot .. "Icon", "topleft", slot, "topleft", (80 - newWidth * scale) / 2, (80 - newHeight * scale) / 2)
			end
			if (CraftingTool.GumpMaterials[itemData.Materials[i].tid].info) ~= 0 then
				local cliloc = CraftingTool.GumpMaterials[itemData.Materials[i].tid].info
				LabelSetText(slot .. "Info", UI.GetCliloc(SystemData.Settings.Language.type, cliloc))
			end
			WindowSetShowing(DataArea, false)
			WindowSetShowing(slot .. "Make", false)
			WindowSetShowing(slot .. "MakeNumber", false)
			WindowSetShowing(slot .. "MakeMax", false)
			prevSubs = 0
		end

	end
	return Height, subs
end


function CraftingTool.SearchCategory()
	local windowName = "CraftingToolWindow"
	local Ctid = CraftingTool.ComboToTid()
	
	local this = SystemData.ActiveWindow.name
	local Item = WindowGetParent(this)

	local id = WindowGetId(Item)
	
	CraftingTool.ClearItemList()
	
	
	for i = 1, #CraftingTool.Craftables do
		
		local success, canDo = CraftingTool.SuccessChance(nil, CraftingTool.Craftables[i])
--[[
		if not canDo and not CraftingTool.SearchOptions["showZeroSuccessItems"] then
			continue
		end
--]]
		if not Ctid or CraftingTool.Craftables[i].toolSkill ~= Ctid then
			continue
		end
		
		if CraftingTool.Craftables[i].Category == id then
			table.insert(CraftingTool.Items, i)
		end

	end
	LabelSetText(windowName .. "Total", ReplaceTokens(UI.GetCliloc(SystemData.Settings.Language.type, 5137), {WindowUtils.AddCommasToNumber(#CraftingTool.Items)}))
	CraftingTool.PopulateList()
	CraftingTool.OpenedCat = true
	CraftingTool.OpenedSearch = true
end


function CraftingTool.PopulateList()
	local windowName = "CraftingToolWindow"
	local dialog = "CraftingToolSW"
	local parent = dialog.. "ScrollChildCont"
	
	local scale = WindowGetScale(windowName)
	
	local Width, Height = WindowGetDimensions(parent)
	
	Height = 0
	WindowSetDimensions(parent, Width, Height )
	ScrollWindowUpdateScrollRect( "CraftingToolSW" ) 
	ScrollWindowSetOffset( "CraftingToolSW", 0 )
	
	local prevH = 0
	
	local starttime = EnhancePack.TimeSinceLogin
	
	for i = 1, #CraftingTool.Items do
		local slot = "CraftingToolItem" .. i
		
		local data = CraftingTool.Craftables[CraftingTool.Items[i]]
		local success, canDo = CraftingTool.SuccessChance(slot, data)
		if not canDo and not CraftingTool.SearchOptions["showZeroSuccessItems"] then
			continue
		end
		
		local prevSlot = "CraftingToolItem" .. i - 1
		local DataArea = slot .. "CraftData"
		local prevData = CraftingTool.Craftables[CraftingTool.Items[i-1]]
		
		
		
		
		CreateWindowFromTemplate(slot, "CraftItemTemplate", parent)
		WindowSetScale (slot, scale)
		local w, h = WindowGetDimensions(slot)
		
		Height = Height + h 
		
		table.insert(CraftingTool.allSlots, slot)
		table.insert(CraftingTool.mainItemSlots, slot)
		if i == 1 then
			WindowAddAnchor(slot, "topleft", parent, "topleft", 0, 0)
		else
			WindowAddAnchor(slot, "bottomleft", prevSlot, "topleft", 0, prevH)
		end
		
		
		if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont(slot .. "Name", "UO_DefaultText_ASIA_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText(slot .. "Name", FormatProperly(CraftingTool.GetStringFromTid(data.tid)))
		if DoesWindowNameExist(DataArea) then
			local skills = GetStringFromTid(data.mainSkill) ..  L" " .. data.minMain .. L"%" 
			if data.secondarySkill ~= "" then
				skills = skills .. L"\n" .. GetStringFromTid(data.secondarySkill) .. L" " .. data.minSecondary .. L"%" 
			end
			if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
				LabelSetFont(DataArea .. "Skills", "UO_DefaultText_ASIA_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end
			LabelSetText(DataArea .."Skills", FormatProperly(skills))
			
			
			
			LabelSetText(slot .. "MakeLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5125))
			LabelSetTextColor(slot .. "MakeLabel", 0,152,0)
			LabelSetFont(slot .. "MakeNumberLabel", "font_verdana_bold_shadow_med2_12", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			LabelSetText(slot .. "MakeNumberLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5126))
			LabelSetTextColor(slot .. "MakeNumberLabel", 0,152,254)
			LabelSetText(slot .. "MakeMaxLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5127))
			LabelSetTextColor(slot .. "MakeMaxLabel", 139,100,255)
			

			if success > 0 then
				CraftingTool.ToggleDisableMakeButton(slot, true)
			else
				CraftingTool.ToggleDisableMakeButton(slot, false)
			end
			if data.ObjectType ~= 0 and not data.DeedItem then
				local name, x, y, scale, newWidth, newHeight = RequestTileArt(data.ObjectType,200,200)
				scale = 1.5
				if newWidth * scale > 75 or newHeight * scale > 75 then
					for j = scale, 0.1, -0.1 do

						if newWidth * j <= 75 and newHeight * j <= 75 then
							scale = j
							break
						end
					end
				end
				DynamicImageSetTextureDimensions(slot .. "Icon", newWidth*scale, newHeight*scale)
				WindowSetDimensions(slot.. "Icon", newWidth*scale, newHeight*scale)
				DynamicImageSetTexture(slot .. "Icon", name, x, y )
				DynamicImageSetTextureScale(slot .. "Icon", scale)
				DynamicImageSetCustomShader(slot .. "Icon", "UOSpriteUIShader", {data.HueID, data.ObjectType})
				WindowClearAnchors(slot .. "Icon")
				WindowAddAnchor(slot .. "Icon", "topleft", slot, "topleft", (80 - newWidth * scale) / 2, (80 - newHeight * scale) / 2)
			elseif data.DeedItem then
				local iconId = data.tid
				local name, x, y = GetIconData(iconId)
				local newWidth, newHeight = UOGetTextureSize("icon"..iconId)
				local scale = 1.5
				if newWidth * scale > 75 or newHeight * scale > 75 then
					for j = scale, 0.1, -0.1 do

						if newWidth * j <= 75 and newHeight * j <= 75 then
							scale = j
							break
						end
					end
				end
				DynamicImageSetTextureDimensions(slot .. "Icon", newWidth*scale, newHeight*scale)
				WindowSetDimensions(slot.. "Icon", newWidth*scale, newHeight*scale)
				DynamicImageSetTexture(slot .. "Icon", name, x, y )
				DynamicImageSetTextureScale(slot .. "Icon", scale)
				DynamicImageSetCustomShader(slot .. "Icon", "UOSpriteUIShader", {data.HueID, data.ObjectType})
				WindowClearAnchors(slot .. "Icon")
				WindowAddAnchor(slot .. "Icon", "topleft", slot, "topleft", (80 - newWidth * scale) / 2, (80 - newHeight * scale) / 2)
			end
			
			WindowSetId(slot, CraftingTool.Items[i])
			
			if #data.Materials > 0 and CraftingTool.SearchOptions["showMaterials"] then
				for i = 1, #data.Materials do
					if not CraftingTool.ActiveMaterials[data.Materials[i].tid] then
						CraftingTool.ActiveMaterials[data.Materials[i].tid] = true
					end
				end
				prevH = CraftingTool.AddSubItems(slot, CraftingTool.Items[i]) +(10 * scale)
				Height = Height + prevH
			end
		end
	
	end
	WindowSetDimensions(parent, Width, Height )
	ScrollWindowUpdateScrollRect( "CraftingToolSW" ) 
	ScrollWindowSetOffset( "CraftingToolSW", 0 )
	--Debug.Print(EnhancePack.TimeSinceLogin - starttime)
end

function CraftingTool.ClearItemList()
	if not DONOTclearSearch then
		CraftingTool.Items = {}
	end
	for i = #CraftingTool.allSlots, 1, -1 do
		if DoesWindowNameExist(CraftingTool.allSlots[i]) then
			DestroyWindow(CraftingTool.allSlots[i])
		end
	end
	CraftingTool.allSlots = {}
	CraftingTool.materialSlots = {}
	CraftingTool.mainItemSlots = {}
	LabelSetText( "CraftingToolWindowTotal", L"")
	CraftingTool.ActiveMaterials = {}
end

function CraftingTool.ToggleDisableSearch(flag)
	local windowName = "CraftingToolWindow"
	if flag ~= nil then
		if not flag then
			LabelSetTextColor(windowName .. "SearchText", 81,81,72)
			WindowSetTintColor(windowName .. "NextButton", 81,81,72)
			WindowSetTintColor(windowName .. "CancelButton", 81,81,72)
			WindowSetTintColor(windowName .. "SearchBoxBGFrame", 81,81,72)
			WindowSetHandleInput(windowName .. "SearchBox", false)
			ButtonSetDisabledFlag(windowName .. "NextButton", true)
			ButtonSetDisabledFlag(windowName .. "CancelButton", true)
			WindowSetShowing(windowName .. "DisableSW", true)
		else
			LabelSetTextColor(windowName .. "SearchText", 255,204,0)
			WindowSetTintColor(windowName .. "NextButton", 255,255,255)
			WindowSetTintColor(windowName .. "CancelButton", 255,255,255)
			WindowSetTintColor(windowName .. "SearchBoxBGFrame", 255,255,255)
			WindowSetHandleInput(windowName .. "SearchBox", true)
			ButtonSetDisabledFlag(windowName .. "NextButton", false)
			ButtonSetDisabledFlag(windowName .. "CancelButton", false)
			WindowSetShowing(windowName .. "DisableSW", false)
		end
	else
		if WindowGetHandleInput(windowName .. "SearchBox") then
			LabelSetTextColor(windowName .. "SearchText", 81,81,72)
			WindowSetTintColor(windowName .. "NextButton", 81,81,72)
			WindowSetTintColor(windowName .. "CancelButton", 81,81,72)
			WindowSetTintColor(windowName .. "SearchBoxBGFrame", 81,81,72)
			WindowSetHandleInput(windowName .. "SearchBox", false)
			ButtonSetDisabledFlag(windowName .. "NextButton", true)
			ButtonSetDisabledFlag(windowName .. "CancelButton", true)
			WindowSetShowing(windowName .. "DisableSW", true)
		else
			LabelSetTextColor(windowName .. "SearchText", 255,204,0)
			WindowSetTintColor(windowName .. "NextButton", 255,255,255)
			WindowSetTintColor(windowName .. "CancelButton", 255,255,255)
			WindowSetTintColor(windowName .. "SearchBoxBGFrame", 255,255,255)
			WindowSetHandleInput(windowName .. "SearchBox", true)
			ButtonSetDisabledFlag(windowName .. "NextButton", false)
			ButtonSetDisabledFlag(windowName .. "CancelButton", false)
			WindowSetShowing(windowName .. "DisableSW", false)
		end
	end
end

function CraftingTool.ToggleDisableButton(button, flag)
	if flag ~= nil then
		if flag then
			if DoesWindowNameExist(button .. "Icon") then
				DynamicImageSetCustomShader(button .. "Icon", "UOSpriteUIShader", {0, WindowGetId(button .. "Icon")})
			end
			LabelSetTextColor(button .. "Label", 255,204,0)
			ButtonSetDisabledFlag(button, false)
			WindowSetHandleInput(button, true)
		else
			if DoesWindowNameExist(button .. "Icon") then
				DynamicImageSetCustomShader(button .. "Icon", "UOSpriteUIShader", {854, WindowGetId(button .. "Icon")})
			end
			LabelSetTextColor(button .. "Label", 81,81,72)
			ButtonSetDisabledFlag(button, true)
			WindowSetHandleInput(button, false)
		end
	else
		if ButtonGetDisabledFlag(button) then
			if DoesWindowNameExist(button .. "Icon") then
				DynamicImageSetCustomShader(button .. "Icon", "UOSpriteUIShader", {0, WindowGetId(button .. "Icon")})
			end
			LabelSetTextColor(button .. "Label", 255,204,0)
			ButtonSetDisabledFlag(button, false)
			WindowSetHandleInput(button, true)
		else
			if DoesWindowNameExist(button .. "Icon") then
				DynamicImageSetCustomShader(button .. "Icon", "UOSpriteUIShader", {854, WindowGetId(button .. "Icon")})
			end
			LabelSetTextColor(button .. "Label", 81,81,72)
			ButtonSetDisabledFlag(button, true)
			WindowSetHandleInput(button, false)
		end
	end
end

function CraftingTool.ToggleDisableMakeButton(slot, flag)
	if flag ~= nil then
		if flag then
			
			LabelSetTextColor(slot .. "MakeLabel", 0,152,0)
			ButtonSetDisabledFlag(slot .. "Make", false)
			WindowSetHandleInput(slot .. "Make", true)
			
			LabelSetTextColor(slot .. "MakeNumberLabel", 0,152,254)
			ButtonSetDisabledFlag(slot .. "MakeNumber", false)
			WindowSetHandleInput(slot .. "MakeNumber", true)
			
			LabelSetTextColor(slot .. "MakeMaxLabel", 139,100,255)
			ButtonSetDisabledFlag(slot .. "MakeMax", false)
			WindowSetHandleInput(slot .. "MakeMax", true)
		else			
			LabelSetTextColor(slot .. "MakeLabel", 81,81,72)
			ButtonSetDisabledFlag(slot .. "Make", true)
			WindowSetHandleInput(slot .. "Make", false)
			
			LabelSetTextColor(slot .. "MakeNumberLabel", 81,81,72)
			ButtonSetDisabledFlag(slot .. "MakeNumber", true)
			WindowSetHandleInput(slot .. "MakeNumber", false)
			
			LabelSetTextColor(slot .. "MakeMaxLabel",81,81,72)
			ButtonSetDisabledFlag(slot .. "MakeMax", true)
			WindowSetHandleInput(slot .. "MakeMax", false)
		end
	else
		if ButtonGetDisabledFlag(slot .. "Make") then
			
			LabelSetTextColor(slot .. "MakeLabel", 0,152,0)
			ButtonSetDisabledFlag(slot .. "MakeLabel", false)
			WindowSetHandleInput(slot .. "MakeLabel", true)
			
			LabelSetTextColor(slot .. "MakeNumberLabel", 0,152,254)
			ButtonSetDisabledFlag(slot .. "MakeNumber", false)
			WindowSetHandleInput(slot .. "MakeNumber", true)
			
			LabelSetTextColor(slot .. "MakeMaxLabel", 139,100,255)
			ButtonSetDisabledFlag(slot .. "MakeMax", false)
			WindowSetHandleInput(slot .. "MakeMax", true)
		else
			
			LabelSetTextColor(slot .. "MakeLabel", 81,81,72)
			ButtonSetDisabledFlag(slot .. "Make", true)
			WindowSetHandleInput(slot .. "Make", false)
			
			LabelSetTextColor(slot .. "MakeNumberLabel", 81,81,72)
			ButtonSetDisabledFlag(slot .. "MakeNumber", true)
			WindowSetHandleInput(slot .. "MakeNumber", false)
			
			LabelSetTextColor(slot .. "MakeMaxLabel",81,81,72)
			ButtonSetDisabledFlag(slot .. "MakeMax", true)
			WindowSetHandleInput(slot .. "MakeMax", false)
		end
	end
end

function CraftingTool.DisableWarning()
	local windowName = "CraftingToolWindow"
	LabelSetTextColor(windowName .. "WarningLabel", 81,81,72)
	LabelSetText(windowName .. "WarningValue", L"")
	CraftingTool.WarningActive = false
end

function CraftingTool.SendWarning(text, time, override, nosound)
	local windowName = "CraftingToolWindow"
	if not time then
		time = 20
	end
	if CraftingTool.WarningActive and not override then
		if LabelGetText(windowName .. "WarningValue") == text then
			
			CraftingTool.WarningEndTime = EnhancePack.TimeSinceLogin + time
		end
		return
	end
	
	LabelSetTextColor(windowName .. "WarningLabel", EnhancePack.DANGER_COLOR.r,EnhancePack.DANGER_COLOR.g,EnhancePack.DANGER_COLOR.b)
	LabelSetText(windowName .. "WarningValue", text)
	CraftingTool.WarningEndTime = EnhancePack.TimeSinceLogin + time
	if not nosound then
		local prefix = "m_"
		if (EnhancePack.Female) then
			prefix = "f_"
		end
		PlaySound(0,prefix .. "sigh.wav", 0)
	end
	CraftingTool.WarningActive = true
end

function CraftingTool.MaterialsTooltip()
	if CraftingTool.SearchOptions["showMaterials"] then
		return
	end
	
	local win = SystemData.ActiveWindow.name
	win = WindowGetParent(win)
	if string.find(win, "Info") then
		win = WindowGetParent(win)
	end
	
	local id = WindowGetId(win)
	if id == 0 or not #CraftingTool.Craftables[id].Materials or #CraftingTool.Craftables[id].Materials <= 0 then
		return
	end
	
	local ttWind = "CraftTooltip"
	if DoesWindowNameExist(ttWind) then
		DestroyWindow(ttWind)
	end
	CreateWindowFromTemplate(ttWind, "CraftTooltipTemplate", "Root")
	LabelSetText(ttWind .. "Title", UI.GetCliloc(SystemData.Settings.Language.type, 7010))
	

	local w, h = WindowGetDimensions(ttWind)
	WindowSetDimensions(ttWind, w,  10)
	
	local height = 25

	for j = 1, #CraftingTool.Craftables[id].Materials do
		local slot = ttWind .. "Item" .. j
		local prevSlot = ttWind .. "Item" .. j - 1
		CreateWindowFromTemplate(slot, "CraftTooltipItemTemplate", ttWind)

		local tidd = CraftingTool.Craftables[id].Materials[j].tid
		
		if not CraftingTool.ActiveMaterials[tidd] then
			CraftingTool.ActiveMaterials[tidd] = true
		end
			
		if j == 1 then
			WindowAddAnchor(slot, "bottomleft", ttWind .. "Title", "topleft", 0 ,25)
			height = height + 40
		else
			WindowAddAnchor(slot, "bottomleft", prevSlot, "topleft", 0, 0)
		end
		w, h = WindowGetDimensions(slot)
		height = height + h
		
		
		local material = CraftingTool.GumpMaterials[tidd]
		
		local name, x, y, scale, newWidth, newHeight = RequestTileArt(material.objectType[1],56,56)
		DynamicImageSetTextureDimensions(slot .. "Icon", newWidth, newHeight)
		DynamicImageSetTexture(slot .. "Icon", name, x, y )
		DynamicImageSetTextureScale(slot .. "Icon", scale)
		WindowSetDimensions(slot.. "Icon", newWidth, newHeight)
		
		WindowClearAnchors(slot .. "Icon")
		WindowAddAnchor(slot .. "Icon", "topleft", slot, "topleft", (56 - newWidth) / 2, (56 - newHeight) / 2)
		
		local data = CraftingTool.Craftables[id]
		local tid = data.toolSkill
		if CraftingTool.CurrentMaterials[tid] then
			local mat = CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][1]]
			local mat2 = CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][2]]
			
			if CraftingTool.MaterialsIcon[tid][2] == 9908 then
				CraftingTool.GumpMaterials[1029905].hueID[1] = mat2.hue
			else
				CraftingTool.GumpMaterials[1029905].hueID[1] = -1
			end	
			
			if CraftingTool.MaterialsIcon[tid][1] == 7155 then
				CraftingTool.GumpMaterials[1027154].hueID[1] = mat.hue
				
			elseif CraftingTool.MaterialsIcon[tid][1] == 7131 then
				CraftingTool.GumpMaterials[1044041].hueID[1] = mat.hue
				CraftingTool.GumpMaterials[1044041].hueID[2] = mat.hue
				
			elseif CraftingTool.MaterialsIcon[tid][1] == 4199 then
				CraftingTool.GumpMaterials[1044462].hueID[1] = mat.hue
				CraftingTool.GumpMaterials[1044462].hueID[2] = mat.hue
				CraftingTool.GumpMaterials[1044462].hueID[3] = mat.hue
				CraftingTool.GumpMaterials[1044462].hueID[4] = mat.hue
				CraftingTool.GumpMaterials[1044462].hueID[5] = mat.hue
				CraftingTool.GumpMaterials[1044462].hueID[6] = mat.hue
			
			elseif CraftingTool.MaterialsIcon[tid][1] == 6009 then
				CraftingTool.GumpMaterials[1044607].hueID[1] = mat.hue
				
			else
				CraftingTool.GumpMaterials[1027154].hueID[1] = -1
				CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
				CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
				CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
				CraftingTool.GumpMaterials[1044462].hueID[2] = -1
				CraftingTool.GumpMaterials[1044462].hueID[3] = -1
				CraftingTool.GumpMaterials[1044462].hueID[4] = -1
				CraftingTool.GumpMaterials[1044462].hueID[5] = -1
				CraftingTool.GumpMaterials[1044462].hueID[6] = -1
				CraftingTool.GumpMaterials[1044607].hueID[1] = -1
			end
		else
			CraftingTool.GumpMaterials[1027154].hueID[1] = -1
			CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
			CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
			CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
			CraftingTool.GumpMaterials[1044462].hueID[2] = -1
			CraftingTool.GumpMaterials[1044462].hueID[3] = -1
			CraftingTool.GumpMaterials[1044462].hueID[4] = -1
			CraftingTool.GumpMaterials[1044462].hueID[5] = -1
			CraftingTool.GumpMaterials[1044462].hueID[6] = -1
			CraftingTool.GumpMaterials[1044607].hueID[1] = -1
		end
		
		local hue = material.hueID[1]
		if hue == -1 then
			hue = 0
		end				
		
		DynamicImageSetCustomShader(slot .. "Icon", "UOSpriteUIShader", {hue, material.objectType[1]})
		
		local amount = CraftingTool.Craftables[id].Materials[j].amount
		local count = 0
		if material.quantity and type(material.quantity) == "number"  then
			count = material.quantity
		else
			count = material.quantity[tid] or 0
			
		end
		
		local str = L""
		if count and amount then
			if amount == "N" then
				str = L"\nALL"
			else
				str = L"\n" .. count .. L"/" .. amount
			end
		end
		
		if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont(slot .. "Name", "UO_DefaultText_ASIA_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		if amount ~= "N" and count < amount then
			LabelSetTextColor(slot .. "Name", EnhancePack.DANGER_COLOR.r,EnhancePack.DANGER_COLOR.g,EnhancePack.DANGER_COLOR.b)
		else
			LabelSetTextColor(slot .. "Name", EnhancePack.ESSENCE_COLOR.r,EnhancePack.ESSENCE_COLOR.g,EnhancePack.ESSENCE_COLOR.b)
		end
		LabelSetText(slot .. "Name", FormatProperly(CraftingTool.GetStringFromTid(tidd)) .. str)
		
	
	end
	w, h = WindowGetDimensions(ttWind)
	WindowSetDimensions(ttWind, w,  height)

	WindowSetShowing( ttWind, true )
	WindowAddAnchor(ttWind, "topright", win .. "Name", "topleft", 0, -10 )
end

function CraftingTool.DeleteTooltip()
	if DoesWindowNameExist("CraftTooltip") then
		DestroyWindow("CraftTooltip")
	end
end

function CraftingTool.ButtonsTooltip()
	local wind = string.gsub(SystemData.ActiveWindow.name, "Label", "")
	wind = string.gsub(wind, "Icon", "")
	if WindowGetId(wind) ~= 0 and not ButtonGetDisabledFlag(wind) then
		if WindowGetId(wind) < 100000 then
			Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, WindowGetId(wind)))
			Tooltips.Finalize()
			Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
		else
			Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,   ItemsInfo.Descriptions[GetStringFromTid(WindowGetId(wind))])
			Tooltips.Finalize()
			Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
		end
		
	end
end

function CraftingTool.MouseOverEnd()
	if( DoesWindowExist("MaterialInfo") ) then
		DestroyWindow("MaterialInfo")
	end
end


function CraftingTool.ChangeActiveSkill()
	local windowName = "CraftingToolWindow"

	local tid = CraftingTool.ComboToTid()
	if not tid or tid == 0 then
		for i = 1, #CraftingTool.Buttons do
			if DoesWindowNameExist(CraftingTool.Buttons[i]) then
				CraftingTool.ToggleDisableButton(CraftingTool.Buttons[i], CraftingTool.ButtonStatus["Default"][i])
			end
		end
		if CraftingTool.SearchOptions["showSkillsAvailable"] and CraftingTool.SearchOptions["showSkillsWithTool"] then
			CraftingTool.SendWarning(UI.GetCliloc(SystemData.Settings.Language.type, 7008), 5, true, true)
		elseif CraftingTool.SearchOptions["showSkillsAvailable"] then
			CraftingTool.SendWarning(UI.GetCliloc(SystemData.Settings.Language.type, 7009), 5, true, true)
		end
		CraftingTool.ClearItemList()
		return
	end
	CraftingTool.ComboData.CurrentSelection = ComboBoxGetSelectedMenuItem( windowName .. "ActiveSkillCombo" )
	CraftingTool.ComboData.CurrentSelectionTid = tid

	for i = 1, #CraftingTool.Buttons do
		if DoesWindowNameExist(CraftingTool.Buttons[i]) then
			CraftingTool.ToggleDisableButton(CraftingTool.Buttons[i], CraftingTool.ButtonStatus[tid][i])
		end
	end
	
	--CraftingTool.LastSkill[currShard][playerID] = sel
	
	if CraftingTool.CurrentMaterials[tid] then
		local mat = CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][1]]
		local mat2 = CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][2]]
		
		if CraftingTool.MaterialsIcon[tid][2] == 9908 then
			CraftingTool.GumpMaterials[1029905].hueID[1] = mat2.hue
		else
			CraftingTool.GumpMaterials[1029905].hueID[1] = -1
		end	
		
		if CraftingTool.MaterialsIcon[tid][1] == 7155 then
			CraftingTool.GumpMaterials[1027154].hueID[1] = mat.hue
			
		elseif CraftingTool.MaterialsIcon[tid][1] == 7131 then
			CraftingTool.GumpMaterials[1044041].hueID[1] = mat.hue
			CraftingTool.GumpMaterials[1044041].hueID[2] = mat.hue
			
		elseif CraftingTool.MaterialsIcon[tid][1] == 4199 then
			CraftingTool.GumpMaterials[1044462].hueID[1] = mat.hue
			CraftingTool.GumpMaterials[1044462].hueID[2] = mat.hue
			CraftingTool.GumpMaterials[1044462].hueID[3] = mat.hue
			CraftingTool.GumpMaterials[1044462].hueID[4] = mat.hue
			CraftingTool.GumpMaterials[1044462].hueID[5] = mat.hue
			CraftingTool.GumpMaterials[1044462].hueID[6] = mat.hue
		
		elseif CraftingTool.MaterialsIcon[tid][1] == 6009 then
			CraftingTool.GumpMaterials[1044607].hueID[1] = mat.hue
			
		else
			CraftingTool.GumpMaterials[1027154].hueID[1] = -1
			CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
			CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
			CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
			CraftingTool.GumpMaterials[1044462].hueID[2] = -1
			CraftingTool.GumpMaterials[1044462].hueID[3] = -1
			CraftingTool.GumpMaterials[1044462].hueID[4] = -1
			CraftingTool.GumpMaterials[1044462].hueID[5] = -1
			CraftingTool.GumpMaterials[1044462].hueID[6] = -1
			CraftingTool.GumpMaterials[1044607].hueID[1] = -1
		end
	else
		CraftingTool.GumpMaterials[1027154].hueID[1] = -1
		CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
		CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
		CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
		CraftingTool.GumpMaterials[1044462].hueID[2] = -1
		CraftingTool.GumpMaterials[1044462].hueID[3] = -1
		CraftingTool.GumpMaterials[1044462].hueID[4] = -1
		CraftingTool.GumpMaterials[1044462].hueID[5] = -1
		CraftingTool.GumpMaterials[1044462].hueID[6] = -1
		CraftingTool.GumpMaterials[1044607].hueID[1] = -1
	end
	
	
	
	if (#CraftingTool.Items <= 0 or CraftingTool.OpenedCat) and not CraftingTool.OpenedLast and not CraftingTool.OpenedRecipe and not CraftingTool.OpenedSearch then
		
		CraftingTool.LoadCategories()

		
	end
end

function CraftingTool.Update(timepassed)
	if not CraftingTool.Initialized then
		return
	end
	CraftingTool.delta = CraftingTool.delta + timepassed
	if CraftingTool.delta >= 0.5 then
		CraftingTool.delta = 0
		local ok, err = pcall( CraftingTool.updateToolData, timePassed)
		EnhancePack.ErrorTracker(ok, err)
		
		local ok, err = pcall( CraftingTool.updateSkillData, timePassed)
		EnhancePack.ErrorTracker(ok, err)
	end
	if EnhancePack.TimeSinceLogin > CraftingTool.WarningEndTime then
		CraftingTool.WarningEndTime = 0
		CraftingTool.DisableWarning()
	end
end

function CraftingTool.updateSkillData(timePassed)
	local windowName = "CraftingToolWindow"
	local sid = CraftingTool.ComboToSkillId()
	if sid then
		local skillId = sid
		local serverId = WindowData.SkillsCSV[skillId].ServerId
		LabelSetText(windowName .. "SkillLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5107))
		LabelSetText(windowName .. "SkillValue", SkillsWindow.FormatSkillValue(WindowData.SkillDynamicData[serverId].TempSkillValue) .. L"%")
	else
		LabelSetText(windowName .. "SkillLabel", L"")
		LabelSetText(windowName .. "SkillValue", L"")
	end
end

function CraftingTool.updateToolData(timePassed)
	local windowName = "CraftingToolWindow"
	for key, value in pairs(CraftingTool.LoadedTools) do
		if not DoesPlayerHaveItem(CraftingTool.LoadedTools[key].id) then
			CraftingTool.LoadedTools[key].id = 0
			CraftingTool.LoadedTools[key].uses = 0
		end
	end
	if #CraftingTool.LastItems > 0 then
		CraftingTool.ToggleDisableButton(windowName .. "Latest", true)
	else
		CraftingTool.ToggleDisableButton(windowName .. "Latest", false)
	end
	EnhancePack.ScanQuantities()
	CraftingTool.SearchTools()
	CraftingTool.CountMaterials( )
	CraftingTool.UpdateMaterialsInList( )
	CraftingTool.UpdateMaxCraftInList( )
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()

	if tid and tid ~= 0 then
		
		local tool = CraftingTool.LoadedTools[tid].id
		local uses = CraftingTool.LoadedTools[tid].uses
		local totalUses = CraftingTool.LoadedTools[tid].totalUses
		
		if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont(windowName .. "ToolType", "UO_DefaultText_ASIA_14", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		
		LabelSetText(windowName .. "ToolType", L"(" .. FormatProperly(GetStringFromTid(CraftingTool.Toolkit[tid])) .. L")")
		local R,G,B = HueRGBAValue(CraftingTool.Materials[CraftingTool.Toolkit[tid]].hue)
		LabelSetTextColor(windowName .. "ToolType", R,G,B)
		
		if uses and uses > 0 then
			LabelSetText(windowName .. "ToolLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5108))
			LabelSetText(windowName .. "ToolValue", towstring(EnhancePack.Knumber(uses)) )

			LabelSetText(windowName .. "AllToolLabel", UI.GetCliloc(SystemData.Settings.Language.type, 7020))
			LabelSetText(windowName .. "AllToolValue", towstring(EnhancePack.Knumber(totalUses)))


			if CraftingTool.GumpRequest ~= "countRecipes" then
				for i = 1, #CraftingTool.Buttons do
					if DoesWindowNameExist(CraftingTool.Buttons[i]) then
						CraftingTool.ToggleDisableButton(CraftingTool.Buttons[i], CraftingTool.ButtonStatus[tid][i])
					end
				end
			end
			if LabelGetText(windowName .. "WarningValue") == UI.GetCliloc(SystemData.Settings.Language.type, 5118) then
				CraftingTool.DisableWarning()
			end
		else
			LabelSetText(windowName .. "ToolLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5108))
			LabelSetText(windowName .. "ToolValue", L"0")
			CraftingTool.SendWarning(UI.GetCliloc(SystemData.Settings.Language.type, 5118), 5, false, true)
			CraftingTool.ToggleDisableSearch(true)
			if CraftingTool.GumpRequest ~= "countRecipes" then
				for i = 1, #CraftingTool.Buttons do
					if DoesWindowNameExist(CraftingTool.Buttons[i]) then
						CraftingTool.ToggleDisableButton(CraftingTool.Buttons[i], CraftingTool.ButtonStatus["Default"][i])
					end
				end
			end
		end

		local btnName = "Materials1"
		if (CraftingTool.MaterialsIcon[tid] and CraftingTool.MaterialsIcon[tid][1]) then
			local name, x, y, scale, newWidth, newHeight = RequestTileArt(CraftingTool.MaterialsIcon[tid][1],50,50)
			scale = 0.9
			WindowSetId(windowName .. btnName .. "Icon", CraftingTool.MaterialsIcon[tid][1])
			DynamicImageSetTextureDimensions(windowName .. btnName .. "Icon", newWidth *scale, newHeight*scale)
			WindowSetDimensions(windowName .. btnName .. "Icon", newWidth*scale, newHeight*scale)
			DynamicImageSetTexture(windowName .. btnName .. "Icon", name, x, y )
			DynamicImageSetTextureScale(windowName .. btnName .. "Icon", scale)
			DynamicImageSetCustomShader(windowName .. btnName .. "Icon", "UOSpriteUIShader", {CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][1]].hue, CraftingTool.MaterialsIcon[tid][1]})
			if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
				LabelSetFont(windowName .. "Materials1Label", "UO_DefaultText_ASIA_20", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			else
				LabelSetFont(windowName .. "Materials1Label", "font_verdana_bold_shadow_med2_11", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end
			LabelSetText(windowName .. btnName .. "Label", FormatProperly(GetStringFromTid(CraftingTool.CurrentMaterials[tid][1])))
			WindowSetId(windowName .. btnName, CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][1]].infoCliloc)
			LabelSetText(windowName .. "MaterialsLabel", UI.GetCliloc(SystemData.Settings.Language.type, 5109))
			if not WindowGetShowing(windowName .. btnName) then
				WindowSetShowing(windowName .. btnName, true)
			end
		else
			LabelSetText(windowName .. "MaterialsLabel", L"")
			WindowSetShowing(windowName .. btnName, false)
		end
		
		btnName = "Materials2"
		if (CraftingTool.MaterialsIcon[tid] and CraftingTool.MaterialsIcon[tid][2]) then
			local name, x, y, scale, newWidth, newHeight = RequestTileArt(CraftingTool.MaterialsIcon[tid][2],50,50)
			scale = 0.9
			WindowSetId(windowName .. btnName .. "Icon", CraftingTool.MaterialsIcon[tid][2])
			DynamicImageSetTextureDimensions(windowName .. btnName .. "Icon", newWidth *scale, newHeight*scale)
			WindowSetDimensions(windowName .. btnName .. "Icon", newWidth*scale, newHeight*scale)
			DynamicImageSetTexture(windowName .. btnName .. "Icon", name, x, y )
			DynamicImageSetTextureScale(windowName .. btnName .. "Icon", scale)
			DynamicImageSetCustomShader(windowName .. btnName .. "Icon", "UOSpriteUIShader", {CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][2]].hue, CraftingTool.MaterialsIcon[tid][2]})
			
			if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
				LabelSetFont(windowName .. "Materials2Label", "UO_DefaultText_ASIA_20", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			else
				LabelSetFont(windowName .. "Materials2Label", "font_verdana_bold_shadow_med2_11", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end
			LabelSetText(windowName .. btnName .. "Label", FormatProperly(GetStringFromTid(CraftingTool.CurrentMaterials[tid][2])))
			WindowSetId(windowName .. btnName, CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][2]].infoCliloc)
			if not WindowGetShowing(windowName .. btnName) then
				WindowSetShowing(windowName .. btnName, true)
			end
		else
			WindowSetShowing(windowName .. btnName, false)
		end
	end
end

function CraftingTool.UpdateMaterialsInList( )
	for i = #CraftingTool.materialSlots, 1, -1 do
		local slot = CraftingTool.materialSlots[i]
		if DoesWindowNameExist(slot) then
			local id = WindowGetId(slot)
			if id == 0 then
				continue
			end
			
			local Stid = CraftingTool.Craftables[id].toolSkill
			if CraftingTool.CurrentMaterials[Stid] then
				
				local mat = CraftingTool.Materials[CraftingTool.CurrentMaterials[Stid][1]]
				local mat2 = CraftingTool.Materials[CraftingTool.CurrentMaterials[Stid][2]]

				if CraftingTool.MaterialsIcon[Stid][2] == 9908 then
					CraftingTool.GumpMaterials[1029905].hueID[1] = mat2.hue
				else
					CraftingTool.GumpMaterials[1029905].hueID[1] = -1
				end	
				
				if CraftingTool.MaterialsIcon[Stid][1] == 7155 then
					CraftingTool.GumpMaterials[1027154].hueID[1] = mat.hue
					
				elseif CraftingTool.MaterialsIcon[Stid][1] == 7131 then
					CraftingTool.GumpMaterials[1044041].hueID[1] = mat.hue
					CraftingTool.GumpMaterials[1044041].hueID[2] = mat.hue
					
				elseif CraftingTool.MaterialsIcon[Stid][1] == 4199 then
					CraftingTool.GumpMaterials[1044462].hueID[1] = mat.hue
					CraftingTool.GumpMaterials[1044462].hueID[2] = mat.hue
					CraftingTool.GumpMaterials[1044462].hueID[3] = mat.hue
					CraftingTool.GumpMaterials[1044462].hueID[4] = mat.hue
					CraftingTool.GumpMaterials[1044462].hueID[5] = mat.hue
					CraftingTool.GumpMaterials[1044462].hueID[6] = mat.hue
				
				elseif CraftingTool.MaterialsIcon[Stid][1] == 6009 then
					CraftingTool.GumpMaterials[1044607].hueID[1] = mat.hue
					
				else
					CraftingTool.GumpMaterials[1027154].hueID[1] = -1
					CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
					CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
					CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
					CraftingTool.GumpMaterials[1044462].hueID[2] = -1
					CraftingTool.GumpMaterials[1044462].hueID[3] = -1
					CraftingTool.GumpMaterials[1044462].hueID[4] = -1
					CraftingTool.GumpMaterials[1044462].hueID[5] = -1
					CraftingTool.GumpMaterials[1044462].hueID[6] = -1
					CraftingTool.GumpMaterials[1044607].hueID[1] = -1
				end
			else
				CraftingTool.GumpMaterials[1027154].hueID[1] = -1
				CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
				CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
				CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
				CraftingTool.GumpMaterials[1044462].hueID[2] = -1
				CraftingTool.GumpMaterials[1044462].hueID[3] = -1
				CraftingTool.GumpMaterials[1044462].hueID[4] = -1
				CraftingTool.GumpMaterials[1044462].hueID[5] = -1
				CraftingTool.GumpMaterials[1044462].hueID[6] = -1
				CraftingTool.GumpMaterials[1044607].hueID[1] = -1
			end
			
			
			local amount = 0
			for j = 1, #CraftingTool.Craftables[id].Materials do
				local name = wstring.lower(LabelGetText(slot .. "Name"))
				local tid = wstring.lower(CraftingTool.GetStringFromTid(CraftingTool.Craftables[id].Materials[j].tid))
				if name == tid then
					tid = CraftingTool.Craftables[id].Materials[j].tid
					amount = CraftingTool.Craftables[id].Materials[j].amount
					id = tid
					break
				end
			end
			
			if not CraftingTool.ActiveMaterials[id] then
				CraftingTool.ActiveMaterials[id] = true
			end
			local hue = CraftingTool.GumpMaterials[id].hueID[1]
			if hue == -1 then
				hue = 0
			end
			DynamicImageSetCustomShader(slot .. "Icon", "UOSpriteUIShader", {hue, CraftingTool.GumpMaterials[id].objectType[1]})
			
			local count = 0

			if CraftingTool.GumpMaterials[id].quantity and type(CraftingTool.GumpMaterials[id].quantity) ~= "number"  then
				count = CraftingTool.GumpMaterials[id].quantity[Stid]
			else
				count = CraftingTool.GumpMaterials[id].quantity 
			end

			local max
			
			if CraftingTool.GumpMaterials[id].craftable then
				for k =1, #CraftingTool.Craftables do
					if CraftingTool.Craftables[k].tid == id then
						local data = CraftingTool.Craftables[k]
						local success, canDo = CraftingTool.SuccessChance(slot, data)
						local Stid = CraftingTool.Craftables[k].toolSkill
						for j = 1, #CraftingTool.Craftables[k].Materials do
							local tid = CraftingTool.Craftables[k].Materials[j].tid
							local reqAmount = CraftingTool.Craftables[k].Materials[j].amount
							
							local available =  0
							if CraftingTool.GumpMaterials[tid].quantity and type(CraftingTool.GumpMaterials[tid].quantity) ~= "number"  then
								available = CraftingTool.GumpMaterials[tid].quantity[Stid]
							else
								available = CraftingTool.GumpMaterials[tid].quantity
							end
							
							
							local tot = math.floor(available / reqAmount)
							if not max  then
								max = tot
							else
								max = math.min (max, tot)
							end
						end
						if max then
							
							if (success > 0 or canDo) and max > 0 then
								CraftingTool.ToggleDisableMakeButton(slot, true)
							else
								
								CraftingTool.ToggleDisableMakeButton(slot, false)
							end
						else
							if (success > 0 or canDo) then
								CraftingTool.ToggleDisableMakeButton(slot, true)
							else
								CraftingTool.ToggleDisableMakeButton(slot, false)
							end
						end
						break
					end
				end
			end
			
			
			
			LabelSetText(slot .. "Amount", L"")
			if amount == "N" then
				LabelSetText(slot .. "Amount", L"ALL")
			else
				if count < amount then
					LabelSetTextColor(slot .. "Amount", EnhancePack.DANGER_COLOR.r,EnhancePack.DANGER_COLOR.g,EnhancePack.DANGER_COLOR.b)
				else
					LabelSetTextColor(slot .. "Amount", EnhancePack.ESSENCE_COLOR.r,EnhancePack.ESSENCE_COLOR.g,EnhancePack.ESSENCE_COLOR.b)
				end
			end
			
			
			
			if max then
				LabelSetText(slot .. "Max", L"")
				if max <= 0 then
					LabelSetTextColor(slot .. "Max", EnhancePack.DANGER_COLOR.r,EnhancePack.DANGER_COLOR.g,EnhancePack.DANGER_COLOR.b)
				else
					LabelSetTextColor(slot .. "Max", EnhancePack.ESSENCE_COLOR.r,EnhancePack.ESSENCE_COLOR.g,EnhancePack.ESSENCE_COLOR.b)
				end
				
				WindowClearAnchors(slot .. "Amount")
				WindowAddAnchor(slot .. "Amount", "bottomleft", slot .. "Name", "topleft", 0, -15)
				if amount ~= "N" then
					LabelSetText(slot .. "Amount", count .. L" / " .. amount)
				end
				LabelSetText(slot .. "Max",  UI.GetCliloc(SystemData.Settings.Language.type, 5130) .. max)
			elseif amount ~= "N" then
				LabelSetText(slot .. "Amount", count .. L" / " .. amount)
			end
		end
	end
end

function CraftingTool.SuccessChance(slot, data)
	
	---		
	local bonus = CraftingTool.SuccessBonus[data.toolSkill][1]
	local excbonus = CraftingTool.SuccessBonus[data.toolSkill][2]
	
	
	local serverId = WindowData.SkillsCSV[CraftingTool.TidToSkill(data.mainSkill)].ServerId
	local skill = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	
	local secondarySkill 
	if data.secondarySkill ~= "" then
		serverId = WindowData.SkillsCSV[CraftingTool.TidToSkill(data.secondarySkill)].ServerId
		secondarySkill = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	end
	
	if WindowData.PlayerStatus["Race"] == 1 then
		if skill < 20 then
			skill = 20
		end
		if secondarySkill and secondarySkill < 20 then
			secondarySkill = 20
		end
	end
	
	  local canDo = true

	
	local minskill = data.minMain
	local variation = data.variation
	
	local chanceskill = data.minMain
	
	 if data.startTen then
		chanceskill = minskill - ((variation * 10) / 100)
	elseif data.startTwenty then
		chanceskill = minskill - ((variation * 20) / 100)
	elseif data.startThirty then
		chanceskill = minskill - ((variation * 30) / 100)
	elseif data.startFourty then
		chanceskill = minskill - ((variation * 40) / 100)
	elseif data.startFifty then
		chanceskill = minskill - ((variation * 50) / 100)
	elseif data.MalusTen then
		chanceskill = minskill + 10
	end
    
	if data.Detract ~= 0 then
		chanceskill = chanceskill - data.Detract
	end
    
	local success = (((skill - chanceskill) * 100) / variation) + bonus
	if success < 0 then
		success = 0
		canDo = false
	end
	if success > 100 then
		success = 100
	end
    
	local masterbonus = (skill - 95) * 3
	if masterbonus > 15 then
		masterbonus = 15
	end
	if masterbonus < 0 then
		masterbonus = 0
	end
	
	local exceptional = ((((((skill - chanceskill) * 100) / variation) - variation) - 10) + masterbonus)
	if exceptional < 0 then
		exceptional = 0
	end
	exceptional = exceptional + excbonus
	if success <= 0 then
		exceptional = 0
	end
	if exceptional > 100 then
		exceptional = 100
	end
    
  
    
	if secondarySkill and secondarySkill < data.minSecondary then
		success = 0
		exceptional = 0
		canDo = false
	end
	
	if skill and skill < data.minMain then
		success = 0
		exceptional = 0
		canDo = false
	end
	
	

	if slot and DoesWindowNameExist(slot) then
		if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
			LabelSetFont(slot .. "CraftDataSuccess", "UO_DefaultText_ASIA_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		local succ = GetStringFromTid(1044057).. L" " .. wstring.format(L"%.1f", success) .. L"%"
		if not data.noExceptional then
			succ = succ .. L"\n" .. GetStringFromTid(1044058).. L" " .. wstring.format(L"%.1f", exceptional) .. L"%"
		end
		LabelSetText(slot .."CraftDataSuccess", succ)
	end

	return success, canDo
	
	---
end

function CraftingTool.UpdateMaxCraftInList( )
	for i = #CraftingTool.mainItemSlots, 1, -1 do
		local slot = CraftingTool.mainItemSlots[i]
		if DoesWindowNameExist(slot) then
			local id = WindowGetId(slot)
			
			local data = CraftingTool.Craftables[id]
			
			local success, canDo = CraftingTool.SuccessChance(slot, data)
			
			
			local amount
			for j = 1, #CraftingTool.Craftables[id].Materials do
				local tid = CraftingTool.Craftables[id].Materials[j].tid
				local reqAmount = CraftingTool.Craftables[id].Materials[j].amount or 0
				local available = 0
				
				if CraftingTool.GumpMaterials[tid].quantity and type(CraftingTool.GumpMaterials[tid].quantity) == "number"  then
					available = CraftingTool.GumpMaterials[tid].quantity
				else
					available = CraftingTool.GumpMaterials[tid].quantity[data.toolSkill] or 0
					
				end

				if not CraftingTool.ActiveMaterials[tid] then
					CraftingTool.ActiveMaterials[tid] = true
				end
				if reqAmount ~= "N" then
					local tot = math.floor(available / reqAmount)
					if not amount  then
						amount = tot
					else
						amount = math.min (amount, tot)
					end
				end
			end
			
			if amount and amount <= 0 then
				LabelSetTextColor(slot .. "Amount", EnhancePack.DANGER_COLOR.r,EnhancePack.DANGER_COLOR.g,EnhancePack.DANGER_COLOR.b)
				CraftingTool.ToggleDisableMakeButton(slot, false)
			else
				LabelSetTextColor(slot .. "Amount", EnhancePack.ESSENCE_COLOR.r,EnhancePack.ESSENCE_COLOR.g,EnhancePack.ESSENCE_COLOR.b)
				if success > 0 or canDo then
					CraftingTool.ToggleDisableMakeButton(slot, true)
				else
					CraftingTool.ToggleDisableMakeButton(slot, false)
				end
			end
			
			if amount then
				LabelSetText(slot .. "Amount", UI.GetCliloc(SystemData.Settings.Language.type, 5130) .. amount)
			end
		end
	end
end

function CraftingTool.CountMaterials( )
	local windowName = "CraftingToolWindow"
	local objID
	
	--[[
	local backpackId =  CraftingTool.MaterialsContainer[currShard][playerID]
	if not DoesPlayerHaveItem(backpackId) then
		CraftingTool.SendWarning(UI.GetCliloc(SystemData.Settings.Language.type, 5129), 5, false, true)
		CraftingTool.ToggleDisableSearch(false)
		return
	elseif LabelGetText(windowName .. "WarningValue") == UI.GetCliloc(SystemData.Settings.Language.type, 5129)  and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5114) and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5115) and
			CraftingTool.GumpRequest ~= "countRecipes"
			then
			CraftingTool.DisableWarning()
			CraftingTool.ToggleDisableSearch(true)
	end
	if not WindowData.ContainerWindow[backpackId] then
		
		RegisterWindowData(WindowData.ContainerWindow.Type, backpackId)
		if not WindowData.ContainerWindow[backpackId] then
			CraftingTool.SendWarning(UI.GetCliloc(SystemData.Settings.Language.type, 5128), 5, false, true)
			CraftingTool.ToggleDisableSearch(false)
			return
		elseif	LabelGetText(windowName .. "WarningValue") == UI.GetCliloc(SystemData.Settings.Language.type, 5128) and
				LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5114) and
				LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5115) and
			CraftingTool.GumpRequest ~= "countRecipes"
				then
			CraftingTool.DisableWarning()
			CraftingTool.ToggleDisableSearch(true)
		end
		
	elseif LabelGetText(windowName .. "WarningValue") == UI.GetCliloc(SystemData.Settings.Language.type, 5128)  and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5114) and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5115) and
			CraftingTool.GumpRequest ~= "countRecipes"
			then
		CraftingTool.DisableWarning()
		CraftingTool.ToggleDisableSearch(true)
	elseif LabelGetText(windowName .. "WarningValue") == "" or LabelGetText(windowName .. "WarningValue") == L"" then
		CraftingTool.DisableWarning()
		CraftingTool.ToggleDisableSearch(true)
	end
	
	local numItems = WindowData.ContainerWindow[backpackId].numItems
	--]]
	for skil, value in pairs(CraftingTool.GumpMaterials) do	
		
		if skil == 1029905 or skil == 1027154 or skil == 1044041 or skil == 1044462 or skil == 1044607 then
			CraftingTool.GumpMaterials[skil].quantity = {}
			for key, n in pairs(skillsIndex) do
				if skil == 1029905 or skil == 1027154 or skil == 1044041 or skil == 1044462 or skil == 1044607 then
					
					CraftingTool.GumpMaterials[skil].quantity[key] = 0
				else
					CraftingTool.GumpMaterials[skil].quantity = 0
				end
			end
		else
			CraftingTool.GumpMaterials[skil].quantity = 0
		end
		if CraftingTool.ActiveMaterials[skil] then
			
		
			for j = 1, #CraftingTool.GumpMaterials[skil].objectType do
				local objType = CraftingTool.GumpMaterials[skil].objectType[j]
				
				if objType ~= 0 or skil == 1150016 or skil == 1041517 or skil == 1041521 or skil == 1041520 or skil == 1041519 then
				
					if skil == 1029905 or skil == 1027154 or skil == 1044041 or skil == 1044462 or skil == 1044607 then
						
						for key, n in pairs(skillsIndex) do
							
							local tid = key
							if CraftingTool.CurrentMaterials[tid] then
								local mat = CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][1]]
								local mat2 = CraftingTool.Materials[CraftingTool.CurrentMaterials[tid][2]]
								
								if CraftingTool.MaterialsIcon[tid][2] == 9908 then
									CraftingTool.GumpMaterials[1029905].hueID[1] = mat2.hue
								else
									CraftingTool.GumpMaterials[1029905].hueID[1] = -1
								end	
								
								if CraftingTool.MaterialsIcon[tid][1] == 7155 then
									CraftingTool.GumpMaterials[1027154].hueID[1] = mat.hue
									
								elseif CraftingTool.MaterialsIcon[tid][1] == 7131 then
									CraftingTool.GumpMaterials[1044041].hueID[1] = mat.hue
									CraftingTool.GumpMaterials[1044041].hueID[2] = mat.hue
									
								elseif CraftingTool.MaterialsIcon[tid][1] == 4199 then
									CraftingTool.GumpMaterials[1044462].hueID[1] = mat.hue
									CraftingTool.GumpMaterials[1044462].hueID[2] = mat.hue
									CraftingTool.GumpMaterials[1044462].hueID[3] = mat.hue
									CraftingTool.GumpMaterials[1044462].hueID[4] = mat.hue
									CraftingTool.GumpMaterials[1044462].hueID[5] = mat.hue
									CraftingTool.GumpMaterials[1044462].hueID[6] = mat.hue
								
								elseif CraftingTool.MaterialsIcon[tid][1] == 6009 then
									CraftingTool.GumpMaterials[1044607].hueID[1] = mat.hue
									
								else
									CraftingTool.GumpMaterials[1027154].hueID[1] = -1
									CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
									CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
									CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
									CraftingTool.GumpMaterials[1044462].hueID[2] = -1
									CraftingTool.GumpMaterials[1044462].hueID[3] = -1
									CraftingTool.GumpMaterials[1044462].hueID[4] = -1
									CraftingTool.GumpMaterials[1044462].hueID[5] = -1
									CraftingTool.GumpMaterials[1044462].hueID[6] = -1
									CraftingTool.GumpMaterials[1044607].hueID[1] = -1
								end
							else
								CraftingTool.GumpMaterials[1027154].hueID[1] = -1
								CraftingTool.GumpMaterials[1044041].hueID[1] = -1 
								CraftingTool.GumpMaterials[1044041].hueID[2] = -1 
								CraftingTool.GumpMaterials[1044462].hueID[1] = -1 
								CraftingTool.GumpMaterials[1044462].hueID[2] = -1
								CraftingTool.GumpMaterials[1044462].hueID[3] = -1
								CraftingTool.GumpMaterials[1044462].hueID[4] = -1
								CraftingTool.GumpMaterials[1044462].hueID[5] = -1
								CraftingTool.GumpMaterials[1044462].hueID[6] = -1
								CraftingTool.GumpMaterials[1044607].hueID[1] = -1
							end
							
							local hue = CraftingTool.GumpMaterials[skil].hueID[j]
														
														
							if not (EnhancePack.itemQuantities[objType]) then
								continue
							end
							--[[
							for i = 1, numItems  do
								local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
								
								item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
							--]]
							
							for i = 1, #EnhancePack.itemQuantities[objType] do
								local item = {}
								item.objectId = EnhancePack.itemQuantities[objType][i]
								
								--item = WindowData.ContainerWindow[backpackId].ContainedItems[i]

								local itemdata = WindowData.ObjectInfo[item.objectId]
								if not itemdata then
									RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
									itemdata = WindowData.ObjectInfo[item.objectId]
								end
							
								
								
								
								local itemHue = itemdata.hueId				


								if EnhancePack.Highlight[item.objectId] then
									itemHue = EnhancePack.Highlight[item.objectId].oldHue
								end

								
								
								
									
								-- if  skil == 1150016 or skil == 1041517 or skil == 1041521 or skil == 1041520 or skil == 1041519 thenitemdata.objectType == objType or
									
									if hue ~= -1 then
										if itemHue ~= hue and objType ~= 0 then
											continue
										end
									end
								
									local name = wstring.lower(Shopkeeper.stripFirstNumber(itemdata.name))

									local props = GetObjectProperties( item.objectId )
									if skil == 1041517 or skil == 1041521 or skil == 1041520 or skil == 1041519 then
										if name == wstring.lower(CraftingTool.GetStringFromTid(skil)) then
											local tid = wstring.lower(wstring.gsub(GetStringFromTid(1041507), L"~1_val~", L"")) -- : completed by ~1_val~
											
											if #props >= 5 and wstring.find(wstring.lower(props[5]), tid) then
												if itemdata.quantity >= 1 then
													CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
												else
													CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
												end
											end
										end
									elseif skil == 1024153 then
										if name == wstring.lower(CraftingTool.GetStringFromTid(1024154)) then -- open sack of flour
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
									elseif skil == 1025465 then
										if name == wstring.lower(CraftingTool.GetStringFromTid(1115929)) then -- Endless Decanter of Water
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										elseif name == wstring.lower(CraftingTool.GetStringFromTid(1048133)) then -- : a Pitcher of Water
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
									
									elseif skil == 1044455 then
										if name == wstring.lower(CraftingTool.GetStringFromTid(1044286)) then -- cloth
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										elseif name == wstring.lower(CraftingTool.GetStringFromTid(1025992)) then -- cut cloth
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										elseif name == wstring.lower(CraftingTool.GetStringFromTid(1025988)) then -- folded cloth
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif skil == 1044462 then
										
										if name == wstring.lower(CraftingTool.GetStringFromTid(1024199)) then -- cut leather
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										elseif name == wstring.lower(CraftingTool.GetStringFromTid(1024216)) then -- pile of hides
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
									elseif skil == 1044041 then
										if name == wstring.lower(CraftingTool.GetStringFromTid(1027127)) then -- board
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										elseif name == wstring.lower(CraftingTool.GetStringFromTid(1027133)) then -- log
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
									
									elseif skil == 1044377 then	-- blank scrolls
										if name == wstring.lower(CraftingTool.GetStringFromTid(1023636)) then -- blank scroll
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity[tid]
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
									
									elseif skil == 1044447 then	-- unmarked rune
										
										if name == wstring.lower(CraftingTool.GetStringFromTid(1027956)) and #props <= 2 then -- recall rune
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
									
									elseif skil == 1028762 then -- broken crystals
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
										end
										
									elseif skil == 1112131 then -- plant clippings
										if wstring.find(name, wstring.lower(CraftingTool.GetStringFromTid(skil))) then
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
									
									elseif skil == 1112132 then -- plant pigment
										if wstring.find(name, wstring.lower(CraftingTool.GetStringFromTid(skil))) then
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif skil == 1029905 then -- dragon scales
										if wstring.find(name, wstring.lower(GetStringFromTid(1053113))) or wstring.find(name, wstring.lower(CraftingTool.GetStringFromTid(skil))) then
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
											
									elseif skil == 1112248 then -- dry reeds
										local t = wstring.gsub(wstring.lower(CraftingTool.GetStringFromTid(1112289)), L"~1_color~", L"") -- ~1_COLOR~ reeds
										if wstring.find(name, t) then
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif skil == 1112249 then -- softened reeds
										local t = wstring.gsub(wstring.lower(CraftingTool.GetStringFromTid(1112346)), L"~1_color~", L"") -- ~1_COLOR~ softened reeds
										if wstring.find(name, t) then
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end

									elseif skil == 1044472 then -- honey

										if name == wstring.lower(CraftingTool.GetStringFromTid(1022540)) then
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif skil == 1023850 then -- green potion
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1041322)) or -- lesser poison
											name == wstring.lower(CraftingTool.GetStringFromTid(1041323)) or -- poison
											name == wstring.lower(CraftingTool.GetStringFromTid(1041324)) or -- greater poison
											name == wstring.lower(CraftingTool.GetStringFromTid(1041325)) or -- deadly poison
											name == wstring.lower(CraftingTool.GetStringFromTid(1023850)) -- green potion
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
									
									elseif skil == 1023853 then -- purple potion
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1041331)) or -- lesser explosion
											name == wstring.lower(CraftingTool.GetStringFromTid(1041332)) or -- explosion
											name == wstring.lower(CraftingTool.GetStringFromTid(1041333)) or -- greater explosion
											name == wstring.lower(CraftingTool.GetStringFromTid(1023853)) -- purple potion
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif skil == 1015015 then -- greater strength
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1015015)) or -- greater strength
											name == wstring.lower(CraftingTool.GetStringFromTid(1041321))  -- greater strength potion
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif skil == 1015012 then -- greater heal
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1015012)) or -- greater heal
											name == wstring.lower(CraftingTool.GetStringFromTid(1041330))  -- greater heal potion
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif skil == 1072943 then -- darkglow
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1072943)) or -- darkglow
											name == wstring.lower(CraftingTool.GetStringFromTid(1072849))  -- darkglow poison
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif skil == 1153504 then -- gold dust
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1098337)) or
											name == wstring.lower(CraftingTool.GetStringFromTid(1153504))
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
											end
										end
										
									elseif name == wstring.lower(CraftingTool.GetStringFromTid(skil)) then
										
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
										end
									end
								--end
								UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
							end
						end
					else
						
						local hue = CraftingTool.GumpMaterials[skil].hueID[j]
							
						if not (EnhancePack.itemQuantities[objType]) then
							continue
						end
						--[[
						for i = 1, numItems  do
							local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
							
							item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
						--]]
						
						for i = 1, #EnhancePack.itemQuantities[objType] do
							local item = {}
							item.objectId = EnhancePack.itemQuantities[objType][i]
							
							local itemdata = WindowData.ObjectInfo[item.objectId]
							if not itemdata then
								RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
								itemdata = WindowData.ObjectInfo[item.objectId]
							end
						
							
							local itemHue = itemdata.hueId				


							if EnhancePack.Highlight[item.objectId] then
								itemHue = EnhancePack.Highlight[item.objectId].oldHue
							end
						
							
							
							
								
							--if skil == 1150016 or skil == 1041517 or skil == 1041521 or skil == 1041520 or skil == 1041519 then -- itemdata.objectType == objType or
								
								
								if hue ~= -1 then
									if itemHue ~= hue and objType ~= 0 then
										continue
									end
								end
								
							
								local name = wstring.lower(Shopkeeper.stripFirstNumber(itemdata.name))

								local props = GetObjectProperties( item.objectId )
								if skil == 1041517 or skil == 1041521 or skil == 1041520 or skil == 1041519 then
									if name == wstring.lower(CraftingTool.GetStringFromTid(skil)) then
										local tid = wstring.lower(wstring.gsub(GetStringFromTid(1041507), L"~1_val~", L"")) -- : completed by ~1_val~
										
										if #props >= 5 and wstring.find(wstring.lower(props[5]), tid) then
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
											end
										end
									end
								elseif skil == 1024153 then
									if name == wstring.lower(CraftingTool.GetStringFromTid(1024154)) then -- open sack of flour
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
								elseif skil == 1025465 then
									if name == wstring.lower(CraftingTool.GetStringFromTid(1115929)) then -- Endless Decanter of Water
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									elseif name == wstring.lower(CraftingTool.GetStringFromTid(1048133)) then -- : a Pitcher of Water
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
								
								elseif skil == 1044455 then
									if name == wstring.lower(CraftingTool.GetStringFromTid(1044286)) then -- cloth
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									elseif name == wstring.lower(CraftingTool.GetStringFromTid(1025992)) then -- cut cloth
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									elseif name == wstring.lower(CraftingTool.GetStringFromTid(1025988)) then -- folded cloth
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
									
								elseif skil == 1044462 then
									
									if name == wstring.lower(CraftingTool.GetStringFromTid(1024199)) then -- cut leather
										
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									elseif name == wstring.lower(CraftingTool.GetStringFromTid(1024216)) then -- pile of hides
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
								elseif skil == 1044041 then
									if name == wstring.lower(CraftingTool.GetStringFromTid(1027127)) then -- board
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									elseif name == wstring.lower(CraftingTool.GetStringFromTid(1027133)) then -- log
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
									
								elseif skil == 1044377 then	-- blank scrolls
									
									if name == wstring.lower(CraftingTool.GetStringFromTid(1023636)) then -- blank scroll
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
									
								elseif skil == 1044447 then	-- unmarked rune
									
									if name == wstring.lower(CraftingTool.GetStringFromTid(1027956)) and #props <= 2 then -- recall rune
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
								
								elseif skil == 1028762 then -- broken crystals
									if itemdata.quantity >= 1 then
										CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
									else
										CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
									end
									
								elseif skil == 1112131 then -- plant clippings
									if wstring.find(name, wstring.lower(CraftingTool.GetStringFromTid(skil))) then
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
									
								elseif skil == 1112132 then -- plant pigment
									if wstring.find(name, wstring.lower(CraftingTool.GetStringFromTid(skil))) then
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
									
								elseif skil == 1029905 then -- dragon scales
									if wstring.find(name, wstring.lower(GetStringFromTid(1053113))) or wstring.find(name, wstring.lower(CraftingTool.GetStringFromTid(skil))) then
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
								elseif skil == 1112248 then -- dry reeds
									local t = wstring.gsub(wstring.lower(CraftingTool.GetStringFromTid(1112289)), L"~1_color~", L"") -- ~1_COLOR~ reeds
									if wstring.find(name, t) then
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
									
								elseif skil == 1112249 then -- softened reeds
									local t = wstring.gsub(wstring.lower(CraftingTool.GetStringFromTid(1112346)), L"~1_color~", L"") -- ~1_COLOR~ softened reeds
									if wstring.find(name, t) then
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
									
								elseif skil == 1044472 then -- honey
									if name == wstring.lower(CraftingTool.GetStringFromTid(1022540)) then
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
									
								elseif skil == 1023850 then -- green potion
									if  name == wstring.lower(CraftingTool.GetStringFromTid(1041322)) or -- lesser poison
										name == wstring.lower(CraftingTool.GetStringFromTid(1041323)) or -- poison
										name == wstring.lower(CraftingTool.GetStringFromTid(1041324)) or -- greater poison
										name == wstring.lower(CraftingTool.GetStringFromTid(1041325))  or -- deadly poison
										name == wstring.lower(CraftingTool.GetStringFromTid(1023850)) -- green potion
										then
										
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
								
								elseif skil == 1023853 then -- purple potion
									if  name == wstring.lower(CraftingTool.GetStringFromTid(1041331)) or -- lesser explosion
										name == wstring.lower(CraftingTool.GetStringFromTid(1041332)) or -- explosion
										name == wstring.lower(CraftingTool.GetStringFromTid(1041333)) or -- greater explosion
										name == wstring.lower(CraftingTool.GetStringFromTid(1023853)) -- purple potion
										then
										
										if itemdata.quantity >= 1 then
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
										else
											CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
										end
									end
								
								elseif skil == 1015015 then -- greater strength
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1015015)) or -- greater strength
											name == wstring.lower(CraftingTool.GetStringFromTid(1041321))  -- greater strength potion
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
											end
										end
										
								elseif skil == 1015012 then -- greater heal
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1015012)) or -- greater heal
											name == wstring.lower(CraftingTool.GetStringFromTid(1041330))  -- greater heal potion
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
											end
										end
										
								elseif skil == 1072943 then -- darkglow
										if  name == wstring.lower(CraftingTool.GetStringFromTid(1072943)) or -- darkglow
											name == wstring.lower(CraftingTool.GetStringFromTid(1072849))  -- darkglow poison
											then
											
											if itemdata.quantity >= 1 then
												CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
											else
												CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
											end
										end
										
								elseif name == wstring.lower(CraftingTool.GetStringFromTid(skil)) then
									
									
									if itemdata.quantity >= 1 then
										CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
									else
										CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
									end
								end
							--end
							UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
						end
					end
				else
					--for i = 1, numItems  do
					--	local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
					-- item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
					for i = 1, #EnhancePack.AllItems do
						local item = {}
						item.objectId = EnhancePack.AllItems[i]	
						
						
						local itemdata = WindowData.ObjectInfo[item.objectId]
						if not itemdata then
							RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
							itemdata = WindowData.ObjectInfo[item.objectId]
						end
						
						local name = wstring.lower(Shopkeeper.stripFirstNumber(itemdata.name))
						if skil == 1029905 or skil == 1027154 or skil == 1044041 or skil == 1044462 or skil == 1044607 then
							for key, n in pairs(skillsIndex) do
							
								local tid = key
								if name == wstring.lower(CraftingTool.GetStringFromTid(skil)) then
									if itemdata.quantity >= 1 then
										CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + itemdata.quantity
									else
										CraftingTool.GumpMaterials[skil].quantity[tid] = CraftingTool.GumpMaterials[skil].quantity[tid] + 1
									end
								end
							end
						else
							for key, n in pairs(skillsIndex) do
							
								local tid = key
								if name == wstring.lower(CraftingTool.GetStringFromTid(skil)) then
									if itemdata.quantity >= 1 then
										CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + itemdata.quantity
									else
										CraftingTool.GumpMaterials[skil].quantity = CraftingTool.GumpMaterials[skil].quantity + 1
									end
								end
							end
						end
						UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
					end
					
				end
			end
		end
	end
--[[
	if not (ContainerWindow.OpenContainers[backpackId]) and backpackId then
		UnregisterWindowData(WindowData.ContainerWindow.Type, backpackId)

			
	end
--]]
end

function CraftingTool.ComboToTid()
	local windowName = "CraftingToolWindow"
	local sel = ComboBoxGetSelectedMenuItem( windowName .. "ActiveSkillCombo" )
	if sel > 0 then
		return CraftingTool.ComboData[sel]
	else
		return
	end
end
function CraftingTool.ComboToSkillId()
	local windowName = "CraftingToolWindow"
	local sel = ComboBoxGetSelectedMenuItem( windowName .. "ActiveSkillCombo" )
	if sel > 0 then
		return CraftingTool.SkillsIdFromTid[CraftingTool.ComboData[sel]]
	else
		return
	end
end
function CraftingTool.ComboTidToIndex(tid)
	local windowName = "CraftingToolWindow"
	for idx, value in pairs(CraftingTool.ComboData) do
		if value == tid then
			return idx
		end
	end
	return
end

function CraftingTool.UpdateCombo(searchTools)
	CraftingTool.ComboInUpdate = true
	local windowName = "CraftingToolWindow"
	if searchTools then
		CraftingTool.SearchTools(true)
	end
	local currentTid = 0
	if CraftingTool.ComboData ~= nil then
		currentTid = CraftingTool.ComboData.CurrentSelectionTid
		CraftingTool.ComboData.CurrentSelectionTid = nil
		CraftingTool.ComboData.CurrentSelection = nil
	end
	
	
	CraftingTool.ComboData = nil
	CraftingTool.ComboData = {}
	CraftingTool.ComboData.CurrentSelection = 1
	ComboBoxClearMenuItems(windowName .. "ActiveSkillCombo")
	if CraftingTool.SearchOptions["showAllSkills"] then
		local idx = 0
		for i = 1, #skills do
			local text = GetStringFromTid(WindowData.SkillsCSV[skills[i]].NameTid)
			ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", text)
			CraftingTool.ComboData[i] = WindowData.SkillsCSV[skills[i]].NameTid
			if WindowData.SkillsCSV[skills[i]].NameTid == currentTid then
				CraftingTool.ComboData.CurrentSelection = i
			end
			idx = i
		end
		idx = idx + 1
		ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", GetStringFromTid(1072392))
		CraftingTool.ComboData[idx] = 1072392
		if 1072392 == currentTid then
			CraftingTool.ComboData.CurrentSelection = idx
		end
		idx = idx + 1
		ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", GetStringFromTid(1072393))
		CraftingTool.ComboData[idx] = 1072393
		if 1072393 == currentTid then
			CraftingTool.ComboData.CurrentSelection = idx
		end
		ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", L"")
		idx = idx + 1
		CraftingTool.ComboData[idx] = 1072393
		ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", L"")
		idx = idx + 1
		CraftingTool.ComboData[idx] = 1072393
	elseif CraftingTool.SearchOptions["showSkillsAvailable"] then
		local idx = 0
		local gb = false
		local msn = false
		local lastSkill = 0
		for i = 1, #skills do
			local serverId = WindowData.SkillsCSV[skills[i]].ServerId
			local skillVal = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
			
			if skillVal > 0 then
				if CraftingTool.SearchOptions["showSkillsWithTool"] then
					if CraftingTool.LoadedTools[WindowData.SkillsCSV[skills[i]].NameTid].id ~= 0 then
						idx = idx + 1
						local text = GetStringFromTid(WindowData.SkillsCSV[skills[i]].NameTid)
						CraftingTool.ComboData[idx] = WindowData.SkillsCSV[skills[i]].NameTid
						ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", text)
						if WindowData.SkillsCSV[skills[i]].NameTid == currentTid then
							CraftingTool.ComboData.CurrentSelection = i
							CraftingTool.ComboData.CurrentSelectionTid = currentTid
						end
						if skills[i] == 1 then
							gb = true
						end
						if skills[i] == 11 then
							msn = true
						end
						lastSkill = WindowData.SkillsCSV[skills[i]].NameTid
					end
				else
					idx = idx + 1
					local text = GetStringFromTid(WindowData.SkillsCSV[skills[i]].NameTid)
					CraftingTool.ComboData[idx] = WindowData.SkillsCSV[skills[i]].NameTid
					ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", text)
					if WindowData.SkillsCSV[skills[i]].NameTid == currentTid then
						CraftingTool.ComboData.CurrentSelection = i
						CraftingTool.ComboData.CurrentSelectionTid = currentTid
					end
					if skills[i] == 1 then
						gb = true
					end
					if skills[i] == 11 then
						msn = true
					end
					lastSkill = WindowData.SkillsCSV[skills[i]].NameTid
				end
				
				
			end
		end
		if msn then
			idx = idx + 1
			ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", GetStringFromTid(1072392))
			CraftingTool.ComboData[idx] = 1072392
			lastSkill = 1072392
			if 1072392 == currentTid then
				CraftingTool.ComboData.CurrentSelection = idx
				CraftingTool.ComboData.CurrentSelectionTid = currentTid
			end
		end
		if gb then
			idx = idx + 1
			ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", GetStringFromTid(1072393))
			CraftingTool.ComboData[idx] = 1072393
			lastSkill = 1072393
			if 1072393 == currentTid then
				CraftingTool.ComboData.CurrentSelection = idx
			end
		end
		ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", L"")
		idx = idx + 1
		CraftingTool.ComboData[idx] = lastSkill
		ComboBoxAddMenuItem( windowName .. "ActiveSkillCombo", L"")
		idx = idx + 1
		CraftingTool.ComboData[idx] = lastSkill
		
	end

	if not CraftingTool.ComboData.CurrentSelectionTid then
		CraftingTool.ComboData.CurrentSelectionTid = CraftingTool.ComboData[CraftingTool.ComboData.CurrentSelection]
	end
	ComboBoxSetSelectedMenuItem(windowName .. "ActiveSkillCombo", CraftingTool.ComboTidToIndex(CraftingTool.ComboData.CurrentSelectionTid))

	CraftingTool.ChangeActiveSkill()
		
	
end

function CraftingTool.CountToolsUses()
	local windowName = "CraftingToolWindow"
	local objID
	
	for skil, value in pairs(CraftingTool.LoadedTools) do	
		CraftingTool.LoadedTools[skil].totalUses = 0
		
		if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] and WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId and WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId ~= 0 then
			local item = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId
			
			local itemdata = WindowData.ObjectInfo[item]
			if not itemdata then
				RegisterWindowData(WindowData.ObjectInfo.Type, item)
				itemdata = WindowData.ObjectInfo[item]
			end
			local hue = CraftingTool.Materials[CraftingTool.Toolkit[skil]].hue
			local tid =  CraftingTool.Materials[CraftingTool.Toolkit[skil]].tid
			
			local itemHue = itemdata.hueId
			
			local noHue = false
			local found = false
			for j = 1, #CraftingTool.Tools[skil] do
				if CraftingTool.Tools[skil][j] == 3722 and hue == 0 then
					hue = 2301
				end
				if EnhancePack.Highlight[item] then
					itemHue = EnhancePack.Highlight[item].oldHue
				end
				
				if itemHue ~= hue then
					noHue = true
					break
				end

									
				if itemdata.objectType == CraftingTool.Tools[skil][j] then
					local props = GetObjectProperties( item )
					
					if (tid >= 1049028 and tid <= 1049031)  then
						if wstring.lower(CraftingTool.GetStringFromTid(tid)) ~= wstring.lower(props[1]) then
							break
						end
					
					end
					if props and #props > 0 then
						for k=1, #props do
							local use = wstring.lower(wstring.gsub(GetStringFromTid(1060584), ItemPropertiesEvaluator.escape2, L"")) -- uses remaining: ~1_val~
							if (wstring.find(wstring.lower(props[k]),use)) then
								use = tonumber(tostring(wstring.gsub(wstring.lower(props[k]), use .. L" ", L"")))
								
								if use > 0 then
									CraftingTool.LoadedTools[skil].totalUses = CraftingTool.LoadedTools[skil].totalUses + use 
									break
								end

							end
						end
					end

				end
			end

		end


		for j = 1, #CraftingTool.Tools[skil] do
			local objType = CraftingTool.Tools[skil][j] 
			
			if not (EnhancePack.itemQuantities[objType]) then
				continue
			end

			local hue = CraftingTool.Materials[CraftingTool.Toolkit[skil]].hue
			local tid =  CraftingTool.Materials[CraftingTool.Toolkit[skil]].tid
			
			if CraftingTool.Tools[skil][j] == 3722 and hue == 0 then
				hue = 2301
			end
			for i = 1, #EnhancePack.itemQuantities[objType] do
				local item = {}
				item.objectId = EnhancePack.itemQuantities[objType][i]
				
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if not itemdata then
					RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
					itemdata = WindowData.ObjectInfo[item.objectId]
				end
				
				
				local itemHue = itemdata.hueId
							
				
				if EnhancePack.Highlight[item.objectId] then
					itemHue = EnhancePack.Highlight[item.objectId].oldHue
				end
				
				if itemHue ~= hue then
					break
				end

									

				local props = GetObjectProperties( item.objectId )
				
				if (tid >= 1049028 and tid <= 1049031)  then
					if wstring.lower(CraftingTool.GetStringFromTid(tid)) ~= wstring.lower(props[1]) then
						continue
					end
				
				end
				if props and #props > 0 then
					for k=1, #props do
						local use = wstring.lower(wstring.gsub(GetStringFromTid(1060584), ItemPropertiesEvaluator.escape2, L"")) -- uses remaining: ~1_val~
						if (wstring.find(wstring.lower(props[k]),use)) then
							use = tonumber(tostring(wstring.gsub(wstring.lower(props[k]), use .. L" ", L"")))
							
							if use > 0 then
								CraftingTool.LoadedTools[skil].totalUses = CraftingTool.LoadedTools[skil].totalUses + use 
							end
							break
						end
					end
				end
			end		

		end

	end

end

function CraftingTool.SearchTools(forced)
	local windowName = "CraftingToolWindow"
	local objID
	CraftingTool.CountToolsUses()
	--[[
	local backpackId =  CraftingTool.CraftContainer[currShard][playerID]
	if not DoesPlayerHaveItem(backpackId) then
		CraftingTool.SendWarning(UI.GetCliloc(SystemData.Settings.Language.type, 5115), 5, false, true)
		CraftingTool.ToggleDisableSearch(false)
		return
	elseif LabelGetText(windowName .. "WarningValue") == UI.GetCliloc(SystemData.Settings.Language.type, 5115)  and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5128) and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5129) and
			CraftingTool.GumpRequest ~= "countRecipes"
			then
			CraftingTool.DisableWarning()
			CraftingTool.ToggleDisableSearch(true)
	end
	if not WindowData.ContainerWindow[backpackId] then
		
		RegisterWindowData(WindowData.ContainerWindow.Type, backpackId)
		if not WindowData.ContainerWindow[backpackId] then
			CraftingTool.SendWarning(UI.GetCliloc(SystemData.Settings.Language.type, 5114), 5, false, true)
			CraftingTool.ToggleDisableSearch(false)
			return
		elseif LabelGetText(windowName .. "WarningValue") == UI.GetCliloc(SystemData.Settings.Language.type, 5114) and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5128) and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5129) and
			CraftingTool.GumpRequest ~= "countRecipes"
			then
			CraftingTool.DisableWarning()
			CraftingTool.ToggleDisableSearch(true)
	
		end
		
	elseif LabelGetText(windowName .. "WarningValue") == UI.GetCliloc(SystemData.Settings.Language.type, 5114) and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5128) and
			LabelGetText(windowName .. "WarningValue") ~= UI.GetCliloc(SystemData.Settings.Language.type, 5129) and
			CraftingTool.GumpRequest ~= "countRecipes"
			then
		CraftingTool.DisableWarning()
		CraftingTool.ToggleDisableSearch(true)
	elseif LabelGetText(windowName .. "WarningValue") == "" or LabelGetText(windowName .. "WarningValue") == L"" then
		CraftingTool.DisableWarning()
		CraftingTool.ToggleDisableSearch(true)
		
	end
	
	local numItems = WindowData.ContainerWindow[backpackId].numItems
	--]]
	for skil, value in pairs(CraftingTool.LoadedTools) do	
		
		if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] and WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId and WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId ~= 0 then
			local item = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][4].slotId
			
			local itemdata = WindowData.ObjectInfo[item]
			if not itemdata then
				RegisterWindowData(WindowData.ObjectInfo.Type, item)
				itemdata = WindowData.ObjectInfo[item]
			end
			local hue = CraftingTool.Materials[CraftingTool.Toolkit[skil]].hue
			local tid =  CraftingTool.Materials[CraftingTool.Toolkit[skil]].tid
			
			local itemHue = itemdata.hueId
			
			local noHue = false
			local found = false
			for j = 1, #CraftingTool.Tools[skil] do
				if CraftingTool.Tools[skil][j] == 3722 and hue == 0 then
					hue = 2301
				end
				if EnhancePack.Highlight[item] then
					itemHue = EnhancePack.Highlight[item].oldHue
				end
				
				if itemHue ~= hue then
					noHue = true
					break
				end

									
				if itemdata.objectType == CraftingTool.Tools[skil][j] then
					local props = GetObjectProperties( item )
					
					if (tid >= 1049028 and tid <= 1049031)  then
						if wstring.lower(CraftingTool.GetStringFromTid(tid)) ~= wstring.lower(props[1]) then
							break
						end
					
					end
					if props and #props > 0 then
						for k=1, #props do
							local use = wstring.lower(wstring.gsub(GetStringFromTid(1060584), ItemPropertiesEvaluator.escape2, L"")) -- uses remaining: ~1_val~
							if (wstring.find(wstring.lower(props[k]),use)) then
								use = tonumber(tostring(wstring.gsub(wstring.lower(props[k]), use .. L" ", L"")))
								
								if use > 0 then
									CraftingTool.LoadedTools[skil].uses = use 
								end
								break
							end
						end
					end
					if CraftingTool.LoadedTools[skil].uses > 0 then
						CraftingTool.LoadedTools[skil].id = item
						found = true
						break
					end
				end
			end
			if found then
				continue
			end
		end
		if CraftingTool.LoadedTools[skil].id ~= 0 and not forced then
			continue
		end
		
		--for i = 1, numItems  do
		--	local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
			
		--	item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		

		for j = 1, #CraftingTool.Tools[skil] do
			local objType = CraftingTool.Tools[skil][j] 
			
			if not (EnhancePack.itemQuantities[objType]) then
				continue
			end

			local hue = CraftingTool.Materials[CraftingTool.Toolkit[skil]].hue
			local tid =  CraftingTool.Materials[CraftingTool.Toolkit[skil]].tid
			
			if CraftingTool.Tools[skil][j] == 3722 and hue == 0 then
				hue = 2301
			end
			for i = 1, #EnhancePack.itemQuantities[objType] do
				local item = {}
				item.objectId = EnhancePack.itemQuantities[objType][i]
				
				local itemdata = WindowData.ObjectInfo[item.objectId]
				if not itemdata then
					RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
					itemdata = WindowData.ObjectInfo[item.objectId]
				end
				
				
				local itemHue = itemdata.hueId
							
				
				if EnhancePack.Highlight[item.objectId] then
					itemHue = EnhancePack.Highlight[item.objectId].oldHue
				end
				
				if itemHue ~= hue then
					break
				end

									
				--if  not block then -- itemdata.objectType == CraftingTool.Tools[skil][j] and
					local props = GetObjectProperties( item.objectId )
					
					if (tid >= 1049028 and tid <= 1049031)  then
						if wstring.lower(CraftingTool.GetStringFromTid(tid)) ~= wstring.lower(props[1]) then
							break
						end
					
					end
					if props and #props > 0 then
						for k=1, #props do
							local use = wstring.lower(wstring.gsub(GetStringFromTid(1060584), ItemPropertiesEvaluator.escape2, L"")) -- uses remaining: ~1_val~
							if (wstring.find(wstring.lower(props[k]),use)) then
								use = tonumber(tostring(wstring.gsub(wstring.lower(props[k]), use .. L" ", L"")))
								
								if use > 0 then
									CraftingTool.LoadedTools[skil].uses = use 
								end
								break
							end
						end
					end
					if CraftingTool.LoadedTools[skil].uses > 0 then
						CraftingTool.LoadedTools[skil].id = item.objectId
						
						break
					end
				--end
			end		

		end

	end
	
	if CraftingTool.SearchOptions["showSkillsWithTool"] then
		CraftingTool.UpdateCombo()
	end
--[[
	if not (ContainerWindow.OpenContainers[backpackId]) then
		UnregisterWindowData(WindowData.ContainerWindow.Type, backpackId)
	end
--]]
end

function CraftingTool.AlterItem()
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	
	if EnhancePack.CraftSkill ~= tid then
		UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
		EnhancePack.CraftSkill = tid
	end
	CraftingTool.GumpRequest = "alter"
	CraftingTool.GumpRequestSkill = tid
end

function CraftingTool.RepairItemHB()

	if EnhancePack.RepairItem and DoesWindowNameExist(EnhancePack.RepairItem) then
		local gumpId = WindowGetId(EnhancePack.RepairItem)
		GenericGumpOnClicked(gumpId, EnhancePack.RepairItem)
	end
end

function CraftingTool.RepairItem()
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	
	if EnhancePack.CraftSkill ~= tid then
		UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
		EnhancePack.CraftSkill = tid
	end
	CraftingTool.GumpRequest = "repair"
	CraftingTool.GumpRequestSkill = tid
end

function CraftingTool.EnhanceItem()
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	
	if EnhancePack.CraftSkill ~= tid then
		UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
		EnhancePack.CraftSkill = tid
	end
	CraftingTool.GumpRequest = "enhance"
	CraftingTool.GumpRequestSkill = tid
end

function CraftingTool.SmeltItem()
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	
	if EnhancePack.CraftSkill ~= tid then
		UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
		EnhancePack.CraftSkill = tid
	end
	CraftingTool.GumpRequest = "smelt"
	CraftingTool.GumpRequestSkill = tid
end

function CraftingTool.MakeLastHB()

	if EnhancePack.MakeLast and DoesWindowNameExist(EnhancePack.MakeLast) then
		local gumpId = WindowGetId(EnhancePack.MakeLast)
		GenericGumpOnClicked(gumpId, EnhancePack.MakeLast)
	end
end

function CraftingTool.MakeLast()
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	
	if EnhancePack.CraftSkill ~= tid then
		UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
		EnhancePack.CraftSkill = tid
	end
	CraftingTool.GumpRequest = "makelast"
	CraftingTool.GumpRequestSkill = tid
	LabelSetText("CraftingToolWindowItemMade", L"")
end

function CraftingTool.CancelMake()
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	
	if EnhancePack.CraftSkill ~= tid then
		UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
		EnhancePack.CraftSkill = tid
	end
	CraftingTool.GumpRequest = "cancelmake"
	CraftingTool.GumpRequestSkill = tid
end

function CraftingTool.CountRecipes()
	CraftingTool.OpenedRecipe = true
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	for j = 1, #CraftingTool.Craftables do
		if tid == CraftingTool.Craftables[j].toolSkill  then
			
			if CraftingTool.Craftables[j].recipe == true then
				table.insert(CraftingTool.GumpRecipeCount, #CraftingTool.GumpRecipeCount+1, j)
			end
		end
	end
	

	CraftingTool.Patterns = {}
	TextEditBoxSetText("CraftingToolWindowSearchBox", L"")
	CraftingTool.ClearItemList()
	local dialog = "CraftingToolSW"
	local parent = dialog.. "ScrollChildCont"
	local Width, Height = WindowGetDimensions(parent)
	
	Height = 0
	WindowSetDimensions(parent, Width, Height )
	ScrollWindowUpdateScrollRect( "CraftingToolSW" ) 
	ScrollWindowSetOffset( "CraftingToolSW", 0 )
	
	if #CraftingTool.GumpRecipeCount > 0 then
		
		for i = 1, #CraftingTool.Buttons do
			if DoesWindowNameExist(CraftingTool.Buttons[i]) then
				CraftingTool.ToggleDisableButton(CraftingTool.Buttons[i], false)
			end
		end
		CraftingTool.ToggleDisableSearch(false)
		WindowSetShowing(windowName .. "DisableSW", false)
		
		CraftingTool.OpenedCat = false
		CraftingTool.OpenedLast = false
		CraftingTool.OpenedSearch = false
		
		EnhancePack.AfterPrep = nil
		EnhancePack.AfterCat = nil
		EnhancePack.AfterItem  = nil
		CraftingTool.GumpRequest = "countRecipes"
		CraftingTool.GumpRequestSkill = tid
		CraftingTool.GumpRecipeCurrent = 0
		if EnhancePack.CraftSkill ~= tid then
			UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
			EnhancePack.CraftSkill = tid
		end
	else
		LabelSetText(windowName .. "Total", UI.GetCliloc(SystemData.Settings.Language.type, 7004))
	end

end

function CraftingTool.Make()
	local windowName = "CraftingToolWindow"
	local this = SystemData.ActiveWindow.name
	local Item = WindowGetParent(this)

	local id = WindowGetId(Item)
	
	local name = wstring.lower(LabelGetText(Item .. "Name"))
	local skillId = WindowGetId( Item .. "CraftDataSkills")
	if skillId and skillId ~= 0 then
		for j = 1, #CraftingTool.Craftables do
			
			local tid = wstring.lower(CraftingTool.GetStringFromTid(CraftingTool.Craftables[j].tid))
			local skill = CraftingTool.Craftables[j].mainSkill == skillId
			if name == tid and skill then
				id = j
				break
			end
		end
	end
	
	
	local data = CraftingTool.Craftables[id]
	if CraftingTool.LoadedTools[data.toolSkill].id ~= 0 then
			
		local sel = CraftingTool.ComboToTid()
		if sel ~= data.toolSkill then
			CraftingTool.ComboData.CurrentSelection = CraftingTool.ComboTidToIndex(data.toolSkill)
			CraftingTool.ComboData.CurrentSelectionTid = data.toolSkill
			ComboBoxSetSelectedMenuItem(windowName .. "ActiveSkillCombo", CraftingTool.ComboTidToIndex(data.toolSkill))
			CraftingTool.ChangeActiveSkill()
		end
		
		for i = 1, #CraftingTool.LastItems do
			if CraftingTool.LastItems[i] ==	id then
				table.remove(CraftingTool.LastItems, i)
				break
			end
		end
		
		table.insert(CraftingTool.LastItems, 1, id)
		if #CraftingTool.LastItems > CraftingTool.MaxLastItems then
			table.remove(CraftingTool.LastItems, #CraftingTool.LastItems)
		end
	
		if EnhancePack.CraftSkill ~= data.toolSkill then
			UserActionUseItem(CraftingTool.LoadedTools[data.toolSkill].id,false)
			EnhancePack.CraftSkill = data.toolSkill
		end
		CraftingTool.GumpMakeMax = 0
		if string.find(this, "MakeMax") then
			CraftingTool.GumpRequest = "makeMax"
			CraftingTool.GumpRequestSkill = data.toolSkill
			CraftingTool.GumpRequestCategory = data.Category
			CraftingTool.GumpRequestCraftItem = data.tid
			CraftingTool.GumpRequestItemInstance = data.Instance
		elseif string.find(this, "MakeNumber") then
			CraftingTool.GumpRequest = "makeNumber"
			CraftingTool.GumpRequestSkill = data.toolSkill
			CraftingTool.GumpRequestCategory = data.Category
			CraftingTool.GumpRequestCraftItem = data.tid
			CraftingTool.GumpRequestItemInstance = data.Instance
		elseif string.find(this, "Make") then
			CraftingTool.GumpRequest = "make"
			CraftingTool.GumpRequestSkill = data.toolSkill
			CraftingTool.GumpRequestCategory = data.Category
			CraftingTool.GumpRequestCraftItem = data.tid
			CraftingTool.GumpRequestItemInstance = data.Instance
			LabelSetText("CraftingToolWindowItemMade", L"")
		end
		CraftingTool.SendWarning(UI.GetCliloc(SystemData.Settings.Language.type, 7011) , 20, true, true)
	else
		CraftingTool.SendWarning(ReplaceTokens(UI.GetCliloc(SystemData.Settings.Language.type, 5138), {wstring.upper(GetStringFromTid(data.toolSkill))} )   , 5, true, true)
	end
	
end

function CraftingTool.MaterialsMenu()
	local this = SystemData.ActiveWindow.name
	local objectType = WindowGetId(this .. "Icon")
	
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	local skillVal = 120
	if tid then
		local sid = CraftingTool.ComboToSkillId()
		local serverId = WindowData.SkillsCSV[sid].ServerId
		skillVal = WindowData.SkillDynamicData[serverId].TempSkillValue / 10
	end
	

	for i=1, #CraftingTool.MaterialsGroup[objectType] do
		local key = CraftingTool.MaterialsGroup[objectType][i]
		local code
		local matId
		if string.find(this, "Materials1") then
			matId = 1
		else
			matId = 2
		end
		if skillVal >= CraftingTool.Materials[key].minSkill then
			ContextMenu.CreateLuaContextMenuItemWithString(FormatProperly(GetStringFromTid(key)),0,"SETMATERIAL" .. key,{objectType, i, matId, key} ,CraftingTool.CurrentMaterials[tid][matId] == key)
		end
		if i == #CraftingTool.MaterialsGroup[objectType] then
			ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null" ,0 ,false)
			
			local color = CraftingTool.CurrentMaterialsColor[tid][matId]
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1061591),0,"DONOTCOLOR" ,{0, i, matId, key} ,color) -- DO NOT COLOR
		end
	end
		
	ContextMenu.ActivateLuaContextMenu(CraftingTool.MaterialContextMenuCallback)
end

function CraftingTool.MaterialContextMenuCallback( returnCode, param )
	local windowName = "CraftingToolWindow"

	local tid = CraftingTool.ComboToTid()
	
	if string.find(returnCode, "SETMATERIAL") then
		local key = string.gsub(returnCode, "SETMATERIAL", "")
		key = tonumber(key)
				
		if EnhancePack.CraftSkill ~= tid then
			UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
			EnhancePack.CraftSkill = tid
		end
		--CraftingTool.CurrentMaterials[tid][param[3]] = key
		CraftingTool.GumpRequest = "material"
		CraftingTool.GumpRequestSkill = tid
		CraftingTool.GumpRequestMaterial = CraftingTool.Materials[key].tid
		CraftingTool.GumpRequestMaterialGroupID = param
	elseif returnCode == "DONOTCOLOR" then
		if EnhancePack.CraftSkill ~= tid then
			UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
			EnhancePack.CraftSkill = tid
		end
		CraftingTool.GumpRequest = "material"
		CraftingTool.GumpRequestSkill = tid
		CraftingTool.GumpRequestMaterial = 1061591
		CraftingTool.GumpRequestMaterialGroupID = param
	end
end


function CraftingTool.SettingsMenu()
	local windowName = "CraftingToolWindow"
	local tid = CraftingTool.ComboToTid()
	
	--ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5111),0,"setToolsCont",2,false)
	--ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5112),0,"setMatCont",2,false)
	--ContextMenu.CreateLuaContextMenuItemWithString(L" ",0,"null",2,false)


	local flag = 0
	if not CraftingTool.SearchOptions["showMaterials"] then
		flag = ContextMenu.GREYEDOUT 
	end
	
	local options = {
		{str=UI.GetCliloc(SystemData.Settings.Language.type, 5132),flags=0,returnCode="|OPT|showMaterials" , pressed=CraftingTool.SearchOptions["showMaterials"]};
		{str=UI.GetCliloc(SystemData.Settings.Language.type, 5133),flags=flag,returnCode="|OPT|showSubMaterials" ,pressed=CraftingTool.SearchOptions["showSubMaterials"]};
		{str=UI.GetCliloc(SystemData.Settings.Language.type, 5135),flags=0,returnCode="|OPT|showZeroSuccessItems" ,pressed=CraftingTool.SearchOptions["showZeroSuccessItems"]};
		{str=UI.GetCliloc(SystemData.Settings.Language.type, 5136),flags=0,returnCode="|OPT|enableSkillSearch" ,pressed=CraftingTool.SearchOptions["enableSkillSearch"]};
		{str=UI.GetCliloc(SystemData.Settings.Language.type, 5134),flags=0,returnCode="|OPT|searchActiveSkillOnly" ,pressed=CraftingTool.SearchOptions["searchActiveSkillOnly"]};
		{str=L"",flags=0,returnCode="null" ,pressed=false};
		{str=UI.GetCliloc(SystemData.Settings.Language.type, 7005),flags=0,returnCode="|OPT|showAllSkills" ,pressed=CraftingTool.SearchOptions["showAllSkills"]};
		
		}

	local flag = 0
	if CraftingTool.SearchOptions["showAllSkills"] then
		flag = ContextMenu.GREYEDOUT 
	end
	table.insert(options, {str=UI.GetCliloc(SystemData.Settings.Language.type, 7007),flags=flag,returnCode="|OPT|showSkillsAvailable" ,pressed=CraftingTool.SearchOptions["showSkillsAvailable"]})
	
	local flag = 0
	if CraftingTool.SearchOptions["showAllSkills"] then
		flag = ContextMenu.GREYEDOUT 
	end
	table.insert(options, {str=UI.GetCliloc(SystemData.Settings.Language.type, 7006),flags=flag,returnCode="|OPT|showSkillsWithTool" ,pressed=CraftingTool.SearchOptions["showSkillsWithTool"]})
	
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 7029),0,0,"null",false,options)
		

	ContextMenu.CreateLuaContextMenuItemWithString(L" ",0,"null",2,false)

	if not tid or tid == 0 then
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5116),ContextMenu.GREYEDOUT ,"null",2,false)
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5119),ContextMenu.GREYEDOUT ,"null",2,false)
	else
		if CraftingTool.ButtonStatus[tid][8] then
			if CraftingTool.CurrentFlags[tid].quest == false then
				ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5116),0,"questON",2,false)
			else
				ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5117),0,"questOFF",2,false)
			end
		else
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5116),ContextMenu.GREYEDOUT ,"null",2,false)
		end
		
		if CraftingTool.ButtonStatus[tid][7] then
			if CraftingTool.CurrentFlags[tid].mark == 0 then
				ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5120),0,"markPROMPT",2,false)
			elseif CraftingTool.CurrentFlags[tid].mark == 1 then
				ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5121),0,"markOFF",2,false)
			elseif CraftingTool.CurrentFlags[tid].mark == 2 then
				ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5119),0,"markON",2,false)
			end
		else
			ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5119),ContextMenu.GREYEDOUT ,"null",2,false)
		end
		
	end
	if CraftingTool.RunicTools[tid] then
		local subMenu = { }
		for i=1, #CraftingTool.RunicTools[tid] do
			local key = CraftingTool.RunicTools[tid][i]
			local tool = { str = FormatProperly(GetStringFromTid(key)),flags=0,returnCode="SETTOOL" .. key,pressed=CraftingTool.Toolkit[tid] == key }
							
			table.insert(subMenu, tool)
		end
		ContextMenu.CreateLuaContextMenuItemWithString(L" ",0,"null",2,false)
		ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5123),0,0,"null",false,subMenu)
	end
	
	ContextMenu.ActivateLuaContextMenu(CraftingTool.ContextMenuCallback)
end



function CraftingTool.ContextMenuCallback( returnCode, param )
	local windowName = "CraftingToolWindow"
	
	if string.find(returnCode, "|OPT|") then
		returnCode = string.gsub(returnCode, "|OPT|", "")
		
		if returnCode == "showAllSkills" then
			CraftingTool.SearchOptions[returnCode] = not CraftingTool.SearchOptions[returnCode]
			if CraftingTool.SearchOptions["showAllSkills"] == true then
				CraftingTool.SearchOptions["showSkillsWithTool"] = true
				CraftingTool.SearchOptions["showSkillsAvailable"] = false
			else
				CraftingTool.SearchOptions["showSkillsWithTool"] = false
				CraftingTool.SearchOptions["showSkillsAvailable"] = true
			end
			CraftingTool.UpdateCombo()
		elseif returnCode == "showSkillsAvailable" then
			CraftingTool.SearchOptions[returnCode] = not CraftingTool.SearchOptions[returnCode]
			if CraftingTool.SearchOptions["showSkillsAvailable"] == true then
				CraftingTool.SearchOptions["showSkillsWithTool"] = true
				CraftingTool.SearchOptions["showAllSkills"] = false
			else
				CraftingTool.SearchOptions["showSkillsWithTool"] = false
				CraftingTool.SearchOptions["showAllSkills"] = false
			end
			CraftingTool.UpdateCombo()
		elseif returnCode == "showSkillsWithTool" then
			--Debug.Print(returnCode)
			CraftingTool.SearchOptions[returnCode] = not CraftingTool.SearchOptions[returnCode]
			CraftingTool.UpdateCombo()
		
		else
			CraftingTool.SearchOptions[returnCode] = not CraftingTool.SearchOptions[returnCode]
		end
		CraftingTool.ReSearchText()
		return
	end
	
	local tid = CraftingTool.ComboToTid()
	
	if string.find(returnCode, "SETTOOL") then
		local key = string.gsub(returnCode, "SETTOOL", "")
		key = tonumber(key)
		CraftingTool.Toolkit[tid] = key
		CraftingTool.LoadedTools[tid].id = 0
		CraftingTool.LoadedTools[tid].uses = 0
		CraftingTool.SendWarning(ReplaceTokens(UI.GetCliloc(SystemData.Settings.Language.type, 5124), {wstring.upper(GetStringFromTid(key))}), 5, true, true)
		
	elseif (returnCode == "setToolsCont") then
		RequestTargetInfo()
		EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 5110), 1152, true)
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "CraftingTool.SetToolsCont")
	elseif (returnCode == "setMatCont") then
		RequestTargetInfo()
		EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 5110), 1152, true)
		WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "CraftingTool.SetMatsCont")
	elseif (returnCode == "questON" or 
			returnCode == "questOFF"
			) then
		if EnhancePack.CraftSkill ~= tid then
			UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
			EnhancePack.CraftSkill = tid
		end
		CraftingTool.GumpRequest = returnCode
		CraftingTool.GumpRequestSkill = tid
	elseif (returnCode == "markPROMPT" or 
			returnCode == "markOFF" or
			returnCode == "markON"
			) then
		if EnhancePack.CraftSkill ~= tid then
			UserActionUseItem(CraftingTool.LoadedTools[tid].id,false)
			EnhancePack.CraftSkill = tid
		end
		CraftingTool.GumpRequest = returnCode
		CraftingTool.GumpRequestSkill = tid
	end
end

function CraftingTool.SetToolsCont()
	local bag = SystemData.RequestInfo.ObjectId
	if (bag ~= nil and bag ~= 0) then
		 CraftingTool.CraftContainer[currShard][playerID] = bag
		for key, value in pairs(CraftingTool.LoadedTools) do
			CraftingTool.LoadedTools[key].id = 0
			CraftingTool.LoadedTools[key].uses = 0
		end
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
end

function CraftingTool.SetMatsCont()
	local bag = SystemData.RequestInfo.ObjectId
	if (bag ~= nil and bag ~= 0) then
		CraftingTool.MaterialsContainer[currShard][playerID] = bag
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
end

function CraftingTool.MContextMenuCallback( returnCode, param )
	local skill = string.gsub(returnCode, "Mat", "")
	local objID
	local backpackId =  CraftingTool.CraftContainer[currShard][playerID]
	
	local numItems = WindowData.ContainerWindow[backpackId].numItems
	for i = 1, numItems  do
		local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
		
		item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		local itemdata = WindowData.ObjectInfo[item.objectId]
		if itemdata then
			for j = 1, #CraftingTool.Tools[skill] do
				if itemdata.objectType == CraftingTool.Tools[skill][j] then
					objID = item.objectId
					break
				end
			end
		end
		if objID then
			UserActionUseItem(objID,false)
			break
		end
	end
	
	
	
	CraftingTool.GumpRequest = "material"

end

function CraftingTool.OnLButtonUpSearch()
	CraftingTool.SearchText(nil, TextEditBoxGetText("CraftingToolWindowSearchBox"))
end

function CraftingTool.SearchTooltip()
	local windowName = "CraftingToolWindow"
	if WindowGetHandleInput(windowName .. "SearchBox") then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 820))
		
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end
end

function CraftingTool.OnLButtonUpSearch()
	CraftingTool.SearchText(nil, TextEditBoxGetText("CraftingToolWindowSearchBox"))
end

function CraftingTool.RemoveFiltersTooltip()
	local windowName = "CraftingToolWindow"
	if WindowGetHandleInput(windowName .. "SearchBox") then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 824))

		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end
end

function CraftingTool.OptionsButtonMouseOver()
	local windowName = "CraftingToolWindow"
	if WindowGetHandleInput(windowName .. "SearchBox") then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 5131))

		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end
end

function CraftingTool.Tooltip()
	if (CraftingTool.Container == 0) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 822))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 823))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function CraftingTool.ShowLatest()
	CraftingTool.Patterns = {}
	TextEditBoxSetText("CraftingToolWindowSearchBox", L"")
	CraftingTool.ClearItemList()
	
	for j = 1, #CraftingTool.LastItems do
		i = CraftingTool.LastItems[j]
		local name = wstring.lower(CraftingTool.GetStringFromTid(CraftingTool.Craftables[i].tid))
		local found = true
		local success, canDo = CraftingTool.SuccessChance(nil, CraftingTool.Craftables[i])
		if not canDo and not CraftingTool.SearchOptions["showZeroSuccessItems"] then
			continue
		end
		if CraftingTool.SearchOptions["searchActiveSkillOnly"] then
			if not Ctid or CraftingTool.Craftables[i].mainSkill ~= Ctid then
				continue
			end
		end
		table.insert(CraftingTool.Items, i)
	end
	
	CraftingTool.PopulateList()
	CraftingTool.OpenedLast =  true
end

function CraftingTool.SearchText(null, text)
	text = wstring.trim(text)
	if (not text or text == L"" or text == "") then
		return
	end
	text = wstring.gsub(text, L"[-]", L"\[\-\]")
	text = wstring.lower(text)
	
	local ok = true
	for k = 1, table.getn(CraftingTool.Patterns) do
		if text == CraftingTool.Patterns[k] then
			ok = false
			break
		end
	end
	if ok then
		table.insert(CraftingTool.Patterns, text)
		--Debug.Print(L"ADD " .. text)
	end
	CraftingTool.OpenedSearch = true
	
	local windowName = "CraftingToolWindow"

	local Ctid = CraftingTool.ComboToTid()
	
	CraftingTool.OpenedCat = false
	CraftingTool.OpenedLast = false
	CraftingTool.OpenedRecipe = false
	CraftingTool.OpenedSearch = false
	CraftingTool.ClearItemList()
	
	for i = 1, #CraftingTool.Craftables do
		if #CraftingTool.Items >= CraftingTool.MaxSearchItems then
			break
		end
		local name = wstring.lower(CraftingTool.GetStringFromTid(CraftingTool.Craftables[i].tid))
		local found = true
		local success, canDo = CraftingTool.SuccessChance(nil, CraftingTool.Craftables[i])
		if not canDo and not CraftingTool.SearchOptions["showZeroSuccessItems"] then
			continue
		end
		if CraftingTool.SearchOptions["searchActiveSkillOnly"] then
			if not Ctid or CraftingTool.Craftables[i].toolSkill ~= Ctid then
				continue
			end
		end
		for k = 1, table.getn(CraftingTool.Patterns) do
			text = CraftingTool.Patterns[k]
			local m_start = wstring.find(text, L"\"")
			local m_end
			if m_start then
				m_end =  wstring.find(text, L"\"", m_start + 1)
			end
			if m_start and m_end then

				text = wstring.sub(text, m_start+1, m_end-1)

				if name ~= text then
					found = false
					break
				end
			elseif name ~= text and not wstring.find(name, text) then
				local isSkill, tid = CraftingTool.IsSkill(text)
				if  (not (isSkill and (CraftingTool.Craftables[i].mainSkill == tid or CraftingTool.Craftables[i].secondarySkill == tid or CraftingTool.Craftables[i].toolSkill == tid)) or not CraftingTool.SearchOptions["enableSkillSearch"]) then
					found = false
					break
				end
			end
		end
		if found then
			table.insert(CraftingTool.Items, i)
		end	
	end
	
	CraftingTool.PopulateList()
	
	LabelSetText(windowName .. "Total", ReplaceTokens(UI.GetCliloc(SystemData.Settings.Language.type, 5137), {WindowUtils.AddCommasToNumber(#CraftingTool.Items)}))
	
end

function CraftingTool.ReSearchText()

	if CraftingTool.OpenedCat then
		local itm = {}
		for i =1, #CraftingTool.Items do
			table.insert(itm, CraftingTool.Items[i])
		end
		CraftingTool.ClearItemList()
		for i =1, #itm do
			table.insert(CraftingTool.Items, itm[i])
		end
		CraftingTool.PopulateList()
		return
	end
	
	if #CraftingTool.Patterns <= 0 then
		return
	end
	
	
	CraftingTool.OpenedSearch = true
	
	local windowName = "CraftingToolWindow"

	local Ctid = CraftingTool.ComboToTid()
	
	CraftingTool.OpenedCat = false
	CraftingTool.OpenedLast = false
	CraftingTool.OpenedRecipe = false
	CraftingTool.ClearItemList()
	
	
	for i = 1, #CraftingTool.Craftables do
		local name = wstring.lower(CraftingTool.GetStringFromTid(CraftingTool.Craftables[i].tid))
		local found = true
		local success, canDo = CraftingTool.SuccessChance(nil, CraftingTool.Craftables[i])
		if  not canDo and not CraftingTool.SearchOptions["showZeroSuccessItems"] then
			continue
		end
		if CraftingTool.SearchOptions["searchActiveSkillOnly"] then
			if not Ctid or CraftingTool.Craftables[i].mainSkill ~= Ctid then
				continue
			end
		end
		for k = 1, table.getn(CraftingTool.Patterns) do
			text = CraftingTool.Patterns[k]
			local m_start = wstring.find(text, L"\"")
			local m_end
			if m_start then
				m_end =  wstring.find(text, L"\"", m_start + 1)
			end
			if m_start and m_end then

				text = wstring.sub(text, m_start+1, m_end-1)

				if name ~= text then
					found = false
					break
				end
			elseif name ~= text and not wstring.find(name, text) then
				local isSkill, tid = CraftingTool.IsSkill(text)
				if  (not (isSkill and (CraftingTool.Craftables[i].mainSkill == tid or CraftingTool.Craftables[i].secondarySkill == tid or CraftingTool.Craftables[i].toolSkill == tid)) or not CraftingTool.SearchOptions["enableSkillSearch"]) then
					found = false
					break
				end
			end
		end
		if found then
			table.insert(CraftingTool.Items, i)
		end	
	end
	
	CraftingTool.PopulateList()
	
	LabelSetText(windowName .. "Total", ReplaceTokens(UI.GetCliloc(SystemData.Settings.Language.type, 5137), {WindowUtils.AddCommasToNumber(#CraftingTool.Items)}))
end

function CraftingTool.IsSkill(text)

	for key, value in pairs(skillsIndex) do
		local tid = key
		local skillName = wstring.lower(GetStringFromTid(tid))
		if wstring.find(wstring.lower(GetStringFromTid(tid)), wstring.lower(text)) then
			return true, tid
		end
	end
	return false, 0
end

function CraftingTool.LoadCategories()
	CraftingTool.ClearItemList()
	local tid = CraftingTool.ComboToTid()

	if #CraftingTool.Items <= 0 and tid and tid ~= 0 then
		
		local windowName = "CraftingToolWindow"
		
		local i = 0
		
		ScrollWindowUpdateScrollRect( "CraftingToolSW" ) 
		ScrollWindowSetOffset( "CraftingToolSW", 0 )
		local dialog = "CraftingToolSW"
		local parent = dialog.. "ScrollChildCont"
		local scale = WindowGetScale(windowName)
		
		local Width, Height = WindowGetDimensions(parent)
	
		Height = 0
		WindowSetDimensions(parent, Width, Height )
		
		for cat, n in pairs(CraftingTool.SkillsCategory[tid]) do
			i = i + 1
			local slot = "Category" .. i
			local prevSlot = "Category" .. i - 1
			
			CreateWindowFromTemplate(slot, "CraftCategoryTemplate", parent)
			ButtonSetDisabledFlag(slot .. "GoButton", false)
			WindowSetScale (slot, scale)
			local w, h = WindowGetDimensions(slot)
			
			Height = Height + h 
			
			table.insert(CraftingTool.allSlots, slot)
			if i == 1 then
				WindowAddAnchor(slot, "topleft", parent, "topleft", 0, 0)
			else
				WindowAddAnchor(slot, "bottomleft", prevSlot, "topleft", 0, 0)
			end
			if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
				LabelSetFont(slot .. "Name", "UO_DefaultText_ASIA_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end
			LabelSetText(slot .. "Name", FormatProperly(GetStringFromTid(cat)))
			WindowSetId(slot, cat)
		end
		WindowSetDimensions(parent, Width, Height )
		ScrollWindowUpdateScrollRect( "CraftingToolSW" ) 
		ScrollWindowSetOffset( "CraftingToolSW", 0 )
	end
end

function CraftingTool.ClearAll()
	CraftingTool.Restart()
	CraftingTool.LoadCategories()
end

function CraftingTool.Restart()
	CraftingTool.Patterns = {}
	TextEditBoxSetText("CraftingToolWindowSearchBox", L"")
	CraftingTool.ClearItemList()
	local dialog = "CraftingToolSW"
	local parent = dialog.. "ScrollChildCont"
	local Width, Height = WindowGetDimensions(parent)
	
	Height = 0
	WindowSetDimensions(parent, Width, Height )
	ScrollWindowUpdateScrollRect( "CraftingToolSW" ) 
	ScrollWindowSetOffset( "CraftingToolSW", 0 )
	
	CraftingTool.OpenedCat = false
	CraftingTool.OpenedLast = false
	CraftingTool.OpenedRecipe = false
	CraftingTool.OpenedSearch = false
	
end

function CraftingTool.OnItemClicked()
	local this = SystemData.ActiveWindow.name
	local dialog = WindowUtils.GetActiveDialog()
	local objectId = WindowGetId(this)

	if (objectId) then
	    if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			HandleSingleLeftClkTarget(objectId)
	    elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
			DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
			CraftingTool.UpdateList(objectId)
	    end
	end
	
end
function CraftingTool.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local dialog = WindowUtils.GetActiveDialog()
	local id = WindowGetId(this)
	if (id) then
	    local itemData = { windowName = dialog,
					       itemId = id,
	    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
	    			       detail = ItemProperties.DETAIL_LONG }
	    ItemProperties.SetActiveItem(itemData)
	end
end

function CraftingTool.GetStringFromTid(tid, gumpRequest)
	if SystemData.Settings.Language.englishNames then
		return CraftingTool.ENUCliloc[tid]
	else
		return GetStringFromTid(tid)
	end
end