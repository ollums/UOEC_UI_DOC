----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ActionsWindow = {}

ActionsWindow.DefaultPet1 = 0
ActionsWindow.DefaultPet2 = 0
ActionsWindow.DefaultPet3 = 0
ActionsWindow.DefaultPet4 = 0
ActionsWindow.DefaultPet5 = 0

ActionsWindow.DefaultObject1 = 0
ActionsWindow.DefaultObject2 = 0
ActionsWindow.DefaultObject3 = 0
ActionsWindow.DefaultObject4 = 0
ActionsWindow.DefaultObject5 = 0

function ActionsWindow.InitActionData()

	ActionsWindow.ActionData = {}
	ActionsWindow.ActionData[1]  = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=625, nameTid=1078184, detailTid=1115131, editWindow="Equip", paramInfoTid=1078184}
	ActionsWindow.ActionData[2]  = { type=SystemData.UserAction.TYPE_UNEQUIP_ITEMS,					inActionWindow=true, iconId=637, nameTid=1078185, detailTid=1115132, editWindow="UnEquip", paramInfoTid=1078185}
	ActionsWindow.ActionData[3]  = { type=SystemData.UserAction.TYPE_TOGGLE_WAR_MODE,				inActionWindow=true, iconId=635, nameTid=3002081, detailTid=1115133 }
	ActionsWindow.ActionData[4]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=632, nameTid=3002076, detailTid=1115134, editWindow="Text", paramInfoTid=3002006 }
	ActionsWindow.ActionData[5]  = { type=SystemData.UserAction.TYPE_SPEECH_EMOTE,					inActionWindow=true, iconId=624, nameTid=3002077, detailTid=1115135, editWindow="Text", paramInfoTid=3002007 }
	ActionsWindow.ActionData[6]  = { type=SystemData.UserAction.TYPE_SPEECH_WHISPER,				inActionWindow=true, iconId=638, nameTid=3002078, detailTid=1115136, editWindow="Text", paramInfoTid=3002009 }
	ActionsWindow.ActionData[7]  = { type=SystemData.UserAction.TYPE_SPEECH_YELL,					inActionWindow=true, iconId=639, nameTid=3002079, detailTid=1115137, editWindow="Text", paramInfoTid=3002010 }
	ActionsWindow.ActionData[8]  = { type=SystemData.UserAction.TYPE_LAST_SKILL,					inActionWindow=true, iconId=617, nameTid=3002089, detailTid=1115138 }
	ActionsWindow.ActionData[9]  = { type=SystemData.UserAction.TYPE_LAST_SPELL,					inActionWindow=true, iconId=640, nameTid=3002091, detailTid=1115139 }
	ActionsWindow.ActionData[10] = { type=SystemData.UserAction.TYPE_LAST_OBJECT,					inActionWindow=true, iconId=629, nameTid=3002092, detailTid=1115140 }
	ActionsWindow.ActionData[11] = { type=SystemData.UserAction.TYPE_USE_TARGETED_OBJECT,			inActionWindow=true, iconId=646, nameTid=1079159, detailTid=1115141 }
	ActionsWindow.ActionData[12] = { type=SystemData.UserAction.TYPE_BOW,							inActionWindow=true, iconId=622, nameTid=3002093, detailTid=1115142 }
	ActionsWindow.ActionData[13] = { type=SystemData.UserAction.TYPE_SALUTE,						inActionWindow=true, iconId=631, nameTid=3002094, detailTid=1115143 }
	ActionsWindow.ActionData[14] = { type=SystemData.UserAction.TYPE_OPEN_DOOR,						inActionWindow=true, iconId=641, nameTid=3002087, detailTid=1115144 }
	ActionsWindow.ActionData[15] = { type=SystemData.UserAction.TYPE_ALL_NAMES,						inActionWindow=true, iconId=619, nameTid=3002096, detailTid=1115145 }
	ActionsWindow.ActionData[16] = { type=SystemData.UserAction.TYPE_DELAY,							inActionWindow=true, iconId=623, nameTid=3002103, detailTid=1115146, editWindow="Slider", paramInfoTid=3002103, sliderMin=0.0, sliderMax=10.0 }
	ActionsWindow.ActionData[17] = { type=SystemData.UserAction.TYPE_WAIT_FOR_TARGET,				inActionWindow=true, iconId=618, nameTid=3002100, detailTid=1115147 }
	ActionsWindow.ActionData[18] = { type=SystemData.UserAction.TYPE_MACRO,							inActionWindow=false,			 nameTid=3000394, editWindow="Macro" }
	ActionsWindow.ActionData[19] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_LAST,			inActionWindow=true, iconId=644, nameTid=1079156, detailTid=1115148 }
	ActionsWindow.ActionData[20] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_CURRENT,			inActionWindow=true, iconId=643, nameTid=1079157, detailTid=1115149 }
	ActionsWindow.ActionData[21] = { type=SystemData.UserAction.TYPE_CURSOR_TARGET_SELF,			inActionWindow=true, iconId=645, nameTid=1079158, detailTid=1115150 }
	ActionsWindow.ActionData[22] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_FRIENDLY,			inActionWindow=true, iconId=647, nameTid=1079177, detailTid=1115151 }
	ActionsWindow.ActionData[23] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_ENEMY,				inActionWindow=true, iconId=648, nameTid=1079178, detailTid=1115152 }
	ActionsWindow.ActionData[24] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_GROUPMEMBER,		inActionWindow=true, iconId=649, nameTid=1079179, detailTid=1115153 }
	ActionsWindow.ActionData[25] = { type=SystemData.UserAction.TYPE_TARGET_NEXT,					inActionWindow=true, iconId=708, nameTid=1094824, detailTid=1115154 }
	ActionsWindow.ActionData[26] = { type=SystemData.UserAction.TYPE_ARM_DISARM,					inActionWindow=true, iconId=677, nameTid=3002099, detailTid=1115155, editWindow="ArmDisarm", paramInfoTid=1079292 }
	ActionsWindow.ActionData[27] = { type=SystemData.UserAction.TYPE_WAR_MODE,						inActionWindow=true, iconId=675, nameTid=3000086, detailTid=1115156 }
	ActionsWindow.ActionData[28] = { type=SystemData.UserAction.TYPE_PEACE_MODE, 					inActionWindow=true, iconId=676, nameTid=3000085, detailTid=1115157 }
	ActionsWindow.ActionData[29] = { type=SystemData.UserAction.TYPE_PET_COMMAND_ALLKILL,			inActionWindow=true, iconId=650, nameTid=1079300, detailTid=1115158 }
	ActionsWindow.ActionData[30] = { type=SystemData.UserAction.TYPE_PET_COMMAND_COME,				inActionWindow=true, iconId=651, nameTid=1079301, detailTid=1115159 }
	ActionsWindow.ActionData[31] = { type=SystemData.UserAction.TYPE_PET_COMMAND_FOLLOW,			inActionWindow=true, iconId=655, nameTid=1079302, detailTid=1115160 }
	ActionsWindow.ActionData[32] = { type=SystemData.UserAction.TYPE_PET_COMMAND_FOLLOWME,			inActionWindow=true, iconId=656, nameTid=1079303, detailTid=1115161 }
	ActionsWindow.ActionData[33] = { type=SystemData.UserAction.TYPE_PET_COMMAND_GUARD,				inActionWindow=true, iconId=657, nameTid=1079304, detailTid=1115163 }
	ActionsWindow.ActionData[34] = { type=SystemData.UserAction.TYPE_PET_COMMAND_GUARDME,			inActionWindow=true, iconId=658, nameTid=1079305, detailTid=1115162 }
	ActionsWindow.ActionData[35] = { type=SystemData.UserAction.TYPE_PET_COMMAND_STAY,				inActionWindow=true, iconId=660, nameTid=1079306, detailTid=1115164 }
	ActionsWindow.ActionData[36] = { type=SystemData.UserAction.TYPE_PET_COMMAND_STOP,				inActionWindow=true, iconId=661, nameTid=1079307, detailTid=1115165 }
	ActionsWindow.ActionData[37] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_LEFT,		inActionWindow=true, iconId=668, nameTid=1079313, detailTid=1115166 }
	ActionsWindow.ActionData[38] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_RIGHT,	inActionWindow=true, iconId=669, nameTid=1079314, detailTid=1115167 }
	ActionsWindow.ActionData[39] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD,			inActionWindow=true, iconId=667, nameTid=1079325, detailTid=1115168 }
	ActionsWindow.ActionData[40] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_LEFT,	inActionWindow=true, iconId=653, nameTid=1079315, detailTid=1115169 }
	ActionsWindow.ActionData[41] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_RIGHT,	inActionWindow=true, iconId=654, nameTid=1079316, detailTid=1115170 }
	ActionsWindow.ActionData[42] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARDS,		inActionWindow=true, iconId=652, nameTid=1079317, detailTid=1115171 }
	ActionsWindow.ActionData[43] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_LEFT,				inActionWindow=true, iconId=664, nameTid=1079318, detailTid=1115172 }
	ActionsWindow.ActionData[44] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_RIGHT,			inActionWindow=true, iconId=665, nameTid=1079319, detailTid=1115173 }
	ActionsWindow.ActionData[45] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_LEFT,		inActionWindow=true, iconId=670, nameTid=1079320, detailTid=1115174 }
	ActionsWindow.ActionData[46] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_RIGHT,		inActionWindow=true, iconId=672, nameTid=1079321, detailTid=1115175 }
	ActionsWindow.ActionData[47] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_AROUND,		inActionWindow=true, iconId=662, nameTid=1079322, detailTid=1115176 }
	ActionsWindow.ActionData[48] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_DORACRON,			inActionWindow=true, iconId=663, nameTid=1079323, detailTid=1115177 }
	ActionsWindow.ActionData[49] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_SUEACRON,			inActionWindow=true, iconId=674, nameTid=1079324, detailTid=1115178 }
	ActionsWindow.ActionData[50] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_STOP,				inActionWindow=true, iconId=673, nameTid=1052073, detailTid=1115179, editWindow="Text", paramInfoTid=3002006, callback=L"Furl Sail"  }
	ActionsWindow.ActionData[51] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_DROP_ANCHOR,		inActionWindow=true, iconId=666, nameTid=1079333, detailTid=1115180 }
	ActionsWindow.ActionData[52] = { type=SystemData.UserAction.TYPE_BOAT_COMMAND_RAISE_ANCHOR,		inActionWindow=true, iconId=671, nameTid=1079334, detailTid=1115181 }
	ActionsWindow.ActionData[53] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=694, nameTid=3005113, detailTid=1115182, editWindow="Text", paramInfoTid=3002006, callback=L"Start" }
	ActionsWindow.ActionData[54] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=695, nameTid=1052072, detailTid=1115183, editWindow="Text", paramInfoTid=3002006, callback=L"Continue" }
	ActionsWindow.ActionData[55] = { type=SystemData.UserAction.TYPE_TARGET_BY_RESOURCE,			inActionWindow=true, iconId=770, nameTid=1079430, detailTid=1115184, editWindow="TargetByResource", paramInfoTid=1079430 }
	ActionsWindow.ActionData[56] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=771, nameTid=1094786, detailTid=1115185, editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[57] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=790, nameTid=3002105, detailTid=1115186, editWindow="Text", paramInfoTid=3002105 }
	ActionsWindow.ActionData[58] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=701, nameTid=1051005, detailTid=1052058, invokeId=1 } -- Honor
	ActionsWindow.ActionData[59] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=706, nameTid=1051001, detailTid=1052053, invokeId=2 } -- Sacrifice
	ActionsWindow.ActionData[60] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=700, nameTid=1051004, detailTid=1052057, invokeId=3 } -- Valor
	ActionsWindow.ActionData[61] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=702, nameTid=1051002, detailTid=1053000, invokeId=4 } -- Compassion
	ActionsWindow.ActionData[62] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=704, nameTid=1051007, detailTid=1052060, invokeId=5 } -- Honesty
	ActionsWindow.ActionData[63] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=707, nameTid=1051000, detailTid=1052051, invokeId=6 } -- Humility
	ActionsWindow.ActionData[64] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=703, nameTid=1051006, detailTid=1052059, invokeId=7 } -- Justice
	ActionsWindow.ActionData[65] = { type=SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow=true, iconId=705, nameTid=1051003, detailTid=1052056, invokeId=8 } -- Spirituality
	ActionsWindow.ActionData[66] = { type=SystemData.UserAction.TYPE_CYCLE_CURSOR_TARGET,			inActionWindow=true, iconId=772, nameTid=1112413, detailTid=1115187 }
	ActionsWindow.ActionData[67] = { type=SystemData.UserAction.TYPE_ATTACK_CURRENT_TARGET,			inActionWindow=true, iconId=773, nameTid=1112414, detailTid=1115188 }
	ActionsWindow.ActionData[68] = { type=SystemData.UserAction.TYPE_ATTACK_LAST_CURSOR_TARGET,		inActionWindow=true, iconId=774, nameTid=1112415, detailTid=1115190 }
	ActionsWindow.ActionData[69] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_FOLLOWER,			inActionWindow=true, iconId=775, nameTid=1112416, detailTid=1115191 }
	ActionsWindow.ActionData[70] = { type=SystemData.UserAction.TYPE_TARGET_NEXT_OBJECT,			inActionWindow=true, iconId=776, nameTid=1112420, detailTid=1115192 }
	ActionsWindow.ActionData[71] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_FRIENDLY,		inActionWindow=true, iconId=777, nameTid=1112431, detailTid=1115193 }
	ActionsWindow.ActionData[72] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_ENEMY,			inActionWindow=true, iconId=778, nameTid=1112432, detailTid=1115194 }
	ActionsWindow.ActionData[73] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_GROUPMEMBER,	inActionWindow=true, iconId=779, nameTid=1112433, detailTid=1115195 }
	ActionsWindow.ActionData[74] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_FOLLOWER,		inActionWindow=true, iconId=780, nameTid=1112434, detailTid=1115196 }
	ActionsWindow.ActionData[75] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS_OBJECT,		inActionWindow=true, iconId=781, nameTid=1112435, detailTid=1115197 }
	ActionsWindow.ActionData[76] = { type=SystemData.UserAction.TYPE_TARGET_PREVIOUS,				inActionWindow=true, iconId=782, nameTid=1112436, detailTid=1115198 }
	ActionsWindow.ActionData[77] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_FRIENDLY,		inActionWindow=true, iconId=783, nameTid=1112437, detailTid=1115199 }
	ActionsWindow.ActionData[78] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_ENEMY,			inActionWindow=true, iconId=784, nameTid=1112438, detailTid=1115200 }
	ActionsWindow.ActionData[79] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_GROUPMEMBER,	inActionWindow=true, iconId=785, nameTid=1112439, detailTid=1115201 }
	ActionsWindow.ActionData[80] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_FOLLOWER,		inActionWindow=true, iconId=786, nameTid=1112440, detailTid=1115202 }
	ActionsWindow.ActionData[81] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST_OBJECT,			inActionWindow=true, iconId=787, nameTid=1112441, detailTid=1115203 }
	ActionsWindow.ActionData[82] = { type=SystemData.UserAction.TYPE_TARGET_NEAREST,				inActionWindow=true, iconId=788, nameTid=1112442, detailTid=1115204 }
	ActionsWindow.ActionData[83] = { type=SystemData.UserAction.TYPE_TOGGLE_ALWAYS_RUN,				inActionWindow=true, iconId=789, nameTid=1113150, detailTid=1115205 }
	ActionsWindow.ActionData[84] = { type=SystemData.UserAction.TYPE_TOGGLE_CIRCLE_OF_TRANSPARENCY,	inActionWindow=true, iconId=791, nameTid=1079818, detailTid=1115206 }
	ActionsWindow.ActionData[85] = { type=SystemData.UserAction.TYPE_EQUIP_LAST_WEAPON,				inActionWindow=true, iconId=792, nameTid=1114305, detailTid=1115207 }
	ActionsWindow.ActionData[86] = { type=SystemData.UserAction.TYPE_BANDAGE_SELF,					inActionWindow=true, iconId=793, nameTid=1114306, detailTid=1115208 }
	ActionsWindow.ActionData[87] = { type=SystemData.UserAction.TYPE_BANDAGE_SELECTED_TARGET,		inActionWindow=true, iconId=794, nameTid=1114307, detailTid=1115209 }
	ActionsWindow.ActionData[88] = { type=SystemData.UserAction.TYPE_QUIT_GAME,						inActionWindow=true, iconId=795, nameTid=1114308, detailTid=1115210 }
	ActionsWindow.ActionData[89] = { type=SystemData.UserAction.TYPE_LOG_OUT,						inActionWindow=true, iconId=796, nameTid=1115334, detailTid=1115335 }
	ActionsWindow.ActionData[90] = { type=SystemData.UserAction.TYPE_CLEAR_TARGET_QUEUE,			inActionWindow=true, iconId=797, nameTid=1115342, detailTid=1115344 }
	ActionsWindow.ActionData[91] = { type=SystemData.UserAction.TYPE_DISMOUNT,						inActionWindow=true, iconId=798, nameTid=1115935, detailTid=1115936 }

	ActionsWindow.ActionData[5001] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=724, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 8), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 9), callback=L"script EnhancePack.ToggleFoliage()" }
	ActionsWindow.ActionData[5002] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=729, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 10), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 11), callback=L"script EnhancePack.ToggleSound()"}
	ActionsWindow.ActionData[5003] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=720, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 12), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 13), callback=L"script EnhancePack.ToggleQuickDetails()" }
	ActionsWindow.ActionData[5004] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860000, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 14), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 15), callback=L"script Hourglass.Toggle()" }
	ActionsWindow.ActionData[5005] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860001, detailString=L"", nameTid=1077438, callback=L"script EnhancePack.ToggleMapWindow()" }
	ActionsWindow.ActionData[5006] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860002, detailString=L"", nameTid=1049755, callback=L"script EnhancePack.ToggleMainMenu()" }
	ActionsWindow.ActionData[5007] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860003, detailString=L"", nameTid=1077440, callback=L"script EnhancePack.ToggleQuestWindow()"}
	ActionsWindow.ActionData[5008] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860004, detailString=L"", nameTid=1077439, callback=L"script EnhancePack.ToggleVirtuesWindow()"}
	ActionsWindow.ActionData[5009] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860005, detailString=L"", nameTid=1063308, callback=L"script EnhancePack.ToggleGuildWindow()" }
	ActionsWindow.ActionData[5010] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860006, detailString=L"", nameTid=3000133, callback=L"script EnhancePack.TogglePaperdollWindow()" }
	ActionsWindow.ActionData[5011] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860007, detailString=L"", nameTid=3000084, callback=L"script SkillsWindow.ToggleSkillsWindow()" }
	ActionsWindow.ActionData[5012] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860008, detailString=L"", nameTid=1114078, callback=L"script EnhancePack.ToggleChatWindow()" }
	ActionsWindow.ActionData[5013] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860009, detailString=L"", nameTid=1077437, callback=L"script EnhancePack.ToggleCharacterSheet()" }
	ActionsWindow.ActionData[5014] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860010, detailString=L"", nameTid=1112228, callback=L"script EnhancePack.ToggleCharacterAbilities()" }
	ActionsWindow.ActionData[5015] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860011, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 16), callback=L"script EnhancePack.ToggleInventoryWindow()" }
	ActionsWindow.ActionData[5016] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860012, detailTid=1115316, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 17), callback=L"script EnhancePack.IgnorePlayer()" }
	ActionsWindow.ActionData[5017] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860013, detailString=L"", nameTid=1077814, callback=L"script EnhancePack.ToggleUserSettings()" }
	ActionsWindow.ActionData[5018] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860014, detailString=L"", nameTid=1079812, callback=L"script EnhancePack.ToggleActions()"}
	ActionsWindow.ActionData[5019] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860015, detailString=L"", nameTid=3000172, callback=L"script EnhancePack.ToggleMacros()" }
	ActionsWindow.ActionData[5020] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860016, detailString=L"", nameTid=1061037, callback=L"script EnhancePack.ToggleHelp()" }
	ActionsWindow.ActionData[5021] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860017, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 18), callback=L"script EnhancePack.ToggleClock()" }
	ActionsWindow.ActionData[5022] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=718, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 19), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 20), callback=L"script EnhancePack.ToggleObjectHandle()" }
	ActionsWindow.ActionData[5023] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860018, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 21), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 22),  callback=L"script EnhancePack.ToggleBookRecorder()" }
	ActionsWindow.ActionData[5024] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860019, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 23), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 24),  callback=L"script EnhancePack.UOTemplateEditor()" }
	ActionsWindow.ActionData[5025] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860020, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 25), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 26),  callback=L"script EnhancePack.GetTypeID()" }
	ActionsWindow.ActionData[5026] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860021, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 27), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 28),  callback=L"script EnhancePack.GetHueID()" }
	ActionsWindow.ActionData[5027] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860022, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 29), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 30),  callback=L"script EnhancePack.IgnoreTargettedItem()" }
	ActionsWindow.ActionData[5028] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860023, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 31), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 32),  callback=L"script EnhancePack.ClearIgnoreList()" }
	ActionsWindow.ActionData[5029] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855030, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 33), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 34),  callback=L"script EnhancePack.GetHealthbar()" }
	ActionsWindow.ActionData[5030] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860025, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 35),  callback=L"script ServerLine.Toggle()" }
	ActionsWindow.ActionData[5031] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860026, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 36),  callback=L"script EnhancePack.ToggleUOCartographer()" }
	ActionsWindow.ActionData[5032] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860027, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 37),  callback=L"script EnhancePack.SetTrapBox()" }
	ActionsWindow.ActionData[5033] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860028, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 38),  callback=L"script EnhancePack.UnsetYourTrapbox()" }
	ActionsWindow.ActionData[5034] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860029, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 39),  callback=L"script EnhancePack.SetLootBag()" }
	ActionsWindow.ActionData[5035] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860030, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 40),  callback=L"script EnhancePack.UnsetYourLootbag()" }
	ActionsWindow.ActionData[5036] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860031, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 41), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 42),  callback=L"script EnhancePack.ToggleScaleMode()" }
	ActionsWindow.ActionData[5037] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860032, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 43), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 44),  callback=L"script EnhancePack.ToggleSadMode()" }
	ActionsWindow.ActionData[5038] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860033, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 45), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 46),  callback=L"script EnhancePack.CloseAllCorpses()" }
	ActionsWindow.ActionData[5039] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855502, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 47),  callback=L"script EnhancePack.ToggleLegacyContainers()" }
	ActionsWindow.ActionData[5040] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860035, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 48), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 49),  callback=L"script EnhancePack.ToggleBlockPaperdolls()" }
	ActionsWindow.ActionData[5041] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860036, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 50),  callback=L"script MobilesOnScreen.Clear()" }
	ActionsWindow.ActionData[5051] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860049, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 582), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 581),  callback=L"script MapWindow.BigToggle()" }
	ActionsWindow.ActionData[5052] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860050, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 611),  callback=L"script MainMenuWindow.OnToggleAgentsSettings()" }
	ActionsWindow.ActionData[5053] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860051, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 613), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 612),  callback=L"script EnhancePack.DropHolding()" }
	ActionsWindow.ActionData[5054] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860053, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 627), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 626),  callback=L"script EnhancePack.ToggleQuickLoot()" }
	ActionsWindow.ActionData[5055] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860054, detailTid=1115919, nameTid=1115918,  callback=L"script EnhancePack.IgnoreActionSelf()" }
	ActionsWindow.ActionData[5056] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860055, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 645), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 638),  callback=L"script EnhancePack.ImbuingCalc()" }
	ActionsWindow.ActionData[5057] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860056, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 649),  callback=L"script EnhancePack.CloseAllHealthbars()" }

	ActionsWindow.ActionData[5058] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860057, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 655), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 654), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 654) }
	ActionsWindow.ActionData[5059] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860058, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 659), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 658), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 658) }

	ActionsWindow.ActionData[5047] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860046, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 531), nameString=GetStringFromTid(1113945),  callback=L"script CrystalPortal.Toggle()" }
	ActionsWindow.ActionData[5048] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=719, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 571), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 570), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 574) }
	ActionsWindow.ActionData[5049] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=730, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 573), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 572), callback=L"script PlaySound(1, nil, 1)" }

	ActionsWindow.ActionData[5042] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855101, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 51), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 52), callback=L"script EnhancePack.TargetDefaultPet(1)" }
	ActionsWindow.ActionData[5043] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855102, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 53), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 54), callback=L"script EnhancePack.TargetDefaultPet(2)" }
	ActionsWindow.ActionData[5044] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855103, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 55), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 56), callback=L"script EnhancePack.TargetDefaultPet(3)" }
	ActionsWindow.ActionData[5045] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855104, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 57), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 58), callback=L"script EnhancePack.TargetDefaultPet(4)" }
	ActionsWindow.ActionData[5046] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855105, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 59), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 60), callback=L"script EnhancePack.TargetDefaultPet(5)" }

	ActionsWindow.ActionData[5050] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860045, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 61), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 62), callback=L"script EnhancePack.PrevTarget()" }

	ActionsWindow.ActionData[5065] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855110, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 63), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 64), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultPet1 )" }
	ActionsWindow.ActionData[5066] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855111, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 65), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 66), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultPet2 )" }
	ActionsWindow.ActionData[5067] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855112, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 67), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 68), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultPet3 )" }
	ActionsWindow.ActionData[5068] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855113, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 69), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 70), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultPet4 )" }
	ActionsWindow.ActionData[5069] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855114, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 71), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 72), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultPet5 )" }

	ActionsWindow.ActionData[5070] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855064, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 74) }
	ActionsWindow.ActionData[5071] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855065, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 75) }
	ActionsWindow.ActionData[5072] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855066, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 76) }
	ActionsWindow.ActionData[5073] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855067, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 77) }
	ActionsWindow.ActionData[5074] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855068, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 78) }
	ActionsWindow.ActionData[5075] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855069, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 79) }
	ActionsWindow.ActionData[5076] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855080, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 80) }
	ActionsWindow.ActionData[5077] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855072, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 81) }
	ActionsWindow.ActionData[5078] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855073, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 82) }
	ActionsWindow.ActionData[5079] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855074, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 83) }
	ActionsWindow.ActionData[5080] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855075, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 84) }
	ActionsWindow.ActionData[5081] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855076, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 85) }
	ActionsWindow.ActionData[5082] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855077, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 86) }
	ActionsWindow.ActionData[5083] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855078, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 77) }
	ActionsWindow.ActionData[5084] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855079, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 73), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 88) }

	ActionsWindow.ActionData[5085] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860100, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 90) }
	ActionsWindow.ActionData[5086] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860101, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 91) }
	ActionsWindow.ActionData[5087] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860102, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 92) }
	ActionsWindow.ActionData[5088] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860103, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 93) }
	ActionsWindow.ActionData[5089] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860104, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 94) }
	ActionsWindow.ActionData[5090] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860105, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 95) }
	ActionsWindow.ActionData[5091] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860106, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 96) }
	ActionsWindow.ActionData[5092] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860107, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 97) }
	ActionsWindow.ActionData[5093] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860108, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 98) }
	ActionsWindow.ActionData[5094] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860109, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 99) }
	ActionsWindow.ActionData[5095] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860110, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 100) }
	ActionsWindow.ActionData[5096] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860111, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 89), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 101) }
	ActionsWindow.ActionData[5097] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860047, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 580), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 579) }
	ActionsWindow.ActionData[5098] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860052, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 615), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 614) }

	ActionsWindow.ActionData[5100]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855002, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 102), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 103), editWindow="Text", paramInfoTid=3002006, callback=L"Bank"}
	ActionsWindow.ActionData[5101]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855005, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 104), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 105), editWindow="Text", paramInfoTid=3002006, callback=L"Guards ! Help Me !!!"}
	ActionsWindow.ActionData[5102]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855008, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 106), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 107), editWindow="Text", paramInfoTid=3002006, callback=L"Vendor Buy"}
	ActionsWindow.ActionData[5103]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855011, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 108), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 109), editWindow="Text", paramInfoTid=3002006, callback=L"Vendor Sell"}
	ActionsWindow.ActionData[5104]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855014, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 110), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 111), editWindow="Text", paramInfoTid=3002006, callback=L"Recsu"}
	ActionsWindow.ActionData[5105]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855015, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 112), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 113), editWindow="Text", paramInfoTid=3002006, callback=L"Recdu"}
	ActionsWindow.ActionData[5106]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855016, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 114), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 115), editWindow="Text", paramInfoTid=3002006, callback=L"I Must Consider My Sins"}
	ActionsWindow.ActionData[5107]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855003, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 116), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 117), editWindow="Text", paramInfoTid=3002006, callback=L"Balance"}
	ActionsWindow.ActionData[5108]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855017, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 118), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 119), editWindow="Text", paramInfoTid=3002006, callback=L"Ord"}
	ActionsWindow.ActionData[5109]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855018, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 120), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 121), editWindow="Text", paramInfoTid=3002006, callback=L"An Ord"}
	ActionsWindow.ActionData[5110]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855019, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 122), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 123), editWindow="Text", paramInfoTid=3002006, callback=L"I Honor Your Leadership"}
	ActionsWindow.ActionData[5111]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855023, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 124), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 125), editWindow="Text", paramInfoTid=3002006, callback=L"Punkte"}

	ActionsWindow.ActionData[5120]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855012, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 126), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 127), editWindow="Text", paramInfoTid=3002006, callback=L"Stable"}
	ActionsWindow.ActionData[5121]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855013, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 128), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 129), editWindow="Text", paramInfoTid=3002006, callback=L"Claim Pet"}
	ActionsWindow.ActionData[5122]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=713, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 130), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 131), editWindow="Text", paramInfoTid=3002006, callback=L"I Wish To Secure This"}
	ActionsWindow.ActionData[5123]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=714, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 132), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 133), editWindow="Text", paramInfoTid=3002006, callback=L"I Wish To Release This"}
	ActionsWindow.ActionData[5124]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=715, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 134), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 135), editWindow="Text", paramInfoTid=3002006, callback=L"I Wish To Lock This Down"}
	ActionsWindow.ActionData[5125]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855020, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 136), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 137), editWindow="Text", paramInfoTid=3002006, callback=L"I Wish To Place A Trash Barrel"}
	ActionsWindow.ActionData[5126]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855021, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 138), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 139), editWindow="Text", paramInfoTid=3002006, callback=L"Stablecount"}
	ActionsWindow.ActionData[5127]  = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=855022, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 140), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 141), editWindow="Text", paramInfoTid=3002006, callback=L"News"}

	ActionsWindow.ActionData[6000] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855550, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 142)}
	ActionsWindow.ActionData[6001] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855551, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 143)}
	ActionsWindow.ActionData[6002] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855552, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 144)}
	ActionsWindow.ActionData[6003] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855553, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 145)}
	ActionsWindow.ActionData[6004] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855554, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 146)}
	ActionsWindow.ActionData[6005] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855555, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 147)}
	ActionsWindow.ActionData[6006] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855556, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 148)}

	ActionsWindow.ActionData[6020] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855577, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 149)}
	ActionsWindow.ActionData[6021] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855581, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 150)}
	ActionsWindow.ActionData[6022] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855585, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 151)}
	ActionsWindow.ActionData[6023] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855602, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 152)}
	ActionsWindow.ActionData[6024] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855627, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 153)}
	ActionsWindow.ActionData[6025] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855630, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 154)}
	ActionsWindow.ActionData[6026] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855633, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 155)}
	ActionsWindow.ActionData[6027] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855636, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 156)}
	ActionsWindow.ActionData[6028] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855639, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 157)}
	ActionsWindow.ActionData[6029] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855642, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 158)}
	ActionsWindow.ActionData[6030] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855645, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 159)}
	ActionsWindow.ActionData[6031] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855676, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 160)}
	ActionsWindow.ActionData[6032] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855679, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 161)}
	ActionsWindow.ActionData[6033] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855682, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 162)}
	ActionsWindow.ActionData[6034] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855701, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 163)}
	ActionsWindow.ActionData[6035] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855704, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 164)}
	ActionsWindow.ActionData[6036] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855707, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 165)}
	ActionsWindow.ActionData[6037] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855710, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 166)}
	ActionsWindow.ActionData[6038] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855712, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 167)}
	ActionsWindow.ActionData[6039] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855711, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 168)}

	ActionsWindow.ActionData[6050] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855903, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 169)}
	ActionsWindow.ActionData[6051] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855906, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 170)}
	ActionsWindow.ActionData[6052] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855909, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 171)}
	ActionsWindow.ActionData[6053] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855912, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 172)}
	ActionsWindow.ActionData[6054] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855915, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 173)}
	ActionsWindow.ActionData[6055] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855918, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 174)}
	ActionsWindow.ActionData[6056] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855921, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 175)}
	ActionsWindow.ActionData[6057] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855924, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 176)}
	ActionsWindow.ActionData[6058] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855926, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 177)}
	ActionsWindow.ActionData[6059] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855927, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 178)}
	ActionsWindow.ActionData[6060] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855995, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 179)}

	ActionsWindow.ActionData[6100] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855405, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 180), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 181), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[6101] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855406, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 182), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 183), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[6102] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855407, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 184), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 185), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[6103] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855408, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 186), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 187), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[6104] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855409, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 188), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 189), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[6105] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855410, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 190), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 191), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[6106] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855411, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 192), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 193), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[6107] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855412, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 194), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 195), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }
	ActionsWindow.ActionData[6108] = { type=SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow=true, iconId=855413, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 196), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 197), editWindow="TargetByObjectId", paramInfoTid=1094788, hideOK=true }

	ActionsWindow.ActionData[6150] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855167, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 198)}
	ActionsWindow.ActionData[6151] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855152, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 199)}
	ActionsWindow.ActionData[6152] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855155, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 200)}
	ActionsWindow.ActionData[6153] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855158, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 201)}
	ActionsWindow.ActionData[6154] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855161, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 202)}
	ActionsWindow.ActionData[6155] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855164, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 203)}
	ActionsWindow.ActionData[6156] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855190, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 204)}
	ActionsWindow.ActionData[6157] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855191, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 205)}
	ActionsWindow.ActionData[6158] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855192, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 206)}
	ActionsWindow.ActionData[6159] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855193, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 207)}
	ActionsWindow.ActionData[6160] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855194, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 208)}

	ActionsWindow.ActionData[6170] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855202, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 209)}
	ActionsWindow.ActionData[6171] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855240, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 210)}
	ActionsWindow.ActionData[6172] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855241, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 211)}
	ActionsWindow.ActionData[6173] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855242, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 212)}
	ActionsWindow.ActionData[6174] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855243, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 213)}
	ActionsWindow.ActionData[6175] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855244, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 214)}

	ActionsWindow.ActionData[6190] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855260, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 215)}
	ActionsWindow.ActionData[6191] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855261, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 216)}
	ActionsWindow.ActionData[6192] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855262, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 217)}
	ActionsWindow.ActionData[6193] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855263, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 218)}
	ActionsWindow.ActionData[6194] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855270, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 219)}
	ActionsWindow.ActionData[6195] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855271, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 220)}
	ActionsWindow.ActionData[6196] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855272, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 221)}
	ActionsWindow.ActionData[6197] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855273, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 222)}
	ActionsWindow.ActionData[6198] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855274, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 223)}

	ActionsWindow.ActionData[6210] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855196, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 224)}
	ActionsWindow.ActionData[6211] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855197, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 225)}
	ActionsWindow.ActionData[6212] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855198, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 226)}
	ActionsWindow.ActionData[6213] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855199, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 227)}
	ActionsWindow.ActionData[6214] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855195, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 228)}
	ActionsWindow.ActionData[6215] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855205, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 229)}
	ActionsWindow.ActionData[6216] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855206, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 230)}

	ActionsWindow.ActionData[6220] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855200, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 231)}
	ActionsWindow.ActionData[6221] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855201, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 232)}
	ActionsWindow.ActionData[6222] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855203, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 233)}
	ActionsWindow.ActionData[6223] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855204, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 234)}

	ActionsWindow.ActionData[6250] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855302, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 235)}
	ActionsWindow.ActionData[6251] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855305, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 236)}
	ActionsWindow.ActionData[6252] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855308, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 237)}
	ActionsWindow.ActionData[6253] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855311, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 238)}
	ActionsWindow.ActionData[6254] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855314, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 239)}
	ActionsWindow.ActionData[6255] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855317, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 240)}
	ActionsWindow.ActionData[6256] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855320, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 241)}
	ActionsWindow.ActionData[6257] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855323, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 242)}
	ActionsWindow.ActionData[6258] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855326, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 243)}
	ActionsWindow.ActionData[6259] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855329, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 244)}
	ActionsWindow.ActionData[6260] = { type=SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow=true, iconId=855332, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 245)}

	ActionsWindow.ActionData[7000] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=00709, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 721), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 725), editWindow="Text", paramInfoTid=3002006, callback=L"Slow Forward" }
	ActionsWindow.ActionData[7001] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=00711, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 722), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 726), editWindow="Text", paramInfoTid=3002006, callback=L"Forward One" }
	ActionsWindow.ActionData[7002] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=00710, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 723), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 727), editWindow="Text", paramInfoTid=3002006, callback=L"Slow Back" }
	ActionsWindow.ActionData[7003] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=00712, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 724), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 728), editWindow="Text", paramInfoTid=3002006, callback=L"Back One" }
	ActionsWindow.ActionData[7004] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860089, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 741), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 740),  callback=L"script EnhancePack.DressHolding()" }
	ActionsWindow.ActionData[7005] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860090, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 767), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 766),  callback=L"script EnhancePack.ToggleKeepAlive()" }

	ActionsWindow.ActionData[7020] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870134, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 892), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 893), callback=L"script EnhancePack.TargetDefaultItem(1)" }
	ActionsWindow.ActionData[7021] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870135, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 894), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 895), callback=L"script EnhancePack.TargetDefaultItem(2)" }
	ActionsWindow.ActionData[7022] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870136, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 896), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 897), callback=L"script EnhancePack.TargetDefaultItem(3)" }
	ActionsWindow.ActionData[7023] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870137, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 898), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 899), callback=L"script EnhancePack.TargetDefaultItem(4)" }
	ActionsWindow.ActionData[7024] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870138, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 900), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 901), callback=L"script EnhancePack.TargetDefaultItem(5)" }

	ActionsWindow.ActionData[7025] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870139, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 902), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 903), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultObject1 )" }
	ActionsWindow.ActionData[7026] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870140, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 904), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 905), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultObject2 )" }
	ActionsWindow.ActionData[7027] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870141, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 906), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 907), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultObject3 )" }
	ActionsWindow.ActionData[7028] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870142, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 908), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 909), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultObject4 )" }
	ActionsWindow.ActionData[7029] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870143, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 910), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 911), callback=L"script HandleSingleLeftClkTarget( ActionsWindow.DefaultObject5 )" }

	ActionsWindow.ActionData[7030] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=870144, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 914), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 915), editWindow="Text", paramInfoTid=3002006, callback=L"Start Tracking" }
	ActionsWindow.ActionData[7031] = { type=SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow=true, iconId=870145, nameString=UI.GetCliloc(SystemData.Settings.Language.type, 916), detailString=UI.GetCliloc(SystemData.Settings.Language.type, 917), editWindow="Text", paramInfoTid=3002006, callback=L"Stop Tracking" }

	--- 10000 to 15000 reserved for user action commands
	ActionsWindow.ActionData[10000] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860091, detailString=L"", nameString=GetStringFromTid(1113797),  callback=L"script EnhancePack.EnablePVPWarning()" }
	ActionsWindow.ActionData[10001] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860092, detailString=L"", nameString=GetStringFromTid(3006205),  callback=L"script EnhancePack.ReleaseCoownership()" }
	ActionsWindow.ActionData[10002] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860093, detailString=L"", nameString=GetStringFromTid(3006207),  callback=L"script EnhancePack.LeaveHouse()" }
	ActionsWindow.ActionData[10003] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860094, detailString=L"", nameString=GetStringFromTid(3006156),  callback=L"script EnhancePack.QuestConversation()" }
	ActionsWindow.ActionData[10004] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860095, detailString=L"", nameString=GetStringFromTid(3006154),  callback=L"script EnhancePack.ViewQuestLog()" }
	ActionsWindow.ActionData[10005] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860096, detailString=L"", nameString=GetStringFromTid(3006155),  callback=L"script EnhancePack.CancelQuest()" }
	ActionsWindow.ActionData[10006] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860097, detailString=L"", nameString=GetStringFromTid(3006169),  callback=L"script EnhancePack.QuestItem()" }
	ActionsWindow.ActionData[10007] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860098, detailString=L"", nameString=GetStringFromTid(1114299),  callback=L"script EnhancePack.InsuranceMenu()" }
	ActionsWindow.ActionData[10008] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=860099, detailString=L"", nameString=GetStringFromTid(3006201),  callback=L"script EnhancePack.ToggleItemInsurance()" }
	ActionsWindow.ActionData[10009] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870100, detailString=L"", nameString=GetStringFromTid(1115022),  callback=L"script EnhancePack.TitlesMenu()" }
	ActionsWindow.ActionData[10010] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870101, detailString=L"", nameString=GetStringFromTid(1049594),  callback=L"script EnhancePack.LoyaltyRating()" }
	ActionsWindow.ActionData[10011] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870102, detailString=L"", nameString=GetStringFromTid(3006157),  callback=L"script EnhancePack.CancelProtection()" }

	ActionsWindow.ActionData[10012] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=708, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 841), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 840),  callback=L"script EnhancePack.NextTarget()" }
	ActionsWindow.ActionData[10013] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=788, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 843), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 842),  callback=L"script EnhancePack.NearTarget()" }

	ActionsWindow.ActionData[10014] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870126, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 857), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 856),  callback=L"script EnhancePack.InjuredFollower()" }
	ActionsWindow.ActionData[10015] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870127, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 859), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 858),  callback=L"script EnhancePack.InjuredMobile()" }
	ActionsWindow.ActionData[10016] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870128, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 861), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 860),  callback=L"script EnhancePack.InjuredParty()" }
	ActionsWindow.ActionData[10017] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870129, detailString=L"", nameString=UI.GetCliloc(SystemData.Settings.Language.type, 852),  callback=L"script MainMenuWindow.OnToggleFriendList()" }

	ActionsWindow.ActionData[10018] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870133, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 889), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 888),  callback=L"script EnhancePack.MassOrganizerStart()" }
	ActionsWindow.ActionData[10019] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855052, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 965), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 964),  callback=L"script EnhancePack.LoadShuri()" }
	
	ActionsWindow.ActionData[10020] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870175, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 967), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 966),  callback=L"script HandleSingleLeftClkTarget(0)" }
	
	ActionsWindow.ActionData[10021] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=855202, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 969), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 968),  callback=L"" }
	
	ActionsWindow.ActionData[10022] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870176, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 976), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 975),  callback=L"script EnhancePack.FillOpenBod()" }
	
	ActionsWindow.ActionData[10023] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870177, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 980), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 979),  callback=L"script EnhancePack.RestockOpenBod()" }
	
	ActionsWindow.ActionData[10024] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870178, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 995), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 994),  callback=L"script Hotbar.ToggleQuickHotbar()" }
	
	ActionsWindow.ActionData[10025] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870179, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 1142), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5000),  callback=L"script EnhancePack.ToggleAlphaMode()" }
	
	ActionsWindow.ActionData[10026] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870180, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5002), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5001),  callback=L"script EnhancePack.AllRelease()" }
	
	ActionsWindow.ActionData[10027] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870181, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5004), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5003),  callback=L"script EnhancePack.ChangeSecurity(~TYPE~)" }
	
	ActionsWindow.ActionData[10028] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870182, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5010), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5009),  callback=L"script EnhancePack.InjuredFriend()" }
	
	ActionsWindow.ActionData[10029] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870183, detailString=L"", nameString=GetStringFromTid(1152531),  callback=L"script EnhancePack.VoidPool()" }
	
	ActionsWindow.ActionData[10030] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870184, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5023), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5022),  callback=L"script EnhancePack.ToggleItemProperties()" }

	ActionsWindow.ActionData[10031] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870185, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5041), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5042),  callback=L"script Moongate.GODefault()" }
	
	ActionsWindow.ActionData[10032] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870186, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5073), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5072),  callback=L"script EnhancePack.CloseAllContainers()" }
	
	ActionsWindow.ActionData[10033] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870187, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5085), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5084),  callback=L"script EnhancePack.TargetFirstContainerObject()" }
	
	ActionsWindow.ActionData[10034] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870189, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5088), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5087),  callback=L"script EnhancePack.UnravelItem()" }
	ActionsWindow.ActionData[10035] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870188, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 5090), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 5089),  callback=L"script EnhancePack.ImbueLastProp()" }
	
	ActionsWindow.ActionData[10036] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870190, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7014), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7013),  callback=L"script CraftingTool.MakeLastHB()" }
	ActionsWindow.ActionData[10037] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870191, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7017), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7016),  callback=L"script CraftingTool.RepairItemHB()" }
	
	ActionsWindow.ActionData[10038] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870192, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7023), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7022),  callback=L"script EnhancePack.ToggleTrades()" }
	
	ActionsWindow.ActionData[10039] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870193, detailString=GetStringFromTid(1115914), nameString=GetStringFromTid(1115913),  callback=L"script EnhancePack.ToggleEnglishNames()" }
	
	ActionsWindow.ActionData[10040] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870194, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7027), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7026), callback=L"script EnhancePack.UndressHB()" }
	
	ActionsWindow.ActionData[10041] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=1000138, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7047), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7046), callback=L"" }
	
	ActionsWindow.ActionData[10042] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870195, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7051), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7050), callback=L"script EnhancePack.ExportContainerItems()" }
	
	
	ActionsWindow.ActionData[15001] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870196, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7055), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15002] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870197, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7056), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15003] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870198, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7057), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15004] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870199, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7058), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15005] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870200, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7059), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15006] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870201, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7060), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15007] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870202, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7061), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15008] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870203, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7062), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15009] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870204, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7063), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	ActionsWindow.ActionData[15010] = { type=SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow=true, iconId=870205, detailString=UI.GetCliloc(SystemData.Settings.Language.type, 7054), nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7064), editWindow="Text", paramInfoText=UI.GetCliloc(SystemData.Settings.Language.type, 7053) }
	
	

	-- This table is used to define the different catagories of actions, so they don't have to all show up in one list
	-- nameString can be removed once you localize them all - it was just for testing that the strings will fit
	-- nameTid will overpower nameString
	-- I'm not going to bother to localize them until I get offical groups from design
	ActionsWindow.Groups = {}

	ActionsWindow.Groups[1] = { nameString=L"Communication",		nameTid=1094744,									 index={ 5100, 5107, 5101, 5127, 5102, 5103, 5104, 5105, 5108, 5109, 5111, 5110, 5106, 5122, 5123, 5124, 10027, 5125, 4, 5, 6, 7, 12, 13 } }
	ActionsWindow.Groups[2] = { nameString=L"Pet Commands",			nameTid=1079385,									 index={ 5120, 5121, 5126, 29, 30, 31, 32, 34, 35, 36, 10026 } }
	ActionsWindow.Groups[3] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 912),						 index={ 5042, 5065, 5043, 5066, 5044, 5067, 5045, 5068, 5046, 5069 } }
	ActionsWindow.Groups[4] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 913),						 index={ 7020,7025, 7021,7026, 7022,7027, 7023,7028, 7024,7029 } }
	ActionsWindow.Groups[5] = { nameString=	UI.GetCliloc(SystemData.Settings.Language.type, 246),						 index={ 5070,5071,5072,5073,5074,5075,5076,5077,5078,5079,5080,5081,5082,5083,5084 } }
	ActionsWindow.Groups[6] = { nameString=	UI.GetCliloc(SystemData.Settings.Language.type, 247),						 index={ 5085,5086,5087,5088,5089,5090,5091,5092,5093,5094,5095,5096 } }
	ActionsWindow.Groups[7] = { nameString=L"Boat Commands",		nameTid=1079386,									 index={ 5097, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 53, 54, 7000, 7001, 7002, 7003, 7030, 7031 } }
	ActionsWindow.Groups[8] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 248),						 index={ 6100,6101,6102,6103,6104,6105,6106,6107,6108 } }
	ActionsWindow.Groups[9] = { nameString=L"Combat",				nameTid=1077417,									 index={ 27, 28, 67, 68 } }
	ActionsWindow.Groups[10] = { nameString=L"Cursor Targeting",		nameTid=1094876,							     index={ 17, 19, 20, 21, 56, 66, 90, 10020 } }
	ActionsWindow.Groups[11] = { nameString=L"Targeting",			nameTid=1079383,									 index={ 22, 71, 77, 23, 72, 78, 24, 73, 79, 69, 74, 80, 70, 75, 81, 25, 76, 82, 11, 5050, 10012, 10013, 10014, 10015, 10016, 10028, 10033, 10041 } }
	ActionsWindow.Groups[12] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 249),						 index={ 1, 2, 10040, 10021, 6150,6151,6152,6153,6154,6155,6156,6157,6158,6159,6160,6170,6171,6172,6173,6174,6175,6190,6191,6192,6193,6194,6195,6196,6197,6198,6210,6216,6213,6212,6214,6211,6215,6220,6221,6222,6223 } }
	ActionsWindow.Groups[13] = { nameString=L"Items/Abilities",		nameTid=1079384,									 index={ 8, 9, 10, 26, 86, 87, 91, 85, 55 } }
	ActionsWindow.Groups[14] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 250),						 index={ 5018, 5015, 5010, 5014, 5013, 5012, 5009, 5020, 89, 5007, 88, 5006, 5019, 5005, 5011, 5017, 5052, 5008, 3, 10017 } }
	ActionsWindow.Groups[15] = { nameString=L"Other",				nameTid=1044294,									 index={ 15, 14, 16, 83, 84, 57, 5001, 5002, 5016, 5039, 5055 } }
	ActionsWindow.Groups[16] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 251),						 index={ 5028, 5041, 5021, 5047, 5038, 5026, 5025, 5029, 5027, 5034, 5054, 5032, 5030, 5051, 5040, 5023, 5004, 5022, 5003, 5037, 5036, 10025, 5035, 5033, 5024, 5048, 5049, 5053, 7004, 5098, 5056, 5057, 7005, 10018, 10019, 10022, 10023, 10024, 10030, 10031, 10032, 10034, 10035, 10036, 10037, 10039, 10042  } }
	ActionsWindow.Groups[17] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 252),						 index={ 6000, 6001,6002,6003,6004,6005,6006 } }
	ActionsWindow.Groups[18] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 253),						 index={ 6020,6021,6022,6023,6024,6025,6026,6027,6028,6029,6030,6031,6032,6033,6034, 6035,6036,6037,6038, 6039 } }
	ActionsWindow.Groups[19] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 254),						 index={ 6050,6051,6052,6053,6054,6055,6056,6057,6058,6059,6060 } }
	ActionsWindow.Groups[20] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 255),						 index={ 6250, 6251, 6252, 6253, 6254, 6255, 6256, 6257, 6258, 6259, 6260 } }
	ActionsWindow.Groups[21] = { nameString=L"Virtues",				nameTid=1077439,									 index={ 58, 59, 60, 61, 62, 63, 64, 65 } }
	ActionsWindow.Groups[22] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 778),						 index={ 10000, 10001, 10002, 10003, 10004, 10005, 10006, 10007, 10008, 10009, 10010, 10011, 10029, 10038 } }
	ActionsWindow.Groups[23] = { nameString=UI.GetCliloc(SystemData.Settings.Language.type, 7052),						 index={ 15001,15002,15003,15004,15005,15006,15007,15008,15009,15010 } }
end

ActionsWindow.OFFSET_FROM_TOP = 50
ActionsWindow.OFFSET_FROM_BOTTOM = 10
ActionsWindow.SIDE_OFFSET = 10
ActionsWindow.ITEM_WIDTH = 50
ActionsWindow.ITEM_HEIGHT = 50

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ActionsWindow.Initialize()
	ActionsWindow.InitActionData()
    Interface.OnCloseCallBack["ActionsWindow"] = ActionsWindow.OnClose

	ActionsWindow.CurrentGroup = 1
	local groupItr
	local group
	local itemItr
	local actionIndex
	local actionData
	for groupItr, group in pairs(ActionsWindow.Groups) do
		local rowIndex = 1
		for itemItr, actionIndex in pairs(group.index) do	
			actionData = ActionsWindow.ActionData[actionIndex]		
			if( actionData.inActionWindow == true ) then
				local scrollChild = "ActionsWindowListScrollChild"
				local windowName = scrollChild.."Group"..groupItr.."Row"..rowIndex			
				CreateWindowFromTemplate(windowName, "ActionItemDef", scrollChild)
				WindowSetId(windowName.."Button", actionIndex )
				local texture, x, y = GetIconData( actionData.iconId )
				DynamicImageSetTexture( windowName.."ButtonSquareIcon", texture, x, y )
				
				DynamicImageSetTexture( windowName.."ButtonSquareIconBG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 0, 0 )
				if (actionData.type ~= 1000) then
					if( UserActionIsActionTypeTargetModeCompat(actionData.type) ) then
						WindowSetShowing(windowName.."ButtonDisabled", false)
						LabelSetTextColor( windowName.."Name", 255, 255, 255 )
					else
						WindowSetShowing(windowName.."ButtonDisabled", true)
						LabelSetTextColor( windowName.."Name", 128, 128, 128 )
					end
				else
					WindowSetShowing(windowName.."ButtonDisabled", false)
					LabelSetTextColor( windowName.."Name", 255, 255, 255 )
				end
				if (actionData.nameTid) then
					LabelSetText( windowName.."Name", GetStringFromTid(actionData.nameTid) )
				else
					LabelSetText( windowName.."Name", actionData.nameString )
				end
				if( rowIndex == 1 ) then
					WindowAddAnchor(windowName,"topleft",scrollChild,"topleft",0,0)
				else
					local relativeTo = scrollChild.."Group"..groupItr.."Row"..(rowIndex-1)
					WindowAddAnchor(windowName,"bottomleft",relativeTo,"topleft",0,0)
				end
				rowIndex = rowIndex + 1
			end
		end	
	end
	ActionsWindow.RefreshList(0)	
	WindowUtils.SetWindowTitle("ActionsWindow",GetStringFromTid(1079812))
	WindowUtils.RestoreWindowPosition("ActionsWindow")	
end

function ActionsWindow.Shutdown()
	WindowUtils.SaveWindowPosition("ActionsWindow")
end

function ActionsWindow.UpdateIcons()
	for groupItr, group in pairs(ActionsWindow.Groups) do
		local rowIndex = 1
		for itemItr, actionIndex in pairs(group.index) do	
			actionData = ActionsWindow.ActionData[actionIndex]		
			if( actionData.inActionWindow == true ) then
				local scrollChild = "ActionsWindowListScrollChild"
				local windowName = scrollChild.."Group"..groupItr.."Row"..rowIndex			
				
				DynamicImageSetTexture( windowName.."ButtonSquareIconBG", MiniTexturePack.DB[MiniTexturePack.Current].texture .. "Icon", 64, 64 )
				rowIndex = rowIndex + 1
				if (actionIndex == 10030 and EnhancePack.PropsSlot ~= nil) then
					WindowSetShowing(windowName.."ButtonDisabled", true)
					LabelSetTextColor( windowName.."Name", 128, 128, 128 )
				else
					WindowSetShowing(windowName.."ButtonDisabled", false)
					LabelSetTextColor( windowName.."Name", 255, 255, 255 )
				end
			end
		end	
	end
end

function ActionsWindow.OnClose()
    ButtonSetPressedFlag("MenuBarWindowToggleActions",false)
end

function ActionsWindow.RefreshList(modifier)
	ActionsWindow.UpdateCurrentGroup(modifier)
	ActionsWindow.SetGroupLabel()
	ActionsWindow.HideAllGroups()
	ActionsWindow.ShowActiveGroup()
	ScrollWindowSetOffset( "ActionsWindowList", 0 )
	ScrollWindowUpdateScrollRect("ActionsWindowList")
end

function ActionsWindow.SetGroupLabel()
	if ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid
	and ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid ~= 0
	then
		LabelSetText( "ActionsWindowTopArrowsText", GetStringFromTid( ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameTid ) )
	else
		if ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameString
		then
			LabelSetText( "ActionsWindowTopArrowsText", ActionsWindow.Groups[ActionsWindow.CurrentGroup].nameString )
		else
			LabelSetText( "ActionsWindowTopArrowsText", L""..ActionsWindow.CurrentGroup )
		end
	end
end

function ActionsWindow.ItemLButtonDown()

	local index = WindowGetId(SystemData.ActiveWindow.name)	
	local actionData = ActionsWindow.ActionData[index]
	local actionId = 0

	if (actionData.type == SystemData.UserAction.TYPE_INVOKE_VIRTUE) then
		actionId = actionData.invokeId
	end
	
	if(index == 10030 and EnhancePack.PropsSlot ~= nil) then
		return
	end
	
	if(index < 5000 and index ~= 53 and index ~= 54 and index ~= 50) then
		DragSlotSetActionMouseClickData(actionData.type, actionId, actionData.iconId)
	else
		DragSlotSetActionMouseClickData(actionData.type, index, actionData.iconId)
	end
end

function ActionsWindow.ItemMouseOver()
	local index = WindowGetId(SystemData.ActiveWindow.name)
	local actionData = ActionsWindow.ActionData[index]
	
	if(actionData.type == SystemData.UserAction.TYPE_INVOKE_VIRTUE) then
		index = actionData.invokeId
	end
	local name = L""
	if (actionData.nameTid) then
		name = GetStringFromTid(actionData.nameTid)
	else
		name = actionData.nameString
	end

	local desc = L""
	if (actionData.detailTid) then
		desc = GetStringFromTid(actionData.detailTid)
	else
		desc = actionData.detailString
	end
	local itemData
	
	if (index < 5000 and index ~= 53 and index ~= 54 and index ~= 50) then
	
		itemData =
		{
			windowName = "ActionsWindow",
			itemId = index,
			actionType = actionData.type,
			detail = ItemProperties.DETAIL_LONG,
			itemType = WindowData.ItemProperties.TYPE_ACTION,
			title =	name,
			body = desc
		}	
	elseif (index==5015) then
		local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	
		if backpackId ~= 0 then
			itemData = {
				windowName = dialog,
				itemId = backpackId,
				itemType = WindowData.ItemProperties.TYPE_ITEM,
			}
			ItemProperties.SetActiveItem(itemData)
		end
	else
		
			itemData =
		{
			windowName = "ActionsWindow",
			itemId = index,
			detail = ItemProperties.DETAIL_LONG,
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			title =	name,
			body = desc
		}	
	end				
	ItemProperties.SetActiveItem(itemData)	
end

function ActionsWindow.GetActionDataForType(actionType)
	for index, actionData in pairs(ActionsWindow.ActionData) do
		if( actionData.type == actionType ) then
			return actionData
		end
	end
end

function ActionsWindow.GetActionDataForId(actionId)
	if( ActionsWindow.ActionData[actionId]) then
		return ActionsWindow.ActionData[actionId]
	end

end

function ActionsWindow.LeftArrowPressed()
	ActionsWindow.RefreshList(-1)
end

function ActionsWindow.RightArrowPressed()
	ActionsWindow.RefreshList(1)
end

function ActionsWindow.UpdateCurrentGroup(modifier)
	ActionsWindow.CurrentGroup = ActionsWindow.CurrentGroup + modifier
	
	if ( not ActionsWindow.CurrentGroup ) or ( ActionsWindow.CurrentGroup > #ActionsWindow.Groups ) then
		ActionsWindow.CurrentGroup = 1
	end
	
	if ( ActionsWindow.CurrentGroup < 1 ) then
		ActionsWindow.CurrentGroup = #ActionsWindow.Groups
	end
end

function ActionsWindow.HideAllGroups()
	local groupItr
	local group
	local itemItr
	local actionIndex
	local actionData
	for groupItr, group in pairs(ActionsWindow.Groups) do
		local rowIndex = 1
		for itemItr, actionIndex in pairs(group.index) do	
			actionData = ActionsWindow.ActionData[actionIndex]		
			if( actionData.inActionWindow == true ) then
				local windowName = "ActionsWindowListScrollChildGroup"..groupItr.."Row"..rowIndex			
				WindowSetShowing( windowName, false )
				WindowClearAnchors( windowName )
				rowIndex = rowIndex + 1
			end
		end	
	end
end

function ActionsWindow.ShowActiveGroup()
	local itemItr
	local actionIndex
	local actionData
	local rowIndex = 1
	for itemItr, actionIndex in pairs(ActionsWindow.Groups[ActionsWindow.CurrentGroup].index) do	
		actionData = ActionsWindow.ActionData[actionIndex]		
		if( actionData.inActionWindow == true ) then
			local windowName = "ActionsWindowListScrollChildGroup"..ActionsWindow.CurrentGroup.."Row"..rowIndex			
			WindowSetShowing( windowName, true )
			WindowClearAnchors( windowName )
			if itemItr == 1 then
				WindowAddAnchor( windowName, "topleft", "ActionsWindowListScrollChild", "topleft", 0, 0 ) 
			else
				WindowAddAnchor( windowName, "bottomleft", "ActionsWindowListScrollChildGroup"..ActionsWindow.CurrentGroup.."Row"..(rowIndex-1), "topleft", 0, 0 )
			end
			rowIndex = rowIndex + 1
		end
	end
end


function ActionsWindow.Context()
	for i=1, table.getn(ActionsWindow.Groups) do
		local name = ""
		if (ActionsWindow.Groups[i].nameTid) then
			name = GetStringFromTid(ActionsWindow.Groups[i].nameTid)
		else
			name = ActionsWindow.Groups[i].nameString
		end
		ContextMenu.CreateLuaContextMenuItemWithString(name,0,i,2,ActionsWindow.CurrentGroup== i)
	end
	ContextMenu.ActivateLuaContextMenu(ActionsWindow.ContextMenuCallback)
end

function ActionsWindow.ContextMenuCallback( returnCode, param )
	ActionsWindow.CurrentGroup=returnCode
	ActionsWindow.RefreshList(0)
end

function ActionsWindow.ContextTooltip()

	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  UI.GetCliloc(SystemData.Settings.Language.type, 688))
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end