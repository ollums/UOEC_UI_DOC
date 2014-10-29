
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SettingsWindow = {}
SettingsWindow.IGNORE_LIST_ALL = 0
SettingsWindow.IGNORE_LIST_CONF	= 1
SettingsWindow.Modes = {}
SettingsWindow.Modes.Graphics = 1 
SettingsWindow.Modes.KeyBindings = 2 
SettingsWindow.Modes.Options = 5
SettingsWindow.Modes.NUM_MODES = 10

SettingsWindow.Modes.windows = { "SettingsGraphicsWindow", 
								"SettingsKeyBindingsWindow", 
								"SettingsSoundWindow", 
								"SettingsOptionsWindow", 
								"SettingsLegacyWindow", 
								"SettingsProfanityWindow", 
								"SettingsKeyDefaultWindow",
								"SettingsPincosUIWindow",
								"SettingsMobilesOnScreen",
								"NewChatSettingsWindow"
								}

SettingsWindow.FontSizes = {}
SettingsWindow.FontSizes[1] = 12
SettingsWindow.FontSizes[2] = 14
SettingsWindow.FontSizes[3] = 16
SettingsWindow.FontSizes[4] = 18
SettingsWindow.FontSizes[5] = 20
SettingsWindow.FontSizes[6] = 22
SettingsWindow.FontSizes[7] = 24
SettingsWindow.NUM_FONT_SIZES = 7

SettingsWindow.ChatFadeTime = {}
SettingsWindow.ChatFadeTime[1] = 1
SettingsWindow.ChatFadeTime[2] = 2
SettingsWindow.ChatFadeTime[3] = 3
SettingsWindow.ChatFadeTime[4] = 4
SettingsWindow.ChatFadeTime[5] = 5
SettingsWindow.NUM_FADE_TIMES = 5

SettingsWindow.Languages = {}
SettingsWindow.Languages[1] = {tid = 1077459, id = SystemData.Settings.Language.LANGUAGE_ENU}
SettingsWindow.Languages[2] = {tid = 1077460, id = SystemData.Settings.Language.LANGUAGE_JPN}
SettingsWindow.Languages[3] = {tid = 1078516, id = SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL}
SettingsWindow.NUM_LANGUAGES = 3

SettingsWindow.ShowNames = {}
SettingsWindow.ShowNames[1] = {tid = 1011051, id = SystemData.Settings.GameOptions.SHOWNAMES_NONE}
SettingsWindow.ShowNames[2] = {tid = 1078090, id = SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING}
SettingsWindow.ShowNames[3] = {tid = 1078091, id = SystemData.Settings.GameOptions.SHOWNAMES_ALL}
SettingsWindow.NUM_SHOWNAMES = 3

SettingsWindow.ScrollWheelBehaviors = {}
SettingsWindow.ScrollWheelBehaviors[1] = {tid = 1079288, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_IN_CAMERA }
SettingsWindow.ScrollWheelBehaviors[2] = {tid = 1079289, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_OUT_CAMERA }
SettingsWindow.ScrollWheelBehaviors[3] = {tid = 1079177, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_FRIENDLY }
SettingsWindow.ScrollWheelBehaviors[4] = {tid = 1111940, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_FRIENDLY }
SettingsWindow.ScrollWheelBehaviors[5] = {tid = 1079178, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ENEMY }
SettingsWindow.ScrollWheelBehaviors[6] = {tid = 1111941, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ENEMY }
SettingsWindow.ScrollWheelBehaviors[7] = {tid = 1094824, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ANY }
SettingsWindow.ScrollWheelBehaviors[8] = {tid = 1111942, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ANY }
SettingsWindow.ScrollWheelBehaviors[9] = {tid = 1079156, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_LAST }
SettingsWindow.ScrollWheelBehaviors[10] = {tid = 1079158, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_SELF }
SettingsWindow.ScrollWheelBehaviors[11] = {tid = 1079157, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_CURRENT }
SettingsWindow.ScrollWheelBehaviors[12] = {tid = 1112413, id = SystemData.Settings.GameOptions.MOUSESCROLL_CYCLE_CURSOR_TARGET }
SettingsWindow.ScrollWheelBehaviors[13] = {tid = 1115342, id = SystemData.Settings.GameOptions.MOUSESCROLL_CLEAR_TARGET_QUEUE }
SettingsWindow.ScrollWheelBehaviors[14] = {tid = 1011051, id = SystemData.Settings.GameOptions.MOUSESCROLL_NONE }
SettingsWindow.NUM_SCROLLWHEELBEHAVIORS = 14

SettingsWindow.ScrollWheelBehaviors_Legacy = {}
SettingsWindow.ScrollWheelBehaviors_Legacy[1] = {tid = 1079288, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_IN_CAMERA }
SettingsWindow.ScrollWheelBehaviors_Legacy[2] = {tid = 1079289, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_OUT_CAMERA }
SettingsWindow.ScrollWheelBehaviors_Legacy[3] = {tid = 1079156, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_LAST }
SettingsWindow.ScrollWheelBehaviors_Legacy[4] = {tid = 1079158, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_SELF }
SettingsWindow.ScrollWheelBehaviors_Legacy[5] = {tid = 1112413, id = SystemData.Settings.GameOptions.MOUSESCROLL_CYCLE_CURSOR_TARGET }
SettingsWindow.ScrollWheelBehaviors_Legacy[6] = {tid = 1115342, id = SystemData.Settings.GameOptions.MOUSESCROLL_CLEAR_TARGET_QUEUE }
SettingsWindow.ScrollWheelBehaviors_Legacy[7] = {tid = 1011051, id = SystemData.Settings.GameOptions.MOUSESCROLL_NONE }
SettingsWindow.NUM_SCROLLWHEELBEHAVIORS_LEGACY = 7

SettingsWindow.DelayValues = {}
SettingsWindow.DelayValues[1] = 1078334
SettingsWindow.DelayValues[2] = 1078336
SettingsWindow.DelayValues[3] = 1078337
SettingsWindow.DelayValues[4] = 1078338
SettingsWindow.DelayValues[5] = 1078339
SettingsWindow.DelayValues[6] = 1078340
SettingsWindow.NUM_DELAY_VALUES = 6

SettingsWindow.ContainerViewOptions = {}
SettingsWindow.ContainerViewOptions[1] = {name="List", tid=1079824}
SettingsWindow.ContainerViewOptions[2] = {name="Grid", tid=1079825}

SettingsWindow.ObjectHandles = {}
SettingsWindow.ObjectHandles[1] = { id = SystemData.Settings.ObjectHandleFilter.eDynamicFilter, tid = 1079457}
SettingsWindow.ObjectHandles[2] = { id = SystemData.Settings.ObjectHandleFilter.eCorpseFilter, tid = 1078368}
SettingsWindow.ObjectHandles[3] = { id = SystemData.Settings.ObjectHandleFilter.eNPCFilter, tid = 1079458}
SettingsWindow.ObjectHandles[4] = { id = SystemData.Settings.ObjectHandleFilter.eNPCVendorFilter, tid = 1079459}
SettingsWindow.ObjectHandles[5] = { id = SystemData.Settings.ObjectHandleFilter.eMobileFilter, tid = 1075672}
SettingsWindow.NUM_OBJHANDLE_FILTERS = 5

SettingsWindow.ObjectHandleSizes = {50, 100, 200, 300, -1}

-- NOTE_KEYBIND: Make sure the order of these match with the order of other keybinding symbol lists in code
SettingsWindow.Keybindings = {}
SettingsWindow.Keybindings[1] = { name = "MoveUp", tid = 1077791, type = "FORWARD" }
SettingsWindow.Keybindings[2] = { name = "MoveDown", tid = 1077792, type = "BACKWARD" }
SettingsWindow.Keybindings[3] = { name = "MoveLeft", tid = 1077793, type = "LEFT" }
SettingsWindow.Keybindings[4] = { name = "MoveRight", tid = 1077794, type = "RIGHT" }

SettingsWindow.Keybindings[5] = { name = "AttackMode", tid = 1077813, type = "MELEE_ATTACK" }
SettingsWindow.Keybindings[6] = { name = "PrimaryAttack", tid = 1079153, type = "USE_PRIMARY_ATTACK" }
SettingsWindow.Keybindings[7] = { name = "SecondaryAttack", tid = 1079154, type = "USE_SECONDARY_ATTACK" }

SettingsWindow.Keybindings[8] = { name = "NextGroupTarget", tid = 1079155, type = "NEXT_GROUP_TARGET" }
SettingsWindow.Keybindings[9] = { name = "NextEnemy", tid = 1077807, type = "NEXT_ENEMY_TARGET" }
SettingsWindow.Keybindings[10] = { name = "NextFriend", tid = 1077809, type = "NEXT_FRIENDLY_TARGET" }
SettingsWindow.Keybindings[11] = { name = "NextFollower", tid = 1112417, type = "NEXT_FOLLOWER_TARGET" }
SettingsWindow.Keybindings[12] = { name = "NextObject", tid = 1112424, type = "NEXT_OBJECT_TARGET" }
SettingsWindow.Keybindings[13] = { name = "NextTarget", tid = 1094822, type = "NEXT_TARGET" }

SettingsWindow.Keybindings[14] = { name = "PreviousGroupTarget", tid = 1112425, type = "PREVIOUS_GROUP_TARGET" }
SettingsWindow.Keybindings[15] = { name = "PreviousEnemy", tid = 1112426, type = "PREVIOUS_ENEMY_TARGET" }
SettingsWindow.Keybindings[16] = { name = "PreviousFriend", tid = 1112427, type = "PREVIOUS_FRIENDLY_TARGET" }
SettingsWindow.Keybindings[17] = { name = "PreviousFollower", tid = 1112428, type = "PREVIOUS_FOLLOWER_TARGET" }
SettingsWindow.Keybindings[18] = { name = "PreviousObject", tid = 1112429, type = "PREVIOUS_OBJECT_TARGET" }
SettingsWindow.Keybindings[19] = { name = "PreviousTarget", tid = 1112430, type = "PREVIOUS_TARGET" }

SettingsWindow.Keybindings[20] = { name = "NearestGroup", tid = 1112418, type = "NEAREST_GROUP_TARGET" }
SettingsWindow.Keybindings[21] = { name = "NearestEnemy", tid = 1077811, type = "NEAREST_ENEMY_TARGET" }
SettingsWindow.Keybindings[22] = { name = "NearestFriend", tid = 1077812, type = "NEAREST_FRIENDLY_TARGET" }
SettingsWindow.Keybindings[23] = { name = "NearestFollower", tid = 1112419, type = "NEAREST_FOLLOWER_TARGET" }
SettingsWindow.Keybindings[24] = { name = "NearestObject", tid = 1112423, type = "NEAREST_OBJECT_TARGET" }
SettingsWindow.Keybindings[25] = { name = "NearestTarget", tid = 1094823, type = "NEAREST_TARGET" }

SettingsWindow.Keybindings[26] = { name = "TargetSelf", tid = 1077801, type = "TARGET_SELF" }
SettingsWindow.Keybindings[27] = { name = "TargetG1", tid = 1077802, type = "TARGET_GROUP_MEMBER_1" }
SettingsWindow.Keybindings[28] = { name = "TargetG2", tid = 1077803, type = "TARGET_GROUP_MEMBER_2" }
SettingsWindow.Keybindings[29] = { name = "TargetG3", tid = 1077804, type = "TARGET_GROUP_MEMBER_3" }
SettingsWindow.Keybindings[30] = { name = "TargetG4", tid = 1077805, type = "TARGET_GROUP_MEMBER_4" }
SettingsWindow.Keybindings[31] = { name = "TargetG5", tid = 1077806, type = "TARGET_GROUP_MEMBER_5" }
SettingsWindow.Keybindings[32] = { name = "TargetG6", tid = 1079147, type = "TARGET_GROUP_MEMBER_6" }
SettingsWindow.Keybindings[33] = { name = "TargetG7", tid = 1079148, type = "TARGET_GROUP_MEMBER_7" }
SettingsWindow.Keybindings[34] = { name = "TargetG8", tid = 1079149, type = "TARGET_GROUP_MEMBER_8" }
SettingsWindow.Keybindings[35] = { name = "TargetG9", tid = 1079150, type = "TARGET_GROUP_MEMBER_9" }

SettingsWindow.Keybindings[36] = { name = "CursorTargetCurrent", tid = 1115345, type = "CURSOR_TARGET_CURRENT" }
SettingsWindow.Keybindings[37] = { name = "CursorTargetLast", tid = 1115346, type = "CURSOR_TARGET_LAST" }
SettingsWindow.Keybindings[38] = { name = "CursorTargetSelf", tid = 1115347, type = "CURSOR_TARGET_SELF" }
SettingsWindow.Keybindings[39] = { name = "CycleLastCursorTarget", tid = 1115348, type = "CYCLE_LAST_CURSOR_TARGET" }
SettingsWindow.Keybindings[40] = { name = "ClearTargetQueue", tid = 1115349, type = "CLEAR_TARGET_QUEUE" }

SettingsWindow.Keybindings[41] = { name = "CharacterWin", tid = 1077795, type = "PAPERDOLL_CHARACTER_WINDOW" }
SettingsWindow.Keybindings[42] = { name = "BackpackWin", tid = 1077796, type = "BACKPACK_WINDOW" }
SettingsWindow.Keybindings[43] = { name = "SkillsWin", tid = 1078992, type = "SKILLS_WINDOW" }
SettingsWindow.Keybindings[44] = { name = "ToggleMap", tid = 1078993, type = "WORLD_MAP_WINDOW" }
SettingsWindow.Keybindings[45] = { name = "QuestLogWin", tid = 1077799, type = "QUEST_LOG_WINDOW" }

SettingsWindow.Keybindings[46] = { name = "ToggleAlwaysRun", tid = 1113150, type = "TOGGLE_ALWAYS_RUN" }

SettingsWindow.Keybindings[47] = { name = "ZoomIn", tid = 1079288, type = "ZOOM_IN" }
SettingsWindow.Keybindings[48] = { name = "ZoomOut", tid = 1079289, type = "ZOOM_OUT" }
SettingsWindow.Keybindings[49] = { name = "ZoomReset", tid = 1079290, type = "ZOOM_RESET" }

SettingsWindow.Keybindings[50] = { name = "Screenshot", tid = 1079819, type = "SCREENSHOT" }
SettingsWindow.Keybindings[51] = { name = "ToggleInterface", tid = 1079817, type = "TOGGLE_UI" }
SettingsWindow.Keybindings[52] = { name = "ReloadInterface", tid = 1079820, type = "RELOAD_UI" }
SettingsWindow.Keybindings[53] = { name = "ToggleCoT", tid = 1079818, type = "TOGGLE_CIRCLE_OF_TRANSPARENCY" }
SettingsWindow.Keybindings[54] = { name = "CycleChatForward", tid = 1115574, type = "CYCLE_CHAT_FORWARD" }
SettingsWindow.Keybindings[55] = { name = "CycleChatBackward", tid = 1115575, type = "CYCLE_CHAT_BACKWARD" }

SettingsWindow.Keybindings[56] = { name = "QuitGame", tid = 1114308, type = "QUIT_GAME" }
SettingsWindow.Keybindings[57] = { name = "LogOut", tid = 1115334, type = "LOG_OUT" }
SettingsWindow.Keybindings[58] = { name = "Cancel", tid = 1006045, type = "CANCEL" }

SettingsWindow.NON_LEGACY_BINDING_MIN = 8
SettingsWindow.NON_LEGACY_BINDING_MAX = 36

SettingsWindow.TID = {UserSetting = 1077814, Graphics = 1077815, KeyBindings = 1077816, Options = 1015326, Resolution = 1077817, 
					 WindowRes = 1077818, MaxFramerate = 1112340, FullRes = 1077819, ShowFrame = 1077820, UseFull = 1077821, EnableSound = 1077823, SoundVol = 1094691, 
					 Language = 1077824, Okay = 3000093, Apply = 3000090, Reset = 1077825, Cancel = 1006045, Quarter = 1078023, Full = 1074240, 
					 Sound = 3000390, Interface = 3000395, PlayFootsteps = 1078077, CircleOfTransparency = 1078079, 
					 AlwaysRun = 1078078, Movie = 3000190, ObjectHandles = 1062947, ObjectHandleFilter = 1079461, ObjectHandleQuantity = 1094696,
					 QueryBeforeCriminalActions = 1078080, HoldShiftToUnstack = 1112076, FilterObscenity = 3000460, OverheadChatFadeDelay = 1078084, 
					 OverheadChat = 1078083, Tooltips = 1115211, TooltipDelay = 1078086, PlayerNameColors = 1078087, ShowNames = 1078093, Filter = 3000173, IgnorePlayers = 3000462, IgnoreConfPlayers = 1151906,
					 MusicVolume = 1078578, EnableMusic = 1078577, Animation = 1079368, EffectsVolume = 1078576, EnableEffects = 1078575, AlwaysAttack = 1078858, ShowStrLabel = 1079171,
					 LegacyChat = 1079172, PlayIdleAnimation = 1094692, GameOptions = 1094695, System = 1078905, Chat = 3000131, Legacy = 1094697,
					 UiScale = 1079205, Gamma = 3000166, ParticleLOD = 1079213, ParticleFilter = 1112330, Input = 1094693, Mouse = 1094694, NotAvailable = 1094717,
					 ShowShadows = 1079286, EnableVsync = 1112689, ShowChatWindow = 1079299, Bindings = 1079337, UseLegacyContainers = 1094708, ShowFoliage = 1079814, 
                     LegacyTargeting = 1094710, ScrollWheelUp = 1111944, ScrollWheelDown = 1111945, DefaultContainerView = 1079827, DefaultCorpseView = 1079828, TipoftheDay = 1094689,
                     Display = 3000396, Environment = 1077415, DiskCache = 1079480, LegacyKeyDefault = 1079163, MMOKeyDefault = 1111866, CustomUI = 1079523, EnableAutorun = 1115321,
					 EnablePathfinding = 1115324, TargetQueueing = 1115337, ShiftRightClickContextMenus = 1115355, PartyInvitePopUp = 1115367, EnglishNames = 1115913,
					 IgnoreMouseActionsOnSelf = 1115918, ShowCorpseNames = 1115927, HardwareDeathEffect = 1115993, EnableChatLog = 1149998, UseLegacyPaperdolls = 1150185, ResetUILocPos = 1153107 }
					 
SettingsWindow.DetailTID = {	UseFull = 1115267, FullRes = 1115269, MaxFramerate = 1115270, ShowFrame = 1115271,
								Gamma = 1115272, ShowFoliage = 1115275, ShowShadows = 1115276, EnableVsync = 1115277,
								CircleOfTransparency = 1115278, ParticleLOD = 1115279, ParticleFilter = 1115280,
								PlayIdleAnimation = 1115281, Animation = 1115282, ScrollWheelUp = 1115283,
								ScrollWheelDown = 1115284, LegacyKeyDefault = 1115285, MMOKeyDefault = 1115286,
								EnableSound = 1115287, SoundVol = 1115288, EnableEffects = 1115289, EffectsVolume = 1115290,
								EnableMusic = 1115291, MusicVolume = 1115292, PlayFootsteps = 1115293, Language = 1115294,
								DiskCache = 1115295, AlwaysRun = 1115296, AlwaysAttack = 1115297,
								QueryBeforeCriminalActions = 1115298, HoldShiftToUnstack = 1115299, CustomUI = 1115300,
								UiScale = 1115301, DefaultContainerView = 1115302, DefaultCorpseView = 1115303,
								ShowStrLabel = 1115304, Tooltips = 1115305, TipoftheDay = 1115306,
								ObjectHandleFilter = 1115307, ObjectHandleQuantity = 1115308, ShowNames = 1115309,
								OverheadChat = 1115310, OverheadChatFadeDelay = 1115311, LegacyChat = 1115312,
								UseLegacyContainers = 1115313, LegacyTargeting = 1115314, FilterObscenity = 1115315,
								IgnorePlayers = 1115316, IgnoreConfPlayers = 1151906, EnableAutorun = 1115322, EnablePathfinding = 1115325,
								TargetQueueing = 1115338, ShiftRightClickContextMenus = 1115356, PartyInvitePopUp = 1115368,
                                EnglishNames = 1115914, IgnoreMouseActionsOnSelf = 1115919, ShowCorpseNames = 1115928, 
                                HardwareDeathEffect = 1115994, EnableChatLog = 1149999, UseLegacyPaperdolls = 1150186,
                                EnglishSpells = 1000, OverheadSpells = 1001, DefaultItemTextColor = 1002, DefaultModsTextColor = 1003,
                                DefaultEngraveTextColor = 1004, DefaultArtiTextColor = 1005, DefaultSetTextColor = 1006, DefaultAlertTextColor = 1007,
                                DefaultDangerTextColor = 1008, DefaultPhysicalTextColor = 1009, DefaultFireTextColor = 1010, DefaultColdTextColor = 1011,
                                DefaultPoisonTextColor = 1012, DefaultEnergyTextColor = 1013, DefaulChaosTextColor = 1014, DefaulHealTextColor = 1015,
                                DefaulCurseTextColor = 1016, DefaulParaTextColor = 1017, DefaulNeutralTextColor = 1018, DefaulNegTextColor = 1019,
                                DefaulPosTextColor = 1020, DefaulYouTextColor = 1021, DefaulPetTextColor = 1022, DefaulEnemyTextColor = 1023,
                                DefaulSadModeColor = 1024, DefaulTextSizePlus = 1025, DefaulTextSizeMinus = 1026, DefaulSpeechFont = 1027,
                                DefaulNamesFont = 1028, DefaulSpellsFont = 1029, DefaulDamagesFont = 1030, DefaulObjectHandleSize = 1031,
                                DefaulOpacity = 1032, ObjectHandleWindow = 1033, CenterscreenTextPos = 1034, CenterscreenTest = 1035, CenterscreenLowHP = 1036,
                                CenterscreenLowHPPet = 1037, Ignoresummon = 1038, HotbarSlots = 1039, HotbarOrient = 1040, colorHBPlain = 1041,
                                colorHBControl = 1042, colorHBAlt = 1043, colorHBShift = 1044, colorHBCtrlalt = 1045,  colorHBAltShift = 1046,
                                colorHBCtrlShift = 1047, colorHBCtrlAltShift = 1048, colorHBCountdown = 1049, colorHBCurrent = 1050,
                                colorHBSelf = 1051, colorHBCursor = 1052, colorHBStored = 1053, colorHBBorder = 1054, GridLegacy = 1055,
                                ContainersGrid = 1056, ExtraBright = 1057, AlternateGrid = 1058, BaseGridColor = 1059, AlternateGridColor = 1060,
                                OldClose = 1061, PetOldClose = 1062, WodHealthbars = 1063, DiabloHealthbars = 1064, DiabloHealthbarsNum = 1065,
                                ToggleNotoAura = 1066, Static = 1067, NormalSpeed = 1068, Fast = 1069, ExtraProps = 1070, IntensInfo = 1071,
                                ExtraInfoColor = 1072, BlockOthersPaper = 1073, YouSee = 1074, WarMode = 1075, WarShield = 1076, AutoIgnore = 1077,
                                LockChat = 1078, ScaleMode = 1079, WinSnap = 1080, UOCart = 1081, BookLog = 1082, QuickDetails = 1083, Hourglass = 1084, 
								ServerLines = 1085, Clock = 1086, TrapBoxs = 1087, LootBags = 1088, UnTrapBoxs = 1089, UnLootBags = 1090, GoldOnBackpack = 1091,
								MenuMaker = 1092, HBNoSpace = 1093, MapCombo = 1094, AutoCloseVetRew = 1095, ChooseSex = 1096, ECVolume = 1097, Heartbeat = 1098,
								HeartbeatVol = 1099, NormalForge = 1100, TerMurForge = 1101, QueenForge = 1102,  HumanElf = 1103, Gargoyle = 1104, QuickLoot = 1105,
								LootSort = 1106, Notes = 1107, RedButtonSpell = 1108, GreenButtonSpell = 1109, BlueButtonSpell = 1110, TexturePack = 1111, BardMastery = 1112,
								NewChat = 1113, PartyIgnore = 1114, ECPlayMusic = 1115, ECPlaySound = 1116, ECMusicVolume = 1117, StatusButtons = 1118, DangerBar = 1119,
								NewAnimalLore = 1120, DefaulLostItemTextColor = 1121, BlockWarOnPet = 1122, BlockWarOnParty = 1123, BlockWarOnGuild = 1124, BrokenPerc = 1125,
								MobileArrow = 1126, LootAllButTrash = 1127, ShowCloseExtract = 1128, ClickableNames = 1131, PoisonOthers = 1132, PartyHP = 1133, GuildPos = 1134,
								GuildHP = 1135, AllyPos = 1136, AllyHP = 1137, GuildWP = 1138, BuffBlink = 1139, SpellSpeed = 1140, PaperdollBG = 1141, AlphaMode = 1142,
								NewLayout = 1143, DefaultMagicPropTextColor = 1144, DefaultResidueTextColor = 1145, DefaultEssenceTextColor = 1146, DefaultRelicTextColor = 1147,
								DefaultPlainTextColor = 1148, ContentsInfo = 1149, ItemComparison = 1150, HighlightLast = 1151, AdvancedCraftings = 1152, ScavengeAll = 1153,
								DisableBandages = 1154, MoongateGump = 1155,
							}

SettingsWindow.TID_BINDING_CONFLICT_TITLE = 1079169
SettingsWindow.TID_BINDING_CONFLICT_BODY = 1079170
SettingsWindow.TID_BINDING_CONFLICT_QUESTION = 1094839
SettingsWindow.TID_YES = 1049717
SettingsWindow.TID_NO = 1049718
SettingsWindow.TID_INFO = 1011233
SettingsWindow.TID_RESETLEGACYBINDINGS_CHAT = 1079400
SettingsWindow.TID_RESETDEFAULTBINDINGS = 1094698
SettingsWindow.TID_RESETCHATSETTINGS = 1094699

SettingsWindow.TID_FRAMERATE = { 1112341, 1112342, 1112343, 1112344, 1112345 }

SettingsWindow.TID_DETAILS = { 1079210, 1079211, 1079212 }
SettingsWindow.TID_FILTERS = { 1112331, 1112332, 1112333, 1112334 }

SettingsWindow.TID_ANIMATION = {1079210, 1079211, 1079212}

SettingsWindow.RecordingKey = false

SettingsWindow.PreviousBadWordCount = 0
SettingsWindow.PreviousIgnoreListCount = 0
SettingsWindow.CurIgnoreListIdx = -1
SettingsWindow.PreviousIgnoreConfListCount = 0
SettingsWindow.CurIgnoreConfListIdx = -1

--SettingsWindow.ENABLE_CUSTOM_SKINS = false -- enable this element? search for this tag to find all uses of this element also!
--SettingsWindow.TID_CUSTOM_SKINS_TEXT = 1011012 -- "Cancel"( placeholder )-- Label on the right of the combo box
--SettingsWindow.CustomSkins = {} -- table containing data for the different skins, may need to be initalized before use
--SettingsWindow.CustomSkins[1] = { tid = 3006115, id = 1 } -- "Resign( placeholder )-- Fist listed element in combo box
--SettingsWindow.CustomSkins[2] = { tid = 1078056, id = 2 } -- "MORE"( placeholder )
--SettingsWindow.CustomSkins[3] = { tid = 1011011, id = 3 } -- "CONTINUE"( placeholder )-- Last listed element in combo box

SettingsWindow.DefaultRequest = false
----------------------------------------------------------------
-- LoginWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler()
function SettingsWindow.Initialize()

	Interface.OnCloseCallBack["SettingsWindow"] = SettingsWindow.OnCancelButton
	
	WindowRegisterEventHandler( "Root", SystemData.Events.PROFANITYLIST_UPDATED, "SettingsWindow.ProfanityListUpdated" )
	
	WindowUtils.SetWindowTitle( "SettingsWindow", GetStringFromTid( SettingsWindow.TID.UserSetting ) )
	
	-- Tab Buttons
	ButtonSetText( "SettingsWindowGraphicsTabButton", GetStringFromTid( SettingsWindow.TID.Graphics ) )
	ButtonSetText( "SettingsWindowKeyBindingsTabButton", GetStringFromTid( SettingsWindow.TID.Input ) )
	ButtonSetText( "SettingsWindowOptionsTabButton", GetStringFromTid( SettingsWindow.TID.Options ) )
	ButtonSetText( "SettingsWindowSoundTabButton", GetStringFromTid( SettingsWindow.TID.Sound ) )
	ButtonSetText( "SettingsWindowLegacyTabButton", GetStringFromTid( SettingsWindow.TID.Legacy ) )
	ButtonSetText( "SettingsWindowProfanityTabButton", GetStringFromTid( SettingsWindow.TID.Filter ) )
	
	ButtonSetText( "SettingsWindowPincosUITabButton", L"Pinco's UI" )
	ButtonSetText( "SettingsWindowMobilesOnScreenTabButton", L"Mobiles Bar" )
	ButtonSetText( "SettingsWindowNewChatTabButton", L"New Chat" )
	
	
	-- SubSection Labels
	LabelSetText( "SettingsGraphicsDisplaySubSectionLabel", GetStringFromTid( SettingsWindow.TID.Display ) )
	LabelSetText( "SettingsGraphicsEnvironmentSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Environment ) )
	LabelSetText( "SettingsKeyBindingsMouseSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Mouse ) )
	LabelSetText( "SettingsKeyBindingsKeyboardSubSectionLabel", GetStringFromTid( SettingsWindow.TID.KeyBindings ) )
	LabelSetText( "SettingsSoundSoundSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Sound ) )
	LabelSetText( "SettingsOptionsGameOptionsSubSectionLabel", GetStringFromTid( SettingsWindow.TID.GameOptions ) )
	LabelSetText( "SettingsOptionsInterfaceSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Interface ) )
	LabelSetText( "SettingsOptionsSystemSubSectionLabel", GetStringFromTid( SettingsWindow.TID.System ) )
	LabelSetText( "SettingsOptionsChatSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Chat ) )
	LabelSetText( "SettingsLegacyLegacySubSectionLabel", GetStringFromTid( SettingsWindow.TID.Legacy ) )
	LabelSetText( "SettingsBadWordFilterFilterSubSectionLabel", GetStringFromTid( SettingsWindow.TID.Filter ) )
	
	-- Buttons
	ButtonSetText( "SettingsWindowOkayButton", GetStringFromTid( SettingsWindow.TID.Okay ) )
	ButtonSetText( "SettingsWindowApplyButton", GetStringFromTid( SettingsWindow.TID.Apply ) )
	ButtonSetText( "SettingsWindowResetButton", GetStringFromTid( SettingsWindow.TID.Reset ) )
	ButtonSetText( "SettingsWindowCancelButton", GetStringFromTid( SettingsWindow.TID.Cancel ) )
	
	--[[ this no longer seems to be necessary
	ButtonSetStayDownFlag( "SettingsWindowGraphicsTabButton", true )
	ButtonSetStayDownFlag( "SettingsWindowKeyBindingsTabButton", true )
	ButtonSetStayDownFlag( "SettingsWindowOptionsTabButton", true )
	--]]
	
	
	-- Start with graphics window open
	SettingsWindow.OpenGraphicsTab()
	
	-- Graphics --
	
	-- Use Fullscreen
	LabelSetText( "SettingsGraphicsUseFullscreenLabel", GetStringFromTid( SettingsWindow.TID.UseFull ) )
	WindowSetId( "SettingsGraphicsUseFullscreenLabel", SettingsWindow.DetailTID.UseFull )
	ButtonSetCheckButtonFlag( "SettingsGraphicsUseFullscreenButton", true )
	
	-- Fullscreen Resolution
	LabelSetText( "SettingsGraphicsFullScreenResLabel", GetStringFromTid( SettingsWindow.TID.FullRes ) )
	WindowSetId( "SettingsGraphicsFullScreenResLabel", SettingsWindow.DetailTID.FullRes )
	for res = 1, table.getn( SystemData.AvailableResolutions.widths )do
		ComboBoxAddMenuItem( "SettingsGraphicsFullScreenResCombo", L""..SystemData.AvailableResolutions.widths[res]..L" x "..SystemData.AvailableResolutions.heights[res] )
	end
	
	-- Framerate Max
	LabelSetText( "SettingsGraphicsFramerateMaxLabel", GetStringFromTid( SettingsWindow.TID.MaxFramerate ) )
	WindowSetId( "SettingsGraphicsFramerateMaxLabel", SettingsWindow.DetailTID.MaxFramerate )
	for index, tid in ipairs( SettingsWindow.TID_FRAMERATE )do
		ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", GetStringFromTid( tid ) )
	end
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"70 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"80 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"90 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"100 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"110 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"120 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"130 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"140 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"150 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"160 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"170 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"180 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"190 FPS" )
	ComboBoxAddMenuItem( "SettingsGraphicsFramerateMaxCombo", L"200 FPS" )
	
	-- Show Frame
	LabelSetText( "SettingsGraphicsShowFrameLabel", GetStringFromTid( SettingsWindow.TID.ShowFrame ) )
	WindowSetId( "SettingsGraphicsShowFrameLabel", SettingsWindow.DetailTID.ShowFrame )
	ButtonSetCheckButtonFlag( "SettingsGraphicsShowFrameButton", true )
	
	-- Brightness
	LabelSetText( "GammaText", GetStringFromTid( SettingsWindow.TID.Gamma ) )
	WindowSetId( "GammaText", SettingsWindow.DetailTID.Gamma )
	
	-- Show Foliage
	LabelSetText( "SettingsGraphicsShowFoliageLabel", GetStringFromTid( SettingsWindow.TID.ShowFoliage ) )
	WindowSetId( "SettingsGraphicsShowFoliageLabel", SettingsWindow.DetailTID.ShowFoliage )
	ButtonSetStayDownFlag( "SettingsGraphicsShowFoliageButton", true )
	ButtonSetCheckButtonFlag( "SettingsGraphicsShowFoliageButton", true )
	
	-- Show Shadows
	LabelSetText( "SettingsGraphicsShowShadowsLabel", GetStringFromTid( SettingsWindow.TID.ShowShadows ) )
	WindowSetId( "SettingsGraphicsShowShadowsLabel", SettingsWindow.DetailTID.ShowShadows )
	ButtonSetCheckButtonFlag( "SettingsGraphicsShowShadowsButton", true )

	-- Enable Vsync
	LabelSetText( "SettingsGraphicsEnableVSyncLabel", GetStringFromTid( SettingsWindow.TID.EnableVsync ) )
	WindowSetId( "SettingsGraphicsEnableVSyncLabel", SettingsWindow.DetailTID.EnableVsync )
	ButtonSetCheckButtonFlag( "SettingsGraphicsEnableVSyncButton", true )
	
	-- Use Circle of Transparency
	LabelSetText( "SettingsGraphicsCircleOfTransparencyLabel", GetStringFromTid( SettingsWindow.TID.CircleOfTransparency ) )
	WindowSetId( "SettingsGraphicsCircleOfTransparencyLabel", SettingsWindow.DetailTID.CircleOfTransparency )
	ButtonSetCheckButtonFlag( "SettingsGraphicsCircleOfTransparencyButton", true )
    
    -- Use Old Death Effect
	LabelSetText( "SettingsGraphicsHardwareDeathEffectLabel", GetStringFromTid( SettingsWindow.TID.HardwareDeathEffect ) )
	WindowSetId( "SettingsGraphicsHardwareDeathEffectLabel", SettingsWindow.DetailTID.HardwareDeathEffect )
	ButtonSetCheckButtonFlag( "SettingsGraphicsHardwareDeathEffectButton", true )
	
	-- Particle Detail
	LabelSetText( "SettingsGraphicsParticleLODLabel", GetStringFromTid( SettingsWindow.TID.ParticleLOD )..L":" )
	WindowSetId( "SettingsGraphicsParticleLODLabel", SettingsWindow.DetailTID.ParticleLOD )
	for index, tid in ipairs( SettingsWindow.TID_DETAILS )do
		ComboBoxAddMenuItem( "SettingsGraphicsParticleLODCombo", GetStringFromTid( tid ) )
	end
	
	-- Particle Filter
	LabelSetText( "SettingsGraphicsParticleFilterLabel", GetStringFromTid( SettingsWindow.TID.ParticleFilter )..L":" )
	WindowSetId( "SettingsGraphicsParticleFilterLabel", SettingsWindow.DetailTID.ParticleFilter )
	for index, tid in ipairs( SettingsWindow.TID_FILTERS )do
		ComboBoxAddMenuItem( "SettingsGraphicsParticleFilterCombo", GetStringFromTid( tid ) )
	end

	-- Idle Animation (Restart Required)
	LabelSetText( "SettingsGraphicsPlayIdleAnimationLabel", GetStringFromTid( SettingsWindow.TID.PlayIdleAnimation ) )
	WindowSetId( "SettingsGraphicsPlayIdleAnimationLabel", SettingsWindow.DetailTID.PlayIdleAnimation )
	ButtonSetCheckButtonFlag( "SettingsGraphicsPlayIdleAnimationButton", true )
	
	-- Animation (Restart Required)
	LabelSetText( "SettingsGraphicsAnimationLabel", GetStringFromTid( SettingsWindow.TID.Animation )..L":" )
	WindowSetId( "SettingsGraphicsAnimationLabel", SettingsWindow.DetailTID.Animation )
	for index, tid in ipairs( SettingsWindow.TID_ANIMATION )do
		ComboBoxAddMenuItem( "SettingsGraphicsAnimationCombo", GetStringFromTid( tid ) )
	end

	-- Input --
	
	-- Scroll Wheel Behavior
	LabelSetText( "SettingsKeyBindingsScrollWheelUpLabel", GetStringFromTid( SettingsWindow.TID.ScrollWheelUp ) )
	WindowSetId( "SettingsKeyBindingsScrollWheelUpLabel", SettingsWindow.DetailTID.ScrollWheelUp )
	LabelSetText( "SettingsKeyBindingsScrollWheelDownLabel", GetStringFromTid( SettingsWindow.TID.ScrollWheelDown ) )
	WindowSetId( "SettingsKeyBindingsScrollWheelDownLabel", SettingsWindow.DetailTID.ScrollWheelDown )
	SettingsWindow.RefreshScrollWheelComboBoxes()
	
	-- Classic Key Default
	LabelSetText( "SettingsKeyDefaultWindowLegacyKeysName", GetStringFromTid( SettingsWindow.TID.LegacyKeyDefault ) )
	WindowSetId( "SettingsKeyDefaultWindowLegacyKeysName", SettingsWindow.DetailTID.LegacyKeyDefault )
	-- Enhanced Key Default
	LabelSetText( "SettingsKeyDefaultWindowMMOKeysName", GetStringFromTid( SettingsWindow.TID.MMOKeyDefault ) )
	WindowSetId( "SettingsKeyDefaultWindowMMOKeysName", SettingsWindow.DetailTID.MMOKeyDefault )
	
	-- Key Bindings
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."Action", GetStringFromTid( SettingsWindow.Keybindings[key].tid ) )
	end	

	-- Sound --
	
	-- Master Volume
	ButtonSetStayDownFlag( "MasterVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "MasterVolumeToggleButton", true )
		
	LabelSetText( "MasterVolumeText", GetStringFromTid( SettingsWindow.TID.SoundVol ) )
	WindowSetId( "MasterVolumeText", SettingsWindow.DetailTID.SoundVol )
	LabelSetText( "MasterVolumeToggleLabel", GetStringFromTid( SettingsWindow.TID.EnableSound ) )
	WindowSetId( "MasterVolumeToggleLabel", SettingsWindow.DetailTID.EnableSound )
	LabelSetText( "MasterVolumeVal", L""..( math.floor( SystemData.Settings.Sound.master.volume*100 ) ) )
	
	-- Effects Volume
	ButtonSetStayDownFlag( "EffectsVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "EffectsVolumeToggleButton", true )
	
	LabelSetText( "EffectsVolumeText", GetStringFromTid( SettingsWindow.TID.EffectsVolume ) )
	WindowSetId( "EffectsVolumeText", SettingsWindow.DetailTID.EffectsVolume )
	LabelSetText( "EffectsVolumeToggleLabel", GetStringFromTid( SettingsWindow.TID.EnableEffects ) )
	WindowSetId( "EffectsVolumeToggleLabel", SettingsWindow.DetailTID.EnableEffects )
	LabelSetText( "EffectsVolumeVal", L""..( math.floor( SystemData.Settings.Sound.effects.volume*100 ) ) )
	
	-- EC PlaySound Volume
	ButtonSetStayDownFlag( "ECPlaySoundVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "ECPlaySoundVolumeToggleButton", true )
	LabelSetText( "ECPlaySoundVolumeText", UI.GetCliloc(SystemData.Settings.Language.type, 1631) )
	WindowSetId( "ECPlaySoundVolumeText", SettingsWindow.DetailTID.ECVolume )
	LabelSetText( "ECPlaySoundVolumeToggleLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1648) )
	WindowSetId( "ECPlaySoundVolumeToggleLabel", SettingsWindow.DetailTID.ECPlaySound )
	
	
	-- Music Volume
	ButtonSetStayDownFlag( "MusicVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "MusicVolumeToggleButton", true )
	
	LabelSetText( "MusicVolumeText", GetStringFromTid( SettingsWindow.TID.MusicVolume ) )
	WindowSetId( "MusicVolumeText", SettingsWindow.DetailTID.MusicVolume )
	LabelSetText( "MusicVolumeToggleLabel", GetStringFromTid( SettingsWindow.TID.EnableMusic ) )
	WindowSetId( "MusicVolumeToggleLabel", SettingsWindow.DetailTID.EnableMusic )
	LabelSetText( "MusicVolumeVal", L""..( math.floor( SystemData.Settings.Sound.music.volume*100 ) ) )
	
	-- EC PlayMusic Volume
	ButtonSetStayDownFlag( "ECPlayMusicVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "ECPlayMusicVolumeToggleButton", true )
	LabelSetText( "ECPlayMusicVolumeText", UI.GetCliloc(SystemData.Settings.Language.type, 1650) )
	WindowSetId( "ECPlayMusicVolumeText", SettingsWindow.DetailTID.ECMusicVolume )
	LabelSetText( "ECPlayMusicVolumeToggleLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1649) )
	WindowSetId( "ECPlayMusicVolumeToggleLabel", SettingsWindow.DetailTID.ECPlayMusic )

	-- Play Footsteps
	ButtonSetStayDownFlag( "PlayFootstepsToggleButton", true )
	ButtonSetCheckButtonFlag( "PlayFootstepsToggleButton", true )
	LabelSetText( "PlayFootstepsToggleLabel", GetStringFromTid( SettingsWindow.TID.PlayFootsteps ) )
	WindowSetId( "PlayFootstepsToggleLabel", SettingsWindow.DetailTID.PlayFootsteps )
	
	-- Play Heartbeat
	ButtonSetStayDownFlag( "PlayHeartbeatVolumeToggleButton", true )
	ButtonSetCheckButtonFlag( "PlayHeartbeatVolumeToggleButton", true )
	LabelSetText( "PlayHeartbeatVolumeToggleLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1632) )
	WindowSetId( "PlayHeartbeatVolumeToggleLabel", SettingsWindow.DetailTID.Heartbeat )
	LabelSetText( "PlayHeartbeatVolumeText", UI.GetCliloc(SystemData.Settings.Language.type, 1633))
	WindowSetId( "PlayHeartbeatVolumeText", SettingsWindow.DetailTID.HeartbeatVol )
	
	-- Options --
	
	-- Language
	LabelSetText( "SettingsOptionsLanguageLabel", GetStringFromTid( SettingsWindow.TID.Language ) )
	WindowSetId( "SettingsOptionsLanguageLabel", SettingsWindow.DetailTID.Language )
	for lan = 1, SettingsWindow.NUM_LANGUAGES do
		local text = GetStringFromTid( SettingsWindow.Languages[lan].tid )
		ComboBoxAddMenuItem( "SettingsOptionsLanguageCombo", L""..text )
	end
    
    -- English item names
    LabelSetText( "SettingsOptionsEnglishNamesLabel", GetStringFromTid( SettingsWindow.TID.EnglishNames ) ) 
    WindowSetId( "SettingsOptionsEnglishNamesLabel", SettingsWindow.DetailTID.EnglishNames )
    ButtonSetCheckButtonFlag( "SettingsOptionsEnglishNamesButton", true )
	
	-- Cache
	LabelSetText( "SettingsOptionsCacheSizeText", GetStringFromTid( SettingsWindow.TID.DiskCache ) )
	WindowSetId( "SettingsOptionsCacheSizeText", SettingsWindow.DetailTID.DiskCache )
	
	-- Always Run
	LabelSetText( "AlwaysRunLabel", GetStringFromTid( SettingsWindow.TID.AlwaysRun ) )
	WindowSetId( "AlwaysRunLabel", SettingsWindow.DetailTID.AlwaysRun )
	ButtonSetCheckButtonFlag( "AlwaysRunButton", true )
	
	-- Enable Autorun
	LabelSetText( "EnableAutorunLabel", GetStringFromTid( SettingsWindow.TID.EnableAutorun ) )
	WindowSetId( "EnableAutorunLabel", SettingsWindow.DetailTID.EnableAutorun )
	ButtonSetCheckButtonFlag( "EnableAutorunButton", true )
	
	-- Enable Pathfinding
	LabelSetText( "EnablePathfindingLabel", GetStringFromTid( SettingsWindow.TID.EnablePathfinding ) )
	WindowSetId( "EnablePathfindingLabel", SettingsWindow.DetailTID.EnablePathfinding )
	ButtonSetCheckButtonFlag( "EnablePathfindingButton", true )
	
	-- Always Attack
	LabelSetText( "AlwaysAttackLabel", GetStringFromTid( SettingsWindow.TID.AlwaysAttack ) )
	WindowSetId( "AlwaysAttackLabel", SettingsWindow.DetailTID.AlwaysAttack )
	ButtonSetCheckButtonFlag( "AlwaysAttackButton", true )
	
	-- Query Before Criminal Actions
	LabelSetText( "QueryBeforeCriminalActionsLabel", GetStringFromTid( SettingsWindow.TID.QueryBeforeCriminalActions ) )
	WindowSetId( "QueryBeforeCriminalActionsLabel", SettingsWindow.DetailTID.QueryBeforeCriminalActions )
	ButtonSetCheckButtonFlag( "QueryBeforeCriminalActionsButton", true )
	
	-- Ignore Mouse Actions on Self
	LabelSetText( "IgnoreMouseActionsOnSelfLabel", GetStringFromTid( SettingsWindow.TID.IgnoreMouseActionsOnSelf ) )
	WindowSetId( "IgnoreMouseActionsOnSelfLabel", SettingsWindow.DetailTID.IgnoreMouseActionsOnSelf )
	ButtonSetCheckButtonFlag( "IgnoreMouseActionsOnSelfButton", true )
	
	-- Hold Shift to Unstack
	LabelSetText( "HoldShiftToUnstackLabel", GetStringFromTid( SettingsWindow.TID.HoldShiftToUnstack ) )
	WindowSetId( "HoldShiftToUnstackLabel", SettingsWindow.DetailTID.HoldShiftToUnstack )
	ButtonSetCheckButtonFlag( "HoldShiftToUnstackButton", true )
	
	-- Shift-Right Click to Open Context Menus
	LabelSetText( "ShiftRightClickContextMenusLabel", GetStringFromTid( SettingsWindow.TID.ShiftRightClickContextMenus ) )
	WindowSetId( "ShiftRightClickContextMenusLabel", SettingsWindow.DetailTID.ShiftRightClickContextMenus )
	ButtonSetCheckButtonFlag( "ShiftRightClickContextMenusButton", true )
	
	-- Cursor Target Queueing
	LabelSetText( "TargetQueueingLabel", GetStringFromTid( SettingsWindow.TID.TargetQueueing ) )
	WindowSetId( "TargetQueueingLabel", SettingsWindow.DetailTID.TargetQueueing )
	ButtonSetCheckButtonFlag( "TargetQueueingButton", true )
	
	-- Use Custom UI
	LabelSetText( "CustomSkinsLabel", GetStringFromTid( SettingsWindow.TID.CustomUI )..L":" )
	WindowSetId( "CustomSkinsLabel", SettingsWindow.DetailTID.CustomUI )
	for skinItr = 1, #SystemData.CustomUIList do
		local text = SystemData.CustomUIList[skinItr]
		if text == "" then
			ComboBoxAddMenuItem( "CustomSkinsCombo", GetStringFromTid( 3000094 ) )-- "Default"
		else
			ComboBoxAddMenuItem( "CustomSkinsCombo", StringToWString( text ) )
		end
	end
	
	-- UI Scale
	LabelSetText( "UiScaleText", GetStringFromTid( SettingsWindow.TID.UiScale ) )
	WindowSetId( "UiScaleText", SettingsWindow.DetailTID.UiScale )
	
	-- Default Container View
	-- Default Corpse View
	LabelSetText( "ContainerViewLabel", GetStringFromTid( SettingsWindow.TID.DefaultContainerView )..L":" )
	WindowSetId( "ContainerViewLabel", SettingsWindow.DetailTID.DefaultContainerView )
	LabelSetText( "CorpseViewLabel", GetStringFromTid( SettingsWindow.TID.DefaultCorpseView )..L":" )
	WindowSetId( "CorpseViewLabel", SettingsWindow.DetailTID.DefaultCorpseView )
	for id, data in ipairs(SettingsWindow.ContainerViewOptions) do
	    ComboBoxAddMenuItem( "ContainerViewCombo", GetStringFromTid(data.tid) )
	    ComboBoxAddMenuItem( "CorpseViewCombo", GetStringFromTid(data.tid) )
	end
	
	-- Show Corpse Names
	LabelSetText( "ShowCorpseNamesLabel", GetStringFromTid( SettingsWindow.TID.ShowCorpseNames ) )
	WindowSetId( "ShowCorpseNamesLabel", SettingsWindow.DetailTID.ShowCorpseNames )
	ButtonSetCheckButtonFlag( "ShowCorpseNamesButton", true )
	
	-- Always show Health, Mana, and Stamina
	LabelSetText( "ShowStrLabelLabel", GetStringFromTid( SettingsWindow.TID.ShowStrLabel ) )
	WindowSetId( "ShowStrLabelLabel", SettingsWindow.DetailTID.ShowStrLabel )
	ButtonSetCheckButtonFlag( "ShowStrLabelButton", true )
	
	-- Tooltips
	LabelSetText( "TooltipsLabel", GetStringFromTid( SettingsWindow.TID.Tooltips ) )
	WindowSetId( "TooltipsLabel", SettingsWindow.DetailTID.Tooltips )
	ButtonSetCheckButtonFlag( "TooltipsButton", true )
	
	-- Display Pop-Up Window for Party Invitations
	LabelSetText( "PartyInvitePopUpLabel", GetStringFromTid( SettingsWindow.TID.PartyInvitePopUp ) )
	WindowSetId( "PartyInvitePopUpLabel", SettingsWindow.DetailTID.PartyInvitePopUp )
	ButtonSetCheckButtonFlag( "PartyInvitePopUpButton", true )
	
	-- Tip of the Day
	LabelSetText( "TipoftheDayLabel", GetStringFromTid( SettingsWindow.TID.TipoftheDay) )
	WindowSetId( "TipoftheDayLabel", SettingsWindow.DetailTID.TipoftheDay )
	ButtonSetCheckButtonFlag( "TipoftheDayButton", true )
	
	-- Reset UI Locs
	ButtonSetText( "ResetUILocButton", GetStringFromTid( SettingsWindow.TID.ResetUILocPos) )
	
	-- Object Handle Filter
	LabelSetText( "SettingsOptionsObjHandleFilterLabel", L""..GetStringFromTid( SettingsWindow.TID.ObjectHandleFilter )..L":" )
	WindowSetId( "SettingsOptionsObjHandleFilterLabel", SettingsWindow.DetailTID.ObjectHandleFilter )
	for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
		local text = GetStringFromTid( SettingsWindow.ObjectHandles[filter].tid )
		ComboBoxAddMenuItem( "SettingsOptionsObjHandleFilterCombo", L""..text )
	end
	
	-- Object Handle Quantity
	LabelSetText( "SettingsOptionsObjHandleSizeLabel", L""..GetStringFromTid( SettingsWindow.TID.ObjectHandleQuantity )..L":" )
	WindowSetId( "SettingsOptionsObjHandleSizeLabel", SettingsWindow.DetailTID.ObjectHandleQuantity )
	for indexSize, objHandleSize in pairs( SettingsWindow.ObjectHandleSizes )do
		--( -1 )is considered max size
		local text = SettingsWindow.ObjectHandleSizes[indexSize]
		if( objHandleSize == -1 )then
			text = GetStringFromTid( 1077866 )-- "All"
		end
		ComboBoxAddMenuItem( "SettingsOptionsObjHandleSizeCombo", L""..text )
	end
	
	-- Show Names
	LabelSetText( "SettingsOptionsShowNamesLabel", GetStringFromTid( SettingsWindow.TID.ShowNames )..L":" )
	WindowSetId( "SettingsOptionsShowNamesLabel", SettingsWindow.DetailTID.ShowNames )
	for sn = 1, SettingsWindow.NUM_SHOWNAMES do
		local text = GetStringFromTid( SettingsWindow.ShowNames[sn].tid )
		ComboBoxAddMenuItem( "SettingsOptionsShowNamesCombo", L""..text )
	end
	
	-- Show Chat Windows
	--LabelSetText( "ShowChatWindowLabel", GetStringFromTid( SettingsWindow.TID.ShowChatWindow ) )
	--ButtonSetCheckButtonFlag( "ShowChatWindowButton", true )
		
	-- Overhead Chat
	LabelSetText( "OverheadChatLabel", GetStringFromTid( SettingsWindow.TID.OverheadChat ) )
	WindowSetId( "OverheadChatLabel", SettingsWindow.DetailTID.OverheadChat )
	ButtonSetCheckButtonFlag( "OverheadChatButton", true )
	
	-- Overhead Chat Fade Delay
	LabelSetText( "OverheadChatFadeDelayLabel", GetStringFromTid( SettingsWindow.TID.OverheadChatFadeDelay )..L":" )
	WindowSetId( "OverheadChatFadeDelayLabel", SettingsWindow.DetailTID.OverheadChatFadeDelay )
	for delay = 1, SettingsWindow.NUM_DELAY_VALUES do
		local text = GetStringFromTid( SettingsWindow.DelayValues[delay] )
		ComboBoxAddMenuItem( "OverheadChatFadeDelayCombo", L""..text )
	end
	
	-- Enable chat log
	LabelSetText( "EnableChatLogLabel", GetStringFromTid( SettingsWindow.TID.EnableChatLog ) )
	WindowSetId( "EnableChatLogLabel", SettingsWindow.DetailTID.EnableChatLog )
	ButtonSetCheckButtonFlag( "EnableChatLogButton", true )
	
	
	-- Legacy --
		
	-- Legacy Chat
	LabelSetText( "LegacyChatLabel", GetStringFromTid( SettingsWindow.TID.LegacyChat ) )
	WindowSetId( "LegacyChatLabel", SettingsWindow.DetailTID.LegacyChat )
	ButtonSetCheckButtonFlag( "LegacyChatButton", true )
	
	-- Use Legacy Container Art
	LabelSetText( "SettingsLegacyUseLegacyContainersLabel", GetStringFromTid( SettingsWindow.TID.UseLegacyContainers ) )
	WindowSetId( "SettingsLegacyUseLegacyContainersLabel", SettingsWindow.DetailTID.UseLegacyContainers )
	ButtonSetCheckButtonFlag( "SettingsLegacyUseLegacyContainersButton", true )
	
	-- Use Legacy Paperdoll Art
	LabelSetText( "SettingsLegacyUseLegacyPaperdollsLabel", GetStringFromTid( SettingsWindow.TID.UseLegacyPaperdolls ) )
	WindowSetId( "SettingsLegacyUseLegacyPaperdollsLabel", SettingsWindow.DetailTID.UseLegacyPaperdolls )
	ButtonSetCheckButtonFlag( "SettingsLegacyUseLegacyPaperdollsButton", true )
	
	-- Use Legacy Targeting
	LabelSetText( "SettingsLegacyLegacyTargetingLabel", GetStringFromTid( SettingsWindow.TID.LegacyTargeting ) )
	WindowSetId( "SettingsLegacyLegacyTargetingLabel", SettingsWindow.DetailTID.LegacyTargeting )
	ButtonSetCheckButtonFlag( "SettingsLegacyLegacyTargetingButton", true )
	
	-- Update the settings
	SettingsWindow.UpdateSettings()
			
	-- Update the scroll window
	ScrollWindowSetOffset( "SettingsGraphicsWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsGraphicsWindow" )
	ScrollWindowSetOffset( "SettingsKeyBindingsWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsKeyBindingsWindow" )
	ScrollWindowSetOffset( "SettingsSoundWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsSoundWindow" )
	ScrollWindowSetOffset( "SettingsOptionsWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsOptionsWindow" )
	ScrollWindowSetOffset( "SettingsLegacyWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsLegacyWindow" )
	
	
	-- Call backs
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.USER_SETTINGS_UPDATED, "SettingsWindow.UpdateSettings" )
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.INTERFACE_KEY_RECORDED, "SettingsWindow.KeyRecorded" )
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.INTERFACE_KEY_CANCEL_RECORD, "SettingsWindow.KeyCancelRecord" )
	WindowRegisterEventHandler( "SettingsWindow", SystemData.Events.TOGGLE_USER_PREFERENCE, "SettingsWindow.ToggleSettingsWindow" )
	
	-- Profanity --
	LabelSetText( "BadWordFilterOptionLabel", GetStringFromTid( SettingsWindow.TID.FilterObscenity ) )
	WindowSetId( "BadWordFilterOptionLabel", SettingsWindow.DetailTID.FilterObscenity )
	ButtonSetStayDownFlag( "BadWordFilterOptionButton", true )
	ButtonSetCheckButtonFlag( "BadWordFilterOptionButton", true )

	LabelSetText( "IgnoreListOptionLabel", GetStringFromTid( SettingsWindow.TID.IgnorePlayers ) )
	WindowSetId( "IgnoreListOptionLabel", SettingsWindow.DetailTID.IgnorePlayers )
	ButtonSetStayDownFlag( "IgnoreListOptionButton", true )
	ButtonSetCheckButtonFlag( "IgnoreListOptionButton", true )

	ButtonSetText( "IgnoreListAddButton", UI.GetCliloc(SystemData.Settings.Language.type, 1501) )
	ButtonSetText( "IgnoreListChatListButton", UI.GetCliloc(SystemData.Settings.Language.type, 1502) )
	ButtonSetText( "IgnoreListDeleteButton", GetStringFromTid(3000176) )
	
	LabelSetText( "IgnoreConfListOptionLabel", GetStringFromTid( SettingsWindow.TID.IgnoreConfPlayers ) )
	WindowSetId( "IgnoreConfListOptionLabel", SettingsWindow.DetailTID.IgnoreConfPlayers )
	ButtonSetStayDownFlag( "IgnoreConfListOptionButton", true )
	ButtonSetCheckButtonFlag( "IgnoreConfListOptionButton", true )
	
	ButtonSetText( "IgnoreConfListAddButton", L"Add By Target" )
	ButtonSetText( "IgnoreConfListChatListButton", L"Add From Chat" )
	ButtonSetText( "IgnoreConfListDeleteButton", L"Delete" )


	SettingsWindow.PopulateProfanityList()

	-- THESE ELEMENTS ARE NOT READY FOR THIS MILESTONE 3/23/2007. RESTORE THE FOLLOWING LINES AS THEY BECOME AVAILABLE!
	-- YOU WILL ALSO HAVE TO UNCOMMENT AND RE-ANCHOR THINGS IN THE XML!
	-- And you'll also need to restore the commented out LabelSetText functions for them
	-- WindowSetShowing( "Pathfinding", false )
	-- WindowSetShowing( "Movie", false )
	-- WindowSetShowing( "ObjectHandles", false )
	-- WindowSetShowing( "ChatWindowFadeDelaySliderBar", false )
	-- WindowSetShowing( "OverheadChatFadeDelaySliderBar", false )
	-- WindowSetShowing( "TooltipDelayLabel", false )
	-- WindowSetShowing( "TooltipDelayDelaySliderBar", false )
	
	-- PINCO
	LabelSetText( "SettingsPincoSubSection1Label", UI.GetCliloc(SystemData.Settings.Language.type, 1503) ) -- L"Overhead Text Settings"
	
	LabelSetText( "SettingsPincoToggleOverheadSpellsLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1504) ) --L"Enable Overhead Spells Text"
	WindowSetId( "SettingsPincoToggleOverheadSpellsLabel", SettingsWindow.DetailTID.OverheadSpells )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleOverheadSpellsButton", true )
	
	LabelSetText( "SettingsPincoToggleOverheadSpellNamesLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1505) ) -- L"Enable English Spell Names" 
	WindowSetId( "SettingsPincoToggleOverheadSpellNamesLabel", SettingsWindow.DetailTID.EnglishSpells )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleOverheadSpellNamesButton", true )
	
	LabelSetText( "SettingsPincoToggleSadModeLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1506) ) -- L"Enable Sad Mode"
	WindowSetId( "SettingsPincoToggleSadModeLabel", SettingsWindow.DetailTID.DefaulSadModeColor )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleSadModeButton", true )
	
	LabelSetText( "SettingsPincoToggleClickableNamesLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1662) )
	WindowSetId( "SettingsPincoToggleClickableNamesLabel", SettingsWindow.DetailTID.ClickableNames )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleClickableNamesButton", true )
	
	LabelSetText( "SettingsPincoTogglePoisonOthersLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1663) )
	WindowSetId( "SettingsPincoTogglePoisonOthersLabel", SettingsWindow.DetailTID.PoisonOthers )
	ButtonSetCheckButtonFlag( "SettingsPincoTogglePoisonOthersButton", true )
	
	
	ButtonSetText( "OverheadTextSizePlus", UI.GetCliloc(SystemData.Settings.Language.type, 1507) ) -- L"Text Size +"
	WindowSetId( "OverheadTextSizePlus", SettingsWindow.DetailTID.DefaulTextSizePlus )
	
	ButtonSetText( "OverheadTextSizeMinus", UI.GetCliloc(SystemData.Settings.Language.type, 1508)) -- L"Text Size -"
	WindowSetId( "OverheadTextSizeMinus", SettingsWindow.DetailTID.DefaulTextSizeMinus )
	
	ButtonSetText( "OverheadChatFont",  UI.GetCliloc(SystemData.Settings.Language.type, 1509)) -- L"Speech Font"
	WindowSetId( "OverheadChatFont", SettingsWindow.DetailTID.DefaulSpeechFont )
	
	ButtonSetText( "OverheadNamesFont", UI.GetCliloc(SystemData.Settings.Language.type, 1510)) -- L"Names Font" 
	WindowSetId( "OverheadNamesFont", SettingsWindow.DetailTID.DefaulNamesFont )
	
	ButtonSetText( "OverheadSpellFont", UI.GetCliloc(SystemData.Settings.Language.type, 1511) ) -- L"Spells Font" 
	WindowSetId( "OverheadSpellFont", SettingsWindow.DetailTID.DefaulSpellsFont )
	
	ButtonSetText( "OverheadDamageFont", UI.GetCliloc(SystemData.Settings.Language.type, 1512) ) -- L"Damages Font"
	WindowSetId( "OverheadDamageFont", SettingsWindow.DetailTID.DefaulDamagesFont )
	
	
	LabelSetText( "SettingsPincoSubSection4Label", UI.GetCliloc(SystemData.Settings.Language.type, 1513) ) -- L"Object Handle Settings"
	
	LabelSetText( "SettingsPincoNormalSizeLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1514) ) -- L"Normal Size" 
	WindowSetId( "SettingsPincoNormalSizeLabel", SettingsWindow.DetailTID.DefaulObjectHandleSize )
	ButtonSetCheckButtonFlag( "SettingsPincoNormalSizeButton", true )
	
	LabelSetText( "SettingsPincoMediumSizeLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1515) ) -- L"Medium Size"
	WindowSetId( "SettingsPincoMediumSizeLabel", SettingsWindow.DetailTID.DefaulObjectHandleSize )
	ButtonSetCheckButtonFlag( "SettingsPincoMediumSizeButton", true )
	
	LabelSetText( "SettingsPincoSmallSizeLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1516) ) -- L"Small Size"
	WindowSetId( "SettingsPincoSmallSizeLabel", SettingsWindow.DetailTID.DefaulObjectHandleSize )
	ButtonSetCheckButtonFlag( "SettingsPincoSmallSizeButton", true )
	
	
	
	LabelSetText( "SettingsPincoDullLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1517)  ) --L"Dull Label"
	WindowSetId( "SettingsPincoDullLabel", SettingsWindow.DetailTID.DefaulOpacity )
	ButtonSetCheckButtonFlag( "SettingsPincoDullButton", true )
	
	LabelSetText( "SettingsPincoHalfDullLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1518) ) -- L"Half Dull Label"
	WindowSetId( "SettingsPincoHalfDullLabel", SettingsWindow.DetailTID.DefaulOpacity )
	ButtonSetCheckButtonFlag( "SettingsPincoHalfDullButton", true )
	
	LabelSetText( "SettingsPincoTransparentLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1519)  ) -- L"Transparent Label"
	WindowSetId( "SettingsPincoTransparentLabel", SettingsWindow.DetailTID.DefaulOpacity )
	ButtonSetCheckButtonFlag( "SettingsPincoTransparentButton", true )
	
	LabelSetText( "SettingsPincoObjectHandleWindowLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1520) ) -- L"Object Handle Window"
	WindowSetId( "SettingsPincoObjectHandleWindowLabel", SettingsWindow.DetailTID.ObjectHandleWindow )
	ButtonSetCheckButtonFlag( "SettingsPincoObjectHandleWindowButton", true )
	
	LabelSetText( "SettingsPincoSubSection5Label", UI.GetCliloc(SystemData.Settings.Language.type, 1521) ) --L"Center Screen Text Settings"
	
	LabelSetText( "SettingsPincoCenterScreenTextPosLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1522)  ) -- L"Text Position"
	WindowSetId( "SettingsPincoCenterScreenTextPosLabel", SettingsWindow.DetailTID.CenterscreenTextPos )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextPosCombo",UI.GetCliloc(SystemData.Settings.Language.type, 1523)  )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextPosCombo",UI.GetCliloc(SystemData.Settings.Language.type, 1524)  )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextPosCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1525) )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextPosCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1526) )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextPosCombo",UI.GetCliloc(SystemData.Settings.Language.type, 1527) )
	
	LabelSetText( "SettingsPincoCenterScreenTextLowHPLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1528)  )
	WindowSetId( "SettingsPincoCenterScreenTextLowHPLabel", SettingsWindow.DetailTID.CenterscreenLowHP )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"20%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"30%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"40%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"50%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"60%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"70%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"80%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"90%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", L"99%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1529) )
	
	LabelSetText( "SettingsPincoCenterScreenTextLowHPPetLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1530)  )
	WindowSetId( "SettingsPincoCenterScreenTextLowHPPetLabel", SettingsWindow.DetailTID.CenterscreenLowHPPet )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPPetCombo", L"20%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPPetCombo", L"30%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPPetCombo", L"40%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPPetCombo", L"50%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPPetCombo", L"60%" )
	ComboBoxAddMenuItem( "SettingsPincoCenterScreenTextLowHPPetCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1529) )
	
	LabelSetText( "SettingsPincoIgnoreSummonsLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1531) ) -- L"Ignore Summons for low HP warning"
	WindowSetId( "SettingsPincoIgnoreSummonsLabel", SettingsWindow.DetailTID.Ignoresummon )
	ButtonSetCheckButtonFlag( "SettingsPincoIgnoreSummonsButton", true )
	
	ButtonSetText( "CenterscreenTest", UI.GetCliloc(SystemData.Settings.Language.type, 1532) )
	WindowSetId( "CenterscreenTest", SettingsWindow.DetailTID.CenterscreenTest )
	
	
	LabelSetText( "SettingsPincoSubSection6Label", UI.GetCliloc(SystemData.Settings.Language.type, 1533) )
	
	
	LabelSetText( "SettingsPincoHotbarSlotsLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1534)  )
	WindowSetId( "SettingsPincoHotbarSlotsLabel", SettingsWindow.DetailTID.HotbarSlots )
	for i = 1, 12 do
		ComboBoxAddMenuItem( "SettingsPincoHotbarSlotsCombo", L"".. i )
	end
	
	LabelSetText( "SettingsPincoHorizLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1535) )
	WindowSetId( "SettingsPincoHorizLabel", SettingsWindow.DetailTID.HotbarOrient )
	ButtonSetCheckButtonFlag( "SettingsPincoHorizButton", true )
	
	LabelSetText( "SettingsPincoVerticLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1536) )
	WindowSetId( "SettingsPincoVerticLabel", SettingsWindow.DetailTID.HotbarOrient )
	ButtonSetCheckButtonFlag( "SettingsPincoVerticButton", true )
	
	LabelSetText( "SettingsPincoNoSpaceLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1537)  )
	WindowSetId( "SettingsPincoNoSpaceLabel", SettingsWindow.DetailTID.HBNoSpace )
	ButtonSetCheckButtonFlag( "SettingsPincoNoSpaceButton", true )
	
	
	LabelSetText( "SettingsPincoSubSection8Label", UI.GetCliloc(SystemData.Settings.Language.type, 1538) )
		
	LabelSetText( "SettingsPincoToggleGridLegacyLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1539)  )
	WindowSetId( "SettingsPincoToggleGridLegacyLabel", SettingsWindow.DetailTID.GridLegacy )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleGridLegacyButton", true )
	
	LabelSetText( "SettingsPincoToggleContentsInfoLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1680)  )
	WindowSetId( "SettingsPincoToggleContentsInfoLabel", SettingsWindow.DetailTID.ContentsInfo )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleContentsInfoButton", true )
	
	LabelSetText( "SettingsPincoHighlightLastLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1682)  )
	WindowSetId( "SettingsPincoHighlightLastLabel", SettingsWindow.DetailTID.HighlightLast )
	ButtonSetCheckButtonFlag( "SettingsPincoHighlightLastButton", true )
	
	LabelSetText( "SettingsPincoToggleGridLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1540) )
	WindowSetId( "SettingsPincoToggleGridLabel", SettingsWindow.DetailTID.ContainersGrid )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleGridButton", true )
	
	LabelSetText( "SettingsPincoToggleQuickLootLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1640) )
	WindowSetId( "SettingsPincoToggleQuickLootLabel", SettingsWindow.DetailTID.QuickLoot )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleQuickLootButton", true )
	
	LabelSetText( "SettingsPincoToggleExtraBrightLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1541)  )
	WindowSetId( "SettingsPincoToggleExtraBrightLabel", SettingsWindow.DetailTID.ExtraBright )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleExtraBrightButton", true )
	
	LabelSetText( "SettingsPincoToggleAlternateGridLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1542)  )
	WindowSetId( "SettingsPincoToggleAlternateGridLabel", SettingsWindow.DetailTID.AlternateGrid )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleAlternateGridButton", true )
		
	LabelSetText( "SettingsPincocolorGridLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1543) )
	WindowSetId( "SettingsPincocolorGridLabel", SettingsWindow.DetailTID.BaseGridColor )
	
	LabelSetText( "SettingsPincocolorGridAlterLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1544) )
	WindowSetId( "SettingsPincocolorGridAlterLabel", SettingsWindow.DetailTID.AlternateGridColor )
		
	
	LabelSetText( "SettingsPincoSubSection9Label", UI.GetCliloc(SystemData.Settings.Language.type, 1545) )
	
	LabelSetText( "SettingsPincoToggleOldCloseLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1546) )
	WindowSetId( "SettingsPincoToggleOldCloseLabel", SettingsWindow.DetailTID.OldClose )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleOldCloseButton", true )
	
	LabelSetText( "SettingsPincoTogglePetOldCloseLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1547) )
	WindowSetId( "SettingsPincoTogglePetOldCloseLabel", SettingsWindow.DetailTID.PetOldClose )
	ButtonSetCheckButtonFlag( "SettingsPincoTogglePetOldCloseButton", true )
	
	LabelSetText( "SettingsPincoShowCloseExtractLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1661) )
	WindowSetId( "SettingsPincoShowCloseExtractLabel", SettingsWindow.DetailTID.ShowCloseExtract )
	ButtonSetCheckButtonFlag( "SettingsPincoShowCloseExtractButton", true )
	
	
	LabelSetText( "SettingsPincoToggleWoDHealthbarsLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1548) )
	WindowSetId( "SettingsPincoToggleWoDHealthbarsLabel", SettingsWindow.DetailTID.WodHealthbars )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleWoDHealthbarsButton", true )
	
	LabelSetText( "SettingsPincoToggleButtonHealthbarsLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1651) )
	WindowSetId( "SettingsPincoToggleButtonHealthbarsLabel", SettingsWindow.DetailTID.StatusButtons )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleButtonHealthbarsButton", true )
	
	LabelSetText( "SettingsPincoToggleDiabloHealthbarsLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1549)  )
	WindowSetId( "SettingsPincoToggleDiabloHealthbarsLabel", SettingsWindow.DetailTID.DiabloHealthbars )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleDiabloHealthbarsButton", true )
	
	LabelSetText( "SettingsPincoToggleDiabloHealthbarsNumLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1550) )
	WindowSetId( "SettingsPincoToggleDiabloHealthbarsNumLabel", SettingsWindow.DetailTID.DiabloHealthbarsNum )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleDiabloHealthbarsNumButton", true )
	
	LabelSetText( "SettingsPincoToggleMobileArrowLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1659) )
	WindowSetId( "SettingsPincoToggleMobileArrowLabel", SettingsWindow.DetailTID.MobileArrow )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleMobileArrowButton", true )
	
	WindowSetId( "SettingsPincoRedB", SettingsWindow.DetailTID.RedButtonSpell )
	WindowSetId( "SettingsPincoGreenB", SettingsWindow.DetailTID.GreenButtonSpell )
	WindowSetId( "SettingsPincoBlueB", SettingsWindow.DetailTID.BlueButtonSpell )
	
	
		
	LabelSetText( "SettingsPincoSubSection10Label", UI.GetCliloc(SystemData.Settings.Language.type, 1551) )
	
	LabelSetText( "SettingsPincoToggleNotorietyAuraLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1552) )
	WindowSetId( "SettingsPincoToggleNotorietyAuraLabel", SettingsWindow.DetailTID.ToggleNotoAura )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleNotorietyAuraButton", true )
	
	LabelSetText( "SettingsPincoStaticLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1553)  )
	WindowSetId( "SettingsPincoStaticLabel", SettingsWindow.DetailTID.Static )
	ButtonSetCheckButtonFlag( "SettingsPincoStaticButton", true )
	
	LabelSetText( "SettingsPincoNormalSpeedLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1554)  )
	WindowSetId( "SettingsPincoNormalSpeedLabel", SettingsWindow.DetailTID.NormalSpeed )
	ButtonSetCheckButtonFlag( "SettingsPincoNormalSpeedButton", true )
	
	LabelSetText( "SettingsPincoFastLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1555) )
	WindowSetId( "SettingsPincoFastLabel", SettingsWindow.DetailTID.Fast )
	ButtonSetCheckButtonFlag( "SettingsPincoFastButton", true )
		
		
	LabelSetText( "SettingsPincoSubSection11Label", UI.GetCliloc(SystemData.Settings.Language.type, 1556) )
	
	LabelSetText( "SettingsPincoEnableNewLayoutLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1674) )
	WindowSetId( "SettingsPincoEnableNewLayoutLabel", SettingsWindow.DetailTID.NewLayout )
	ButtonSetCheckButtonFlag( "SettingsPincoEnableNewLayoutButton", true )
	
	LabelSetText( "SettingsPincoEnableItemComparisonLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1681) )
	WindowSetId( "SettingsPincoEnableItemComparisonLabel", SettingsWindow.DetailTID.ItemComparison )
	ButtonSetCheckButtonFlag( "SettingsPincoEnableItemComparisonButton", true )
	
	
	
	LabelSetText( "SettingsPincoExtraPropsLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1557) )
	WindowSetId( "SettingsPincoExtraPropsLabel", SettingsWindow.DetailTID.ExtraProps )
	ButtonSetCheckButtonFlag( "SettingsPincoExtraPropsButton", true )
	
	LabelSetText( "SettingsPincoIntensInfoLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1558) )
	WindowSetId( "SettingsPincoIntensInfoLabel", SettingsWindow.DetailTID.IntensInfo )
	ButtonSetCheckButtonFlag( "SettingsPincoIntensInfoButton", true )
	
	LabelSetText( "SettingsPincoExtraInfoColorLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1559)  )
	WindowSetId( "SettingsPincoExtraInfoColorLabel", SettingsWindow.DetailTID.ExtraInfoColor )
	ComboBoxAddMenuItem( "SettingsPincoExtraInfoColorCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1560) )
	ComboBoxAddMenuItem( "SettingsPincoExtraInfoColorCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1561) )
	ComboBoxAddMenuItem( "SettingsPincoExtraInfoColorCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1562) )
	ComboBoxAddMenuItem( "SettingsPincoExtraInfoColorCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1563) )
	ComboBoxAddMenuItem( "SettingsPincoExtraInfoColorCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1564) )
	ComboBoxAddMenuItem( "SettingsPincoExtraInfoColorCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1565) )
	ComboBoxAddMenuItem( "SettingsPincoExtraInfoColorCombo", UI.GetCliloc(SystemData.Settings.Language.type, 1566) )

	LabelSetText( "SettingsPincoSubSectionImbuingLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1634) )

	LabelSetText( "SettingsPincoNormalForgeLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1635) )
	WindowSetId( "SettingsPincoNormalForgeLabel", SettingsWindow.DetailTID.NormalForge )
	ButtonSetCheckButtonFlag( "SettingsPincoNormalForgeButton", true )
	
	LabelSetText( "SettingsPincoTerMurForgeLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1636) )
	WindowSetId( "SettingsPincoTerMurForgeLabel", SettingsWindow.DetailTID.TerMurForge )
	ButtonSetCheckButtonFlag( "SettingsPincoTerMurForgeButton", true )
	
	LabelSetText( "SettingsPincoQueenForgeLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1637) )
	WindowSetId( "SettingsPincoQueenForgeLabel", SettingsWindow.DetailTID.QueenForge )
	ButtonSetCheckButtonFlag( "SettingsPincoQueenForgeButton", true )
	
	LabelSetText( "SettingsPincoNormalCharLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1638) )
	WindowSetId( "SettingsPincoNormalCharLabel", SettingsWindow.DetailTID.HumanElf )
	ButtonSetCheckButtonFlag( "SettingsPincoNormalCharButton", true )
	
	LabelSetText( "SettingsPincoGargCharLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1639) )
	WindowSetId( "SettingsPincoGargCharLabel", SettingsWindow.DetailTID.Gargoyle )
	ButtonSetCheckButtonFlag( "SettingsPincoGargCharButton", true )


	LabelSetText( "SettingsPincoSubSection12Label", UI.GetCliloc(SystemData.Settings.Language.type, 1567) )
	
	LabelSetText( "SettingsPincoBlockOthersPaperdollLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1568)  )
	WindowSetId( "SettingsPincoBlockOthersPaperdollLabel", SettingsWindow.DetailTID.BlockOthersPaper )
	ButtonSetCheckButtonFlag( "SettingsPincoBlockOthersPaperdollButton", true )
	
	LabelSetText( "SettingsPincoYouSeeLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1569)  )
	WindowSetId( "SettingsPincoYouSeeLabel", SettingsWindow.DetailTID.YouSee )
	ButtonSetCheckButtonFlag( "SettingsPincoYouSeeButton", true )
	
	LabelSetText( "SettingsPincoWarModeLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1570)  )
	WindowSetId( "SettingsPincoWarModeLabel", SettingsWindow.DetailTID.WarMode )
	ButtonSetCheckButtonFlag( "SettingsPincoWarModeButton", true )
	
	LabelSetText( "SettingsPincoWarShieldLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1571)  )
	WindowSetId( "SettingsPincoWarShieldLabel", SettingsWindow.DetailTID.WarShield )
	ButtonSetCheckButtonFlag( "SettingsPincoWarShieldButton", true )
	
	LabelSetText( "SettingsPincoDisableAutoIgnoreLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1572) )
	WindowSetId( "SettingsPincoDisableAutoIgnoreLabel", SettingsWindow.DetailTID.AutoIgnore )
	ButtonSetCheckButtonFlag( "SettingsPincoDisableAutoIgnoreButton", true )
	
	LabelSetText( "SettingsPincoLockChatLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1573)  )
	WindowSetId( "SettingsPincoLockChatLabel", SettingsWindow.DetailTID.LockChat )
	ButtonSetCheckButtonFlag( "SettingsPincoLockChatButton", true )
	
	LabelSetText( "SettingsPincoScaleModeLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1574) )
	WindowSetId( "SettingsPincoScaleModeLabel", SettingsWindow.DetailTID.ScaleMode )
	ButtonSetCheckButtonFlag( "SettingsPincoScaleModeButton", true )
	
	LabelSetText( "SettingsPincoAlphaModeLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1673) )
	WindowSetId( "SettingsPincoAlphaModeLabel", SettingsWindow.DetailTID.AlphaMode )
	ButtonSetCheckButtonFlag( "SettingsPincoAlphaModeButton", true )
	
	LabelSetText( "SettingsPincoWindowSnapLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1575) )
	WindowSetId( "SettingsPincoWindowSnapLabel", SettingsWindow.DetailTID.WinSnap )
	ButtonSetCheckButtonFlag( "SettingsPincoWindowSnapButton", true )
	
	LabelSetText( "SettingsPincoUOCartLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1576) )
	WindowSetId( "SettingsPincoUOCartLabel", SettingsWindow.DetailTID.UOCart )
	ButtonSetCheckButtonFlag( "SettingsPincoUOCartButton", true )
	
	LabelSetText( "SettingsPincoBookLogLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1577) )
	WindowSetId( "SettingsPincoBookLogLabel", SettingsWindow.DetailTID.BookLog )
	ButtonSetCheckButtonFlag( "SettingsPincoBookLogButton", true )
	
	LabelSetText( "SettingsPincoCreateMenuLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1578) )
	WindowSetId( "SettingsPincoCreateMenuLabel", SettingsWindow.DetailTID.MenuMaker )
	ButtonSetCheckButtonFlag( "SettingsPincoCreateMenuButton", true )
	
	LabelSetText( "SettingsPincoMapComboLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1579) )
	WindowSetId( "SettingsPincoMapComboLabel", SettingsWindow.DetailTID.MapCombo )
	ButtonSetCheckButtonFlag( "SettingsPincoMapComboButton", true )
	
	LabelSetText( "SettingsPincoGuildWPLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1669) )
	WindowSetId( "SettingsPincoGuildWPLabel", SettingsWindow.DetailTID.GuildWP )
	ButtonSetCheckButtonFlag( "SettingsPincoGuildWPButton", true )
	
	LabelSetText( "SettingsPincoPartyHPShareLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1664) )
	WindowSetId( "SettingsPincoPartyHPShareLabel", SettingsWindow.DetailTID.PartyHP )
	ButtonSetCheckButtonFlag( "SettingsPincoPartyHPShareButton", true )
	
	LabelSetText( "SettingsPincoGuildPosShareLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1665) )
	WindowSetId( "SettingsPincoGuildPosShareLabel", SettingsWindow.DetailTID.GuildPos )
	ButtonSetCheckButtonFlag( "SettingsPincoGuildPosShareButton", true )
	
	LabelSetText( "SettingsPincoGuildHPShareLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1666) )
	WindowSetId( "SettingsPincoGuildHPShareLabel", SettingsWindow.DetailTID.GuildHP )
	ButtonSetCheckButtonFlag( "SettingsPincoGuildHPShareButton", true )
	
	LabelSetText( "SettingsPincoAllyPosShareLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1667) )
	WindowSetId( "SettingsPincoAllyPosShareLabel", SettingsWindow.DetailTID.AllyPos )
	ButtonSetCheckButtonFlag( "SettingsPincoAllyPosShareButton", true )
	
	LabelSetText( "SettingsPincoAllyHPShareLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1668) )
	WindowSetId( "SettingsPincoAllyHPShareLabel", SettingsWindow.DetailTID.AllyHP )
	ButtonSetCheckButtonFlag( "SettingsPincoAllyHPShareButton", true )
	
	LabelSetText( "SettingsPincoLootSortLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1641) )
	WindowSetId( "SettingsPincoLootSortLabel", SettingsWindow.DetailTID.LootSort )
	ButtonSetCheckButtonFlag( "SettingsPincoLootSortButton", true )
	
	LabelSetText( "SettingsPincoLootAllButTrashLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1660) )
	WindowSetId( "SettingsPincoLootAllButTrashLabel", SettingsWindow.DetailTID.LootAllButTrash )
	ButtonSetCheckButtonFlag( "SettingsPincoLootAllButTrashButton", true )
		
	LabelSetText( "SettingsPincoBardMasteryLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1645) )
	WindowSetId( "SettingsPincoBardMasteryLabel", SettingsWindow.DetailTID.BardMastery )
	ButtonSetCheckButtonFlag( "SettingsPincoBardMasteryButton", true )
	
	LabelSetText( "SettingsPincoAutoCloseVetRewLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1580) )
	WindowSetId( "SettingsPincoAutoCloseVetRewLabel", SettingsWindow.DetailTID.AutoCloseVetRew )
	ButtonSetCheckButtonFlag( "SettingsPincoAutoCloseVetRewButton", true )
	
	LabelSetText( "SettingsPincoChooseCharSexLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1630) )
	WindowSetId( "SettingsPincoChooseCharSexLabel", SettingsWindow.DetailTID.ChooseSex )
	ButtonSetCheckButtonFlag( "SettingsPincoChooseCharSexButton", true )
	
	LabelSetText( "SettingsPincoPartyIgnoreLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1647) )
	WindowSetId( "SettingsPincoPartyIgnoreLabel", SettingsWindow.DetailTID.PartyIgnore )
	ButtonSetCheckButtonFlag( "SettingsPincoPartyIgnoreButton", true )
	
	LabelSetText( "SettingsPincoBlockWarOnPetLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1655) )
	WindowSetId( "SettingsPincoBlockWarOnPetLabel", SettingsWindow.DetailTID.BlockWarOnPet )
	ButtonSetCheckButtonFlag( "SettingsPincoBlockWarOnPetButton", true )
	
	LabelSetText( "SettingsPincoBlockWarOnPartyLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1656) )
	WindowSetId( "SettingsPincoBlockWarOnPartyLabel", SettingsWindow.DetailTID.BlockWarOnParty )
	ButtonSetCheckButtonFlag( "SettingsPincoBlockWarOnPartyButton", true )
	
	LabelSetText( "SettingsPincoBlockWarOnGuildLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1657) )
	WindowSetId( "SettingsPincoBlockWarOnGuildLabel", SettingsWindow.DetailTID.BlockWarOnGuild )
	ButtonSetCheckButtonFlag( "SettingsPincoBlockWarOnGuildButton", true )


	LabelSetText( "SettingsPincoSubSection13Label", UI.GetCliloc(SystemData.Settings.Language.type, 1581) )
	
	LabelSetText( "SettingsPincoToggleScavengeAllLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1684) )
	WindowSetId( "SettingsPincoToggleScavengeAllLabel", SettingsWindow.DetailTID.ScavengeAll )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleScavengeAllButton", true )
	
	LabelSetText( "SettingsPincoToggleDisableBandagesLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1685) )
	WindowSetId( "SettingsPincoToggleDisableBandagesLabel", SettingsWindow.DetailTID.DisableBandages )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleDisableBandagesButton", true )
	
	LabelSetText( "SettingsPincoToggleQuickDetailsLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1582) )
	WindowSetId( "SettingsPincoToggleQuickDetailsLabel", SettingsWindow.DetailTID.QuickDetails )
	ButtonSetCheckButtonFlag( "SettingsPincoToggleQuickDetailsButton", true )
	
	LabelSetText( "SettingsPincoHourglassLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1583) )
	WindowSetId( "SettingsPincoHourglassLabel", SettingsWindow.DetailTID.Hourglass )
	ButtonSetCheckButtonFlag( "SettingsPincoHourglassButton", true )
	
	LabelSetText( "SettingsPincoServerLinesLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1584) )
	WindowSetId( "SettingsPincoServerLinesLabel", SettingsWindow.DetailTID.ServerLines )
	ButtonSetCheckButtonFlag( "SettingsPincoServerLinesButton", true )

	LabelSetText( "SettingsPincoClockLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1585) )
	WindowSetId( "SettingsPincoClockLabel", SettingsWindow.DetailTID.Clock )
	ButtonSetCheckButtonFlag( "SettingsPincoClockButton", true )
	
	LabelSetText( "SettingsPincoNoteLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1642) )
	WindowSetId( "SettingsPincoNoteLabel", SettingsWindow.DetailTID.Notes )
	ButtonSetCheckButtonFlag( "SettingsPincoNoteButton", true )
	
	--LabelSetText( "SettingsPincoUseNewChatLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1646) )
	--WindowSetId( "SettingsPincoUseNewChatLabel", SettingsWindow.DetailTID.NewChat )
	--ButtonSetCheckButtonFlag( "SettingsPincoUseNewChatButton", true )
	
	--LabelSetText( "SettingsPincoDangerBarLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1652) )
	--WindowSetId( "SettingsPincoDangerBarLabel", SettingsWindow.DetailTID.DangerBar )
	--ButtonSetCheckButtonFlag( "SettingsPincoDangerBarButton", true )
	
	LabelSetText( "SettingsPincoNewAnimalLoreLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1653) )
	WindowSetId( "SettingsPincoNewAnimalLoreLabel", SettingsWindow.DetailTID.NewAnimalLore )
	ButtonSetCheckButtonFlag( "SettingsPincoNewAnimalLoreButton", true )
	
	LabelSetText( "SettingsPincoAdvancedCraftingLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1683) )
	WindowSetId( "SettingsPincoAdvancedCraftingLabel", SettingsWindow.DetailTID.AdvancedCraftings )
	ButtonSetCheckButtonFlag( "SettingsPincoAdvancedCraftingButton", true )
	
	LabelSetText( "SettingsPincoMoongateGumpLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1686) )
	WindowSetId( "SettingsPincoMoongateGumpLabel", SettingsWindow.DetailTID.MoongateGump )
	ButtonSetCheckButtonFlag( "SettingsPincoMoongateGumpButton", true )
	
	
	LabelSetText( "SettingsPincoBuffBlinkLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1670) )
	WindowSetId( "SettingsPincoBuffBlinkLabel", SettingsWindow.DetailTID.BuffBlink )
	ButtonSetCheckButtonFlag( "SettingsPincoBuffBlinkButton", true )
	
	LabelSetText( "SettingsPincoSpellSpeedLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1671) )
	WindowSetId( "SettingsPincoSpellSpeedLabel", SettingsWindow.DetailTID.SpellSpeed )
	ButtonSetCheckButtonFlag( "SettingsPincoSpellSpeedButton", true )
	
	LabelSetText( "SettingsPincoDisablePaperdollBGLabel",UI.GetCliloc(SystemData.Settings.Language.type, 1672) )
	WindowSetId( "SettingsPincoDisablePaperdollBGLabel", SettingsWindow.DetailTID.PaperdollBG )
	ButtonSetCheckButtonFlag( "SettingsPincoDisablePaperdollBGButton", true )
	
	
	ButtonSetText( "SetTrapbox", UI.GetCliloc(SystemData.Settings.Language.type, 1586) )
	WindowSetId( "SetTrapbox", SettingsWindow.DetailTID.TrapBoxs )
	
	ButtonSetText( "UnSetTrapbox", UI.GetCliloc(SystemData.Settings.Language.type, 1587) )
	WindowSetId( "UnSetTrapbox", SettingsWindow.DetailTID.UnTrapBoxs )
	
	ButtonSetText( "SetLootbag", UI.GetCliloc(SystemData.Settings.Language.type, 1588) )
	WindowSetId( "SetLootbag", SettingsWindow.DetailTID.LootBags )
	
	ButtonSetText( "UnSetLootbag", UI.GetCliloc(SystemData.Settings.Language.type, 1589) )
	WindowSetId( "UnSetLootbag", SettingsWindow.DetailTID.UnLootBags )
	
	LabelSetText( "SettingsPincoGoldOnLootbagLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1590) )
	WindowSetId( "SettingsPincoGoldOnLootbagLabel", SettingsWindow.DetailTID.GoldOnBackpack )
	ButtonSetCheckButtonFlag( "SettingsPincoGoldOnLootbagButton", true )
	
	LabelSetText( "SettingsPincoBrokenPercText", UI.GetCliloc(SystemData.Settings.Language.type, 1658) )
	WindowSetId( "SettingsPincoBrokenPercText", SettingsWindow.DetailTID.BrokenPerc )

	
	LabelSetText( "SettingsPincoSubSection7Label", UI.GetCliloc(SystemData.Settings.Language.type, 1591) )
	
	LabelSetText( "SettingsPincocolorHBPlainLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1592) )
	WindowSetId( "SettingsPincocolorHBPlainLabel", SettingsWindow.DetailTID.colorHBPlain )
	
	LabelSetText( "SettingsPincocolorHBControlLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1593)  )
	WindowSetId( "SettingsPincocolorHBControlLabel", SettingsWindow.DetailTID.colorHBControl )
	
	LabelSetText( "SettingsPincocolorHBAltLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1594)  )
	WindowSetId( "SettingsPincocolorHBAltLabel", SettingsWindow.DetailTID.colorHBAlt )
	
	LabelSetText( "SettingsPincocolorHBShiftLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1595)  )
	WindowSetId( "SettingsPincocolorHBShiftLabel", SettingsWindow.DetailTID.colorHBShift )
	
	LabelSetText( "SettingsPincocolorHBCtrlaltLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1596) )
	WindowSetId( "SettingsPincocolorHBCtrlaltLabel", SettingsWindow.DetailTID.colorHBCtrlalt )
	
	LabelSetText( "SettingsPincocolorHBAltShiftLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1597) )
	WindowSetId( "SettingsPincocolorHBAltShiftLabel", SettingsWindow.DetailTID.colorHBAltShift )
	
	LabelSetText( "SettingsPincocolorHBCtrlShiftLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1598) )
	WindowSetId( "SettingsPincocolorHBCtrlShiftLabel", SettingsWindow.DetailTID.colorHBCtrlShift )
	
	LabelSetText( "SettingsPincocolorHBCtrlAltShiftLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1599) )
	WindowSetId( "SettingsPincocolorHBCtrlAltShiftLabel", SettingsWindow.DetailTID.colorHBCtrlShift )
	
	LabelSetText( "SettingsPincocolorHBCountdownLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1600) )
	WindowSetId( "SettingsPincocolorHBCountdownLabel", SettingsWindow.DetailTID.colorHBCountdown )
	
	LabelSetText( "SettingsPincocolorHBCurrentLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1601) )
	WindowSetId( "SettingsPincocolorHBCurrentLabel", SettingsWindow.DetailTID.colorHBCurrent )
	
	LabelSetText( "SettingsPincocolorHBSelfLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1602) )
	WindowSetId( "SettingsPincocolorHBSelfLabel", SettingsWindow.DetailTID.colorHBSelf )
	
	LabelSetText( "SettingsPincocolorHBCursorLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1603)  )
	WindowSetId( "SettingsPincocolorHBCursorLabel", SettingsWindow.DetailTID.colorHBCursor )
	
	LabelSetText( "SettingsPincocolorHBStoredLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1604)  )
	WindowSetId( "SettingsPincocolorHBStoredLabel", SettingsWindow.DetailTID.colorHBStored )
	
	LabelSetText( "SettingsPincocolorHBBorderLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1605) )
	WindowSetId( "SettingsPincocolorHBBorderLabel", SettingsWindow.DetailTID.colorHBBorder )
	

	
	
	
	LabelSetText( "SettingsPincoSubSection3Label",UI.GetCliloc(SystemData.Settings.Language.type, 1606) )
	
	LabelSetText( "SettingsPincocolorHealLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1607)  )
	WindowSetId( "SettingsPincocolorHealLabel", SettingsWindow.DetailTID.DefaulHealTextColor )
	
	LabelSetText( "SettingsPincocolorCurseLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1608) )
	WindowSetId( "SettingsPincocolorCurseLabel", SettingsWindow.DetailTID.DefaulCurseTextColor )
	
	LabelSetText( "SettingsPincocolorParaLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1609) )
	WindowSetId( "SettingsPincocolorParaLabel", SettingsWindow.DetailTID.DefaulParaTextColor )
	
	LabelSetText( "SettingsPincocolorNeutralLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1610) )
	WindowSetId( "SettingsPincocolorNeutralLabel", SettingsWindow.DetailTID.DefaulNeutralTextColor )
	
	LabelSetText( "SettingsPincocolorNegLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1611) )
	WindowSetId( "SettingsPincocolorNegLabel", SettingsWindow.DetailTID.DefaulNegTextColor )
	
	LabelSetText( "SettingsPincocolorPosLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1612)  )
	WindowSetId( "SettingsPincocolorPosLabel", SettingsWindow.DetailTID.DefaulPosTextColor )
	
	LabelSetText( "SettingsPincocolorYouLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1613)  )
	WindowSetId( "SettingsPincocolorYouLabel", SettingsWindow.DetailTID.DefaulYouTextColor )
	
	LabelSetText( "SettingsPincocolorPetLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1614))
	WindowSetId( "SettingsPincocolorPetLabel", SettingsWindow.DetailTID.DefaulPetTextColor )
	
	LabelSetText( "SettingsPincocolorEnemyLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1615) )
	WindowSetId( "SettingsPincocolorEnemyLabel", SettingsWindow.DetailTID.DefaulEnemyTextColor )
	
	
	LabelSetText( "SettingsPincoSubSection2Label",UI.GetCliloc(SystemData.Settings.Language.type, 1616)  )
	
	LabelSetText( "SettingsPincocolorDefaultLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1617) )
	WindowSetId( "SettingsPincocolorDefaultLabel", SettingsWindow.DetailTID.DefaultItemTextColor )
	
	LabelSetText( "SettingsPincocolorModsLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1618)  )
	WindowSetId( "SettingsPincocolorModsLabel", SettingsWindow.DetailTID.DefaultModsTextColor )
	
	LabelSetText( "SettingsPincocolorEngraveLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1619)  )
	WindowSetId( "SettingsPincocolorEngraveLabel", SettingsWindow.DetailTID.DefaultEngraveTextColor )
	
	LabelSetText( "SettingsPincocolorPlainLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1679)  )
	WindowSetId( "SettingsPincocolorPlainLabel", SettingsWindow.DetailTID.DefaultPlainTextColor )
	
	LabelSetText( "SettingsPincocolorArtiLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1620)  )
	WindowSetId( "SettingsPincocolorArtiLabel", SettingsWindow.DetailTID.DefaultArtiTextColor )
	
	LabelSetText( "SettingsPincocolorSetLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1621) )
	WindowSetId( "SettingsPincocolorSetLabel", SettingsWindow.DetailTID.DefaultSetTextColor )
	
	LabelSetText( "SettingsPincocolorResidueLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1676)  )
	WindowSetId( "SettingsPincocolorResidueLabel", SettingsWindow.DetailTID.DefaultResidueTextColor )
	
	LabelSetText( "SettingsPincocolorEssenceLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1677)  )
	WindowSetId( "SettingsPincocolorEssenceLabel", SettingsWindow.DetailTID.DefaultEssenceTextColor )
	
	LabelSetText( "SettingsPincocolorRelicLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1678)  )
	WindowSetId( "SettingsPincocolorRelicLabel", SettingsWindow.DetailTID.DefaultRelicTextColor )
	
	LabelSetText( "SettingsPincocolorAlertLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1622) )
	WindowSetId( "SettingsPincocolorAlertLabel", SettingsWindow.DetailTID.DefaultAlertTextColor )
	
	LabelSetText( "SettingsPincocolorDangerLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1623)  )
	WindowSetId( "SettingsPincocolorDangerLabel", SettingsWindow.DetailTID.DefaultDangerTextColor )
	
	LabelSetText( "SettingsPincocolorMagicLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1675)  )
	WindowSetId( "SettingsPincocolorMagicLabel", SettingsWindow.DetailTID.DefaultMagicPropTextColor )
	
	LabelSetText( "SettingsPincocolorPhysLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1624) )
	WindowSetId( "SettingsPincocolorPhysLabel", SettingsWindow.DetailTID.DefaultPhysicalTextColor )
	
	LabelSetText( "SettingsPincocolorFireLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1625) )
	WindowSetId( "SettingsPincocolorFireLabel", SettingsWindow.DetailTID.DefaultFireTextColor )
	
	LabelSetText( "SettingsPincocolorColdLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1626) )
	WindowSetId( "SettingsPincocolorColdLabel", SettingsWindow.DetailTID.DefaultColdTextColor )
	
	LabelSetText( "SettingsPincocolorPoisLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1627)  )
	WindowSetId( "SettingsPincocolorPoisLabel", SettingsWindow.DetailTID.DefaultPoisonTextColor )
	
	LabelSetText( "SettingsPincocolorEnerLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1628) )
	WindowSetId( "SettingsPincocolorEnerLabel", SettingsWindow.DetailTID.DefaultEnergyTextColor )
	
	LabelSetText( "SettingsPincocolorChaosLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1629) )
	WindowSetId( "SettingsPincocolorChaosLabel", SettingsWindow.DetailTID.DefaulChaosTextColor )
	
	LabelSetText( "SettingsPincocolorLostItemLabel", UI.GetCliloc(SystemData.Settings.Language.type, 1654) )
	WindowSetId( "SettingsPincocolorLostItemLabel", SettingsWindow.DetailTID.DefaulLostItemTextColor )	
	
		
	LabelSetText( "SettingsPincoSubSection103Label",UI.GetCliloc(SystemData.Settings.Language.type, 1643) )
	
	LabelSetText( "SettingsPincoTPLabel",  UI.GetCliloc(SystemData.Settings.Language.type, 1644) )
	WindowSetId( "SettingsPincoTPLabel", SettingsWindow.DetailTID.TexturePack )
	
	for i = 1, table.getn( MiniTexturePack.DB )do
		ComboBoxAddMenuItem( "SettingsPincoTexturePack", MiniTexturePack.DB[i].name )
	end
	ComboBoxSetSelectedMenuItem( "SettingsPincoTexturePack", MiniTexturePack.Current ) 
	SettingsWindow.SwitchTP()
	
	ScrollWindowSetOffset( "SettingsPincosUIWindow", 0 )
	ScrollWindowUpdateScrollRect( "SettingsPincosUIWindow" )
end

function SettingsWindow.Check()
	
	local win = string.gsub(SystemData.ActiveWindow.name, "Label", "Button")
	ButtonSetPressedFlag( win, not ButtonGetPressedFlag( win ))
	SettingsWindow.CheckEnable()
end

function SettingsWindow.ResetScrollWheelOptions()
	SettingsWindow.RefreshScrollWheelComboBoxes()
	
	ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelUpCombo", 1 ) -- Default case
	ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelDownCombo", 2 ) -- Default case
end

function SettingsWindow.RefreshScrollWheelComboBoxes()
	local scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors
	local numScrollWheelBehaviors = SettingsWindow.NUM_SCROLLWHEELBEHAVIORS
	if ( ButtonGetPressedFlag( "SettingsLegacyLegacyTargetingButton" ) == true) then
		scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors_Legacy
		numScrollWheelBehaviors = SettingsWindow.NUM_SCROLLWHEELBEHAVIORS_LEGACY
	end
	
	ComboBoxClearMenuItems( "SettingsKeyBindingsScrollWheelUpCombo" )
	for behavior = 1, numScrollWheelBehaviors do
		ComboBoxAddMenuItem( "SettingsKeyBindingsScrollWheelUpCombo", L""..GetStringFromTid( scrollWheelBehaviors[behavior].tid ) )
	end
		
	ComboBoxClearMenuItems( "SettingsKeyBindingsScrollWheelDownCombo" )
	for behavior = 1, numScrollWheelBehaviors do
		ComboBoxAddMenuItem( "SettingsKeyBindingsScrollWheelDownCombo", L""..GetStringFromTid( scrollWheelBehaviors[behavior].tid ) )
	end
end

function SettingsWindow.ToggleSettingsWindow()	
	ToggleWindowByName( "SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow )	
end

function SettingsWindow.UpdateVolumeSliderSettings()
	--Debug.PrintToDebugConsole( L"SettingsWindow.UpdateSoundSettings()!" )
	local masterVolume = math.floor( 100 * SliderBarGetCurrentPosition( "MasterVolumeSliderBar" ) )
	local effectsVolume = math.floor( 100 * SliderBarGetCurrentPosition( "EffectsVolumeSliderBar" ) )
	local musicVolume = math.floor( 100 * SliderBarGetCurrentPosition( "MusicVolumeSliderBar" ) )
	
	local playSound = math.floor( 100 * SliderBarGetCurrentPosition( "ECPlaySoundVolumeSliderBar" ) )
	local heartbeatSound = math.floor( 100 * SliderBarGetCurrentPosition( "PlayHeartbeatVolumeSliderBar" ) )
	local playMusic = math.floor( 100 * SliderBarGetCurrentPosition( "ECPlayMusicVolumeSliderBar" ) )

	LabelSetText( "MasterVolumeVal", L""..masterVolume )
	LabelSetText( "EffectsVolumeVal", L""..effectsVolume )
	LabelSetText( "MusicVolumeVal", L""..musicVolume )
	
	LabelSetText( "PlayHeartbeatVolumeVal", L""..heartbeatSound )
	
	LabelSetText( "ECPlaySoundVolumeVal", L""..playSound )
	LabelSetText( "ECPlayMusicVolumeVal", L""..playMusic )
	
		
end

function SettingsWindow.UpdateSliderSettings()
	-- update ui scale
	local uiScale =( SliderBarGetCurrentPosition( "UiScaleSliderBar" )/2 )+ 0.5
	LabelSetText( "UiScaleVal", wstring.format( L"%2.2f", uiScale ) )
	
	-- update the cache size value
	local cacheSize = math.floor( SliderBarGetCurrentPosition( "SettingsOptionsCacheSizeSliderBar" ) * 1024 )
	LabelSetText( "SettingsOptionsCacheSizeVal", L""..cacheSize )	
	
	-- broken value
	
	local broken = math.floor( SliderBarGetCurrentPosition( "SettingsPincoBrokenPercSliderBar" ) * 50 )
	LabelSetText( "SettingsPincoBrokenPercVal", L"" .. broken )
	
	local barName = string.gsub(SystemData.ActiveWindow.name, "SliderBar", "")
	local bar = SystemData.ActiveWindow.name
	if (string.find(SystemData.ActiveWindow.name, "LimitSliderBar") or barName == "windowOffset") then
		local barVal = 0
		barVal = math.floor( 50 * SliderBarGetCurrentPosition(bar ) )
		LabelSetText(barName .. "Val", L"" .. barVal)
	end
	if (barName == "UpdateLimit" ) then
		barVal =  tonumber(string.sub(tostring(SliderBarGetCurrentPosition(bar )),1, 4))
		LabelSetText(barName .. "Val", L"" .. barVal .. L"s")
	end
	
	if (barName == "BaseAlpha") then
		barVal = SliderBarGetCurrentPosition(bar )
		barVal = tonumber(string.format("%.2f", barVal))
		LabelSetText(barName .. "Val", L"" .. barVal)
		if (barVal < 0.01) then
			barVal = 0.01
			SliderBarSetCurrentPosition(barName .. "SliderBar", barVal )
			
			LabelSetText(barName .. "Val", L"" .. barVal)
		end
		
	elseif (barName == "FadeDelay") then
		
		barVal =  tonumber(string.format("%.0f", SliderBarGetCurrentPosition(bar ) * 20))
		LabelSetText(barName .. "Val", L"" .. barVal)
		if (barVal < 1) then
			barVal = 1
			SliderBarSetCurrentPosition(barName .. "SliderBar", barVal / 20 )
			LabelSetText(barName .. "Val", L"" .. barVal)
		end
		
	elseif (barName == "MinTotDamage") then
		barVal =  tonumber(string.format("%.0f", SliderBarGetCurrentPosition(bar ) * 1000))
		LabelSetText(barName .. "Val", L"" .. barVal)
		if (barVal < 1) then
			barVal = 1
			SliderBarSetCurrentPosition(barName .. "SliderBar", barVal / 1000 )
			LabelSetText(barName .. "Val", L"" .. barVal)
		end
		
	end
end

function SettingsWindow.UpdateSettings()
	
    --Debug.Print( "SettingsWindow.UpdateSettings" )
    
	local text
	
	if (SettingsWindow.DefaultRequest) then
		SystemData.Settings.GameOptions.enableAutorun = false
		SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf = true
		SystemData.Settings.GameOptions.holdShiftToUnstack = true 
		SystemData.Settings.Interface.showTipoftheDay = false
		SystemData.Settings.Interface.defaultCorpseMode = "List"
		SystemData.Settings.GameOptions.showStrLabel = true
		StatusWindow.ToggleStrLabel()
		SystemData.Settings.GameOptions.mouseScrollUpAction = SystemData.Settings.GameOptions.MOUSESCROLL_NONE
		SystemData.Settings.GameOptions.mouseScrollDownAction = SystemData.Settings.GameOptions.MOUSESCROLL_NONE
		
		SystemData.Settings.Interface.customUiScale = 0.85
		
		if (ChatWindow.Settings.autohide) then
			ChatWindow.ToggleAutoHide()
		end
	
		
	end
	
	-- Resolution
	
	for res = 1, table.getn( SystemData.AvailableResolutions.widths )do 
		if( SystemData.Settings.Resolution.fullScreen.width == SystemData.AvailableResolutions.widths[res] and 
			SystemData.Settings.Resolution.fullScreen.height == SystemData.AvailableResolutions.heights[res] )then
			ComboBoxSetSelectedMenuItem( "SettingsGraphicsFullScreenResCombo", res )
		end 
	end
	
	ComboBoxSetSelectedMenuItem( "SettingsGraphicsFramerateMaxCombo", (SystemData.Settings.Resolution.framerateMax / 10) - 1 )
	
	ComboBoxSetSelectedMenuItem( "SettingsGraphicsParticleLODCombo", SystemData.Settings.Resolution.particleLOD )
	ComboBoxSetSelectedMenuItem( "SettingsGraphicsParticleFilterCombo", SystemData.Settings.Resolution.particleFilter+1 )
	ComboBoxSetSelectedMenuItem( "SettingsGraphicsAnimationCombo", SystemData.Settings.Optimization.frameSetRestriction+1 )
	
	ButtonSetPressedFlag( "SettingsGraphicsShowFrameButton", SystemData.Settings.Resolution.showWindowFrame )
	ButtonSetPressedFlag( "SettingsGraphicsShowShadowsButton", SystemData.Settings.Resolution.showShadows )
	ButtonSetPressedFlag( "SettingsGraphicsEnableVSyncButton", SystemData.Settings.Resolution.enableVSync )
	ButtonSetPressedFlag( "SettingsGraphicsCircleOfTransparencyButton", SystemData.Settings.GameOptions.circleOfTransEnabled )
    ButtonSetPressedFlag( "SettingsGraphicsHardwareDeathEffectButton", SystemData.Settings.GameOptions.useHardwareDeathEffect )
	ButtonSetPressedFlag( "SettingsGraphicsUseFullscreenButton", SystemData.Settings.Resolution.useFullScreen )
	ButtonSetPressedFlag( "SettingsGraphicsPlayIdleAnimationButton", SystemData.Settings.Optimization.idleAnimation )
	ButtonSetPressedFlag( "SettingsGraphicsShowFoliageButton", SystemData.Settings.Resolution.displayFoliage )
	
	-- Legacy
	ButtonSetPressedFlag( "SettingsLegacyUseLegacyContainersButton", SystemData.Settings.Interface.LegacyContainers )
	ButtonSetPressedFlag( "SettingsLegacyUseLegacyPaperdollsButton", SystemData.Settings.Interface.LegacyPaperdolls)
	ButtonSetPressedFlag( "LegacyChatButton", SystemData.Settings.Interface.LegacyChat )
	ButtonSetPressedFlag( "SettingsLegacyLegacyTargetingButton", SystemData.Settings.GameOptions.legacyTargeting )
	
	SliderBarSetCurrentPosition( "GammaSliderBar", SystemData.Settings.Resolution.gamma )
	LabelSetText( "GammaVal", wstring.format( L"%2.2f", SystemData.Settings.Resolution.gamma ) )
 
	--Language
	for lan = 1, SettingsWindow.NUM_LANGUAGES do 
		if( SystemData.Settings.Language.type == SettingsWindow.Languages[lan].id )then
			ComboBoxSetSelectedMenuItem( "SettingsOptionsLanguageCombo", lan )
		end
	end
    ButtonSetPressedFlag( "SettingsOptionsEnglishNamesButton", SystemData.Settings.Language.englishNames )
	
	--Cache Size
	SliderBarSetCurrentPosition( "SettingsOptionsCacheSizeSliderBar", (SystemData.Settings.Optimization.cacheSize / 1024) )
	LabelSetText( "SettingsOptionsCacheSizeVal",  L""..SystemData.Settings.Optimization.cacheSize )	
	
	for sn = 1, SettingsWindow.NUM_SHOWNAMES do 
		if( SystemData.Settings.GameOptions.showNames == SettingsWindow.ShowNames[sn].id )then
			ComboBoxSetSelectedMenuItem( "SettingsOptionsShowNamesCombo", sn )
		end
	end

	local filter
	for filter = 1, SettingsWindow.NUM_OBJHANDLE_FILTERS do
		if( SystemData.Settings.GameOptions.objectHandleFilter == SettingsWindow.ObjectHandles[filter].id )then
			ComboBoxSetSelectedMenuItem( "SettingsOptionsObjHandleFilterCombo", filter )
		end
	end

	local skinItr
	for skinItr = 1, #SystemData.CustomUIList do
		if( SystemData.Settings.Interface.customUiName == SystemData.CustomUIList[skinItr] )then
			ComboBoxSetSelectedMenuItem( "CustomSkinsCombo", skinItr )
		end
	end
	
	local indexSize
	local objHandleSize
	for indexSize, objHandleSize in pairs( SettingsWindow.ObjectHandleSizes )do
		if( SystemData.Settings.GameOptions.objectHandleSize == objHandleSize )then
			ComboBoxSetSelectedMenuItem( "SettingsOptionsObjHandleSizeCombo", indexSize )
		end
	end
	
	if( SystemData.Settings.Interface.OverheadChatFadeDelay ~= nil )then
		ComboBoxSetSelectedMenuItem( "OverheadChatFadeDelayCombo", SystemData.Settings.Interface.OverheadChatFadeDelay )
	end
	
	-- Scroll Wheel Behavior
	SettingsWindow.RefreshScrollWheelComboBoxes()
	local scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors
	local numScrollWheelBehaviors = SettingsWindow.NUM_SCROLLWHEELBEHAVIORS
	if ( ButtonGetPressedFlag( "SettingsLegacyLegacyTargetingButton" ) == true) then
		scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors_Legacy
		numScrollWheelBehaviors = SettingsWindow.NUM_SCROLLWHEELBEHAVIORS_LEGACY
	end
	
	ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelUpCombo", 1 ) -- Default case
	for behavior = 1, numScrollWheelBehaviors do
		if( SystemData.Settings.GameOptions.mouseScrollUpAction == scrollWheelBehaviors[behavior].id )then
			ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelUpCombo", behavior )
		end
	end
	ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelDownCombo", 1 ) -- Default case
	for behavior = 1, numScrollWheelBehaviors do
		if( SystemData.Settings.GameOptions.mouseScrollDownAction == scrollWheelBehaviors[behavior].id )then
			ComboBoxSetSelectedMenuItem( "SettingsKeyBindingsScrollWheelDownCombo", behavior )
		end
	end
	
    ComboBoxSetSelectedMenuItem( "ContainerViewCombo", 1)
	local containerMode = SystemData.Settings.Interface.defaultContainerMode
	for id, data in ipairs(SettingsWindow.ContainerViewOptions) do
	    if( data.name == containerMode ) then
	        ComboBoxSetSelectedMenuItem( "ContainerViewCombo", id)
	        break
	    end
	end
    
    ComboBoxSetSelectedMenuItem( "CorpseViewCombo", 1)
	local corpseMode = SystemData.Settings.Interface.defaultCorpseMode
	for id, data in ipairs(SettingsWindow.ContainerViewOptions) do
	    if( data.name == corpseMode ) then
	        ComboBoxSetSelectedMenuItem( "CorpseViewCombo", id)
	        break
	    end
	end	
	
	SliderBarSetCurrentPosition( "UiScaleSliderBar", ( ( SystemData.Settings.Interface.customUiScale - 0.5 )*2 ) )
	LabelSetText( "UiScaleVal", wstring.format( L"%2.2f", SystemData.Settings.Interface.customUiScale ) )
	
	ButtonSetPressedFlag( "BadWordFilterOptionButton", SystemData.Settings.Profanity.BadWordFilter )
	ButtonSetPressedFlag( "IgnoreListOptionButton", SystemData.Settings.Profanity.IgnoreListFilter )
	ButtonSetPressedFlag( "IgnoreConfListOptionButton", SystemData.Settings.Profanity.IgnoreConfListFilter )
	
	ButtonSetPressedFlag( "AlwaysRunButton", SystemData.Settings.GameOptions.alwaysRun )
	ButtonSetPressedFlag( "EnableAutorunButton", SystemData.Settings.GameOptions.enableAutorun )
	ButtonSetPressedFlag( "EnablePathfindingButton", SystemData.Settings.GameOptions.enablePathfinding )
	ButtonSetPressedFlag( "QueryBeforeCriminalActionsButton", SystemData.Settings.GameOptions.queryBeforeCriminalAction )
	ButtonSetPressedFlag( "IgnoreMouseActionsOnSelfButton", SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf )
	ButtonSetPressedFlag( "HoldShiftToUnstackButton", SystemData.Settings.GameOptions.holdShiftToUnstack )
	ButtonSetPressedFlag( "ShiftRightClickContextMenusButton", SystemData.Settings.GameOptions.shiftRightClickContextMenus )
	ButtonSetPressedFlag( "TargetQueueingButton", SystemData.Settings.GameOptions.targetQueueing )
	ButtonSetPressedFlag( "AlwaysAttackButton", SystemData.Settings.GameOptions.alwaysAttack )
	ButtonSetPressedFlag( "TooltipsButton", SystemData.Settings.Interface.showTooltips )
	ButtonSetPressedFlag( "PartyInvitePopUpButton", SystemData.Settings.Interface.partyInvitePopUp )
	ButtonSetPressedFlag( "TipoftheDayButton", SystemData.Settings.Interface.showTipoftheDay )
	ButtonSetPressedFlag( "ShowCorpseNamesButton", SystemData.Settings.GameOptions.showCorpseNames )
	ButtonSetPressedFlag( "ShowStrLabelButton", SystemData.Settings.GameOptions.showStrLabel )
	ButtonSetPressedFlag( "OverheadChatButton", SystemData.Settings.Interface.OverheadChat )
	--ButtonSetPressedFlag( "ShowChatWindowButton", SystemData.Settings.Interface.ShowChatWindow )
	ButtonSetPressedFlag( "EnableChatLogButton", SystemData.Settings.GameOptions.enableChatLog )
	
	ButtonSetPressedFlag( "MasterVolumeToggleButton", SystemData.Settings.Sound.master.enabled )
	ButtonSetPressedFlag( "EffectsVolumeToggleButton", SystemData.Settings.Sound.effects.enabled )
	ButtonSetPressedFlag( "MusicVolumeToggleButton", SystemData.Settings.Sound.music.enabled )
	ButtonSetPressedFlag( "PlayFootstepsToggleButton", SystemData.Settings.Sound.footsteps.enabled )
	SliderBarSetCurrentPosition( "MasterVolumeSliderBar", SystemData.Settings.Sound.master.volume )
	SliderBarSetCurrentPosition( "EffectsVolumeSliderBar", SystemData.Settings.Sound.effects.volume )
	SliderBarSetCurrentPosition( "MusicVolumeSliderBar", SystemData.Settings.Sound.music.volume )
	
	
	
	
	
	
	SettingsWindow.UpdateKeyBindings()
	
	if (SettingsWindow.DefaultRequest) then
		needsReload = UserSettingsChanged()
	
		if ( needsReload == true ) then
			InterfaceCore.ReloadUI()
		end
		if (WindowGetShowing("SettingsWindow")) then
			ToggleWindowByName( "SettingsWindow", "", nil )
		end
	end
end

function SettingsWindow.UpdateKeyBindings()
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		if( SettingsWindow.Keybindings[key].type ~= nil )then
			if( SettingsWindow.Keybindings[key].newValue ~= nil )then
				SystemData.Settings.Keybindings[SettingsWindow.Keybindings[key].type] = SettingsWindow.Keybindings[key].newValue
				SettingsWindow.Keybindings[key].newValue = nil
			end
			
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 255, 255, 255 )
			LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."ActionValue", SystemData.Settings.Keybindings[SettingsWindow.Keybindings[key].type] )
		end
	end	

	SettingsWindow.UpdateLegacyTargetBindingsText()
end

--When the Legacy or MMO Key Binding button has been selected, update the key binding to reflect the change
function SettingsWindow.OnDefaultKeyPressed()
	local buttonId = WindowGetId( WindowGetParent( SystemData.ActiveWindow.name ) )
	--Legacy Key Bindings have been selected
	if( buttonId == 1 )then
		local yesButton = { textTid = SettingsWindow.TID_YES, callback = function()SettingsWindow.ResetLegacyKeyBindings()end }
		local noButton = { textTid = SettingsWindow.TID_NO }
		local windowData = 
		{
			windowName = "Root", 
			titleTid = SettingsWindow.TID_INFO, 
			bodyTid = SettingsWindow.TID_RESETDEFAULTBINDINGS, 
			buttons = { yesButton, noButton }
		}
		UO_StandardDialog.CreateDialog( windowData )
		return
	end
	--MMO Key Bindings have been selected
	if( buttonId == 2 )then
		local yesButton = { textTid = SettingsWindow.TID_YES, callback = function()SettingsWindow.ResetMMOKeyBindings()end }
		local noButton = { textTid = SettingsWindow.TID_NO }
		local windowData = 
		{
			windowName = "Root", 
			titleTid = SettingsWindow.TID_INFO, 
			bodyTid = SettingsWindow.TID_RESETDEFAULTBINDINGS, 
			buttons = { yesButton, noButton }
		}
		UO_StandardDialog.CreateDialog( windowData )
		return
	end
	
end

--Set the key bindings to Legacy default
function SettingsWindow.ResetLegacyKeyBindings()
	ResetLegacyKeyBinding()
	
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		if( SettingsWindow.Keybindings[key].type ~= nil )then
			local value = SystemData.Settings.DefaultKeybindings[SettingsWindow.Keybindings[key].type]
			if( value ~= nil )then
				SettingsWindow.Keybindings[key].newValue = value
				LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 255, 255, 255 )
				LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."ActionValue", value )
			end
		end
	end
	
	SettingsWindow.UpdateLegacyTargetBindingsText()
end

--Set the key bindings to MMO default
function SettingsWindow.ResetMMOKeyBindings()
	ResetMMOKeyBinding()
	
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		if( SettingsWindow.Keybindings[key].type ~= nil )then
			local value = SystemData.Settings.DefaultKeybindings[SettingsWindow.Keybindings[key].type]
			if( value ~= nil )then
				SettingsWindow.Keybindings[key].newValue = value
				LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 255, 255, 255 )
				LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."ActionValue", value )
			end
		end
	end
	
	SettingsWindow.UpdateLegacyTargetBindingsText()
	
	
end

function SettingsWindow.UpdateLegacyTargetBindingsText()
	if( SystemData.Settings.GameOptions.legacyTargeting ) then
		for key = SettingsWindow.NON_LEGACY_BINDING_MIN, SettingsWindow.NON_LEGACY_BINDING_MAX do
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 128, 128, 128 )
			LabelSetText( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name.."ActionValue", GetStringFromTid(SettingsWindow.TID.NotAvailable) )
		end
	end
end

function SettingsWindow.OnOkayButton()
	SettingsWindow.OnApplyButton()

	-- Close the window		
	ToggleWindowByName( "SettingsWindow", "", nil )
end

function SettingsWindow.OnApplyButton()

	-- Set the Options
		
	local fullScreenRes = ComboBoxGetSelectedMenuItem( "SettingsGraphicsFullScreenResCombo" )
	SystemData.Settings.Resolution.fullScreen.width = SystemData.AvailableResolutions.widths[fullScreenRes]
	SystemData.Settings.Resolution.fullScreen.height = SystemData.AvailableResolutions.heights[fullScreenRes]

	SystemData.Settings.Resolution.framerateMax = ( ComboBoxGetSelectedMenuItem( "SettingsGraphicsFramerateMaxCombo" ) + 1 ) * 10
	
	SystemData.Settings.Resolution.showWindowFrame = ButtonGetPressedFlag( "SettingsGraphicsShowFrameButton" )
	SystemData.Settings.Resolution.showShadows = ButtonGetPressedFlag( "SettingsGraphicsShowShadowsButton" )
	SystemData.Settings.Resolution.enableVSync = ButtonGetPressedFlag( "SettingsGraphicsEnableVSyncButton" )
	SystemData.Settings.GameOptions.circleOfTransEnabled = ButtonGetPressedFlag( "SettingsGraphicsCircleOfTransparencyButton" )
    SystemData.Settings.GameOptions.useHardwareDeathEffect = ButtonGetPressedFlag( "SettingsGraphicsHardwareDeathEffectButton" )
	SystemData.Settings.Resolution.useFullScreen = ButtonGetPressedFlag( "SettingsGraphicsUseFullscreenButton" )
	SystemData.Settings.Optimization.idleAnimation = ButtonGetPressedFlag( "SettingsGraphicsPlayIdleAnimationButton" )
	SystemData.Settings.Resolution.displayFoliage = ButtonGetPressedFlag( "SettingsGraphicsShowFoliageButton" )

	SystemData.Settings.Resolution.gamma = SliderBarGetCurrentPosition( "GammaSliderBar" )
	
	SystemData.Settings.Resolution.particleLOD = ComboBoxGetSelectedMenuItem( "SettingsGraphicsParticleLODCombo" )
	SystemData.Settings.Resolution.particleFilter = ComboBoxGetSelectedMenuItem( "SettingsGraphicsParticleFilterCombo" )-1

	SystemData.Settings.Optimization.frameSetRestriction = ComboBoxGetSelectedMenuItem( "SettingsGraphicsAnimationCombo" )-1

	-- Language
	local languageIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsLanguageCombo" )
	SystemData.Settings.Language.type = SettingsWindow.Languages[languageIndex].id
    SystemData.Settings.Language.englishNames = ButtonGetPressedFlag( "SettingsOptionsEnglishNamesButton" )
	
	-- Cache Size
	SystemData.Settings.Optimization.cacheSize = (SliderBarGetCurrentPosition( "SettingsOptionsCacheSizeSliderBar" ) * 1024)
	
	-- Show Names
	local showNamesIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsShowNamesCombo" )
	SystemData.Settings.GameOptions.showNames = SettingsWindow.ShowNames[showNamesIndex].id
	
	-- Sound 
	SystemData.Settings.Sound.master.enabled = ButtonGetPressedFlag( "MasterVolumeToggleButton" )
	SystemData.Settings.Sound.master.volume = SliderBarGetCurrentPosition( "MasterVolumeSliderBar" )
	
	SystemData.Settings.Sound.effects.enabled = ButtonGetPressedFlag( "EffectsVolumeToggleButton" )
	SystemData.Settings.Sound.effects.volume = SliderBarGetCurrentPosition( "EffectsVolumeSliderBar" )
	
	EnhancePack.ECPlaySoundVol = SliderBarGetCurrentPosition( "ECPlaySoundVolumeSliderBar" )
	CustomSettings.SaveNumber( "EnhancePackECPlaySoundVol", EnhancePack.ECPlaySoundVol )
	
	EnhancePack.ECPlaySoundHBVol = SliderBarGetCurrentPosition( "PlayHeartbeatVolumeSliderBar" )
	CustomSettings.SaveNumber( "EnhancePackECPlaySoundHBVol", EnhancePack.ECPlaySoundHBVol )
	
	EnhancePack.ECPlaySoundMusVol = SliderBarGetCurrentPosition( "ECPlayMusicVolumeSliderBar" )
	CustomSettings.SaveNumber( "EnhancePackECPlaySoundMusVol", EnhancePack.ECPlaySoundMusVol )
	
	EnhancePack.MinBroken = SliderBarGetCurrentPosition( "SettingsPincoBrokenPercSliderBar" ) 
	CustomSettings.SaveNumber( "EnhancePackMinBroken" , EnhancePack.MinBroken )
	
	EnhancePack.Music = ButtonGetPressedFlag( "ECPlayMusicVolumeToggleButton" )
	CustomSettings.SaveBoolean( "EnhancePackMusic" , EnhancePack.Music )
	
	EnhancePack.HeartBeat = ButtonGetPressedFlag( "PlayHeartbeatVolumeToggleButton" )
	CustomSettings.SaveBoolean( "EnhancePackHeartBeat" , EnhancePack.HeartBeat )
	
	SystemData.Settings.Sound.music.enabled = ButtonGetPressedFlag( "MusicVolumeToggleButton" )
	SystemData.Settings.Sound.music.volume = SliderBarGetCurrentPosition( "MusicVolumeSliderBar" )

	SystemData.Settings.Sound.footsteps.enabled = ButtonGetPressedFlag( "PlayFootstepsToggleButton" )
	
	if not EnhancePack.Music then
		PlaySound(1, "", 1)
	else
		EnhancePack.CurrentArea = " "
		EnhancePack.AreaDescription = " "
		EnhancePack.CurrentSubArea = " "
		EnhancePack.CurrentAreaMusic = " "
	end
	if not EnhancePack.ECPlaySound then
		PlaySound(0, "", 1)
	end
	if not EnhancePack.HeartBeat then
		PlaySound(2, "", 1)
	end
	local music = math.floor( EnhancePack.ECPlaySoundMusVol*7000 ) - 7000
	local effects = math.floor( EnhancePack.ECPlaySoundVol*7000 ) - 7000
	local heartbeat = math.floor(  EnhancePack.ECPlaySoundHBVol*7000 ) - 7000
	
	TextLogCreate("Volume", 1)
	TextLogSetEnabled("Volume", true)
	TextLogClear("Volume")
	TextLogSetIncrementalSaving( "Volume", true, "logs/Volume.log")
		
	TextLogAddEntry("Volume", 1, StringToWString("music|"..music))
	TextLogAddEntry("Volume", 1, StringToWString("effects|"..effects))
	TextLogAddEntry("Volume", 1, StringToWString("heartbeat|"..heartbeat))
	TextLogDestroy("Volume")
	
	-- Options
	SystemData.Settings.GameOptions.alwaysRun = ButtonGetPressedFlag( "AlwaysRunButton" )
	SystemData.Settings.GameOptions.enableAutorun = ButtonGetPressedFlag( "EnableAutorunButton" )
	SystemData.Settings.GameOptions.enablePathfinding = ButtonGetPressedFlag( "EnablePathfindingButton" )
	SystemData.Settings.GameOptions.queryBeforeCriminalAction = ButtonGetPressedFlag( "QueryBeforeCriminalActionsButton" )
	SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf = ButtonGetPressedFlag( "IgnoreMouseActionsOnSelfButton" )
	SystemData.Settings.GameOptions.holdShiftToUnstack = ButtonGetPressedFlag( "HoldShiftToUnstackButton" )
	SystemData.Settings.GameOptions.shiftRightClickContextMenus = ButtonGetPressedFlag( "ShiftRightClickContextMenusButton" )
	SystemData.Settings.GameOptions.targetQueueing = ButtonGetPressedFlag( "TargetQueueingButton" )
	SystemData.Settings.GameOptions.alwaysAttack = ButtonGetPressedFlag( "AlwaysAttackButton" )
	SystemData.Settings.GameOptions.showCorpseNames = ButtonGetPressedFlag( "ShowCorpseNamesButton" )
	SystemData.Settings.GameOptions.showStrLabel = ButtonGetPressedFlag( "ShowStrLabelButton" )
	
	-- Object Handle Filter
	local filterIndex = ComboBoxGetSelectedMenuItem( "SettingsOptionsObjHandleFilterCombo" )
	SystemData.Settings.GameOptions.objectHandleFilter = SettingsWindow.ObjectHandles[filterIndex].id
	
	local skinIndex = ComboBoxGetSelectedMenuItem( "CustomSkinsCombo" )
	SystemData.Settings.Interface.customUiName = SystemData.CustomUIList[skinIndex]
	
	local objHandleSize = ComboBoxGetSelectedMenuItem( "SettingsOptionsObjHandleSizeCombo" )
	SystemData.Settings.GameOptions.objectHandleSize = SettingsWindow.ObjectHandleSizes[objHandleSize]
	
	-- Interface
	SystemData.Settings.Interface.showTooltips = ButtonGetPressedFlag( "TooltipsButton" )
	SystemData.Settings.Interface.partyInvitePopUp = ButtonGetPressedFlag( "PartyInvitePopUpButton" )
	SystemData.Settings.Interface.showTipoftheDay = ButtonGetPressedFlag( "TipoftheDayButton" )
	--SystemData.Settings.Interface.ShowChatWindow = ButtonGetPressedFlag( "ShowChatWindowButton" )

	SystemData.Settings.Interface.OverheadChat = ButtonGetPressedFlag( "OverheadChatButton" )
	SystemData.Settings.Interface.OverheadChatFadeDelay = ComboBoxGetSelectedMenuItem( "OverheadChatFadeDelayCombo" )

	-- only update the scale if necesary
	local uiScale =( SliderBarGetCurrentPosition( "UiScaleSliderBar" )/2 )+ 0.5
	SystemData.Settings.Interface.customUiScale = uiScale

    local selectedId = ComboBoxGetSelectedMenuItem( "ContainerViewCombo" )
    SystemData.Settings.Interface.defaultContainerMode = SettingsWindow.ContainerViewOptions[selectedId].name

    selectedId = ComboBoxGetSelectedMenuItem( "CorpseViewCombo" )
    SystemData.Settings.Interface.defaultCorpseMode = SettingsWindow.ContainerViewOptions[selectedId].name
    
	SystemData.Settings.GameOptions.enableChatLog = ButtonGetPressedFlag( "EnableChatLogButton" )
    
    -- Legacy
    SystemData.Settings.Interface.LegacyChat = ButtonGetPressedFlag( "LegacyChatButton" )
    SystemData.Settings.Interface.LegacyContainers = ButtonGetPressedFlag( "SettingsLegacyUseLegacyContainersButton" )
    SystemData.Settings.Interface.LegacyPaperdolls = ButtonGetPressedFlag( "SettingsLegacyUseLegacyPaperdollsButton" )
    SystemData.Settings.GameOptions.legacyTargeting = ButtonGetPressedFlag( "SettingsLegacyLegacyTargetingButton" )

	-- Profanity
	SystemData.Settings.Profanity.BadWordFilter = ButtonGetPressedFlag( "BadWordFilterOptionButton" )
	SystemData.Settings.Profanity.IgnoreListFilter = ButtonGetPressedFlag( "IgnoreListOptionButton" )
	SystemData.Settings.Profanity.IgnoreConfListFilter = ButtonGetPressedFlag( "IgnoreConfListOptionButton" )
	
	-- Key Bindings
	SettingsWindow.UpdateKeyBindings()
	
	-- Scroll Wheel Behavior
	local scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors
	if ( ButtonGetPressedFlag( "SettingsLegacyLegacyTargetingButton" ) == true) then
		scrollWheelBehaviors = SettingsWindow.ScrollWheelBehaviors_Legacy
	end
	
	SystemData.Settings.GameOptions.mouseScrollUpAction = scrollWheelBehaviors[ComboBoxGetSelectedMenuItem( "SettingsKeyBindingsScrollWheelUpCombo" )].id
	SystemData.Settings.GameOptions.mouseScrollDownAction = scrollWheelBehaviors[ComboBoxGetSelectedMenuItem( "SettingsKeyBindingsScrollWheelDownCombo" )].id

	-- PINCO
	EnhancePack.ShowSpellName = ButtonGetPressedFlag( "SettingsPincoToggleOverheadSpellNamesButton" )
		
	CustomSettings.SaveBoolean( "EnhancePackShowSpellName", EnhancePack.ShowSpellName )
	if (EnhancePack.ShowSpellName and FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName == "runic") then
		OverheadText.SpellsFontIndex = 1
	end
	
	EnhancePack.DisableSpells = not ButtonGetPressedFlag( "SettingsPincoToggleOverheadSpellsButton" )
	CustomSettings.SaveBoolean( "EnhancePackDisableSpells", EnhancePack.DisableSpells )
	
	EnhancePack.SadMode = ButtonGetPressedFlag( "SettingsPincoToggleSadModeButton" )
	CustomSettings.SaveBoolean( "EnhancePackSadMode", EnhancePack.SadMode )
	
	EnhancePack.clickableNames = ButtonGetPressedFlag( "SettingsPincoToggleClickableNamesButton" )
	CustomSettings.SaveBoolean( "EnhancePackclickableNames", EnhancePack.clickableNames )
	
	EnhancePack.noPoisonOthers = ButtonGetPressedFlag( "SettingsPincoTogglePoisonOthersButton" )
	CustomSettings.SaveBoolean( "EnhancePacknoPoisonOthers", EnhancePack.noPoisonOthers )
	
	if (ButtonGetPressedFlag( "SettingsPincoNormalSizeButton" )) then
		EnhancePack.ObjectHandleScaleNumeric = 1
		EnhancePack.ObjectHandleScale = InterfaceCore.scale
	elseif(ButtonGetPressedFlag( "SettingsPincoMediumSizeButton" )) then
		EnhancePack.ObjectHandleScaleNumeric = 2
		EnhancePack.ObjectHandleScale = InterfaceCore.scale * 0.8
	elseif(ButtonGetPressedFlag( "SettingsPincoSmallSizeButton" )) then
		EnhancePack.ObjectHandleScaleNumeric = 3
		EnhancePack.ObjectHandleScale = (InterfaceCore.scale * 1.8 )/3
	end
	CustomSettings.SaveNumber( "EnhancePackObjectHandleScaleNumeric" , EnhancePack.ObjectHandleScaleNumeric )
	CustomSettings.SaveNumber( "EnhancePackObjectHandleScale" , EnhancePack.ObjectHandleScale )
	
	
	if (ButtonGetPressedFlag( "SettingsPincoDullButton" )) then
		EnhancePack.ObjectHandleAlpha = 1
	elseif(ButtonGetPressedFlag( "SettingsPincoHalfDullButton" )) then
		EnhancePack.ObjectHandleAlpha = 0.6
	elseif(ButtonGetPressedFlag( "SettingsPincoTransparentButton" )) then
		EnhancePack.ObjectHandleAlpha = 0.4
	end
	CustomSettings.SaveNumber( "EnhancePackObjectHandleAlpha" , EnhancePack.ObjectHandleAlpha )
	
	EnhancePack.ObjectHandle = ButtonGetPressedFlag( "SettingsPincoObjectHandleWindowButton" )
	CustomSettings.SaveBoolean( "EnhancePackObjectHandle", EnhancePack.ObjectHandle )
	WindowSetShowing("ObjectHandleToggleWindow", EnhancePack.ObjectHandle)
	
	EnhancePack.CenterScreenPosition = ComboBoxGetSelectedMenuItem( "SettingsPincoCenterScreenTextPosCombo" )
	CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition", EnhancePack.CenterScreenPosition )
	
	local lowHP = ComboBoxGetSelectedMenuItem( "SettingsPincoCenterScreenTextLowHPCombo" )

	if (lowHP < 10) then
		CustomSettings.SaveBoolean( "EnhancePackLowHPPercDisabled", false )
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", (lowHP + 1) * 10 )
		EnhancePack.LowHPPerc = (lowHP + 1) * 10
		if EnhancePack.LowHPPerc == 100 then
			EnhancePack.LowHPPerc = 99
		end
		EnhancePack.LowHPPercDisabled = false
	else
		CustomSettings.SaveBoolean( "EnhancePackLowHPPercDisabled", true )
		EnhancePack.LowHPPercDisabled = true
	end
	
	lowHP = ComboBoxGetSelectedMenuItem( "SettingsPincoCenterScreenTextLowHPPetCombo" )
	
	if (lowHP < 6) then
		CustomSettings.SaveBoolean( "EnhancePackLowHPPETPercDisabled", false )
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", (lowHP + 1) * 10 )
		EnhancePack.LowHPPETPerc = (lowHP + 1) * 10
		EnhancePack.LowPETHPPercDisabled = false
	else
		CustomSettings.SaveBoolean( "EnhancePackLowHPPETPercDisabled", true )
		EnhancePack.LowPETHPPercDisabled = true
	end
	
	EnhancePack.EnableIgnoreSummons = ButtonGetPressedFlag( "SettingsPincoIgnoreSummonsButton" )
	CustomSettings.SaveBoolean( "EnhancePackEnableIgnoreSummons", EnhancePack.EnableIgnoreSummons  )
	
	HotbarSystem.DefaultSlots = ComboBoxGetSelectedMenuItem( "SettingsPincoHotbarSlotsCombo" )
	CustomSettings.SaveNumber( "HotbarSystemDefaultSlots" , HotbarSystem.DefaultSlots )
	
	HotbarSystem.DefHorizontal = ButtonGetPressedFlag( "SettingsPincoHorizButton" )
	CustomSettings.SaveBoolean( "HotbarSystemDefHorizontal" , HotbarSystem.DefHorizontal )
	
	local bck = EnhancePack.HotbarNoSpace
	EnhancePack.HotbarNoSpace = ButtonGetPressedFlag( "SettingsPincoNoSpaceButton" )
	CustomSettings.SaveBoolean( "HotbarNoSpace" , EnhancePack.HotbarNoSpace )
	if (bck ~=  EnhancePack.HotbarNoSpace) then
		for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
			local hotbar = "Hotbar"..hotbarId
			Debug.Print("[Smart Hotbar Lock System]: Fixing dimensions of hotbar " .. hotbarId .. "...")
			local back = SystemData.Hotbar[hotbarId].Locked
			Hotbar.SetLocked(hotbarId, false)
			Hotbar.SetLocked(hotbarId, back)
		end
	end
	
	EnhancePack.GridLegacy = ButtonGetPressedFlag( "SettingsPincoToggleGridLegacyButton" )
	CustomSettings.SaveBoolean( "EnhancePackGridLegacy", EnhancePack.GridLegacy)
	
	EnhancePack.ToggleContentsInfo = ButtonGetPressedFlag( "SettingsPincoToggleContentsInfoButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleContentsInfo", EnhancePack.ToggleContentsInfo)
	
	EnhancePack.HighlightLastSetting = ButtonGetPressedFlag( "SettingsPincoHighlightLastButton" )
	CustomSettings.SaveBoolean( "EnhancePackHighlightLastSetting", EnhancePack.HighlightLastSetting)
	
	bck = EnhancePack.EnableContainerGrid
	EnhancePack.EnableContainerGrid  = ButtonGetPressedFlag( "SettingsPincoToggleGridButton" )
	CustomSettings.SaveBoolean( "EnhancePackEnableContainerGrid", EnhancePack.EnableContainerGrid )
	
	if (bck ~=  EnhancePack.EnableContainerGrid) then
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
	end

	EnhancePack.QuickLootEverywhere  = ButtonGetPressedFlag( "SettingsPincoToggleQuickLootButton" )
	CustomSettings.SaveBoolean( "EnhancePackQuickLootEverywhere", EnhancePack.QuickLootEverywhere )
	
	bck = EnhancePack.ExtraBrightContainers
	EnhancePack.ExtraBrightContainers  = ButtonGetPressedFlag( "SettingsPincoToggleExtraBrightButton" )
	CustomSettings.SaveBoolean( "EnhancePackExtraBrightContainers", EnhancePack.ExtraBrightContainers )
	if (bck ~=  EnhancePack.ExtraBrightContainers) then
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
	end
	
	bck = EnhancePack.AlternateGrid
	EnhancePack.AlternateGrid = ButtonGetPressedFlag( "SettingsPincoToggleAlternateGridButton" )
	CustomSettings.SaveBoolean( "EnhancePackAlternateGrid",EnhancePack.AlternateGrid )
	if (bck ~=  EnhancePack.AlternateGrid) then
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
	end
	
	MobileHealthBar.CloseStyle = ButtonGetPressedFlag( "SettingsPincoToggleOldCloseButton" )
	CustomSettings.SaveBoolean( "MobileHealthBarCloseStyle", MobileHealthBar.CloseStyle )
		
	MobileHealthBar.PetCloseStyle = ButtonGetPressedFlag( "SettingsPincoTogglePetOldCloseButton" )
	CustomSettings.SaveBoolean( "MobileHealthBarPetCloseStyle", MobileHealthBar.PetCloseStyle )
	
	local bck2 = EnhancePack.ShowCloseExtract
	EnhancePack.ShowCloseExtract = ButtonGetPressedFlag( "SettingsPincoShowCloseExtractButton" )
	CustomSettings.SaveBoolean( "EnhancePackShowCloseExtract", EnhancePack.ShowCloseExtract  )
		
	bck = EnhancePack.HealthBarWod
	EnhancePack.HealthBarWod = ButtonGetPressedFlag( "SettingsPincoToggleWoDHealthbarsButton" )
	CustomSettings.SaveBoolean( "EnhancePackHealthBarWod", EnhancePack.HealthBarWod )
	if (bck ~=  EnhancePack.HealthBarWod or bck2 ~= EnhancePack.ShowCloseExtract) then
		for key, value in pairs(MobileHealthBar.hasWindow) do
			MobileHealthBar.UpdateStatus(key)
		end
	end
	
	local diabloEnable = EnhancePack.DiabloHealthEnable
	EnhancePack.DiabloHealthEnable = ButtonGetPressedFlag( "SettingsPincoToggleDiabloHealthbarsButton" )
	CustomSettings.SaveBoolean( "DiabloHealthEnable", EnhancePack.DiabloHealthEnable )
	
	EnhancePack.DiabloHealthNumbersEnable = ButtonGetPressedFlag( "SettingsPincoToggleDiabloHealthbarsNumButton" )
	CustomSettings.SaveBoolean( "DiabloHealthNumbersEnable", EnhancePack.DiabloHealthNumbersEnable )
		
	DiabloHealth.CheckToggle(diabloEnable)
	
	EnhancePack.EnableMobileArrow = ButtonGetPressedFlag( "SettingsPincoToggleMobileArrowButton" )
	CustomSettings.SaveBoolean( "SettingsPincoEnableMobileArrow", EnhancePack.EnableMobileArrow )
	
	local i = ComboBoxGetSelectedMenuItem( "SettingsPincoRed" )
	EnhancePack.RedButton = EnhancePack.RedButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackRedButton", EnhancePack.RedButton )
	
	local i = ComboBoxGetSelectedMenuItem( "SettingsPincoRed2" )
	EnhancePack.RedButton2 = EnhancePack.RedButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackRedButton2", EnhancePack.RedButton2 )
	
	local i = ComboBoxGetSelectedMenuItem( "SettingsPincoRed3" )
	EnhancePack.RedButton3 = EnhancePack.RedButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackRedButton3", EnhancePack.RedButton3 )
	
	
	i = ComboBoxGetSelectedMenuItem( "SettingsPincoGreen" )
	EnhancePack.GreenButton = EnhancePack.GreenButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackGreenButton", EnhancePack.GreenButton )
	
	i = ComboBoxGetSelectedMenuItem( "SettingsPincoGreen2" )
	EnhancePack.GreenButton2 = EnhancePack.GreenButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackGreenButton2", EnhancePack.GreenButton2 )
	
	i = ComboBoxGetSelectedMenuItem( "SettingsPincoGreen3" )
	EnhancePack.GreenButton3 = EnhancePack.GreenButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackGreenButton3", EnhancePack.GreenButton3 )
	
	
	i = ComboBoxGetSelectedMenuItem( "SettingsPincoBlue" )
	EnhancePack.BlueButton = EnhancePack.BlueButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackBlueButton", EnhancePack.BlueButton )
	
	i = ComboBoxGetSelectedMenuItem( "SettingsPincoBlue2" )
	EnhancePack.BlueButton2 = EnhancePack.BlueButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackBlueButton2", EnhancePack.BlueButton2 )
	
	i = ComboBoxGetSelectedMenuItem( "SettingsPincoBlue3" )
	EnhancePack.BlueButton3 = EnhancePack.BlueButtonSpells[i].SpellId
	CustomSettings.SaveNumber( "EnhancePackBlueButton3", EnhancePack.BlueButton3 )
	
	
	StatusWindow.AuraEnabled = ButtonGetPressedFlag( "SettingsPincoToggleNotorietyAuraButton" )
	CustomSettings.SaveBoolean( "StatusWindowAuraEnabled", StatusWindow.AuraEnabled )
	HealthBarManager.HandlePartyMemberUpdate()
	
	if (ButtonGetPressedFlag( "SettingsPincoStaticButton" )) then
		EnhancePack.AuraSpeed = 0
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
	elseif (ButtonGetPressedFlag( "SettingsPincoNormalSpeedButton" )) then
		EnhancePack.AuraSpeed = 10
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
	elseif (ButtonGetPressedFlag( "SettingsPincoFastButton" )) then
		EnhancePack.AuraSpeed = 20
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
	end
	
	EnhancePack.ToggleNewLayout = ButtonGetPressedFlag( "SettingsPincoEnableNewLayoutButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleNewLayout", EnhancePack.ToggleNewLayout )
	
	EnhancePack.ToggleItemComparison = ButtonGetPressedFlag( "SettingsPincoEnableItemComparisonButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleItemComparison", EnhancePack.ToggleItemComparison )
	
	EnhancePack.ToggleExtraInfo = ButtonGetPressedFlag( "SettingsPincoExtraPropsButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleExtraInfo", EnhancePack.ToggleExtraInfo )
		
	EnhancePack.IntensityInfo = ButtonGetPressedFlag( "SettingsPincoIntensInfoButton" )
	CustomSettings.SaveBoolean( "EnhancePackIntensityInfo", EnhancePack.IntensityInfo )
	
	EnhancePack.ExtraInfoColorID = ComboBoxGetSelectedMenuItem( "SettingsPincoExtraInfoColorCombo" )
	CustomSettings.SaveNumber( "EnhancePackExtraInfoColorID" , EnhancePack.ExtraInfoColorID )
	
	if (EnhancePack.ToggleExtraInfo) then
		local re,gr,bl
		if (EnhancePack.ExtraInfoColorID ==1) then
			re=255
			gr=0
			bl=0
		elseif (EnhancePack.ExtraInfoColorID ==2) then
			re=0
			gr=255
			bl=0
		elseif (EnhancePack.ExtraInfoColorID ==3) then
			re=0
			gr=0
			bl=255
		elseif (EnhancePack.ExtraInfoColorID ==4) then
			re=255
			gr=255
			bl=0
		elseif (EnhancePack.ExtraInfoColorID ==5) then
			re=0
			gr=255
			bl=255
		elseif (EnhancePack.ExtraInfoColorID ==6) then
			re=255
			gr=0
			bl=255
		elseif (EnhancePack.ExtraInfoColorID ==7) then
			re=255
			gr=255
			bl=255
		end
		EnhancePack.EXTRAINFO ={r=re, g=gr, b=bl, a=0}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	end
	if (ButtonGetPressedFlag( "SettingsPincoNormalForgeButton" )) then
		EnhancePack.UnravelForge = 1
	elseif (ButtonGetPressedFlag( "SettingsPincoTerMurForgeButton" )) then
		EnhancePack.UnravelForge = 2
	elseif (ButtonGetPressedFlag( "SettingsPincoQueenForgeButton" )) then
		EnhancePack.UnravelForge = 3
	end
	CustomSettings.SaveNumber( "EnhancePackUnravelForge" , EnhancePack.UnravelForge )
	
	if (ButtonGetPressedFlag( "SettingsPincoNormalCharButton" )) then
		EnhancePack.UnravelChar = 1
	elseif (ButtonGetPressedFlag( "SettingsPincoGargCharButton" )) then
		EnhancePack.UnravelChar = 2
	end

	CustomSettings.SaveNumber( "EnhancePackUnravelChar" , EnhancePack.UnravelChar )
	
	EnhancePack.BlockOthersPaperdoll = ButtonGetPressedFlag( "SettingsPincoBlockOthersPaperdollButton" )
		CustomSettings.SaveBoolean( "EnhancePackBlockOthersPaperdoll", EnhancePack.BlockOthersPaperdoll )
	
	EnhancePack.ToggleYouSee = ButtonGetPressedFlag( "SettingsPincoYouSeeButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleYouSee", EnhancePack.ToggleYouSee )
	
	EnhancePack.ToggleBloodOath = ButtonGetPressedFlag( "SettingsPincoWarModeButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleBloodOath", EnhancePack.ToggleBloodOath )
	
	EnhancePack.WarShield = ButtonGetPressedFlag( "SettingsPincoWarShieldButton" )
	CustomSettings.SaveBoolean( "EnhancePackWarShield",EnhancePack.WarShield )
	WindowSetShowing("WarButton",EnhancePack.WarShield)
	
	EnhancePack.EnableAutoIgnoreCorpses = ButtonGetPressedFlag( "SettingsPincoDisableAutoIgnoreButton" )
	CustomSettings.SaveBoolean( "EnhancePackEnableAutoIgnoreCorpses", EnhancePack.EnableAutoIgnoreCorpses )
	
	EnhancePack.EnableCartographer = ButtonGetPressedFlag( "SettingsPincoUOCartButton" )
	CustomSettings.SaveBoolean( "EnhancePackEnableCartographer", EnhancePack.EnableCartographer )
	
	EnhancePack.BookLog = ButtonGetPressedFlag( "SettingsPincoBookLogButton" )
	CustomSettings.SaveBoolean( "EnhancePackBookLog", EnhancePack.BookLog )
	
	EnhancePack.MenuCreated = not ButtonGetPressedFlag( "SettingsPincoCreateMenuButton" )
	CustomSettings.SaveBoolean( "EnhancePackMenuCreated", EnhancePack.MenuCreated )
	if (not EnhancePack.MenuCreated) then
		HotbarSystem.DestroyHotbar(EnhancePack.MenuId)
	end
	
	MapWindow.ToggleCombos(ButtonGetPressedFlag( "SettingsPincoMapComboButton" ))
	
	local bckup = EnhancePack.GuildWaypoints
	EnhancePack.GuildWaypoints = ButtonGetPressedFlag( "SettingsPincoGuildWPButton" )
	CustomSettings.SaveBoolean( "EnhancePackGuildWaypoints", EnhancePack.GuildWaypoints )
	if (bckup ~= EnhancePack.GuildWaypoints and EnhancePack.GuildWaypoints  ) then
		EnhancePack.GuildMembers = {}
		EnhancePack.allyreqSend = false
		EnhancePack.GuildRequestUpdate = true
		MapCommon.WaypointUpdateRequest = true
	elseif (bckup ~= EnhancePack.GuildWaypoints and not EnhancePack.GuildWaypoints  ) then
		EnhancePack.GuildMembers = {}
		MapCommon.WaypointUpdateRequest = true
	end
	
	
	local bckup = EnhancePack.PartyShareHP
	EnhancePack.PartyShareHP = ButtonGetPressedFlag( "SettingsPincoPartyHPShareButton" )
	CustomSettings.SaveBoolean( "EnhancePackPartyShareHP", EnhancePack.PartyShareHP )
	if (bckup ~= EnhancePack.PartyShareHP and EnhancePack.PartyShareHP  and WindowData.PartyMember.partyLeaderId ~= 0) then
		local text = L"/party Party-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
		StatusWindow.NextUpdate = EnhancePack.TimeSinceLogin + 2
	elseif (bckup  ~= EnhancePack.PartyShareHP and WindowData.PartyMember.partyLeaderId ~= 0) then
		local text = L"/party Party-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. 0 .. L"-" .. 0
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
		StatusWindow.NextUpdate = EnhancePack.TimeSinceLogin + 2
	end
	
	bckup = EnhancePack.GuildShareHP
	EnhancePack.GuildShareHP = ButtonGetPressedFlag( "SettingsPincoGuildHPShareButton" )
	CustomSettings.SaveBoolean( "EnhancePackGuildShareHP", EnhancePack.GuildShareHP )
	if (bckup ~= EnhancePack.GuildShareHP and EnhancePack.GuildShareHP  and not EnhancePack.NotGuilded) then
		local text = L"/guild Guild-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
	elseif (bckup ~= EnhancePack.GuildShareHP and not EnhancePack.NotGuilded) then
		local text = L"/guild Guild-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. 0 .. L"-" .. 0
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
	end
	
	bckup = EnhancePack.GuildSharePos
	EnhancePack.GuildSharePos = ButtonGetPressedFlag( "SettingsPincoGuildPosShareButton" )
	CustomSettings.SaveBoolean( "EnhancePackGuildSharePos", EnhancePack.GuildSharePos )
	if (bckup ~= EnhancePack.GuildSharePos and EnhancePack.GuildSharePos  and not EnhancePack.NotGuilded) then
		local text = L"/guild Guild-cmd:POS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_xyzMap:" .. WindowData.PlayerLocation.x .. L"," .. WindowData.PlayerLocation.y .. L"," .. WindowData.PlayerLocation.z .. L"," .. WindowData.PlayerLocation.facet
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
	elseif (bckup ~= EnhancePack.GuildSharePos and not EnhancePack.NotGuilded) then
		local text = L"/guild Guild-cmd:POS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_xyzMap:" .. 0 .. L"," .. 0 .. L"," .. 0 .. L"," .. -1
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
	end
	
	
	bckup = EnhancePack.AllyShareHP
	EnhancePack.AllyShareHP = ButtonGetPressedFlag( "SettingsPincoAllyHPShareButton" )
	CustomSettings.SaveBoolean( "EnhancePackAllyShareHP", EnhancePack.AllyShareHP )
	if (bckup ~= EnhancePack.AllyShareHP and EnhancePack.AllyShareHP  and not EnhancePack.NotAlliance) then
		local text = L"/alliance Ally-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. WindowData.PlayerStatus.CurrentHealth .. L"-" .. WindowData.PlayerStatus.MaxHealth
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
	elseif (bckup ~= EnhancePack.AllyShareHP and not EnhancePack.NotAlliance) then
		local text = L"/alliance Ally-cmd:STATUS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_HP:" .. 0 .. L"-" .. 0
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
	end
	
	bckup = EnhancePack.AllySharePos
	EnhancePack.AllySharePos = ButtonGetPressedFlag( "SettingsPincoAllyPosShareButton" )
	CustomSettings.SaveBoolean( "EnhancePackAllySharePos", EnhancePack.AllySharePos )
	if (bckup ~= EnhancePack.AllySharePos and EnhancePack.AllySharePos  and not EnhancePack.NotAllyed) then
		local text = L"/alliance Ally-cmd:POS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_xyzMap:" .. WindowData.PlayerLocation.x .. L"," .. WindowData.PlayerLocation.y .. L"," .. WindowData.PlayerLocation.z .. L"," .. WindowData.PlayerLocation.facet
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
	elseif (bckup ~= EnhancePack.AllySharePos and not EnhancePack.NotAlliance) then
		local text = L"/alliance Ally-cmd:POS~" .. WindowData.PlayerStatus.PlayerId .. L"_Name:" .. WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName .. L"_xyzMap:" .. 0 .. L"," .. 0 .. L"," .. 0 .. L"," .. -1
		SendChat( ChatSettings.Channels[ SystemData.ChatLogFilters.SAY ], text )
	end

	EnhancePack.DisableBandages = ButtonGetPressedFlag( "SettingsPincoToggleDisableBandagesButton" )
	CustomSettings.SaveBoolean( "EnhancePackDisableBandages", EnhancePack.DisableBandages )
	
	EnhancePack.ScavengeAll = ButtonGetPressedFlag( "SettingsPincoToggleScavengeAllButton" )
	CustomSettings.SaveBoolean( "EnhancePackScavengeAll", EnhancePack.ScavengeAll )
	OrganizerWindow.UpdateCombo()

	
	EnhancePack.EnableQuickDetail = ButtonGetPressedFlag( "SettingsPincoToggleQuickDetailsButton" )
	CustomSettings.SaveBoolean( "EnhancePackEnableQuickDetail", EnhancePack.EnableQuickDetail )
	WindowSetShowing("QuickDetailsWindow", EnhancePack.EnableQuickDetail)
	 
	 
	EnhancePack.AutoCloseVetRew = ButtonGetPressedFlag( "SettingsPincoAutoCloseVetRewButton" )
	CustomSettings.SaveBoolean( "EnhancePackAutoCloseVetRew", EnhancePack.AutoCloseVetRew )
	
	EnhancePack.LootSort = ButtonGetPressedFlag( "SettingsPincoLootSortButton" )
	CustomSettings.SaveBoolean( "EnhancePackLootSort", EnhancePack.LootSort )
	
	EnhancePack.LootAllButTrash = ButtonGetPressedFlag( "SettingsPincoLootAllButTrashButton" )
	CustomSettings.SaveBoolean( "EnhancePackLootAllButTrash", EnhancePack.LootAllButTrash )
	
	EnhancePack.BardMastery = ButtonGetPressedFlag( "SettingsPincoBardMasteryButton" )
	CustomSettings.SaveBoolean( "EnhancePackBardMastery", EnhancePack.BardMastery )
	
	if (ButtonGetPressedFlag( "SettingsPincoChooseCharSexButton" )) then
		local okayButton = { textTid=1015327 , callback=function()EnhancePack.Female = false; CustomSettings.SaveBoolean( "EnhancePackFemale" , false ); CustomSettings.SaveBoolean( "EnhancePackSetSex" , true ); EnhancePack.SetSex = true; ButtonSetPressedFlag( "SettingsPincoChooseCharSexButton", false ); end }
		local cancelButton = { textTid=1015328, callback=function()EnhancePack.Female = true; CustomSettings.SaveBoolean( "EnhancePackFemale" , true ); CustomSettings.SaveBoolean( "EnhancePackSetSex" , true ); EnhancePack.SetSex = true; ButtonSetPressedFlag( "SettingsPincoChooseCharSexButton", false ); end }
		local DestroyConfirmWindow = 
				{
				    windowName = "SexMenu",
					title = UI.GetCliloc(SystemData.Settings.Language.type, 532),
					body = UI.GetCliloc(SystemData.Settings.Language.type, 533) ,
					buttons = { okayButton, cancelButton }
				}
	UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

	end
	
	EnhancePack.PartyIgnoreSharing = ButtonGetPressedFlag( "SettingsPincoPartyIgnoreButton" )
	CustomSettings.SaveBoolean( "EnhancePackPartyIgnoreSharing", EnhancePack.PartyIgnoreSharing )
	
	
	EnhancePack.ToggleWarOnPet = ButtonGetPressedFlag( "SettingsPincoBlockWarOnPetButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleWarOnPet", EnhancePack.ToggleWarOnPet )
	
	EnhancePack.ToggleWarOnParty = ButtonGetPressedFlag( "SettingsPincoBlockWarOnPartyButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleWarOnParty", EnhancePack.ToggleWarOnParty )
	
	EnhancePack.ToggleWarOnGuild = ButtonGetPressedFlag( "SettingsPincoBlockWarOnGuildButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleWarOnGuild", EnhancePack.ToggleWarOnGuild )
	
	 
	Hourglass.HourglassVisible = ButtonGetPressedFlag( "SettingsPincoHourglassButton" )
	WindowSetShowing("Hourglass", Hourglass.HourglassVisible)
	CustomSettings.SaveBoolean( "HourglassVisible", Hourglass.HourglassVisible )
	
	EnhancePack.ServerLine = ButtonGetPressedFlag( "SettingsPincoServerLinesButton" )
	CustomSettings.SaveBoolean( "EnhancePackServerLine", EnhancePack.ServerLine )
	WindowSetShowing("ServerLine", EnhancePack.ServerLine)
	
	ClockWindow.ClockEnabled = ButtonGetPressedFlag( "SettingsPincoClockButton" )
	CustomSettings.SaveBoolean( "ShowClock", ClockWindow.ClockEnabled)
	ClockWindow.ReloadSettings()
	
	EnhancePack.NoteWindow = ButtonGetPressedFlag( "SettingsPincoNoteButton" )
	CustomSettings.SaveBoolean( "EnhancePackNoteWindow", EnhancePack.NoteWindow)

	WindowSetShowing("SlayerNote", EnhancePack.NoteWindow)
	
	EnhancePack.StatusButtons = ButtonGetPressedFlag( "SettingsPincoToggleButtonHealthbarsButton" )
	CustomSettings.SaveBoolean( "SettingsPincoStatusButtons", EnhancePack.StatusButtons )
	

	StatusWindow.ToggleButtons()
	for mobileId, value in pairs(MobileHealthBar.hasWindow) do
		local windowNamed = "MobileHealthBar_"..mobileId
		if( DoesWindowNameExist(windowNamed)) then
			WindowSetShowing(windowNamed .. "GreenButton", EnhancePack.StatusButtons)
			WindowSetShowing(windowNamed .. "RedButton", EnhancePack.StatusButtons)
			WindowSetShowing(windowNamed .. "BlueButton", EnhancePack.StatusButtons)
		end
	end
	
	--EnhancePack.DangerBarEnabled = ButtonGetPressedFlag( "SettingsPincoDangerBarButton" )
	--CustomSettings.SaveBoolean( "SettingsPincoDangerBarEnabled", EnhancePack.DangerBarEnabled )
	
	--WindowSetShowing(DangerBar.WindowName, EnhancePack.DangerBarEnabled)
	
	EnhancePack.NewAnimalLore = ButtonGetPressedFlag( "SettingsPincoNewAnimalLoreButton" )
	CustomSettings.SaveBoolean( "SettingsPincoNewAnimalLore", EnhancePack.NewAnimalLore )
	
	EnhancePack.AdvancedCrafting = ButtonGetPressedFlag( "SettingsPincoAdvancedCraftingButton" )
	CustomSettings.SaveBoolean( "SettingsPincoAdvancedCrafting", EnhancePack.AdvancedCrafting )
	
	EnhancePack.DisableMoongateGump = ButtonGetPressedFlag( "SettingsPincoMoongateGumpButton" )
	CustomSettings.SaveBoolean( "SettingsPincoMoongateGump", EnhancePack.DisableMoongateGump )
	
	EnhancePack.NewBuffWarning = ButtonGetPressedFlag( "SettingsPincoBuffBlinkButton" )
	CustomSettings.SaveBoolean( "EnhancePackNewBuffWarning", EnhancePack.NewBuffWarning )
	
	EnhancePack.SpellSpeed = ButtonGetPressedFlag( "SettingsPincoSpellSpeedButton" )
	CustomSettings.SaveBoolean( "EnhancePackSpellSpeed", EnhancePack.SpellSpeed )
	
	EnhancePack.PaperdollBGEnable = ButtonGetPressedFlag( "SettingsPincoDisablePaperdollBGButton" )
	CustomSettings.SaveBoolean( "EnhancePackPaperdollBGEnable", EnhancePack.PaperdollBGEnable )
	
	
	if (not EnhancePack.PaperdollBGEnable) then
		local windowName = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
		PaperdollWindow.CurrentBG = "blackBG"
		DynamicImageSetTexture( windowName.."BGBG", "blackBG", 0, 0 )
	else
		PaperdollWindow.CurrentBG = ""
	end
	
	local reload = false
	--if (EnhancePack.UseNewChat ~= ButtonGetPressedFlag( "SettingsPincoUseNewChatButton" )) then
--		reload = true
--	end
--	EnhancePack.UseNewChat = ButtonGetPressedFlag( "SettingsPincoUseNewChatButton" )
--	CustomSettings.SaveBoolean( "EnhancePackUseNewChat", EnhancePack.UseNewChat )
--	NewChatWindow.SetVisible()
	
	
	
	bck = EnhancePack.LockChatLine 
	EnhancePack.LockChatLine = ButtonGetPressedFlag( "SettingsPincoLockChatButton" )
	CustomSettings.SaveBoolean( "EnhancePackLockChatLine" , EnhancePack.LockChatLine )
	
	if (bck ~=  EnhancePack.LockChatLine) then
		reload = true
	end
	
	EnhancePack.ToggleScale = ButtonGetPressedFlag( "SettingsPincoScaleModeButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleScale", EnhancePack.ToggleScale )
	
	EnhancePack.ToggleAlpha = ButtonGetPressedFlag( "SettingsPincoAlphaModeButton" )
	CustomSettings.SaveBoolean( "EnhancePackToggleAlpha", EnhancePack.ToggleAlpha )
		
	EnhancePack.EnableSnapping = ButtonGetPressedFlag( "SettingsPincoWindowSnapButton" )
	CustomSettings.SaveBoolean( "EnhancePackEnableSnapping", EnhancePack.EnableSnapping )
	
	EnhancePack.GoldLootBag = not ButtonGetPressedFlag( "SettingsPincoGoldOnLootbagButton" )
	CustomSettings.SaveBoolean( "EnhancePackGoldLootBag", EnhancePack.GoldLootBag )
	
	
	local it = ComboBoxGetSelectedMenuItem( "SettingsPincoTexturePack" )
	MiniTexturePack.Current = it
	CustomSettings.SaveNumber( "MiniTexturePackCurrent", MiniTexturePack.Current )
	
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do	
		Hotbar.ReloadHotbar(hotbarId)
	end
	
	MobilesOnScreen.SaveFilterSettings()
	NewChatWindow.OnSettingsHidden()
	
	PaperdollWindow.SwitchLabelTexture()
	ActionsWindow.UpdateIcons()
	CharacterSheet.UpdateIcons()
	SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
	
	StatusWindow.ToggleStrLabel()
	OverheadText.UpdateSettings()
	
	-- push the new values to c++
	needsReload = UserSettingsChanged() or reload
	
	if ( needsReload == true ) then
		InterfaceCore.ReloadUI()
	end
end

function SettingsWindow.ClearTempKeybindings()
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		SettingsWindow.Keybindings[key].newValue = nil
	end
end

function SettingsWindow.OnResetButton()
	local okayButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function()SettingsWindow.ClearTempKeybindings(); WindowUtils.ClearSettings(); SettingsWindow.DefaultRequest=true; InterfaceCore.ReloadUI();  end } -- BroadcastEvent( SystemData.Events.RESET_SETTINGS_TO_DEFAULT );
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }
	local ResetConfirmWindow = 
	{
		windowName = "SettingsWindow", 
		titleTid = 1078994, 
		bodyTid = 1078995, 
		buttons = { okayButton, cancelButton }
	}
			
	UO_StandardDialog.CreateDialog( ResetConfirmWindow )
end

function SettingsWindow.OnCancelButton()

	-- Reload the current settings
	SettingsWindow.ClearTempKeybindings()
	SettingsWindow.UpdateSettings()
	
	-- Close the window		
	ToggleWindowByName( "SettingsWindow", "", nil )
end

function SettingsWindow.OnResetUILocButton()	
	WindowUtils.ForceResetWindowPositions()	
end

function SettingsWindow.ClearTabStates()
	-- The pressed flag isn't being used for these tabs to decide color anymore
	ButtonSetPressedFlag( "SettingsWindowGraphicsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowKeyBindingsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowSoundTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowOptionsTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowLegacyTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowProfanityTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowPincosUITabButton", false )
	ButtonSetPressedFlag( "SettingsWindowMobilesOnScreenTabButton", false )
	ButtonSetPressedFlag( "SettingsWindowNewChatTabButton", false )
	
	ButtonSetDisabledFlag( "SettingsWindowGraphicsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowKeyBindingsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowSoundTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowOptionsTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowLegacyTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowProfanityTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowPincosUITabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowMobilesOnScreenTabButton", false )
	ButtonSetDisabledFlag( "SettingsWindowNewChatTabButton", false )
	
	WindowSetShowing( "SettingsWindowGraphicsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowKeyBindingsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowSoundTabButtonTab", true )
	WindowSetShowing( "SettingsWindowOptionsTabButtonTab", true )
	WindowSetShowing( "SettingsWindowLegacyTabButtonTab", true )
	WindowSetShowing( "SettingsWindowProfanityTabButtonTab", true )
	WindowSetShowing( "SettingsWindowPincosUITabButtonTab", true )
	WindowSetShowing( "SettingsWindowMobilesOnScreenTabButtonTab", true )
	WindowSetShowing( "SettingsWindowNewChatTabButtonTab", true )


	for index = 1, SettingsWindow.Modes.NUM_MODES do
		WindowSetShowing( SettingsWindow.Modes.windows[index], false )
	end	
end


function SettingsWindow.OpenGraphicsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowGraphicsTabButton", true )
	WindowSetShowing( "SettingsWindowGraphicsTabButtonTab", false )
	WindowSetShowing( "SettingsGraphicsWindow", true )
end

function SettingsWindow.OpenKeyBindingsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowKeyBindingsTabButton", true )
	WindowSetShowing( "SettingsWindowKeyBindingsTabButtonTab", false )
	WindowSetShowing( "SettingsKeyBindingsWindow", true )
	WindowSetShowing( "SettingsKeyDefaultWindow", true )
end

function SettingsWindow.OpenSoundTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowSoundTabButton", true )
	WindowSetShowing( "SettingsWindowSoundTabButtonTab", false )
	WindowSetShowing( "SettingsSoundWindow", true )
end

function SettingsWindow.OpenOptionsTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowOptionsTabButton", true )
	WindowSetShowing( "SettingsWindowOptionsTabButtonTab", false )
	WindowSetShowing( "SettingsOptionsWindow", true )
end

function SettingsWindow.OpenLegacyTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowLegacyTabButton", true )
	WindowSetShowing( "SettingsWindowLegacyTabButtonTab", false )
	WindowSetShowing( "SettingsLegacyWindow", true )
end

function SettingsWindow.OpenProfanityTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowProfanityTabButton", true )
	WindowSetShowing( "SettingsWindowProfanityTabButtonTab", false )
	WindowSetShowing( "SettingsProfanityWindow", true )
end

function SettingsWindow.OpenPincosTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowPincosUITabButton", true )
	WindowSetShowing( "SettingsWindowPincosUITabButtonTab", false )
	WindowSetShowing( "SettingsPincosUIWindow", true )
end

function SettingsWindow.OpenMobilesTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowMobilesOnScreenTabButton", true )
	WindowSetShowing( "SettingsWindowMobilesOnScreenTabButtonTab", false )
	WindowSetShowing( "SettingsMobilesOnScreen", true )
end

function SettingsWindow.OpenNewChatTab()
	SettingsWindow.ClearTabStates()
	ButtonSetDisabledFlag( "SettingsWindowNewChatTabButton", true )
	WindowSetShowing( "SettingsWindowNewChatTabButtonTab", false )
	WindowSetShowing( "NewChatSettingsWindow", true )
end

function SettingsWindow.ChatFont()
	FontSelector.Selection = "chat"
	if (not DoesWindowNameExist("FontSelector")) then
		CreateWindow("FontSelector", true)
	else
		WindowSetShowing("FontSelector", true)
	end
	
	FontSelector.OnShown()
	WindowSetShowing(FontSelector.RunicFontItem, false)
	WindowUtils.SetWindowTitle("FontSelector", L"Overhead Chat Font")
end

function SettingsWindow.NamesFont()
	FontSelector.Selection = "names"
	if (not DoesWindowNameExist("FontSelector")) then
		CreateWindow("FontSelector", true)
	else
		WindowSetShowing("FontSelector", true)
	end
	FontSelector.OnShown()
	WindowSetShowing(FontSelector.RunicFontItem, false)
	WindowUtils.SetWindowTitle("FontSelector", L"Overhead Names Font")
end

function SettingsWindow.SpellFont()
	FontSelector.Selection = "spells"
	if (not DoesWindowNameExist("FontSelector")) then
		CreateWindow("FontSelector", true)
	else
		WindowSetShowing("FontSelector", true)
	end
	FontSelector.OnShown()
	WindowSetShowing(FontSelector.RunicFontItem, not EnhancePack.ShowSpellName)
	WindowUtils.SetWindowTitle("FontSelector", L"Overhead Spells Font")
end

function SettingsWindow.DamageFont()
	FontSelector.Selection = "damage"
	if (not DoesWindowNameExist("FontSelector")) then
		CreateWindow("FontSelector", true)
	else
		WindowSetShowing("FontSelector", true)
	end
	FontSelector.OnShown()
	WindowSetShowing(FontSelector.RunicFontItem, false)
	WindowUtils.SetWindowTitle("FontSelector", L"Overhead Damage Font")
end

function SettingsWindow.IncreaseTextSize()
	EnhancePack.OverhedTextSize =EnhancePack.OverhedTextSize + 0.1
		
	if (EnhancePack.OverhedTextSize > 1.5) then
		EnhancePack.OverhedTextSize = 1.5
	end
	CustomSettings.SaveNumber("EnhancePackOverhedTextSize", EnhancePack.OverhedTextSize)
	EnhancePack.SendOverheadText(L"TEST Message", 23  , false, false)
end

function SettingsWindow.DecreaseTextSize()
	EnhancePack.OverhedTextSize =EnhancePack.OverhedTextSize - 0.1
	if (EnhancePack.OverhedTextSize < 0.5) then
		EnhancePack.OverhedTextSize = 0.5
	end
	CustomSettings.SaveNumber("EnhancePackOverhedTextSize", EnhancePack.OverhedTextSize)
	EnhancePack.SendOverheadText(L"TEST Message", 23 , false, false)
end
		

function SettingsWindow.CheckEnable()
	-- MUSIC
	local disable = ButtonGetPressedFlag( "MusicVolumeToggleButton" )
	if (disable) then
		ButtonSetPressedFlag( "ECPlayMusicVolumeToggleButton",false )
		LabelSetTextColor("ECPlayMusicVolumeText", 127,127,127)
		LabelSetTextColor("ECPlayMusicVolumeToggleLabel", 127,127,127)
	else
		LabelSetTextColor("ECPlayMusicVolumeText", 255,255,255)
		LabelSetTextColor("ECPlayMusicVolumeToggleLabel", 255,255,255)
	end
	ButtonSetDisabledFlag( "ECPlayMusicVolumeToggleButton", disable )
	
	-- OVERHEAD SPELLS DISABLED
	local disable = not ButtonGetPressedFlag( "SettingsPincoToggleOverheadSpellsButton" )

	if (disable) then
		ButtonSetPressedFlag( "SettingsPincoToggleOverheadSpellNamesButton",false )
		LabelSetTextColor("SettingsPincoToggleOverheadSpellNamesLabel", 127,127,127)
	else
		LabelSetTextColor("SettingsPincoToggleOverheadSpellNamesLabel", 255,255,255)
	end
	ButtonSetDisabledFlag( "SettingsPincoToggleOverheadSpellNamesButton", disable )
	
	--SAD MODE
	disable = ButtonGetPressedFlag( "SettingsPincoToggleSadModeButton" )

	if (disable) then
		ButtonSetPressedFlag( "SettingsPincoToggleOverheadSpellNamesButton",false )
		LabelSetTextColor("SettingsPincoToggleOverheadSpellNamesLabel", 127,127,127)
	else
		LabelSetTextColor("SettingsPincoToggleOverheadSpellNamesLabel", 255,255,255)
	end
	ButtonSetDisabledFlag( "SettingsPincoToggleOverheadSpellNamesButton", disable )
	
	
	-- OBJECT HANDLE SIZE
	local win = string.gsub(SystemData.ActiveWindow.name , "Button", "")
	win = string.gsub(win , "Label", "")
	
	if (win  ==  "SettingsPincoNormalSize") then
		ButtonSetPressedFlag( "SettingsPincoNormalSizeButton", true )
		ButtonSetPressedFlag( "SettingsPincoMediumSizeButton", false )
		ButtonSetPressedFlag( "SettingsPincoSmallSizeButton", false )
	elseif(win == "SettingsPincoMediumSize") then
		ButtonSetPressedFlag( "SettingsPincoNormalSizeButton", false )
		ButtonSetPressedFlag( "SettingsPincoMediumSizeButton", true )
		ButtonSetPressedFlag( "SettingsPincoSmallSizeButton", false )
	elseif(win  == "SettingsPincoSmallSize") then
		ButtonSetPressedFlag( "SettingsPincoNormalSizeButton", false )
		ButtonSetPressedFlag( "SettingsPincoMediumSizeButton", false )
		ButtonSetPressedFlag( "SettingsPincoSmallSizeButton", true )
	end
	
	-- OBJECT HANDLE OPACITY
	if (win  ==  "SettingsPincoDull") then
		ButtonSetPressedFlag( "SettingsPincoDullButton", true )
		ButtonSetPressedFlag( "SettingsPincoHalfDullButton", false )
		ButtonSetPressedFlag( "SettingsPincoTransparentButton", false )
	elseif(win == "SettingsPincoHalfDull") then
		ButtonSetPressedFlag( "SettingsPincoDullButton", false )
		ButtonSetPressedFlag( "SettingsPincoHalfDullButton", true )
		ButtonSetPressedFlag( "SettingsPincoTransparentButton", false )
	elseif(win  == "SettingsPincoTransparent") then
		ButtonSetPressedFlag( "SettingsPincoDullButton", false )
		ButtonSetPressedFlag( "SettingsPincoHalfDullButton", false )
		ButtonSetPressedFlag( "SettingsPincoTransparentButton", true )
	end
	
	-- HOTBAR ORIENTATION
	if (win  ==  "SettingsPincoHoriz") then
		ButtonSetPressedFlag( "SettingsPincoHorizButton", true )
		ButtonSetPressedFlag( "SettingsPincoVerticButton", false )
	elseif(win == "SettingsPincoVertic") then
		ButtonSetPressedFlag( "SettingsPincoHorizButton", false )
		ButtonSetPressedFlag( "SettingsPincoVerticButton", true )
	end
	
	-- IGNORE SUMMONS
	disable = ComboBoxGetSelectedMenuItem( "SettingsPincoCenterScreenTextLowHPPetCombo" ) == 6
	
	if (disable) then
		ButtonSetPressedFlag( "SettingsPincoIgnoreSummonsButton",false )
		LabelSetTextColor("SettingsPincoIgnoreSummonsLabel", 127,127,127)
	else
		LabelSetTextColor("SettingsPincoIgnoreSummonsLabel", 255,255,255)
	end
	ButtonSetDisabledFlag( "SettingsPincoIgnoreSummonsButton", disable )
	
	-- ALTERNATE GRID
	disable = not ButtonGetPressedFlag( "SettingsPincoToggleAlternateGridButton" )
	
	if (disable) then
		LabelSetTextColor("SettingsPincocolorGridAlterLabel", 127,127,127)
	else
		LabelSetTextColor("SettingsPincocolorGridAlterLabel", 255,255,255)
	end
	WindowSetShowing( "SettingsPincocolorGridAlterButton", not disable )
	
	--DIABLO HEALTHBARS
	disable = not ButtonGetPressedFlag( "SettingsPincoToggleDiabloHealthbarsButton" )

	if (disable) then
		ButtonSetPressedFlag( "SettingsPincoToggleDiabloHealthbarsNumButton",false )
		LabelSetTextColor("SettingsPincoToggleDiabloHealthbarsNumLabel", 127,127,127)
	else
		LabelSetTextColor("SettingsPincoToggleDiabloHealthbarsNumLabel", 255,255,255)
	end
	ButtonSetDisabledFlag( "SettingsPincoToggleDiabloHealthbarsNumButton", disable )
	
	
	-- AURA SPEED
	disable = not ButtonGetPressedFlag( "SettingsPincoToggleNotorietyAuraButton" )

	if (disable) then
		LabelSetTextColor("SettingsPincoStaticLabel", 127,127,127)
		LabelSetTextColor("SettingsPincoNormalSpeedLabel", 127,127,127)
		LabelSetTextColor("SettingsPincoFastLabel", 127,127,127)
		ButtonSetPressedFlag( "SettingsPincoStaticButton", false )
		ButtonSetPressedFlag( "SettingsPincoNormalSpeedButton", false )
		ButtonSetPressedFlag( "SettingsPincoFastButton", false )
	else
		LabelSetTextColor("SettingsPincoStaticLabel", 255,255,255)
		LabelSetTextColor("SettingsPincoNormalSpeedLabel", 255,255,255)
		LabelSetTextColor("SettingsPincoFastLabel", 255,255,255)
		if (win  ==  "SettingsPincoStatic") then
			ButtonSetPressedFlag( "SettingsPincoStaticButton", true )
			ButtonSetPressedFlag( "SettingsPincoNormalSpeedButton", false )
			ButtonSetPressedFlag( "SettingsPincoFastButton", false )
		elseif(win == "SettingsPincoNormalSpeed" or win  == "SettingsPincoToggleNotorietyAura" ) then
			ButtonSetPressedFlag( "SettingsPincoStaticButton", false )
			ButtonSetPressedFlag( "SettingsPincoNormalSpeedButton", true )
			ButtonSetPressedFlag( "SettingsPincoFastButton", false )
		elseif(win  == "SettingsPincoFast") then
			ButtonSetPressedFlag( "SettingsPincoStaticButton", false )
			ButtonSetPressedFlag( "SettingsPincoNormalSpeedButton", false )
			ButtonSetPressedFlag( "SettingsPincoFastButton", true )
		end
	end
	ButtonSetDisabledFlag( "SettingsPincoStaticButton", disable )
	ButtonSetDisabledFlag( "SettingsPincoNormalSpeedButton", disable )
	ButtonSetDisabledFlag( "SettingsPincoFastButton", disable )
	
	
	-- EXTRA ITEM INFO
	disable = not ButtonGetPressedFlag( "SettingsPincoExtraPropsButton" )

	if (disable) then
		ButtonSetPressedFlag( "SettingsPincoIntensInfoButton",false )
		LabelSetTextColor("SettingsPincoIntensInfoLabel", 127,127,127)
		LabelSetTextColor("SettingsPincoExtraInfoColorLabel", 127,127,127)
	else
		LabelSetTextColor("SettingsPincoIntensInfoLabel", 255,255,255)
		LabelSetTextColor("SettingsPincoExtraInfoColorLabel", 255,255,255)
	end
	WindowSetShowing("SettingsPincoExtraInfoColorExample", not disable)
	ComboBoxSetDisabledFlag("SettingsPincoExtraInfoColorCombo", disable )
	ButtonSetDisabledFlag( "SettingsPincoIntensInfoButton", disable )
	
	local id = ComboBoxGetSelectedMenuItem( "SettingsPincoExtraInfoColorCombo" )
	local r,g,b
	if (id ==1) then
		r=255
		g=0
		b=0
	elseif (id ==2) then
		r=0
		g=255
		b=0
	elseif (id ==3) then
		r=0
		g=0
		b=255
	elseif (id ==4) then
		r=255
		g=255
		b=0
	elseif (id ==5) then
		r=0
		g=255
		b=255
	elseif (id ==6) then
		r=255
		g=0
		b=255
	elseif (id ==7) then
		r=255
		g=255
		b=255
	end
	WindowSetTintColor("SettingsPincoExtraInfoColorExample", r,g,b)
	
	-- FORGE TYPE
	if (win  ==  "SettingsPincoNormalForge") then
		ButtonSetPressedFlag( "SettingsPincoNormalForgeButton", true )
		ButtonSetPressedFlag( "SettingsPincoTerMurForgeButton", false )
		ButtonSetPressedFlag( "SettingsPincoQueenForgeButton", false )
	elseif(win == "SettingsPincoTerMurForge" ) then
		ButtonSetPressedFlag( "SettingsPincoNormalForgeButton", false )
		ButtonSetPressedFlag( "SettingsPincoTerMurForgeButton", true )
		ButtonSetPressedFlag( "SettingsPincoQueenForgeButton", false )
	elseif(win  == "SettingsPincoQueenForge" ) then
		ButtonSetPressedFlag( "SettingsPincoNormalForgeButton", false )
		ButtonSetPressedFlag( "SettingsPincoTerMurForgeButton", false )
		ButtonSetPressedFlag( "SettingsPincoQueenForgeButton", true )
	end
	
	-- CHAR TYPE
	if (win  ==  "SettingsPincoNormalChar") then
		ButtonSetPressedFlag( "SettingsPincoNormalCharButton", true )
		ButtonSetPressedFlag( "SettingsPincoGargCharButton", false )
	elseif(win == "SettingsPincoGargChar" ) then
		ButtonSetPressedFlag( "SettingsPincoNormalCharButton", false )
		ButtonSetPressedFlag( "SettingsPincoGargCharButton", true )
	end
	
	disable = not ButtonGetPressedFlag( "SettingsPincoGuildWPButton" )
	if (disable) then
		LabelSetTextColor("SettingsPincoGuildPosShareLabel", 127,127,127)
		LabelSetTextColor("SettingsPincoGuildHPShareLabel", 127,127,127)
		LabelSetTextColor("SettingsPincoAllyHPShareLabel", 127,127,127)
		LabelSetTextColor("SettingsPincoAllyPosShareLabel", 127,127,127)
		
		ButtonSetPressedFlag( "SettingsPincoGuildPosShareButton", false )
		ButtonSetPressedFlag( "SettingsPincoGuildHPShareButton",false )
		ButtonSetPressedFlag( "SettingsPincoAllyHPShareButton",false )
		ButtonSetPressedFlag( "SettingsPincoAllyPosShareButton", false )
		
		WindowSetShowing("SettingsPincoGuildPosShareButton", not disable)
		WindowSetShowing("SettingsPincoGuildHPShareButton", not disable)
		WindowSetShowing("SettingsPincoAllyHPShareButton", not disable)
		WindowSetShowing("SettingsPincoAllyPosShareButton", not disable)
	else
	
		LabelSetTextColor("SettingsPincoGuildPosShareLabel", 255,255,255)
		LabelSetTextColor("SettingsPincoAllyPosShareLabel", 255,255,255)
		
		WindowSetShowing("SettingsPincoGuildPosShareButton", not disable)
		WindowSetShowing("SettingsPincoAllyPosShareButton", not disable)
		
			-- ally share
		disable = not ButtonGetPressedFlag( "SettingsPincoAllyPosShareButton" )
		if (disable) then
			LabelSetTextColor("SettingsPincoGuildPosShareLabel", 255,255,255)
			LabelSetTextColor("SettingsPincoGuildHPShareLabel", 127,127,127)
			ButtonSetPressedFlag( "SettingsPincoAllyHPShareButton",false )
			LabelSetTextColor("SettingsPincoAllyHPShareLabel", 127,127,127)
			WindowSetShowing("SettingsPincoGuildPosShareButton", disable)
			WindowSetShowing("SettingsPincoGuildHPShareButton", disable)
		else
			ButtonSetPressedFlag( "SettingsPincoGuildPosShareButton",false )
			ButtonSetPressedFlag( "SettingsPincoGuildHPShareButton",false )
			LabelSetTextColor("SettingsPincoGuildPosShareLabel", 127,127,127)
			LabelSetTextColor("SettingsPincoGuildHPShareLabel", 127,127,127)
			
			WindowSetShowing("SettingsPincoGuildPosShareButton", disable)
			WindowSetShowing("SettingsPincoGuildHPShareButton", disable)
			
			LabelSetTextColor("SettingsPincoAllyHPShareLabel", 255,255,255)
		end
		WindowSetShowing("SettingsPincoAllyHPShareButton", not disable)

		
		--guild share
		disable = not ButtonGetPressedFlag( "SettingsPincoGuildPosShareButton" )

		if (disable) then
			ButtonSetPressedFlag( "SettingsPincoGuildHPShareButton",false )
			LabelSetTextColor("SettingsPincoGuildHPShareLabel", 127,127,127)
		else
			LabelSetTextColor("SettingsPincoGuildHPShareLabel", 255,255,255)
		end
		WindowSetShowing("SettingsPincoGuildHPShareButton", not disable)
	end
	
	
	
	

end

function SettingsWindow.TestCenterscreen()
	EnhancePack.SendCenterScreenTexture("panic")
end

function SettingsWindow.OnKeyPicked()
	for key = 1, table.getn( SettingsWindow.Keybindings )do
		if( SystemData.ActiveWindow.name == "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name )then
			SettingsWindow.CurKeyIndex = key
		elseif( SystemData.Settings.GameOptions.legacyTargeting == true and key >= SettingsWindow.NON_LEGACY_BINDING_MIN and key <= SettingsWindow.NON_LEGACY_BINDING_MAX ) then
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "Action", 255, 255, 255 )
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 128, 128, 128 )
		else
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "Action", 255, 255, 255 )
			LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[key].name .. "ActionValue", 255, 255, 255 )
		end
	end
		
	if ( SystemData.Settings.GameOptions.legacyTargeting == false or
	( SystemData.Settings.GameOptions.legacyTargeting == true and ( SettingsWindow.CurKeyIndex < SettingsWindow.NON_LEGACY_BINDING_MIN or SettingsWindow.CurKeyIndex > SettingsWindow.NON_LEGACY_BINDING_MAX) ) ) then
		--Debug.PrintToDebugConsole( L"Active Window: ".. StringToWString( SystemData.ActiveWindow.name ) )
		LabelSetTextColor( SystemData.ActiveWindow.name .. "Action", 250, 250, 0 )
		LabelSetTextColor( SystemData.ActiveWindow.name .. "ActionValue", 250, 250, 0 )
		
		WindowClearAnchors( "AssignHotkeyInfo" )
		WindowAddAnchor( "AssignHotkeyInfo", "topleft", SystemData.ActiveWindow.name.."ActionValue", "bottomleft", 0, -6 )
		WindowSetShowing( "AssignHotkeyInfo", true )	
		
		SettingsWindow.RecordingKey = true
		
		SystemData.IsRecordingSettings = true
		BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
	end
end

function SettingsWindow.KeyRecorded()	
	if( SettingsWindow.RecordingKey == true )then
		local keyIndex = SettingsWindow.CurKeyIndex
		
		WindowSetShowing( "AssignHotkeyInfo", false )
		
		LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[keyIndex].name .. "Action", 255, 255, 255 )
		LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[keyIndex].name .. "ActionValue", 255, 255, 255 )
	
		if( SystemData.RecordedKey ~= L"" )then
			for index = 1, table.getn( SettingsWindow.Keybindings )do
				if( SettingsWindow.Keybindings[keyIndex].type ~= nil )then
					local value = SystemData.Settings.Keybindings[SettingsWindow.Keybindings[index].type]
					if( SettingsWindow.Keybindings[index].newValue ~= nil )then
						value = SettingsWindow.Keybindings[index].newValue
					end
					
					if( value == SystemData.RecordedKey )then
						SystemData.BindingConflictItemIndex = index
						SystemData.BindingConflictType = SystemData.BindType.BINDTYPE_SETTINGS
						break
					end
				end
			end
		end
		
		if( SystemData.BindingConflictType ~= SystemData.BindType.BINDTYPE_NONE )then
			body = GetStringFromTid( SettingsWindow.TID_BINDING_CONFLICT_BODY )..L"\n\n"..HotbarSystem.GetKeyName(SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType)..L"\n\n"..GetStringFromTid( SettingsWindow.TID_BINDING_CONFLICT_QUESTION )
			
			local yesButton = { textTid = SettingsWindow.TID_YES,
								callback =	function()
											HotbarSystem.ReplaceKey(
												SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType,
												0, keyIndex, SystemData.BindType.BINDTYPE_SETTINGS,
												SystemData.RecordedKey, L"")
											end
							  }
			local noButton = { textTid = SettingsWindow.TID_NO }
			local windowData = 
			{
				windowName = "SettingsWindow", 
				titleTid = SettingsWindow.TID_BINDING_CONFLICT_TITLE, 
				body = body, 
				buttons = { yesButton, noButton }
			}
			UO_StandardDialog.CreateDialog( windowData )
		else	
			SettingsWindow.Keybindings[keyIndex].newValue = SystemData.RecordedKey
			SettingsWindow.UpdateKeyBindings()
			
			BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )
		end
		
		SystemData.IsRecordingSettings = false
		SettingsWindow.RecordingKey = false
	end
end

function SettingsWindow.KeyCancelRecord()
	if( SettingsWindow.RecordingKey == true )then
		WindowSetShowing( "AssignHotkeyInfo", false )
		
		local keyIndex = SettingsWindow.CurKeyIndex
		LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[keyIndex].name .. "Action", 255, 255, 255 )
		LabelSetTextColor( "SettingsKeyBindings"..SettingsWindow.Keybindings[keyIndex].name .. "ActionValue", 255, 255, 255 )
		
		SystemData.IsRecordingSettings = false
		SettingsWindow.RecordingKey = false
	end
end

function SettingsWindow.OnIgnoreListAddButton()
	StartIgnoreListAdd(SettingsWindow.IGNORE_LIST_ALL)

	--hide the settings window and main menu window so player can pick something on screen	
	WindowSetShowing( "SettingsWindow", false )
	WindowSetShowing( "MainMenuWindow", false )
end

function SettingsWindow.OnIgnoreConfListAddButton()
	StartIgnoreListAdd(SettingsWindow.IGNORE_LIST_CONF)

	--hide the settings window and main menu window so player can pick something on screen	
	WindowSetShowing( "SettingsWindow", false )
	WindowSetShowing( "MainMenuWindow", false )
end

function SettingsWindow.ProfanityListUpdated()
	--the player has picked something, show the main menu and settings window
--	WindowSetShowing( "MainMenuWindow", true )
	WindowSetShowing( "SettingsWindow", true )

	SettingsWindow.PopulateProfanityList()
end

function SettingsWindow.PopulateProfanityList()
	-- local previousListItem -- Is there a reason this isn't in here?

	-- don't show the bad words for now
	local b = false -- NOTE: Due to layout changes on this gump, the bad words list will need re-anchoring if you set it to display!
	if b then
		-- clear bad words
		for i = 1, SettingsWindow.PreviousBadWordCount do
			--Debug.PrintToDebugConsole( L"destroy BadWord"..i )
			--hide instead of destroy because destroyWindow dosen't actually destroy it, it just puts it into the destroy queue
			WindowSetShowing( "BadWord"..i, false )
		end
		
		-- list all bad words
		local first = true
		SettingsWindow.PreviousBadWordCount = WindowData.BadWordListCount
		for i = 1, WindowData.BadWordListCount do
			--Debug.PrintToDebugConsole( L"create BadWord"..i )
			CreateWindowFromTemplate( "BadWord"..i, "BadWord", "SettingsBadWordFilter" )
			WindowSetShowing( "BadWord"..i, true )
			LabelSetText( "BadWord"..i, L"- "..WindowData.BadWordList[i] )
			if( first )then
				first = false
				WindowAddAnchor( "BadWord"..i, "topleft", "SettingsBadWordFilter", "topleft", 80, 110 )
			else
				WindowAddAnchor( "BadWord"..i, "bottomleft", previousListItem, "topleft", 0, 0 )
			end
	
			previousListItem = "BadWord"..i
		end
	end
	
	-- clear ignore list
	for i = 1, SettingsWindow.PreviousIgnoreListCount do
		--Debug.PrintToDebugConsole( L"destroy IgnoreListItem"..i )
		--Debug.PrintToDebugConsole( LabelGetText( "IgnoreListItem"..i ) )
		DestroyWindow( "IgnoreListItem"..i)
	end

	-- list all player in the ignore list
	first = true
	for i = 1, WindowData.IgnoreListCount do
		--Debug.PrintToDebugConsole( L"create IgnoreListItem"..i )
		--Debug.PrintToDebugConsole( L""..WindowData.IgnoreIdList[i]..L" "..WindowData.IgnoreNameList[i] )
		CreateWindowFromTemplate( "IgnoreListItem"..i, "IgnoreListItem", "SettingsBadWordFilter" )
		
		WindowSetShowing( "IgnoreListItem"..i, true )
		LabelSetText( "IgnoreListItem"..i, L"- "..WindowData.IgnoreNameList[i] )
		if( first )then
			first = false
			WindowAddAnchor( "IgnoreListItem"..i, "bottomleft", "IgnoreListDeleteButton", "topleft", 0, 10 )
		else
			WindowAddAnchor( "IgnoreListItem"..i, "bottomleft", previousListItem, "topleft", 0, 0 )
		end

		previousListItem = "IgnoreListItem"..i
	end
	SettingsWindow.PreviousIgnoreListCount = WindowData.IgnoreListCount

	-- clear conf ignore list
	for i = 1, SettingsWindow.PreviousIgnoreConfListCount do
		--Debug.PrintToDebugConsole( L"destroy IgnoreConfListItem"..i )
		--Debug.PrintToDebugConsole( LabelGetText( "IgnoreConfListItem"..i ) )
		DestroyWindow( "IgnoreConfListItem"..i)
	end

	-- list all player in the ignore list
	first = true
	for i = 1, WindowData.IgnoreConfListCount do
		--Debug.PrintToDebugConsole( L"create IgnoreConfListItem"..i )
		--Debug.PrintToDebugConsole( L""..WindowData.IgnoreConfIdList[i]..L" "..WindowData.IgnoreConfNameList[i] )
		CreateWindowFromTemplate( "IgnoreConfListItem"..i, "IgnoreConfListItem", "SettingsBadWordFilter" )
		
		WindowSetShowing( "IgnoreConfListItem"..i, true )
		LabelSetText( "IgnoreConfListItem"..i, L"- "..WindowData.IgnoreConfNameList[i] )
		if( first )then
			first = false
			WindowAddAnchor( "IgnoreConfListItem"..i, "bottomleft", "IgnoreConfListDeleteButton", "topleft", 0, 10 )
		else
			WindowAddAnchor( "IgnoreConfListItem"..i, "bottomleft", previousListItem, "topleft", 0, 0 )
		end

		previousListItem = "IgnoreConfListItem"..i
	end
	SettingsWindow.PreviousIgnoreConfListCount = WindowData.IgnoreConfListCount

	ScrollWindowUpdateScrollRect( "SettingsProfanityWindow" )	
end

function SettingsWindow.OnIgnoreListDeleteButton()
	if SettingsWindow.CurIgnoreListIdx == -1 then
		return
	end

	local idx = SettingsWindow.CurIgnoreListIdx
	Debug.PrintToDebugConsole( L"current idx "..idx )
	local id = WindowData.IgnoreIdList[idx]
	Debug.PrintToDebugConsole( L"id at idx "..id )
	DeleteFromIgnoreList( id, SettingsWindow.IGNORE_LIST_ALL )
	SettingsWindow.CurIgnoreListIdx = -1
	SettingsWindow.PopulateProfanityList()
end

function SettingsWindow.OnIgnoreConfListDeleteButton()
	if SettingsWindow.CurIgnoreConfListIdx == -1 then
		return
	end

	local idx = SettingsWindow.CurIgnoreConfListIdx
	Debug.PrintToDebugConsole( L"conf current idx "..idx )
	local id = WindowData.IgnoreConfIdList[idx]
	Debug.PrintToDebugConsole( L"conf id at idx "..id )
	DeleteFromIgnoreList( id, SettingsWindow.IGNORE_LIST_CONF )
	SettingsWindow.CurIgnoreConfListIdx = -1
	SettingsWindow.PopulateProfanityList()
end

function SettingsWindow.OnIgnoreListChatListButton()
	SettingsWindow.ignoreListType = SettingsWindow.IGNORE_LIST_ALL
	CreateWindow("IgnoreWindow", true)
end

function SettingsWindow.OnIgnoreConfListChatListButton()
	SettingsWindow.ignoreListType = SettingsWindow.IGNORE_LIST_CONF
	CreateWindow("IgnoreWindow", true)
end

function SettingsWindow.OnIgnoreListItemClicked()
	for i = 1, WindowData.IgnoreListCount do
		LabelSetTextColor( "IgnoreListItem"..i, 255, 255, 255 )
		if( SystemData.ActiveWindow.name == "IgnoreListItem"..i )then
			SettingsWindow.CurIgnoreListIdx = i
		end
	end

	LabelSetTextColor( SystemData.ActiveWindow.name, 250, 250, 0 )
end

function SettingsWindow.OnIgnoreConfListItemClicked()
	for i = 1, WindowData.IgnoreConfListCount do
		LabelSetTextColor( "IgnoreConfListItem"..i, 255, 255, 255 )
		if( SystemData.ActiveWindow.name == "IgnoreConfListItem"..i )then
			SettingsWindow.CurIgnoreConfListIdx = i
		end
	end

	LabelSetTextColor( SystemData.ActiveWindow.name, 250, 250, 0 )
end

function SettingsWindow.UpdateGammaVal()
	local gamma = SliderBarGetCurrentPosition( "GammaSliderBar" )
	LabelSetText( "GammaVal", wstring.format( L"%2.2f", gamma ) )
	
	--Debug.Print("Framerate max: "..SystemData.Settings.Resolution.framerateMax)
end

function SettingsWindow.OnShowResetLegacyDialog()
	if( ButtonGetPressedFlag( "LegacyChatButton" )== true )then
		local yesButton = { textTid = SettingsWindow.TID_YES, callback = function()SettingsWindow.ResetLegacyKeyBindings()end }
		local noButton = { textTid = SettingsWindow.TID_NO }
		local windowData = 
		{
			windowName = "Root", 
			titleTid = SettingsWindow.TID_INFO, 
			bodyTid = SettingsWindow.TID_RESETLEGACYBINDINGS_CHAT, 
			buttons = { yesButton, noButton }
		}
		UO_StandardDialog.CreateDialog( windowData )	 
	end
end

function SettingsWindow.LegacyTargetingButtonOnLButtonUp()
	SettingsWindow.ResetScrollWheelOptions()
end

function SettingsWindow.LabelOnMouseOver()
	local windowName = SystemData.ActiveWindow.name
	local detailTID = WindowGetId(windowName)
	if (detailTID == 0) then
		return
	end
	if ( (detailTID ~= nil) and (detailTID ~= 0) and detailTID > 800000) then
		local text = GetStringFromTid(detailTID)
		Tooltips.CreateTextOnlyTooltip(windowName, text)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	else
		local text = GetStringFromTid(detailTID)
		if (detailTID >= 1000 and detailTID <= 1501) then
			text = UI.GetCliloc(SystemData.Settings.Language.type, detailTID)
		end
		Tooltips.CreateTextOnlyTooltip(windowName, text)
		Tooltips.Finalize()
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end 
end


function SettingsWindow.PincosSettings()	
	--Debug.Print( L"Called MenuBarWindow.ToggleMenuButton()" )

	local enabled = 0
	local active = 0

	enabled = 0
	active = 0
	if ( EnhancePack.ShowSpellName ) then
		enabled = 1
	end
	
	if (EnhancePack.SadMode) then
		active = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Overhead Spell Names",active,"disableSpellname",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Overhead Spell Names",active,"enableSpellname",2,false)
	end
	
	enabled = 0
	if ( not EnhancePack.DisableSpells ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Overhead Spells",0,"disableSpell",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Overhead Spells",0,"enableSpell",2,false)
	end
	
	
	enabled = 0
	if ( EnhancePack.BlockOthersPaperdoll ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Block Others Paperdoll",0,"disablepaper",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Block Others Paperdoll",0,"enablepaper",2,false)
	end
	
	enabled = 0
	if ( MobileHealthBar.CloseStyle ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Healthbar Old Close",0,"disableOldHealth",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Healthbar Old Close",0,"enableOldHealth",2,false)
	end
	
	enabled = 0
	if ( MobileHealthBar.PetCloseStyle ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Pet Healthbar Old Close",0,"disablePetOldHealth",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Pet Healthbar Old Close",0,"enablePetOldHealth",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.HealthBarWod ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable WoD on Healthbars",0,"disableWOD",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable WoD on Healthbars",0,"enableWOD",2,false)
	end
	
	
	enabled = 0
	if ( EnhancePack.ToggleYouSee ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable You See Message",0,"disableYouSee",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable You See Message",0,"enableYouSee",2,false)
	end
	
	enabled = 0
	if ( StatusWindow.AuraEnabled) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Notoriety Aura",0,"disableNoto",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Notoriety Aura",0,"enableNoto",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.ToggleBloodOath ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Auto-Toggle War Mode",0,"disableBlood",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Auto-Toggle War Mode",0,"enableBlood",2,false)
	end
	
	
	
	
	enabled = 0
	if (  EnhancePack.GoldLootBag) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Looted Gold Goes On Backpack",0,"disableGold",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Looted Gold Goes On Loot Bag",0,"enableGold",2,false)
	end
	
	enabled = 0
	if (  EnhancePack.EnableAutoIgnoreCorpses) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Auto-Ignore Corpses",0,"disableAutoIgnore",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Auto-Ignore Corpses",0,"enableAutoIgnore",2,false)
	end
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	enabled = 0
	active = 0
	if ( SystemData.Settings.Interface.LegacyContainers ) then
		enabled = 1
		active = 1
	end
	
	
	enabled = 0
	if ( EnhancePack.GridLegacy ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Grid Legacy Containers",active,"disableGridLegacy",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Grid Legacy Containers",active,"enableGridLegacy",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.EnableContainerGrid ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Grid on Containers",active,"disableGrid",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Grid on Containers",active,"enableGrid",2,false)
	end
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	
	enabled = 0
	active = 1
	if ( EnhancePack.DiabloHealthEnable ) then
		enabled = 1
		active = 0
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable  Diablo Healthbars",0,"disableDiablo",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable  Diablo Healthbars",0,"enableDiablo",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.DiabloHealthNumbersEnable ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Health Numbers",active,"disableDiabloNum",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Diablo Health Numbers",active,"enableDiabloNum",2,false)
	end
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
			
		
	local enabled2 = 0
	if ( EnhancePack.ToggleExtraInfo ) then
		enabled2 = 1
	end
	
	if (enabled2 == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Extra Properties Info",0,"disableExtra",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Extra Properties Info",0,"enableExtra",2,false)
	end
	
	enabled = 0
	if ( EnhancePack.IntensityInfo ) then
		enabled = 1
	end
	
	if (enabled2 == 1) then
		active = 0
	else
		active = 1
	end
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Item Intensity Info",active,"disableIntens",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Item Intensity Info",active,"enableIntens",2,false)
	end
	

	
	subMenu = {
			{ str = L"Current",flags=0,returnCode="null",pressed=false,textColor=EnhancePack.EXTRAINFO },
			{ str = L"",flags=0,returnCode="null",pressed=false,textColor=EnhancePack.ENGRAVE_COLOR },
			{ str = L"Red",flags=0,returnCode="colorRed",pressed=false, textColor={r=255, g=0, b=0} },
			{ str = L"Green",flags=0,returnCode="colorGreen",pressed=false, textColor={r=0, g=255, b=0} },
			{ str = L"Blue",flags=0,returnCode="colorBlue",pressed=false,textColor={r=0, g=0, b=255} },
			{ str = L"Yellow",flags=0,returnCode="colorYellow",pressed=false,textColor={r=255, g=255, b=0} },
			{ str = L"Aqua",flags=0,returnCode="colorAqua",pressed=false,textColor={r=0, g=255, b=255} },
			{ str = L"Pink",flags=0,returnCode="colorPink",pressed=false,textColor={r=255, g=0, b=255} },
			{ str = L"White",flags=0,returnCode="colorWhite",pressed=false,textColor={r=255, g=255, b=255} }
			}
	if (enabled2 == 1) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Set Extra Info Color",0,0,"null",false,subMenu)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Set Extra Info Color",1,0,"null",false)
	end
	

	
	
	ContextMenu.ActivateLuaContextMenu(SettingsWindow.ContextMenuCallback)
	
	
	local scaleFactor = 1/0.65
	
	local cmWidth, cmHeight = WindowGetDimensions("ContextMenu")

	WindowSetScale("ContextMenu", 0.65)
	
	
	
	
	local cmWindowX = 0
	local mouseX = SystemData.MousePosition.x
	if mouseX + (cmWidth / scaleFactor) > SystemData.screenResolution.x then
		cmWindowX = mouseX - (cmWidth / scaleFactor)
	else
		cmWindowX = mouseX
	end
		
	local mouseY = SystemData.MousePosition.y
	local cmWindowY = mouseY
	if mouseY + (cmHeight / scaleFactor) > SystemData.screenResolution.y then
		cmWindowY = mouseY - (cmHeight / scaleFactor)
	else
		cmWindowY = mouseY
	end
	
	WindowSetOffsetFromParent("ContextMenu", cmWindowX * scaleFactor, cmWindowY * scaleFactor)	
	
end
function SettingsWindow.PincosCustom()
	local active = 0
	if (EnhancePack.AuraSpeed == 0) then
		active = 1
	end
	local active1 = 0
	if (EnhancePack.AuraSpeed == 10) then
		active1 = 1
	end
	local active2 = 0
	if (EnhancePack.AuraSpeed == 20) then
		active2 = 1
	end
	local subMenu = {
			{ str = L"Static",flags=active ,returnCode="auraStatic",pressed=false},
			{ str = L"Normal",flags=active1,returnCode="auraNormal",pressed=false},
			{ str = L"Fast",flags=active2,returnCode="auraFast",pressed=false}
			}
	active = 1
	if (StatusWindow.AuraEnabled) then
		active = 0
	end

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Aura Speed",active,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	enabled = 0
	if ( EnhancePack.ToggleScale ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Scale Mode",0,"disableScale",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Scale Mode",0,"enableScale",2,false)
	end
	
	enabled = 0
	if (  EnhancePack.EnableSnapping) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Windows Snap",0,"disableSnap",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Windows Snap",0,"enableSnap",2,false)
	end
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	subMenu = {
			{ str = L"Normal",flags=0 ,returnCode="objNormal",pressed=EnhancePack.ObjectHandleScale == InterfaceCore.scale},
			{ str = L"Medium",flags=0,returnCode="objMedium",pressed=EnhancePack.ObjectHandleScale == InterfaceCore.scale * 0.8},
			{ str = L"Small",flags=0,returnCode="objSmall",pressed=EnhancePack.ObjectHandleScale == (InterfaceCore.scale * 2 )/3}
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Object Handle Size",0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = L"Dull",flags=0 ,returnCode="objDull",pressed=EnhancePack.ObjectHandleAlpha == 1},
			{ str = L"Half-Dull",flags=0,returnCode="objHalfTransp",pressed=EnhancePack.ObjectHandleAlpha == 0.6},
			{ str = L"Transparent",flags=0,returnCode="objTransp",pressed=EnhancePack.ObjectHandleAlpha == 0.4}
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Object Handle Opacity",0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	subMenu = {
			{ str = L"Center",flags=MenuBarWindow.getPos(1) ,returnCode="center1",pressed=false},
			{ str = L"Top",flags=MenuBarWindow.getPos(2),returnCode="center2",pressed=false},
			{ str = L"Bottom",flags=MenuBarWindow.getPos(3),returnCode="center3",pressed=false},
			{ str = L"Left",flags=MenuBarWindow.getPos(4),returnCode="center4",pressed=false},
			{ str = L"Right",flags=MenuBarWindow.getPos(5),returnCode="center5",pressed=false}
			}
	if (WindowGetShowing("MainCenterScreenTexture")) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Centerscreen Text Position",1,0,"null",false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Centerscreen Text Position",0,0,"null",false,subMenu)
	end
	
	subMenu = {
			{ str = L"20%",flags=0,returnCode="HP20",pressed=EnhancePack.LowHPPerc == 20 },
			{ str = L"30%",flags=0,returnCode="HP30",pressed=EnhancePack.LowHPPerc == 30 },
			{ str = L"40%",flags=0,returnCode="HP40",pressed=EnhancePack.LowHPPerc == 40 },
			{ str = L"50%",flags=0,returnCode="HP50",pressed=EnhancePack.LowHPPerc == 50 },
			{ str = L"60%",flags=0,returnCode="HP60",pressed=EnhancePack.LowHPPerc == 60 },
			{ str = L"Disabled",flags=0,returnCode="HPdisable",pressed=EnhancePack.LowHPPercDisabled }
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Centerscreen Text Low HP %",0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = L"20%",flags=0,returnCode="PHP20",pressed=EnhancePack.LowPETHPPerc == 20 },
			{ str = L"30%",flags=0,returnCode="PHP30",pressed=EnhancePack.LowPETHPPerc == 30 },
			{ str = L"40%",flags=0,returnCode="PHP40",pressed=EnhancePack.LowPETHPPerc == 40 },
			{ str = L"50%",flags=0,returnCode="PHP50",pressed=EnhancePack.LowPETHPPerc == 50 },
			{ str = L"60%",flags=0,returnCode="PHP60",pressed=EnhancePack.LowPETHPPerc == 60 },
			{ str = L"Ignore Summons",flags=0,returnCode="IgnoreSummons",pressed=EnhancePack.EnableIgnoreSummons },
			{ str = L"Disabled",flags=0,returnCode="HPPETdisable",pressed=EnhancePack.LowHPPETPercDisabled }
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Centerscreen Text Pet Low HP %",0,0,"null",false,subMenu)

	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,0,"null",false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Overhead Chat Font",0,"setFont",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Overhead Names Font",0,"setNameFont",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Overhead Spells Font",0,"setSpellFont",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Overhead Damage Font",0,"setDamageFont",2,false)
	
	enabled = 0
	if ( EnhancePack.SadMode ) then
		enabled = 1
	end
	
	if (enabled == 1 ) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Disable Sad Mode",0,"disableSad",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(L"Enable Sad Mode",0,"enableSad",2,false)
	end
	
	subMenu = {
			{ str = L"Set Default Name Color",flags=0,returnCode="colorDefault",pressed=false, textColor=EnhancePack.TITLE_COLOR },
			{ str = L"Set Default Mods Color",flags=0,returnCode="colorMods",pressed=false, textColor=EnhancePack.BODY_COLOR },
			{ str = L"Set Engrave Color",flags=0,returnCode="colorEngrave",pressed=false,textColor=EnhancePack.ENGRAVE_COLOR },
			{ str = L"Set Artifacts Color",flags=0,returnCode="colorArti",pressed=false, textColor=EnhancePack.ARTIFACT_COLOR },
			{ str = L"Set Sets Color",flags=0,returnCode="colorSet",pressed=false,textColor=EnhancePack.SET_COLOR },
			{ str = L"Set Alert Color",flags=0,returnCode="colorAlert",pressed=false,textColor=EnhancePack.ALERT_COLOR},
			{ str = L"Set Danger Color",flags=0,returnCode="colorDanger",pressed=false,textColor=EnhancePack.DANGER_COLOR},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Set Physical Color",flags=0,returnCode="colorPhys",pressed=false,textColor=EnhancePack.PHYSICAL},
			{ str = L"Set Fire Color",flags=0,returnCode="colorFire",pressed=false,textColor=EnhancePack.FIRE},
			{ str = L"Set Cold Color",flags=0,returnCode="colorCold",pressed=false,textColor=EnhancePack.COLD},
			{ str = L"Set Poison Color",flags=0,returnCode="colorPois",pressed=false,textColor=EnhancePack.POISON},
			{ str = L"Set Energy Color",flags=0,returnCode="colorEner",pressed=false,textColor=EnhancePack.ENERGY}, 
			{ str = L"Set Chaos Color",flags=0,returnCode="colorChaos",pressed=false,textColor=EnhancePack.Chaos},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Set Healing Color",flags=0,returnCode="colorHeal",pressed=false,textColor=EnhancePack.Heal},
			{ str = L"Set Curse Color",flags=0,returnCode="colorCurse",pressed=false,textColor=EnhancePack.Curse},
			{ str = L"Set Paralyze Color",flags=0,returnCode="colorPara",pressed=false,textColor=EnhancePack.Paralyze},
			{ str = L"Set Neutral Color",flags=0,returnCode="colorNeutral",pressed=false,textColor=EnhancePack.Neutral},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Set Overhead Negative Color",flags=0,returnCode="colorNeg",pressed=false,textColor=EnhancePack.OverHeadError},
			{ str = L"Set Overhead Positive Color",flags=0,returnCode="colorPos",pressed=false,textColor=EnhancePack.SpecialColor},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.YOUGETAMAGE_COLOR },
			{ str = L"You take damage",flags=0,returnCode="colorYou",pressed=false,textColor=EnhancePack.YOUGETAMAGE_COLOR},
			{ str = L"Your pet take damage",flags=0,returnCode="colorPet",pressed=false,textColor=EnhancePack.PETGETDAMAGE_COLOR},
			{ str = L"Enemy take damage",flags=0,returnCode="colorEnemy",pressed=false,textColor=EnhancePack.OTHERGETDAMAGE_COLOR}	}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Text Colors",0,0,"null",false,subMenu)
	
	local flagP = 0
	local flagM = 0
	if (EnhancePack.OverhedTextSize <= 0.5) then
		flagM = 1
	end
	if (EnhancePack.OverhedTextSize >= 1.5) then
		flagP = 1
	end
	subMenu = {
			{ str = L"Decrease Size",flags=flagM,returnCode="txtLessSize",pressed=false },
			{ str = L"Increase Size",flags=flagP,returnCode="txtMoreSize",pressed=false}
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Text Size",0,0,"null",false,subMenu)
	


	
	
	ContextMenu.ActivateLuaContextMenu(SettingsWindow.ContextMenuCallback)
	
	
	local scaleFactor = 1/0.7
	
	local cmWidth, cmHeight = WindowGetDimensions("ContextMenu")

	WindowSetScale("ContextMenu", 0.7)
	
	
	
	
	local cmWindowX = 0
	local mouseX = SystemData.MousePosition.x
	if mouseX + (cmWidth / scaleFactor) > SystemData.screenResolution.x then
		cmWindowX = mouseX - (cmWidth / scaleFactor)
	else
		cmWindowX = mouseX
	end
		
	local mouseY = SystemData.MousePosition.y
	local cmWindowY = mouseY
	if mouseY + (cmHeight / scaleFactor) > SystemData.screenResolution.y then
		cmWindowY = mouseY - (cmHeight / scaleFactor)
	else
		cmWindowY = mouseY
	end
	
	WindowSetOffsetFromParent("ContextMenu", cmWindowX * scaleFactor, cmWindowY * scaleFactor)	
end


function SettingsWindow.PincosCustom2()
	subMenu = {
			{ str = L"Countdown Timer",flags=0,returnCode="colorHBCountdown",pressed=false, textColor=HotbarSystem.CountdownTimer },
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Direct Button",flags=0,returnCode="colorHBPlain",pressed=false, textColor=HotbarSystem.Plain },
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Control + Button",flags=0,returnCode="colorHBControl",pressed=false,textColor=HotbarSystem.Control },
			{ str = L"Alt + Button",flags=0,returnCode="colorHBAlt",pressed=false, textColor=HotbarSystem.Alt },
			{ str = L"Shift + Button",flags=0,returnCode="colorHBShift",pressed=false,textColor=HotbarSystem.Shift },
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Control + Alt + Button",flags=0,returnCode="colorHBCtrlalt",pressed=false,textColor=HotbarSystem.ControlAlt},
			{ str = L"Control + Shift + Button",flags=0,returnCode="colorHBCtrlShift",pressed=false,textColor=HotbarSystem.ControlShift},
			{ str = L"Alt + Shift + Button",flags=0,returnCode="colorHBAltShift",pressed=false,textColor=HotbarSystem.AltShift},
			{ str = L"",flags=0,returnCode="null",pressed=false,delay=0, color=EnhancePack.TITLE_COLOR },
			{ str = L"Control + Alt + Shift + Button",flags=0,returnCode="colorHBCtrlAltShift",pressed=false,textColor=HotbarSystem.ControlAltShift}	}
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Hotbar Text Colors",0,0,"null",false,subMenu)
	
	subMenu = {
			{ str = L"Target Current",flags=0,returnCode="colorHBCurrent",pressed=false, textColor=HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] },
			{ str = L"Target Self",flags=0,returnCode="colorHBSelf",pressed=false, textColor=HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF] },
			{ str = L"Target Cursor",flags=0,returnCode="colorHBCursor",pressed=false,textColor=HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
			{ str = L"Target Stored",flags=0,returnCode="colorHBStored",pressed=false, textColor=HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] }	}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Hotbar Target Colors",0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Hotbar Border Color",0,"colorHBBorder",false,nil,nil,nil, HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE])
	
	subMenu = {
			{ str = L"1",flags=0,returnCode="1",pressed=HotbarSystem.DefaultSlots == 1},
			{ str = L"2",flags=0,returnCode="2",pressed=HotbarSystem.DefaultSlots == 2},
			{ str = L"3",flags=0,returnCode="3",pressed=HotbarSystem.DefaultSlots == 3},
			{ str = L"4",flags=0,returnCode="4",pressed=HotbarSystem.DefaultSlots == 4 },
			{ str = L"5",flags=0,returnCode="5",pressed=HotbarSystem.DefaultSlots == 5 },
			{ str = L"6",flags=0,returnCode="6",pressed=HotbarSystem.DefaultSlots == 6},
			{ str = L"7",flags=0,returnCode="7",pressed=HotbarSystem.DefaultSlots == 7},
			{ str = L"8",flags=0,returnCode="8",pressed=HotbarSystem.DefaultSlots == 8},
			{ str = L"9",flags=0,returnCode="9",pressed=HotbarSystem.DefaultSlots == 9},
			{ str = L"10",flags=0,returnCode="10",pressed=HotbarSystem.DefaultSlots == 10},
			{ str = L"11",flags=0,returnCode="11",pressed=HotbarSystem.DefaultSlots == 11},
			{ str = L"12",flags=0,returnCode="12",pressed=HotbarSystem.DefaultSlots == 12}	}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Default Hotbar Slots Number",0,0,"null",false,subMenu)
	

	subMenu = {
			{ str = L"Horizontal",flags=0,returnCode="horiz",pressed=HotbarSystem.DefHorizontal},
			{ str = L"Vertical",flags=0,returnCode="vert",pressed=not HotbarSystem.DefHorizontal}
			}

	ContextMenu.CreateLuaContextMenuItemWithString(L"Default Hotbar Orientation",0,0,"null",false,subMenu)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Extra Bright Containers",0,"extraBright",2,EnhancePack.ExtraBrightContainers)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Default Container Grid color",0,"colorGrid",false,nil,nil,nil, EnhancePack.BaseGridColor)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle Alternate Grid Color",0,"altergrid",2,EnhancePack.AlternateGrid)
	
	enabled = 0
	
	if (not EnhancePack.AlternateGrid) then
		enabled = 1
	end
	ContextMenu.CreateLuaContextMenuItemWithString(L"Set Alternate Grid Color",enabled,"colorGridAlter",false,nil,nil,nil, EnhancePack.AlternateBackpack)
	

	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"null",2,false)
	
	if (EnhancePack.LockChatLine) then
		ContextMenu.CreateLuaContextMenuItemWithString(L"Unlock Chat Line",0,"unlockChat",2,false)
	else
		
		ContextMenu.CreateLuaContextMenuItemWithString(L"Lock Chat Line To Game Area",0,"lockChat",2,false)
	end
	
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"Toggle War/Peace Shield",0,"warshield",2,EnhancePack.WarShield)
	
	ContextMenu.ActivateLuaContextMenu(SettingsWindow.ContextMenuCallback)
	
	
	local scaleFactor = 1/0.7
	
	local cmWidth, cmHeight = WindowGetDimensions("ContextMenu")

	WindowSetScale("ContextMenu", 0.7)
	
	
	
	
	local cmWindowX = 0
	local mouseX = SystemData.MousePosition.x
	if mouseX + (cmWidth / scaleFactor) > SystemData.screenResolution.x then
		cmWindowX = mouseX - (cmWidth / scaleFactor)
	else
		cmWindowX = mouseX
	end
		
	local mouseY = SystemData.MousePosition.y
	local cmWindowY = mouseY
	if mouseY + (cmHeight / scaleFactor) > SystemData.screenResolution.y then
		cmWindowY = mouseY - (cmHeight / scaleFactor)
	else
		cmWindowY = mouseY
	end
	
	WindowSetOffsetFromParent("ContextMenu", cmWindowX * scaleFactor, cmWindowY * scaleFactor)
end


function SettingsWindow.PickColor()
	local color = string.gsub(SystemData.ActiveWindow.name, "SettingsPinco", "")
	color = string.gsub(color, "Button", "")
	EnhancePack.HuePickerWindowRequest = color
	local defaultColors = {
		0, --HUE_NONE 
		34, --HUE_RED
		53, --HUE_YELLOW
		63, --HUE_GREEN
		89, --HUE_BLUE
		119, --HUE_PURPLE
		144, --HUE_ORANGE
		368, --HUE_GREEN_2
		946, --HUE_GREY
		}
		local hueTable = {}
		for idx, hue in pairs(defaultColors) do
			for i=0,8 do
				hueTable[(idx-1)*10+i+1] = hue+i
			end
		end
		local Brightness = 1
		CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )
		WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)
		ColorPickerWindow.SetNumColorsPerRow(9)
		ColorPickerWindow.SetSwatchSize(30)
		ColorPickerWindow.SetWindowPadding(4,4)
		ColorPickerWindow.SetFrameEnabled(true)
		ColorPickerWindow.SetCloseButtonEnabled(true)
		ColorPickerWindow.SetColorTable(hueTable,"ColorPicker")
		ColorPickerWindow.DrawColorTable("ColorPicker")
		ColorPickerWindow.SetAfterColorSelectionFunction(SettingsWindow.ColorPicked)
		local w, h = WindowGetDimensions("ColorPicker")
		WindowAddAnchor( "ColorPicker", "topleft", "SettingsPinco" .. EnhancePack.HuePickerWindowRequest .. "Button", "topleft", 50, -h)
		ColorPickerWindow.SetFrameEnabled(false)
		WindowSetShowing( "ColorPicker", true )
		ColorPickerWindow.SelectColor("ColorPicker", 1)
end


function SettingsWindow.ColorPicked()
		local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]
		if (EnhancePack.HuePickerWindowRequest== "colorDefault") then
			EnhancePack.TITLE_COLOR.r,EnhancePack.TITLE_COLOR.g,EnhancePack.TITLE_COLOR.b,EnhancePack.TITLE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackTITLE_COLOR", EnhancePack.TITLE_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorMods") then
			EnhancePack.BODY_COLOR.r,EnhancePack.BODY_COLOR.g,EnhancePack.BODY_COLOR.b,EnhancePack.BODY_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackBODY_COLOR", EnhancePack.BODY_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorEngrave") then
			EnhancePack.ENGRAVE_COLOR.r,EnhancePack.ENGRAVE_COLOR.g,EnhancePack.ENGRAVE_COLOR.b,EnhancePack.ENGRAVE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackENGRAVE_COLOR", EnhancePack.ENGRAVE_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorPlain") then
			EnhancePack.PLAIN_COLOR.r,EnhancePack.PLAIN_COLOR.g,EnhancePack.PLAIN_COLOR.b,EnhancePack.PLAIN_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPLAIN_COLOR", EnhancePack.PLAIN_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorArti") then
			EnhancePack.ARTIFACT_COLOR.r,EnhancePack.ARTIFACT_COLOR.g,EnhancePack.ARTIFACT_COLOR.b,EnhancePack.ARTIFACT_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackARTIFACT_COLOR", EnhancePack.ARTIFACT_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorSet") then
			EnhancePack.SET_COLOR.r,EnhancePack.SET_COLOR.g,EnhancePack.SET_COLOR.b,EnhancePack.SET_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackSET_COLOR", EnhancePack.SET_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorResidue") then
			EnhancePack.RESIDUE_COLOR.r,EnhancePack.RESIDUE_COLOR.g,EnhancePack.RESIDUE_COLOR.b,EnhancePack.RESIDUE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackRESIDUE_COLOR", EnhancePack.RESIDUE_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorEssence") then
			EnhancePack.ESSENCE_COLOR.r,EnhancePack.ESSENCE_COLOR.g,EnhancePack.ESSENCE_COLOR.b,EnhancePack.ESSENCE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackESSENCE_COLOR", EnhancePack.ESSENCE_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorRelic") then
			EnhancePack.RELIC_COLOR.r,EnhancePack.RELIC_COLOR.g,EnhancePack.RELIC_COLOR.b,EnhancePack.RELIC_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackRELIC_COLOR", EnhancePack.RELIC_COLOR)
			
		elseif (EnhancePack.HuePickerWindowRequest== "colorAlert") then
			EnhancePack.ALERT_COLOR.r,EnhancePack.ALERT_COLOR.g,EnhancePack.ALERT_COLOR.b,EnhancePack.ALERT_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackALERT_COLOR", EnhancePack.ALERT_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorDanger") then
			EnhancePack.DANGER_COLOR.r,EnhancePack.DANGER_COLOR.g,EnhancePack.DANGER_COLOR.b,EnhancePack.DANGER_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackDANGER_COLOR", EnhancePack.DANGER_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorPhys") then
			EnhancePack.PHYSICAL.r,EnhancePack.PHYSICAL.g,EnhancePack.PHYSICAL.b,EnhancePack.PHYSICAL.a  = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPHYSICAL", EnhancePack.PHYSICAL)
		elseif (EnhancePack.HuePickerWindowRequest== "colorFire") then
			EnhancePack.FIRE.r,EnhancePack.FIRE.g,EnhancePack.FIRE.b,EnhancePack.FIRE.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackFIRE", EnhancePack.FIRE)
		elseif (EnhancePack.HuePickerWindowRequest== "colorCold") then
			EnhancePack.COLD.r,EnhancePack.COLD.g,EnhancePack.COLD.b,EnhancePack.COLD.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackCOLD", EnhancePack.COLD)
		elseif (EnhancePack.HuePickerWindowRequest== "colorPois") then
			EnhancePack.POISON.r,EnhancePack.POISON.g,EnhancePack.POISON.b,EnhancePack.POISON.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPOISON", EnhancePack.POISON)
		elseif (EnhancePack.HuePickerWindowRequest== "colorEner") then
			EnhancePack.ENERGY.r,EnhancePack.ENERGY.g,EnhancePack.ENERGY.b,EnhancePack.ENERGY.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackENERGY", EnhancePack.ENERGY)
		elseif (EnhancePack.HuePickerWindowRequest== "colorChaos") then
			EnhancePack.Chaos.r,EnhancePack.Chaos.g,EnhancePack.Chaos.b,EnhancePack.Chaos.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackChaos", EnhancePack.Chaos)
		elseif (EnhancePack.HuePickerWindowRequest== "colorLostItem") then
			EnhancePack.LOSTITEM_COLOR.r,EnhancePack.LOSTITEM_COLOR.g,EnhancePack.LOSTITEM_COLOR.b,EnhancePack.LOSTITEM_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackLOSTITEM_COLOR", EnhancePack.LOSTITEM_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorHeal") then
			EnhancePack.Heal.r,EnhancePack.Heal.g,EnhancePack.Heal.b,EnhancePack.Heal.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackHeal", EnhancePack.Heal)
		elseif (EnhancePack.HuePickerWindowRequest== "colorCurse") then
			EnhancePack.Curse.r,EnhancePack.Curse.g,EnhancePack.Curse.b,EnhancePack.Curse.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackCurse", EnhancePack.Curse)
		elseif (EnhancePack.HuePickerWindowRequest== "colorPara") then
			EnhancePack.Paralyze.r,EnhancePack.Paralyze.g,EnhancePack.Paralyze.b,EnhancePack.Paralyze.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackParalyze", EnhancePack.Paralyze)
		elseif (EnhancePack.HuePickerWindowRequest== "colorNeutral") then
			EnhancePack.Neutral.r,EnhancePack.Neutral.g,EnhancePack.Neutral.b,EnhancePack.Neutral.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackNeutral", EnhancePack.Neutral)
		elseif (EnhancePack.HuePickerWindowRequest== "colorNeg") then
			EnhancePack.OverHeadError.r,EnhancePack.OverHeadError.g,EnhancePack.OverHeadError.b,EnhancePack.OverHeadError.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackOverHeadError", EnhancePack.OverHeadError)
		elseif (EnhancePack.HuePickerWindowRequest== "colorPos") then
			EnhancePack.SpecialColor.r,EnhancePack.SpecialColor.g,EnhancePack.SpecialColor.b,EnhancePack.SpecialColor.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackSpecialColor", EnhancePack.SpecialColor)
		elseif (EnhancePack.HuePickerWindowRequest== "colorMagic") then
			EnhancePack.MAGICPROP_COLOR.r,EnhancePack.MAGICPROP_COLOR.g,EnhancePack.MAGICPROP_COLOR.b,EnhancePack.MAGICPROP_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackMAGICPROP_COLOR", EnhancePack.MAGICPROP_COLOR)
			
			
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBCountdown") then
			HotbarSystem.CountdownTimer.r,HotbarSystem.CountdownTimer.g,HotbarSystem.CountdownTimer.b,HotbarSystem.CountdownTimer.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemCountdownTimer", HotbarSystem.CountdownTimer)
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBPlain") then
			HotbarSystem.Plain.r,HotbarSystem.Plain.g,HotbarSystem.Plain.b,HotbarSystem.Plain.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemPlain", HotbarSystem.Plain)
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBControl") then
			HotbarSystem.Control.r,HotbarSystem.Control.g,HotbarSystem.Control.b,HotbarSystem.Control.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControl", HotbarSystem.Control)
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBAlt") then
			HotbarSystem.Alt.r,HotbarSystem.Alt.g,HotbarSystem.Alt.b,HotbarSystem.Alt.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemAlt", HotbarSystem.Alt)
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBShift") then
			HotbarSystem.Shift.r,HotbarSystem.Shift.g,HotbarSystem.Shift.b,HotbarSystem.Shift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemShift", HotbarSystem.Shift)
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBCtrlalt") then
			HotbarSystem.ControlAlt.r,HotbarSystem.ControlAlt.g,HotbarSystem.ControlAlt.b,HotbarSystem.ControlAlt.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlAlt", HotbarSystem.ControlAlt)
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBAltShift") then
			HotbarSystem.AltShift.r,HotbarSystem.AltShift.g,HotbarSystem.AltShift.b,HotbarSystem.AltShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemAltShift", HotbarSystem.AltShift)
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBCtrlAltShift") then
			HotbarSystem.ControlAltShift.r,HotbarSystem.ControlAltShift.g,HotbarSystem.ControlAltShift.b,HotbarSystem.ControlAltShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlAltShift", HotbarSystem.ControlAltShift)
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBCtrlShift") then
			HotbarSystem.ControlShift.r,HotbarSystem.ControlShift.g,HotbarSystem.ControlShift.b,HotbarSystem.ControlShift.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("HotbarSystemControlShift", HotbarSystem.ControlShift)
			EnhancePack.UpdateHotbars()
			
		
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBCurrent") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_CURRENT", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT])
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBSelf") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_SELF", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_SELF])
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBCursor") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_CURSOR", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR])
			EnhancePack.UpdateHotbars()
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBStored") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_OBJECT_ID", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID])
			EnhancePack.UpdateHotbars()
			
		elseif (EnhancePack.HuePickerWindowRequest== "colorHBBorder") then
			HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].r,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].g,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].b,HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE].a = HueRGBAValue(huePicked)

			CustomSettings.SaveColor("HotbarTARGETTYPE_NONE", HotbarSystem.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE])
			EnhancePack.UpdateHotbars()
		
		elseif (EnhancePack.HuePickerWindowRequest== "colorYou") then
			EnhancePack.YOUGETAMAGE_COLOR.r,EnhancePack.YOUGETAMAGE_COLOR.g,EnhancePack.YOUGETAMAGE_COLOR.b,EnhancePack.YOUGETAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackYOUGETAMAGE_COLOR", EnhancePack.YOUGETAMAGE_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorPet") then
			EnhancePack.PETGETDAMAGE_COLOR.r,EnhancePack.PETGETDAMAGE_COLOR.g,EnhancePack.PETGETDAMAGE_COLOR.b,EnhancePack.PETGETDAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackPETGETDAMAGE_COLOR", EnhancePack.PETGETDAMAGE_COLOR)
		elseif (EnhancePack.HuePickerWindowRequest== "colorEnemy") then
			EnhancePack.OTHERGETDAMAGE_COLOR.r,EnhancePack.OTHERGETDAMAGE_COLOR.g,EnhancePack.OTHERGETDAMAGE_COLOR.b,EnhancePack.OTHERGETDAMAGE_COLOR.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackOTHERGETDAMAGE_COLOR", EnhancePack.OTHERGETDAMAGE_COLOR)
			
		elseif (EnhancePack.HuePickerWindowRequest== "colorGrid") then
			EnhancePack.BaseGridColor.r,EnhancePack.BaseGridColor.g,EnhancePack.BaseGridColor.b,EnhancePack.BaseGridColor.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackBaseGridColor", EnhancePack.BaseGridColor)
			for id, value in pairs(ContainerWindow.OpenContainers) do
				DestroyWindow("ContainerWindow_"..id)
			end
			
		elseif (EnhancePack.HuePickerWindowRequest== "colorGridAlter") then
			EnhancePack.AlternateBackpack.r,EnhancePack.AlternateBackpack.g,EnhancePack.AlternateBackpack.b,EnhancePack.AlternateBackpack.a = HueRGBAValue(huePicked)
			CustomSettings.SaveColor("EnhancePackAlternateBackpack", EnhancePack.AlternateBackpack)
			for id, value in pairs(ContainerWindow.OpenContainers) do
				DestroyWindow("ContainerWindow_"..id)
			end
		end
		local r,g,b,a = HueRGBAValue(huePicked)
		WindowSetTintColor("SettingsPinco" .. EnhancePack.HuePickerWindowRequest .. "Button", r,g,b)
		
		EnhancePack.HuePickerWindowRequest= ""
		DestroyWindow("ColorPicker")
		
end

function SettingsWindow.ContextMenuCallback( returnCode, param )	
	EnhancePack.HuePickerWindowRequest= returnCode
	local text = string.find(EnhancePack.HuePickerWindowRequest, "color")
	if (text and not( returnCode == "colorRed" or returnCode=="colorGreen" or returnCode=="colorBlue" or returnCode=="colorYellow" or returnCode=="colorAqua" or returnCode=="colorPink" or returnCode=="colorWhite")) then
		local defaultColors = {
		0, --HUE_NONE 
		34, --HUE_RED
		53, --HUE_YELLOW
		63, --HUE_GREEN
		89, --HUE_BLUE
		119, --HUE_PURPLE
		144, --HUE_ORANGE
		368, --HUE_GREEN_2
		946, --HUE_GREY
		}
		local hueTable = {}
		for idx, hue in pairs(defaultColors) do
			for i=0,8 do
				hueTable[(idx-1)*10+i+1] = hue+i
			end
		end
		local Brightness = 1
		CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )
		WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)
		ColorPickerWindow.SetNumColorsPerRow(9)
		ColorPickerWindow.SetSwatchSize(30)
		ColorPickerWindow.SetWindowPadding(4,4)
		ColorPickerWindow.SetFrameEnabled(true)
		ColorPickerWindow.SetCloseButtonEnabled(true)
		ColorPickerWindow.SetColorTable(hueTable,"ColorPicker")
		ColorPickerWindow.DrawColorTable("ColorPicker")
		ColorPickerWindow.SetAfterColorSelectionFunction(SettingsWindow.ColorPicked)
		local w, h = WindowGetDimensions("ColorPicker")
		WindowAddAnchor( "ColorPicker", "topleft", "MenuBarWindow", "topleft", 50, -h)
		ColorPickerWindow.SetFrameEnabled(false)
		WindowSetShowing( "ColorPicker", true )
		ColorPickerWindow.SelectColor("ColorPicker", 1)
	end

	if ( returnCode=="enableBlood" ) then
		EnhancePack.ToggleBloodOath = true
		CustomSettings.SaveBoolean( "EnhancePackToggleBloodOath", EnhancePack.ToggleBloodOath )
	elseif(returnCode=="disableBlood") then
		EnhancePack.ToggleBloodOath = false
		CustomSettings.SaveBoolean( "EnhancePackToggleBloodOath", EnhancePack.ToggleBloodOath )
		
	elseif(returnCode=="lockChat") then
		EnhancePack.LockChatLine = true
		CustomSettings.SaveBoolean( "EnhancePackLockChatLine" , EnhancePack.LockChatLine )
		InterfaceCore.ReloadUI()
	elseif(returnCode=="unlockChat") then
		EnhancePack.LockChatLine = false
		CustomSettings.SaveBoolean( "EnhancePackLockChatLine" , EnhancePack.LockChatLine )
		InterfaceCore.ReloadUI()
	elseif(returnCode=="horiz") then
		HotbarSystem.DefHorizontal = true
		CustomSettings.SaveBoolean( "HotbarSystemDefHorizontal" , HotbarSystem.DefHorizontal )
	elseif(returnCode=="vert") then
		HotbarSystem.DefHorizontal = false
		CustomSettings.SaveBoolean( "HotbarSystemDefHorizontal" , HotbarSystem.DefHorizontal )
	elseif(type(tonumber(returnCode)) == "number") then
		HotbarSystem.DefaultSlots = tonumber(returnCode)
		CustomSettings.SaveNumber( "HotbarSystemDefaultSlots" , HotbarSystem.DefaultSlots )
	elseif (returnCode=="warshield") then
		EnhancePack.WarShield = not EnhancePack.WarShield
		CustomSettings.SaveBoolean( "EnhancePackWarShield",EnhancePack.WarShield )
		WindowSetShowing("WarButton",EnhancePack.WarShield)
	elseif (returnCode=="altergrid") then
		EnhancePack.AlternateGrid = not EnhancePack.AlternateGrid
		CustomSettings.SaveBoolean( "EnhancePackAlternateGrid",EnhancePack.AlternateGrid )
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
	elseif (returnCode=="extraBright") then
		EnhancePack.ExtraBrightContainers = not EnhancePack.ExtraBrightContainers
		CustomSettings.SaveBoolean( "EnhancePackExtraBrightContainers",EnhancePack.ExtraBrightContainers )
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
		
	elseif(returnCode=="disableSnap") then
		EnhancePack.EnableSnapping = false
		CustomSettings.SaveBoolean( "EnhancePackEnableSnapping", EnhancePack.EnableSnapping )
	elseif(returnCode=="enableSnap") then
		EnhancePack.EnableSnapping = true
		CustomSettings.SaveBoolean( "EnhancePackEnableSnapping", EnhancePack.EnableSnapping )
		
	elseif(returnCode=="disableGold") then
		EnhancePack.GoldLootBag = false
		CustomSettings.SaveBoolean( "EnhancePackGoldLootBag", EnhancePack.GoldLootBag )
	elseif(returnCode=="enableGold") then
		EnhancePack.GoldLootBag = true
		CustomSettings.SaveBoolean( "EnhancePackGoldLootBag", EnhancePack.GoldLootBag )
		
	elseif(returnCode=="disableAutoIgnore") then
		EnhancePack.EnableAutoIgnoreCorpses = false
		CustomSettings.SaveBoolean( "EnhancePackEnableAutoIgnoreCorpses", EnhancePack.EnableAutoIgnoreCorpses )
	elseif(returnCode=="enableAutoIgnore") then
		EnhancePack.EnableAutoIgnoreCorpses = true
		CustomSettings.SaveBoolean( "EnhancePackEnableAutoIgnoreCorpses", EnhancePack.EnableAutoIgnoreCorpses )
	
	elseif(returnCode=="disablepaper") then
		EnhancePack.BlockOthersPaperdoll = false
		CustomSettings.SaveBoolean( "EnhancePackBlockOthersPaperdoll", EnhancePack.BlockOthersPaperdoll )
	elseif(returnCode=="enablepaper") then
		EnhancePack.BlockOthersPaperdoll = true
		CustomSettings.SaveBoolean( "EnhancePackBlockOthersPaperdoll", EnhancePack.BlockOthersPaperdoll )
	
	elseif(returnCode=="disableOldHealth") then
		MobileHealthBar.CloseStyle = false
		CustomSettings.SaveBoolean( "MobileHealthBarCloseStyle", MobileHealthBar.CloseStyle )
	elseif(returnCode=="enableOldHealth") then
		MobileHealthBar.CloseStyle = true
		CustomSettings.SaveBoolean( "MobileHealthBarCloseStyle", MobileHealthBar.CloseStyle )
		
	elseif(returnCode=="disablePetOldHealth") then
		MobileHealthBar.PetCloseStyle = false
		CustomSettings.SaveBoolean( "MobileHealthBarPetCloseStyle", MobileHealthBar.PetCloseStyle )
	elseif(returnCode=="enablePetOldHealth") then
		MobileHealthBar.PetCloseStyle = true
		CustomSettings.SaveBoolean( "MobileHealthBarPetCloseStyle", MobileHealthBar.PetCloseStyle )
	
	elseif(returnCode=="disableWOD") then
		EnhancePack.HealthBarWod = false
		CustomSettings.SaveBoolean( "EnhancePackHealthBarWod", EnhancePack.HealthBarWod )
		for key, value in pairs(MobileHealthBar.hasWindow) do
			MobileHealthBar.UpdateStatus(key)
		end
	elseif(returnCode=="enableWOD") then
		EnhancePack.HealthBarWod = true
		CustomSettings.SaveBoolean( "EnhancePackHealthBarWod", EnhancePack.HealthBarWod )
		for key, value in pairs(MobileHealthBar.hasWindow) do
			MobileHealthBar.UpdateStatus(key)
		end
		
		
	elseif(returnCode=="clearIgnore") then
		EnhancePack.IgnoreItems = {}		
	
	elseif(returnCode=="colorRed") then
		EnhancePack.EXTRAINFO ={r=255, g=0, b=0}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorGreen") then
		EnhancePack.EXTRAINFO ={r=0, g=255, b=0} 
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorBlue") then
		EnhancePack.EXTRAINFO ={r=0, g=0, b=255} 
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorYellow") then
		EnhancePack.EXTRAINFO ={r=255, g=255, b=0}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorAqua") then
		EnhancePack.EXTRAINFO ={r=0, g=255, b=255} 
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorPink") then
		EnhancePack.EXTRAINFO ={r=255, g=0, b=255}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
	elseif(returnCode=="colorWhite") then
		EnhancePack.EXTRAINFO ={r=255, g=255, b=255}
		CustomSettings.SaveColor("EnhancePackEXTRAINFO", EnhancePack.EXTRAINFO)
		
	elseif ( returnCode=="HP20" ) then
		EnhancePack.LowHPPerc = 20
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HP30" ) then
		EnhancePack.LowHPPerc = 30
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HP40" ) then
		EnhancePack.LowHPPerc = 40
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HP50" ) then
		EnhancePack.LowHPPerc = 50
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HP60" ) then
		EnhancePack.LowHPPerc = 60
		CustomSettings.SaveNumber( "EnhancePackLowHPPerc", EnhancePack.LowHPPerc  )
	elseif ( returnCode=="HPdisable" ) then
		EnhancePack.LowHPPercDisabled = not EnhancePack.LowHPPercDisabled
		CustomSettings.SaveBoolean( "EnhancePackLowHPPercDisabled",EnhancePack.LowHPPercDisabled )
		WindowSetShowing("MainCenterScreenTexture",false)
		
	elseif ( returnCode=="PHP20" ) then
		EnhancePack.LowPETHPPerc = 20
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="PHP30" ) then
		EnhancePack.LowPETHPPerc = 30
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="PHP40" ) then
		EnhancePack.LowPETHPPerc = 40
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="PHP50" ) then
		EnhancePack.LowPETHPPerc = 50
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="PHP60" ) then
		EnhancePack.LowPETHPPerc = 60
		CustomSettings.SaveNumber( "EnhancePackLowPETHPPerc", EnhancePack.LowPETHPPerc  )
	elseif ( returnCode=="IgnoreSummons" ) then
		EnhancePack.EnableIgnoreSummons = not EnhancePack.EnableIgnoreSummons
		CustomSettings.SaveBoolean( "EnhancePackEnableIgnoreSummons", EnhancePack.EnableIgnoreSummons  )
	elseif ( returnCode=="HPPETdisable" ) then
		EnhancePack.LowHPPETPercDisabled = not EnhancePack.LowHPPETPercDisabled
		CustomSettings.SaveBoolean( "EnhancePackLowHPPETPercDisabled",EnhancePack.LowHPPETPercDisabled )	
		WindowSetShowing("MainCenterScreenTexture",false)
		
	elseif ( returnCode=="disableSad" ) then
		EnhancePack.SadMode =  false
		CustomSettings.SaveBoolean( "EnhancePackSadMode", EnhancePack.SadMode  )
	elseif ( returnCode=="enableSad" ) then
		EnhancePack.ShowSpellName = false
		CustomSettings.SaveBoolean( "EnhancePackShowSpellName", EnhancePack.ShowSpellName )
		EnhancePack.SadMode = true
		CustomSettings.SaveBoolean( "EnhancePackSadMode", EnhancePack.SadMode  )
		
	elseif(returnCode=="center1") then
		EnhancePack.CenterScreenPosition = 1
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
	elseif(returnCode=="center2") then
		EnhancePack.CenterScreenPosition = 2
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
	elseif(returnCode=="center3") then
		EnhancePack.CenterScreenPosition = 3
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
	elseif(returnCode=="center4") then
		EnhancePack.CenterScreenPosition = 4
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
	elseif(returnCode=="center5") then
		EnhancePack.CenterScreenPosition = 5
		CustomSettings.SaveNumber( "EnhancePackCenterScreenPosition" , EnhancePack.CenterScreenPosition )
		EnhancePack.SendCenterScreenTexture("panic")
		
		
	elseif(returnCode=="auraStatic") then
		EnhancePack.AuraSpeed = 0
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
	elseif(returnCode=="auraNormal") then
		EnhancePack.AuraSpeed = 10
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
	elseif(returnCode=="auraFast") then
		EnhancePack.AuraSpeed = 20
		CustomSettings.SaveNumber( "EnhancePackAuraSpeed" , EnhancePack.AuraSpeed )
		
	elseif(returnCode=="objNormal") then
		EnhancePack.ObjectHandleScale = InterfaceCore.scale
		CustomSettings.SaveNumber( "EnhancePackObjectHandleScale" , EnhancePack.ObjectHandleScale )
	elseif(returnCode=="objMedium") then
		EnhancePack.ObjectHandleScale = InterfaceCore.scale * 0.8
		CustomSettings.SaveNumber( "EnhancePackObjectHandleScale" , EnhancePack.ObjectHandleScale )
	elseif(returnCode=="objSmall") then
		EnhancePack.ObjectHandleScale = (InterfaceCore.scale * 2 )/3
		CustomSettings.SaveNumber( "EnhancePackObjectHandleScale" , EnhancePack.ObjectHandleScale )	
		
		
	elseif(returnCode=="objDull") then
		EnhancePack.ObjectHandleAlpha = 1
		CustomSettings.SaveNumber( "EnhancePackObjectHandleAlpha" , EnhancePack.ObjectHandleAlpha )
	elseif(returnCode=="objHalfTransp") then
		EnhancePack.ObjectHandleAlpha = 0.6
		CustomSettings.SaveNumber( "EnhancePackObjectHandleAlpha" , EnhancePack.ObjectHandleAlpha )
	elseif(returnCode=="objTransp") then
		EnhancePack.ObjectHandleAlpha = 0.4
		CustomSettings.SaveNumber( "EnhancePackObjectHandleAlpha" , EnhancePack.ObjectHandleAlpha )
			
	elseif(returnCode=="setFont") then
		
		if (not DoesWindowNameExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.Selection = "chat"
		
		WindowSetShowing(FontSelector.RunicFontItem, false)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Chat Font")
		
		
	elseif(returnCode=="setNameFont") then
		if (not DoesWindowNameExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.Selection = "names"
		WindowSetShowing(FontSelector.RunicFontItem, false)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Names Font")
		
	elseif(returnCode=="txtMoreSize") then
		
		EnhancePack.OverhedTextSize =EnhancePack.OverhedTextSize + 0.1
		
		if (EnhancePack.OverhedTextSize > 1.5) then
			EnhancePack.OverhedTextSize = 1.5
		end
		CustomSettings.SaveNumber("EnhancePackOverhedTextSize", EnhancePack.OverhedTextSize)
		EnhancePack.SendOverheadText(L"TEST Message", 23 , false)
	
	elseif(returnCode=="txtLessSize") then	
		EnhancePack.OverhedTextSize =EnhancePack.OverhedTextSize - 0.1
		if (EnhancePack.OverhedTextSize < 0.5) then
			EnhancePack.OverhedTextSize = 0.5
		end
		CustomSettings.SaveNumber("EnhancePackOverhedTextSize", EnhancePack.OverhedTextSize)
		EnhancePack.SendOverheadText(L"TEST Message", 23 , false)
		
	elseif(returnCode=="setDamageFont") then
		if (not DoesWindowNameExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.Selection = "damage"
		WindowSetShowing(FontSelector.RunicFontItem, false)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Damage Font")
			
	elseif(returnCode=="setSpellFont") then
		if (not DoesWindowNameExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.Selection = "spells"
		WindowSetShowing(FontSelector.RunicFontItem, not EnhancePack.ShowSpellName)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Spells Font")

	elseif(returnCode=="disableScale") then
		EnhancePack.ToggleScale = false
		CustomSettings.SaveBoolean( "EnhancePackToggleScale", EnhancePack.ToggleScale )
	elseif(returnCode=="enableScale") then
		EnhancePack.ToggleScale = true
		CustomSettings.SaveBoolean( "EnhancePackToggleScale", EnhancePack.ToggleScale )
		
	
	
		
	elseif(returnCode=="disableSpellname") then
		EnhancePack.ShowSpellName = false
		CustomSettings.SaveBoolean( "EnhancePackShowSpellName", EnhancePack.ShowSpellName )
	elseif(returnCode=="enableSpellname") then
		EnhancePack.ShowSpellName = true
		CustomSettings.SaveBoolean( "EnhancePackShowSpellName", EnhancePack.ShowSpellName )
		if (FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName == "runic") then
			OverheadText.SpellsFontIndex = 1
		end
		
	elseif(returnCode=="disableSpell") then
		EnhancePack.DisableSpells = true
		CustomSettings.SaveBoolean( "EnhancePackDisableSpells", EnhancePack.DisableSpells )
	elseif(returnCode=="enableSpell") then
		EnhancePack.DisableSpells = false
		CustomSettings.SaveBoolean( "EnhancePackDisableSpells", EnhancePack.DisableSpells )
		
		
	elseif(returnCode=="disableExtra") then
		EnhancePack.ToggleExtraInfo = false
		CustomSettings.SaveBoolean( "EnhancePackToggleExtraInfo", EnhancePack.ToggleExtraInfo )
	elseif(returnCode=="enableExtra") then
		EnhancePack.ToggleExtraInfo = true
		CustomSettings.SaveBoolean( "EnhancePackToggleExtraInfo", EnhancePack.ToggleExtraInfo )
		
	elseif(returnCode=="disableIntens") then
		EnhancePack.IntensityInfo = false
		CustomSettings.SaveBoolean( "EnhancePackIntensityInfo", EnhancePack.IntensityInfo )
	elseif(returnCode=="enableIntens") then
		EnhancePack.IntensityInfo = true
		CustomSettings.SaveBoolean( "EnhancePackIntensityInfo", EnhancePack.IntensityInfo )
		
	elseif(returnCode=="disableNoto") then
		StatusWindow.AuraEnabled = false
		 HealthBarManager.HandlePartyMemberUpdate()
		CustomSettings.SaveBoolean( "StatusWindowAuraEnabled", StatusWindow.AuraEnabled )
	elseif(returnCode=="enableNoto") then
		StatusWindow.AuraEnabled = true
		 HealthBarManager.HandlePartyMemberUpdate()
		CustomSettings.SaveBoolean( "StatusWindowAuraEnabled", StatusWindow.AuraEnabled )	
		
	elseif(returnCode=="disableDiablo") then
		EnhancePack.DiabloHealthEnable = false
		CustomSettings.SaveBoolean( "DiabloHealthEnable", EnhancePack.DiabloHealthEnable )
		DiabloHealth.CheckToggle()
	elseif(returnCode=="enableDiablo") then
		EnhancePack.DiabloHealthEnable = true
		CustomSettings.SaveBoolean( "DiabloHealthEnable", EnhancePack.DiabloHealthEnable )
		DiabloHealth.CheckToggle()
		
	elseif(returnCode=="disableDiabloNum") then
		EnhancePack.DiabloHealthNumbersEnable = false
		CustomSettings.SaveBoolean( "DiabloHealthNumbersEnable", EnhancePack.DiabloHealthNumbersEnable )
		DiabloHealth.CheckToggle()
	elseif(returnCode=="enableDiabloNum") then
		EnhancePack.DiabloHealthNumbersEnable = true
		CustomSettings.SaveBoolean( "DiabloHealthNumbersEnable", EnhancePack.DiabloHealthNumbersEnable )
		DiabloHealth.CheckToggle()
		
	elseif(returnCode=="disableYouSee") then
		EnhancePack.ToggleYouSee = false
		CustomSettings.SaveBoolean( "EnhancePackToggleYouSee", EnhancePack.ToggleYouSee )
	elseif(returnCode=="enableYouSee") then
		EnhancePack.ToggleYouSee = true
		CustomSettings.SaveBoolean( "EnhancePackToggleYouSee", EnhancePack.ToggleYouSee)
		
	elseif(returnCode=="disableSound") then
		SystemData.Settings.Sound.master.enabled = false
		UserSettingsChanged()
	elseif(returnCode=="enableSound") then
		SystemData.Settings.Sound.master.enabled = true
		UserSettingsChanged()
		
	elseif(returnCode=="disableLegacy") then
		SystemData.Settings.Interface.LegacyContainers = false
		UserSettingsChanged()
		--DestroyWindow("ContainerWindow_"..EnhancePack.PlayerBackpack)
	elseif(returnCode=="enableLegacy") then
		SystemData.Settings.Interface.LegacyContainers = true
		UserSettingsChanged()
		--DestroyWindow("ContainerWindow_"..EnhancePack.PlayerBackpack)
		
	elseif(returnCode=="disableGridLegacy") then
		EnhancePack.GridLegacy = false
		CustomSettings.SaveBoolean( "EnhancePackGridLegacy", EnhancePack.GridLegacy)
		ChatWindow.Print(L"Grid Legacy containers DISABLED", SystemData.ChatLogFilters.SYSTEM )
	elseif(returnCode=="enableGridLegacy") then
		EnhancePack.GridLegacy = true
		CustomSettings.SaveBoolean( "EnhancePackGridLegacy", EnhancePack.GridLegacy )
		ChatWindow.Print(L"Grid Legacy containers ENABLED", SystemData.ChatLogFilters.SYSTEM )
	elseif(returnCode=="disableGrid") then
		EnhancePack.EnableContainerGrid = false
		CustomSettings.SaveBoolean( "EnhancePackEnableContainerGrid", EnhancePack.EnableContainerGrid)
		ChatWindow.Print(L"Grid on containers DISABLED", SystemData.ChatLogFilters.SYSTEM )
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
	elseif(returnCode=="enableGrid") then
		EnhancePack.EnableContainerGrid = true
		CustomSettings.SaveBoolean( "EnhancePackEnableContainerGrid", EnhancePack.EnableContainerGrid )
		ChatWindow.Print(L"Grid on containers ENABLED", SystemData.ChatLogFilters.SYSTEM )
		for id, value in pairs(ContainerWindow.OpenContainers) do
			DestroyWindow("ContainerWindow_"..id)
		end
		
	elseif(returnCode=="Reset") then
		SettingsWindow.OnResetButton()
	elseif(returnCode=="showMain") then
		data = MenuBarWindow.MenuBarData["MenuBarWindowToggleMainMenu"]
	
		-- Setting ToggleWindow to nil indicates that we have to use a custom handler
		if (data.ToggleWindow) then
    		ToggleWindowByName(data.ToggleWindow, SystemData.ActiveWindow.name, MenuBarWindow.ToggleMenuButton)	
		else
			--Debug.Print( L"ERROR MenuBarWindow.ToggleMenuButton - no data found for window = "..StringToWString(SystemData.ActiveWindow.name) )
		end
	end
end

function SettingsWindow.SwitchTP()
	local it = ComboBoxGetSelectedMenuItem( "SettingsPincoTexturePack" )
	DynamicImageSetTexture("SettingsPincoTPImage", MiniTexturePack.DB[it].texture .. "Icon", 0,0)
end